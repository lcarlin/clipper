*********************************************************************
* bop TMBCSERV                                                      *
* AUTORES: ANA PAULA, DANIELLE, EVERTON, LUIZ                       *
* OBJETIVO: PERMITIR UMA CONSULTA DE REPAROS OU VENDA DE MATERIAIS  *
* DATA: 04/10/94                                                    *
*********************************************************************
SELE 1
   USE TMBREP
SELE 2
   USE TMBVEND
SOMBRA(3,63,6,70,.F.)
OPC = 0
@ 03,63 PROMPT "REPAROS"
@ 04,64 PROMPT "VENDAS"
MENU TO OPC
IF OPC = 1
   SELE 1
   DECLARE VCAM[6]
   VCAM[1] = "NOMCLI"
   VCAM[2] = "DESCREP"
   VCAM[3] = "DATA"
   VCAM[4] = "VALP"
   VCAM[5] = "VALSERV"
   VCAM[6] = "VALTOT"
   DECLARE VCABEC[6]
   VCABEC[1] = "NOME DO CLIENTE"
   VCABEC[2] = "DESCRI€ŽO DO SERVI€O"
   VCABEC[3] = "DATA DO REPARO"
   VCABEC[4] = "VALOR DAS PE€AS"
   VCABEC[5] = "VALOR DO SERVI€O"
   VCABEC[6] = "VALOR TOTAL"
ELSE 
   SELE 2
   DECLARE VCAM[5]
   VCAM[1] = "NOMCLI"
   VCAM[2] = "DESCMAT"
   VCAM[3] = "QTDE"
   VCAM[4] = "VALTOT"
   VCAM[5] = "DATAC"
   DECLARE VCABEC[5]
   VCABEC[1] = "NOME DO CLIENTE"
   VCABEC[2] = "DESCRI€ŽO DO MATERIAL"
   VCABEC[3] = "QUANTIDADE"
   VCABEC[4] = "VALOR TOTAL"
   VCABEC[5] = "DATA DA VENDA"
ENDIF
DBEDIT(04,01,20,77,VCAM,"CONSULTAR",.T.,VCABEC)
CLOSE ALL
RETURN


