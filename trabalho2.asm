;periférico de entrada
Opcao EQU 280H;
OK EQU 290H;

;Opções
;Menu Inical
OProdutos EQU 1;
OStock EQU 2;
;ProdCategorias
OBebidas EQU 1;
OSnacks EQU 2;
;Bebidas
OAgua EQU 1;
OCocaCola EQU 2;
OFanta EQU 3;
;Snacks
OBatata EQU 1;
OBolacha EQU 2;
OChiclete EQU 3;
;Cancelar
OCancelar EQU 7;
;Voltar
OVoltar EQU 4;
;Seguinte
OSeguinte EQU 1;

;display (periférico de saída)
DisplayBegin EQU 200H;
DisplayEnd EQu 270H;

;lista de bebidas com os respectivos preços e quantidades na máquina
Place 500H;
ListaBebidas:
    String "Agua    ";
    Word 100;
    Word 0;
    String "CocaCola";
    Word 250;
    Word 0;
    String "Fanta   ";
    Word 220;
    Word 0;

;lista de snacks com os respectivos preços e quantidades na máquina
Place 1000H;
ListaSnacks:
    String "Batatas ";
    Word 170;
    Word 0;
    String "Bolacha ";
    Word 210;
    Word 0;
    String "Chiclete";
    Word 130;
    Word 0;

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
    MOV R2, MaquinaMadeira;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
LeOInical:    
    MOV R0, Opcao;
    MOVB R1, [R0];
    CMP R1, 0;
    JEQ LeOInical;
    CMP R1, OProdutos;
    JEQ MenuProdCategoria;
    ;CMP R1,OStock;
    ;JEQ StockAutenticacao;
    CALL RotinaErro;
    JMP MenuInicial;

;---------------------------------
;  Menu das Categorias de Produtos
;---------------------------------
MenuProdCategoria:
    MOV R0,ProdCategoria; 
    CALL MostraDisplay;
    CALL LimpaPerifericos;
LeOpProdutos:
    MOV R0, Opcao;
    MOVB R1, [R0];
    CMP R1, 0;
    JEQ LeOpProdutos;
    CMP R1, OBebidas;
    JEQ MenuBebidas;
    CMP R1, OSnacks;
    JEQ MenuSnacks;
    CMP R1, OCancelar;
    JEQ MenuInicial;
    CALL RotinaErro;
    JMP MenuProdCategoria;

;------------------------------
;      Menu das Bebidas
;------------------------------
MenuBebidas:
    MOV R2, EscBebidas;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    ;MOV R3, ListaBebidas;
LeOBebidas:
    MOV R0, Opcao;
    MOVB R1, [R0];
    CMP R1, 0;
    JEQ LeOBebidas; 
    CMP R1, OAgua; R1==1
    JEQ IrPagamento;
    CMP R1, OCocaCola; R1==2
    JEQ IrPagamento;
    CMP R1, OFanta; R1==3
    JEQ IrPagamento;
    CMP R1, OCancelar; R1==7
    JEQ MenuProdCategoria;
    CALL RotinaErro;
    JMP MenuBebidas;

;------------------------------
;      Menu dos Snacks
;------------------------------
MenuSnacks:
    MOV R2, EscSnacks;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    ;MOV R3, ListaSnacks;
LeOSnacks:
    MOV R0, Opcao
    MOVB R1, [R0];
    CMP R1, 0;
    JEQ LeOSnacks;
    CMP R1, OBatata; R1==1
    JEQ IrPagamento;
    CMP R1, OBolacha; R1==2
    JEQ IrPagamento;
    CMP R1, OChiclete; R1==3
    JEQ IrPagamento;
    CMP R1, OCancelar; R1==7
    JEQ MenuProdCategoria;
    CALL RotinaErro;
    JMP MenuSnacks;

;-------------------------------
;     Pagamento
;-------------------------------
IrPagamento:
    MOV R4,[R3]; R4 é o pagar
    ; verifica se existe esse produto no stock
    JMP IrPagamento;so pa resolver problemas resolver depois

;--------------------------
;  Rotina Erro
;--------------------------
RotinaErro:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    MOV R2, MenuErro;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R0, OK;
Erro:
    MOVB R1, [R0]
    CMP R1, 1;
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
    MOV R1, DisplayBegin; R1 = 1º posição do display 
    MOV R2, DisplayEnd; R2 = última posição do display
Ciclo:
    MOV R3, [R0]; R3 = conteúdo da memória de endereço R0
    MOV [R1], R3; o conteúdo da memória de endereço R1 = a R3
    ADD R0, 2; avança para a palavra logo a seguir a R0
    ADD R1, 2; avança para a palavra logo a seguir a R1
    CMP R1, R2; verifica se já 
    JLT Ciclo;
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
    PUSH R2;
    MOV R0, Opcao;
    MOV R1, OK;
    MOV R2, 0;
    MOVB [R0], R2;
    MOVB [R1], R2;
    POP R2;
    POP R1;
    POP R0;
    RET;


