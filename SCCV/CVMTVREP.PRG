**************************************************************
* BOP CVMTPEC.PRG                                            *
* PROGRAMA PARA CONTROLE DAS PECAS USADAS NOS REPAROS DE AUTOMOVEIS*
* AUTORES: WILSON, EVERTON, OSWALDO                          *
* DATA: 20/05/94                                             *
**************************************************************

DO WHILE .T.
   MCODCLI = 0
   MCODFUN = 0
*   USE CVREPAR INDEX CVIREP1
   GO TOP
   TELA(11)
   MCODORC   =  0
   MDATORC   =  CTOD("   /  /   ")
   MVALORC   =  0
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
       if CONFIRMA(10,10,"Cliente nao Cadastrado; Deseja Cadastra-lo ")
          DO CVMTCLI
       else
          LOOP
       endif
    ENDIF
    MNOMCLI = NOMCLI
	@09,29 GET MNOMCLI
	CLEAR GETS
        USE CVBFUNC  INDEX CVIFUN1
        @ 10,29 GET MCODFUN PICT "99999"
        READ
        IF EMPTY(MCODFUN) .AND. LASTKEY() = 13
           TABELA()
           IF EMPTY(MCODFUN) .AND. LASTKEY() = 27
              LOOP
           ENDIF
           @ 10,29 GET MCODFUN PICT "99999"
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
         @ 11,29 GET MNOMFUN
         CLEAR GETS
         USE CVBFUNC  INDEX CVIFUN1
         MCOMFUN = COMFUN
         MCOMFUN = COMFUN+(MCODFUN * 0.2)
         REPLACE COMFUN WITH MCOMFUN
         LIN = 15
         conf = .t.
         MTOTAL = 0
         SCROLL = .F.
         do while .T.
            USE CVBPECAS INDEX CVIVPEC1
            MCODPEC = 0
            IF LIN >= 19
               if conf
                  SCROLL(15,1,18,78,1)
               endif
               conf = .t.
               @ 18,1 GET MCODPEC PICT "99999"
               LIN = 18
               SCROLL = .T.
            ELSE
               IF SCROLL
                  LIN = 18
               ENDIF
               @ LIN,1 GET MCODPEC PICT "99999"
            ENDIF
            READ
            IF EMPTY(MCODPEC) .AND. LASTKEY() = 13
               TABELA()
               IF LASTKEY() = 27
                  LOOP
               ENDIF
               @ LIN,1 GET MCODPEC PICT "99999"
               CLEA GETS
            ENDIF
            IF EMPTY(MCODPEC) .AND. LASTKEY() = 27
               CLOSE DATABASES
               RETURN
            ENDIF
            SEEK MCODPEC
            IF .NOT. FOUND()
                MENSAGEM("Peca nao Cadastrada; Tecle <ENTER> ",23)
                WAIT ""
                LOOP
            ENDIF
            MDECPEC = DECPEC
            MQUANTC = 0
            MVALUNI = VALUNI
            @ LIN,12 SAY CHR(179)
            @ LIN,13 get MDECPEC
            @ LIN,48 SAY CHR(179)
            CLEAR GETS
            @ LIN,50 get MQUANTC PICT "9999"
            READ
            MSUBTOT = MVALUNI * MQUANTC
            MTOTAL = MTOTAL + MSUBTOT
            @ LIN,64 SAY CHR(179)
            @ LIN,65 GET MSUBTOT PICT "@E 99,999,999.99"
            CLEAR GETS
            USE CVPECAS INDEX CVIPEC1
            IF CONFIRMA(1,1,"Dados Estao Corretos ")
               USE CVVPEC INDEX CVIGRAP1
               REINDEX
               SEEK MDECPEC
               IF .NOT. FOUND()
                   APPEND BLANK
                   REPLACE DEcPEC WITH MDECPEC
                   REPLACE QUANTC WITH MQTVEND
               ELSE
                   REPLACE QUANTC WITH QUANTC + MQTVEND
               ENDIF
               IF .NOT. CONFIRMA(1,1,"Continua Cadastrando Pecas ")
                  APPEND BLANK
                  REPLACE CODPEC   WITH    MCODPEC
                  REPLACE NOMCLI   WITH    MNOMCLI
                  REPLACE CODCLI   WITH    MCODCLI
                  REPLACE DECPEC   WITH    MDECPEC
                  REPLACE QTPECC   WITH    MQUANTC
                  REPLACE SUBTOT   WITH    MSUBTOT
                  REPLACE VALTOT   WITH    MTOTAL
                  RETURN
               endif
               APPEND BLANK
               REPLACE NOMCLI   WITH    MNOMCLI
               REPLACE CODCLI   WITH    MCODCLI
               REPLACE CODPEC   WITH    MCODPEC
               REPLACE DECPEC   WITH    MDECPEC
               REPLACE QTPECC   WITH    MQUANTC
               REPLACE SUBTOT   WITH    MSUBTOT
            ELSE
               conf = .f.
               loop
            ENDIF
            LIMPA()
            LIN = LIN + 1
         enddo
ENDDO