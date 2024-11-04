> Um programa codificado em assembly para o simulador Edsim51 que busca implementar o funcionamento de uma maquina de venda de salgadinhos. O programa inicia com uma mensagem mostrando as opções de salgado juntamente com o prçeo de cada um e qual botão deve ser  pressionado para selecionar cada salgadinho. Por meio do teclado, o usuário seleciona entre 4 opções: S1(botão 1 do telcado), S2(botão 2 do telcado), S3(botão 3 do telcado) e S4(botão 4 do telcado). Caso qualquer outro botão tenha sido apertado, a máquina irá aprentar uma mensagem dizendo que essa opção é invalida e o programa repetirá o processo até que uma opção válida tenha sido selecionada.<br><br>Depois de selecionar uma opção válida,o motor da edsim se movera para a posição correspondente a do salgado escolhido, após isso, uma mensagem irá aparecer indicando quais botões devem ser pressionados para executar o pagamento, que será por moedas de 50 centavos e 100 centavos(1 real). Qualquer outro botão pressionado não irá afetar em nada o programa. A medida que os botões coreespondentes a 50 centavos e 1 real forem pressionados uma mensagem irá aparecer dizendo qual moeda foi inserida na maquina. O código só irá para quando o valor pago for maior ou igual ao valor do salgado. Caso o valor seja maior, uma mensagem será exibida dizendo qual será o troco que será exibido.<br><br>Por fim, haverá uma mensagem avisando que o salgadinho "X" será dispejado da máquina, o motor retornara para sua posição original e assim o programa finaliza.
 

# Configurações antes de começar: 

- Frequência 100 Hz e teclado no modo pulse
<br>
<img src="https://github.com/user-attachments/assets/705fdca7-ca06-44d2-831e-9fa6db83bbae" alt="Configurações para o funcionamento do projeto" width="300">


- Velocidade do motor similar a da imagem abaixo
<img src = "https://github.com/user-attachments/assets/c3b46f60-72c2-4d5f-99ef-ef0d28803e2e" alt= "configuração da velocidade do motor" width="300">


- Iniciar o teclado: cada endereço recebe um determinado caracter
<br>
<img src = "https://github.com/user-attachments/assets/13f0cef9-26eb-4ae7-a0a9-77556577c777" alt="Iniciar o teclado" widht = "300" >

# Fluxograma do projeto
```mermaid
flowchart TD
    n1["COMEÇO<br>"] --> n3{"INPUT DO USUARIO<br>"}
    n3 -- NÃO --> n1
    n3 -- SIM --> n4{"CHECK INPUT<br>"}
    n4 -- INPUT INVÁLIDO --> n1
    n4 -- INPUT VÁLIDO --> n6{"AGUARDANDO PAGAMENTO<br>"}
    n6 --> n7{"CHECK MOEDA<br>"}
    n7 -- MOEDA INVÁLIDA --> n6
    n7 -- MOEDA VÁLIDA --> n8{"QUANTIDADE SUFICIENTE"}
    n8 -- NÃO --> n6
    n8 -- SIM --> n9["DISPENSANDO SALGADO"]
    n9 -- SEM TROCO --> n1
    n9 -- COM TROCO --> n10["DISPENSANDO TROCO"]
    n10 --> n1

    %% Estilo dos nós
    style n1 fill:#FFCDD2,color:black
    style n3 fill:#FFE0B2,color:black
    style n4 fill:#FF6D00,color:black
    style n6 fill:#FFE0B2,color:black
    style n7 fill:#FF6D00,color:black
    style n8 fill:#BBDEFB,color:black
    style n9 fill:#BBDEFB,color:black
    style n10 fill:#BBDEFB,color:black
```


# Textos usados na Main
<br>
<img src = "https://github.com/user-attachments/assets/dee91e10-68d1-49f6-a1c3-473c68cf574f" alt="Textos usados na main" widht = "200" >
<img src = "https://github.com/user-attachments/assets/93040cf0-9681-4690-93ac-2a963ee3f911" alt="Textos usados na main" widht = "200" >
<img src = "https://github.com/user-attachments/assets/6f00a73d-6ff8-419e-b6d5-322d47a1e9c3" alt="Textos usados na main" widht = "200" >
<img src = "https://github.com/user-attachments/assets/08485c0e-1a75-4117-a816-2c54a535f988" alt="Textos usados na main" widht = "200" >

# Funções
- Check_input: O conjunto de subrotinas verifica qual botão o usuário apertou e se o valor está no intervalo de 1 a 4. A subrotina check1 verifica se o botão pressionado é o 1; se não for, chama check2. Esse processo continua até check4, que, caso o botão não seja o 4, chama a subrotina incorreto. Cada subrotina também define o preço do salgado escolhido no registrador R3 e aciona uma subrotina que move o motor para a posição correspondente ao salgado selecionado.
  
  <img src = "https://github.com/user-attachments/assets/15faf286-0a12-41bc-bff0-13f702fe45b9" alt="Função check input" widht = "200" height ="300">
  <img src = "https://github.com/user-attachments/assets/73b91086-e1c1-4b6b-8878-dfea3b7cf370" alt="Função check input" widht = "200" height ="300">
 
