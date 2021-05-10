***********************
* BOP CVTELAS.PRG
* sistema : SCCV
* comet   : tela de manutencao de clientes
***********************
procedure men_t_1
set color to w/n
borda(6,9,19,70)
*set color to w/g
do mens
@06, 25 say "Manutencao    de    Clientes"
@8,10 say  "Codigo....:"
@9,10 say  "Nome......:"
@10,10 say "Endereco..:"
@11,10 say "Cidade....:"
@12,10 say "CEP.......:"
@13,10 say "U.F.......:"
@14,10 SAY "Telefone..:"
@15,10 say "R.G.......:"
@16,10 say "CIC.......:"
@17,10 say "Nascimento:"
@13,50 say "Data:"
@16,38 say "Participa de Consorcio..:"
return

****************
procedure men_t_2
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 25 say "Manutencao   de   Funcionarios"
do mens
@8,10 say  "Codigo....:"
@9,10 say  "Nome......:"
@10,10 say "Endereco..:"
@11,10 say "Cidade....:"
@12,10 say "CEP.......:"
@13,10 say "Cargo.....:"
@14,10 say "Salario...:"
@15,10 say "Comiss„o..:"

return

***********************
procedure men_t_3
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 25 say "Manutencao   de   Fornecedores"
do mens
@08,10 say "Codigo.....:"
@09,10 say "Nome.......:"
@10,10 say "Telefone...:"
@11,10 say "CEP........:"
@12,10 say "Cidade.....:"
@13,10 say "Endereco...:"
@14,10 say "Codigo-Item:"
@15,10 say "Descri‡„o..:"
@16,10 say "Fabrica....:"
@17,10 say "C.G.C......:"
@18,10 say "Obser.<S/N>:"
return

***************************************
procedure men_t_4
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 25 say "Vendas    de     Pecas"
do mens
@8,10 say  "Codigo do Cliente:"
@9,10 say  "Nome.............:"
@10,10 say "Codigo da Peca...:"
@11,10 say "tipo.............:"
@12,10 say "Qtde.............:"
@13,10 say "Valor............:"
@14,10 say "cod do fornecedor:"
@15,10 say "Nome.............:"

return
**************************

procedure men_t_11
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 25 say "Reparos    de    Autos"
do mens
@8,10 say  "Codigo do Cliente:"
@9,10 say  "Nome.............:"
@10,10 say "Codigo da func...:"
@11,10 say "Nome.............:"
borda(12,0,19,79)
@13,10 say "Pecas Consumidas.:"
@14,1 say "Codigo Peca³Descricao Pecas                    ³Quant Comprad  ³Subtotal"
return
***************************

procedure men_t_12
set color to w/n
borda(7,10,20,71)
*set color to w/g
@07,27 say "C o n s o r c i o s"
do mens
@08,11 say "Codigo do Cliente:"
@09,11 say "Nome.............:"
@10,11 say "Codigo do Carro..:"
@11,11 say "Codigo Do Grupo..:"
@12,11 say "N§ de Part.......:"
@13,11 say "Valor Da Presta..:"
@14,11 say "N§ De Meses......:"
@15,11 say "Data.............:"
@16,11 say "Consorciado n§...:"
@17,11 say "Cod. Funcionario.:"
return
*************************************

procedure men_t_13
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 24 say "Pronta Enterga de Veiculos"
do mens
@8,10 say  "Codigo do Carro..:"
@9,10 say  "Descricao........:"
@10,10 say "Valor Veiculo....:"
@11,10 say "Codigo do Funci..:"
@12,10 say "Nome funcionario.:"
@13,10 say "Codigo Cliente...:"
@14,10 say "Nome Cliente.....:"

return
****************************

procedure men_t_14
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 25 say "Estoque  de  Pecas"
do mens
@ 8,10 say  "Codigo...........:"
@ 9,10 say  "Descricao........:"
@ 10,10 say "Quantidade.......:"
@ 11,10 say "Valor unitario...:"
@ 12,10 say "Quantidade Minima:"
@ 13,10 say "Codigo do Fornec.:"
@ 14,10 say "Nome.............:"

return
*******************************

procedure men_t_15
set color to w/n
Borda(6,9,19,70)
*set color to w/g
@6, 25 say "Manutecao   de   Estoque - Pecas -"
do mens
@8,10 say  "Codigo............:"
@9,10 say  "Descricao.........:"
@10,10 say "Quantidade........:"
@11,10 say "Valor unitario....:"
@12,10 say "Quantidade Minima.:"
@13,10 say "Quantidade Vendida:"
@14,10 say "Codigo Funcionario:"
@15,10 say "Nome Funcionaio...:"
@16,10 say "Codigo Cliente....:"
@17,10 say "Nome Cliente......:"
return
**************************************

procedure men_t_16
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 25 say "Manutecao   de   Estoque - Almoxarifado -"
do mens
@8,10 say  "Codigo...........:"
@9,10 say  "Descricao........:"
@10,10 say "Quantidade.......:"
@11,10 say "Valor unitario...:"
@12,10 say "Quantidade Minima:"
@13,10 say "Codigo do Fornec.:"
@14,10 say "Nome.............:"

return
*****************************

procedure men_t_17
set color to w/n
borda(6,9,19,70)
*set color to w/g
@6, 25 say "Manutecao   de   Estoque - Frota -"
do mens
@8,10 say  "Codigo...........:"
@9,10 say  "Veiculo..........:"
@10,10 say "Quantidade.......:"
@11,10 say "Valor............:"
@12,10 say "Data comissao....:"
@13,10 say "chassis..........:"
return

*********************************
procedure mens
cor = setcolor()
setcolor("w/b")
@23,15 say "<Esc>-Retorna <ENTER>-Tabela de Codigos"
setcolor(cor)

* EOP CVTELAS.PRG