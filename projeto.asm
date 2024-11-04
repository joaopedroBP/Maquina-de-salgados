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
	DB "Escolheu S"
	DB 00h
;texto exibido caso a opção esteja errada
opi:
	DB "Op nao existe"
	DB 00h
mopi:
	DB "Moeda nao existe"
	DB 00h

; textos exibindo instruções do pagamento
moedas1:
	DB "1 = 50   2 = 100"
	DB 00h
um_real:
	DB "1 real"
	DB 00h
cinquenta_cents:
	DB "50 cents"
	DB 00h
; texto para o troco
Troco:
	DB "Devolvendo troco"
	DB 00h

dispensando:
	DB "Dispensando"
	DB 00h

salgado:
	DB "Salgado"
	DB 00h

ORG 0100h
	LJMP MAIN
MAIN:
	;inicia o teclado
	;incia o lcd
	;inicia o motor
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
	
	;Se o input for valido
	;ele move o motor para
	;a posição relacionada
	;com o salgado escolhido
	;simulando a maquina
	;"pegando" o salgado
		
	;Mostra no lcd o que o usuario 	escolheu
	MOV DPTR, #escolheu
	ACALL Escreve_String

	MOV A, @R0        
	ACALL Envia_caracter
	CLR f0

	;Zera R4 e R5
	MOV R4, #0
	MOV R5, #0

	;Loop que ocorre até que o usuario
	;deposite um valor maior ou igual que
	;o preço do salgado
	loop2:
		;Limpa o LCD
		CALL DELAY
		ACALL Clear_Display
		CALL DELAY

		;Mostra os botões correspondentes
		;as moedas para o usuario
	
		MOV DPTR, #moedas1
		ACALL Escreve_String

		;loop que ocorre até que o usuario
		;precione um botão

		loop3:
			ACALL lerTeclado
			JNB F0, loop3

		;Move o botão precionado para
		;o acumulador A
		
		MOV A, #40h
		ADD A, R0
		MOV R0, A
		MOV A, @R0
		
		;Chama a subrotina check_moeda1
		;para verificar que moeda o usuario depositou
		;ou se ele depositou uma moeda não admitida

		CALL DELAY
		CALL check_moeda1

		;Acumula o valor depositado
		;no acumulador A e no R4
		
		MOV A, R7
		ADD A, R4
		MOV R4, A

		;Move o valor do preço do salgado
		;para B e chama a subrotina maior1
		;para verificar se o valor acumulado 
		;até o momento é maior que o preço do
		;salgado

		MOV B, R3
		CALL maior1

		;Compara A e B,se ambos forem iguais
		;isso indica que o usuario depositou
		;o valor necessário para comprar o salgado
		;encerrando o loop, se forem diferentes
		;ele volta para o inicio do loop

		CJNE A, B, loop2 

	;Limpa o LCD

	CALL DELAY
	ACALL Clear_Display
	CALL DELAY
	
	;Mostra no Lcd que o salgado escolhido
	;esta sendo dispensado

	MOV DPTR, #dispensando
	CALL Escreve_String

	MOV A, #0x40
	ACALL Pos_cursor
	MOV DPTR, #salgado
	CALL Escreve_String
	
	;volta o motor para a posição
	;original simulando a maquina
	;"entregando" o salgado
	ACALL Volta_motor

	;chama a subrotina ftroco para vericar se existe
	;troco e devolver o valor ao usuario(caso ele exista)

	CALL ftroco
	
	;LOOP para que o programa
	;não acabe tão rapido

	loop4:
		MOV R7, #20
		DEC R7
		DJNZ R7, $
	CALL DELAY

	;Limpa o LCD e reinicia o programa
	ACALL Clear_Display
	CALL DELAY
	JMP MAIN	

;Checks para ver se o usuario
;escolheu um botão errado
;checa de 1 a 4
;se não for nenhum deles
;chama a subrotina incorreto

;Também chamam as subrotians
;que posicionam o motor
;de acordo com o salgado
;escolhido

Check_input1:
	MOV B, #'1'
	CJNE A,B, Check_input2
	MOV R3, #150
	ACALL Move_S1
	ret
Check_input2:
	MOV B, #'2'
	CJNE A, B, Check_input3
	MOV R3, #50
	ACALL Move_S2
	ret
Check_input3:
	MOV B, #'3'
	CJNE A, B, Check_input4
	MOV R3, #100
	ACALL Move_S3
	ret
Check_input4:
	MOV B, #'4'
	CJNE A, B, incorreto
	MOV R3, #200
	ACALL Move_s4
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

;Funções check_moeda
;verificão se o usuario apertou um botão
;correspondente a uma das moedas disponiveis

;check_moeda1, verifica se a moeda é de 50 centavos
;usando CJNE entre A que contem a tecla precionada e B
;que contem o valor '1'
;se não for chama check_moeda2
;se for escreve na tela que o usuario depositou 50 centavos
;e move 50 para o r7 para que na main ocorra o acumulo dos valores depositados

check_moeda1:
	MOV B, #'1'
	CJNE A,B, Check_moeda2
	CALL DELAY
	ACALL Clear_Display
	CALL DELAY

	MOV DPTR, #cinquenta_cents
	ACALL Escreve_String
	MOV R7, #50
	ret

