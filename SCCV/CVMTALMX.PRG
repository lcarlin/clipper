**************************************************************
* BOP CVMTALM.PRG                                            *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE PECAS    *
* AUTORES: EVERTON/OSWALDO                                   *
* DATA: 20/05/94                                             *
**************************************************************

DO WHILE .T.
   SELE 1
   USE CVBFORNE INDEX CVIFOR1
   GO TOP
   REINDEX
   SELE 2
   USE CVBALMOX INDEX CVIALM1
   GOTO TOP
   REINDEX
   TELA(16)
   MCODALM    =  0
   MDESCALM   =  SPACE(35)
   MQUANTALM  =  0
   MVALALM    =  0
   MQUANALM   =  0
   MCODFORALM =  0
   MNOMFORALM =  SPACE(35)
   @ 08,29 GET MCODALM PICT "999999"
   READ
   @ 18,10 say space(45)
   IF EMPTY(MCODALM) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODALM) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,29 GET MCODALM PICT "999999"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODALM) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODALM
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (23,12,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,29 GET MDESCALM   PICT "@!"
       @ 10,29 GET MQUANTALM  PICT "999"
       @ 11,29 GET MVALALM    PICT "9,999,999.99"
       @ 12,29 GET MQUANALM   PICT "999"
       READ
       DO WHILE .T.
          SELE 1
          @ 13,29 GET MCODFORALM  PICT "999999"
          READ
          IF EMPTY(MCODFORALM) .AND. LASTKEY() = 13
             TABELA()
             IF EMPTY(MCODFORALM) .AND. LASTKEY() = 27
                LOOP
             ENDIF
             MCODFORALM=CODFOR
             @ 13,29 GET MCODFORALM PICT "999999"
             CLEAR GETS
          ENDIF
          MNOMFORALM=NOMFOR
          @ 14,29 GET MNOMFORALM  PICT "@!"
          CLEAR GETS
          SEEK MCODFORALM
          IF .NOT. FOUND()
             MENSAGEM("Codigo nao cadastrado",24)
             LOOP
          ENDIF
          SELE 2
          IF .NOT. CONFIRMA (23,12,"Os dados estao corretos ")
             LOOP
          ENDIF
          LIMPA(1)
          APPEND BLANK
	  EXIT
       ENDDO
   ELSE
       MCODALM    =  CODALM
       MDESCALM   =  DESCALM
       MQUANTALM  =  QUANTALM
       MVALALM    =  VALALM
       MQUANALM   =  QUANALM
       @ 09,29 GET MDESCALM   PICT "@!"
       @ 10,29 GET MQUANTALM  PICT "999"
       @ 11,29 GET MVALALM    PICT "9,999,999.99"
       @ 12,29 GET MQUANALM   PICT "999"
       MCODFORALM =  CODFORALM
       MNOMFORALM =  NOMFORALM
       @ 13,29 GET MCODFORALM PICT "999999"
       @ 14,29 GET MNOMFORALM PICT "@!"
       CLEAR GETS
       ALTER = "R"
       cor = setcolor()
       setcolor("w/b")
       @ 23,12 SAY "Almoxarifado ja cadastrado <A>ltera; <R>etorna; <E>xclui" GET ALTER PICT "!" VALID (ALTER $"ARE")
       READ
       setcolor(cor)
       LIMPA()
       IF ALTER = "R"
          LOOP
       ELSEIF ALTER = "E"
          IF CONFIRMA(20,12,"Confirma exclusao")
      DELETE
          ENDIF
          LIMPA()
       ELSEIF ALTER = "A"
          DO WHILE .T.
             SELE 2
             @ 09,29 GET MDESCALM   PICT "@!"
             @ 10,29 GET MQUANTALM  PICT "999"
             @ 11,29 GET MVALALM    PICT "9,999,999.99"
             @ 12,29 GET MQUANALM   PICT "999"
             READ
             SELE 1
             @ 13,29 GET MCODFORALM  PICT "999999"
             READ
             IF LASTKEY() = 13
                TABELA()
                IF EMPTY(MCODFORALM) .AND. LASTKEY() = 27
                   LOOP
                ENDIF
                MCODFORALM=CODFOR
                @ 13,29 GET MCODFORALM PICT "999999"
                CLEAR GETS
             ENDIF
             MNOMFORALM=NOMFOR
             @ 14,29 GET MNOMFORALM  PICT "@!"
             CLEAR GETS
             SEEK MCODFORALM
             IF .NOT. FOUND()
                 MENSAGEM("Codigo nao cadastrado",24)
                 LOOP
             ENDIF
             IF CONFIRMA (23,12,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF
   SELE 2
   REPLACE CODALM    WITH  MCODALM
   REPLACE DESCALM   WITH  MDESCALM
   REPLACE QUANTALM  WITH  MQUANTALM
   REPLACE VALALM    WITH  MVALALM
   REPLACE QUANALM   WITH  MQUANALM
   REPLACE CODFORALM  WITH MCODFORALM
   REPLACE NOMFORALM  WITH MNOMFORALM
   IF.NOT. CONFIRMA (23,12,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVMTALMX.PRG

