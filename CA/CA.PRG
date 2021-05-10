/*

bop ca.prg
data      : 07/07/95
autor     : Luiz Antonio Carlin
funcao    : Menu principal do Controle de acouques
sistema   : Controle ACOUGES
modulo    : ca.prg
linguagem : clipper 5.01
*/



* variaveis do DOS
PUBLIC linha:=row()
PUBLIC coluna:=col()
PUBLIC tela_dos
PUBLIC data_sis := date()

SAve screen to tela_dos
clear
* ambiente

/*
cCont := ["O Corsario(tm)"]
IF .NOT. memowrit("b:\test.dsk",cCont)
   ?"Unidade B: nao preparada!!!"
   quit
ENDIF
*/

// Verifica se a coia e pirata
ARQUIVO = MEMOREAD("C:\CONTROL_.LOG")
IF empty(ARQUIVO) .or. ARQUIVO <> "CS # 1995 Controle de Acougues v1.0 - L.A.C. - {O Corsario(tm)}"
   ?
   ?"Copia Ilegal !!! Acesso nao Permitido"
   ?
   quit
ENDIF

setblink(.t.)
set score off
set date british
set wrap on
set delete on
set procedure to CAfunc
SET KEY 277 TO MUSICA1
SET KEY 301 TO MUSICA2
SET KEY -19 TO CALC ()
// verifica arquivos dbfs e dbts
EXISTE := .T.
IF .NOT. FILE("caBCLI.DBF") .OR. .NOT. FILE("CABCLI.DBT")
   ?"Criando arquivo de clientes"
   aEstru1 := {{"CODIGO    ","C",06,0},;
               {"NOME      ","C",40,0},;
               {"ENDERECO  ","C",40,0},;
               {"TELEFONE  ","C",15,0},;
               {"OBS       ","M",10,0},;
               {"CIDADE    ","C",30,0}}
    dbcreate("CABCLI",aEstru1)
ENDIF

IF .NOT. FILE("CABEST.DBF")
   ?"Criando arquivo de estoques"
   aEstru1 := {{"CODIGO    ","C",06,0},;
               {"PRODUTO   ","C",40,0},;
               {"VALUNIT   ","N",10,2},;
               {"QTD       ","N",04,0},;
               {"MARCADO   ","C",01,0}}
   dbcreate("CABEST",aEstru1)
ENDIF
IF .NOT. FILE("CABLMC.DBF")
   ?"Criando arquivo de lancamentos mensais"
   aEstru1 := {{"DESCRICAO ","C",40,0},;
               {"VALOR     ","N",10,2},;
               {"DATA      ","D",08,0},;
               {"TIPO      ","C",01,0}}
    dbcreate("CABLMC",aEstru1)
ENDIF
IF .NOT. FILE("CABLANCA.DBF")
   ?"Criando arquivo de lancamentos diarios"
   aEstru1 := {{"DESCRICAO ","C",40,0},;
               {"VALOR     ","N",10,2},;
               {"DATA      ","D",08,0},;
               {"TIPO      ","C",01,0},;
               {"NMOV      ","C",16,0}}
    dbcreate("CABLANCA",aEstru1)
ENDIF
IF .NOT. FILE("CABcusto.DBF")
   ?"Criando arquivo de custos mensais"
   aEstru1 := {{"DESCRICAO ","C",40,0},;
               {"VALOR     ","N",10,2},;
               {"DATA      ","D",08,0},;
               {"TIPO      ","C",01,0}}
    dbcreate("CABcusto",aEstru1)
ENDIF
IF .NOT. FILE("CABMEST.DBF")
   ?"Criando arquivo de cruzamento de dados"
   aEstru1 := {{"COD_PES   ","C",06,0},;
               {"PESSOA    ","C",40,0},;
               {"COD_ITEM  ","C",06,0},;            
               {"ITEM      ","C",40,0},;
               {"QUANT     ","N",08,3},;
               {"VAL_UNI   ","N",10,2},;
               {"VAL_TOT   ","N",10,2},;
               {"DATA_NEG  ","D",08,0},;            
               {"TIPO      ","C",01,0},;
               {"SELEC     ","C",01,0},;
               {"NMOV      ","C",16,0}}
   dbcreate("CABMEST",aEstru1)
