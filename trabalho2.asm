;periférico de entrada
PE EQU 280H;

;posição no display para representar o dinheiro inserido
ShowMoneyPagamento EQU 219H;
ShowMoneyTalao EQU 23BH;

;password inserida pelo utilizador
UserPassword EQU 300H;

;simbolo de caracter escrito
CaractWrite EQU 2AH;
;posição onde se encontra o 1º caracter q será escrito
PosCaractWrite EQU 243H;

;display (periférico de saída)
DisplayBegin EQU 200H;
DisplayEnd EQU 270H;

;PassWord Stock
Place 0F00H; 
Password:
    String "#Ac23";

;lista de moedas e quantidades das mesma na máquina
Place 0F50H;
ListaMoedas:
    String "10Cent  ";
    Word 10; 
    Word 0; quantidade de moedas de 10 centimos
    String "20Cent  ";
    Word 20; 
    Word 0; quantidade de moedas de 20 centimos
    String "50Cent  ";
    Word 50;
    Word 0; quantidade de moedas de 50 centimos
    String "1Euro   ";
    Word 100;
    Word 0; quantidade de moedas de 1 euro
    String "2Euros  ";
    Word 200;
    Word 0; quantidade de moedas de 2 euros
    String "5Euros  ";
    Word 500;
    Word 0; quantidade de notas de 5 euros

;lista de bebidas com os respectivos preços e quantidades na máquina
Place 1000H;
ListaBebidas:
    String "Agua    ";
    Word 100; preço
    Word 3; quantidade
    String "CocaCola";
    Word 250; preço
    Word 4; quantidade
    String "Fanta   ";
    Word 220; preço
    Word 5; quantidade

;lista de snacks com os respectivos preços e quantidades na máquina
Place 1500H;
ListaSnacks:
    String "Batatas ";
    Word 170; preço 
    Word 0; quantidade 
    String "Bolacha ";
    Word 210; preço 
    Word 0; quantidade 
    String "Chiclete";
    Word 130; preço 
    Word 0; quantidade 

;interface incial 
Place 2000H;
MaquinaMadeira:
    String "----------------";
    String "MAQUINA MADEIRA ";
    String "   BEM-VINDO    ";
    String "----------------";
    String "1) Produtos     ";
    String "2) Stock        ";
    String "----------------";

;interface com o menu das categorias de produtos
Place 2080H;
ProdCategoria:
    String "----------------";
    String "-- Categoria ---";
    String "----------------";
    String "1) Bebidas      ";
    String "2) Snacks       ";
    String "7) Cancelar     ";
    String "----------------";

;interface de escolha de bebidas
Place 2100H;
EscBebidas:
    String "--- Bebidas ----";
    String "----------------";
    String "1) Agua     1.00";
    String "2) CocaCola 2.50";
    String "3) Fanta    2.20";
    String "                ";
    String "7) Cancelar     ";
    

;interface de escolha de snacks
Place 2180H;
EscSnacks:
    String "---- Snacks ----";
    String "----------------";
    String "1) Batatas  1.70";
    String "2) Bolacha  2.10";
    String "3) Chiclete 1.30";
    String "                ";
    String "7) Cancelar     ";

;interface do talão
Place 2200H;
MenuTalao:
    String "----------------";
    String "     TALAO      ";
    String "----------------";
    String "                ";
    String "Inserido        ";
    String "Troco           ";
    String "----------------";

;interface incial para acessar ao stock
Place 2280H;
StockAutent:
    String "---- Stock -----";
    String "----------------";
    String "   Introduza    ";
    String "    Password    ";
    String "   _ _ _ _ _    ";
    String "1) Confirmar    ";
    String "4) Voltar       ";

;interface do stock vazio com a opção seguinte
Place 2300H;
StockOSeg:
    String "-- Stock  /  ---";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "1) Seguinte     ";

;interface do stock vazio com a opção vazio
Place 2380H;
StockOVolt:
    String "-- Stock  /  ---";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "4) Voltar       ";

;interface de pagamento
Place 2400H;
EscPagamento:
    String "--- Pagamento---";
    String "Inserido:       ";
    String "                ";
    String "1) 0.10  2) 0.20";
    String "3) 0.50  4) 1.00";
    String "5) 2.00  6) 5.00";
    String "7) Cancelar     ";

