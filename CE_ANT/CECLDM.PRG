/* BOP CECLDM.PRG

Programa    cecldm.prg
autor       Luiz Antonio CArlin
Data        12/06/95
Funcao      Consulta de lancamentos diarios e mensais do caixa
Sistema     Controle de estoqur
linguagem   Clipper 5.01

*/

PARAMETERS  Tipo_c

IF Tipo_c = 1
   USE CEBLANCA
   cMostra1 := "Consulta de Lan‡amentos Diarios do Caixa"
ELSE
   USE CEBLMC
   cMostra1 := "Consulta de Lancamentos Mensais do Caixa"
ENDIF

aVet_campos := {"Tipo","Data","Valor","Descricao"}
aVet_masc   := {"!","99/99/99","999,999.99","@!"}
aVet_cab    := {"Tipo:","Data:","Valor:","Descri‡ao:"}

sombra(04,04,22,77)
@ 04,19 say cMostra1
dbedit(05,05,21,76,aVet_campos,"CONSULTA",aVet_masc,aVet_cab,"Ä","³")
CLOSE ALL
RELEASE ALL
RETURN

* EOP CECLDM.PRG