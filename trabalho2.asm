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
OCafe EQU 3;
;Snacks
OBatata EQU 1;
OBolacha EQU 2;
O

OCancelar EQU 7;
OVoltar EQU 4;


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

;interface do talão
Place 2100H;
Talao:
    String "----------------";
    String "     TALAO      ";
    String "----------------";
    String "                ";
    String "Inserido        ";
    String "Troco           ";
    String "----------------";

;interface incial para acessar ao stock
Place 2180H;
StockAutent:
    String "---- Stock -----";
    String "----------------";
    String "    Introduza   ";
    String "     Password   ";
    String "                ";
    String "1) Confirmar    ";
    String "4) Voltar       ";

;interface do stock vazio com a opção seguinte
Place 2200H;
    String "-- Stock  /  ---";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "1) Seguinte     ";

;interface do stock vazio com a opção vazio
Place 2280H;
    String "-- Stock  /  ---";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "                ";
    String "4) Voltar       ";

;interface de pagamento
Place 2300H;
    String "--- Pagamento---";
    String "Inserido:       ";
    String "Opções:         ";
    String "1) 0.10  2) 0.20";
    String "3) 0.50  4) 1.00";
    String "5) 2.00  6) 5.00";
    String "7) Cancelar     ";


ProdCategoria:
    CALL LimpaDisplay;
    CALL LimpaPerifericos;



