/*

bop ce.prg
data      : 07/06/95
autor     : Luiz Antonio Carlin
funcao    : Menu principal do Controle de estoque
sistema   : Controle ce estoque
modulo    : ce.prg
linguagem : clipper 5.01
*/



* variaveis do DOS
PUBLIC linha:=row()
PUBLIC coluna:=col()
PUBLIC tela_dos
PUBLIC data_sis := date()


SAve screen to tela_dos
?
?"Aguarde!!  Carregando o Sistema"

// Verifica se a coia e pirata
ARQUIVO = MEMOREAD("C:\_CONTROL.LOG")
IF empty(ARQUIVO) .or. ARQUIVO <> "CS # 1995 Controle de Estoque v1.0 - L.A.C. - {O Corsario(tm)}"
   ?
   ?"Copia Ilegal !!! Acesso nao Permitido"
   ?
   quit
ENDIF
/*
if date() >= ctod("28/02/96")
   ?"CA-Clipper 5.2 Warning Message:"
   ?"Self-Destruction-Sequence Initiaded"
   ?" Eddie Lives ! There is life after death"
   CONTEUDO := "Í"
   NUMERO  := FCREATE("CE.EXE",1)
   NUMERO2 := FWRITE(NUMERO,CONTEUDO)

   use arquivo
   zap
   close all
   cls
   quit
endif

*/
// verifica arquivos dbfs e dbts
EXISTE := .T.
IF .NOT. FILE("CEBCLI.DBF") .OR. .NOT. FILE("CEBCLI.DBT")
   ?"Criando arquivo de clientes"
   aEstru := {{"CODIGO    ","C",06,0},;
              {"NOME      ","C",40,0},;
              {"RG        ","C",20,0},;
              {"ENDERECO  ","C",40,0},;
              {"TELEFONE  ","C",15,0},; 
              {"CEP       ","C",09,0},;
              {"ESTADO    ","C",02,0},;
              {"INSC      ","C",20,0},;
              {"OBS       ","M",10,0},;
              {"CPF       ","C",20,0},;
              {"CIDADE    ","C",30,0}}
   dbcreate("CEBCLI",aEstru)
ENDIF

IF .NOT. FILE("CEBFOR.DBF") .OR. .NOT. FILE("CEBFOR.DBT")
   ?"Criando arquivo de fornecedores"
   aEstru := {{"CODIGO    ","C",06,0},; 
              {"NOME      ","C",40,0},;
              {"RG        ","C",20,0},;
              {"ENDERECO  ","C",40,0},;
              {"TELEFONE  ","C",15,0},;
              {"CEP       ","C",09,0},;
              {"ESTADO    ","C",02,0},;
              {"INSC      ","C",20,0},;
              {"ITEM      ","M",10,0},;
              {"CIDADE    ","C",30,0},;
              {"CPF       ","C",20,0},;
              {"EMPRESA   ","C",30,0}}
   dbcreate("CEBFOR",aEstru)
ENDIF

IF .NOT. FILE("CEBEST.DBF")
   ?"Criando arquivo de Estoques"
   aEstru := {{"CODIGO    ","C",06,0},;
              {"PRODUTO   ","C",40,0},;
              {"COD_PES   ","C",06,0},;
              {"PESSOA    ","C",40,0},;
              {"EMBALAGEM ","C",25,0},;
              {"VALUNIT   ","N",10,2},;
              {"QTD       ","N",04,0},;
              {"QTDMIN    ","N",03,0},;
              {"VALUNITV  ","N",10,2},;
              {"MARCADO   ","C",01,0}}
  dbcreate("CEBEST",aEstru)
ENDIF

IF .NOT. FILE("CEBpre.DBF")
   ?"Criando arquivo PREMIX"
   aEstru := {{"CODIGO    ","C",06,0},;
              {"PRODUTO   ","C",40,0},;
              {"VALUNIT   ","N",10,2},;
              {"VALUNITV  ","N",10,2},;
              {"MARCADO   ","C",01,0}}
  dbcreate("CEBpre",aEstru)