- Incorreto: informa a o usuário que ele escolheu uma opção inválida e renicia o código na main
  
   <img src = "https://github.com/user-attachments/assets/71bf9244-3108-4fa2-bb62-e6192854e69c" alt="Função incorreto" widht = "200" >
   
- Ini_lcd: inicia o LCD de 2 linhas por 16 colunas
  
  <img src = "https://github.com/user-attachments/assets/9ff2fbeb-f96d-487c-88d3-75d63a1ca17e" alt="Função ini_lcd" widht = "200" >
  <img src = "https://github.com/user-attachments/assets/1140b6d9-a3e2-4019-b85b-18e384f49903" alt="Função ini_lcd" widht = "200" >

- Escreve_String: subrotina que escreve uma string inteira
  
  <img src = "https://github.com/user-attachments/assets/5b028373-3594-4920-90a7-b6b9c8801590" alt="Função escreve_string" widht = "200" >

- Finish: subrotina que retorna outro subrotina
  
 <img src = "https://github.com/user-attachments/assets/0196d615-f0ad-4199-a451-22b4da6bb715" alt="Função finish" widht = "200" >
 
- Envia_caracter: subrotina que coloca o caracter no LCD. O pino RS é ativado para sinalizar ao LCD que o dado enviado é um caractere e o byte mais significativo para os pinos "P1.7" a "P1.4" e  habilita o pino EN para sinalizar o envio do LCD.
  
  <img src = "https://github.com/user-attachments/assets/38de39a0-49a2-40e7-9991-da2fd5cb5aed" alt="Função envia_caracter" widht = "200" >
  <img src = "https://github.com/user-attachments/assets/8627afc9-5bd4-4fc8-a231-c18fb40e27e5" alt="Função envia_caracter" widht = "200" >

- Pos_cursor: Coloca o cursor na posição desejada no lcd

  <img src = "https://github.com/user-attachments/assets/51aa2485-1970-4ef8-b301-ebaf522e314d" alt="Função pos_cursor" widht = "200" >
  <img src = "https://github.com/user-attachments/assets/289bfece-efad-4973-8929-dc1fe524c599" alt="Função pos_cursor" widht = "200" >

- Retorna cursor:  move o cursor do display LCD para a posição inicial
  
  <img src = "https://github.com/user-attachments/assets/14d00a0f-95d3-4abc-baec-3ba20436412d" alt="Função pos_cursor" widht = "200" >

- Clear_display: limpa o display

  <img src = "https://github.com/user-attachments/assets/400becbc-de55-48a6-8d39-488ba27b50f9" alt="Função pos_cursor" widht = "200" >
  <img src = "https://github.com/user-attachments/assets/49f42f29-a69c-46bb-9c1a-fb23c52c73c1" alt="Função pos_cursor" widht = "200" >
  
- ler_teclado : subrotina que verifica se o usuário já apertou algum botão no teclado

<img width="300" alt="image" src="https://github.com/user-attachments/assets/176d6943-3494-4dc4-8b4d-cbe16e5a1349">
<img width="300" alt="image" src="https://github.com/user-attachments/assets/ff68c9e2-b4b9-4e08-b79d-c37bbf82ac18">

- Ver_Coluna: verifica as colunas do telcado
  
   <img width="464" alt="Ver_coluna" src="https://github.com/user-attachments/assets/87d6c2ff-12b1-4474-973a-b01ede3ccc4b">
   
- Pegra_telca: ativa o bit F0 se um botão tiver sido apertado
  
  <img width="252" alt="Pegar_telca" src="https://github.com/user-attachments/assets/69684296-1b52-45da-8c68-e21c6b8ba65f">
  
- Delay: usa um decremento para garantir que subrotinas como Clear_Display funcionem sem erros
  
  <img width="210" alt="Delay" src="https://github.com/user-attachments/assets/318a3de5-e50f-41fd-99b1-0b8caebd9c61">

- Exibir_salgados: printa todos salgados e e seus preços
  
<img width="432" alt="Exibir_salgados" src="https://github.com/user-attachments/assets/f99129b3-d459-43f2-b324-562eaaaa6aef">
<img width="382" alt="Exibir_salgados" src="https://github.com/user-attachments/assets/5af00203-c495-4757-b49e-58bd839d616f">

- check_moeda1: verifica se a moeda é de 50 centavos usando CJNE entre A que contem a tecla precionada e B que contem o valor '1'. Se não for chama check_moeda2, e se for escreve na tela que o usuario depositou 50 centavos e move 50 para o r7 para que na main ocorra o acumulo dos valores depositados
  
  <img width="300" alt="check_moeda1" src="https://github.com/user-attachments/assets/61815318-b7e3-4e58-b17f-cc87d9db68c7">

