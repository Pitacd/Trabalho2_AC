;periféricos
ON_OFF EQU 1A0H;
Opcao EQU 1B0H;
OK EQU 1C0H;

;display
Display EQU 200H;
DisplayEnd EQU 260H;
CaracterVazio EQU 20H;

MAlmoco EQU 1;opcao almoco
MBebidas EQU 2;opcao bebidas
MSandes EQU 2;opcao sandes
MSopas EQU 2;opcao sopas

MQuente EQU 2;opcao quente 
MFrio EQU 2;opcao frio

StackPointer EQU 6000H;

Place 2000H;
MenuInicio:
    String "   Menu Inicio  ";
    String "  1- Almoco     ";
    String "  2- Bebidas    ";
    String "  3- Sandes     ";
    String "  4- Sopas      ";
    String "                ";
    String "                ";

Place 2080H;
MenuBebidas:
    String "  Menu Bebidas  ";
    String "  1- Quentes    ";
    String "  2- Frias      ";
    String "                ";
    String "                ";
    String "                ";
    String "                ";

Place 2100H;
MenuErro:
    String "    Atencao     ";
    String "     Opcao      ";
    String "    Errada      ";
    String "                ";
    String "                ";
    String "                ";
    String "                ";

Place 0000H;
Inicio:
    MOV R0, Principio;
    JMP R0;

Place 3000H;
Principio:
    MOV SP, StackPointer;
    CALL LimpaDisplay;
    CALL LimpaPerifericos;
    MOV R0, ON_OFF;
Liga:
    MOV R1, [R0];
    CMP R1, 1;
    JNE Liga;
Ligado:
    MOV R2, MenuInicio;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
LeOpcao:
    MOV R0, Opcao;
    MOVB R1, [R0];
    CMP R1, 0;
    JEQ LeOpcao;
    CMP R1, MBebidas;
    JEQ OBebidas;
    CMP R1, MAlmoco;
    JEQ OAlmoco;
    CMP R1, MSandes;
    JEQ OSandes;
    CMP R1, MSopas;
    JEQ OSopas;
    CALL RotinaErro;
    JMP Ligado;


;--------------
;  Menu Bebidas
;--------------
OBebidas:
    MOV R2, MenuBebidas;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R0, Opcao;
OBebidasCiclo:
    MOVB R1, [R0];
    CMP R1, 0;
    JEQ OBebidasCiclo;
    CMP R1, MQuente;
    JEQ Ligado;
    CMP R1, MFrio;
    JEQ Ligado;
    CALL RotinaErro;
    JMP OBebidas;

;------------------
;   Rotina Erro
;------------------
RotinaErro:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    MOV R2, MenuErro;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R0, OK;
Erro:
    MOVB R1, [R0];
    CMP R1, 1;
    JNE Erro;
    POP R2;
    POP R1;
    POP R0;
    RET;
    
;------------------------
;  Rotina Almoco
;------------------------

OAlmoco:
    JMP Ligado;

;------------------------
;  Rotina Sandes
;------------------------

OSandes:
    JMP Ligado;

;------------------------
;  Rotina Sopas
;------------------------

OSopas:
    JMP Ligado;

;-------------------------
;     Mostra Display
;-------------------------

MostraDisplay:
    PUSH R0;
    PUSH R1;
    PUSH R3;
    MOV R0, Display;
    MOV R1, DisplayEnd;
Ciclo:
    MOV R3, [R2];
    MOV [R0], R3;
    ADD R2, 2;
    ADD R0, 2;
    CMP R0, R1;
    JLE Ciclo;
    POP R3;
    POP R1;
    POP R0;
    RET;

;-----------------------
;    Limpa Perifericos
;-----------------------
LimpaPerifericos:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    MOV R0, ON_OFF;
    MOV R1, Opcao;
    MOV R2, OK;
    MOV R3, 0;
    MOVB [R0], R3;
    MOVB [R1], R3;
    MOVB [R2], R3;
    POP R3;
    POP R2;
    POP R1;
    POP R0;
    RET;

;--------------------------
;  Limpa Display
;--------------------------
LimpaDisplay:
    PUSH R0;
    PUSH R1;
    PUSH R2;
    MOV R0, Display;
    MOV R1, DisplayEnd;
CicloLimpa:
    MOV R2, CaracterVazio;
    MOVB [R0], R2;
    ADD R0, 1;
    CMP R0, R1;
    JLE CicloLimpa;
    POP R2;
    POP R1;
    POP R0;
    RET;

