**************************************************************
* BOP CVMTPEC.PRG                                            *
* PROGRAMA PARA CONTROLE DAS PECAS VENDIDAS NO BALCAO        *
* AUTORES: WILSON, EVERTON, OSWALDO                          *
* DATA: 20/05/94                                             *
**************************************************************

DO WHILE .T.
   MCODFUN = 0
   GO TOP
   TELA(15)
   USE CVBCLIEN INDEX CVICLI1
	MCODCLI = 0
        @ 07,29 GET MCODCLI PICT "99999"
        READ
        IF EMPTY(MCODCLI) .AND. LASTKEY() = 13
           TABELA()
           IF EMPTY(MCODCLI) .AND. LASTKEY() = 27
              LOOP
           ENDIF
           @ 07,29 GET MCODCLI PICT "99999"
           CLEAR GETS
        ENDIF
        IF EMPTY(MCODCLI) .AND. LASTKEY() = 27
          CLOSE DATABASES
          RETURN
        ENDIF
        SEEK MCODCLI
        IF .NOT. FOUND()
          if CONFIRMA(23,10,"Cliente nao Cadastrado; Deseja Cadastra-lo ")
             DO CVMTCLI
	  else
             LOOP
	  endif
        ENDIF
        MNOMCLI = NOMCLI
	@ 8,29 GET MNOMCLI
	CLEAR GETS
        SAVE SCREEN TO CLI
   MTOTALC=0
   DO WHILE .T.
   TELA(15)
   RESTORE SCREEN FROM CLI
   USE CVBPECAS INDEX CVIPEC1
   MCODPEC   =  0
   MCODFOR   =  0
   MQTVEND   =  0
   @ 9,29 GET MCODPEC PICT "99999"
   READ
   IF EMPTY(MCODPEC) .AND. LASTKEY() = 13
      TABELA()
      IF EMPTY(MCODPEC) .AND. LASTKEY() = 27
         LOOP
      ENDIF
      @ 9,29 GET MCODPEC PICT "99999"
      CLEAR GETS
   ENDIF
   IF EMPTY(MCODPEC) .AND. LASTKEY() = 27
      CLOSE DATABASES
      RETURN
   ENDIF
   SEEK MCODPEC
   IF .NOT. FOUND()
       MENSAGEM("Codigo nao Cadastrado; Tecle <ENTER> ",23)
       WAIT ""
       LOOP
   ELSE
       MDECPEC   =  DECPEC
       MQTDPEC   =  QTDPEC
       MVALUNI   =  VALUNI
       MQTDMIN   =  QTDMIN
       @ 10,29 GET MDECPEC  PICT "@!"
       @ 11,29 GET MQTDPEC  PICT "99999"
       @ 12,29 GET MVALUNI  PICT "9,999,999.99"
       @ 13,29 GET MQTDMIN  PICT "99999"
       CLEAR GETS
       @ 14,29 GET MQTVEND  PICT "99999"
       READ
       USE CVBPECAS INDEX CVIPEC1
       MSUBTOT=MVALUNI*MQTVEND
       MTOTALC=MTOTALC+MSUBTOT
       @ 15,29 GET MSUBTOT  PICT  "9,999,999.99"
       CLEAR GETS
       IF MQTVEND > (MQTDPEC-MQTDMIN)
	  if .NOT. CONFIRMA(10,10, " [ERRO] Estouro do Estoque Minimo; Continuo ")
             LOOP
	  endif
       ENDIF
       USE CVBFUNC  INDEX CVIFUN1
       @ 16,29 GET MCODFUN PICT "99999"
       READ
       IF EMPTY(MCODFUN) .AND. LASTKEY() = 13
          TABELA()
          IF EMPTY(MCODFUN) .AND. LASTKEY() = 27
             LOOP
          ENDIF
          @ 16,29 GET MCODFUN PICT "99999"
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
       @ 17,29 GET MNOMFUN
       CLEAR GETS
       USE CVBFUNC  INDEX CVIFUN1
       MCOMFUN = COMFUN
       MCOMFUN = COMFUN+(MCODFUN * 0.2)
       REPLACE COMFUN WITH MCOMFUN
       USE CVBPECAS INDEX CVIPEC1
       MNQTDPEC = MQTDPEC - MQTVEND
       REPLACE QTDPEC WITH MNQTDPEC
        *MQTVEND = MQTVEND - QTDPEC
        USE CVPECAS INDEX CVIVPEC1
        IF CONFIRMA(23,17,"Dados Estao Corretos")
	       APPEND BLANK
               REPLACE  CODPEC  WITH MCODPEC
	       REPLACE  DECPEC  WITH MDECPEC
	       REPLACE  QTPECC  WITH MQTVEND
               REPLACE  NOMCLI  WITH MNOMCLI
	       REPLACE  CODCLI  WITH MCODCLI
               REPLACE  SUBTOT  WITH MSUBTOT
               USE CVVPEC INDEX CVIGRAP1
               SEEK MDECPEC
               IF .NOT. FOUND()
                   APPEND BLANK
                   REPLACE DEsPEC WITH MDECPEC
                   REPLACE QUANTC WITH MQTVEND
               ELSE
                   REPLACE QUANTC WITH QUANTC + MQTVEND
               ENDIF                                   
               USE CVPECAS INDEX CVIVPEC1
        ENDIF
        IF CONFIRMA(23,17,"Continua cadastrando pecas")
           CLEAR
           LOOP
        ENDIF
           REPLACE  VALTOT  WITH MTOTALC
           SET FILTER TO CODCLI=MCODCLI
	   GO TOP
           DECLARE VCAB[7]
           VCAB[1]  = "Codigo"
           VCAB[2]  = "Descricao"
           VCAB[3]  = "Subtotal"
           VCAB[4]  = "Quantidade"
           VCAB[5]  = "Val. total da compra"
	   VCAB[6]  = "Nome cliente"
	   VCAB[7]  = "Codigo cliente"
           BORDA(07,10,20,73,"W+/N")
           DBEDIT(08,11,19,72,.T.,"FUNDBCON",.T.,VCAB,.T.,.T.,.T.)
           RETURN
       LIMPA()
   ENDIF
ENDDO
ENDDO

