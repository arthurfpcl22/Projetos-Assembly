
DOSSEG
	.model small
	.stack
	.data
MESSAGE db "Entre com sua senha de acesso:",0dh,0ah,"$"
MESSAGE1 db 0ah,0dh,"Digite 1 ou 2: ", "$"
senha1 DB 0,0,0
senhar1 DB 31h,32h,33h
ver DB 0
ver_senha DB 0
nElementos DB 0
vetor1 DB 3 DUP(1,2,3)
vetor2 DB 3 DUP(2,2,5)
VetorXor DB 3 DUP(0)
SENHACORRETA db 0dh,"Senha correta",0ah, 0dh, " $"
SENHAINCORRETA db 0dh,"Senha incorreta",0ah, 0dh, " $"
VetorXorm db 0ah,0dh,"Vetorxor:$"
nElementosm db 0ah,0dh,"Numero de elementos:$"
String1 DB "Arturfrancapi"
tam1 EQU $-String1
String2 DB "Arturfrancapu"
tam2 EQU $-String2
DIF db 0dh,0ah,"Comprimentos diferentes$"
IGUALR db 0dh,0ah,"Comprimentos iguais e mesmo conteudo$"
IGUAL_d db 0dh,0ah,"Comprimentos iguais e conteudos diferentes$"
voltarp db 0dh,0ah,"Deseja voltar ao programa? Digite S se sim.$"
s DB 53h
	.code
main proc 
    MOV AX, @DATA 
	MOV DS, AX
inicio: 
    MOV AH, 09h
	MOV DX, OFFSET MESSAGE
	INT 21h
	MOV CX, 3
	MOV SI, 0
	MOV BX, OFFSET senha1
	
; OBTER SENHA
loopsenha:
	MOV AH, 1h
	INT 21h
	MOV [BX + SI], AL
	INC SI
	LOOP loopsenha
;COMPARAR SENHA
	MOV CX, 3
	MOV SI, 0
loop1:
	MOV DL, [BX + SI]
    PUSH BX
    MOV BX, OFFSET senhar1
    MOV DH, [BX + SI]
    POP BX
	CMP DH, DL
	je     igual      
	jmp    diferente
igual:
	INC ver
diferente:
	
	INC SI
	LOOP loop1
verificacaosenha:
	MOV DL, 3
	CMP ver, DL
	je     senhacorreta1      
	jmp    senhaincorreta1
senhaincorreta1:
	MOV AH, 09h
	MOV DX, OFFSET SENHAINCORRETA
	INT 21h
	INC ver_senha
	CMP ver_senha, 3
	jl inicio
	MOV AH, 4Ch
    INT 21h
senhacorreta1:
	MOV AH, 09h
	MOV DX, OFFSET SENHACORRETA
	INT 21h
digitaopcao:
	MOV AH, 09h
	MOV DX, OFFSET MESSAGE1
	INT 21h
	MOV AH, 1h
	INT 21h
	CMP AL, 31h
	jl valorinvalido
	jg valormaior
	je opcao1
valorinvalido:
	MOV AH, 09h
	MOV DX, OFFSET voltarp
	INT 21h
	MOV AH, 1h
	INT 21h
	CMP AL,s
	je digitaopcao 
	MOV AH, 4Ch
    INT 21h
valormaior:
    CMP AL, 32h
    je opcao2
    jg valorinvalido
opcao1:
	MOV DH, tam1
	MOV DL, tam2
	CMP DH, DL
	je mesmocomp
	jmp difcomp
difcomp:
	MOV AH, 09h
	MOV DX, OFFSET DIF
	INT 21h
    MOV AH, 4Ch
    INT 21h
mesmocomp:
    MOV SI, offset String1
    MOV DI, offset String2
    MOV AX, tam1
    MOV CX, AX
cmpr:
	MOV AL, [SI]
	CMP AL, [DI]
	jne nsame
	iNC SI
	INC DI
	loop cmpr
same:
	MOV AH, 09h
	MOV DX, OFFSET IGUALR
	INT 21h
    MOV AH, 4Ch
    INT 21h
nsame:
	MOV AH, 09h
	MOV DX, OFFSET IGUAL_d
	INT 21h
    MOV AH, 4Ch
    INT 21h
	;JMP continua
opcao2:
    MOV CX, 3
	MOV SI, 0
	MOV AH, 09h
	MOV DX, OFFSET VetorXorm
	INT 21h
loop2:
    PUSH BX
    MOV BX, OFFSET vetor1
    MOV DH, [BX + SI]
    POP BX
    PUSH BX
    MOV BX, OFFSET vetor2
    MOV DL, [BX + SI]
    POP BX
    PUSH BX
    MOV BX, OFFSET VetorXor
    XOR DH, DL
    MOV [BX + SI], DH
    MOV DL, [BX + SI]
    ADD DL, 48
    POP BX
    MOV AH, 2h
    INT 21h
    INC SI
    LOOP loop2
    MOV nElementos, LENGTH VetorXor
    MOV AH, 09h
	MOV DX, OFFSET nElementosm
	INT 21h
    MOV DL, nElementos
    ADD DL, 48
    MOV AH, 2h
    INT 21h
    	
continua: 
    	
    MOV AH, 4Ch
    INT 21h
    
main ENDP
    
    end main
	
	
	
	

