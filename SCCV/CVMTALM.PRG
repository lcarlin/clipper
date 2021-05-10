******************************************************************
* BOP CVMTALM                                                    *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DO ALMOXARIFADO *
* AUTORES: WILSON/EVERTON                                        *
* DATA: 22/06/94                                                 *
******************************************************************

DO WHILE .T.
   USE CVALMOX INDEX CVIALM1
   GOTO TOP
   V_OBS = " "
   TELA(18)
   MCODALM   =  0
   MDESCALM   =  SPACE(35)
   MQUANTALM =  0
   MVALALM   =  0
   MQUAMIN   =  0
   @ 08,29 GET MCODALM PICT "99999"
   READ
   @ 18,10 SAY SPACE(45)
   IF EMPTY(MCODALM) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODALM) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,29 GET MCODALM PICT "99999"
      CLEAR GETS
   ELSEIF EMPTY(MCODALM) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODALM
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (23,14,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,29 GET  MDESCALM    PICT "@!"
       @ 10,29 GET  MQUANTALM  PICT "999"
       @ 11,29 GET  MVALALM    PICT "@E 9,999,999.99"
       @ 12,29 GET  MQUAMIN    PICT "999"
       READ
       IF .NOT. CONFIRMA (23,14,"Os dados estao corretos ")
          LOOP
       ENDIF
       LIMPA(1)
       APPEND BLANK
   ELSE
       MCODALM    =  CODALM
       MDESCALM   =  DESCALM
       MQUANTALM  =  QUANTALM
       MVALALM    =  VALALM
       MQUAMIN    =  QUAMIN
       @ 09,29 GET  MDESCALM    PICT "@!"
       @ 10,29 GET  MQUANTALM  PICT "999"
       @ 11,29 GET  MVALALM    PICT "@E 9,999,999.99"
       @ 12,29 GET  MQUAMIN    PICT "999"
       CLEAR GETS
       ALTER = "R"
       @ 23,12 SAY "Material ja cadastrado <A>ltera; <R>etorna; <E>xclui" GET ALTER PICT "!" VALID (ALTER $"ARE")
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
             @ 09,29 GET  MDESCALM    PICT "@!"
             @ 10,29 GET  MQUANTALM  PICT "999"
             @ 11,29 GET  MVALALM    PICT "@E 9,999,999.99"
             @ 12,29 GET  MQUAMIN    PICT "999"
             READ
             IF CONFIRMA (23,14,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF
   REPLACE    CODALM     WITH  MCODALM
   REPLACE    DESCALM    WITH  MDESCALM
   REPLACE    QUANTALM   WITH  MQUANTALM
   REPLACE    VALALM     WITH  MVALALM
   REPLACE    QUAMIN     WITH  MQUAMIN
   IF .NOT. CONFIRMA (23,14,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVMTALM.PRG
