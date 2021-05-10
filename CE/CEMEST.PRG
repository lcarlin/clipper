#include "common.ch"
#include "inkey.ch"
/*
BOP CEMEST.PRG
FUNCAO  MOVIMENTACAO DO ESTOQUE ( BAIXA / ENTRADA)
DATA    15/04/95
AUTOR    LUIZ ANTONIO CARLIN
SISTEMA   CONTROLE DE ESTOQUE
LINGUAGEM  CLIPPER5.2
*/
   local Local1
   parameters modo
   Local1:= .T.
   select 1
   use CEBMEST index CEIMEST
   if (modo == 1)
      select 2
      use CEBFOR index CEIFOR, CEIFOR2
      cmostra1:= "Codigo do Fornecedor:"
      cmostra2:= "Quantidade Comprada.:"
      cmostra3:= "Fornecedor "
      ctipo:= "C"
      cmostra4:= "Entrada"
      cmostra5:= "Reposicao de Materiais em Estoque"
      cmostra6:= "D"
      cmostra7:= "Pagamento "
      IF .NOT. file("COMPRAS.MEM")
         n_mov := cTipo + "0"
         SAVE TO COMPRAS ALL LIKE n_mov
      ELSE
         RESTORE FROM COMPRAS ADDITIVE
      ENDIF
   else
      select 2
      use CEBCLI index CEICLI, CEICLI2
      cmostra1:= "Codigo do Cliente...:"
      cmostra2:= "Quantidade Vendida..:"
      cmostra3:= "Cliente "
      ctipo:= "V"
      cmostra4:= "Saida  "
      cmostra5:= "Venda de Materiais em Estoque"
      cmostra6:= "C"
      cmostra7:= "Recebimento "
      IF .NOT. file("VENDAS.MEM")
         n_mov := cTipo + "0"
         SAVE TO VENDAS ALL LIKE n_mov
      ELSE
         RESTORE FROM VENDAS ADDITIVE
      ENDIF
   endif
   
   select 3
   use CEBEST index CEIEST, CEIEST2
   select 4
   use CEBLANCA
   select 5
   use CEBAGEN index CEIAGEN
   select 6
   use CEBFUN index CEIFUN, CEIFUN2
   sombra(7, 7, iif(modo = 1, 18, 19), 70)
   @  7, 27 say cmostra4 + " de Produtos"
   @  8,  8 say cmostra1
   @  9,  8 say "Nome................:"
   @ 10,  8 say "Codigo do Produto...:"
   @ 11,  8 say "Produto.............:"
   @ 12,  8 say "Valor Unitario......:"
   @ 13,  8 say "Quantidade Estocada.:"
   @ 14,  8 say cmostra2
   @ 15,  8 say "Valor Total.........:"
   @ 16,  8 say "Quantidade Atual....:"
   @ 17,  8 say "Data................:"
   if (modo == 2)
      @ 18,  8 say "Funcionario:"
      @ 15, 43 say "Retirada p/ uso Interno ?"
      aOpcReti := {{16,47," N„o "},{16,54," Sim "}}
      botao(aOpcReti,.f.)
   endif
   save screen to stela1
   corcli:= SetColor()
   do while (Local1)
      IF len(n_mov) > 18
         n_Mov := cTipo+"0"
      ENDIF  // X99999999999999999
      restore screen from stela1
      set color to (corcli)
      ccod_pes:= Space(6)
      cpessoa:= Space(40)
      ccod_item:= Space(6)
      citem:= Space(40)
      ccodfunc:= Space(6)
      nquant_es:= 0
      nquant:= 0
      nquant_tot:= 0
      nval_uni:= 0
      nval_tot:= 0
      nquant_min:= 0
      lGrava    := .T.
      @  8, 30 get cCod_pes picture "@!"
      read
      select 2
      if (Empty(ccod_pes) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         set order to 1
         if (Empty(nproc))
            loop
         endif
         ccod_pes:= codigo
         @  8, 30 get cCod_pes picture "@!"
         clear gets
      elseif (Empty(ccod_pes) .AND. LastKey() = K_ESC)
         exit
      endif
      set color to (corcli)
      seek ccod_pes
      if (!Found())
         mensagem(cmostra3 + "Nao Cadastrado")
         loop
      endif
      cpessoa:= nome
      @  9, 30 get cPessoa picture "@!"
      clear gets
      @ 10, 30 get cCod_item picture "@!"
      read
      select 3
      if (Empty(ccod_item) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         set order to 1
         if (Empty(nproc))
            loop
         endif
         ccod_item:= codigo
         @ 10, 30 get cCod_item picture "@!"
         clear gets
      elseif (Empty(ccod_item) .AND. LastKey() = K_ESC)
         exit
      endif
      set color to (corcli)
      seek ccod_item
      if (!Found())
         mensagem("Item  Nao  Cadastrado")
         loop
      endif
      citem:= produto
      nquant_es:= qtd
      nval_uni:= iif(modo = 1, valunit, valunitv)
      nquant_min:= qtdmin
      nlucro:= iif(modo = 2, valunitv - valunit, 0)
      @ 11, 30 get cItem picture "@!"
      CLEAR GETS
      @ 12, 30 get nVal_uni picture "999,999.99"
      READ
      @ 13, 30 get nQuant_es picture "9999"
      clear gets
      @ 14, 30 get nQuant picture "9999" valid nquant > 0
      read
      nval_tot:= nquant * nval_uni
      if (modo == 1)
         nquant_tot:= nquant + nquant_es
      else
         nquant_tot:= nquant_es - nquant
         if (nquant_tot < nquant_min)
            mensagem("Quantidade Insuficiente em Estoque")
            loop
         endif
      endif
      @ 15, 30 get nVal_tot picture "999,999.99"
      READ
      @ 16, 30 get nQuant_tot picture "9999"
      @ 17, 30 get data_sis picture "99/99/99"
      clear gets
      nRetira := if(modo=2,botao(aOPcReti),0)
      IF lastkey() = 27
         LOOP
      ENDIF
      if (modo == 2 .AND. nRetira = 1)
         select 6
         @ 18, 21 get cCodFunc picture "@!"
         read
         if (Empty(ccodfunc) .AND. LastKey() = K_ENTER)
            set order to 2
            nproc:= tabela()
            set order to 1
            if (Empty(nproc))
               loop
            endif
            ccodfunc:= codigo
            @ 18, 21 get cCodFunc picture "@!"
            clear gets
         elseif (Empty(ccodfunc) .AND. LastKey() = K_ESC)
            exit
         endif
         set color to (corcli)
         seek ccodfunc
         if (!Found())
            mensagem("Funcionario nao Cadastrado!")
            loop
         endif
         @ 18, 28 say nome
         lGrava := .T.
      ELSEIF (modo = 2 .AND. nRetira = 2)
         lGrava := .F.
      endif
      InKey(5)
      if (confirma("Os Dados Estao Corretos"))
         nNMov := val(substr(n_mov,2))+1
         n_Mov :=ctipo+alltrim(str(nNmov))
         select 3
         replace qtd with nquant_tot
         if (lgrava)
            select 1
            append blank
            replace cod_pes with ccod_pes
            replace pessoa with cpessoa
            replace cod_item with ccod_item
            replace item with citem
            replace quant with nquant
            replace val_uni with nval_uni
            replace val_tot with nval_tot
            replace data_neg with data_sis
            replace tipo with ctipo
            replace lucro with nlucro
            replace codfunc with iif(modo = 2, ccodfunc, "COMPRA")
            REPLACE NMOV WITH n_mov
            if (confirma("Deseja registrar o " + cmostra7 + ;
                  " na agenda?"))
               select 5
               gera_agd(nVal_tot, cmostra6, ccod_pes, cpessoa,n_mov) 
           else 
               select 4 
               append blank 
               replace descricao with cmostra5 
               replace valor with nval_tot 
               replace tipo with cmostra6 
               replace data with data_sis 
               REPLACE NMOV WITH n_mov 
            endif 
         endif 
      endif 
      Local1:= confirma("Deseja Continuar na " + cmostra4 + " de Produtos?") 
   enddo 
   IF cTipo = "V" 
      SAVE TO VENDAS  ALL LIKE n_mov 
   ELSE 
      SAVE TO COMPRAS ALL LIKE n_mov 
   ENDIF 
   release all
   close databases 
   select 1 
   close format 
   return

* EOF
