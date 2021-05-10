***********************************************************
* BOP TMMTCLI
* OBJETIVO: MANUTENCAO DE CLIENTES
* AUTORES: DANIELLE, LUIZ, EVERTON E ANA PAULA
* DATA: 23/09/94
***********************************************************
USE TMBCLI INDEX TMICLI1
SOMBRA (5,5,18,70,.F.)
@ 05,20 SAY "MANUTENÄèO DE CLIENTES"
@ 07,7 SAY "CODIGO.......:"
@ 08,7 SAY "NOME.........:"
@ 09,7 SAY "ENDEREÄO.....:"
@ 10,7 SAY "CIDADE.......:"
@ 11,7 SAY "ESTADO.......:"
@ 12,7 SAY "CEP..........:"
@ 13,7 SAY "TELEFONE.....:"
@ 14,7 SAY "FAX..........:"
@ 15,7 SAY "RG...........:"
@ 16,7 SAY "C.G.C........:"
@ 17,7 SAY "INSC. EST....:"
SAVE SCREEN TO TELACLI
PUBLIC MCOD
DO WHILE .T.
   RESTORE SCREEN FROM TELACLI
   MCOD     = 0
   MNOME    = SPACE(35)
   MENDER   = SPACE(45)
   MCID     = SPACE(30)
   MEST     = SPACE(02)
   MCEP     = SPACE(09)
   MTEL     = SPACE(15)
   MFAX     = space(15)
   MRG      = SPACE(13)
   MCGC     = SPACE(12)
   MINSC    = 0
   MOBS      = SPACE(10)
   @ 7,22 GET MCOD PICT "9999"
   READ
   IF LASTKEY() = 13 .AND. EMPTY(MCOD)
      TABELA()
      IF EMPTY(MCOD)
        LOOP
      ENDIF
      @ 7,22 GET MCOD PICT "9999"
      CLEAR GETS
   ELSEIF LASTKEY() = 27
      EXIT
   ENDIF
   SEEK MCOD
   ENCONTRA = FOUND()
   IF .NOT. ENCONTRA
      IF CONFIRMA ("CODIGO NOVO - CADASTRA ?")
         @ 08,22 GET MNOME   PICT "@!"
         @ 09,22 GET MENDER  PICT "@!"
         @ 10,22 GET MCID    PICT "@!"
         @ 11,22 GET MEST    PICT "@!" valid (mest$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
         @ 12,22 GET MCEP    PICT "99999-999"
         @ 13,22 GET MTEL    PICT "@!"
         @ 14,22 GET MFAX    PICT "@!"
         @ 15,22 GET MRG     PICT "@!"
         @ 16,22 GET MCGC    PICT "@!"
         @ 17,22 GET MINSC   PICT "999999999999"
         READ
         IF CONFIRMA("DESEJA ANOTAR OBSERVAÄôES SOBRE O CLIENTE ?")
             OBSER(.T.)
         ENDIF
         IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
            LOOP
         ENDIF
      ELSE
         LOOP
      ENDIF
   ELSE
      MNOME    = NOME
      MENDER   = ENDER
      MCID     = CID
      MEST     = EST
      MTEL     = TEL
      MFAX     = FAX
      MRG      = RG
      MCGC     = CGC
      MINSC    = INSC
      MCEP     = CEP
      MOBS     = BOBS
      MOBS2    = MOBS
      @ 08,22 GET NOME
      @ 09,22 GET ENDER
      @ 10,22 GET CID
      @ 11,22 GET EST
      @ 12,22 GET CEP
      @ 13,22 GET TEL
      @ 14,22 GET FAX
      @ 15,22 GET RG
      @ 16,22 GET CGC
      @ 17,22 GET INSC 
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
              @ 08,22 GET MNOME   PICT "@!"
              @ 09,22 GET MENDER  PICT "@!"
              @ 10,22 GET MCID    PICT "@!"
              @ 11,22 GET MEST    PICT "@!"  valid (mest$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
              @ 12,22 GET MCEP    PICT "99999-999"
              @ 13,22 GET MTEL    PICT "@!"
              @ 14,22 GET MFAX    PICT "@!"
              @ 15,22 GET MRG     PICT "@!"
              @ 16,22 GET MCGC    PICT "@!"
              @ 17,22 GET MINSC   PICT "999999999999"
              READ
              IF CONFIRMA("DESEJA ANOTAR OBSERVAÄôES SOBRE O CLIENTE ?")
                 OBSER(.T.)
              ENDIF
              IF .NOT. CONFIRMA ("CONFIRMA OS DADOS ?")
                  LOOP
              ENDIF
      ENDCASE
   ENDIF
   IF .NOT. ENCONTRA
       APPEND BLANK
   ENDIF
   REPLACE COD    WITH MCOD
   REPLACE NOME   WITH MNOME
   REPLACE ENDER  WITH MENDER
   REPLACE CID    WITH MCID
   REPLACE EST    WITH MEST
   REPLACE CEP    WITH MCEP
   REPLACE TEL    WITH MTEL
   REPLACE FAX    WITH MFAX
   REPLACE RG     WITH MRG
   REPLACE CGC    WITH MCGC
   REPLACE INSC   WITH MINSC
   REPLACE BOBS   WITH MOBS
   IF .NOT. CONFIRMA ("QUER CONTINUAR")
       EXIT
   ENDIF
ENDDO
CLOSE ALL
RETURN
