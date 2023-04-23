;-----------------------------
;  Mostra Dinheiro Inserido
;-----------------------------
;R7 posição no display onde colocaremos o valor
;R8 valor a representar no display
MostraDinheiro:  
    PUSH R0;
    PUSH R1;
    PUSH R2;
    PUSH R3;
    PUSH R4;
    PUSH R5;
    PUSH R6;
    MOV R0, R7; R0 = posição no display onde colocaremos o valor
    MOV R6, R8; R6 = valor a representar no display
    MOV R1, 10; R1 = valor pelo qual vou dividir para obter cada número
    ADD R0, 4; R0 = posição do caracter a preencher
    MOV R2, 0; R2 = nº de caracteres já preenchidos
Ponto:
    CMP R2, 2; verifica se ja se encontra no 3º caracter
    JNE Numero; 
    MOV R5, 2EH; R5 = "."
    MOVB [R0], R5; escreve o ponto no display
    SUB R0, 1; proxima posição do display a preencher
    ADD R2, 1; incrementa o nº de caracter preenchidos
Numero:
    MOV R3, R6; R3 = quociente/valor que queremos mostrar 
    MOD R3, R1; R3 =  resto da divisão inteira de R3 por 10
    DIV R6, R1; R6 = quociente da divisão inteira de R6 por 10
    MOV R4, 48; 
    ADD R4, R3; passar o número para representação ASCII
    MOVB [R0], R4; colocar o número no display
    SUB R0, 1; proxima posição do display a preencher
    ADD R2, 1; incrementa o nº de caracter preenchidos
    CMP R2, 4; verifica se ja preencheu todos os caracteres
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