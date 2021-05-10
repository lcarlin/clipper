/*
BOP CECMEST.PRG

PROGRAMA : CECMEST.PRG
DATA     : 10/06/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : CONSULTA DE ENTRADAS E BAIXAS NO ESTOQUE
SISTEMA  : CONTROLE DE ESTOQUE
LINGUAGEM: CLIPPER 5.01
*/

PARAMETERS Tipo_con

USE CEBMEST  INDEX CEIMEST

IF Tipo_con = 3
   SET FILTER TO Tipo = "C"
   GO TOP
   cMostra1 := "Fornecedor"
   cMostra2 := "Entrada"
ELSE
   SET FILTER TO Tipo = "V"
   GO TOP
   cMostra1 := "Cliente"
   cMostra2 := " Saida "
ENDIF

aVet_camp := {"data_neg","cod_pes","pessoa","cod_item","item","quant","Val_tot"}
aVet_masc := {"99/99/99","@!","@!","@!","@!","9999","99,999.99",}
aVet_cab  := {"Data","Codigo",cMostra1,"Cod. Item","Item","Quant.","Valor Total"}

SOMBRA(05,05,22,76)
@ 05,24 SAY "Consulta de "+cMostra2+" de Produtos"
dbedit(06,06,21,75,aVet_camp,"consulta",aVet_masc,aVet_cab,"Ä","³")
SET FILTER TO
GO TOP
RELEASE ALL
CLOSE ALL
RETURN

* eop CECMEST.prg