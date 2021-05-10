/*
BOP ATUALIZA.PRG
AUTOR   LUIZ ANTONIO CARLIN
DATA    31/08/95
FUNCAO  ATUALIZACAO DE DBFS DO SISTEMA DE CONTROLE DE ESTOQUE
LINGUAGEM CLIPPER 5.2
*/
LOCAL aMatEstru := {}



CLS
aMatArq := {"CABMEST","CABCEST","CABLANCA","CABAGEN"}
FOR K := 1 TO 4
   dbusearea(.t.,,aMatArq[k])
   aMatEstru := dbstruct()
   COPY TO CaTEMP
   DBCLOSEAREA()
   DELETE FILE aMatArq[k]+".DBF"
   DELETE FILE aMatArq[k]+".NTX"
   aadd(aMatestru,{"NMOV      ","C",16,0})
   IF K < 3
      aadd(aMatestru,{"selec     ","C",01,0})
   ENDIF
   dbcreate(aMatArq[k],aMatEstru)
   dbusearea(.t.,,aMatArq[k])
   GO TOP
   @ 00,00 SAY "Numero total de Registros:"+str(LASTREC())
   @ 01,00 SAY "Registro Atual...........:"
   APPEND FROM CaTEMP
   CLOSE ALL
   ! DEL CaTEMP.DB?
NEXT

DBUSEAREA(.T.,,"CABMEST")
dbgotop()
nRecs := LASTREC()
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

* EOP ATUALIZA.PRG