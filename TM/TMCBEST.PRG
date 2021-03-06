***********************************************************
* bop TMCBEST                                             *
* AUTORES: ANA PAULA, DANIELLE, EVERTON, LUIZ             *
* OBJETIVO: PERMITIR CONSULTA DAS BAIXAS NO ESTOQUE       *
* DATA: 29/09/94                                          *
***********************************************************
close all
PUBLIC NUMERO, CV, L, AX
SELE 1
   USE TMBBEST INDEX TMIEST1
REINDEX
SELE 2
   USE TMBEST INDEX TMIEST
sombra (5,3,20,76,.f.)
@ 05,25 say "CONSULTA DE BAIXAS"
MCODEST = 0
@  07,07 SAY "DIGITE O CODIGO DO ESTOQUE: " GET MCODEST PICT "9999"
READ
IF EMPTY(MCODEST) .AND. LASTKEY() = 13
   TABELA()
ENDIF
IF EMPTY(MCODEST) .AND. LASTKEY() = 27
   RETURN
ENDIF
SELE  2
SEEK MCODEST
IF .NOT. FOUND()
   @ 13,10 SAY "ESTOQUE INEXISTENTE - PRESSIONE ALGO"
   INKEY(0)
   RETURN
ENDIF
MDESC = DESC
SELE 1
SET FILTER TO CODEST = MCODEST
GO TOP
IF EOF()
   @ 13,10 SAY "ESTOQUE SEM BAIXA - PRESSIONE ALGO"
   INKEY(0)
   RETURN
ENDIF
DECLARE CAMPOS[3]
CAMPOS[1] = "DATAB"
CAMPOS[2] = "QTD"
CAMPOS[3] = "VALOR"
DECLARE MASC[3]
MASC[1] = "99/99/99"
MASC[2] = "9999"
MASC[3] = "999,999.99"
DECLARE TIT[3]
TIT[1] = "DATA"
TIT[2] = "QUANTIDADE"
TIT[3] = "VALOR"
desbarr(07,19,76,1)
CV=0
L=8
NUMERO=RECCOUNT()/12
PUBLIC NUMERO, L, CV
DBEDIT(7,4,19,75,CAMPOS,"CONSULTA",MASC,TIT,.T.,.T.)
SET FILTER TO
CLOSE ALL
RELEASE CV, L, NUMERO
RETURN

* eop TMCBEST