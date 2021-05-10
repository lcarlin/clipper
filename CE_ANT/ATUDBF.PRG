/*
BOP ATUALIZA.PRG
AUTOR   LUIZ ANTONIO CARLIN
DATA    06/08/95
FUNCAO  ATUALIZACAO DE DBFS DO SISTEMA DE CONTROLE DE ESTOQUE
LINGUAGEM CLIPPER 5.2
*/
LOCAL aMatEstru := {}

USE CEBMEST INDEX CEIMEST NEW
aMatEstru := dbstruct()
CLS

IF len(aMatEstru)<=9
   COPY TO CETEMP
   CLOSE CEBMEST
   DELETE FILE CEBMEST.DBF
   DELETE FILE CEIMEST.NTX
   aadd(aMatEstru,{"Lucro","N",10,2})
   dbcreate("CEBMEST",aMatEstru)
   USE CEBMEST NEW
   USE CEBEST INDEX CEIEST NEW
   USE CETEMP  NEW
   GO TOP
   @ 00,00 SAY "Numero total de Registros:"+str(recCOUNT(),4,0)
   @ 01,00 SAY "Registro Atual...........:"
   nRec := 1
   DO WHILE .NOT. eof()
      @ 01,27 SAY nRec
      cCod     := COD_PES
      cPess    := PESSOA
      cCodItem := COD_ITEM
      cItem    := ITEM
      nQuant   := QUANT
      nValunit := VAL_UNI
      nValtot  := VAL_TOT
      dData    := DATA_NEG
      cTipo    := TIPO
      SELE CEBEST
      SEEK cCodItem
      IF FOUND()
         nLucro := VALUNITV-VALUNIT
      ELSE
         nLucro := 0
      ENDIF
      SELE CEBMEST
      APPEND BLANK
      REPLACE COD_PES   WITH cCod
      REPLACE PESSOA    WITH cPess
      REPLACE COD_ITEM  WITH cCoditem
      REPLACE ITEM      WITH cItem
      REPLACE QUANT     WITH nQuant
      REPLACE VAL_UNI   WITH nValunit
      REPLACE VAL_TOT   WITH nValtot
      REPLACE DATA_NEG  WITH dData
      REPLACE TIPO      WITH cTipo
      REPLACE LUCRO     WITH nLucro
      nRec++
      SELE CETEMP
      SKIP
   ENDDO
ENDIF
QUIT

* EOP ATUALIZA.PRG