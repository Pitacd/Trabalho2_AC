;periférico de entrada
Opcao EQU 280H;
OK EQU 290H;
ListaBebidas 300H;
ListaSnacks 310H;

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
OCafe EQU 3;
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
DisplayEnd EQu 260H;

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
    String "3) Cafe     0.60";
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
    String "Opções:         ";
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
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R0, Opcao;
    MOV R1, [R0];
LeOInical:
    CMP R1, 0;
    JEQ LeOInical;
    CMP R1, 1;
    JEQ MenuProdCategoria;
    CMP R1,2;
    JEQ StockAutenticacao;
    JMP MenuInicial;

;---------------------------------
;  Menu das Categorias de Produtos
;---------------------------------
MenuProdCategoria:
    MOV R2,ProdCategoria; 
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
    CAll RotinaErro;
    JMP MenuProdCategoria;

;------------------------------
;      Menu das Bebidas
;------------------------------
MenuBebidas:
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R0, Opcao;
    MOV R3, ListaBebidas;
    MOV R1, [R0];
    MOV R2, 1;
    CMP R1, R2; R1==1
    JEQ IrPagamento;
    ADD R2, 1;
    CMP R1, R2; R1==2
    JEQ IrPagamento;
    ADD R2, 1;
    CMP R1, R2; R1==3
    JEQ IrPagamento;
    ADD R2, 4;
    CMP R1, R2; R1==7
    JEQ MenuProdCategoria;
    JMP MenuBebidas;

;------------------------------
;      Menu dos Snacks
;------------------------------
MenuSnacks:
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R0, Opcao;
    MOV R3, ListaSnacks;
    MOV R1, [R0];
    MOV R2, 1;
    CMP R1, R2; R1==1
    JEQ IrPagamento;
    ADD R2, 1;
    ADD R3, nº de bytes q tem cada elemento da lista;
    CMP R1, R2; R1==2
    JEQ IrPagamento;
    ADD R2, 1;
    ADD R3, nº de bytes q tem cada elemento da lista;
    CMP R1, R2; R1==3
    JEQ IrPagamento;
    ADD R2, 4;
    ADD R3, (nº de bytes q tem cada elemento da lista)*4;
    CMP R1, R2; R1==7
    JEQ MenuProdCategoria;
    JMP MenuSnacks;

;-------------------------------
;     Pagamento
;-------------------------------
IrPagamento:
    MOV R4,[R3]; R4 é o pagar
    ; verifica se existe esse produto no stock
    JMP Pagamento;

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
    PUSH R0;
    PUSH R1;
    PUSH R3;
    MOV R0, DisplayBegin;
    MOV R1, DisplayEnd;
Ciclo:
    MOV R3, [R2];
    MOV [R0], R3;
    ADD R0, 2;
    ADD R2, 2;
    CMP R0, R1;
    JLE Ciclo;
    POP R3; 
    POP R1; 
    POP R0;
    RET; 



