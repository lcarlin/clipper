*********************************************************************
* BOP CVRSERV                                                       *
* PROGRAMA  : CVRRSERV                                              *
* OBJETIVO  : RELATORIOS DE SERVICOS EM GERAL                       *
* AUTORES   : WILSON/OSWALDO                                        *
* DATA      : 27/06/94                                              *
*********************************************************************

SAVE SCREEN TO TELA_RCLI
BORDA(05,55,10,71)
OPR=0
@ 06,56 PROMPT "Vendas de Pecas"
@ 07,56 PROMPT "Reparos        "
@ 08,56 PROMPT "Consorcios     "
@ 09,56 PROMPT "Pronta Entrega "
MENU TO OPR
OPR2=OPREL(7,63)
IF OPR2 = 0 .OR. OPR2=4
   CLOSE DATABASES
   RESTORE SCREEN FROM TELA_RCLI
   RETURN
ELSEIF OPR2 = 1
   NL = 21
   telimp = .f.
   CLEAR
ELSEIF OPR2 = 2
   DO WHILE .NOT. ISPRINTER()
      MEIO("Impressora nao Preparada; [ENTER] p/ Continuar ou [ESC] P/ Sair",24)
      if inkey(.1) = 27
         return
      endif
   ENDDO
   telimp = .t.
   NL = 60
   SET DEVICE TO PRINTER
   SET CONSOLE OFF
ENDIF
IF OPR=1
   do ven_pec with NL,telimp
ELSEIF OPR=2
   do rep with NL,telimp
ELSEIF OPR=3
   do cons with NL,telimp
ELSE
   do pron_entr with NL,telimp
ENDIF
return

***************************************
procedure ven_pec
***************************************

parameters NL,telimp
USE CVPECAS 

PG = 0
L = 10
IF TELIMP=.T.
   CABER("FIAT - Fralleti Ltda.","RELATORIO DE VENDA DE PECAS",telimp)
   RG("VPE")
ENDIF
IF TELIMP=.F.
   REL("VENDA DE PECAS")
   RG("VPE")
ENDIF
DO WHILE .NOT. EOF()
   @ L,0  SAY CODCLI
   @ L,10 SAY DECPEC
   @ L,50 SAY QTPECC
   @ L,60 SAY VALTOT
   L = L + 1
   SKIP
   IF L >= NL
      PG = PG +1
      IF NL = 21
         MENSAGEM(" ",24)
         CLEAR
	 L=10
      ENDIF
      IF TELIMP=.T.
          CABER("FIAT - Fralleti Ltda.","RELATORIO DE VENDA DE PECAS",telimp)
          RG("VPE")
      ENDIF
      IF TELIMP=.F.
         REL("VENDA DE PECAS")
         RG("VPE")
      ENDIF
   ENDIF
ENDDO
SET DEVICE TO SCREEN
MENSAGEM("Final da Listagem ",24)
RESTORE SCREEN FROM TELA_RCLI
RETURN

***************************************************
PROC REP
***************************************************
parameters NL,telimp
USE CVPECAS
PG = 0
L = 10
IF TELIMP=.T.
   CABER("FIAT - Fralleti Ltda.","RELATORIO DE ORCAMENTOS",telimp)
   RG("VRE")
ENDIF
IF TELIMP=.F.
   REL("ORCAMENTO")
   RG("VRE")
ENDIF
DO WHILE .NOT. EOF()
   @ L,0  SAY CODPEC
   @ L,12 SAY CODCLI
   @ L,24 SAY QTPECC
   @ L,36 SAY DECPEC
   @ L,66 SAY VALTOT
   L = L + 1
   SKIP
   IF L >= NL
      PG = PG +1
      IF NL = 21
         MENSAGEM(" ",24)
         CLEAR
	 L=10
      ENDIF
      IF TELIMP=.T.
          CABER("FIAT - Fralleti Ltda.","RELATORIO DE ORCAMENTO",telimp)
          RG("VRE")
      ENDIF
      IF TELIMP=.F.
         REL("ORCAMENTO")
         RG("VRE")
      ENDIF
   ENDIF
ENDDO
SET DEVICE TO SCREEN
MENSAGEM("Final da Listagem ",24)
RESTORE SCREEN FROM TELA_RCLI
RETURN


***************************************************
PROC CONS
***************************************************
parameters NL,telimp
USE CVBGRUCO
PG = 0
L = 10
IF TELIMP=.T.
   CABER("FIAT - Fralleti Ltda.","RELATORIO DE CONSORCIOS",telimp)
   RG("RE")
ENDIF
IF TELIMP=.F.
   REL("CONSORCIOS")
   RG("RE")
ENDIF
DO WHILE .NOT. EOF()
   @ L,4  SAY CODCLI
   @ L,12 SAY NUMGRUP
   @ L,24 SAY NUMPRES
   @ L,36 SAY CODCAR
   @ L,48 SAY DATENT
   @ L,58 SAY DATFEC
   @ L,68 SAY VALPRES
   L = L + 1
   SKIP
   IF L >= NL
      PG = PG +1
      IF NL = 21
         MENSAGEM(" ",24)
         CLEAR
	 L=10
      ENDIF
      IF TELIMP=.T.
         
 CABER("FIAT - Fralleti Ltda.","RELATORIO DE CONSORCIOS",telimp)
          RG("RE")
      ENDIF
      IF TELIMP=.F.
         REL("CONSORCIOS")
         RG("RE")
      ENDIF
   ENDIF
ENDDO
SET DEVICE TO SCREEN
MENSAGEM("Final da Listagem ",24)
RESTORE SCREEN FROM TELA_RCLI
RETURN

***************************************************
PROC pron_entr
***************************************************
parameters NL,telimp
USE CVBPENT
PG = 0
L = 10
IF TELIMP=.T.
   CABER("FIAT - Fralleti Ltda.","RELATORIO DE PRONTA ENTREGA",telimp)
   RG("PRE")
ENDIF
IF TELIMP=.F.
   REL("PRONTA ENTREGA")
   RG("PRE")
ENDIF
DO WHILE .NOT. EOF()
   @ L,0  SAY CODCAR
   @ L,11 SAY DESCAR
   @ L,39 SAY VALCAR
   @ L,55 SAY DATAV
   @ L,66 SAY CODCLI
   L = L + 1
   SKIP
   IF L >= NL
      PG = PG +1
      IF NL = 21
         MENSAGEM(" ",24)
         CLEAR
	 L=10
      ENDIF
      IF TELIMP=.T.
          CABER("FIAT - Fralleti Ltda.","RELATORIO DE PRONTA ENTREGA",telimp)
          RG("PRE")
      ENDIF
      IF TELIMP=.F.
         REL("PRONTA ENTREGA")
         RG("PRE")
      ENDIF
   ENDIF
ENDDO
SET DEVICE TO SCREEN
MENSAGEM("Final da Listagem ",24)
RESTORE SCREEN FROM TELA_RCLI
RETURN