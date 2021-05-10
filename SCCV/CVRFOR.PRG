*********************************************************************
* BOP CVRFOR.PRG                                                    *
* PROGRAMA  : CVRCLI.PRG                                            *
* OBJETIVO  : RELATORIOS DE FORNECEDORES                            *
* AUTORES   : WILSON/OSWALDO                                        *
* DATA      : 30/05/94                                              *
*********************************************************************

SAVE SCREEN TO TELA_RCLI
USE CVBFORNE INDEX CVIFOR1
OPR2=OPREL(5,40)
IF OPR2 = 0 .OR. OPR2=4
   CLOSE DATABASES
   RESTORE SCREEN FROM TELA_RCLI
   RETURN
ELSEIF OPR2 = 1
   NL = 23
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
   LABEL FORM ETIQFOR TO PRINT
   RETURN
ENDIF
PUBLIC PG
PG = 0
L = 8
IF TELIMP=.T.
   CABER("FIAT - Fralleti Ltda.","RELATORIO DE FORNECEDORES",telimp)
   RG("FOR")
   ??i20
ENDIF
IF TELIMP=.F.
   REL("FORNECEDORES")
   RG("FOR")
ENDIF
DO WHILE .NOT. EOF()
   @ L,0 SAY CODFOR
   @ L,8 SAY DESITE
   @ L,50 SAY NOMFAB
   L = L + 1
   SKIP
   IF L >= NL
      PG = PG +1
      IF NL = 18
         MENSAGEM(" ",24)
         CLEAR
         L=8
      ENDIF
      IF TELIMP=.T.
          CABER("FIAT - Fralleti Ltda.","RELATORIO DE FORNECEDORES",telimp)
          RG("FOR")
          ??i20
      ENDIF
      IF TELIMP=.F.
          REL("FORNECEDOR")
          RG("FOR")
      ENDIF
   ENDIF
ENDDO
SET DEVICE TO SCREEN
MENSAGEM(" Final da Listagem ", 24)
RESTORE SCREEN FROM TELA_RCLI
RETURN


*EOP CVRCLI.PRG