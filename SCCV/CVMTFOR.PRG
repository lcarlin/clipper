*****************************************************************
* BOP CVMTFOR                                                   *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE FORNECEDORES*
* AUTORES: WILSON/OSWALDO                                       *
* DATA: 27/05/94                                                *
*****************************************************************

DO WHILE .T.
   USE CVBFORNE INDEX CVIFOR1
   GOTO TOP
   V_OBS = " "
   TELA(3)
   MCODFOR   =  0
   MNOMFOR   =  SPACE(35)
   MCEPFOR   =  SPACE(09)
   MTELFOR   =  SPACE(14)
   MCIDFOR   =  SPACE(20)
   MENDFOR   =  SPACE(45)
   MCODITE   =  SPACE(05)
   MDESITE   =  SPACE(35)
   MNOMFAB   =  SPACE(30)
   MCGCFAB   =  SPACE(20)
   MOBSFOR   =  SPACE(10)
   @ 08,23 GET MCODFOR PICT "99999"
   READ
   IF EMPTY(MCODFOR) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODFOR) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,23 GET MCODFOR PICT "99999"
      CLEAR GETS
   ELSEIF EMPTY(MCODFOR) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODFOR
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (20,12,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,23 GET  MNOMFOR   PICT "@!"
       @ 10,23 GET  MTELFOR   PICT "(XXXX)XXX-XXXX"
       @ 11,23 GET  MCEPFOR   PICT "XXXXX-XXX"
       @ 12,23 GET  MCIDFOR   PICT "@!"
       @ 13,23 GET  MENDFOR   PICT "@!"
       @ 14,23 GET  MCODITE   PICT "@!"
       @ 15,23 GET  MDESITE   PICT "@!"
       @ 16,23 GET  MNOMFAB   PICT "@!"
       @ 17,23 GET  MCGCFAB   PICT "@!"
       @ 18,23 GET  V_OBS     PICT "!" VALID V_OBS $ "SN"
       READ
       IF V_OBS = "S"
          SAVE SCREEN TO TEL
          mobsfor=obser(.t.,"obsfor")
          RESTORE SCREEN FROM TEL
       ENDIF
       IF .NOT. CONFIRMA (23,12,"Os dados estao corretos ")
          LOOP
       ENDIF
       LIMPA(1)
       APPEND BLANK
   ELSE
       MCODFOR   =  CODFOR
       MNOMFOR   =  NOMFOR
       MCODITE   =  CODITE
       MCEPFOR   =  CEPFOR
       MTELFOR   =  TELFOR
       MCIDFOR   =  CIDFOR
       MENDFOR   =  ENDFOR
       MDESITE   =  DESITE
       MNOMFAB   =  NOMFAB
       MCGCFAB   =  CGCFAB
       MOBSFOR   =  OBSFOR
       @ 09,23 GET  MNOMFOR   PICT "@!"
       @ 10,23 GET  MTELFOR   PICT "(XXXX)XXX-XXXX"
       @ 11,23 GET  MCEPFOR   PICT "XXXXX-XXX"
       @ 12,23 GET  MCIDFOR   PICT "@!"
       @ 13,23 GET  MENDFOR   PICT "@!"
       @ 14,23 GET  MCODITE   PICT "@!"
       @ 15,23 GET  MDESITE   PICT "@!"
       @ 16,23 GET  MNOMFAB   PICT "@!"
       @ 17,23 GET  MCGCFAB   PICT "@!"
       CLEAR GETS
       ALTER = "R"
       cor = setcolor()
       setcolor("w/b")
       @ 23,12 SAY "Fornecedor ja cadastrado <A>ltera; <R>etorna; <E>xclui" GET ALTER PICT "!" VALID (ALTER $"ARE")
       READ
       set color to &cor.
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
             @ 09,23 GET  MNOMFOR   PICT "@!"
             @ 10,23 GET  MTELFOR   PICT "(XXXX)XXX-XXXX"
             @ 11,23 GET  MCEPFOR   PICT "XXXXX-XXX"
             @ 12,23 GET  MCIDFOR   PICT "@!"
             @ 13,23 GET  MENDFOR   PICT "@!"
             @ 14,23 GET  MCODITE   PICT "@!"
             @ 15,23 GET  MDESITE   PICT "@!"
             @ 16,23 GET  MNOMFAB   PICT "@!"
             @ 17,23 GET  MCGCFAB   PICT "@!"
             @ 18,23 GET  V_OBS     PICT "!" VALID V_OBS $ "SN"
             READ
             IF V_OBS = 'S'
                SAVE SCREEN TO TEL
                mobsfor=obser(.t.,"obsfor")
                RESTORE SCREEN FROM TEL
             ENDIF
             IF CONFIRMA (23,12,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF
   REPLACE CODFOR   WITH  MCODFOR
   REPLACE NOMFOR   WITH  MNOMFOR
   REPLACE CODITE   WITH  MCODITE
   REPLACE CEPFOR   WITH  MCEPFOR
   REPLACE TELFOR   WITH  MTELFOR
   REPLACE CIDFOR   WITH  MCIDFOR
   REPLACE ENDFOR   WITH  MENDFOR
   REPLACE DESITE   WITH  MDESITE
   REPLACE NOMFAB   WITH  MNOMFAB
   REPLACE CGCFAB   WITH  MCGCFAB
   IF V_OBS = 'S'
      REPLACE OBSFOR   WITH  MOBSFOR
   ENDIF
   IF.NOT. CONFIRMA (23,12,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVMTFOR.PRG