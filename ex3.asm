DOSSEG
.MODEL SMALL

.DATA

VETCOD DB 20 DUP(0)
MAXVALUE DB 0
MINVALUE DB 255
VETNORMAL db 0dh,0ah,"Vetor normal:$"
VIRGULA db ",$"
MAIORVALOR db 0dh,0ah,"Maior valor:$"
MENORVALOR db 0dh,0ah,"Menor valor:$"
ORDENAVET db 0dh,0ah,"Vetor ordenado:$"

rem db 0
rem2 db 0
.STACK
.CODE
main PROC
   MOV AX, @DATA 
   MOV DS, AX 
   MOV AX, @CODE
   MOV ES, AX
   MOV CX, 20
   MOV SI, 10h
   MOV AL, ES:[SI]
   MOV BX, OFFSET VETCOD
   MOV DI, 0
vetor_nm1:
   MOV [BX + DI], AL 
   INC DI
   INC SI
   MOV AL, ES:[SI]
   LOOP vetor_nm1
   MOV CX, 20
   MOV DI, 0
   MOV AH, 09h
   MOV DX, OFFSET VETNORMAL
   INT 21h
vetor_n1:
   MOV DL, [BX + DI]
   MOV AL, DL
   MOV AH, 00
   MOV DH, 10
   DIV DH
   MOV REM, AH
   MOV AH, 00
   DIV DH
   MOV REM2, AH
   MOV DL, AL
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   MOV DL, REM2
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   mov dl,REM
   add dl,48
   mov ah,02h
   int 21h
   MOV AH, 09h
   MOV DX, OFFSET VIRGULA
   INT 21h
   INC DI
   loop vetor_n1
   
reinicia:
   MOV CX, 20
   MOV SI, 0
cmp_maior:
   MOV DH, [BX + SI]
   MOV DL, MAXVALUE
   CMP DH, DL
   jA maior
   jmp cmp_menor
maior:
   MOV MAXVALUE, DH
cmp_menor:
   MOV DL, MINVALUE
   CMP DH, DL
   jbe menor
   jmp c_loop
menor:
   MOV MINVALUE, DH
c_loop:
   INC SI
   loop cmp_maior
print:
   MOV AH, 09h
   MOV DX, OFFSET MAIORVALOR
   INT 21h
   MOV DL, MAXVALUE
   MOV AL, DL
   MOV AH, 00
   MOV DH, 10
   DIV DH
   MOV REM, AH
   MOV AH, 00
   DIV DH
   MOV REM2, AH
   MOV DL, AL
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   MOV DL, REM2
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   mov dl,REM
   add dl,48
   mov ah,02h
   int 21h
   MOV AH, 09h
   MOV DX, OFFSET VIRGULA
   INT 21h
   MOV AH, 09h
   MOV DX, OFFSET MENORVALOR
   INT 21h
   MOV DL, MINVALUE
   MOV AL, DL
   MOV AH, 00
   MOV DH, 10
   DIV DH
   MOV REM, AH
   MOV AH, 00
   DIV DH
   MOV REM2, AH
   MOV DL, AL
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   MOV DL, REM2
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   mov dl,REM
   add dl,48
   mov ah,02h
   int 21h
   MOV AH, 09h
   MOV DX, OFFSET VIRGULA
   INT 21h
vetor_nm:
   MOV AH, 09h
   MOV DX, OFFSET VETNORMAL
   INT 21h
   MOV CX, 20
   MOV SI, 0
vetor_n:
   MOV DL, [BX + SI]
   MOV AL, DL
   MOV AH, 00
   MOV DH, 10
   DIV DH
   MOV REM, AH
   MOV AH, 00
   DIV DH
   MOV REM2, AH
   MOV DL, AL
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   MOV DL, REM2
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   mov dl,REM
   add dl,48
   mov ah,02h
   int 21h
   MOV AH, 09h
   MOV DX, OFFSET VIRGULA
   INT 21h
   INC SI
   loop vetor_n
ordenar:
   MOV CX, 19
   MOV SI, 0
   MOV DI, 0
   MOV AX, 19
   jmp l2_ordenar
l1_ordenar:
   DEC AX
   INC SI
   MOV DI, SI
l2_ordenar:
   MOV DH,[BX + SI]
   MOV DL,[BX + DI + 1]
   CMP DH,DL
   JA troca
   JMP continua
troca:
   MOV [BX + SI], DL
   MOV [BX + DI + 1], DH
continua:
   INC DI
   loop l2_ordenar
   MOV CX, AX
   loop l1_ordenar
   MOV AH, 09h
   MOV DX, OFFSET ORDENAVET
   INT 21h
   MOV CX, 20
   MOV SI, 0
print_vet:
   MOV DL, [BX + SI]
   MOV AL, DL
   MOV AH, 00
   MOV DH, 10
   DIV DH
   MOV REM, AH
   MOV AH, 00
   DIV DH
   MOV REM2, AH
   MOV DL, AL
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   MOV DL, REM2
   ADD DL, 48
   MOV AH, 2h
   INT 21h
   mov dl,REM
   add dl,48
   mov ah,02h
   int 21h
   MOV AH, 09h
   MOV DX, OFFSET VIRGULA
   INT 21h
   INC SI
   loop print_vet
   MOV AH, 4Ch
   INT 21h
main ENDP
    
    end main
