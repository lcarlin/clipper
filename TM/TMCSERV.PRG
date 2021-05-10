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
SOMBRA(4,54,7,64,.F.)
OPC = 0
@ 05,56 PROMPT "REPAROS"
@ 06,56 PROMPT "VENDAS"
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
   VAR = "REPARO DE MAQUINAS"
ELSE 
   SELE 2
   DECLARE VCAM[5]
   VCAM[1] = "NOMCLI"
   VCAM[2] = "DESCMAT"
   VCAM[3] = "QTDE"
   VCAM[4] = "VALTOT"
   VCAM[5] = "DATA"
   DECLARE VCABEC[5]
   VCABEC[1] = "NOME DO CLIENTE"
   VCABEC[2] = "DESCRI€ŽO DO MATERIAL"
   VCABEC[3] = "QUANTIDADE"
   VCABEC[4] = "VALOR TOTAL"
   VCABEC[5] = "DATA DA VENDA"
   VAR = "VENDA DE MATERIAIS"
ENDIF
SOMBRA(3,2,21,77,.F.)
cor_db=setcolor()
desbarr(04,20,77,1)
numero=reccount()/16
l=4
public numero, l, cor_db
@ 03,25 SAY "CONSULTA DE " + VAR
DBEDIT(04,03,20,76,VCAM,"CONSUL",.T.,VCABEC)
release numero, l, cor_db
CLOSE ALL
RETURN
* eop tmcserv.prg