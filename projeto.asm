 ;INTEGRANTES
;Alexandre Domiciano Pierri / RA: 24.123.001-0
;João Pedro Bazoli Palma/ RA;24.123.041-6
RS equ P1.3 
EN equ P1.2 

; Utilizando o Edsim51
; Use update Freq 100
; Use o teclado no modo Pulse

;coloca os 'preços' na memoria
ORG 0000h 	
	MOV 11h, #150
	MOV 12h, #50
	MOV 13h, #100
	MOV 14h, #200
	LJMP MAIN
;incia o teclado
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
;Texto do incio
INI:
	DB "MAQUINA SALGADOS"
	DB 00h
;Texto do primeiro salgado
S1:
	DB "S1-1.50"
	DB 00h
;Texto do segundo salgado
S2:
	DB "S2-0.50"
	DB 00h
;Texto do terceiro salgado
 S3:
	DB "S3-1.0"
	DB 00h
;texto do quarto salgado
S4:
	DB "S4-2.0"
	DB 00h
;texto que exibe a escolha
escolheu:
	DB "Dispensando S"
	DB 00h
;texto exibido caso a opção esteja errada
opi:
	DB "Op nao existe"
	DB 00h

; textos exibindo instruções do pagamento
moedas1:
	DB "1 = 50   2 = 100"
	DB 00h

moedas2:
	DB "0 = confirmar"
	DB 00h

; texto para o troco
troco:
	DB "Devolvendo troco"
	DB 00h

; texto para falta de dinheiro
falta:
	DB "Faltam"
	DB 00h

ORG 0100h
	LJMP MAIN
MAIN:
	;inicia o teclado
	;incia o lcd
	ACALL inicia_teclado
	ACALL Ini_lcd
	
	;posiciona o cursor
	;para a primeira mensagem
	MOV A, #00h
	ACALL Pos_cursor	
	
	;primeira mensagem
	MOV DPTR, #INI
	ACALL Escreve_String
	CALL DELAY
	
	;limpa o LCD
	ACALL Clear_Display 
	CALL DELAY
	
	;Exibe no lcd os salgados
	ACALL exibir_salgados

	CALL DELAY
	;loop que le o teclado até
	;o usuario precionar um número
	loop1:
		ACALL lerTeclado
		JNB F0, loop1

	CALL DELAY 
	ACALL Clear_Display
	CALL DELAY
	
	MOV A, #00h
	ACALL Pos_cursor
	
	;apos o usuario apertar o botao
	;passa o valor para o A
	MOV A, #40h
	ADD A, R0
	MOV R0, A
	MOV A, @R0
  	
	;Chama uma subrotina para verificar
	;se o usuario apertou um botão
	;incorreto
 
	CALL Check_input1

	;implementar a logica para o pagamento
	MOV DPTR, #moedas1
	ACALL Escreve_string

	MOV A, #0x40
	ACALL Pos_cursor	

	MOV DPTR, #moedas2
	ACALL Escreve_string

	CALL DELAY
	ACALL CLEAR_Display
	CALL DELAY
	MOV A, #00h
	ACALL Pos_cursor
	
	ACALL inserir_moedas

	;Mostra no lcd o que o usuario 	escolheu
	MOV DPTR, #escolheu
	ACALL Escreve_String

	MOV A, @R0        
	ACALL Envia_caracter
	CLR f0
	
	;LOOP para que o programa
	;NAO acabe tao rapido(provisorio)
	loop2:
		MOV R7, #20
		DEC R7
		DJNZ R7, $
	CALL DELAY

	
	ACALL Clear_Display
	CALL DELAY
	JMP MAIN	

;Checks para ver se o usuario
;escolheu um botão errado
;checa de 1 a 4
;se não for nenhum deles
;chama a subrotina incorreto

Check_input1:
	MOV B, #'1'
	CJNE A,B, Check_input2
	ret
Check_input2:
	MOV B, #'2'
	CJNE A, B, Check_input3
	ret
Check_input3:
	MOV B, #'3'
	CJNE A, B, Check_input4
	ret
Check_input4:
	MOV B, #'4'
	CJNE A, B, incorreto
	ret

;informa o usuario que ele
;escolheu errado o botão
;reinicia o codigo na main

incorreto:
	ACALL Clear_display
	CALL DELAY

	MOV DPTR, #opi 
	ACALL Escreve_String
	CALL DELAY

	ACALL Clear_display
	CALL DELAY

	CALL DELAY
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
;subrotina que escreve uma string inteira
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

;subrotina que reotrna outra subrotina
finish:
	ret

;subrotina que coloca o caracter no LCD
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

;Coloca o cursor na posição desejada no lcd
Pos_cursor: 
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
;coloca o crusor na posição 0 do lcd
;sem apagar o texto
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
;limpa o texto do LCD
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

;subrotina que verifica se o usuario
;apertou algum botão
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

;subrotina que pula pro finish
;tive que fazer ela porque por algum motivo usar
;o finish normal na subrotina de ler teclado
;dava um erro

lfinish:
	LJMP finish

;verifica as colunas do teclado
verColuna:
	JNB P0.4,pegaTecla
	INC R0
	JNB P0.5,pegaTecla
	INC R0
	JNB P0.6, pegaTecla
	INC R0
	RET

;ativa o bit F0 se um botão tiver sido apertado
pegaTecla:
	SETB F0
	RET
;subrotina de Delay
;usa um decremento para garantir que
;subrotinas como Clear_Display funcionem sem erros
DELAY:
	MOV R7, #50
	DJNZ R7, $
	RET

;subrotina que printa todos os salgados
; e precos
exibir_salgados:
	MOV DPTR, #S1
	ACALL Escreve_String
	CALL DELAY
	
	MOV A, #09
	ACALL Pos_cursor
	
	MOV DPTR, #S2
	ACALL Escreve_String
	CALL DELAY
	
	MOV A, #0x40
	ACALL Pos_cursor
	
	MOV DPTR, #S3
	ACALL Escreve_String
	CALL DELAY
	
	MOV A, #0x49
	ACALL Pos_cursor
	
	MOV DPTR, #S4
	ACALL Escreve_String
	CALL DELAY
	RET
;Funções do pagamento

;inicia moeda como 0
inserir_moedas:
    ACALL lerTeclado

    ; Verifica se uma tecla foi pressionada
    JNB F0, inserir_moedas
    MOV A, R0
    
    ; Se 0 for apertado, para com a inserção
    CJNE A, #'0', adiciona_moeda
    JMP fim_insercao

adiciona_moeda:
    ; Se a tecla pressionada não for 1, verifica se foi 2
    CJNE A, #'1', adiciona_moeda2
    MOV A, R1
    ADD A, #50
    MOV R1, A
    JMP inserir_moedas

adiciona_moeda2:
    CJNE A, #'2', inserir_moedas
    MOV A, R1
    ADD A, #100
    MOV R1, A
    JMP inserir_moedas

fim_insercao:
	 RET

