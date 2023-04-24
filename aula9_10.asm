;-----------------------------
; Stock Autenticação
;-----------------------------
StockAutenticacao:
    MOV R0, StockAutent;
    MOV R1, 0; guarda em R1 o nº de caracteres preenchidos
ProxCaracterPass:
    CALL MostraDisplay;
    CALL LimpaPerifericos;
LePass:
    CALL AddCaractMenu;
    MOV R3, PE;
    MOVB R2, [R3]; R2 = periférico de entrada
    CMP R2, 0; 
    JEQ LePass; verifica se foi introduzido algo
    CMP R2, 1; 
    JEQ VerifPass; verifica se o utilizador quer confirmar a palavra passe
    CMP R2, 4; 
    JEQ CheckPointMenuInicial; verifica se o utilizador quer voltar para a pagina inicial
    CMP R1, 5; 
    JGE ProxCaracterPass; verificar se o utilizador já inseriu 5 caracteres
    MOV R3, UserPassword; R3 = a posição da password inserida pelo utilizador
    ADD R3, R1; R3 = posição a guardar o caracter inserido através do nº inserido de carateres
    MOVB [R3], R2; guarda o valor o caracter inserido pelo utilizador na memória
    ADD R1, 1; incrementa em 1 o nº de caracteres inseridos
    JMP ProxCaracterPass;

;---------------------------------
; Confirmar Password Inserida
;--------------------------------
;R1 nº de carateres inseridos pelo utilizador
VerifPass:
    CMP R1, 5; 
    JLT FaltaCaracteres; verificar se o utilizador já inseriu 5 caracteres
    MOV R0, 0; R0 = i
CompPass:
    MOV R1, UserPassword; R1 = posição da password inserida pelo utilizador
    MOV R2, Password; R2 = posição da password correta
    ADD R1, R0; R1 = R1 + i
    ADD R2, R0; R2 = R2 + i
    MOVB R3, [R1]; R3 = caracter na posicao i da password inserida pelo utilizador
    MOVB R4, [R2]; R4 = caracter na posicao i da password 
    CMP R3, R4; comparação do caracter na posição i da password com o da password inserida pelo utilizador
    JNE PasswordErrada;
    ADD R0, 1; i = i + 1
    CMP R0, 5; verificar se já se percorreu todos os caracteres 
    JGE Stock;
    JMP CompPass;

;---------------------------
;  Erro Faltam Caracteres
;---------------------------
FaltaCaracteres:
    MOV R3, MenuFaltaCaract;
    CALL RotinaErro;
    JMP ProxCaracterPass;

;-----------------------------
;   Password Incorreta
;-----------------------------
PasswordErrada:
    MOV R3, MenuPasswordErrada;
    CALL RotinaErro;
    JMP StockAutenticacao;

;------------------------------
;     Stock
;------------------------------
Stock:
    MOV R6, 1; R6 = página atual no stock 
    MOV R1, 1; escolha da lista, neste momento é a lista bebidas
    MOV R2, 1; posição do elemento nessa lista
    CALL NPaginasStock; R10 = nº de páginas necessário
PagOpSegVolt:
    MOV R0, StockOSeg; R0 = posição do interface do stock com a opção seguinte
    CMP R6, R10;
    JLT MostraPagina; verifica se ainda não se encontra na ultima página
    MOV R0, StockOVolt; R0 = posição do interface do stock com a opção voltar
MostraPagina:
    CALL MostraDisplay;
    CALL PaginaAtualStock;
    MOV R8, R1; registo que guardam em que lista esta pagina acessou 1º
    MOV R9, R2; registo que guardam em que posição esta pagina acessou 1º
    CALL StockInfo;
    CALL LimpaPerifericos;
OpSegVolt:
    MOV R3, PE;
    MOVB R0, [R3];
    CMP R0, 0;
    JEQ OpSegVolt;
    CMP R0, 1;
    JNE StockOpVolt;
    CMP R6, R10;
    JGE ErroStock;
    ADD R6, 1;
    JMP PagOpSegVolt;
StockOpVolt:
    CMP R0, 4;
    JNE ErroStock;
    CMP R6, R10;
    JNE ErroStock;
    JMP CheckPointMenuInicial;
ErroStock:
    MOV R3, MenuErro;
    CALL RotinaErro;
    MOV R1, R8;
    MOV R2, R9;
    JMP PagOpSegVolt;

;------------------------------------------------------------------------------
;  Colocar * em vez de _ para o utilizador verificar que o caracter foi inserido
;-----------------------------------------------------------------------------
AddCaractMenu:
    PUSH R0;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    MOV R0, 0; R0 = i 
    MOV R2, PosCaractWrite; R2 = posição no display onde se encontra o 1º caracter q será escrito
    MOV R3, R1; R3 = nº de caracters escritos
    SHL R3, 1; R3 = 2 x R3
CicloAddC:
    CMP R0, R3; verificar se ja todos os substitui _ por *, que representam os caracteres inseridos pelo utilizador  
    JGE FimAddCaract; 
    MOV R4, CaractWrite; R4 = "*"
    MOVB [R2], R4; substituição de _ por *
    ADD R0, 2; R0 = R0 + 2
    ADD R2, 2; R2 = R2 + 2
    JMP CicloAddC;