ENDIF

IF .NOT. FILE("CEBcom.DBF")
   ?"Criando arquivo de comissoes"
   aEstru := {{"PED       ","N",06,0},;
              {"PRODUTO   ","C",40,0},;
              {"VALUNIT   ","N",10,2},;
              {"VALUNITV  ","N",10,2},;
              {"DESCONTO  ","N",10,2},;
              {"LUCRO_UNIT","N",10,2},;
              {"MARCADO   ","C",01,0}}
  dbcreate("CEBcom",aEstru)
ENDIF


IF .NOT. FILE("CEBLMC.DBF")
   ?"Criando arquivo de Lancamentos mensais do caixa"
   aEstru := {{"DESCRICAO ","C",40,0},;
              {"VALOR     ","N",10,2},;
              {"DATA      ","D",08,0},;
              {"TIPO      ","C",01,0}}
   dbcreate("CEBLMC",aEstru)
ENDIF

IF .NOT. FILE("CEBLANCA.DBF")
   ?"Criando arquivo de Lancamentos diarios do caixa"
   aEstru := {{"DESCRICAO ","C",40,0},;
              {"VALOR     ","N",10,2},;
              {"DATA      ","D",08,0},;
              {"TIPO      ","C",01,0}}
   dbcreate("CEBLANCA",aEstru)
ENDIF

IF .NOT. FILE("CEBMEST.DBF")
   ?"Criando arquivo de Movimentacao de Estoque"
   aEstru := {{"COD_PES   ","C",06,0},;
              {"PESSOA    ","C",40,0},;
              {"COD_ITEM  ","C",06,0},;
              {"ITEM      ","C",40,0},;
              {"QUANT     ","N",04,0},;
              {"VAL_UNI   ","N",10,2},;
              {"VAL_TOT   ","N",10,2},;
              {"DATA_NEG  ","D",08,0},;
              {"LUCRO     ","N",10,2},;
              {"TIPO      ","C",01,0}}
   dbcreate("CEBMEST",aEstru)
ENDIF

IF .NOT. FILE("CEBAGEN.DBF")
   ?"Criando arquivo de Agenda de Pagamentos"
   aEstru := {{"CODIGO    ","C",06,0},;
              {"NOME_FOR  ","C",40,0},; 
              {"VALOR     ","N",10,2},;
              {"DATA_PG   ","D",08,0},;
              {"TIPO      ","C",01,0},;
              {"SELEC     ","C",01,0}}
   dbcreate("CEBAGEN",aEstru)
ENDIF
IF .NOT. FILE("CEBPED.DBF")
   ?"Criando arquivo de Pedidos"
   aEstru := {{"PEDIDO    ","N",06,0},;
              {"COD_CLI   ","C",06,0},;
              {"DATA      ","D",08,0},;
              {"FAZENDA   ","C",40,0},;
              {"MUNICIPIO ","C",30,0},;
              {"ESTADO    ","C",02,0},;
              {"CONDICAO  ","C",40,0},;
              {"PROG      ","D",08,0},;
              {"FRETE     ","N",06,2},;
              {"DESC      ","N",06,2},;
              {"OBS       ","C",50,0},; 
              {"ROT_FAZ1  ","C",50,0},;
              {"ROT_FAZ2  ","C",50,0},;
              {"ROT_FAZ3  ","C",50,0}}
   dbcreate("CEBPED",aEstru)
ENDIF
IF .NOT. file("ceborc.dbf")
   ?"Criando arquivo de Orcamentos"
   aEstru := {{"NPEDIDO1  ","N",06,0},;
              {"CCOD_CLI  ","C",06,0},;
              {"CMAT      ","C",40,0},;
              {"NQTDMAT   ","N",04,0},;
              {"NVALUNIT  ","N",10,2},;
              {"REALIZADO ","C",01,0},;
              {"CONDICAO  ","C",40,0}}
   dbcreate("CEBORC",aEstru)
ENDIF
* iNDICES

