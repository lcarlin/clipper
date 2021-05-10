****************************************************************
* bop TMLANCA                                                  *
* AUTORES: Ana Paula, danielle, Everton, Luiz                  *
* OBJETIVO: Permitir os lanáamentos no caixa                   *
* DATA: 28/09/94                                               *
****************************************************************
SELE 1
  USE TMBLCD
SELE 2
  USE TMBCOM
SELE 3
  USE TMBFUN
DO WHILE .T.
   SOMBRA(5,5,18,70,.F.)
   @ 05,20 SAY "LANÄAMENTOS DE CAIXA"
   @ 07,07 SAY "DESCRIÄèO..:"
   @ 09,07 SAY "VALOR......:"
   @ 11,07 SAY "TIPO.......:"
   MDESC   = SPACE(40)
   M_VALOR = 0
   @ 07,20 GET MDESC  PICT "@!"
   @ 09,20 GET M_VALOR PICT "999,999.99"
   READ
   IF LASTKEY() = 27
      EXIT
   ENDIF
   _OP = 0
   @ 11,20 PROMPT "DEBITO"
   @ 11,27 PROMPT "CREDITO"
   @ 11,36 PROMPT "VALES"
   MENU TO _OP
   DO CASE
      CASE _OP = 0
           LOOP
      CASE _OP = 1
           MTIPO = "D"
      CASE _OP = 2
           MTIPO = "C"
      CASE _OP = 3
           MTIPO = "D"
           MCODFUN = 0
	   @ 13,07 SAY "ENTRE COM O FUNCIONARIO:"
           SELE 3
	   TABELA()
	   IF EMPTY(MCODFUN)
	      LOOP
	   ENDIF
   MNOMEF=NOMEFUN
   ENDCASE
   IF .NOT. CONFIRMA ("REGISTRAR LANÄAMENTO?")
      LOOP
   ENDIF
   SELE 1
   APPEND BLANK
   REPLACE DESC   WITH MDESC
   REPLACE VALOR  WITH M_VALOR
   REPLACE TIPO   WITH MTIPO
   IF _OP = 3
      SELE 2
      APPEND BLANK
      REPLACE VALOR WITH M_VALOR*(-1)
      REPLACE CODF  WITH MCODFUN
      REPLACE NOMEF WITH MNOMEF
      REPLACE DATAC WITH DATA_SIS
   ENDIF
   IF .NOT. CONFIRMA ("DESEJA CONTINUAR?")
      EXIT
   ENDIF
ENDDO
CLOSE ALL
RETURN
* eop tmlanca
