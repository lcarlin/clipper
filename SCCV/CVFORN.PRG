******************************************************************
* BOP CVFORN                                                     *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE FORNECEDORES *
* AUTORES: EVERTON/OSWALDO M                                     *
* DATA: 20/05/94                                                 *
******************************************************************




USE CVFORNEC INDEX CVIFOR1
DO WHILE .T.
   GOTO TOP
   TELA(7)
   MCODFOR   =  0
   MNOMEFOR  =  SPACE(35)
   MEMP      =  SPACE(20)
   CGC       =  SPACE(10)
   MITEM     =  SPACE(20)
   @ 08,22 GET MCODFOR PICT "99999"
   READ
   IF EMPTY(MCODFOR) .AND. LASTKEY() = 13
      TABELAF()
      MCODFOR = AUX_COD
      IF EMPTY(MCODFOR) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,22 GET MCODFOR PICT "@!"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODFOR) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODFOR
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (20,12,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,22 GET  MNOMEFOR  PICT "@!"
       @ 10,22 GET  MITEM     PICT "@!"
       @ 11,22 GET  CGC       PICT "@!"
       @ 12,22 GET  MEMP      PICT "@!"
       READ
       IF .NOT. CONFIRMA (20,12,"Os dados estao corretos ")
          LOOP
       ENDIF
       LIMPA(1)
       APPEND BLANK
   ELSE
    MCODFOR   =  CODFORN
    MNOMEFOR  =  NOMEFOR
    MITEM     =  ITEM
    MEMP      =  EMPRFOR
    CGC       =  CGCFOR
       @ 09,22 GET  MNOMEFOR  PICT "@!"
       @ 10,22 GET  ITEM      PICT "@!"
       @ 11,22 GET  CGC       PICT "@!"
       @ 12,22 GET  MEMP      PICT "@!"
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
             @ 09,22 GET   MNOMEFOR  PICT "@!"
             @ 10,22 GET   MITEM     PICT "@!"
             @ 11,22 GET   CGC       PICT "@!"
             @ 12,22 GET   MEMP      PICT "@!"
             READ
             IF CONFIRMA (20,12,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF                  
   REPLACE  CODFORN   WITH  MCODFOR
   REPLACE  NOMEFOR   WITH  MNOMEFOR
   REPLACE  ITEM      WITH  MITEM
   REPLACE  CGCFOR    WITH  CGC
   REPLACE  EMPRFOR   WITH  EMPRFOR
   IF.NOT.  CONFIRMA  (20,12,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVCLI.PRG
