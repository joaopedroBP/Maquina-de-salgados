RS equ P1.3 ;Req select p1.3 
EN equ P1.2 ;Enable p1.2

ORG 0000h
	LJMP MAIN

ORG 0030h
INI:
	DB "MAQUINA SALGADOS"
	DB 00h
S1:
	DB "S1-1.50"
	DB 00h
S2:
	DB "S2-0.50"
	DB 00h
S3:
	DB "S3-1.0"
	DB 00h
S4:
	DB "S4-2.0"
	DB 00h

ORG 0100h
MAIN:
	ACALL Ini_lcd

	MOV A, #00h
	ACALL Pos_cursor
	
	MOV DPTR, #INI
	ACALL Escreve_String
	CALL DELAY
	
	ACALL Clear_Display
	CALL DELAY

	MOV DPTR, #S1
	ACALL Escreve_String
	CALL DELAY
	
	MOV A, #09
	ACALL Pos_cursor
	
	MOV DPTR, #s2
	ACALL Escreve_String
	CALL DELAY
	
	MOV A, #0x40
	ACALL Pos_cursor
	
	MOV DPTR, #s3
	ACALL Escreve_String
	CALL DELAY
	
	MOV A, #0x49
	ACALL Pos_cursor
	
	MOV DPTR, #s4
	ACALL Escreve_String

	CALL DELAY
	JMP $	

Ini_lcd: ;Inicializa o LCD
	CLR RS 
	
	CLR P1.7
	CLR P1.6
	SETB P1.5
	CLR P1.4

	SETB EN
	CLR EN
	CALL DELAY

	SETB EN
	CLR EN
	
	SETB P1.7

	SETB EN
	CLR EN
	CALL DELAY

	CLR P1.7		
	CLR P1.6		
	CLR P1.5		
	CLR P1.4		

	SETB EN		
	CLR EN	

	SETB P1.7	
	SETB P1.6		
	SETB P1.5		
	SETB P1.4		

	SETB EN		
	CLR EN	

	CALL delay		
	RET

Escreve_String:
	MOV R1, #00h
loop:
	MOV A, R1
		MOVC A, @A+DPTR
		JZ finish
		ACALL Envia_caracter
		INC R1
	MOV A, R1
		JMP loop
finish:
	ret

Envia_caracter:
	SETB RS
	MOV C, ACC.7
	MOV P1.7, C
	MOV C, ACC.6
	MOV P1.6, C
	MOV C, ACC.5
	MOV P1.5, C
	MOV C, ACC.4
	MOV P1.4, C

	SETB EN
	CLR EN

	MOV C, ACC.3
	MOV P1.7, C
	MOV C, ACC.2
	MOV P1.6, C
	MOV C, ACC.1
	MOV P1.5, C
	MOV C, ACC.0
	MOV P1.4, C
	
	SETB EN
	CLR EN

	CALL DELAY
	ret

Pos_cursor: ;Coloca o cursor na posição desejada no lcd
	CLR RS
	SETB P1.7
	MOV C,ACC.6
	MOV P1.6, C
	MOV C, ACC.5
	MOV P1.5, C
	MOV C, ACC.4
	MOV P1.4 ,C

	SETB EN
	CLR EN
	
	MOV C, ACC.3
	MOV P1.7, C
	MOV C, ACC.2
	MOV P1.6, C
	MOV C, ACC.1
	MOV P1.5, C
	MOV C, ACC.0
	MOV P1.4, C

	SETB EN
	CLR EN

	CALL DELAY
	RET

Retorna_cursor:
	CLR RS	      
	CLR P1.7		
	CLR P1.6		
	CLR P1.5	
	CLR P1.4		

	SETB EN		
	CLR EN		

	CLR P1.7		
	CLR P1.6	
	SETB P1.5	
	SETB P1.4	

	SETB EN	
	CLR EN	

	CALL DELAY	
	RET

Clear_display:
	CLR RS	     
	CLR P1.7		
	CLR P1.6	
	CLR P1.5	
	CLR P1.4	

	SETB EN	
	CLR EN		

	CLR P1.7		
	CLR P1.6		
	CLR P1.5		
	SETB P1.4		

	SETB EN		
	CLR EN		

	MOV R6, #20
	rotC:
	CALL DELAY	
	DJNZ R6, rotC
	RET

DELAY:
	MOV R0, #50
	DJNZ R0, $
	RET


