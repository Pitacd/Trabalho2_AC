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

    
    MOV R0, 50AH;
    MOV R3, 546H;
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
    JNE RotinaErro; n tinha moedas para dar a ele, dai ve se ele aceita a mesma; isto nunca vai acontecer qd tiver na opção 7(Voltar) do Bedidas/Snacks
    POP R5;
    POP R4;
    POP R3;
    POP R1;
    POP R0;
    RET;




MostraString:
    PUSH R0; R0 = nº de caracteres escritos
    PUSH R1; R1 = tamanho da string
    PUSH R2; 
    PUSH R4; R4 posição da String na memória
    PUSH R9; R9 posição no display para a qual queremos coloca la
    MOV R0, 0; 
    MOV R1, 8;
CicloMostraString:
    CMP R0, R1; 
    JGE FimCicloMostraN; verifica se já foram colocados todos os caracteres
    MOV R2, [R4]; R2 = dois caracteres guardados em R4
    MOV [R9], R2; escreve no display esses caracteres
    ADD R0, 2;
    ADD R4, 2; passa para a próxima palavra
    ADD R9, 2; passa para a próxima palavra
    JMP CicloMostraString;
FimCicloMostraString:
    POP R9;
    POP R4;
    POP R2;
    POP R1;
    POP R0;
    RET;