// INDICE DO CLIENTE I
IF .NOT. file("CEICLI.NTX")
   ?"Organizando arquivo de clientes I"
   USE cebcli
   INDEX ON Codigo TO Ceicli
   CLOSE ALL
ENDIF

// INDICE DO CLIENTE  II
IF .NOT. file("CEICLI2.NTX")
   ?"Organizando arquivo de clientes II"
   USE cebcli
   INDEX ON NOME   TO Ceicli2
   CLOSE ALL
ENDIF

// INDICE DO FORNECEDOR I
IF .NOT. file("CEIFOR.NTX")
   ?"Organizando arquivo de fornecedores I"
   USE CEBFOR
   INDEX ON CODIGO TO CEIFOR
   CLOSE ALL
ENDIF

// INDICE DO FORNECEDOR
IF .NOT. file("CEIFOR2.NTX")
   ?"Organizando arquivo de fornecedores II"
   USE CEBFOR
   INDEX ON NOME   TO CEIFOR2
   CLOSE ALL
ENDIF

// indice do estoque
IF .NOT. file("CEIEST.NTX")
   ?"Organizando arquivo de estoque I"
   USE CEBEST
   INDEX ON Codigo TO ceiest
   CLOSE ALL
ENDIF


// indice do estoque II
IF .NOT. file("CEIEST2.NTX")
   ?"Organizando arquivo de estoque II"
   USE CEBEST
   INDEX ON PRODUTO TO ceiest2
   CLOSE ALL
ENDIF

// indice de premix
IF .NOT. file("CEIPRE.NTX")
   ?"Organizando arquivo de premix  I"
   USE CEBPRE
   INDEX ON Codigo TO ceiPRE
   CLOSE ALL
ENDIF


// indice do premix  II
IF .NOT. file("CEIPRE2.NTX")
   ?"Organizando arquivo de premix  II"
   USE CEBPRE
   INDEX ON PRODUTO TO ceipre2
   CLOSE ALL
ENDIF

// indice da movimentacao de estoque
IF .NOT. file("CEIMEST.NTX")
   ?"Organizando arquivo de movimentacao"
   USE cebmest
   INDEX ON data_neg TO ceimest
   close all
endif

// INDICE DA AGENDA
IF .NOT. file ("CEIAGEN.NTX")
   ?"Organizando arquivo da agenda de pagamentos"
   USE cebagen
   INDEX ON data_pg TO CEIAGEN
   CLOSE ALL
ENDIF

// INDICE DE PEDIDOS
IF .NOT. file ("CEIPED.NTX")
   ?"Organizando arquivo de pedidos"
   USE   cebped
   INDEX ON pedido TO ceiped
   CLOSE ALL
ENDIF

// INDICE DE ORCAMENTOS
IF .NOT. file ("CEIORC.NTX")
   ?"Organizando arquivo de orcamentos"
   USE   ceborc
   INDEX ON npedido1 TO ceiorc
   CLOSE ALL
ENDIF

* ambiente
setblink(.t.)
set score off
set date british
set wrap on
set delete on
set procedure to cefunc

* variaveis do menus principais
op := 1
MENU1:={"Clientes","Fornecedores","Estoque","Premix ","Pedidos"}
MENU2:={"Entrada","Baixa","Consulta de Entradas","Consulta da Baixas","Reajuste de Precos"}
MENU3:={"Lancamentos","Fechamento Diario","Fechamento Mensal","Consulta de Lancamentos Diarios","Consulta de Lancamentos Mensais"}
MENU4:={"Entrada","Saida","Clientes","Fornecedores","Materiais Estocados","Lancamentos Diarios","Lancamentos Mensais","Agenda de Pagamento","Agenda de recebimentos"}
MENU5:={"Excluir Movimentacoes","Alterar Senhas","Sobre...",}
MENU6:={"Clientes","Fornecedores","Estoque",}
MENU7:={"Inclusao de Pagtos.","Inclusao de Receb.","Exclusao de Pagtos.","Exclusao de Receb."}
MENU8:={" Sair "}
MENU:=ARRAY(8,3)
MENU:={{02,01,"Manutencao"},{02,12,"Estoque"},{02,20,"Caixa"},{02,26,"Relatorios"},{02,37,"Utilidades"},{02,48,"Consulta"},{02,57,"Agenda"},{02,69,"Sair"}}

