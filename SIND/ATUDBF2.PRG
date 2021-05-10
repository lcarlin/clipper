/*
BOP ATUALIZA.PRG
AUTOR   LUIZ ANTONIO CARLIN
DATA    31/08/95
FUNCAO  ATUALIZACAO DE DBFS DO SISTEMA DE CONTROLE DE ESTOQUE
LINGUAGEM CLIPPER 5.2
*/
LOCAL aMatEstru := {}



CLS
aMatArq := {"CEBMEST","CEBCUS","CEBLANCA","CEBAGEN"}
aMatArq2:= {"CEiMEST?","CEBIUS","CEILANCA","CEIAGEN"}
FOR K := 1 TO 4
   dbusearea(.t.,,aMatArq[k])
   aMatEstru := dbstruct()
   COPY TO CETEMP
   DBCLOSEAREA()
   DELETE FILE aMatArq[k]+".DBF"
   DELETE FILE aMatArq2[k]+".NTX"
   aadd(aMatestru,{"NMOV      ","C",18,0})
   IF K = 1
      aadd(aMatestru,{"MARCADO   ","C",01,0})
   ENDIF
   dbcreate(aMatArq[k],aMatEstru)
   dbusearea(.t.,,aMatArq[k])
   GO TOP
   APPEND FROM CETEMP
   CLOSE ALL
   ! DEL CETEMP.DB?
NEXT

DBUSEAREA(.T.,,"CEBMEST")
dbgotop()
nRecs := LASTREC()
nV := 0
nC := 0
@ 00,00 SAY "Numero de Registros a Processar :"+str(nRecs)
nAtual := 1
DO WHILE .NOT. EOF()
   @ 01,00 SAY "Atual :"+str(nAtual)
   IF TIPO = "V"
      nV++
   ELSE
      nC++
   ENDIF
   cTemp := TIPO+alltrim(str(if(tipo="V",nV,nC)))
   REPLACE nMov WITH cTemp
   SKIP
   nAtual++
ENDDO
/*
FOR L := 1 TO nRecs
    REPLACE NMOV WITH "V"+ALLTRIM(str(L))
    SKIP
NEXT
nNVenda := L
SAVE TO cavenda ALL LIKE nNvenda

DBUSEAREA(.T.,,"CABcEST")
dbgotop()
nRecs := LASTREC()
FOR m := 1 TO nRecs
    REPLACE NMOV WITH "C"+ALLTRIM(str(M))
    SKIP
NEXT
nNCompra := M
SAVE to cacompra ALL LIKE nNCompra
*/

n_mov := "V"+alltrim(str(nV))
SAVE TO VENDAS ALL LIKE n_MOv
n_mov := "C"+alltrim(str(nC))
SAVE TO compras ALL LIKE n_MOv

CLOSE ALL
USE CEBEST
COPY TO CETEMPX
aMatEstru := dbstruct()
close all
DELETE FILE CE?EST.*
AaDd(aMatEstru,{"CATEGORIA","C",02,0})
AaDd(aMatEstru,{"CAT_DES","C",25,0})
dbcreate("CEBEST",aMatEstru)
USE CEBEST
APPEND FROM CETEMPX
CLOSE ALL
DELE FILE CETEMP*.*

* EOP ATUALIZA.PRG