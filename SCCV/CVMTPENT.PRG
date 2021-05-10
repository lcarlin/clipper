**************************************************************
* BOP CVMTPENT.PRG                                           *
* PROGRAMA PARA CONTROLE DAS VENDAS DE PRONTA ENTREGA        *
* AUTORES: WILSON, EVERTON, OSWALDO E LUIZ                   *
* DATA: 24/06/94                                             *
**************************************************************

DO WHILE .T.
   MCODFUN = 0
   TELA(13)
   USE CVBCLIEN INDEX CVICLI1
     	MCODCLI = 0
        @ 08,29 GET MCODCLI PICT "99999"
        READ
        IF EMPTY(MCODCLI) .AND. LASTKEY() = 13
           TABELA()
           IF EMPTY(MCODCLI) .AND. LASTKEY() = 27
              LOOP
           ENDIF
           @ 08,29 GET MCODCLI PICT "99999"
           CLEAR GETS
        ENDIF
        IF EMPTY(MCODCLI) .AND. LASTKEY() = 27
          CLOSE DATABASES
          RETURN
        ENDIF
        SEEK MCODCLI
        IF .NOT. FOUND()
             mensagem("Cliente nao Cadastrado; Deseja Cadastra-lo ",1)
             loop
        ENDIF
        MNOMCLI = NOMCLI
	@ 09,29 GET MNOMCLI
	CLEAR GETS
   MCODCAR   =  0
   MDESCAR   = SPACE(35)
   MVALCAR   =  0
   USE CVBFROTA INDEX CVIFRO1
   @ 10,29 GET MCODCAR PICT "99999"
   READ
   @ 18,10 say space(45)
   IF EMPTY(MCODCAR) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODCAR) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 10,29 GET MCODCAR PICT "99999"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODCAR) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODCAR
   IF .NOT. FOUND()
       MENSAGEM("Carro nao Cadastrado; Tecle <ENTER> ",23)
       WAIT ""
       LOOP
   ELSE
       MVALCAR   =  0
       MVALCAR   =  VALCAR
       MDESCAR   =  DESCAR
       @ 11,29 GET MDESCAR  PICT "@!"
       @ 12,29 GET VALCAR  PICT "9,999,999.99"
       CLEAR GETS
       USE CVBFUNC  INDEX CVIFUN1
       @ 13,29 GET MCODFUN PICT "99999"
       READ
       IF EMPTY(MCODFUN) .AND. LASTKEY() = 13
          TABELA()
          IF EMPTY(MCODFUN) .AND. LASTKEY() = 27
             LOOP
          ENDIF
          @ 13,29 GET MCODFUN PICT "99999"
          CLEAR GETS
       ENDIF
       IF EMPTY(MCODFUN) .AND. LASTKEY() = 27
          CLOSE DATABASES
          RETURN
       ENDIF
       SEEK MCODFUN
       IF .NOT. FOUND()
          MENSAGEM("Funcionario nao Cadastrado; Tecle <ENTER> ",23)
          WAIT ""
          LOOP
       ENDIF
       MNOMFUN = NOMFUN
       @ 14,29 GET MNOMFUN
       CLEAR GETS
       USE CVBFUNC  INDEX CVIFUN1
       MCOMFUN = COMFUN   
       MCOMFUN = COMFUN+(MVALCAR * 0.015)
       USE CVBFROTA INDEX CVIFRO1
       MQUANCAR = QUANTCAR
       MQUANCAR = MQUANCAR - 1
       USE CVBPENT INDEX CVIPENT1
       MDATA=CTOD("  /  /  ")
       @ 15,29 GET MDATA  PICT "99/99/99"
       IF CONFIRMA(23,17,"Dados Estao Corretos")
               APPEND BLANK
	       REPLACE  CODCAR  WITH MCODCAR
	       REPLACE  DESCAR  WITH MDESCAR
	       REPLACE  VALCAR  WITH MVALCAR
	       REPLACE  CODFUN  WITH MCODFUN
	       REPLACE  NOMFUN  WITH MNOMFUN
               REPLACE  CODCLI  WITH MCODCLI
	       REPLACE  NOMCLI  WITH MNOMCLI
	       REPLACE  DATAV   WITH MDATA
	       USE CVBFROTA INDEX CVIFRO1
	       REPLACE QUANTCAR  WITH MQUANCAR
	       USE CVVCAR INDEX CVIGRAC1
	       SEEK MDESCAR
	       IF .NOT. FOUND()
		  APPEND BLANK
		  REPLACE DESCAR WITH MDESCAR
		  REPLACE QUANTV WITH 1
	       ELSE
                  TOTVEN = QUANTV + 1
		  REPLACE QUANTV WITH TOTVEN
	       ENDIF
	       IF MQUANCAR = 0
	          MENSAGEM ("ATENCAO: ULTIMO CARRO SENDO VENDIDO; Tecle <ENTER>",23)
	       ENDIF
	       USE CVBFUNC  INDEX CVIFUN1
	       REPLACE COMFUN WITH MCOMFUN
         ENDIF
        IF .NOT. CONFIRMA (23,12,"Deseja continuar")
           CLOSE DATABASES
           RETURN
       ENDIF
       LIMPA()
   ENDIF
ENDDO

* EOP CVMTPENT.PRG
