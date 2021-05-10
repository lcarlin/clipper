*********************************************************************
* BOP CVRFUNC.PRG                                                   *
* PROGRAMA  : CVRFUNC.PRG                                           *
* OBJETIVO  : RELATORIOS DE FUNCIONARIOS                            *
* AUTORES   : OSWALDO COELHO DE OLIVEIRA JUNIOR                     *
* DATA      : 30/05/94                                              *
*********************************************************************

SAVE SCREEN TO TELA_RFUNC
USE CVBFUNC INDEX CVIFUN1
GO TOP
OPR2=OPREL(5,27)
IF OPR2 = 0 .OR. OPR2=4
   CLOSE DATABASES
   RESTORE SCREEN FROM TELA_RFUNC
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
       RESTORE SCREEN FROM TELA_RFUNC
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
   LABEL FORM ETIQFUNC TO PRINT
   RETURN
ENDIF
PUBLIC PG
PG = 0
L = 8
GO TOP
IF TELIMP=.T.
   CABER("FIAT - Fralleti Ltda. ","RELATORIO DE FUNCIONARIOS",telimp)
   RG("FUN")
ENDIF
IF TELIMP=.F.
    REL("FUNCIONARIOS")
    RG("FUN")
ENDIF
DO WHILE .NOT. EOF()
   @ L,0  SAY CODFUN
   @ L,8  SAY NOMFUN
   @ L,48 SAY SALFUN
   L = L + 1
   SKIP
   IF L >= NL
      PG = PG +1
      IF NL = 21
         MENSAGEM(" ",24)
         L=8
      ENDIF
      IF TELIMP=.T.
          CABER("FIAT - Fralleti Ltda. ","RELATORIO DE FUNCIONARIOS",telimp)
          RG("FUN")
      ENDIF
      IF TELIMP=.F.
          REL("FUNCIONARIOS")
          RG("FUN")
      ENDIF
   ENDIF
ENDDO
SET DEVICE TO SCREEN
MENSAGEM("Final da Listagem ",24)
RESTORE SCREEN FROM TELA_RFUNC
RETURN

*EOP CVRFUNC.PRG