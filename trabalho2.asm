;periférico de entrada
PE EQU 280H;

;password inserida pelo utilizador
UserPassword EQU 300H;

;simbolo de caracter escrito
CaractWrite EQU 2AH;

;posição onde se encontra o 1º caracter q será escrito
PosCaractWrite EQU 243H;

;SP EQU  fica no final da memória

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
    Word 0; quantidade
    String "CocaCola";
    Word 250; preço
    Word 0; quantidade
    String "Fanta   ";
    Word 220; preço
    Word 0; quantidade

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
Talao:
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
    String "Opcoes:         ";
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
    JEQ StockAutenticacao;
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
    CMP R1, 0; verifica se foi introduzido alguma opção
    JEQ LeOpProdutos;
    CMP R1, 1; verifica se a opção selecionada foi a das bebidas
    JEQ MenuBebidas;
    CMP R1, 2; verifica se a opção selecionada foi a dos snacks
    JEQ MenuSnacks;
    CMP R1, 7; verifica se a operação foi cancelada
    JEQ MenuInicial;
    MOV R3, MenuErro;
    CALL RotinaErro; caso introduza alguma opção não existente é chamado um erro
    JMP MenuProdCategoria;

;------------------------------
;   Menu das Bebidas / Snacks
;------------------------------
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
    JEQ IrPagamento;
    CMP R2, 2; verifica se foi selecionada a 2º opção
    JEQ IrPagamento;
    CMP R2, 3; verifica se foi selecionada a 3º opção
    JEQ IrPagamento;
    CMP R2, 7; verifica se a operação foi cancelada
    JEQ MenuProdCategoria;
    MOV R3, MenuErro;
    CALL RotinaErro; caso introduza alguma opção não existente é chamado um erro
    JMP MenuOpcBS;

;-------------------------------
;     Pagamento
;-------------------------------
IrPagamento:
    MOV R5, 12; R5 é o nº de bytes entre os elementos da lista de bebidas/snacks
    SUB R2, 1; R2 é a opção (1,2,3), que na lista corresponde ao (0,1,2) respetivamente
    MUL R5, R2;
    ADD R4, R5; R4 é o endereço de memória do valor a pagar
    MOV R5,[R4]; R5 é o valor a pagar
    ; verifica se existe esse produto no stock:
    ADD R4, 2;
    MOV R7, [R4];
    CMP R7, 0;
    JNE TemProduto; Apresenta não existe esse produto
    SUB R4, 2;
    CALL RotinaErro;
    CMP R1, 1;
    JEQ MenuBebidas;
    JMP MenuSnacks;
TemProduto:
    SUB R4, 2;
    MOV R6, 0; inicializa o inserido a 0
    JMP Pagamento;

Pagamento:
    ; R0 era o display ||| mudou o display
    ; R1 é 1->bebidas 2->snacks
    ; R2 era a opção ||| continua sendo esse propósito
    ; R3 era o endereço de memoria da opção ||| continua sendo esse propósito
    ; R4 era o endereço de memória do valor a pagar ||| não usado
    ; R5 é o valor a pagar
    ; R6 vai ser o inserido, foi inicializado a 0 antes do Pagamento
    ; R7 vai ser auxiliar
    ; R8 vai ser usado para o endereço de onde vai ser colocado o numero (tem de ter 5 espaços livres apartir desse endereço)
    ; R9 endereço da quantidade da respectiva moeda

    MOV R0, EscPagamento;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R8, 219H;
    CALL MostraNumero;
    ;verifica se ja inserio o suficiente:
    CMP R6, R5;
    JGE MenuTalao;
LeOpPagamento:
    MOV R3, Opcao;
    MOVB R2, [R3];
    CMP R2, 0;
    JEQ LeOpPagamento;
;Op1
    CMP R2, 1;
    JNE Op2;
    MOV R7, 10;
    ADD R6, R7;
    ;O stock de 10cents aumenta em 1;
    MOV R9, 50AH;
    MOV R7, [R9];
    ADD R7, 1;
    MOV [R9], R7;
    JMP Pagamento;
Op2:
    CMP R2, 2;
    JNE Op3;
    MOV R7, 20;
    ADD R6, R7;
    ;O stock de 20cents aumenta em 1;
    MOV R9, 516H; 50AH+12=516H
    MOV R7, [R9];
    ADD R7, 1;
    MOV [R9], R7;
    JMP Pagamento;
Op3:
    CMP R2 ,3;
    JNE Op4;
    MOV R7, 50;
    ADD R6, R7;
    ;O stock de 50cents aumenta em 1;
    MOV R9, 522H;  516H+12=522H;
    MOV R7, [R9];
    ADD R7, 1;
    MOV [R9], R7;
    JMP Pagamento;
Op4:
    CMP R2 ,4;
    JNE Op5;
    MOV R7, 100;
    ADD R6, R7;
    ;O stock de 1euro aumenta em 1;
    MOV R9, 52EH; 522H+12=52EH;
    MOV R7, [R9];
    ADD R7, 1;
    MOV [R9], R7;
    JMP Pagamento;
Op5:
    CMP R2 ,5;
    JNE Op6;
    MOV R7, 200;
    ADD R6, R7;
    ;O stock de 2euros aumenta em 1;
    MOV R9, 53AH; 52EH+12=53AH;
    MOV R7, [R9];
    ADD R7, 1;
    MOV [R9], R7;
    JMP Pagamento;
Op6:
    CMP R2 ,6;
    JNE Op7;
    MOV R7, 500;
    ADD R6, R7;
    ;O stock de 5euros aumenta em 1;
    MOV R9, 546H; 53AH+12=546H;
    MOV R7, [R9];
    ADD R7, 1;
    MOV [R9], R7;
    JMP Pagamento;
Op7:
    CMP R2, 7;
    JNE OpNULL;
    CALL DarDinheiro ; doq ele inseriu, R6
    CMP R1, 1;
    JEQ MenuBebidas;
    CMP R1, 2;
    JEQ MenuSnacks;
OpNULL:
    CALL RotinaErro;
    JMP Pagamento;



;-----------------------------
; Stock Autenticação
;-----------------------------
StockAutenticacao:
    MOV R0, StockAutent;
    MOV R1, 0; guarda em R1 o nº de caracteres preenchidos
ProxCaracter:
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
    JEQ MenuInicial;
    CMP R1, 5; verificar se o utilizador já inseriu 5 caracteres
    JGE ProxCaracter;
    MOV R3, UserPassword; guarda em R3 a posição da password inserida pelo utilizador
    ADD R3, R1; posição a guardar o caracter inserido através do nº inserido de carateres
    MOVB [R3], R2; guarda o valor o caracter inserido pelo utilizador na memória
    ADD R1, 1; incrementa em 1 o nº de caracteres inseridos
    JMP ProxCaracter;

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
    JMP ProxCaracter;

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


