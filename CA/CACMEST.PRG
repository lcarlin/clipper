/*
BOP caCMEST.PRG

PROGRAMA : caCMEST.PRG
DATA     : 07/07/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : CONSULTA DE  BAIXAS NO ESTOQUE
SISTEMA  : CONTROLE DE acougues
LINGUAGEM: CLIPPER 5.01
*/

PUBLIC tipo_c := 0, dat_fil

USE CABAGEN NEW

USE CABLANCA NEW

USE caBMEST  INDEX caIMEST NEW
GO TOP


aVet_campos := {"selec","data_neg","cod_pes","pessoa","cod_item","item","quant","Val_tot"}
aVet_masc := {"!","99/99/99","@!","@!","@!","@!","9999.999","99,999.99",}
aVet_cab  := {"Selec.","Data","Codigo","Cliente","Cod. Item","Item","Kilos.","Valor Total"}

SOMBRA(05,05,22,76)
@ 05,24 SAY "Consulta de Vendas de Produtos"
@ 22,07 SAY "<F5> - Marca; <F6> - Exclui; <ENTER> - Edita"
dbedit(06,06,21,75,aVet_campos,"cons_mv",aVet_masc,aVet_cab,"Ä","³")
RELEASE ALL
CLOSE ALL
RETURN

* eop caCMEST.prg