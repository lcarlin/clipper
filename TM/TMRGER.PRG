***********************************************************
* bop TMRGER                                              *
* AUTORES: ANA PAULA, DANIELLE, EVERTON, LUIZ             *
* OBJETIVO: EMITIR RELATORIOS DA AGENDA                   *
* DATA: 07/10/94                                          *
***********************************************************
USE TMBAGEN
SOMBRA(09,57,12,70,.F.)
AGEN = 0
@ 10,59 PROMPT "  VIDEO   "
@ 11,59 PROMPT "IMPRESSORA"
MENU TO AGEN
IF LASTKEY() = 27
   RETURN
ENDIF
IF AGEN = 1
   NL  = 23
   IMP = .F.
ELSE
   IF .NOT. ISPRINTER()
       SOMBRA(11,10,13,39,.F.)
       @ 12,12 SAY "IMPRESSORA NŽO PREPARADA!"
       INKEY(5)
       RETURN
   ENDIF
   SOMBRA(11,10,13,33,.F.)
   @ 12,12 SAY "AGUARDE IMPRIMINDO!"
   SET DEVICE TO PRINTER
   SET CONSOLE OFF
   NL = 60
   IMP = .T.
ENDIF
P = 1
L = 7
CABECALHO("RELATORIO DE CLIENTES DEVEDORES",1,IMP)
@ 06,02 SAY "DATA VENDA"
@ 06,13 SAY "CODIGO"
@ 06,20 SAY "NOME"
@ 06,57 SAY "VALOR"
@ 06,69 SAY "DATA PAG."
DO WHILE .NOT. EOF()
   @ L,02 SAY DTA
   @ L,13 SAY CODCLI
   @ L,20 SAY NOME
   @ L,57 SAY VALOR PICT "999,999.99"
   @ L,69 SAY DTPG
   L = L+1
   IF L >= NL
      P = P+1
      L = 7
      IF IMP
         EJECT
      ENDIF
      CABECALHO("RELATORIO DE CLIENTES DEVEDORES",P,IMP)
      @ 6,2  SAY "DATA VENDA"
      @ 6,13 SAY "CODIGO"
      @ 6,20 SAY "NOME"
      @ 6,57 SAY "VALOR"
      @ 6,69 SAY "DATA PAG."
   ENDIF
   SKIP
ENDDO
IF IMP
   EJECT
ELSE
   @ 24,20 SAY "Pressione Algo..."
   INKEY(0)
ENDIF
SET DEVICE TO SCREEN
CLOSE ALL
RETURN

* EOP TMRGER.PRG