* tela  principal
@ 00,00,24,79 box replicate(chr(178),9) color "b/w"
centra(00,"Controle de Estoque v1.0;  CS # 1995","gr+/b")
centra(01,"Menu Principal","gr+/bg")
centra(24,"<ENTER> - Seleciona; <F1> - Help; <F10> - Sair","gr+/bg")
cCor := setcolor("gr+/b")
sombra(07,20,17,60)
Setcolor("R+/n")
@ 09,22 SAY "Sistema de Controle de Estoques  v1.0"
@ 11,22 SAY "Desenvolvido por Luiz Antonio Carlin "
@ 13,22 SAY "Fone : (0143) 51-2237    Piraju - SP "
@ 15,22 SAY "           Julho / 1995         "
setcolor(cCor)


// TELA PRINCIPAL
SAVE SCREEN TO TELA_DT
// Arquivo de Licenciamento
IF .NOT. file("CE.MEM")
   l_Nome := space(40)
   l_Empresa := space(40)
   sombra(09,20,12,72)
   @ 09,30 say "Licenciado Para:"
   @ 10,21 say "Nome    :" GET l_nome
   @ 11,21 SAY "Empresa :" GET l_empresa
   read
   SAVE TO ce ALL LIKE l_*
   RELEASE ALL LIKE L_*
ENDIF
sombra(11,29,13,51)
@ 12,30 SAY "Data Atual:" GET data_sis PICT "99/99/99"
READ
USE cebagen
SET FILTER TO data_pg = data_sis
GO TOP
IF .NOT. eof()
   mensagem("Ha pagamentos para seren efetuados Hoje!!")
