*****************************************************************
* BOP CVMTFRO                                                   *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE FROTA       *
* AUTORES: WILSON/OSWALDO                                       *
* DATA: 27/05/94                                                *
*****************************************************************

DO WHILE .T.
   USE CVBFROTA INDEX CVIFRO1
   REINDEX
   GOTO TOP
   V_OBS = " "
   TELA(17)
   MCODCAR   =  0
   MDESCAR   =  SPACE(35)
   MQUANTCAR =  0
   MVALCAR   =  0
   MDATCOMCAR=  CTOD("  /  /  ")
   MCHASSI   =  0
   MCHASDO   =  0
   @ 08,29 GET MCODCAR PICT "99999"
   READ
   @ 18,10 SAY SPACE(45)
   IF EMPTY(MCODCAR) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODCAR) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,29 GET MCODCAR PICT "99999"
      CLEAR GETS
   ELSEIF EMPTY(MCODCAR) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODCAR
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (23,14,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,29 GET  MDESCAR    PICT "@!"
       @ 10,29 GET  MQUANTCAR  PICT "999"
       @ 11,29 GET  MVALCAR    PICT "@e 9,999,999.99"
       @ 12,29 GET  MDATCOMCAR PICT "99/99/99"
       @ 13,29 GET  MCHASSI    PICT "999999999999"
       READ
       MCHASDO = MCHASSI + MQUANTCAR
       @ 14,29 GET  MCHASDO  PICT "999999999999"
       READ
       IF .NOT. CONFIRMA (23,14,"Os dados estao corretos ")
           LOOP
       ENDIF
       LIMPA(1)
       APPEND BLANK
   ELSE
       MCODCAR    =  CODCAR
       MDESCAR    =  DESCAR
       MQUANTCAR  =  QUANTCAR
       MVALCAR    =  VALCAR
       MDATCOMCAR =  DATCOMCAR
       MCHASSI	  =  CHASSI
       MCHASDO    =  CHASDO
       @ 09,29 GET  MDESCAR    PICT "@!"
       @ 10,29 GET  MQUANTCAR  PICT "999"
       @ 11,29 GET  MVALCAR    PICT "@e 9,999,999.99"
       @ 12,29 GET  MDATCOMCAR PICT "99/99/99"
       @ 13,29 GET  MCHASSI    PICT "999999999999"
       @ 14,29 GET  MCHASDO    PICT "999999999999"
       CLEAR GETS
       ALTER = "R"
       @ 23,12 SAY "Carro ja cadastrado <A>ltera; <R>etorna; <E>xclui" GET ALTER PICT "!" VALID (ALTER $"ARE")
       READ
       LIMPA()
       IF ALTER = "R"
          LOOP
       ELSEIF ALTER = "E"
          IF CONFIRMA(23,12,"Confirma exclusao")
             DELETE
          ENDIF
          LIMPA()
       ELSEIF ALTER = "A"
          DO WHILE .T.
             @ 09,29 GET  MDESCAR    PICT "@!"
             @ 10,29 GET  MQUANTCAR  PICT "999"
             @ 11,29 GET  MVALCAR    PICT "@e 9,999,999.99"
             @ 12,29 GET  MDATCOMCAR PICT "99/99/99"
             @ 13,29 GET  MCHASSI     PICT "999999999999"
             MCHASDO = MCHASSI + MQUANTCAR
             READ
             MCHASDO = MCHASSI + MQUANTCAR
             @ 14,29 GET  MCHASDO    PICT "999999999999"
             READ
             IF CONFIRMA (23,14,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF
   REPLACE    CODCAR     WITH  MCODCAR
   REPLACE    DESCAR     WITH  MDESCAR
   REPLACE    QUANTCAR   WITH  MQUANTCAR
   REPLACE    VALCAR     WITH  MVALCAR
   REPLACE    DATCOMCAR  WITH  MDATCOMCAR
   REPLACE    CHASSI	 WITH  MCHASSI
   REPLACE    CHASDO     WITH  MCHASDO
   IF .NOT. CONFIRMA (23,14,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

