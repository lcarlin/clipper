**************************************************************
* BOP CVMTPEC.PRG                                            *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE PECAS    *
* AUTORES: EVERTON/OSWALDO                                   *
* DATA: 20/05/94                                             *
**************************************************************

DO WHILE .T.
   SELE 1
   USE CVBFORNE INDEX CVIFOR1
   GO TOP
   SELE 2
   USE CVBPECAS INDEX CVIPEC1
   GOTO TOP
   TELA(14)
   MCODPEC   =  0
   MDECPEC   =  SPACE(35)
   MQTDPEC   =  0
   MVALUNI   =  0
   MQTDMIN   =  0
   MCODFOR   =  0
   MNOMFOR   =  SPACE(35)
   @ 08,29 GET MCODPEC PICT "99999"
   READ
   @ 18,10 say space(45)
   IF EMPTY(MCODPEC) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODPEC) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,29 GET MCODPEC PICT "99999"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODPEC) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODPEC
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (23,12,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,29 GET MDECPEC  PICT "@!"
       @ 10,29 GET MQTDPEC  PICT "99999"
       @ 11,29 GET MVALUNI  PICT "9,999,999.99"
       @ 12,29 GET MQTDMIN  PICT "999"
       DO WHILE .T.
          @ 13,29 GET MCODFOR  PICT "999999"
          READ
          SELE 1
          IF EMPTY(MCODFOR) .AND. LASTKEY() = 13
             TABELA()
             IF EMPTY(MCODFOR) .AND. LASTKEY() = 27
                LOOP
             ENDIF
             @ 13,29 GET MCODFOR PICT "999999"
             CLEAR GETS
          ENDIF
          MNOMFOR=NOMFOR
          @ 14,29 GET MNOMFOR  PICT "@!"
          CLEAR GETS
          SEEK MCODFOR
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
       MCODPEC   =  CODFOR
       MDECPEC   =  DECPEC
       MQTDPEC   =  QTDPEC
       MVALUNI   =  VALUNI
       MQTDMIN   =  QTDMIN
       @ 09,29 GET MDECPEC  PICT "@!"
       @ 10,29 GET MQTDPEC  PICT "99999"
       @ 11,29 GET MVALUNI  PICT "9,999,999.99"
       @ 12,29 GET MQTDMIN  PICT "999"
       MCODFOR   =  CODFOR
       MNOMFOR   =  NOMFOR
       @ 13,29 GET MCODFOR PICT "999999"
       @ 14,29 GET MNOMFOR  PICT "@!"
       CLEAR GETS
       ALTER = "R"
       cor = setcolor()
       setcolor("w/b")
       @ 23,12 SAY "Cliente ja cadastrado <A>ltera; <R>etorna; <E>xclui" GET ALTER PICT "!" VALID (ALTER $"ARE")
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
             @ 09,29 GET MDECPEC  PICT "@!"
             @ 10,29 GET MQTDPEC  PICT "99999"
             @ 11,29 GET MVALUNI  PICT "9,999,999.99"
             @ 12,29 GET MQTDMIN  PICT "999"
             READ
             SELE 1
             @ 13,29 GET MCODFOR  PICT "999999"
             READ
             IF EMPTY(MCODFOR) .AND. LASTKEY() = 13
                TABELA()
                IF EMPTY(MCODFOR) .AND. LASTKEY() = 27
                   LOOP
                ENDIF
                @ 13,29 GET MCODFOR PICT "999999"
                CLEAR GETS
             ENDIF
             MNOMFOR=NOMFOR
             @ 14,29 GET MNOMFOR  PICT "@!"
             CLEAR GETS
             SEEK MCODFOR
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
   REPLACE  CODPEC  WITH MCODPEC
   REPLACE  DECPEC  WITH MDECPEC
   REPLACE  QTDPEC  WITH MQTDPEC
   REPLACE  VALUNI  WITH MVALUNI
   REPLACE  QTDMIN  WITH MQTDMIN
   REPLACE  CODFOR  WITH MCODFOR
   REPLACE  NOMFOR  WITH MNOMFOR
   IF.NOT. CONFIRMA (23,12,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVMTCLI.PRG
