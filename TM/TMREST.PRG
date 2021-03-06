****************************************************************
* bop TMREST                                                   *
* AUTORES: ANA PAULA, DANIELLE, EVERTON, LUIZ                  *
* OBJETIVO: EMITIR RELATORIOS DE BAIXAS E ENTRADAS DO ESTOQUE  *
* DATA: 06/10/94                                               *
****************************************************************
SELE 1
   USE TMBBEST INDEX TMIEST1
SELE 2
   USE TMBREST INDEX TMIEST2
SOMBRA(5,60,9,71,.F.)
LAN = 0
@ 6,62 PROMPT " BAIXAS "
@ 7,62 PROMPT "ENTRADAS"
@ 8,62 PROMPT " GERAL  "
MENU TO LAN
IF LASTKEY() = 27
   CLOSE ALL
   RETURN
ENDIF
IF LAN = 3
   DO TMREST2
   RETURN
ENDIF
TESTE = "       "
IF LAN = 1
   SELE 1
   CX     = " BAIXAS "
   CABEC  = "       "
   CAMPO1 = "CODEST"
   CAMPO2 = "DATAB"
   CAMPO3 = "QTD"
   CAMPO4 = "VALOR"
   CAMPO5 = "TESTE"
ELSEIF LAN = 2
   SELE 2
   CX     = " ENTRADAS "
   CABEC  = "QUANTIDADE TOTAL"
   CAMPO1 = "CODEST"
   CAMPO2 = "DATAE"
   CAMPO3 = "QTD"
   CAMPO4 = "VALUNIT"
   CAMPO5 = "QTTOT"
ENDIF
SOMBRA(6,55,9,68,.F.)
@ 7,57 PROMPT "   VIDEO  "
@ 8,57 PROMPT "IMPRESSORA"
MENU TO LA_
IF LASTKEY() = 27
   CLOSE ALL
   RETURN
ENDIF
IF LA_ = 1
   NL = 23
   IMP = .F.
ELSE
   IF .NOT. ISPRINTER()
      SOMBRA(11,10,13,38,.F.)
      @ 12,12 SAY "IMPRESSORA N�O PREPARADA!"
      INKEY(5)
      RETURN
   ENDIF
   SOMBRA(11,10,13,32,.F.)
   @ 12,12 SAY "AGUARDE IMPRIMINDO!"
   SET DEVICE TO PRINTER
   SET CONSOLE OFF
   NL = 60
   IMP = .T.
ENDIF
P = 1
L = 7
CABECALHO("RELATORIO"+CX+"DO ESTOQUE",1,IMP)
@ 6,2 SAY "CODIGO"
@ 6,10 SAY "DATA"
@ 6,20 SAY "QUANTIDADE"
@ 6,32 SAY "VALOR "
@ 6,45 SAY CABEC
DO WHILE .NOT. EOF()
   @ L,02 SAY &CAMPO1
   @ L,10 SAY &CAMPO2
   @ L,20 SAY &CAMPO3
   @ L,32 SAY &CAMPO4
   @ L,45 SAY &CAMPO5
   L = L+1
   IF L >= NL
      P = P+1
      L = 7
      IF IMP
         EJECT
      ENDIF
      CABECALHO("RELATORIO "+CX+"DO ESTOQUE",P,IMP)
      @ 6,2 SAY "CODIGO"
      @ 6,10 SAY "DATA"
      @ 6,20 SAY "QUANTIDADE"
      @ 6,32 SAY "VALOR "
      @ 6,45 SAY CABEC
   ENDIF
   SKIP
ENDDO
IF .NOT. IMP
   @ 24,20 SAY "Pressione Algo...."
   INKEY(0)
ELSE
   EJECT
ENDIF
SET DEVICE TO SCREEN
CLOSE ALL
RETURN
* EOP TMREST.PRG