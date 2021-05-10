***********************************************************
* bop TMRCLIS                                              *
* AUTORES: ANA PAULA, DANIELLE, EVERTON, LUIZ             *
* OBJETIVO: EMITIR RELATORIOS DO CLIENTE                  *
* DATA: 07/10/94                                          *
***********************************************************
USE TMBCLI
SOMBRA(08,57,11,70,.F.)
CLI = 0
@ 09,59 PROMPT "  VIDEO   "
@ 10,59 PROMPT "IMPRESSORA"
MENU TO CLI
IF LASTKEY() = 27
   RETURN
ENDIF
IF CLI = 1
   NL  = 23
   IMP = .F.
ELSE
   IF .NOT. ISPRINTER()
       SOMBRA(11,10,13,38,.F.)
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
CABECALHO("RELATORIO DE CLIENTES",1,IMP)
@ 06,02 SAY "CODIGO"
@ 06,10 SAY "NOME"
@ 06,47 SAY "TELEFONE"
DO WHILE .NOT. EOF()
   @ L,02 SAY COD
   @ L,10 SAY NOME
   @ L,47 SAY TEL
   L = L+1
   IF L >= NL
      P = P+1
      L = 7
      IF IMP
         EJECT
      ENDIF
      CABECALHO("RELATORIO DE CLIENTES",P,IMP)
      @ 6,2  SAY "CODIGO"
      @ 6,10 SAY "NOME"
      @ 6,47 SAY "TELEFONE"
   ENDIF
   SKIP
ENDDO
IF IMP
   SET DEVICE TO SCREEN
   EJECT
ELSE
   WAIT "Pressione algo..."
ENDIF
CLOSE ALL
RETURN

* EOP TMRCLIS.PRG