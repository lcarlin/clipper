***********************************************************
* BOP TMMTFOR
* OBJETIVO: MANUTENCAO DE FORNECEDORES
* AUTORES: DANIELLE, LUIZ, EVERTON E ANA PAULA
* DATA: 29/09/94
***********************************************************
USE TMBFOR INDEX TMIFOR
SOMBRA (5,5,19,70,.F.)
@ 05,20 SAY "MANUTENÄèO DE FORNECEDORES"
@ 07,7 SAY "CODIGO.............:"
@ 08,7 SAY "NOME...............:"
@ 09,7 SAY "ENDEREÄO...........:"
@ 10,7 SAY "CIDADE.............:"
@ 11,7 SAY "ESTADO.............:"
@ 12,7 SAY "CEP................:"
@ 13,7 SAY "TELEFONE...........:"
@ 14,7 SAY "FAX................:"
@ 15,7 SAY "RG.................:"
@ 16,7 SAY "C.G.C..............:"
@ 17,7 SAY "INSC. EST..........:"
@ 18,7 SAY "PRODUTO FORNECIDO..:"
SAVE SCREEN TO TELAFOR
PUBLIC MCODFOR
DO WHILE .T.
   RESTORE SCREEN FROM TELAFOR
   MCODFOR     = 0
   MNOMEFOR    = SPACE(35)
   MENDERFOR   = SPACE(41)
   MCIDFOR     = SPACE(30)
   MESTFOR     = SPACE(02)
   MCEPFOR     = SPACE(09)
   MTELFOR     = SPACE(15)
   MFAXFOR     = space(15)
   MRGFOR      = SPACE(13)
   MCGCFOR     = SPACE(12)
   MINSCFOR    = 0
   MPROD       = SPACE(41)
   @ 7,28 GET MCODFOR PICT "9999"
   READ
   IF LASTKEY() = 13 .AND. EMPTY(MCODFOR)
      TABELA()
      IF EMPTY(MCODFOR)
        LOOP
      ENDIF
      @ 7,28 GET MCODFOR PICT "9999"
      CLEAR GETS
   ELSEIF LASTKEY() = 27
      EXIT
   ENDIF
   SEEK MCODFOR
   ENCONTRA = FOUND()
   IF .NOT. ENCONTRA
      IF CONFIRMA ("CODIGO NOVO - CADASTRA ?")
         @ 08,28 GET MNOMEFOR   PICT "@!"
         @ 09,28 GET MENDERFOR  PICT "@!"
         @ 10,28 GET MCIDFOR    PICT "@!"
         @ 11,28 GET MESTFOR    PICT "@!" valid (mestfor$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
         @ 12,28 GET MCEPFOR    PICT "99999-999"
         @ 13,28 GET MTELFOR    PICT "@!"
         @ 14,28 GET MFAXFOR    PICT "@!"
         @ 15,28 GET MRGFOR     PICT "@!"
         @ 16,28 GET MCGCFOR    PICT "@!"
         @ 17,28 GET MINSCFOR   PICT "999999999999"
         @ 18,28 GET MPROD      PICT "@!"
         READ
         IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
            LOOP
         ENDIF
      ELSE
         LOOP
      ENDIF
   ELSE
      MNOMEFOR    = NOMEFOR
      MENDERFOR   = ENDERFOR
      MCIDFOR     = CIDFOR
      MESTFOR     = ESTFOR
      MTELFOR     = TELFOR
      MFAXFOR     = FAXFOR
      MRGFOR      = RGFOR
      MCGCFOR     = CGCFOR
      MINSCFOR    = INSCFOR
      MCEPFOR     = CEPFOR
      MPROD       = PROD
      @ 08,28 GET NOMEFOR
      @ 09,28 GET ENDERFOR
      @ 10,28 GET CIDFOR
      @ 11,28 GET ESTFOR
      @ 12,28 GET CEPFOR
      @ 13,28 GET TELFOR
      @ 14,28 GET FAXFOR
      @ 15,28 GET RGFOR
      @ 16,28 GET CGCFOR
      @ 17,28 GET INSCFOR 
      @ 18,28 GET PROD
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
              @ 08,28 GET MNOMEFOR   PICT "@!"
              @ 09,28 GET MENDERFOR  PICT "@!"
              @ 10,28 GET MCIDFOR    PICT "@!"
              @ 11,28 GET MESTFOR    PICT "@!"  valid (mestfor$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
              @ 12,28 GET MCEPFOR    PICT "99999-999"
              @ 13,28 GET MTELFOR    PICT "@!"
              @ 14,28 GET MFAXFOR    PICT "@!"
              @ 15,28 GET MRGFOR     PICT "@!"
              @ 16,28 GET MCGCFOR    PICT "@!"
              @ 17,28 GET MINSCFOR   PICT "999999999999"
	      @ 18,28 GET MPROD      PICT "@!"
              READ
              IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
                  LOOP
              ENDIF
      ENDCASE
   ENDIF
   IF .NOT. ENCONTRA
       APPEND BLANK
   ENDIF
   REPLACE CODFOR    WITH MCODFOR
   REPLACE NOMEFOR   WITH MNOMEFOR
   REPLACE ENDERFOR  WITH MENDERFOR
   REPLACE CIDFOR    WITH MCIDFOR
   REPLACE ESTFOR    WITH MESTFOR
   REPLACE CEPFOR    WITH MCEPFOR
   REPLACE TELFOR    WITH MTELFOR
   REPLACE FAXFOR    WITH MFAXFOR
   REPLACE RGFOR     WITH MRGFOR
   REPLACE CGCFOR    WITH MCGCFOR
   REPLACE INSCFOR   WITH MINSCFOR
   REPLACE PROD      WITH MPROD
   IF .NOT. CONFIRMA ("QUER CONTINUAR")
       EXIT
   ENDIF
ENDDO
CLOSE ALL
clear typeahead
RETURN
