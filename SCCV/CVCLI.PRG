**************************************************************
* BOP CVCLI.PRG                                              *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE CLIENTES *
* AUTORES: EVERTON/LUIZ/WILSON /OSWALDO                      *
* DATA: 20/05/94                                             *
**************************************************************
USE CVCLIENT INDEX CVICLI1
DO WHILE .T.
   GOTO TOP
   TELA(1)
   MCODCLI   =  0
   MNOMECLI  =  SPACE(35)
   MENDCLI   =  SPACE(45)
   MCIDCLI   =  SPACE(20)
   MCEPCLI   =  0
   MUFCLI    =  SPACE(02)
   MTELCLI   =  SPACE(15)
   MRGCLI    =  SPACE(13)
   MCICCLI   =  SPACE(15)
   MNASCCLI  =  CTOD("  /  /  ")
   MDATACLI  =  DATE()
   MCONSOR   =  " "
   @ 08,22 GET MCODCLI PICT "99999"
   READ
   IF EMPTY(MCODCLI) .AND. LASTKEY() = 13
      TABELA()
      MCODCLI=AUX_COD
      IF EMPTY(MCODCLI) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,22 GET MCODCLI PICT "@!"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODCLI) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODCLI
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (20,12,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,22 GET MNOMECLI PICT "@!"
       @ 10,22 GET MENDCLI  PICT "@!"
       @ 11,22 GET MCIDCLI  PICT "@!"
       @ 12,22 GET MCEPCLI  PICT "99999-999"
       @ 13,22 GET MUFCLI   PICT "@!"        VALID (mufcli$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
       @ 14,22 GET MTELCLI  PICT "(9999)999-9999"
       @ 15,22 GET MRGCLI   PICT "XXX.XXX.XXX-X"
       @ 16,22 GET MCICCLI  PICT "@!"
       @ 17,22 GET MNASCCLI PICT "99/99/99"
       @ 18,22 GET MDATACLI PICT "99/99/99"
       @ 18,62 GET MCONSOR  PICT "!"         VALID MCONSOR $ "SN"
       READ
       IF .NOT. CONFIRMA (20,12,"Os dados estao corretos ")
          LOOP
       ENDIF
       LIMPA(1)
       APPEND BLANK
   ELSE
       MCODCLI   =  CODCLI
       MNOMECLI  =  NOMCLI
       MENDCLI   =  ENDCLI
       MCIDCLI   =  CIDCLI
       MCEPCLI   =  CEPCLI
       MUFCLI    =  UFCLI
       MTELCLI   =  TELCLI
       MRGCLI    =  RGCLI
       MCICCLI   =  CICCLI
       MNASCCLI  =  NASCLI
       MDATACLI  =  DATCLI
       MCONSOR   =  CONSOR
       @ 09,22 GET MNOMECLI PICT "@!"
       @ 10,22 GET MENDCLI  PICT "@!"
       @ 11,22 GET MCIDCLI  PICT "@!"
       @ 12,22 GET MCEPCLI  PICT "99999-999"
       @ 13,22 GET MUFCLI   PICT "@!"
       @ 14,22 GET MTELCLI  PICT "(9999)999-999"
       @ 15,22 GET MRGCLI   PICT "XXX.XXX.XXX-X"
       @ 16,22 GET MCICCLI  PICT "@!"
       @ 17,22 GET MNASCCLI PICT "99/99/99"
       @ 18,22 GET MDATACLI PICT "99/99/99"
       @ 18,62 GET MCONSOR  PICT "!"
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
             @ 09,22 GET MNOMECLI PICT "@!"
             @ 10,22 GET MENDCLI  PICT "@!"
             @ 11,22 GET MCIDCLI  PICT "@!"
             @ 12,22 GET MCEPCLI  PICT "99999-999"
             @ 13,22 GET MUFCLI   PICT "@!" VALID (mufcli$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
             @ 14,22 GET MTELCLI  PICT "(9999)999-9999"
             @ 15,22 GET MRGCLI   PICT "XXX.XXX.XXX-X"
             @ 16,22 GET MCICCLI  PICT "@!"
             @ 17,22 GET MNASCCLI PICT "99/99/99"
             @ 18,22 GET MDATACLI PICT "99/99/99"
	     @ 18,62 GET MCONSOR  PICT "!" VALID MCONSOR $ "SN"
             READ
             IF CONFIRMA (20,12,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF
   REPLACE   CODCLI   WITH   MCODCLI
   REPLACE   NOMCLI   WITH   MNOMECLI
   REPLACE   ENDCLI   WITH   MENDCLI
   REPLACE   CIDCLI   WITH   MCIDCLI
   REPLACE   CEPCLI   WITH   MCEPCLI
   REPLACE   UFCLI    WITH   MUFCLI
   REPLACE   TELCLI   WITH   MTELCLI
   REPLACE   RGCLI    WITH   MRGCLI
   REPLACE   CICCLI   WITH   MCICCLI
   REPLACE   NASCLI   WITH   MNASCCLI
   REPLACE   DATCLI   WITH   MDATACLI
   REPLACE   CONSOR   WITH   MCONSOR
   IF.NOT. CONFIRMA (20,12,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVCLI.PRG