ENDIF

IF .NOT. FILE("CABAGEN.DBF")
   ?"Criando arquivo de agenda de pagamento"
   aEstru1 := {{"CODIGO    ","C",06,0},;
               {"NOME_FOR  ","C",40,0},;
               {"VALOR     ","N",10,2},;
               {"DATA_PG   ","D",08,0},;
               {"SELEC     ","C",01,0},;
               {"TIPO_CAR  ","C",40,0},;
               {"TIPO      ","C",01,0},;
               {"QTD_CAR   ","N",08,3},;
               {"NMOV      ","C",16,0}}
   dbcreate("CABAGEN",aEstru1)
ENDIF

IF .NOT. FILE("CABCEST.DBF")
   ?"Criando arquivo de compra de mercadorias"
   aEstru1 := {{"DESCRICAO ","C",40,0},;
               {"PROCEDENC ","C",40,0},;
               {"DATA_COM  ","D",08,0},;            
               {"DATA_VEN  ","D",08,0},;
               {"DIAS_PRAZ ","N",02,0},;
               {"VAL_ARR   ","N",10,2},;
               {"VAL_TOT   ","N",10,2},;            
               {"ARROBAS   ","N",09,3},;
               {"SELEC     ","C",01,0},;
               {"NMOV      ","C",16,0}}
   dbcreate("CABCEST",aEstru1)
ENDIF


* iNDICES

// INDICE DO CLIENTE
IF .NOT. file("CAICLI.NTX")
   ?"Organizando arquivo de clientes"
   USE CAbcli
   INDEX ON Codigo TO CAicli
   CLOSE ALL
ENDIF


IF .NOT. file("CAICLI2.NTX")
   ?"Organizando arquivo de clientes II"
   USE CAbcli
   INDEX ON NOME  TO CAiclI2
   CLOSE ALL
ENDIF

// indiCA do estoque
IF .NOT. file("CAIEST.NTX")
   ?"Organizando arquivo de estoque"
   USE CABEST
   INDEX ON Codigo TO CAiest
   CLOSE ALL
ENDIF

IF .NOT. file("CAIEST2.NTX")
   ?"Organizando arquivo de estoque II"
   USE CABEST
   INDEX ON PRODUTO TO CAiest2
   CLOSE ALL
ENDIF

// indice da movimentacao de estoque
IF .NOT. file("CAIMEST.NTX")
   ?"Organizando arquivo de movimentacao"
   USE CAbmest
   INDEX ON data_neg TO CAimest
   close all
endif

// INDICE DA AGENDA
IF .NOT. file ("CAIAGEN.NTX")
   ?"Organizando arquivo da agenda de pagamentos"
   USE CAbagen
   INDEX ON data_pg TO CAIAGEN
   CLOSE ALL
ENDIF


* variaveis do menus principais
op := 1
MENU1:={"Clientes","Estoque","Senhas"}
MENU2:={"Vendas de Produtos","Compras de Produtos","Consulta da Vendas","Consulta de Compras","Reajuste de Precos","Excluir Movimentacoes"}
MENU3:={"Lancamentos","Fechamento Diario","Fechamento Mensal","Consulta de Lancamentos Diarios","Consulta de Lancamentos Mensais","Consulta de Custos Mensais","Exclusao de Custos"}
MENU4:={"Pesquisa/Recebimento","Pesquisa/Pagamento"}
MENU5:={"Clientes","Estoque"}
MENU6:={"Copia de Seguranca","Restaura Arquivos","Consulta Dados"}
MENU7:={" Sair "}
MENU := ARRAY(7,3)

MENU := {{02,01,"Manutencao"},{02,12,"Vendas"},{02,19,"Caixa"},{02,25,"Pagamentos"},{02,36,"Consulta"},{02,45,"Utilitarios"},{02,69,"Sair"}}

* tela  principal
@ 00,00,24,79 box replicate(chr(178),9) color "b/w"
centra(00,"Controle de Acougues v1.0;  CS # 1995","gr+/b")
centra(01,"Menu Principal","gr+/bg")
centra(24,"<ENTER> - Seleciona; <F1> - Help; <ESC> - Sair","gr+/bg")


