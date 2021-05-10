*************************************************
* BOP TMCONAGD.PRG
* OBJETIVO = CONSULTA DE REGISTROS DA AGENDA
* AUTORES= FOFA, DANI, TOM ,LU
* DATA=04/09/94
**************************************************
USE TMBAGEN
SOMBRA(07,05,20,70,.f.)
MDTPG = DATA_SIS
@ 08,07 SAY "Digite a data de pagamento:" GET MDTPG
READ
IF LASTKEY() = 27
   CLOSE ALL
   RETURN
ENDIF
SET FILTER TO DTPG = MDTPG
GO TOP
DECLARE VCAMP[6], VCAMP1[6], VCAMP2[6]
VCAMP[1]  = "DTA"
VCAMP[2]  = "CODCLI"
VCAMP[3]  = "NOME"
VCAMP[4]  = "DES"
VCAMP[5]  = "VALOR"
VCAMP[6]  = "DTPG"
VCAMP1[1] = "99/99/99"
VCAMP1[2] = "9999"
VCAMP1[3] = "@!"
VCAMP1[4] = "@!"
VCAMP1[5] = "999,999.99"
VCAMP1[6] = "99/99/99"
VCAMP2[1] = "DATA DO REGISTRO"
VCAMP2[2] = "CODIGO CLIENTE"
VCAMP2[3] = "NOME CLIENTE"
VCAMP2[4] = "DESCRI€AO"
VCAMP2[5] = "VALOR A PAGAR"
VCAMP2[6] = "DATA DO PAGAMENTO"
cor_db=setcolor()
desbarr(08,19,70,1)
numero=reccount()/11
l=8
public numero, l, cor_db
DBEDIT(08,07,19,69,VCAMP,"CONSULTAR",VCAMP1,VCAMP2)
release numero, l
CLOSE ALL
RETURN
release numero, l, cor_db
* eop tmconagd.prg