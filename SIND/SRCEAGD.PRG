#include "common.ch"
#include "inkey.ch"

********************************

   parameters tipo_agd
   public ctipo3, ctitulo2, dat_fil, dano, dmes, VETOR_CAMP, VETOR_MASC
   select 2
   use CEBLANCA
   select 1
   use CEBAGEN index CEIAGEN
   if (tipo_agd == 1)
      ctitulo:= "Exclusao de Pagamentos Agendados"
      ctitulo2:= "Pagamento"
      ctitulo3:= "Fornecedor"
      ctipo3:= "D"
   elseif (tipo_agd == 2)
      ctitulo:= "Exclusao de Recebimentos agendados"
      ctitulo2:= "Recebimento"
      ctitulo3:= "Cliente"
      ctipo3:= "C"
   endif
   vetor_camp:= {"Selec", "codigo", "Nome_FOR", "Data_pg", "Valor"}
   vetor_cab:= {"Sel.", "Codigo", ctitulo3, "Data Pagto", "Valor"}
   vetor_masc:= {"!", "@!", "@!", "99/99/99", "999,999.99"}
   sombra(4, 0, 22, 78)
   @  4, 20 say ctitulo
   @ 19,  5 say "<F2> - Pesquisa data/Limpa Pesquisa; <ENTER> - Edita"
   @ 20, 29 say "<F4> - Efetua " + ctitulo2 + " da divida"
   @ 20,  5 say "<F3> - Marca/descarca"
   select 1
   set filter to TIPO=cTipo3
   goto top
   dbedit(5, 1, 18, 77, vetor_camp, "CONS003", vetor_masc, ;
      vetor_cab, "Ä", "³")
   close databases
   select 1
   close format
   return

* EOF