// TELA PRINCIPAL
SAVE SCREEN TO TELA_DT

sombra(11,29,13,51)
@ 12,30 SAY "Data Atual:" GET data_sis PICT "99/99/99"
READ
USE CAbagen
SET FILTER TO data_pg = data_sis
GO TOP
IF .NOT. eof()
   mensagem("Ha pagamentos/recebintos para serem efetuados Hoje!!")
ENDIF
CLOSE ALL
IF DAY(DATA_SIS)=1
   IF confirma("Primeiro dia do mes, Posso excluir movimentacoes do mes passado")
      USE CABMEST INDEX CAIMEST
      ZAP
      USE CABCEST
      ZAP
      CLOSE ALL
   ELSE
      MENSAGEM("Para excluir movimentacoes, Utilize a Opcao VENDA\EXCLUI MOVIMENTOS")
   ENDIF
ENDIF
RESTORE SCREEN FROM TELA_DT
SET COLOR TO W/BG+
@ 01,00 CLEAR TO 03,79 
centra(01,"Menu Principal","gr+/bg")
SET COLOR TO gr+/b
sombra(07,20,17,60)
SET COLOR TO
@ 09,22 SAY "Sistema de Controle de Acougues  v1.0"
@ 11,22 SAY "Desenvolvido por Luiz Antonio Carlin "
@ 13,22 SAY "Fone : (0143) 51-2237    Piraju - SP "
@ 15,22 SAY "           Julho / 1995         "
SET COLOR TO GR+/B
sombra(19,62,22,76)
@ 20,63 SAY "<SHIFT>+<F10>" color "w/b"
@ 21,63 SAY " Calculadora " color "w/b"
SET COLOR TO W/BG+
OP := BOTAO(MENU)
do while op > 0
   centra(24,"<ENTER> - Seleciona; <F1> - Help; <F10> - Sair","gr+/bg")
   FOR I := 1 TO LEN(MENU)
       @ 02,MENU[I][2] SAY MENU[I][3]  COLOR "N+/W"
   NEXT                                      
   @ 02,MENU[OP][2] SAY UPPER(MENU[OP][3]) COLOR  "W/B"
   Set color to w/n,n/w
   DO CASE
      CASE OP=1
	   SAVE SCREEN TO TELA
	   SOMBRA(04,01,08,10)
	   ac1=ACHOICE(05,02,07,09,MENU1,.T.,"controle")
	   IF AC1<3
	      centra(24,"<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos","gr+/bg")
           ELSE
              centra(24," ","gr+/bg")
	   ENDIF
	   IF AC1 = 1
 	      DO CAMTCLI
	   ELSEIF AC1 = 2
 	      DO CAmtest
           ELSEIF AC1 = 3
              manutsen()
	   ENDIF
           RESTORE SCREEN FROM TELA
      CASE OP=2
	   SAVE SCREEN TO TELA
 	   SOMBRA(04,12,11,36)
	   ac2=ACHOICE(05,13,10,35,MENU2,.T.,"controle")
	   IF AC2 = 1
	      centra(24,"<ESC> - Sair; <F1> - Help; <ENTER> - Tabela de Codigos","gr+/bg")
              DO camest
           ELSE
              centra(24,"<ESC> - Sair; <F1> - Help; ","gr+/bg")
              IF AC2 = 2
                 DO cacprod
              ELSEIF ac2 = 3
                 DO CAcmest
              ELSEIF AC2 = 4
                  DO caccest
              ELSEIF AC2 = 5
                 DO CArjes
              ELSEIF ac2 = 6
                 centra(24," ","gr+/bg")
                 IF confirma("Deseja Realmente Excluir as movimentacoes (COMPRA/VENDA)?")
                    USE CABMEST INDEX CAIMEST
                    ZAP
                    USE CABCEST
                    ZAP
                    CLOSE ALL
                  ENDIF
              ENDIF
	   ENDIF
           RESTORE SCREEN FROM TELA
      CASE OP=3
	   SAVE SCREEN TO TELA
	   SOMBRA(04,19,12,51)
	   ac3=ACHOICE(05,20,17,50,MENU3,.T.,"controle")
	   IF AC3<>0
              COR :=SETCOLOR()
              centra(24," ","gr+/bg")
              lLibera := ExistSenha()
              SETCOLOR(COR)
	   ENDIF
           IF ( AC3=1 .AND. lLibera )
              centra(24,"<ESC> - Sair; <F1> - Help; ","gr+/bg")
              DO CAlanca
           ELSEIF ( AC3 = 2 .AND. lLibera )  
              DO cafcdia
           ELSEIF ( AC3 = 3 .AND. lLibera )
              DO CAfcaixa WITH AC3 - 1
	   ELSEIF ( AC3= 4 .AND. lLibera ) .OR. ( AC3 =5 .AND. lLibera ) .OR. ( AC3= 6 .AND. lLibera )
              centra(24,"<ESC> - Sair; <F1> - Help; ","gr+/bg")
	      DO CAcldm WITH AC3 - 3
            ( AC3= 6 .AND. lLibera )
           ELSEIF ( AC3= 7 .AND. lLibera )
                 centra(24," ","gr+/bg")
                 IF confirma("Deseja Realmente Excluir os Custo Mensais ? ")
                    sombra(12,23,14,40)
                    @ 13,24 SAY "Aguarde !!!" COLOR "R+/N"
                    USE CABcusto iNDEX CAIMEST
                    ZAP
                    CLOSE ALL
                  ENDIF
           ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=4
	   SAVE SCREEN TO TELA
	   SOMBRA(04,25,07,46)
	   ac4=ACHOICE(05,26,06,45,MENU4,.T.,"controle")
	   IF AC4<>0
              IF AC4=1
                 centra(24,"<ESC> - Sair ; <F1> - Help; <ENTER> - Tabela de codigos","gr+/bg")
                 DO capagto
              ELSE
                 centra(24,"<ESC> - Sair ; <F1> - Help;","gr+/bg")
                 DO CACEAGD WITH 3
              endif
	   ENDIF
	   RESTORE SCREEN FROM TELA
      case op=5
	   SAVE SCREEN TO TELA
	   SOMBRA(04,36,07,45)
	   ac5=ACHOICE(05,37,06,44,menu5,.T.,"controle")
	   IF AC5<>0
              centra(24,"<ESC> - Sair; <F1> - Help; ","gr+/bg")
              DO CACGERAL WITH AC5
	   ENDIF
	   RESTORE SCREEN FROM TELA
      case op=6
	   SAVE SCREEN TO TELA
	   SOMBRA(04,45,08,66)
	   ac6=ACHOICE(05,46,07,65,menu6,.T.,"controle")
	   IF AC6<>0
              centra(24,"<ESC> - Sair; <F1> - Help; ","gr+/bg")
              IF ac6 < 3
                 DO CACpARQ  WITH AC6
              ELSE
                 DO CACCSEG
              ENDIF
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=7
           SAVE SCREEN TO TELA
           sOMBRA(04,69,06,77)
	   AC7 = ACHOICE (05,70,05,76,MENU7,.T.,"controle")
           IF AC7 <> 0
              CENTRA(24," ","GR+/bg")
              sai()
           ENDIF
           RESTORE SCREEN FROM TELA
   endcase
   
   tecla:=lastkey()
   do CASE
      case TECLA = -9   //tecla= F10
	  op := 7
	  KEYBOARD CHR(13)
      case tecla = 4
	   op++
	  if op>7
	     op:=1
	  endif
     case tecla=19
	  op--
	  if op<1
	     op:=7 
          endif
   endcase
ENDDO
restore screeN from tela_dos
@ linha,coluna
CLOSE ALL
clear memory
QUIT

PROCEDURE MUSICA1 ()
TONE(294,5)
TONE(294,3)
TONE(247,7)
TONE(330,3)
TONE(294,7)
TONE(247,12)
RETURN

PROCEDURE MUSICA2 ()
TONE(261,7)
TONE(349,3)
TONE(493,20)
TONE(440,4)
TONE(392,3)
TONE(349,3)
TONE(329,2)
TONE(311,29)
RETURN

procedure calc
calculad(15,45,"b")
return

* eop CA.prg