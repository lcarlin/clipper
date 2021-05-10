*******************************************************************
* BOP CVCLI.PRG                                                   *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE FORNRCEDORES  *
* AUTORES: EVERTON/LUIZ/WILSON/OSWALDO                            *
* DATA: 20/05/94                                                  *
*******************************************************************


USE CVPECAS INDEX CVIPES1
DO WHILE .T.
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
   IF EMPTY(MCODPEC) .AND. LASTKEY() = 13
      TABELAP()
      MCODPEC = AUX_COD
      IF EMPTY(MCODPEC) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,22 GET MCODPEC PICT "@!"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODPEC) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODPEC
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (20,12,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,29 GET   MDECPEC  PICT "@!"
       @ 10,29 GET   MQTDPEC  PICT "99999" 
       @ 11,29 GET   MVALUNI  PICT "999999999999.99"
       @ 12,29 GET   MQTDMIN  PICT "999"
       @ 13,29 GET   MCODFOR  PICT "@!"
       @ 14,29 GET   MNOMFOR  PICT "@!"
       READ
       IF .NOT. CONFIRMA (20,12,"Os dados estao corretos ")
          LOOP
       ENDIF
       LIMPA(1)
       APPEND BLANK
   ELSE
       MCODPEC   =  CODPEC
       MDECPEC   =  DECPEC
       MQTDPEC   =  QTDPEC
       MVALUNI   =  VALUNI
       MQTDMIN   =  QTDMIN
       MCODFOR   =  CODFOR
       MNOMFOR   =  NOMFOR
       @ 09,29 GET   MDECPEC  PICT "@!"
       @ 10,29 GET   MQTDPEC  PICT "99999" 
       @ 11,29 GET   MVALUNI  PICT "999999999999.99"
       @ 12,29 GET   MQTDMIN  PICT "999"
       @ 13,29 GET   MCODFOR  PICT "@!"
       @ 14,29 GET   MNOMFOR  PICT "@!"
       CLEAR GETS
       ALTER = "R"
       @ 20,12 SAY "<A>ltera; <R>etorna; <E>xclui" GET ALTER PICT "!" VALID (ALTER $"ARE")
       READ
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
             @ 09,29 GET   MDECPEC  PICT "@!"
             @ 10,29 GET   MQTDPEC  PICT "99999" 
             @ 11,29 GET   MVALUNI  PICT "999999999999.99"
             @ 12,29 GET   MQTDMIN  PICT "999"
             @ 13,29 GET   MCODFOR  PICT "@!"
             @ 14,29 GET   MNOMFOR  PICT "@!"
             READ
             IF CONFIRMA (20,12,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF
 * REPLACE  CODPEC   WITH  MCODPEC
   REPLACE  DECPEC   WITH  MDECPEC
   REPLACE  QTDPEC   WITH  MQTDPEC 
   REPLACE  VALUNI   WITH  VALUNI 
   REPLACE  QTDMIN   WITH  MQTDMIN
 * REPLACE  CODFOR   WITH  MCODFOR
   REPLACE  NOMFOR   WITH  MNOMFOR
   IF.NOT. CONFIRMA (20,12,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVPECAS.PRG