- check_moeda2: verifica se a moeda é de 1 real usando CJNE entre A que contem a tecla precionada e B que contem o valor '2'. Se não for chama m_incorreta, e se for escreve na tela que o usuario depositou 1 real e move 100 para o r7 para que na main ocorra o acumulo dos valores depositados
  
  <img width="300" alt="check_moeda2" src="https://github.com/user-attachments/assets/ccd89e8d-a3fe-45b3-92bb-762c9d431662">

- m_incorreta: informa o usuario que o botão que ele pressionou não corresponde a uma moeda permitida e volta para o inicio do loop2 na main
  
  <img width="300" alt="m_incorreta" src="https://github.com/user-attachments/assets/082184ad-96a9-43eb-9a59-3348543fa605">

- maior_1: subrotina que verifica se o valor acumulado na hora do pagamento é maior que preço do salgado selecionado. Para isso o valor do preço do salgado é subtraido do valor acumulado com SUBB. Caso haja carry, ele vai para a subrotina menor, já que a existência de um carry indica que o valor acumulado é menor que o preço do salgado. Se o valor for maior que o preço ele move o restante da subtração para o R5 e move o preço do salgado para o acumulador A, para que o loop que recebe o pagamento pare na MAIN
  
  <img width="300" alt="maior_1" src="https://github.com/user-attachments/assets/aaffc551-ec45-4c0b-a6b5-2a7f024b0190">

- menor: subrotina que serve para restaurar o valor do acumulador A para o valor que ele possuiaantes da subtração feita na subrotina maior1

  <img width="300" alt="menor" src="https://github.com/user-attachments/assets/057ddd3c-9b6d-4166-a083-3506c15301f0">

- f_troco: subrotina que verifica com CJNE. Se R5 é diferente de 0, existe um valor de troco para devolver e a subrotina mostra_troco é chamada

  
  <img width="300" alt="f_troco" src="https://github.com/user-attachments/assets/a209f94f-7e28-4f68-90eb-1d50eb0ff8f2">
 
- mostra_troco: subrotina que mostra no LCD que o programa esta devolvendo o troco e chama a subrotina checa_troco1 para ver qual o valor do troco

  <img width="300" alt="mostra_troco" src="https://github.com/user-attachments/assets/e066a3cd-49a6-4a75-9b03-3f8d32713ed7">
  
- checa_troco1: subrotina que verifica se o valor no R5 é 100 indicando que o troco é 1 real. Se for ele imprime no LCD "1 real" e se não for ele chama a subrotina checa_troco2

  <img width="300" alt="checa_troco1" src="https://github.com/user-attachments/assets/95fb6e96-6f54-49d3-90b4-f8d9c12a6957">

- checa_troco2: subrotina que imprime no LCD "50 cents". Ela não faz nenhuma checagem já que o troco só pode ser 1 de 2 valores

  <img width="300" alt="checa_troco2" src="https://github.com/user-attachments/assets/55df1ef1-1f4b-4cd6-98ac-86a2cf2a1fd5">
- Move_S: O conjunto de subrotinas que move o motor para a posição relacionada ao salgado escolhido

  <img src = "https://github.com/user-attachments/assets/fc4d32fc-b4bc-4cf4-9626-e95cedb2d005" widht = "200" height ="300">
  <img src = "https://github.com/user-attachments/assets/4b85d0d8-0bb5-452f-8971-df2f647ec54d" widht = "200" height ="300">
  <br>
  <img src = "https://github.com/user-attachments/assets/fa22b72d-097a-447b-bbb1-1231301c3d9b" widht = "200" height ="300">
  <img src = "https://github.com/user-attachments/assets/4d8d2341-16f2-4589-9f74-2943efdcabfa" widht = "200" height ="300">

- Volta_motor: subrotina que retorna o motor para sua posição original

  <img src = "https://github.com/user-attachments/assets/d2371ebd-3513-42f1-b2aa-197c5d6d4741" widht = "200" height ="300">
  
  # MAIN:

  <img width="300" alt="main" src="https://github.com/user-attachments/assets/322d45c2-9172-4261-9296-b05a8148ff8e">
  <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/46a2ee17-b1a2-4e8f-b10f-73af44af8ec7">
   <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/94f4cd34-38ba-4096-9d5e-7a7328ac60c4">
   <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/9db02d3a-e4c3-48f4-ae54-fa4c8f410788">
  <br>  
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/8f95b855-1ad3-4c68-b292-cee4d78f3a47">
  <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/39f61181-3fcc-48c8-a885-6ac88649efea">
  <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/57e85b08-b331-4463-8fdc-16bc7f9ebc6c">
  <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/69aad382-b462-4dae-aa21-c08863caf5df">
  <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/f0f81c59-db69-4510-ac05-0f4a004d6576">
  <br>
  <img width="300" alt="main" src="https://github.com/user-attachments/assets/f0b36739-b2d0-4127-b4ff-20a0e47288f7">







   

  

