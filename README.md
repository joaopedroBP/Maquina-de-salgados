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
<img src = "https://github.com/user-attachments/assets/d9ae74a5-a05a-46fc-b0ec-949eadcec6cd" alt="Textos usados na main" widht = "200" >
