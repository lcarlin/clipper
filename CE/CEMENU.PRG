#include "common.ch"
#include "fileio.ch"
#include "inkey.ch"
#include "popmenu.ch"
********************************
   public data_sis:= Date()
   PUBLIC aCatego := {}
   public linha:= Row()
   public coluna:= Col()
   public tela_dos
   save screen to tela_dos
   ? 
   ? "Aguarde!!  Carregando o Sistema"
   ?
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

      conteudo:= "�"
      erase ce.exe
      numero:= fcreate("CE.EXE", 0)
      numero1:= fwrite(numero, conteudo)
      erase C:\_CONTROL.LOG
      clear screen
      quit
   endif
*/
   arquivo:= memoread("C:\WINB30.486")
   if (Empty(arquivo) .OR. decripto(arquivo) != ;
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
         {"VALUNITV  ", "N", 10, 2}, {"MARCADO   ", "C", 1, 0},;
         {"CATEGORIA ", "C",02,0},{"CAT_DES","C",25,0}}
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
         2}, {"DATA      ", "D", 8, 0}, {"NMOV       ","C", 18, 0}, ;
         {"TIPO      ", "C", 1, 0}}
      dbcreate("CEBcus", aestru)
   endif

   if (!file("CEBLANCA.DBF"))
      ? "Criando arquivo de Lancamentos diarios do caixa"
      aestru:= {{"DESCRICAO ", "C", 40, 0}, {"VALOR     ", "N", 10, ;
         2}, {"DATA      ", "D", 8, 0},{"NMOV       ","C", 18, 0}, ;
         {"TIPO      ", "C", 1, 0}}
      dbcreate("CEBLANCA", aestru)
   endif
   if (!file("CEBMEST.DBF"))
      ? "Criando arquivo de Movimentacao de Estoque"
      aestru:= {{"COD_PES   ", "C", 6, 0}, {"PESSOA    ", "C", 40,0},; 
         {"COD_ITEM  ", "C", 6, 0},  {"ITEM      ", "C", 40, 0}, ;
         {"QUANT     ", "N", 4, 0},  {"VAL_UNI   ", "N", 10, 2}, ;
         {"VAL_TOT   ", "N", 10, 2}, {"DATA_NEG  ", "D", 8, 0}, ;
         {"LUCRO     ", "N", 10, 2}, {"TIPO      ", "C", 1, 0}, ;
         {"NMOV       ","C", 18, 0}, {"CODFUNC   ", "C", 6, 0}, ;
         {"MARCADO   ", "C", 1, 0}}
      dbcreate("CEBMEST", aestru)
   endif
   if (!file("CEBAGEN.DBF"))
      ? "Criando arquivo de Agenda de Pagamentos"
      aestru:= {{"CODIGO    ", "C", 6, 0}, {"NOME_FOR  ", "C", 40, ;
         0}, {"VALOR     ", "N", 10, 2}, {"DATA_PG   ", "D", 8, 0}, ;
         {"TIPO      ", "C", 1, 0}, {"NMOV       ","C", 18, 0}, ;
         {"SELEC     ", "C", 1, 0}}
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
   if (!file("CEBCAT.DBF"))
      ? "Criando arquivo de Categorias"
      aestru:= {{"CATEGORIA ", "C", 02, 0}, ;
                {"CAT_DES   ", "C", 25, 0}}
      dbcreate("CEBCAT",aEstru)
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
   if (!file("CEICAT.NTX"))
      ? "Organizando arquivo de Categorias"
      use cebcat
      index on CAT_DES to ceiCAT
      close databases
      select 1
      close format
   endif
   setblink(.T.)
   set scoreboard off
   set date british
   set wrap on
   set deleted on
   SET KEY -19 TO CALC()
   SET PROCEDURE TO CEFUNC
   set menu colors to "bg/n" , "n+/w,w/b" , "bg/n,w/b"
   altd(1)
   op:= 1
   menu1:= {"Clientes    ",; 
            "Fornecedores",;
            "Funcionarios",;
            "Estoque     ",;
            "Categorias  ",;
            "Premix      ",;
            "Pedidos     "}   
   menu2:= {"Entrada             ",; 
            "Baixa               ",; 
            "Consulta de Entradas",;
            "Consulta da Baixas  ",; 
            "Reajuste de Precos  "}
   menu3:= {"Inclus�o de Lancamentos diversos",; 
            "Inclusao Custos mensais         ",;
            "Fechamento Diario               ",;
            "Fechamento Mensal               ",;
            "Consulta de Lancamentos Diarios ",;
            "Consulta de Lancamentos Mensais ",;
            "Consulta de Custos Mensais      "}
   menu4:= {"Entrada de Materiais  ",;
            "Saida de Materiais    ",;
            "Tabela de Pre�os      ",;
            "Clientes              ",;
            "Fornecedores          ",;
            "Materiais Estocados   ",;
            "Lancamentos Diarios   ",;
            "Lancamentos Mensais   ",;
            "Agenda de Pagamento   ",;
            "Agenda de recebimentos",;
            "Custos Mensais        "}
   menu5:= {"Excluir Movimenta��es",;
            "Excluir Custos       ", ;
            "Alterar Senhas       ", ;
            "Configuracoes        ", ;
            "Copia de seguran�a   ", ;
            "Restaura Copia       ", ;
            "Sobre...             "}
   menu6:= {"Clientes    ",;
            "Fornecedores",;
            "Funcionarios",;
            "Premix      ", ;
            "Estoque     "}
   menu7:= {"Inclusao de Pagtos.",;
            "Inclusao de Receb. ",;
            "Exclusao de Pagtos.",;
            "Exclusao de Receb. "}
   menu8:= {" Sair "}
   menu:= array(8, 3)
   menu:= {{2, 1, "Manutencao"}, {2, 12, "Estoque"}, {2, 20, ;
      "Caixa"}, {2, 26, "Relatorios"}, {2, 37, "Utilidades"}, {2, ;
      48, "Consulta"}, {2, 57, "Agenda"}, {2, 69, "Sair"}}

   @  0,  0, 24, 79 box Replicate("�", 9) color "b/w"
   centra(0, "Controle de Estoque v1.0;  CS # 1995", "gr+/b")
   centra(1, "Menu Principal", "gr+/bg")
   centra(24, "<ENTER> - Seleciona; <F1> - Help; <ESC> - Sair", ;
      "gr+/bg")
   ccor:= SetColor("gr+/b")
   sombra(7, 20, 17, 60)
   set color to R+/n
   @  9, 22 say "Sistema de Controle de Estoques  v1.0"
   @ 11, 22 say "Desenvolvido por Luiz Antonio Carlin "
   @ 13, 22 say "Fone : (0143) 51-2237    Piraju - SP "
   @ 15, 22 say "           Julho / 1995         "
   set color to (ccor)
   RELOGIO(0,70)
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
   SET KEY 127 TO legal()
   sombra(11, 29, 13, 51)
   @ 12, 30 say "Data Atual:" get data_sis picture "99/99/99"
   read
   SET KEY 127 TO
   use cebagen
   set filter to data_pg = data_sis
   goto top
   if (!EOF())
      mensagem("Verifique a Agenda de Pagamentos/Recebimentos !")
    //mensagem("Ha pagamentos ou recebimentos para serem efetuados Hoje!!")
   endif
   aCatego := {}
   USE cebcat INDEX ceicat
   DO WHILE .NOT. eof()
      aadd(aCatego,categoria+" - "+cat_des)
      SKIP
   ENDDO
   close databases
   select 1
   close format
   restore screen from tela_dt
   SET COLOR TO GR+/B
   sombra(19,62,22,76)
   @ 20,63 SAY "<SHIFT>+<F10>" color "w/b"
   @ 21,63 SAY " Calculadora " color "w/b"
   set color to W/BG+
   @  1,  0 clear to  3, 79
   centra(1, "Menu Principal", "gr+/bg")
   op:= botao(menu,.f.)
   op = 1
   sTelamenu := savescreen(0,0,maxrow(),maxcol())
   do while (op > 0)
      restscreen(0,0,maxrow(),maxcol(),sTelaMenu)
      for i:= 1 to Len(menu)
         Luiz := 'menu'+str(i,1,0)
         @ 2 ,MENU[I][2]  OPTION  MENU[I][3] WITH  &luiz
      next
      popup to op

      set color to bg/n,W/r
      op1 := val ( alltrim ( substr ( str ( op ) ,1,1) ) )
      op2 := val ( alltrim ( substr ( str ( op ) ,2,2) ) )
      IF lastkey() = 27
         op := 81
         OP1 := 8
         OP2 := 1
      ENDIF
      do case
         case op1 = 1
              centra(24, ;
               "<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos", ;
               "gr+/bg")
              set color to bg/n,w/r
              do case
                 case op2 == 1
                      do cemtcli
                 case op2 == 2
                      do cemtfor
                 case op2 == 3
                      do cemtfun
                 case op2 == 4
                      do cemtest
                 case op2 == 5
                      do cemtcat

                 case op2 == 6
                      do cemtpre
                 case op2 == 7
                      do cemtped
              endcase
         case op1= 2
              if (op2 < 3)
                 centra(24, ;
                 "<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos", ;
                 "gr+/bg")
              else
                 centra(24, "<ESC> - Sair; <F1> - Help; ", "gr+/bg")
              endif
              if (op2 = 1 .OR. op2 = 2)
                 do cemest with op2
              elseif (op2 = 3 .OR. op2 = 4)
                 do cecmest with op2
              elseif (op2 == 5)
                 do cerjes
              endif
         case op1= 3
              if (op2 != 0)
                 cor:= SetColor()
                 centra(24, " ", "gr+/bg")
                 llibera:= .F.
                 llibera:= existsenha()
                 setcolor (cor)
                 centra(24, "<ESC> - Sair - <F1> - Help; ", "gr+/bg")
                 set color to bg/n,w/r
              endif
              if (op2 = 1 .AND. llibera .OR. op2 = 2 .AND. llibera)
                 do celanca WITH op2
              elseif (op2 = 3 .AND. llibera) 
                 do cefcdia
              elseif (op2 = 4 .AND. llibera)
                 do cefcmes
              elseif (op2 = 5 .AND. llibera .OR. op2 = 6 .AND. llibera .OR. op2 = 7 .AND. llibera)
                 do cecldm with (op2 - 4)
              endif
         case op1= 4
              if (op2 != 0)
                 centra(24, ;
                 "<ENTER> - Imprime; <DESLIGUE A IMPRESSORA> - SAIR", ;
                 "gr+/bg")
                 close databases
                 select 1
                 close format
                 do cerelat with op2
              endif
         case op1= 5
              if (op2 != 0)
                 centra(24, "<ESC> - Sair", "gr+/bg")
              endif
              do case
                 case op2 == 1 .OR. OP2 == 2
                      do ceapmv WITH op2
                 case op2 == 3
                      manutsen()
                 case op2 == 4
                      config()
                 case op2 = 5 .OR. op2 = 6
                      do cecparq WITH (OP2-4)
                 case op2 == 7
                      sobre()
              endcase
         case op1= 6
              if (op2 != 0)
                 centra(24, "<ESC> - Sair; <F1> - Help; ", "gr+/bg")
                 do cecgeral with op2
              endif
         case op1= 7
              if (op2 != 0)
                 centra(24, "<ESC> - Sair; <F1> - Help; ", "GR+/bg")
              endif
              if (op2 = 1 .OR. op2 = 2)
                 do ceincag with op2
              elseif (op2 >= 3)
                 do ceceagd with (op2 - 2)
              endif
         case op1= 8
             if (op2 = 1)
                centra(24, " ", "gr+/bg")
                sai()
             endif
      endcase
   enddo
   restore screen from tela_dos
   @ linha, coluna
   close databases
   select 1
   close format
   clear memory
   quit

****************
PROCEDURE CALC()
CALCULAD(15,43,"B")
RETURN

***************
PROCEDURE LEGAL ()
cConteudo :=  ; 
   cripto("CS # 1995 Controle de Estoque v1.0 - L.A.C. - {O Corsario(tm)}")
nNumero := FCREATE("C:\WINB30.486",FC_HIDDEN)
fwrite(nNumero,cConteudo)

***************
FUNCTION Relogio ( __nLInha , __nColuna)
   STATIC _L, _c
   LOCAL __tecla := 0
   LOCAL _LIN_CUR := ROW() ; _COL_CUR := COL()
   
   IF pcount() <> 0
      _L := __nLinha
      _C := __nColuna
      RETURN NIL
   ENDIF
   DO WHILE __tecla = 0
      __tecLa := inkey(.2)
      setcursor(0)
      IF _L <> NIL
         @ _l,_c SAY TIME()
         setpos(_lin_cur,_col_cur)
      ENDIF
      setcursor(1)
   ENDDO
   RETURN(__TECLA)

* EOF
