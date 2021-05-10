***********************************************************
* BOP TMMTFUN
* OBJETIVO: MANUTENCAO DE FUNCIONèRIOS
* AUTORES: DANIELLE, LUIZ, EVERTON E ANA PAULA
* DATA: 28/09/94
***********************************************************
USE TMBFUN INDEX TMIFUN
SOMBRA (5,5,16,70,.F.)
@ 05,20 SAY "MANUTENÄèO DE FUNCIONèRIOS"
@ 07,7 SAY "CODIGO.......:"
@ 08,7 SAY "NOME.........:"
@ 09,7 SAY "ENDEREÄO.....:"
@ 10,7 SAY "CIDADE.......:"
@ 11,7 SAY "ESTADO.......:"
@ 12,7 SAY "CEP..........:"
@ 13,7 SAY "TELEFONE.....:"
@ 14,7 SAY "CARGO........:"
@ 15,7 SAY "Nß CARTEIRA..:"
SAVE SCREEN TO TELAFUN
PUBLIC MCODFUN
DO WHILE .T.
   RESTORE SCREEN FROM TELAFUN
   MCODFUN     = 0
   MNOMEFUN    = SPACE(35)
   MENDERFUN   = SPACE(45)
   MCIDFUN     = SPACE(30)
   MESTFUN     = SPACE(02)
   MCEPFUN     = SPACE(09)
   MTELFUN     = SPACE(15)
   MCARGO      = space(15)
   MNCART      = SPACE(13)
   @ 7,22 GET MCODFUN PICT "9999"
   READ
   IF LASTKEY() = 13 .AND. EMPTY(MCODFUN)
      TABELA()
      IF EMPTY(MCODFUN)
        LOOP
      ENDIF
      @ 7,22 GET MCODFUN PICT "9999"
      CLEAR GETS
   ELSEIF LASTKEY() = 27
      EXIT
   ENDIF
   SEEK MCODFUN
   ENCONTRA = FOUND()
   IF .NOT. ENCONTRA
      IF CONFIRMA ("CODIGO NOVO - CADASTRA ?")
         @ 08,22 GET MNOMEFUN   PICT "@!"
         @ 09,22 GET MENDERFUN  PICT "@!"
         @ 10,22 GET MCIDFUN    PICT "@!"
         @ 11,22 GET MESTFUN    PICT "@!" valid (mestfun$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
         @ 12,22 GET MCEPFUN    PICT "99999-999"
         @ 13,22 GET MTELFUN    PICT "@!"
         @ 14,22 GET MCARGO     PICT "@!"
         @ 15,22 GET MNCART     PICT "@!"
         READ
         IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
            LOOP
         ENDIF
      ELSE
         LOOP
      ENDIF
   ELSE
      MNOMEFUN    = NOMEFUN
      MENDERFUN  = ENDERFUN
      MCIDFUN     = CIDFUN
      MESTFUN     = ESTFUN
      MTELFUN     = TELFUN
      MCARGO      = CARGO
      MNCART      = NCART
      MCEPFUN     = CEPFUN
      @ 08,22 GET NOMEFUN
      @ 09,22 GET ENDERFUN
      @ 10,22 GET CIDFUN
      @ 11,22 GET ESTFUN
      @ 12,22 GET CEPFUN
      @ 13,22 GET TELFUN
      @ 14,22 GET CARGO
      @ 15,22 GET NCART
      CLEAR GETS
      VAR =ALTER()
      DO CASE
         CASE VAR = 3
              LOOP
         CASE VAR = 2
              IF CONFIRMA("Excluir Registro")
                 DELE
              ENDIF
         CASE VAR = 1
              @ 08,22 GET MNOMEFUN   PICT "@!"
              @ 09,22 GET MENDERFUN  PICT "@!"
              @ 10,22 GET MCIDFUN    PICT "@!"
              @ 11,22 GET MESTFUN    PICT "@!"  valid (mestfun$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
              @ 12,22 GET MCEPFUN    PICT "99999-999"
              @ 13,22 GET MTELFUN    PICT "@!"
              @ 14,22 GET MCARGO     PICT "@!"
              @ 15,22 GET MNCART     PICT "@!"
              READ
              IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
                  LOOP
              ENDIF
      ENDCASE
   ENDIF
   IF .NOT. ENCONTRA
       APPEND BLANK
   ENDIF
   REPLACE CODFUN    WITH MCODFUN
   REPLACE NOMEFUN   WITH MNOMEFUN
   REPLACE ENDERFUN  WITH MENDERFUN
   REPLACE CIDFUN    WITH MCIDFUN
   REPLACE ESTFUN    WITH MESTFUN
   REPLACE CEPFUN    WITH MCEPFUN
   REPLACE TELFUN    WITH MTELFUN
   REPLACE CARGO     WITH MCARGO
   REPLACE NCART     WITH MNCART
   IF .NOT. CONFIRMA ("QUER CONTINUAR")
       EXIT
   ENDIF
ENDDO
CLOSE ALL
RETURN
