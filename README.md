# <p align="center">Maquina-de-salgados</p> 
> Um programa codificado em assembly para o simulador Edsim51 que busca implementar o funcionamento de uma maquina de venda de salgadinhos. O programa inicia com uma mensagem mostrando as opções de salgado juntamente com o prçeo de cada um e qual botão deve ser  pressionado para selecionar cada salgadinho. Por meio do teclado, o usuário seleciona entre 4 opções: S1(botão 1 do telcado), S2(botão 2 do telcado), S3(botão 3 do telcado) e S4(botão 4 do telcado). Caso qualquer outro botão tenha sido apertado, a máquina irá aprentar uma mensagem dizendo que essa opção é invalida e o programa repetirá o processo até que uma opção válida tenha sido selecionada.<br><br>Depois de selecionar uma opção válida, uma mensagem irá aparecer indicando quais botões devem ser pressionados para executar o pagamento, que será por moedas de 50 centavos e 100 centavos(1 real). Qualquer outro botão pressionado não irá afetar em nada o programa. A medida que os botões coreespondentes a 50 centavos e 1 real forem pressionados uma mensagem irá aparecer dizendo qual moeda foi inserida na maquina. O código só irá para quando o valor pago for maior ou igual ao valor do salgado. Caso o valor seja maior, uma mensagem será exibida dizendo qual será o troco que será exibido.<br><br>Por fim, haverá uma mensagem avisando que o salgadinho "X" será dispejado da máquina e assim o programa finaliza.
 

# Configurações antes de começar: 

- Frequência 100 Hz e teclado no modo pulse
<br>
<img src="https://github.com/user-attachments/assets/705fdca7-ca06-44d2-831e-9fa6db83bbae" alt="Configurações para o funcionamento do projeto" width="300">

- Iniciar o teclado: cada endereço recebe um determinado caracter
<br>
<img src = "https://github.com/user-attachments/assets/13f0cef9-26eb-4ae7-a0a9-77556577c777" alt="Iniciar o teclado" widht = "300" >

# Textos usados na Main
<br>
<img src = "https://github.com/user-attachments/assets/dee91e10-68d1-49f6-a1c3-473c68cf574f" alt="Textos usados na main" widht = "200" >
<img src = "https://github.com/user-attachments/assets/93040cf0-9681-4690-93ac-2a963ee3f911" alt="Textos usados na main" widht = "200" >
<img src = "https://github.com/user-attachments/assets/6f00a73d-6ff8-419e-b6d5-322d47a1e9c3" alt="Textos usados na main" widht = "200" >
<img src = "https://github.com/user-attachments/assets/08485c0e-1a75-4117-a816-2c54a535f988" alt="Textos usados na main" widht = "200" >

# Funções
- Check_input: testa qual salgado foi escolhido. Primeiro testa se o salgado escolhido foi S1(Check_input1), e se não foi chama "Check_input2". Caso S2 não seja escolhido, "Check_input3" é chamado, e caso S3 não tenha sido escolhido, "Check_input4" é chamdo. Caso S4 não tenha sido escolhido, a função "incorreto" é chamada.
  
  <img src = "https://github.com/user-attachments/assets/d9ae74a5-a05a-46fc-b0ec-949eadcec6cd" alt="Função check input" widht = "200" >
  
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

- 



   

  