; interface de erro, em caso de opção inexistente
Place 2480H;
MenuErro:
    String "                ";
    String "                ";
    String "    ATENCAO     ";
    String "     OPCAO      ";
    String "    ERRADA      ";
    String "                ";
    String "                ";

Place 2500H;
MenuFaltaCaract:
    String "                ";
    String "                ";
    String "     ATENCAO    ";
    String "     FALTAM     ";
    String "   CARACTERES   ";
    String "                ";
    String "                ";

Place 2580H;
MenuPasswordErrada:
    String "                ";
    String "                ";
    String "     ATENCAO    ";
    String "    PASSWORD    ";
    String "    INCORRETA   ";
    String "                ";
    String "                ";


Place 2600H;
MenuProdFalta:
    String "                ";
    String "                ";
    String "     ATENCAO    ";
    String "     PRODUTO    ";
    String "    EM FALTA    ";
    String "                ";
    String "                ";

;Primeira instrução
Place 0000H;
Inicio:
    MOV R0, MenuInicial;
    JMP R0;

;----------------------------
;    Menu Inicial
;----------------------------
Place 3000H;
MenuInicial:
    MOV R0, MaquinaMadeira;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
LeOInical:    
    MOV R2, PE;
    MOVB R1, [R2];
    CMP R1, 0; verifica se foi introduzido alguma opção
    JEQ LeOInical;
    CMP R1, 1; verifica se a opção selecionada foi a dos produtos
    JEQ MenuProdCategoria;
    CMP R1,2;
    JEQ CheckPointStockAutenticacao;
    MOV R3, MenuErro;
    CALL RotinaErro; caso introduza alguma opção não existente é chamado um erro
    JMP MenuInicial;

;---------------------------------
;  Menu das Categorias de Produtos
;---------------------------------
MenuProdCategoria:
    MOV R0,ProdCategoria; 
    CALL MostraDisplay;
    CALL LimpaPerifericos;
LeOpProdutos:
    MOV R2, PE;
    MOVB R1, [R2];
    CMP R1, 0;
    JEQ LeOpProdutos; verifica se foi introduzido alguma opção
    JLT OpErrada; verifica se a opção é um valor negativo
    CMP R1, 2; 
    JLE MenuProd; verifica se a opção selecionada foi a das bebidas/snacks
    CMP R1, 7; verifica se a operação foi cancelada
    JEQ MenuInicial;
OpErrada:
    MOV R3, MenuErro;
    CALL RotinaErro; caso introduza alguma opção não existente é chamado um erro
    JMP MenuProdCategoria;

;------------------------------
;   Menu das Bebidas / Snacks
;------------------------------
MenuProd:
    CMP R1,1;
    JNE MenuSnacks;
MenuBebidas:
    MOV R0, EscBebidas;
    JMP MenuOpcBS;
MenuSnacks:
    MOV R0, EscSnacks;
MenuOpcBS:
    CALL MostraDisplay;
    CALL LimpaPerifericos;
LeOpcBS:
    MOV R3, PE;
    MOVB R2, [R3];
    CMP R2, 0; verifica se foi introduzido alguma opção
    JEQ LeOpcBS; 
    CMP R2, 1; verifica se foi selecionada a 1º opção
    JEQ VerifQtProd;
    CMP R2, 2; verifica se foi selecionada a 2º opção
    JEQ VerifQtProd;
    CMP R2, 3; verifica se foi selecionada a 3º opção
    JEQ VerifQtProd;
    CMP R2, 7; verifica se a operação foi cancelada
    JEQ MenuProdCategoria;
    MOV R3, MenuErro;
    CALL RotinaErro; caso introduza alguma opção não existente é chamado um erro
    JMP MenuOpcBS;

;---------------------------------------------
;  Verificar se o produto existe no stock
;---------------------------------------------
VerifQtProd:
    CALL QtProd_Moeda;
    CMP R5, 0;
    JGT TemProduto;
    MOV R3, MenuProdFalta;
    CALL RotinaErro;
    CMP R1, 1;
    JEQ MenuBebidas;
    JMP MenuSnacks;
TemProduto:
    JMP Pagamento;

