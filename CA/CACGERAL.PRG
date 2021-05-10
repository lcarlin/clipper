/* 
BOP CACGERAL.PRG
PROGRAMA    : CACGERAL.PRG
DATA        : 07/07/94
AUTOR       : LUIZ ANTONIO CARLIN
FUNCAO      : CONSULTA GERAL DOS DADOS (CLIENTES,MAT. EM ESTOQUE)
SISTEMA     : CONTROLE DE ACOUGUES
LINGUAGEM   : CLIPPER 5.01
*/

public aVet_camp

PARAMETERS Tipo_c

IF TIPO_C = 1
   cMostra1  := "Consulta de Clientes"
   aVet_camp := {"codigo","nome","Endereco","cidade","telefone","obs"}
   aVet_masc := {"@!","@!","@!","@!","@!","@!"}
   aVet_cab  := {" Codigo:"," Nome:"," Endereco:"," Cidade:"," Telefone:"," Obs:"}
   USE CAbcli INDEX CAicli2
ELSEIF TIPO_C = 2
   cMostra1   := "Consulta de Tipos De Carnes"
   aVet_camp  := {"codigo","produto","valunit"}
   aVet_masc  := {"@!","@!","999,999.99"}
   aVet_cab   := {"Codigo"," Produto","Preco(Kilo)"}
   USE CAbest INDEX CAiest2
ENDIF


sombra(03,03,21,77)
@ 03,20 SAY cMostra1
dbedit(04,04,20,76,aVet_camp,"CONSULTAr",aVet_masc,aVet_cab,"Ä","³")
CLOSE ALL
RELEASE ALL
RETURN


*******************************************************
function consultar (modo,_indice)
local  ret
cCampo := aVet_camp[_indice]
if modo = 4
   if lastkey() = 27
      return  0
   ELSEIF lastkey() = 13
      IF valtype(&cCampo) = "M"
         obser(.f.,&cCampo)
         return 1
      ENDIF
      return  1
   endif
elseif modo = 3
   mensagem ("Nao ha dados nesse arquivo!!")
   return 0
elseif modo = 2
   return 1
elseif modo = 1
   return 1
else   
   return 1
endif

* eop cacgeral.prg