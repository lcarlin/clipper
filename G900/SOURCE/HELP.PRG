parameters prog, lin, var
private a, pr
store 0 to a, pr
if prog = 'HELP'
   return
endif
save screen
set color to gr+/r
do case
   case prog = 'SERIE900'
      do case
         case hlpcmd = 1
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'Este programa ‚ distribuido    ' 
            @ 8, 48 say 'gratuitamente com as m quinas  ' 
            @ 9, 48 say 'GENERAL modelo da s‚rie 900.   ' 
            @ 10, 48 say 'Portanto seu uso e restrito    ' 
            @ 11, 48 say 'para as maquinas GENERAL da    ' 
            @ 12, 48 say 'serie 900.                     ' 
            @ 13, 48 say '                               ' 
            @ 14, 48 say '    TECLAS DE MOVIMENTACAO     ' 
            @ 15, 48 say '   <--     Mov. para esquerda  ' 
            @ 16, 48 say '   -->     Mov. para direira   ' 
            @ 17, 48 say 'SETA CIMA  Mov. para cima/esq  ' 
            @ 18, 48 say 'SETA BAIXO Mov. para baixo/dir ' 
            @ 19, 48 say '[ENTER]    Confirma a opcao    ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)
      endcase
   case prog = 'G91VAR'
      do case
         case var = 'MEM_TEMPO'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'Durante a execucao do programa ' 
            @ 8, 48 say 'aparecer  certas mensagens na  ' 
            @ 9, 48 say 'tela por um tempo. Por exemplo:' 
            @ 10, 48 say 'Codigo nao esta cadastrado !!  ' 
            @ 11, 48 say '                               ' 
            @ 12, 48 say 'Esta variavel determina o tempo' 
            @ 13, 48 say 'que esta mensagem ficara na    ' 
            @ 14, 48 say 'tela.                          ' 
            @ 15, 48 say 'O numero dependera do equipam. ' 
            @ 16, 48 say 'que se esta utilizando. Para o ' 
            @ 17, 48 say 'micro PENTIUM dever  ser em    ' 
            @ 18, 48 say 'torno de 500                   ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)
         case var = 'MEM_PORT'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'Determina em que porta de comu-' 
            @ 8, 48 say 'nicacao serial esta ligado o   ' 
            @ 9, 48 say 'sistema SERIE 900.             ' 
            @ 10, 48 say '                               ' 
            @ 11, 48 say 'Digite <1> para selecionar COM1' 
            @ 12, 48 say '                               ' 
            @ 13, 48 say 'Digite <2> para selecionar COM2' 
            @ 14, 48 say '                               ' 
            @ 15, 48 say '                               ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)

         case var = 'MEM_COND'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'E o caracter de controle para a' 
            @ 8, 48 say 'impressora para que os caracte-' 
            @ 9, 48 say 'res enviados a seguir sejam im-' 
            @ 10, 48 say 'pressos no modo condensado em  ' 
            @ 11, 48 say '16,7 cpp                       ' 
            @ 12, 48 say '                               ' 
            @ 13, 48 say 'Em quase todas as impressoras  ' 
            @ 14, 48 say 'este caracter devera ser 15    ' 
            @ 15, 48 say '                               ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)

         case var = 'MEM_NORM'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'E o caracter de controle para a' 
            @ 8, 48 say 'impressora para que os caracte-' 
            @ 9, 48 say 'res enviados a seguir sejam im-' 
            @ 10, 48 say 'pressos no modo normal em 10cpp' 
            @ 11, 48 say '                               ' 
            @ 12, 48 say '                               ' 
            @ 13, 48 say 'Em quase todas as impressoras  ' 
            @ 14, 48 say 'este caracter devera ser 18    ' 
            @ 15, 48 say '                               ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)

         case var = 'MEM_EXP'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'E o caracter de controle para a' 
            @ 8, 48 say 'impressora para que os caracte-' 
            @ 9, 48 say 'res enviados a seguir sejam im-' 
            @ 10, 48 say 'pressos no modo expandido ate o' 
            @ 11, 48 say 'final da linha.                ' 
            @ 12, 48 say '                               ' 
            @ 13, 48 say 'Em quase todas as impressoras  ' 
            @ 14, 48 say 'este caracter devera ser 14    ' 
            @ 15, 48 say '                               ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)

         case var = 'MEM_ETIQ'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'Para as etiquetas de gondola,  ' 
            @ 8, 48 say 'sao utilizados caracteres maio-' 
            @ 9, 48 say 'res,possibilitando melhor visu-' 
            @ 10, 48 say 'alizacao do preco de cada pro- ' 
            @ 11, 48 say 'duto.                          ' 
            @ 12, 48 say 'Esta variavel padrao deve ser  ' 
            @ 13, 48 say '219. Pode ser testado outros   ' 
            @ 14, 48 say 'numeros e escolher a que melhor' 
            @ 15, 48 say 'se adaptar ao seu uso          ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)

         case var = 'MEM_COL'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'Este numero depende da etiqueta' 
            @ 8, 48 say 'de gondola que sera utilizado, ' 
            @ 9, 48 say 'ou seja, com uma ou duas colu- ' 
            @ 10, 48 say 'nas.                           ' 
            @ 11, 48 say 'O tamanho da etiqueta devera   ' 
            @ 12, 48 say 'ser de 102x23,4                ' 
            @ 13, 48 say '                               ' 
            @ 14, 48 say '                               ' 
            @ 15, 48 say '                               ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)

         case var = 'MEM_EMPR'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'E o nome da sua empresa ou o   ' 
            @ 8, 48 say 'nome do usuario do programa    ' 
            @ 9, 48 say 'Esta variavel aparecera em     ' 
            @ 10, 48 say 'todos os relatorios emitidos   ' 
            @ 11, 48 say 'pelo programa. Caso nao queira ' 
            @ 12, 48 say 'que apareca o nome, deixar em  ' 
            @ 13, 48 say 'branco                         ' 
            @ 14, 48 say '                               ' 
            @ 15, 48 say '                               ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)
         case var = 'MEM_FANT'
            @ 6, 47, 21, 79 box frame2
            @ 7, 48 say 'E o nome da sua empresa ou o   ' 
            @ 8, 48 say 'nome do usuario do programa.   ' 
            @ 9, 48 say 'Esta variavel aparecera na     ' 
            @ 10, 48 say 'tela do micro na parte central ' 
            @ 11, 48 say 'superior e na parte inferior a ' 
            @ 12, 48 say 'direita. Uma vez alterado esta ' 
            @ 13, 48 say 'variavel, somente aparecera na ' 
            @ 14, 48 say 'tela apossair do programa e re-' 
            @ 15, 48 say 'entrar novamente.              ' 
            @ 16, 48 say '                               ' 
            @ 17, 48 say '                               ' 
            @ 18, 48 say '                               ' 
            @ 19, 48 say '                               ' 
            @ 20, 48 say ' Digite uma tecla p/ continuar ' 

            inkey (0)
      endcase
   case prog = 'SENHA'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digite a senha em letra maius- ' 
      @ 8, 48 say 'cula. A senha pode ser modifi- ' 
      @ 9, 48 say 'cada atraves do menu cadastro  ' 
      @ 10, 48 say 'de variaveis.                  ' 
      @ 11, 48 say 'Voce ter  3 chances para acer- ' 
      @ 12, 48 say 'tar a senha.                   ' 
      @ 13, 48 say 'Caso nÆo acerte em 3 tentativas' 
      @ 14, 48 say 'o programa voltar  ao prompt do' 
      @ 15, 48 say 'DOS.                           ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91IMPO' .and. var = 'ESC_MAQ' .or. prog = 'G91EXPO' .and. var = 'ESC_MAQ'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digite <S> para que possa esco-' 
      @ 8, 48 say 'lher numeros especificos das   ' 
      @ 9, 48 say 'maquinas que deseja comunicar. ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say 'Digite <N> para que o programa ' 
      @ 12, 48 say 'busque as maquinas presentes e ' 
      @ 13, 48 say 'ativas no sistema.             ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91IMPO' .and. var = 'NUM_MAQ' .or. prog = 'G91EXPO' .and. var = 'NUM_MAQ'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digite <S> para que possa esco-' 
      @ 8, 48 say 'lher numeros especificos das   ' 
      @ 9, 48 say 'maquinas que deseja comunicar. ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say 'Digite <N> para que o programa ' 
      @ 12, 48 say 'use os numeros das maquinas que' 
      @ 13, 48 say 'foram escolhidas na ultima co- ' 
      @ 14, 48 say 'municacao                      ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91IMPO' .and. var = 'MACH' .or. prog = 'G91EXPO' .and. var = 'MACH'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digite o numero da maquina espe' 
      @ 8, 48 say 'cifica que deseja comunicar.   ' 
      @ 9, 48 say 'O numero de maquinas que pode- ' 
      @ 10, 48 say 'rao ser conectado a rede e de  ' 
      @ 11, 48 say 'no maximo 32 maquinas.         ' 
      @ 12, 48 say 'As maquinas de numeros 01 a 09 ' 
      @ 13, 48 say 'devem obrigatoriamente entrar  ' 
      @ 14, 48 say 'com 0 a esquerda.              ' 
      @ 15, 48 say 'Para terminar digite <ENTER> ou' 
      @ 16, 48 say 'a tecla <ESC> sem a entrada do ' 
      @ 17, 48 say 'numero.                        ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)

   case prog = 'G91IMPO' .and. hlpcmd = 1
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Nesta opcao serao lidos os da- ' 
      @ 8, 48 say 'dos de venda da caixa registra-' 
      @ 9, 48 say 'dora. Serao criados os seguin- ' 
      @ 10, 48 say 'tes arquivos:                  ' 
      @ 11, 48 say 'VDDMMMAA.DBF-Venda de PLU      ' 
      @ 12, 48 say 'DDDMMMAA.DBF-Venda de Departam.' 
      @ 13, 48 say 'ODDMMMAA.DBF-Venda dos Operad. ' 
      @ 14, 48 say 'DD-Refere-se ao dia            ' 
      @ 15, 48 say 'MMM-Refere-se ao mes           ' 
      @ 16, 48 say 'AA-Refere-se ao ano            ' 
      @ 17, 48 say 'Portanto entre com a data cor- ' 
      @ 18, 48 say 'reta a que se refere o movimen-' 
      @ 19, 48 say 'to.                            ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'CONFIRME' .and. hlpcmd = 2
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Se responder com <S> Sim, os   ' 
      @ 8, 48 say 'dados de venda acumulados do   ' 
      @ 9, 48 say 'mes somam-se aos dados lidos   ' 
      @ 10, 48 say 'da caixa registradora.         ' 
      @ 11, 48 say 'Portanto devera ser lido uma   ' 
      @ 12, 48 say 'unica vez no fechamento dos    ' 
      @ 13, 48 say 'caixas.                        ' 
      @ 14, 48 say 'Poder  ser lido mais que uma   ' 
      @ 15, 48 say 'vez, desde que responda <N> Nao' 
      @ 16, 48 say 'a esta pergunta                ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'CONFIRME' .and. hlpcmd = 3
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Se responder com <S> Sim,      ' 
      @ 8, 48 say 'sera pedido a senha atual.     ' 
      @ 9, 48 say 'Digite a senha atual. Logo a   ' 
      @ 10, 48 say 'seguir sera pedido a nova senha' 
      @ 11, 48 say 'Apos digitar a nova senha pede-' 
      @ 12, 48 say 'se a reconfirmacao da mesma.   ' 
      @ 13, 48 say 'Caso responda <N> NÆo, o progr.' 
      @ 14, 48 say 'salvara as variaveis anteriores' 
      @ 15, 48 say 'e voltara para o menu anterior ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PROD' .and. var = 'V_TIPO'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Devera ser escolhido entre:    ' 
      @ 8, 48 say 'N - Codigo numerico            ' 
      @ 9, 48 say 'B - Codigo de barras           ' 
      @ 10, 48 say 'A diferenca esta no digito de  ' 
      @ 11, 48 say 'controle, que tem quando e cod.' 
      @ 12, 48 say 'de barras e nao quando e numer.' 
      @ 13, 48 say 'Quando escolhido Barras o cod. ' 
      @ 14, 48 say 'podera ser entrado pelo Scanner' 
      @ 15, 48 say 'para teclado                   ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PROD' .and. var = 'V_DESC_ET1' .or. var = 'V_DESC_ET2'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Ser  a descricao que aparecera ' 
      @ 8, 48 say 'quando da emissao da etiqueta  ' 
      @ 9, 48 say 'para a gondola                 ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say '                               ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say '                               ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PROD' .and. var = 'V_DESC_MAQ'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Ser  a descricao que aparecera ' 
      @ 8, 48 say 'quando do registro do codigo   ' 
      @ 9, 48 say 'na caixa registradora.         ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say 'Por economia de bobina de papel' 
      @ 12, 48 say 'esta descricao devera ser o    ' 
      @ 13, 48 say 'mais abreviado possivel, pois  ' 
      @ 14, 48 say 'se for extenso, ira imprimir em' 
      @ 15, 48 say 'duas linhas.                   ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PROD' .and. var = 'V_DEPTO_C'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say "Para todas as PLU's dever      " 
      @ 8, 48 say 'necessariamente ser conectado a' 
      @ 9, 48 say 'um departamento, para que seja ' 
      @ 10, 48 say 'possivel fazer o registo na    ' 
      @ 11, 48 say 'caixa registradora             ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say 'Para podermos cadastrar o codig' 
      @ 14, 48 say 'do departamento, e necessario  ' 
      @ 15, 48 say 'fazer antes o cadastro do depar' 
      @ 16, 48 say 'tamento, na opcao:             ' 
      @ 17, 48 say 'CADASTRO->DEPTO                ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PROD' .and. var = 'V_ETIQUETA'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Responder <S> se caso queira   ' 
      @ 8, 48 say 'emitir etiqueta para gondola   ' 
      @ 9, 48 say 'Responder <N> se nao quiser    ' 
      @ 10, 48 say 'emitir etiqueta para gondola   ' 
      @ 11, 48 say '                               ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say '                               ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PROD' .and. var = 'V_COMUNICA'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Responder <S>  caso queira     ' 
      @ 8, 48 say 'transmitir este produto para   ' 
      @ 9, 48 say 'a caixa registradora           ' 
      @ 10, 48 say 'Responder <N> se nao quiser    ' 
      @ 11, 48 say 'transmitir este produto para   ' 
      @ 12, 48 say 'a caixa registradora           ' 
      @ 13, 48 say '                               ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PROD' .and. var = 'V_BALANCA'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Responder <S>  caso esteja     ' 
      @ 8, 48 say 'utilizando balanca com codigo  ' 
      @ 9, 48 say 'de barras para registrar este  ' 
      @ 10, 48 say 'produto                        ' 
      @ 11, 48 say 'Responder <N>  caso nao se     ' 
      @ 12, 48 say 'enquadrar na descricao acima   ' 
      @ 13, 48 say '                               ' 
      @ 14, 48 say 'Se estiver utilizando a balanca' 
      @ 15, 48 say 'conectada diretamente na caixa ' 
      @ 16, 48 say 'registradora digite <N>        ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91DEPT' .and. var = 'V_CODIGO'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Devera ser digitado um c¢digo  ' 
      @ 8, 48 say 'entre 01 a 24 para o modelo de ' 
      @ 9, 48 say 'caixa registradora G-910       ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say 'Para o codigo de 01 a 09, neces' 
      @ 12, 48 say 'sariamente deve entrar com 0 na' 
      @ 13, 48 say 'casa da dezena.                ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91DEPT' .and. var = 'V_DESCRI'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Na descricao do departamento   ' 
      @ 8, 48 say 'os tres primeiros caracteres   ' 
      @ 9, 48 say 'referem-se a aliquota dos pro- ' 
      @ 10, 48 say 'dutos conectados a este depar- ' 
      @ 11, 48 say 'tamento. Os demais podem ser   ' 
      @ 12, 48 say 'usados para descrever o depart.' 
      @ 13, 48 say 'Pela Legislacao os primeiros 3 ' 
      @ 14, 48 say 'caracteres deverao ser:        ' 
      @ 15, 48 say 'I-Isento                       ' 
      @ 16, 48 say 'F-Substituicao tributaria      ' 
      @ 17, 48 say 'N-NÆo incidencia               ' 
      @ 18, 48 say 'Tnn-Tributado com aliquota nn  ' 
      @ 19, 48 say '    ex. T18=Aliquota 18%       ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91CONS' .and. var = 'N_CODIGO12' .or. prog = 'G91ENTR' .and. var = 'N_CODIGO12' .or. prog = 'G91SAID' .and. var = 'N_CODIGO12'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digite o codigo do produto com ' 
      @ 8, 48 say 'o respectivo digito de controle' 
      @ 9, 48 say '                               ' 
      @ 10, 48 say 'Caso queira procurar por descri' 
      @ 11, 48 say 'cao do produto, deixe o codigo ' 
      @ 12, 48 say 'em branco, simplesmente digitan' 
      @ 13, 48 say 'do <ENTER>                     ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91CONS' .and. var = 'N_DESCRIC' .or. prog = 'G91ENTR' .and. var = 'N_DESCRIC' .or. prog = 'G91SAID' .and. var = 'N_DESCRIC'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digite a descricao do produto  ' 
      @ 8, 48 say 'o mais detalhado possivel.     ' 
      @ 9, 48 say 'Quanto mais detalhado,mais pro-' 
      @ 10, 48 say 'ximo do produto ira chegar.    ' 
      @ 11, 48 say '                               ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say 'Caso ocorra a coincidencia, ira' 
      @ 14, 48 say 'mostrar na tela o codigo e a   ' 
      @ 15, 48 say 'descricao do produto. Com as   ' 
      @ 16, 48 say 'tecla PgUp e PgDn pode-se sele-' 
      @ 17, 48 say 'cionar registros e quando en-  ' 
      @ 18, 48 say 'contrados, digite <ENTER>      ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PRODR' .and. var = 'V_IND'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Selecionar em que ordem sera   ' 
      @ 8, 48 say 'apresentado a sequencia do     ' 
      @ 9, 48 say 'relatorio.                     ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say '1-Sequencia de codigo EAN      ' 
      @ 12, 48 say '2-Sequencia de codigo interno  ' 
      @ 13, 48 say '3-Sequencia de descricao prod. ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PRODR' .and. var = 'V_EST'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digitar <S> se quiser somente o' 
      @ 8, 48 say 'relatorio   dos produtos que   ' 
      @ 9, 48 say 'estao abaixo do estoque minimo.' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say 'Digitar <N> se quiser o relato-' 
      @ 12, 48 say 'rio independente do estoque    ' 
      @ 13, 48 say 'minimo.                        ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PRODR' .and. var = 'V_GRUPO' .or. prog = 'G91VDIAR' .and. var = 'V_GRUPO' .or. prog = 'G91VACU' .and. var = 'V_GRUPO' .or. prog = 'G91VDET' .and. var = 'V_GRUPO'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Para tirar o relatorio de um   ' 
      @ 8, 48 say 'grupo especifico, digitar um   ' 
      @ 9, 48 say 'numero entre 01 a 99.          ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say 'Caso nao queira de um grupo es-' 
      @ 12, 48 say 'pecifico, digitar somente      ' 
      @ 13, 48 say '<ENTER>, deixando em branco    ' 
      @ 14, 48 say 'este campo.                    ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91PRODR' .and. var = 'V_ALT'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digitar <S> se desejar imprimir' 
      @ 8, 48 say 'somente os produtos que tiveram' 
      @ 9, 48 say 'alteracao de preco. Os precos  ' 
      @ 10, 48 say 'sao alterados na opcao<ENTRADA>' 
      @ 11, 48 say 'ou no cadastro de produto.     ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say 'Digitar <N> se desejar imprimir' 
      @ 14, 48 say 'independente do produto ter    ' 
      @ 15, 48 say 'sido alterado.                 ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91GOND' .and. var = 'V_OPC'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digitar o numero escolhido 1-5.' 
      @ 8, 48 say '1-Todos que no cadastro foi ca-' 
      @ 9, 48 say '  dastrado como ETIQUETA=<S>   ' 
      @ 10, 48 say '2-Escolha de intervalo de cod. ' 
      @ 11, 48 say '  Sera pedido os dois intervalo' 
      @ 12, 48 say '3-Escolha dos codigos que serao' 
      @ 13, 48 say '  impressos.                   ' 
      @ 14, 48 say '4-Sera pedido o numero do grupo' 
      @ 15, 48 say '5-Todos que tiveram alteracao  ' 
      @ 16, 48 say '  de preco.                    ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91GOND' .and. var = 'N_CODIGO12'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Digite o codigo que deseja que ' 
      @ 8, 48 say 'saia impresso a etiqueta para  ' 
      @ 9, 48 say 'gondola.                       ' 
      @ 10, 48 say '                               ' 
      @ 11, 48 say 'Para encerrar a escolha, digite' 
      @ 12, 48 say 'a tecla <ESC> ou digite <ENTER>' 
      @ 13, 48 say 'com o codigo em 0.             ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'CONFIRME' .and. hlpcmd = 4
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Se deseja tirar o relatorio dos' 
      @ 8, 48 say 'produtos com precos alterados, ' 
      @ 9, 48 say 'ou tirar outra copia de etiquet' 
      @ 10, 48 say 'para gondola, digitar <N>      ' 
      @ 11, 48 say '                               ' 
      @ 12, 48 say 'Caso contrario digitar <S> que ' 
      @ 13, 48 say 'sera desmarcado como produto   ' 
      @ 14, 48 say 'com preco alterado             ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91VMOVI' .and. var = 'V_TIPO'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Escolher o tipo de relatorio de' 
      @ 8, 48 say 'movimento que se deseja.       ' 
      @ 9, 48 say 'V-Relatorio de venda           ' 
      @ 10, 48 say 'C-Relatorio de compra          ' 
      @ 11, 48 say 'E-Relatorio de entrada p/acerto' 
      @ 12, 48 say 'S-Relatorio de saida p/ acerto ' 
      @ 13, 48 say 'M-Relatorio de venda pela caixa' 
      @ 14, 48 say '  registradora                 ' 
      @ 15, 48 say 'Se desejar de todos, deixar em ' 
      @ 16, 48 say 'branco.                        ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91VMOVI' .and. var = 'N_CODIGO'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Caso queira de um codigo espe- ' 
      @ 8, 48 say 'cifico,digitar o c¢digo deseja-' 
      @ 9, 48 say 'do.                            ' 
      @ 10, 48 say 'Caso contrario, deixar em bran-' 
      @ 11, 48 say 'co.                            ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say '                               ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91VMOVI' .and. var = 'V_GRUPO'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Caso queira de um grupo especi-' 
      @ 8, 48 say 'fico, digitar o numero do grupo' 
      @ 9, 48 say '                               ' 
      @ 10, 48 say 'Caso contrario, deixar em bran-' 
      @ 11, 48 say 'co                             ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say '                               ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91DEPR' .and. var = 'V_DIA' .or. prog = 'G91VOPE' .and. var = 'V_DIA'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Se escolhido:                  ' 
      @ 8, 48 say 'D-Diario. Apos esta opcao sera ' 
      @ 9, 48 say '  pedido a data especifica.    ' 
      @ 10, 48 say 'M-Mensal. Esta opcao refere-se ' 
      @ 11, 48 say '  a um mes/ano ja fechada.     ' 
      @ 12, 48 say 'C-Corrente.  Refere-se ao rela-' 
      @ 13, 48 say '  torio acumulado do mes que   ' 
      @ 14, 48 say '  esta em curso.               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91FECH' .and. var = 'MESANO'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Muito cuidado ao executar esta ' 
      @ 8, 48 say 'opcao. pois ira zerar o movimen' 
      @ 9, 48 say 'to do mes corrente, e criara os' 
      @ 10, 48 say 'seguintes arquivos:            ' 
      @ 11, 48 say 'PLUMMMAA-Arquivo de produtos   ' 
      @ 12, 48 say 'MOVMMMAA-Arquivo de movimento  ' 
      @ 13, 48 say 'DEPMMMAA-Arquivo de departam.  ' 
      @ 14, 48 say 'OPEMMMAA-Arquivo de operadores ' 
      @ 15, 48 say '-------------------------------' 
      @ 16, 48 say 'MMM-Mes   AA-Ano               ' 
      @ 17, 48 say 'Recomenda-se tirar uma copia   ' 
      @ 18, 48 say 'destes arquivos e guardar em   ' 
      @ 19, 48 say 'local seguro.                  ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91FECH' .and. var = 'V_RESP'
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'O programa encontrou arquivos  ' 
      @ 8, 48 say 'de fechamento do mes/ano que   ' 
      @ 9, 48 say 'foi criado anteriormente.      ' 
      @ 10, 48 say 'Caso responda <S> o arquivo an-' 
      @ 11, 48 say 'teriormente gerado sera zerado ' 
      @ 12, 48 say 'e sobreposto os novos dados.   ' 
      @ 13, 48 say 'Caso responda <N> sera mantido ' 
      @ 14, 48 say 'o arquivo anterior e abortara o' 
      @ 15, 48 say 'processo de fechamento do mes. ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)
   case prog = 'G91IND' .and. var = 'V_OPC'
      @ 6, 47, 21, 79 box frame2
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Esta opcao deve ser executada: ' 
      @ 8, 48 say 'Toda vez que ocorrer alguma    ' 
      @ 9, 48 say 'anomalia.                      ' 
      @ 10, 48 say 'Todas as vezes que ocorrer al- ' 
      @ 11, 48 say 'gum erro e sair do programa, ou' 
      @ 12, 48 say 'por causa de uma interrupcao de' 
      @ 13, 48 say 'energia eletrica,terminando o  ' 
      @ 14, 48 say 'programa abruptamente.         ' 
      @ 15, 48 say 'Todas as vezes que acessar os  ' 
      @ 16, 48 say 'bancos de dados por um outro   ' 
      @ 17, 48 say 'programa, como o DBASE.        ' 
      @ 18, 48 say 'Pode tambem ser executado inde-' 
      @ 19, 48 say 'pendente dos problemas acima.  ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)

   case prog = 'G91GRUP' .and. var = 'V_CODGRUPO'
      @ 6, 47, 21, 79 box frame2
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'O grupo deve ser entrado para  ' 
      @ 8, 48 say 'os numeros 01 a 09 com o zero  ' 
      @ 9, 48 say 'a esquerda.                    ' 
      @ 10, 48 say 'Os grupos podem ser entrados   ' 
      @ 11, 48 say 'com os numeros entre 01 a 99.  ' 
      @ 12, 48 say 'A separacao por grupo facilita ' 
      @ 13, 48 say 'para que possa separar os diver' 
      @ 14, 48 say 'sos setores da loja. por ex.   ' 
      @ 15, 48 say 'Grupo 01-Carnes                ' 
      @ 16, 48 say 'Grupo 10-Enlatados             ' 
      @ 17, 48 say 'Grupo 30-Padaria               ' 
      @ 18, 48 say 'Grupo 40-Bebidas nao alcoolicas' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)

   case prog = 'G91VDET' .and. var = 'N_CODIGO'
      @ 6, 47, 21, 79 box frame2
      @ 6, 47, 21, 79 box frame2
      @ 7, 48 say 'Caso queira de um codigo de    ' 
      @ 8, 48 say 'produto especifico, digite o   ' 
      @ 9, 48 say 'codigo com o check digito.     ' 
      @ 10, 48 say 'Digite simplesmente <ENTER> se ' 
      @ 11, 48 say 'quiser de todos os codigos.    ' 
      @ 12, 48 say '                               ' 
      @ 13, 48 say '                               ' 
      @ 14, 48 say '                               ' 
      @ 15, 48 say '                               ' 
      @ 16, 48 say '                               ' 
      @ 17, 48 say '                               ' 
      @ 18, 48 say '                               ' 
      @ 19, 48 say '                               ' 
      @ 20, 48 say ' Digite uma tecla p/ continuar ' 

      inkey (0)

endcase
set color to &padrao
restore screen
return
