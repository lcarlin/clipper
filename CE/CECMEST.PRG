#include "common.ch"
#include "inkey.ch"

********************************

   parameters tipo_con
   PUBLIC aVet_camp, aVetMasc, TIpo_CON
   USE cebest   INDEX ceiest  NEW
   USE ceblanca              NEW
   USE cebcus   INDEX ceicus  NEW
   USE cebagen  INDEX ceiagen NEW
   use CEBMEST  index CEIMEST NEW
   if (tipo_con == 3)
      set filter to Tipo = "C"
      goto top
      cmostra1:= "Fornecedor"
      cmostra2:= "Entrada"
   else
      set filter to Tipo = "V"
      goto top
      cmostra1:= "Cliente"
      cmostra2:= " Saida "
   endif
   avet_camp:= {"marcado","data_neg", "cod_pes", "pessoa", "cod_item", "item", ;
      "quant", "Val_uni*quant"}
   avet_masc:= {"!","99/99/99", "@!", "@!", "@!", "@!", "9999", ;
      "99,999.99", Nil}
   avet_cab:= {"Sel.","Data", "Codigo", cmostra1, "Cod. Item", "Item", ;
      "Quant.", "Valor Total"}
   sombra(5, 5, 22, 76)
   @  5, 24 say "Consulta de " + cmostra2 + " de Produtos"
   @ 22,06 SAY "<ENTER> - Edita; <F2> - Marca/Desmarca; <DELETE> - Exclui"
   dbedit(6, 6, 21, 75, avet_camp, "cons001", avet_masc, avet_cab, ;
      "Ä", "³")
   set filter to
   goto top
   release all
   close databases
   select 1
   close format
   return

* EOF
