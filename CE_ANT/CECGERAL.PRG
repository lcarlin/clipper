/* BOP CECGERAL.PRG
PROGRAMA    : CECGERAL.PRG
DATA        : 12/06/94
AUTOR       : LUIZ ANTONIO CARLIN
FUNCAO      : CONSULTA GERAL DOS DADOS (CLIENTES, FORNECEDORES, MAT. EM ESTOQUE)
SISTEMA     : CONTROLE DE ESTOQUE
LINGUAGEM   : CLIPPER 5.01
*/

public aVet_camp

PARAMETERS Tipo_c

IF TIPO_C = 1
  
   cMostra1  := "Consulta de Clientes"
   aVet_camp := {"codigo","nome","rg","cpf","INSC","endereco","cidade","estado","cep","telefone","obs"}
   aVet_masc := {"@!","@!","@!","@!","@!","@!","@!","@!","@!","@!","@!"}
   aVet_cab  := {" Codigo:"," Nome:"," R.G.:"," C.P.F.:","Insc. Estadual:"," Endereco:"," Cidade:"," Estado:"," Cep:"," Telefone:"," Obs:"}
   USE cebcli INDEX ceicli2
ELSEIF TIPO_C = 2
   cMostra1  := "Consulta de Fornecedores"
   aVet_camp := {"codigo","nome","empresa","rg","cpf","INSC","endereco","cidade","estado","cep","telefone","item"}
   aVet_masc := {"@!","@!","@!","@!","@!","@!","@!","@!","@!","@!","@!","@!","@!"}
   aVet_cab  := {"Codigo","Nome","Empresa","R.G.","C.P.F.","Insc. Estadual","Endereco","Cidade","Estado","Cep","Telefone","Itens"}
   USE cebfor INDEX ceifor2
ELSE
   cMostra1   := "Consulta de Materiais em Estoque"
   aVet_camp  := {"codigo","produto","embalagem","valunit","valunitv","valunitv-valunit","qtd","qtdmin"}
   aVet_masc  := {"@!","@!","@!","999,999.99","999,999.99","999,999.99","9999","999"}
   aVet_cab   := {"Codigo","Item","Embalagem","Valor Unitario(Compra)","Valor Unitario(Venda)"," (Lucro)","Quantidade","Quantidade Minima"}
   USE cebest INDEX ceiest2
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

* eop cecgeral.prg
