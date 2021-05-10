#include "common.ch"
#include "fileio.ch"
#include "inkey.ch"
#include "popmenu.ch"
********************************
   public data_sis:= Date()
   public linha:= Row()
   public coluna:= Col()
   public tela_dos
   save screen to tela_dos
   ? 
   ? "Aguarde!!  Carregando o Sistema"
   ?
/*
   arquivo:= memoread("C:\WINB30.486")
   if (Empty(arquivo) .OR. decripto(arquivo) != ;
         "CS # 1995 Controle de Estoque v1.0 - L.A.C. - {O Corsario(tm)}")
      ? 
      ? "Copia Ilegal !!! Acesso nao Permitido"
      ? 
      quit
   endif
*/
   existe:= .T.
   if (!file("SRBCLI.DBF") .OR. !file("SRBCLI.DBT"))
      ? "Criando arquivo de clientes"
      aestru:= {{"MATRICULA", "C",06,0},; 
                {"NOME",      "C",40,0},; 
                {"PAI",       "C",40,0},;
                {"MAE",       "C",40,0},;
                {"ESTCIVIL",  "C",15,0},;
                {"NACIONALI", "C",20,0},;
                {"NATURAL",   "C",30,0},;
                {"NASC",      "D",08,0},;
                {"RESID",     "C",20,0},;
                {"ENDERECO",  "C",40,0},;
                {"FIRMA",     "C",30,0},;
                {"END_FAZ",   "C",45,0},;
                {"TELEFONE",  "C",15,0},;
                {"CARGO",     "C",40,0},;
                {"CART_PRO",  "C",30,0},;
                {"CART_SER",  "C",10,0},;
                {"END_COBRA", "C",45,0},;
                {"ELEITOR",   "C",25,0},;
                {"RESERVA",   "C",20,0},;
                {"ADMICAO",   "D",08,0},;
                {"OBS",       "M",10,0}}
      dbcreate("SRBCLI", aestru)
   endif
   if (!file("SRBLMC.DBF"))
      ? "Criando arquivo de Lancamentos mensais do caixa"
      aestru:= {{"DESCRICAO ", "C", 40, 0}, {"VALOR     ", "N", 10, ;
         2}, {"DATA      ", "D", 8, 0}, {"TIPO      ", "C", 1, 0}}
      dbcreate("SRBLMC", aestru)
   endif
  if (!file("SRBcus.DBF"))
      ? "Criando arquivo de Custos"
      aestru:= {{"DESCRICAO ", "C", 40, 0}, {"VALOR     ", "N", 10, ;
         2}, {"DATA      ", "D", 8, 0}, {"NMOV       ","C", 18, 0}, ;
         {"TIPO      ", "C", 1, 0}}
      dbcreate("SRBcus", aestru)
   endif
   if (!file("SRBLANCA.DBF"))
      ? "Criando arquivo de Lancamentos diarios do caixa"
      aestru:= {{"DESCRICAO ", "C", 40, 0}, {"VALOR     ", "N", 10, ;
         2}, {"DATA      ", "D", 8, 0},{"NMOV       ","C", 18, 0}, ;
         {"TIPO      ", "C", 1, 0}}
      dbcreate("SRBLANCA", aestru)
   endif
   IF (!file("SRICLI.NTX"))
      ? "Organizando arquivo de clientes I"
      use SRbcli
      index on MATRICULA to SRicli
      close databases
      select 1
      close format
   endif
   if (!file("SRICLI2.NTX"))
      ? "Organizando arquivo de clientes II"
      use srbcli
      index on NOME to sricli2
      close databases
      select 1
      close format
   endif
   if (!file("srICUS.NTX"))
      ? "Organizando arquivo de custo"
      use SRbcus
      index on DATA to sricus
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
   SET PROCEDURE TO SRFUNC
   set menu colors to "bg/n" , "n+/w,w/b" , "bg/n,w/b"
   altd(1)
   op:= 1
   menu1:= {" Cadastro "}
   menu2:= {"Inclus„o de Lancamentos diversos",; 
            "Fechamento Diario               ",;
            "Fechamento Mensal               ",;
            "Consulta de Lancamentos Diarios ",;
            "Consulta de Lancamentos Mensais ",;
            "Consulta de Custos Mensais      "}
   menu3:= {"Clientes              ",;
            "Lancamentos Diarios   ",;
            "Lancamentos Mensais   ",;
            "Custos Mensais        "}
   menu4:= {"Excluir Custos     ",;
            "Alterar Senhas     ", ;
            "Copia de seguran‡a ", ;
            "Restaura Copia     "}
   menu5:= {" Sair "}
   menu:= array(5, 3)
   menu:= {{2, 1, "Clientes"}, {2, 12, "Caixa"}, {2, 20, "Relatorios"},;
      {2, 33, "Utilidades"},{2, 69, "Sair"}}

   @  0,  0, 24, 79 box Replicate("²", 9) color "b/w"
   centra(0, "Tec Maq Informatica - Fone (0143) 51-1728  - Piraju - SP", "gr+/b")
   centra(1, "Menu Principal", "gr+/bg")
   centra(24, "<ENTER> - Seleciona;<ESC> - Sair","gr+/bg")
*  RELOGIO(0,70)
   save screen to tela_dt
   setcolor("gr+/b")
   sombra(11, 29, 13, 51)
   @ 12, 30 say "Data Atual:" get data_sis picture "99/99/99"
   read
   restore screen from tela_dt
   SET COLOR TO GR+/B
   sombra(19,62,22,76)
   @ 20,63 SAY "<SHIFT>+<F10>" color "w/b"
   @ 21,63 SAY " Calculadora " color "w/b"
   set color to W/BG+
   @  2,  0 clear to  3, 79
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
      setcolor("gr+/b,W/r")
      op1 := val ( alltrim ( substr ( str ( op ) ,1,1) ) )
      op2 := val ( alltrim ( substr ( str ( op ) ,2,2) ) )
      IF lastkey() = 27
         op := 51
         OP1 := 5
         OP2 := 1
      ENDIF
      do case
         case op1 = 1
              centra(24, ;
               "<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos", ;
               "gr+/bg")
              do SRmtcli
         case op1= 2
              if (op2 != 0)
                 cor:= SetColor()
                 centra(24, " ", "gr+/bg")
                 llibera:= .F.
                 llibera:= existsenha()
                 setcolor (cor)
                 centra(24, "<ESC> - Sair - <F1> - Help; ", "gr+/bg")
              endif
              if (op2 = 1 .AND. llibera)
                 do SRlanca
              elseif (op2 = 2 .AND. llibera) 
                 do SRfcdia
              elseif (op2 = 3 .AND. llibera)
                 do SRfcmes
              elseif (op2 = 4 .AND. llibera .OR. op2 = 5 .AND. llibera .OR. op2 = 6 .AND. llibera)
                 do SRcldm with (op2 - 3)
              endif
         CASE OP1 = 3
              do SRrelat WITH OP2
         case op1= 4
              if (op2 != 0)
                 centra(24, "<ESC> - Sair", "gr+/bg")
              endif
              do case
                 case op2 == 1
                      do SRAPCUS
                 case op2 == 2
                      manutsen()
                 case op2 == 3  .OR. OP2 = 4
                      do SRcparq WITH (OP2-2)
              endcase
         case op1= 5
              centra(24, " ", "gr+/bg")
              sai()
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


* EOF