;--------------------------------
;     Pagamento
;--------------------------------
Pagamento:
    MOV R0, EscPagamento;
    CALL PrecoProd_Moeda; guarda em R5 preço do produto a pagar
    MOV R6, 0; dinheiro inserido pelo utilizador
VerifMoneyInsert:
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R7, ShowMoneyPagamento;
    MOV R8, R6;
    CALL MostraMoney;  
    CMP R6, R5; verifica se já inseriu dinheiro suficiente
    JGE Talao;
LeOpPagamento:
    MOV R4, PE;
    MOVB R3, [R4];
    CMP R3, 0;
    JEQ LeOpPagamento;
    JLT OpErro;
    CMP R3, 6;
    JLE InserirMoeda;
    CMP R3, 7;
    JNE OpErro;
    CALL DarDinheiro;
    JMP MenuProd;
InserirMoeda:
    CALL AddMoeda;
    JMP VerifMoneyInsert;
OpErro:
    MOV R3, MenuErro;
    CALL RotinaErro;
    JMP VerifMoneyInsert;

;-----------------------------
;  Mostra Dinheiro Inserido
;-----------------------------
MostraMoney:  
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    PUSH R5;
    PUSH R6;
    MOV R0, R7; posição onde colocaremos o valor a mostrar no display
    MOV R6, R8; valor a representar
    MOV R1, 10; valor pelo qual vou dividir para obter cada número
    ADD R0, 4; posição do caracter a preencher
    MOV R2, 0; R2 = nº de caracteres já preenchidos
Ponto:
    CMP R2, 2;
    JNE Numero;
    MOV R5, 2EH; R5 = "."
    MOVB [R0], R5; escreve o ponto no display
    SUB R0, 1; proxima posição do display a preencher
    ADD R2, 1; incrementa o nº de caracter preenchidos
Numero:
    MOV R3, R6; cópia do quociende/valor inserido para R3
    MOD R3, R1; calculo do resto da divisão por 10
    DIV R6, R1; calculo quociente da divisão inteira por 10
    MOV R4, 48;
    ADD R4, R3; passar o número para representação ASCII
    MOVB [R0], R4; colocar o número no display
    SUB R0, 1; proxima posição do display a preencher
    ADD R2, 1; incrementa o nº de caracter preenchidos
    CMP R2, 4;
    JLT Ponto;
FimMostra:
    POP R6;
    POP R5;
    POP R4;
    POP R3;
    POP R2;
    POP R1;
    POP R0;
    RET;

;--------------------------
;  CheckPointMenuInicial
;--------------------------
CheckPointMenuInicial:
    JMP MenuInicial;
    
;--------------------------
;  CheckPointStockAutenticacao
;--------------------------
CheckPointStockAutenticacao:
    JMP StockAutenticacao;


;------------------------------------------------------
; Adicionar moeda máquino e incrementar valor inserida
;-----------------------------------------------------
AddMoeda:
    PUSH R0;
    PUSH R1;
    PUSH R3;
    PUSH R4;
    MOV R1, 3; para indicar que iremos utilizar a lista de moedas
    CALL PosProd_Moeda; guarda em R4 a posição da moeda na lista de moedas
    MOV R0, 8;
    ADD R4, R0; posição onde está o valor da moeda
    MOV R1, [R4];
    ADD R6, R1;
    ADD R4, 2; posição onde está a quantidade da moeda
    MOV R1, [R4]; 
    ADD R1, 1; incrementa a quantidade dessa moeda em 1
    MOV [R4], R1; 
    POP R4;
    POP R3;
    POP R1;
    POP R0;
    RET;

;--------------------------
;    Talão
;--------------------------
Talao:
    MOV R0, MenuTalao;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
MostraValorPagar:
    MOV R7, ShowMoneyTalao;
    MOV R8, R5; 
    MOV R9, 230H;
    CALL MostraNome;
    CALL MostraMoney;
MostraValorInserido:
    MOV R9, 16;
    ADD R7, R9;
    MOV R8, R6; 
    CALL MostraMoney;
MostraValorTroco:
    ADD R7, R9;
    MOV R9, R6;
    SUB R9, R5;
    MOV R8, R9;
    CALL MostraMoney;
