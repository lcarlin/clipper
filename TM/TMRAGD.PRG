***************************************************
* BOP        TMRAGD                               *
* OBJETIVO = RELATORIO DA AGENDA                  *
* AUTORES  = FOFA, DANI, TON, LU                  *
* DATA     = 11/10/94                             *
***************************************************
USE TMBAGEN
MDTPG = DATA_SIS
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
       SOMBRA(11,10,13,38,.F.)
       @ 12,12 SAY "IMPRESSORA NŽO PREPARADA!"
       INKEY(5)
       RETURN
   ENDIF
   NL = 60
   IMP = .T.
ENDIF
P = 1
L = 7
SOMBRA(10,10,12,45,.F.)
@ 11,11 SAY "DIGITE A DATA DESEJADA:" GET MDTPG
READ
if lastkey()=27
   CLOSE ALL
   return
endif
SET FILTER TO MDTPG = DTPG
GO TOP
IF EOF()
   SOMBRA(11,11,13,49,.F.)
   @ 12,12 SAY "Arquivo Vazio !!! Pressione algo..."
   inkey(0)
   CLOSE ALL
   RETURN
ENDIF
IMPRESSORA=ISPRINTER()
IF IMP
   IF .NOT. IMPRESSORA
      SOMBRA(19,10,21,36,.F.)
      @ 20,11 SAY "IMPRESSORA NAO PREPARADA"
      INKEY(0)
      CLOSE ALL
      RETURN
   ELSE    
      sombra(11,25,13,50,.f.)
      @ 12,26 say "Aguarde !!! Imprimindo "
      SET DEVICE TO PRINTER
      SET CONSOLE OFF
   ENDIF
ELSE
   CLEAR
ENDIF
P=1
L = 7
CABECALHO("RELATORIO DE COBRANCAS PARA O DIA "+DTOC(mdtpg),P,.T.)
@ 6,02 SAY "DATA DA COMPRA"
@ 6,20 SAY "DESCRICAO"
@ 6,67 SAY "VALOR"
DO WHILE .NOT. EOF()
   @ L,02 SAY DTA
   @ L,20 SAY DES
   @ L,67 SAY VALOR PICT "999,999.99"
   SKIP
   L = L+1
   IF L >= NL
      L =7
      P=P+1
      IF IMP
         EJECT
      ENDIF
      CABECALHO("RELATORIO DE COBRANCAS PARA O DIA: "+DTOC(mdtpg),P,.T.)
      @ 6,02 SAY "DATA DA COMPRA"
      @ 6,20 SAY "DESCRICAO"
      @ 6,67 SAY "VALOR"
   ENDIF
ENDDO
IF IMP
   EJECT
ELSE
   @ 24,20 SAY "Pressione Algo..."
   inkey(0)
ENDIF
SET DEVICE TO SCREEN
SET CONSOLE ON
CLOSE ALL
RETURN