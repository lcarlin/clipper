***********************************************************
* BOP TMMTEST
* OBJETIVO: MANUTENCAO DE ESTOQUE
* AUTORES: DANIELLE, LUIZ, EVERTON E ANA PAULA
* DATA: 28/09/94
***********************************************************
USE TMBEST INDEX TMIEST
SOMBRA (8,5,16,70,.F.)
@ 08,20 SAY "MANUTENÄèO DE ESTOQUE"
@ 10,7 SAY "CODIGO...........:"
@ 11,7 SAY "DESCRIÄéO........:"
@ 12,7 SAY "QUANTIDADE.......:"
@ 13,7 SAY "QUANT. MINIMA....:"
@ 14,7 SAY "VALOR UNITARIO...:"
@ 15,7 SAY "DATA ATUALIZAÄéO.:"
SAVE SCREEN TO TELAEST
DO WHILE .T.
   RESTORE SCREEN FROM TELAEST
   MCODEST  = 0
   MDESC    = SPACE(35)
   MQUANT   = 0
   MQTMIN   = 0
   MVALUNIT = 0
   MDATATU  = DATA_SIS
   @ 10,25 GET MCODEST PICT "9999"
   READ
   IF LASTKEY() = 13 .AND. EMPTY(MCODEST)
      TABELA()
      IF EMPTY(MCODEST)
        LOOP
      ENDIF
      @ 10,25 GET MCODEST PICT "9999"
      CLEAR GETS
   ELSEIF LASTKEY() = 27
      EXIT
   ENDIF
   SEEK MCODEST
   ENCONTRA = FOUND()
   IF .NOT. ENCONTRA
      IF CONFIRMA ("CODIGO NOVO - CADASTRA ?")
         @ 11,25 GET MDESC     PICT "@!"
         @ 12,25 GET MQUANT    PICT "999"
         @ 13,25 GET MQTMIN    PICT "999"
         @ 14,25 GET MVALUNIT  PICT "999,999.99"
         @ 15,25 GET MDATATU   PICT "99/99/99"
         READ
         IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
            LOOP
         ENDIF
      ELSE
         LOOP
      ENDIF
   ELSE
      MDESC    = DESC
      MQUANT   = QUANT
      MQTMIN   = QTMIN
      MVALUNIT = VALUNIT
      MDATATU  = DATATU
      @ 11,25 GET DESC
      @ 12,25 GET QUANT
      @ 13,25 GET QTMIN
      @ 14,25 GET VALUNIT
      @ 15,25 GET DATATU
      CLEAR GETS
      VAR =ALTER()
      DO CASE
         CASE VAR = 3
              LOOP
         CASE VAR = 2
              IF CONFIRMA("Excluir Registro?")
                 DELE
              ENDIF
         CASE VAR = 1
              @ 11,25 GET MDESC     PICT "@!"
              @ 12,25 GET MQUANT    PICT "999"
              @ 13,25 GET MQTMIN    PICT "999"
              @ 14,25 GET MVALUNIT  PICT "999,999.99"
              @ 15,25 GET MDATATU   PICT "99/99/99"
              READ
              IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
                  LOOP
              ENDIF
      ENDCASE
   ENDIF
   IF .NOT. ENCONTRA
       APPEND BLANK
   ENDIF
   REPLACE CODEST    WITH MCODEST
   REPLACE DESC      WITH MDESC
   REPLACE QUANT     WITH MQUANT
   REPLACE QTMIN     WITH MQTMIN
   REPLACE VALUNIT   WITH MVALUNIT
   REPLACE DATATU    WITH MDATATU
   IF .NOT. CONFIRMA ("QUER CONTINUAR")
       EXIT
   ENDIF
ENDDO
CLOSE ALL
RETURN

* EOP TMMTEST.PRG