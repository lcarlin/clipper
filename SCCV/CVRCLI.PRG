*********************************************************************
* BOP CVRCLI.PRG                                                    *
* PROGRAMA  : CVRCLI.PRG                                            *
* OBJETIVO  : RELATORIOS DE CLIENTES E CONSORCIADOS                 *
* AUTORES   : EVERTON/LUIZ                                          *
* DATA      : 30/05/94                                              *
*********************************************************************

SAVE SCREEN TO TELA_RCLI
BORDA(04,14,08,27)
USE CVBCLIEN INDEX CVICLI1
OPR=0
@ 05,15 PROMPT "Consorciados"
@ 06,15 PROMPT " Clientes   "
@ 07,15 PROMPT "   Ambos    "
MENU TO OPR
IF OPR=1
   GO TOP
   SET FILTER TO CONSOR="S"
   GO TOP
ELSEIF OPR=2
   GO TOP
   SET FILTER TO CONSOR="N"
   GO TOP
ELSEIF OPR=3
   GO TOP
   SET FILTER TO
   GO TOP
ELSE
  CLOSE DATABASES
  RESTORE SCREEN FROM TELA_RCLI
  RETURN
ENDIF
OPR2=OPREL(5,21)
IF OPR2 = 0 .OR. OPR2=4
   CLOSE DATABASES
   RESTORE SCREEN FROM TELA_RCLI
   RETURN
ELSEIF OPR2 = 1
   NL = 21
   telimp = .f.
   CLEAR
ELSEIF OPR2 = 2
   IF .NOT. ISPRINTER()
      MENSAGEM("VERIFIQUE A IMPRESSORA",12)
   ENDIF
   IF .NOT. ISPRINTER()
       CLOSE DATABASES
       RESTORE SCREEN FROM TELA_RCLI
       RETURN
   ENDIF
   telimp = .t.
   NL = 60
   SET DEVICE TO PRINTER
   SET CONSOLE OFF
ENDIF
IF OPR2=3
   DO WHILE .NOT. ISPRINTER()
      MEIO("Impressora nao Preparada; [ENTER] p/ Continuar ou [ESC] P/ Sair",24)
      if inkey(.1) = 27
         return
      endif
   ENDDO
   LABEL FORM ETIQCLI TO PRINT
   RETURN
ENDIF
PUBLIC PG
PG = 0
L = 8
IF TELIMP=.T.
   CABER("FIAT - Fralleti Ltda.","RELATORIO DE CLIENTES",telimp)
   RG("CLI")
ENDIF
IF TELIMP=.F.
   REL("CLIENTES")
   RG("CLI")
ENDIF
DO WHILE .NOT. EOF()
   @ L,0 SAY CODCLI
   @ L,08 SAY NOMCLI
   @ L,44 SAY TELCLI
   @ L,59 SAY CIDCLI
   L = L + 1
   SKIP
   IF L >= NL
      PG = PG +1
      IF NL = 21
         MENSAGEM(" ",24)
         CLEAR
	 L=8
      ENDIF
      IF TELIMP=.T.
          CABER("FIAT - Fralleti Ltda.","RELATORIO DE CLIENTES",telimp)
          RG("CLI")
      ENDIF
      IF TELIMP=.F.
         REL("CLIENTES")
         RG("CLI")
      ENDIF
   ENDIF
ENDDO
SET DEVICE TO SCREEN
MENSAGEM("Final da Listagem ",24)
RESTORE SCREEN FROM TELA_RCLI
RETURN

* EOP CVRCLI.PRG