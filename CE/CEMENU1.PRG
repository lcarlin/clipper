#include "common.ch"
#include "inkey.ch"

********************************

   public linha:= Row()
   public coluna:= Col()
   public tela_dos
   public data_sis:= Date()
   save screen to tela_dos
   ? 
   ? "Aguarde!!  Carregando o Sistema"
/*
   if (Date() >= CToD("02/28/96"))
      ? "CA-CLIPPER 5.2   Warning Message:"
      ? "Self-Destruction Sequence Initiated"
      ? " Eddie lives. There is life after death"

      use CEBCLI
      zap
      close databases
      select 1
      close format

      use CEBFOR
      zap
      close databases
      select 1
      close format

      use CEBEST
      zap
      close databases
      select 1
      close format

      use CEBLMC
      zap
      close databases
      select 1
      close format

      use CEBLANCA
      zap
      close databases
      select 1
      close format

      use CEBMEST
      zap
      close databases
      select 1
      close format

      use CEBAGEN
      zap
      close databases
      select 1
      close format

      use CEBORC
      zap
      close databases
      select 1
      close format

      use CEBPRE
      zap
      close databases
      select 1
      close format

      use CEBCOM
      zap
      close databases
      select 1
      close format

      use CEBFUN
      zap
      close databases
      select 1
      close format

      use CEBPED
      zap
      close databases
      select 1
      close format

      use CEBCUS
      zap
      close databases
      select 1
      close format

      conteudo:= "Í"
      erase ce.exe
      numero:= fcreate("CE.EXE", 0)
      numero1:= fwrite(numero, conteudo)
      erase C:\_CONTROL.LOG
      clear screen
      quit
   endif
*/
   arquivo:= memoread("C:\_CONTROL.LOG")
   if (Empty(arquivo) .OR. arquivo != ;
         "CS # 1995 Controle de Estoque v1.0 - L.A.C. - {O Corsario(tm)}")
      ? 
      ? "Copia Ilegal !!! Acesso nao Permitido"
      ? 
      quit
   endif
   existe:= .T.
   if (!file("CEBCLI.DBF") .OR. !file("CEBCLI.DBT"))
      ? "Criando arquivo de clientes"
      aestru:= {{"CODIGO    ", "C", 6, 0}, {"NOME      ", "C", 40, ;
         0}, {"RG        ", "C", 20, 0}, {"ENDERECO  ", "C", 40, 0}, ;
         {"TELEFONE  ", "C", 15, 0}, {"CEP       ", "C", 9, 0}, ;
         {"ESTADO    ", "C", 2, 0}, {"INSC      ", "C", 20, 0}, ;
         {"OBS       ", "M", 10, 0}, {"CPF       ", "C", 20, 0}, ;
         {"CIDADE    ", "C", 30, 0}}
      dbcreate("CEBCLI", aestru)
   endif
   if (!file("CEBFOR.DBF") .OR. !file("CEBFOR.DBT"))
      ? "Criando arquivo de fornecedores"
      aestru:= {{"CODIGO    ", "C", 6, 0}, {"NOME      ", "C", 40, ;
         0}, {"RG        ", "C", 20, 0}, {"ENDERECO  ", "C", 40, 0}, ;
         {"TELEFONE  ", "C", 15, 0}, {"CEP       ", "C", 9, 0}, ;
         {"ESTADO    ", "C", 2, 0}, {"INSC      ", "C", 20, 0}, ;
         {"ITEM      ", "M", 10, 0}, {"CIDADE    ", "C", 30, 0}, ;
         {"CPF       ", "C", 20, 0}, {"EMPRESA   ", "C", 30, 0}}
      dbcreate("CEBFOR", aestru)
   endif
   if (!file("CEBFUN.DBF") .OR. !file("CEBFUN.DBT"))
      ? "Criando arquivo de funcionarios"
      aestru:= {{"CODIGO    ", "C", 6, 0}, {"NOME      ", "C", 40, ;
         0}, {"RG        ", "C", 20, 0}, {"ENDERECO  ", "C", 40, 0}, ;
         {"TELEFONE  ", "C", 15, 0}, {"CEP       ", "C", 9, 0}, ;
         {"ESTADO    ", "C", 2, 0}, {"CARGO     ", "C", 20, 0}, ;
         {"OBS       ", "M", 10, 0}, {"CPF       ", "C", 20, 0}, ;
         {"NASC      ", "D", 8, 0}, {"CIDADE    ", "C", 30, 0}}
      dbcreate("CEBFUN", aestru)
   endif
   if (!file("CEBEST.DBF"))
      ? "Criando arquivo de Estoques"
      aestru:= {{"CODIGO    ", "C", 6, 0}, {"PRODUTO   ", "C", 40, ;
         0}, {"COD_PES   ", "C", 6, 0}, {"PESSOA    ", "C", 40, 0}, ;
         {"EMBALAGEM ", "C", 25, 0}, {"VALUNIT   ", "N", 10, 2}, ;
         {"QTD       ", "N", 4, 0}, {"QTDMIN    ", "N", 3, 0}, ;
         {"VALUNITV  ", "N", 10, 2}, {"MARCADO   ", "C", 1, 0}}
      dbcreate("CEBEST", aestru)
   endif
   if (!file("CEBpre.DBF"))
      ? "Criando arquivo PREMIX"
      aestru:= {{"CODIGO    ", "C", 6, 0}, {"PRODUTO   ", "C", 40, ;
         0}, {"VALUNIT   ", "N", 10, 2}, {"VALUNITV  ", "N", 10, 2}, ;
         {"MARCADO   ", "C", 1, 0}}
      dbcreate("CEBpre", aestru)
   endif
   if (!file("CEBcom.DBF"))
      ? "Criando arquivo de comissoes"
      aestru:= {{"PED       ", "N", 6, 0}, {"PRODUTO   ", "C", 40, ;
         0}, {"VALUNIT   ", "N", 10, 2}, {"VALUNITV  ", "N", 10, 2}, ;
         {"DESCONTO  ", "N", 10, 2}, {"LUCRO_UNIT", "N", 10, 2}, ;
         {"MARCADO   ", "C", 1, 0}}
      dbcreate("CEBcom", aestru)
   endif
   if (!file("CEBLMC.DBF"))
      ? "Criando arquivo de Lancamentos mensais do caixa"
      aestru:= {{"DESCRICAO ", "C", 40, 0}, {"VALOR     ", "N", 10, ;
         2}, {"DATA      ", "D", 8, 0}, {"TIPO      ", "C", 1, 0}}
      dbcreate("CEBLMC", aestru)
   endif
   if (!file("CEBcus.DBF"))
      ? "Criando arquivo de Custos"
      aestru:= {{"DESCRICAO ", "C", 40, 0}, {"VALOR     ", "N", 10, ;
         2}, {"DATA      ", "D", 8, 0}, {"TIPO      ", "C", 1, 0}}
      dbcreate("CEBcus", aestru)
   endif
   if (!file("CEBLANCA.DBF"))
      ? "Criando arquivo de Lancamentos diarios do caixa"
      aestru:= {{"DESCRICAO ", "C", 40, 0}, {"VALOR     ", "N", 10, ;
         2}, {"DATA      ", "D", 8, 0}, {"TIPO      ", "C", 1, 0}}
      dbcreate("CEBLANCA", aestru)
   endif
   if (!file("CEBMEST.DBF"))
      ? "Criando arquivo de Movimentacao de Estoque"
      aestru:= {{"COD_PES   ", "C", 6, 0}, {"PESSOA    ", "C", 40, ;
         0}, {"COD_ITEM  ", "C", 6, 0}, {"ITEM      ", "C", 40, 0}, ;
         {"QUANT     ", "N", 4, 0}, {"VAL_UNI   ", "N", 10, 2}, ;
         {"VAL_TOT   ", "N", 10, 2}, {"DATA_NEG  ", "D", 8, 0}, ;
         {"LUCRO     ", "N", 10, 2}, {"TIPO      ", "C", 1, 0}}
      dbcreate("CEBMEST", aestru)
   endif
   if (!file("CEBAGEN.DBF"))
      ? "Criando arquivo de Agenda de Pagamentos"
      aestru:= {{"CODIGO    ", "C", 6, 0}, {"NOME_FOR  ", "C", 40, ;
         0}, {"VALOR     ", "N", 10, 2}, {"DATA_PG   ", "D", 8, 0}, ;
         {"TIPO      ", "C", 1, 0}, {"SELEC     ", "C", 1, 0}}
      dbcreate("CEBAGEN", aestru)
   endif
   if (!file("CEBPED.DBF"))
      ? "Criando arquivo de Pedidos"
      aestru:= {{"PEDIDO    ", "N", 6, 0}, {"COD_CLI   ", "C", 6, ;
         0}, {"DATA      ", "D", 8, 0}, {"FAZENDA   ", "C", 40, 0}, ;
         {"MUNICIPIO ", "C", 30, 0}, {"ESTADO    ", "C", 2, 0}, ;
         {"CONDICAO  ", "C", 40, 0}, {"PROG      ", "D", 8, 0}, ;
         {"FRETE     ", "N", 6, 2}, {"DESC      ", "N", 6, 2}, ;
         {"REALIZADO ", "C", 1, 0}, {"OBS       ", "C", 50, 0}, ;
         {"ROT_FAZ1  ", "C", 50, 0}, {"ROT_FAZ2  ", "C", 50, 0}, ;
         {"ROT_FAZ3  ", "C", 50, 0}}
      dbcreate("CEBPED", aestru)
   endif
   if (!file("ceborc.dbf"))
      ? "Criando arquivo de Orcamentos"
      aestru:= {{"NPEDIDO1  ", "N", 6, 0}, {"CCOD_CLI  ", "C", 6, ;
         0}, {"CMAT      ", "C", 40, 0}, {"NQTDMAT   ", "N", 4, 0}, ;
         {"NVALUNIT  ", "N", 10, 2}, {"REALIZADO ", "C", 1, 0}, ;
         {"CONDICAO  ", "C", 40, 0}}
      dbcreate("CEBORC", aestru)
   endif
   if (!file("CEICLI.NTX"))
      ? "Organizando arquivo de clientes I"
      use cebcli
      index on Codigo to Ceicli
      close databases
      select 1
      close format
   endif
   if (!file("CEICLI2.NTX"))
      ? "Organizando arquivo de clientes II"
      use cebcli
      index on NOME to Ceicli2
      close databases
      select 1
      close format
   endif
   if (!file("CEIFOR.NTX"))
      ? "Organizando arquivo de fornecedores I"
      use CEBFOR
      index on CODIGO to CEIFOR
      close databases
      select 1
      close format
   endif
   if (!file("CEIFOR2.NTX"))
      ? "Organizando arquivo de fornecedores II"
      use CEBFOR
      index on NOME to CEIFOR2
      close databases
      select 1
      close format
   endif
   if (!file("CEIFUN.NTX"))
      ? "Organizando arquivo de funcionarios I"
      use cebfun
      index on Codigo to Ceifun
      close databases
      select 1
      close format
   endif
   if (!file("CEIfun2.NTX"))
      ? "Organizando arquivo de funcionarios II"
      use cebfun
      index on NOME to Ceifun2
      close databases
      select 1
      close format
   endif
   if (!file("CEIEST.NTX"))
      ? "Organizando arquivo de estoque I"
      use CEBEST
      index on Codigo to ceiest
      close databases
      select 1
      close format
   endif
   if (!file("CEIEST2.NTX"))
      ? "Organizando arquivo de estoque II"
      use CEBEST
      index on PRODUTO to ceiest2
      close databases
      select 1
      close format
   endif
   if (!file("CEIPRE.NTX"))
      ? "Organizando arquivo de premix  I"
      use CEBPRE
      index on Codigo to ceiPRE
      close databases
      select 1
      close format
   endif
   if (!file("CEIPRE2.NTX"))
      ? "Organizando arquivo de premix  II"
      use CEBPRE
      index on PRODUTO to ceipre2
      close databases
      select 1
      close format
   endif
   if (!file("CEIMEST.NTX"))
      ? "Organizando arquivo de movimentacao"
      use cebmest
      index on data_neg to ceimest
      close databases
      select 1
      close format
   endif
   if (!file("CEIAGEN.NTX"))
      ? "Organizando arquivo da agenda de pagamentos"
      use cebagen
      index on data_pg to CEIAGEN
      close databases
      select 1
      close format
   endif
   if (!file("CEIPED.NTX"))
      ? "Organizando arquivo de pedidos"
      use cebped
      index on pedido to ceiped
      close databases
      select 1
      close format
   endif
   if (!file("CEIORC.NTX"))
      ? "Organizando arquivo de orcamentos"
      use ceborc
      index on npedido1 to ceiorc
      close databases
      select 1
      close format
   endif
   if (!file("CEICUS.NTX"))
      ? "Organizando arquivo de custo"
      use cebcus
      index on DATA to ceicus
      close databases
      select 1
      close format
   endif
   setblink(.T.)
   set scoreboard off
   set date british
   set wrap on
   set deleted on
   SET PROCEDURE TO CEFUNC
   altd(1)
   op:= 1
   menu1:= {"Clientes", "Fornecedores", "Funcionarios", "Estoque", ;
      "Premix ", "Pedidos"}
   menu2:= {"Entrada", "Baixa", "Consulta de Entradas", ;
      "Consulta da Baixas", "Reajuste de Precos"}
   menu3:= {"Lancamentos", "Custos mensais", "Fechamento Diario", ;
      "Fechamento Mensal", "Consulta de Lancamentos Diarios", ;
      "Consulta de Lancamentos Mensais"}
   menu4:= {"Entrada", "Saida", "Clientes", "Fornecedores", ;
      "Materiais Estocados", "Lancamentos Diarios", ;
      "Lancamentos Mensais", "Agenda de Pagamento", ;
      "Agenda de recebimentos", "Custos Mensais"}
   menu5:= {"Excluir Movimentacoes", "Excluir Custos", ;
      "Alterar Senhas", "Configuracoes", "Sobre..."}
   menu6:= {"Clientes", "Fornecedores", "Funcionarios", "Premix", ;
      "Estoque"}
   menu7:= {"Inclusao de Pagtos.", "Inclusao de Receb.", ;
      "Exclusao de Pagtos.", "Exclusao de Receb."}
   menu8:= {" Sair "}
   menu:= array(8, 3)
   menu:= {{2, 1, "Manutencao"}, {2, 12, "Estoque"}, {2, 20, ;
      "Caixa"}, {2, 26, "Relatorios"}, {2, 37, "Utilidades"}, {2, ;
      48, "Consulta"}, {2, 57, "Agenda"}, {2, 69, "Sair"}}
   @  0,  0, 24, 79 box Replicate("²", 9) color "b/w"
   centra(0, "Controle de Estoque v1.0;  CS # 1995", "gr+/b")
   centra(1, "Menu Principal", "gr+/bg")
   centra(24, "<ENTER> - Seleciona; <F1> - Help; <F10> - Sair", ;
      "gr+/bg")
   ccor:= SetColor("gr+/b")
   sombra(7, 20, 17, 60)
   set color to R+/n
   @  9, 22 say "Sistema de Controle de Estoques  v1.0"
   @ 11, 22 say "Desenvolvido por Luiz Antonio Carlin "
   @ 13, 22 say "Fone : (0143) 51-2237    Piraju - SP "
   @ 15, 22 say "           Julho / 1995         "
   set color to (ccor)
   save screen to tela_dt
   if (!file("CE.MEM"))
      l_nome:= Space(40)
      l_empresa:= Space(40)
      sombra(9, 20, 12, 72)
      @  9, 30 say "Licenciado Para:"
      @ 10, 21 say "Nome    :" get l_nome
      @ 11, 21 say "Empresa :" get l_empresa
      read
      save all like l_* to ce
      release all like L_*
   endif
   sombra(11, 29, 13, 51)
   @ 12, 30 say "Data Atual:" get data_sis picture "99/99/99"
   read
   use cebagen
   set filter to data_pg = data_sis
   goto top
   if (!EOF())
      mensagem("Ha pagamentos ou recebimentos para serem efetuados Hoje!!")
   endif
   close databases
   select 1
   close format
   restore screen from tela_dt
   set color to W/BG+
   @  1,  0 clear to  3, 79
   centra(1, "Menu Principal", "gr+/bg")
   op:= botao(menu)
   do while (op > 0)
      for i:= 1 to Len(menu)
         @  2, menu[i][2] say menu[i][3] color "N+/W"
      next
      @  2, menu[op][2] say Upper(menu[op][3]) color "W/B"
      set color to bg/n,W/B
      do case
      case op = 1
         save screen to tela
         sombra(4, 1, 11, 16)
         ac1:= achoice(5, 2, 10, 15, menu1, .T., "controle")
         if (ac1 != 0)
            centra(24, ;
               "<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos", ;
               "gr+/bg")
            set color to bg/n,w/r
         endif
         do case
         case ac1 == 1
            do cemtcli
         case ac1 == 2
            do cemtfor
         case ac1 == 3
            do cemtfun
         case ac1 == 4
            do cemtest
         case ac1 == 5
            do cemtpre
         case ac1 == 6
            do cemtped
         endcase
         restore screen from tela
      case op = 2
         save screen to tela
         sombra(4, 12, 10, 33)
         ac2:= achoice(5, 13, 9, 32, menu2, .T., "controle")
         if (ac2 < 3)
            centra(24, ;
               "<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos", ;
               "gr+/bg")
            set color to bg/n,w/r
         else
            set color to bg/n,w/r
            centra(24, "<ESC> - Sair; <F1> - Help; ", "gr+/bg")
         endif
         if (ac2 = 1 .OR. ac2 = 2)
            do cemest with ac2
         elseif (ac2 = 3 .OR. ac2 = 4)
            do cecmest with ac2
         elseif (ac2 == 5)
            do cerjes
         endif
         restore screen from tela
      case op = 3
         save screen to tela
         sombra(4, 20, 11, 54)
         ac3:= achoice(5, 21, 10, 53, menu3, .T., "controle")
         if (ac3 != 0)
            cor:= SetColor()
            centra(24, " ", "gr+/bg")
            llibera:= .F.
            llibera:= existsenha()
            set color to (cor)
            centra(24, "<ESC> - Sair - <F1> - Help; ", "gr+/bg")
            set color to bg/n,w/r
         endif
         if (ac3 = 1 .AND. llibera .OR. ac3 = 2 .AND. llibera)
            do celanca
         elseif (ac3 = 3 .AND. llibera) 
            do cefcdia
         elseif (ac3 = 4 .AND. llibera)
            do cefcmes
         elseif (ac3 = 5 .AND. llibera .OR. ac3 = 6 .AND. llibera)
            do cecldm with (ac3 - 4)
         endif
         restore screen from tela
      case op = 4
         save screen to tela
         sombra(4, 26, 15, 51)
         ac4:= achoice(5, 27, 14, 50, menu4, .T., "controle")
         if (ac4 != 0)
            centra(24, ;
               "<ENTER> - Imprime; <DESLIGUE A IMPRESSORA> - SAIR", ;
               "gr+/bg")
            set color to bg/n,w/r
            close databases
            select 1
            close format
            do cerelat with ac4
         endif
         restore screen from tela
      case op = 5
         save screen to tela
         sombra(4, 37, 10, 60)
         ac5:= achoice(5, 38, 9, 59, menu5, .T., "controle")
         if (ac5 != 0)
            centra(24, "<ESC> - Sair", "gr+/bg")
            set color to bg/n,w/r
         endif
         do case
         case ac5 == 1
            do ceapmv
         case ac5 == 2
            do ceapcus
         case ac5 == 3
            manutsen()
         case ac5 == 4
            config()
         case ac5 == 5
            sobre()
         endcase
         restore screen from tela
      case op = 6
         save screen to tela
         sombra(4, 48, 10, 64)
         ac6:= achoice(5, 49, 9, 63, menu6, .T., "controle")
         if (ac6 != 0)
            centra(24, "<ESC> - Sair; <F1> - Help; ", "gr+/bg")
            set color to bg/n,w/r
            do cecgeral with ac6
         endif
         restore screen from tela
      case op = 7
         save screen to tela
         sombra(4, 57, 9, 77)
         ac7:= achoice(5, 58, 8, 76, menu7, .T., "CONTROLE")
         if (ac7 != 0)
            centra(24, "<ESC> - Sair; <F1> - Help; ", "GR+/bg")
            set color to bg/n,w/r
         endif
         if (ac7 = 1 .OR. ac7 = 2)
            do ceincag with ac7
         elseif (ac7 >= 3)
            set color to bg/n,w/r
            do ceceagd with (ac7 - 2)
         endif
         restore screen from tela
      case op = 8
         save screen to tela
         sombra(4, 69, 6, 77, .F.)
         ac8:= achoice(5, 70, 5, 76, menu8, .T., "controle")
         if (ac8 != 0)
            centra(24, " ", "gr+/bg")
            set color to bg/n,w/r
         endif
         if (ac8 == 1)
            sai()
         endif
         restore screen from tela
      endcase
      tecla:= LastKey()
      if (tecla = -9)
         op:= 8
         keyboard Chr(13)
      elseif (tecla = 4)
         op++
         if (op > 8)
            op:= 1
         endif
      elseif (tecla = 19)
         op--
         if (op < 1)
            op:= 8
         endif
      endif
   enddo
   restore screen from tela_dos
   @ linha, coluna
   close databases
   select 1
   close format
   clear memory
   quit

* EOF