OpMenuTalao:
    MOV R4, PE;
    MOVB R3, [R4];
    CMP R3, 0;
    JEQ OpMenuTalao;
    CMP R3, 1;
    JEQ CheckPointMenuInicial;
    MOV R3, MenuErro;
    CALL RotinaErro;
    JMP Talao; 

;-----------------------
;      Mostra Nome
;-----------------------
;R9 tem a posição na qual queremos começar a colocar o nome no display
MostraNome:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    CALL PosProd_Moeda; R4 = posição desse produto na sua lista
    MOV R0, 0;
    MOV R1, 8; R1 = tamanho dos nomes das bebidas ou snacks ou moedas
CicloMostraN:
    CMP R0, R1;
    JGE FimCicloMostraN; 
    MOV R2, [R4];
    MOV [R9], R2;
    ADD R0, 2;
    ADD R4, 2;
    ADD R9, 2;
    JMP CicloMostraN;
FimCicloMostraN:
    POP R4;
    POP R3;
    POP R2;
    POP R1;
    POP R0;
    RET;

;------------------------------------------
; Posição produto na lista bebida/snacks/moedas
;------------------------------------------
;R4 guarda a posição da produto na lista bebida/snack/moedas
PosProd_Moeda:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R5;
    CMP R1, 1; verifica se queremos verificar a quantidade do produto na lista de bebidas
    JEQ PosBebida; 
    CMP R1, 2; verifica se queremos verificar a quantidade do produto na lista de snacks
    JEQ PosSnack;
PosMoeda:
    MOV R2, R3;
    MOV R4, ListaMoedas;
    JMP CalculoPos; 
PosBebida:
    MOV R4,ListaBebidas;
    JMP CalculoPos; 
PosSnack:
    MOV R4, ListaSnacks;
CalculoPos:
    MOV R0, 12; R0 é o nº de bytes entre os elementos da lista de bebidas/snacks
    MOV R5, R2; cópia de R2, escolha da opção da bebida/snack
    SUB R5, 1; R4 é a posição do elemento nessa lista, dada através da escolha da opção da bebida/snack
    MUL R0, R5; 
    ADD R4, R0; R3 contem o endereço onde se encontra a bebida/snack na lista, apontando para o seu nome 
    POP R5;
    POP R3;
    POP R2;
    POP R1;
    POP R0;
    RET;

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
    MOVB R2, [R3];
    CMP R2, 0; verifica se foi introduzido algo
    JEQ LePass;
    CMP R2, 1; verifica se o utilizador quer confirmar a palavra passe
    JEQ VerifPass;
    CMP R2, 4; verifica se o utilizador quer voltar para a pagina inicial
    JEQ CheckPointMenuInicial;
    CMP R1, 5; verificar se o utilizador já inseriu 5 caracteres
    JGE ProxCaracterPass;
    MOV R3, UserPassword; guarda em R3 a posição da password inserida pelo utilizador
    ADD R3, R1; posição a guardar o caracter inserido através do nº inserido de carateres
    MOVB [R3], R2; guarda o valor o caracter inserido pelo utilizador na memória
    ADD R1, 1; incrementa em 1 o nº de caracteres inseridos
    JMP ProxCaracterPass;

;--------------------------
;  DarDinheiro
;--------------------------
; R6 valor inserido
DarDinheiro:
    PUSH R0; é a ultima moeda
    PUSH R1; quantidade de moedas
    PUSH R3; endereço q vai diminuindo ate ser R0
    PUSH R4; valor 12 (nº de bytes entre cada elemento)
    PUSH R5; valor da moeda

    MOV R0, 0F5AH;
    MOV R3, 0F96H;
    MOV R4, 12;
DarDinheiroCiclo:
    MOV R1, [R3];
    CMP R6, R1;
    JLT ProxMoeda; inserido<moeda    2.70<5 
    ; inserido>=moeda  5>=5  6>=5  2.70>=2
    CMP R1, 0;
    JEQ ProxMoeda;
    SUB R1, 1;
    MOV [R3], R1;
    SUB R3, 2;
    MOV R5, [R3];
    SUB R6, R5;
    ADD R3, 2;
    JMP DarDinheiroCiclo;
