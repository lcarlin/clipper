#include "common.ch"
#include "inkey.ch"

********************************

   parameters tipo_c
   PUBLIC avet_campo, aVet_Masc, aVet_cab, cPesquisa, nTam
   if (tipo_c == 1)
      use CEBLANCA
      cmostra1:= "Consulta de Lan‡amentos Diarios do Caixa"
   elseif (tipo_c == 2)
      use CEBLMC
      cmostra1:= "Consulta de Lancamentos Mensais do Caixa"
   else
      use CEBCUS
      cmostra1:= "Consulta de Custos Mensais"
   endif
   avet_campo:= {"Tipo", "Data", "Valor", "Descricao"}
   avet_masc:= {"!", "99/99/99", "999,999.99", "@!"}
   avet_cab:= {"Tipo:", "Data:", "Valor:", "Descri‡ao:"}
   sombra(4, 4, 23, 77)
   @  4, 19 say cmostra1
   @ 22,05 SAY "<ENTER>-Edita; <F8>-Pesquisa; <F9>-Limpa a Pesquisa"
   dbedit(5, 5, 21, 76, avet_campo, "CONS002", avet_masc, avet_cab, ;
      "Ä", "³")
   close databases
   select 1
   close format
   release all
   return

* EOF
