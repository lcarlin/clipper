******************************************************************
* BOP CVMTFUNC.PRG                                               *
* PROGRAMA PARA INCLUSAO E MATENCAO DE REGISTROS DE FUNCIONARIOS *
* AUTORES: EVERTON/LUIZ/WILSON /OSWALDO                          *
* DATA: 30/05/94                                                 *
******************************************************************
USE CVBFUNC INDEX CVIFUN1
DO WHILE .T.
   GOTO TOP
   TELA(2)
   MCODFUN   =  0
   MNOMFUN   =  SPACE(35)
   MENDFUN   =  SPACE(45)
   MCEPFUN   =  SPACE(9)
   MCIDFUN   =  SPACE(20)
   MCARFUN   =  SPACE(15)
   MSALFUN   =  0
   MCOMFUN   =  0
   @ 08,22 GET MCODFUN PICT "99999"
   READ
   @ 18,10 say space(45)
   IF EMPTY(MCODFUN) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODFUN) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 08,22 GET MCODFUN PICT "99999"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODFUN) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODFUN
   IF .NOT. FOUND()
       IF .NOT. CONFIRMA (23,12,"Codigo novo! Deseja cadastrar")
          LOOP
       ENDIF
       LIMPA()
       @ 09,22 GET MNOMFUN  PICT "@!"
       @ 10,22 GET MENDFUN  PICT "@!"
       @ 11,22 GET MCIDFUN  PICT "@!"
       @ 12,22 GET MCEPFUN  PICT "XXXXX-XXX"
       @ 13,22 GET MCARFUN  PICT "@!"
       @ 14,22 GET MSALFUN  PICT "999,999,999.99"
       @ 15,22 GET MCOMFUN  PICT "999,999,999.99"
       READ
       IF .NOT. CONFIRMA (23,12,"Os dados estao corretos ")
          LOOP
       ENDIF
       LIMPA(1)
       APPEND BLANK
   ELSE
       MCODFUN   =  CODFUN
       MNOMFUN   =  NOMFUN
       MENDFUN   =  ENDFUN
       MCIDFUN   =  CIDFUN
       MCEPFUN   =  CEPFUN
       MCARFUN   =  CARFUN
       MSALFUN   =  SALFUN
       MCOMFUN   =  COMFUN
       @ 09,22 GET MNOMFUN  PICT "@!"
       @ 10,22 GET MENDFUN  PICT "@!"
       @ 11,22 GET MCIDFUN  PICT "@!"
       @ 12,22 GET MCEPFUN  PICT "XXXXX-XXX"
       @ 13,22 GET MCARFUN  PICT "@!"
       @ 14,22 GET MSALFUN  PICT "999,999,999.99"
       @ 15,22 GET MCOMFUN  PICT "999,999,999.99"
       CLEAR GETS
       ALTER = "R"
       cor = setcolor()
       setcolor("w/b")
       @ 23,12 SAY "Funcionario ja cadastrado <A>ltera; <R>etorna; <E>xclui" GET ALTER PICT "!" VALID (ALTER $"ARE")
       READ
       setcolor(cor)
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
             @ 09,22 GET MNOMFUN  PICT "@!"
             @ 10,22 GET MENDFUN  PICT "@!"
             @ 11,22 GET MCIDFUN  PICT "@!"
             @ 12,22 GET MCEPFUN  PICT "XXXXXX-XXX"
             @ 13,22 GET MCARFUN  PICT "@!"
             @ 14,22 GET MSALFUN  PICT "999,999,999.99"
             @ 15,22 GET MCOMFUN  PICT "999,999,999.99"
             READ
             IF CONFIRMA (23,12,"Os dados estao corretos ")
                EXIT
             ENDIF
             LIMPA()
          ENDDO
          LIMPA()
       ENDIF
   ENDIF
   REPLACE   CODFUN   WITH   MCODFUN
   REPLACE   NOMFUN   WITH   MNOMFUN
   REPLACE   ENDFUN   WITH   MENDFUN
   REPLACE   CIDFUN   WITH   MCIDFUN
   REPLACE   CARFUN   WITH   MCARFUN
   REPLACE   CEPFUN   WITH   MCEPFUN
   REPLACE   SALFUN   WITH   MSALFUN
   REPLACE   COMFUN   WITH   MCOMFUN
   IF.NOT. CONFIRMA (23,12,"Deseja continuar")
       CLOSE DATABASES
       RETURN
   ENDIF
   LIMPA()
ENDDO

* EOP CVMTFUNC.PRG