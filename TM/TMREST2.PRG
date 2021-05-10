*****************************************************************
* bop TMREST                                                   *
* AUTORES: ANA PAULA, DANIELLE, EVERTON, LUIZ                  *
* OBJETIVO: EMITIR RELATORIOS DE BAIXAS E ENTRADAS DO ESTOQUE  *
* DATA: 06/10/94                                               *
****************************************************************
USE TMBEST INDEX TMIEST
SOMBRA(5,60,8,73,.F.)
LAN = 0
@ 6,62 PROMPT "  VIDEO   "
@ 7,62 PROMPT "IMPRESSORA"
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
CABECALHO("RELATORIO DO ESTOQUE",1,IMP)
@ 6,2 SAY "CODIGO"
@ 6,9 SAY "DESCRICAO"
@ 6,45 SAY "QTD"
@ 6,50 SAY "QTD.MIN"
@ 6,59 SAY "VAL.UNIT"
@ 6,71 SAY "DATA"
DO WHILE .NOT. EOF()
   @ L,02 SAY CODEST
   @ L,09 SAY DESC
   @ L,45 SAY QUANT
   @ L,50 SAY QTMIN
   @ L,59 SAY VALUNIT
   @ L,71 SAY DATATU
   L = L+1
   IF L >= NL
      P = P+1
      L = 7
      IF IMP
         EJECT
      ENDIF
      CABECALHO("RELATORIO DO ESTOQUE",P,IMP)
      @ 6,2 SAY "CODIGO"
      @ 6,10 SAY "DESCRICAO"
      @ 6,47 SAY "QTD"
      @ 6,52 SAY "QTD.MIN"
      @ 6,61 SAY "VAL.UNIT"
      @ 6,71 SAY "DATA"
   ENDIF
   SKIP
ENDDO
IF IMP
   SET DEVICE TO SCREEN
   EJECT
ELSE
  INKEY(0)
ENDIF
CLOSE ALL
RETURN
* EOP TMREST2.PRG