;check_moeda2, verifica se a moeda é de 1 real
;usando CJNE entre A que contem a tecla precionada e B
;que contem o valor '2'
;se não for chama m_incorreta
;se for escreve na tela que o usuario depositou 1 real
;e move 100 para o r7 para que na main ocorra o acumulo dos valores depositados

check_moeda2:
	MOV B, #'2'
	CJNE A, B, m_incorreta
	CALL DELAY
	ACALL Clear_Display
	CALL DELAY

	MOV DPTR, #um_real
	ACALL Escreve_String
	MOV R7, #100
	ret
;informa o usuario que o botão que ele precionou
;não corresponde a uma moeda permitida
;e volta para o inicio do loop2 na main

m_incorreta:
	ACALL Clear_display
	CALL DELAY

	MOV DPTR, #mopi 
	ACALL Escreve_String
	CALL DELAY

	CALL DELAY
	ACALL Clear_Display
	CALL DELAY

	MOV DPTR, #moedas1
	ACALL Escreve_String

	CALL DELAY
	JMP loop2

;subrotina que verifica se o valor acumulado
;na hora do pagamento é maior que preço do
;salgado selecionado

;Para isso o valor do preço do salgado é
;subtraido do valor acumulado com SUBB
;caso haja carry, ele vai para a subrotina
;menor, já que a existência de um carry indica que
;o valor acumulado é menor que o preço do salgado

;Se o valor for maior que o preço
;ele move o restante da subtração
;para o R5 e move o preço do salgado
;para o acumulador A, para que o loop
;que recebe o pagamento pare na MAIN

maior1:
	CLR C
	SUBB A, B
	JC menor
	MOV R5, A
	MOV A, R3
	ret

;subrotina que serve para restaurar o valor
;do acumulador A para o valor que ele possuia
;antes da subtração feita na subrotina maior1
menor:
	MOV A, R4
	ret

;subrotina que verifica com CJNE
;se R5 é diferente de 0 indicando que existe
;um valor de troco para devolver ao usuario
;se existir ele chama a subrotina mostra_troco

ftroco:
	CJNE R5, #0, mostra_troco
	ret

;subrotina que mostra no LCD que
;o programa esta devolvendo o troco
;e chama a subrotina checa_troco1 para
;ver qual o valor do troco

mostra_troco:
	CALL DELAY
	ACALL Clear_Display
	CALL DELAY

	MOV DPTR, #Troco
	ACALL Escreve_String
	
	ACALL checa_troco1
	ret

;subrotinas de checar_troco
;verificam se o troco é 1 real
;ou 50 centavos, o troco só pode
;ser um desses valores por causa
;das moedas admitidas pelo programa

;subrotina que verifica se o valor no
;R5 é 100 indicando que o troco é 1 real
;se for ele imprime no LCD "1 real"
;se não ele chama a subrotina checa_troco2

checa_troco1:
	MOV A, R5
	MOV B, #100
	CJNE A, B, checa_troco2
		
	MOV A, 0x40
	ACALL Pos_cursor

	MOV DPTR, #um_real
	ACALL Escreve_String
	ret
;subrotina que imprime no LCD
;"50 cents", ela não faz nenhuma checagem
;já que o troco só pode ser 1 de 2 valores

checa_troco2:
	MOV A, #0x40
	ACALL Pos_cursor
	MOV DPTR, #cinquenta_cents
	ACALL Escreve_String
	ret

;Subrotinas MOVE_Sx
;Movem o motor para
;uma posição diferente
;para cada salgado
;utilizando um loop com DJNZ em R2
;com valores diferentes dependendo
;do salgado

;Elas também restauram R2 no final
;para usar na subrotina Volta-motor

Move_S1:
	SETB p3.0
	CLR p3.1
	MOV R2, #7
	MOV B, #7
	loops1:
		DJNZ R2, loops1
	CLR p3.0
	CLR p3.1
	MOV R2, B
	RET

Move_S2:
	SETB p3.0
	CLR p3.1
	MOV R2, #14
	MOV B, #14
	loops2:
		DJNZ R2, loops2
	CLR p3.0
	CLR p3.1
	MOV R2, B
	RET

Move_S3:
	SETB p3.0
	CLR p3.1
	MOV R2, #25
	MOV B, #25
	loops3:
		DJNZ R2, loops3
	CLR p3.0
	CLR p3.1
	MOV R2, B
	RET

Move_S4:
	SETB p3.0
	CLR p3.1
	MOV R2, #28
	MOV B, #28
	loops4:
		DJNZ R2, loops4
	CLR p3.0
	CLR p3.1
	MOV R2, B
	RET

;subrotina que volta o motor
;para a posição original
;utiliza um loop com DJNZ R2
;movendo o motor a mesma quantidade
;de vezes que a função que o moveu anteriormente
;só que na direção contraria

Volta_motor:
	SETB p3.1
	CLR p3.0
	loop_volta:
		DJNZ R2,loop_volta
	CLR p3.0
	CLR p3.1
	ret