FimAddCaract:
    POP R4;
    POP R3;
    POP R2;
    POP R0;
    RET;
 
;-------------------------------
; Adiciona inforrmação ao stock
;-------------------------------
StockInfo:
    PUSH R6;
    PUSH R7;
    PUSH R8;
    PUSH R9;
    PUSH R10;
    MOV R0, 0; nº de elementos colocados no display
    MOV R7, 21FH; posição no display onde queremos mostrar o valor
    MOV R9, 210H; posição inicial no display onde mostraremos o 1º nome
CicloAddInfo:
    CMP R1, 3;
    JLT InfoNaoMoedas; verificar se a lista é a das bebidas ou snacks
    JGT FimStockInfo; verificar se ja precorreu todas as listas
    MOV R3, R2;
InfoNaoMoedas:
    CALL PosProd_Moeda;
    MOVB R5, [R4];
    CMP R5, 0;
    JEQ ProxLista; verificar se já precorreu toda a lista
    CALL PosProd_Moeda; 
    CALL MostraString;
    CALL MostraQtElemt;
    MOV R3, 16; nº de bytes a adicionar para ir para a próximo posição
    ADD R9, R3; R9 = próxima posição do nome do elemento no display
    ADD R7, R3; R7 = próxima posição do quantidade do elemento no display
    ADD R0, 1; incremento o nº de elementos no display
    ADD R2, 1; avança para a proóxima posição
    CMP R0, 5; 
    JGE FimStockInfo; verificar se já foram colocados todos os elementos
    JMP CicloAddInfo;
ProxLista:
    ADD R1, 1; avança para a proxima lista
    MOV R2, 1; volta para o 1º elemento
    JMP CicloAddInfo;
FimStockInfo:
    POP R10;
    POP R9;
    POP R8;
    POP R7;
    POP R6;
    RET;

;-------------------------------
; Mostra Quantidade Elementos
;------------------------------
MostraQtElemt:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R5; 
    PUSH R7; 
    CALL QtProd_Moeda; R5 = quantidade do elemento
    MOV R0, 0; nº de caracteres insridos no display
    MOV R1, 10; valor a dividir para obter cada número
    MOV R3, 48; valor a somar para passar para ASCII
CicloMostraQtElemt:
    MOV R2, R5; R2 = valor a mostrar
    DIV R5, R1; 
    MOD R2, R1;
    ADD R2, R3;
    MOVB [R7], R2;
    SUB R7, 1;
    ADD R0, 1;
    CMP R0, 5;
    JGE FimCicloMostraQtElemt;
    JMP CicloMostraQtElemt;
FimCicloMostraQtElemt:
    POP R7;
    POP R5;
    POP R3;
    POP R2;
    POP R1;
    POP R0;
    RET;

;---------------------------
; Nº páginas para o Stock
;--------------------------
;R10 guarda o nº de páginas necessário
NPaginasStock:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    MOV R0, 0; nº de elementos total nas listas 
    MOV R1, 1; lista que desejamos aceder
    MOV R2, 1; posição do elemento na lista
CicloContaElemt:
    CMP R1, 3;
    JNE NaoLMoedas;
    MOV R3, R2; R3 = posição do elemento na lista moedas
NaoLMoedas:
    CALL PosProd_Moeda; R4 posição do elemento na lista
    MOVB R3, [R4];
    CMP R3, 0;
    JNE AddElemt; verifica se já precorreu toda a lista
    ADD R1, 1; avança para a próxima lista
    MOV R2, 1; volta para a 1º posição
    CMP R1, 3; 
    JGT NPaginas; verifica se já precorremos todas as listas
    JMP CicloContaElemt;
AddElemt:
    ADD R0, 1; incremento o nº de elementos
    ADD R2, 1; incrementa a posição
    JMP CicloContaElemt;
NPaginas:
    MOV R10, R0;
    MOV R1, 5; nº de elementos por cada interface
    DIV R10, R1; R10 = nº de páginas necessárias
    MOD R0, R1; resto da divisão do nº de páginas por 5
    CMP R0, 0; 
    JEQ FimNPaginas; verifica se esse resto é igual a 0
    ADD R10, 1; incrementa o nº de páginas
FimNPaginas:
    POP R4;
    POP R3;
    POP R2;
    POP R1;
    POP R0;
    RET;

;---------------------------
; Mostra página atual Stock
;------------------------------
;R6 nº da página atual
PaginaAtualStock:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    MOV R0, R6; R0 = nº da página atual
    MOV R1, 48; R1 = valor a somar para passar um número para notação ASCII
    ADD R0, R1;
    MOV R2, 209H; posição para a qual queremos colocar o nº de página no display
    MOVB [R2], R0;
    ADD R2, 3;
    MOV R0, R10; R0 = nº de páginas do stock
CicloPagTotal:
    MOV R4, R0;
    MOV R3, 10; 
    DIV R0, R3;
    MOD R4, R3; 
    ADD R4, R1;
    MOVB [R2], R4;
    CMP R0, 0;
    JEQ FimPagAtual;
    SUB R2, 1;
    JMP CicloPagTotal;
FimPagAtual:
    POP R4;
    POP R3;
    POP R2;
    POP R1;
    POP R0;
    RET