;periférico de entrada
PE EQU 280H;

;password inserida pelo utilizador
UserPassword EQU 300H;

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
    String "    Introduza   ";
    String "     Password   ";
    String "                ";
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
    MOV R4,[R3]; R4 é o pagar
    ; verifica se existe esse produto no stock
    JMP IrPagamento;so pa resolver problemas resolver depois


;-----------------------------
; Stock Autenticação
;-----------------------------
StockAutenticacao:
    MOV R0, StockAutent;
    MOV R1, 0; guarda em R1 o nº de caracteres preenchidos
    CALL MostraDisplay;
ProxCaracter:
    CALL LimpaPerifericos;
LePass:
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
    ADD R3, R1; «posição a guardar o caracter inserido através do nº inserido de carateres
    MOVB [R3], R2; guarda o valor o caracter inserido pelo utilizador na memória
    ADD R1, 1; incrementa em 1 o nº de caracteres inseridos
    JMP ProxCaracter;
VerifPass:
    CMP R1, 5; verificar se o utilizador já inseriu 5 caracteres
    JLT FaltaCaracteres;
    MOV R0, 0;
CompPass:
    MOV R1, UserPassword;
    ADD R1, R0;
    MOV R2, Password;
    ADD R2, R0;
    CMP R1, R2;
    JNE PasswordErrada;
    ADD R0, 1;
    CMP R0, 5;
    JGE Stock;
    JMP CompPass;
FaltaCaracteres:





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


