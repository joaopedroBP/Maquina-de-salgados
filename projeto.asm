RS equ P1.3 
EN equ P1.2 

; Utilizando o Edsim51
; Use update Freq 100
; Use o teclado no modo Pulse

ORG 0000h 	
	MOV 11h, #150
	MOV 12h, #50
	MOV 13h, #100
	MOV 14h, #200
	LJMP MAIN

ORG 0030h
inicia_teclado:
	MOV 40H, #'#' 
	MOV 41H, #'0'
	MOV 42H, #'*'
	MOV 43H, #'9'
	MOV 44H, #'8'
	MOV 45H, #'7'
	MOV 46H, #'6'
	MOV 47H, #'5'
	MOV 48H, #'4'
	MOV 49H, #'3'
	MOV 4AH, #'2'
	MOV 4BH, #'1'
	
	call DELAY
	ret

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
escolheu:
	DB "Dispensando S"
	DB 00h
opi:
	DB "Op nao existe"
	DB 00h

ORG 0100h
	LJMP MAIN
MAIN:
	ACALL inicia_teclado
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
	loop1:
		ACALL lerTeclado
		JNB F0, loop1

	CALL DELAY 
	ACALL Clear_Display
	CALL DELAY
	
	; Logica pagamento...	


	; ...Logica pagamento
	MOV A, #00h
	ACALL Pos_cursor

	MOV A, #40h
	ADD A, R0
	MOV R0, A
	
	MOV 56h, 4
	Loop3:
		DEC 56h
		DEC R0
		DJNZ 56h,loop3

	DJNZ R0, incorreto

	MOV DPTR, #escolheu
	ACALL Escreve_String

	MOV A, @R0        
	ACALL Envia_caracter
	CLR f0
	
	loop2:
		MOV R7, #20
		DEC R7
		DJNZ R7, $
	CALL DELAY
	
	ACALL Clear_Display
	CALL DELAY
	JMP MAIN	


incorreto:
	MOV DPTR, #opi 

	ACALL Escreve_String
	CALL DELAY
	ACALL Clear_Display

	JMP MAIN
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

lerTeclado:
	CLR F0
	MOV R0, #0			

	
	MOV P0, #0FFh	
	CLR P0.0			
	CALL verColuna		
	JB F0, lfinish		
						
	
	SETB P0.0			
	CLR P0.1			
	CALL verColuna	
	JB F0, lfinish	
						
	SETB P0.1			
	CLR P0.2			
	CALL verColuna		
	JB F0, lfinish		

	SETB P0.2			
	CLR P0.3			
	CALL verColuna	
	JB F0, lfinish

lfinish:
	LJMP finish

verColuna:
	JNB P0.4,pegaTecla
	INC R0
	JNB P0.5,pegaTecla
	INC R0
	JNB P0.6, pegaTecla
	INC R0
	RET

pegaTecla:
	SETB F0
	RET

DELAY:
	MOV R7, #50
	DJNZ R7, $
	RET
