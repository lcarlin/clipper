***********************************************************
* bop TMRCX                                               *
* AUTORES: ANA PAULA, DANIELLE, EVERTON, LUIZ             *
* OBJETIVO: EMITIR RELATORIOS MENSAIS E DIARIOS DO CAIXA  *
* DATA: 06/10/94                                          *
***********************************************************
SELE 1
   USE TMBLCD
SELE 2
   USE TMBLMC
SOMBRA(5,60,8,69,.F.)
LAN = 0
@ 6,61 PROMPT " DIARIO "
@ 7,61 PROMPT " MENSAL "
MENU TO LAN
IF LASTKEY() = 27
   RETURN
ENDIF
IF LAN = 1
   SELE 1
   CX     = " DIARIO "
   CABEC  = "DESCRI€AO"
   CAMPO1 = "VALOR"
   CAMPO2 = "TIPO"
   CAMPO3 = "DESC"
ELSE
   SELE 2
   CX     = " MENSAL "
   CABEC  = "DATA"
   CAMPO1 = "TOTDIA"
   CAMPO2 = "TIPO"
   CAMPO3 = "DIA"
ENDIF
SOMBRA(6,55,9,69,.F.)
@ 7,57 PROMPT "   VIDEO    "
@ 8,57 PROMPT " IMPRESSORA "
MENU TO LAN
IF LASTKEY() = 27
   RETURN
ENDIF
IF LAN = 1
   NL = 23
   IMP = .F.
ELSE
   IF .NOT. ISPRINTER()
      SOMBRA(11,10,13,38,.F.)
      @ 12,12 SAY "IMPRESSORA NŽO PREPARADA!"
      INKEY(5)
      RETURN
   ENDIF
   SOMBRA(11,10,13,31,.F.)
   @ 12,12 SAY "AGUARDE IMPRIMINDO!"
   SET DEVICE TO PRINTER
   SET CONSOLE OFF
   NL = 60
   IMP = .T.
ENDIF
P = 1
L = 7
CABECALHO("RELATORIO"+CX+"DO CAIXA",1,IMP)
@ 6,2 SAY "VALOR"
@ 6,16 SAY "TIPO"
@ 6,21 SAY CABEC
DO WHILE .NOT. EOF()
   @ L,02 SAY &CAMPO1 PICT "999,999.99"
   @ L,16 SAY &CAMPO2
   @ L,21 SAY &CAMPO3
   L = L+1
   IF L >= NL
      P = P+1
      L = 7
      IF LAN = 2
         EJECT
      ENDIF
      CABECALHO("RELATORIO"+CX+"DO CAIXA",P,IMP)
      @ 6,2 SAY "VALOR"
      @ 6,16 SAY "TIPO"
      @ 6,21 SAY CABEC
   ENDIF
   SKIP
ENDDO
IF IMP
   EJECT
   SET DEVICE TO SCREEN
ELSE
   @ 24,20 SAY "Pressione Algo..."
   INKEY(0)
ENDIF
CLOSE ALL
RETURN

* EOP TMRCX.PRG