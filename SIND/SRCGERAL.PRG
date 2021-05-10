#include "common.ch"
#include "inkey.ch"

********************************

   public avet_camp
   parameters tipo_c
   do case
   case tipo_c == 1
      cmostra1:= "Consulta de Clientes"
      avet_camp:= {"codigo", "nome", "rg", "cpf", "INSC", ;
         "endereco", "cidade", "estado", "cep", "telefone", "obs"}
      avet_masc:= {"@!", "@!", "@!", "@!", "@!", "@!", "@!", "@!", ;
         "@!", "@!", "@!"}
      avet_cab:= {" Codigo:", " Nome:", " R.G.:", " C.P.F.:", ;
         "Insc. Estadual:", " Endereco:", " Cidade:", " Estado:", ;
         " Cep:", " Telefone:", " Obs:"}
      use cebcli index ceicli2
   case tipo_c == 2
      cmostra1:= "Consulta de Fornecedores"
      avet_camp:= {"codigo", "nome", "empresa", "rg", "cpf", "INSC", ;
         "endereco", "cidade", "estado", "cep", "telefone", "item"}
      avet_masc:= {"@!", "@!", "@!", "@!", "@!", "@!", "@!", "@!", ;
         "@!", "@!", "@!", "@!", "@!"}
      avet_cab:= {"Codigo", "Nome", "Empresa", "R.G.", "C.P.F.", ;
         "Insc. Estadual", "Endereco", "Cidade", "Estado", "Cep", ;
         "Telefone", "Itens"}
      use cebfor index ceifor2
   case tipo_c == 3
      cmostra1:= "Consulta de Funcionarios"
      avet_camp:= {"codigo", "nome", "cargo", "rg", "cpf", "nasc", ;
         "endereco", "cidade", "estado", "cep", "telefone", "obs"}
      avet_masc:= {"@!", "@!", "@!", "@!", "@!", "@!", "@!", "@!", ;
         "@!", "@!", "@!", "@!", "@!"}
      avet_cab:= {"Codigo", "Nome", "Cargo", "R.G.", "C.P.F.", ;
         "Nascimento", "Endereco", "Cidade", "Estado", "Cep", ;
         "Telefone", "Obs:"}
      use cebfun index ceifun2
   case tipo_c == 4
      cmostra1:= "Consulta de Materiais da Premix"
      avet_camp:= {"codigo", "Produto", "valunit", "valunitv"}
      avet_masc:= {"@!", "@!", "9,999,999.99", "9,999,999.99"}
      avet_cab:= {"Codigo", "Produto", "Valor Unitario", ;
         "Valor Unitario(Venda)"}
      use cebpre index ceipre2
   case tipo_c == 5
      cmostra1:= "Consulta de Materiais em Estoque"
      avet_camp:= {"codigo", "produto", "embalagem", "cat_des","valunit", ;
         "valunitv", "valunitv-valunit", "qtd", "qtdmin"}
      avet_masc:= {"@!", "@!", "@!", "@!","999,999.99", "999,999.99", ;
         "999,999.99", "9999", "999"}
      avet_cab:= {"Codigo", "Item", "Embalagem", "Categoria",;
         "Valor Unitario(Compra)", "Valor Unitario(Venda)", ;
         " (Lucro)", "Quantidade", "Quantidade Minima"}
      use cebest index ceiest2
   endcase
   sombra(3, 3, 21, 77)
   @  3, 20 say cmostra1
   dbedit(4, 4, 20, 76, avet_camp, "CONSULTA", avet_masc, avet_cab, ;
      "Ä", "³")
   close databases
   select 1
   close format
   release all
   return

* EOF
