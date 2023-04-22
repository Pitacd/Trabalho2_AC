
MenuTalao: ;Posso usar até o registo 10 (incluido), 11 pa frente é registo especial
    ; R0 era o display ||| mudou o display
    ; R1 era 1->bebidas 2->snacks vai ser a copia do |VALOR INSERIDO|
    ; R2 era a opção ||| continua sendo esse propósito
    ; R3 era o endereço de memoria da opção ||| continua sendo esse propósito
    ; R4 era o endereço de memória do valor a pagar
    ; R5 é o |VALOR A PAGAR|
    ; R6 era o valor inserido mas vai ser usado para o #Mostrar Numero#
    ; R7 vai ser o |TROCO|
    ; R8 é para os endereços de onde começa o #Mostrar Nome Numero# no display
    ; R9 é para os endereços de onde começa o #Mostrar Nome Numero# na memoria (vai ser copiado para o display)
    MOV R0, Talao;
    MOV R1, R6;
    MOV R7, R6;
    SUB R7, R5;
    CALL MostraDisplay;
    CALL LimpaPerifericos;
    MOV R6, R5;
    MOV R8, 230H;
    MOV R9, R4;
    SUB R9, 4;
    SUB R9, 4;
    CALL MostraNomeNumero;
    MOV R6, R1
    MOV R8, 24BH;
    CALL MostraNumero;
    MOV R6, R7;
    MOV R8, 25BH;
    CALL MostraNumero;
OpMenuTalao:
    MOV R2, Opcao;
    MOVB R3, [R2];
    CMP R3, 0;
    JEQ OpMenuTalao;
    CMP R3, 1;
    JEQ CheckPointMenuInicial;
    CALL RotinaErro;
    JMP MenuTalao;

;--------------------------
;  Mostrar nome e numero
;--------------------------
MostraNomeNumero:
    PUSH R0; vai ser o valor que esta sendo copiado
    PUSH R1; R1 é pa parar de copiar
    PUSH R2;
    ; R6 valor para #Mostrar Numero#
    ; R8 é para os endereços de onde começa o #Mostrar Nome Numero# no display
    ; R9 é para os endereços de onde começa o #Mostrar Nome Numero# na memoria (vai ser copiado para o display)
    MOV R1, 0;
MostraNomeCiclo:
    MOV R0, [R9];
    MOV [R8], R0;
    ADD R9, 2;
    ADD R8, 2;
    ADD R1, 2;
    MOV R2, 8;
    CMP R1, R2;
    JLT MostraNomeCiclo;
    ADD R8, 3;
    CALL MostraNumero;
    POP R2;
    POP R1;
    POP R0;
    RET;