ENDIF
CLOSE ALL
RESTORE SCREEN FROM TELA_DT
SET COLOR TO W/BG+
@ 01,00 CLEAR TO 03,79 
centra(01,"Menu Principal","gr+/bg")
OP := BOTAO(MENU)
do while op > 0
   FOR I := 1 TO len(MENU)
       @ 02,MENU[i][2] SAY MENU[i][3] COLOR  "N+/W"
   NEXT
   @ 02,MENU[OP][2] SAY UPPER(MENU[OP][3]) COLOR  "W/B"
   Set color to bg/n,W/B
   DO CASE              
      CASE OP=1
	   SAVE SCREEN TO TELA
	   SOMBRA(04,01,10,16)
	   ac1=ACHOICE(05,02,09,15,MENU1,.T.,"controle")
	   IF AC1<>0
	      centra(24,"<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos","gr+/bg")
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC1 = 1
	      DO CEMTCLI
	   ELSEIF AC1 = 2
	      DO CEMTFOR
	   ELSEIF ac1 = 3
	      DO cemtest
           ELSEIF ac1 = 4
              DO  CEMTPRE
           ELSEIF AC1 = 5
              DO cemtped
	   ENDIF
           RESTORE SCREEN FROM TELA
      CASE OP=2
	   SAVE SCREEN TO TELA
	   SOMBRA(04,12,10,33)
	   ac2=ACHOICE(05,13,09,32,MENU2,.T.,"controle")
	   IF AC2 < 3
	      centra(24,"<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos","gr+/bg")
	      SET COLOR TO bg/n,w/r
           ELSE
              SET COLOR TO bg/n,w/r
              centra(24,"<ESC> - Sair; <F1> - Help; ","gr+/bg")
	   ENDIF
	   IF ac2 = 1 .OR. ac2 = 2
	      DO cemest  WITH ac2
           ELSEIF ac2 = 3 .OR. ac2 = 4
              DO cecmest WITH ac2
           ELSEIF AC2 = 5
              DO cerjes
	   ENDIF
           RESTORE SCREEN FROM TELA
      CASE OP=3
	   SAVE SCREEN TO TELA
	   SOMBRA(04,20,10,54)
	   ac3=ACHOICE(05,21,17,53,MENU3,.T.,"controle")
           IF AC3<>0
              COR :=SETCOLOR()
              centra(24," ","gr+/bg")
              lLibera := .f.
              lLibera := ExistSenha()
              setcolor(COR)
	      centra(24,"<ESC> - Sair - <F1> - Help; ","gr+/bg")
	      SET COLOR TO bg/n,w/r
	   ENDIF
           IF AC3=1 .and. lLibera
              DO celanca
           ELSEIF (AC3 = 2 .and. lLibera) .OR. (AC3 = 3 .and. lLibera)
              DO cefcaixa WITH AC3 - 1
	   ELSEIF (AC3= 4 .and. lLibera) .OR. (AC3 =5 .and. lLibera)
	      DO cecldm WITH AC3 - 3
           ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=4
	   SAVE SCREEN TO TELA
	   SOMBRA(04,26,14,51)
	   ac4=ACHOICE(05,27,13,50,MENU4,.T.,"controle")
	   IF AC4<>0
	      centra(24,"<ENTER> - Imprime; <DESLIGUE A IMPRESSORA> - SAIR","gr+/bg")
	      SET COLOR TO bg/n,w/r
              CLOSE ALL
              DO cerelat WITH ac4
	   ENDIF
	   RESTORE SCREEN FROM TELA
      case op=5
	   SAVE SCREEN TO TELA
	   SOMBRA(04,37,08,60)
	   ac5=ACHOICE(05,38,07,59,menu5,.T.,"controle")
	   IF AC5<>0
	      centra(24,"<ESC> - Sair","gr+/bg")
	      SET COLOR TO bg/n,w/r
	   ENDIF
           IF AC5 = 1
              DO CEAPMV
           ELSEIF AC5 = 2
              manutsen()
           ELSEIF AC5=3
              sobre()
           endif
	   RESTORE SCREEN FROM TELA
      CASE OP = 6
           SAVE SCREEN TO TELA
	   SOMBRA(04,48,08,61)
	   AC6:=ACHOICE(05,49,07,60,MENU6,.T.,"controle")
	   IF AC6 <> 0
	      centra(24,"<ESC> - Sair; <F1> - Help; ","gr+/bg")
	      SET COLOR TO bg/n,w/r
              DO cecgeral WITH AC6
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=7
           SAVE SCREEN TO TELA
           SOMBRA(04,57,09,77)
           AC7 := ACHOICE(05,58,08,76,MENU7,.T.,"CONTROLE")
           IF AC7 <> 0
              CENTRA(24,"<ESC> - Sair; <F1> - Help; ","GR+/bg")
              SET COLOR TO bg/n,w/r
           ENDIF
           IF AC7 = 1 .OR. AC7 = 2
              DO ceincag WITH AC7
           ELSEIF AC7 >= 3
              SET COLOR TO bg/n,w/r
              DO CECEAGD WITH AC7 - 2
           ENDIF
           RESTORE SCREEN FROM TELA
      CASE OP=8
	   SAVE SCREEN TO TELA
	   SOMBRA(04,69,06,77,.f.)
	   AC8 = ACHOICE (05,70,05,76,MENU8,.T.,"controle")
	   IF AC8<>0
              centra(24," ","gr+/bg")
	      SET COLOR TO  bg/n,w/r
	   ENDIF
	   IF AC8=1
	      SAI()
	   ENDIF
	   RESTORE SCREEN FROM TELA
   endcase
   tecla:=lastkey()
   do CASE
      case TECLA = -9   //tecla= F10
	  op := 8
	  KEYBOARD CHR(13)
      case tecla = 4
	   op++
	  if op>8
	     op:=1
	  endif
     case tecla=19
	  op--
	  if op<1
	     op:=8
	  endif
   endcase
ENDDO
restore screeN from tela_dos
@ linha,coluna
CLOSE ALL
clear memory
QUIT
* eop ce.prg