ProxMoeda:
    SUB R3, R4;
    CMP R3, R0;
    JGE DarDinheiroCiclo;
    CMP R6, 0;
    JEQ FimDarDinheiro; 
    MOV R3, MenuErro;n tinha moedas para dar a ele, dai ve se ele aceita a mesma; isto nunca vai acontecer qd tiver na opção 7(Voltar) do Bedidas/Snacks
    CALL RotinaErro;
FimDarDinheiro:
    POP R5;
    POP R4;
    POP R3;
    POP R1;
    POP R0;
    RET;
    
;--------------------------
; Quantidade Produto/Moedas
;--------------------------
;R5 guardar quantidade de produto ou moeda
QtProd_Moeda:
    PUSH R4; 
    CALL PosProd_Moeda;
    MOV R5, 10; posição a adicionar à posição do produto na lista para chegar na quantidade
    ADD R4, R5;
    MOV R5, [R4]; R5 guarda a quantidade do produto
    POP R4;
    RET;

;---------------------
; Preço Produto/Moedas
;---------------------
;R5 guardar o preço do produto ou moeda
PrecoProd_Moeda:
    PUSH R4; 
    CALL PosProd_Moeda;
    MOV R5, 8; posição a adicionar à posição do produto na lista para chegar no preço
    ADD R4, R5;
    MOV R5, [R4]; R4 guarda a preço do produto
    POP R4;
    RET;

;---------------------------------
; Confirmar Password Inserida
;--------------------------------
VerifPass:
    CMP R1, 5; verificar se o utilizador já inseriu 5 caracteres
    JLT FaltaCaracteres;
    MOV R0, 0; R0 = i
CompPass:
    MOV R1, UserPassword; R1 = posição da password inserida pelo utilizador
    MOV R2, Password; R2 = posição da password
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
    MOV R0, StockOSeg;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    JMP Stock;

;------------------------------------------------------------------------------
;  Colocar * em vez de _ para o utilizador verificar que o caracter foi inserido
;-----------------------------------------------------------------------------
AddCaractMenu:
    PUSH R0;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    MOV R0, 0; R0 = i = 0
    MOV R2, PosCaractWrite; R2 = posição onde se encontra o 1º caracter q será escrito
    MOV R3, R1; R3 = nº de caracters escritos
    SHL R3, 1; R3 = 2 x R3
CicloAddC:
    CMP R0, R3; verificar se ja todos os substitui _ por *, que representam os caracteres inseridos pelo utilizador  
    JGE FimAddCaract; 
    MOV R4, CaractWrite; substituição de _ por *
    MOVB [R2], R4;
    ADD R0, 2; R0 = R0 + 2
    ADD R2, 2; R2 = R2 + 2
    JMP CicloAddC;
FimAddCaract:
    POP R4;
    POP R3;
    POP R2;
    POP R0;
    RET;
 
;--------------------------
;  Rotina Erro
;--------------------------
RotinaErro:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    MOV R0, R3;
Erro:
    CALL MostraDisplay;
    CALL LimpaPerifericos;
CiclErro:
    MOV R1, PE;
    MOVB R2, [R1]; R2 = ao byte menos significativo da memoria de endereço R1
    CMP R2, 0; verifica se OK está ativo, igual a 1
    JEQ CiclErro;
    CMP R2, 1;
    JNE Erro; 
    POP R2;
    POP R1;
    POP R0;
    RET;

;------------------------
;   MostraDispla Display
;------------------------
MostraDisplay:
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    MOV R4, R0; R4 = posição na memória onde se encontra a posição de uma interface
    MOV R1, DisplayBegin; R1 = 1º posição do display 
    MOV R2, DisplayEnd; R2 = última posição do display
Ciclo:
    MOV R3, [R4]; R3 = conteúdo da memória de endereço R4
    MOV [R1], R3; o conteúdo da memória de endereço R1 = a R3
    ADD R4, 2; avança para a palavra logo a seguir a R4
    ADD R1, 2; avança para a palavra logo a seguir a R1
    CMP R1, R2; verifica se já preencheu o display todo
    JLT Ciclo;
    POP R4;
    POP R3; 
    POP R2; 
    POP R1;
    RET; 

;-----------------------
;    Limpa Perifericos
;-----------------------
LimpaPerifericos:
    PUSH R0;
    PUSH R1;
    MOV R0, PE;
    MOV R1, 0;
    MOV [R0], R1;
    POP R1;
    POP R0;
    RET;


