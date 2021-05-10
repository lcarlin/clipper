#include "common.ch"
#include "inkey.ch"

********************************

   local Local1
   Local1:= .T.
   use CEBPRE index CEIPRE, CEIPRE2
   sombra(7, 7, 12, 75)
   @  7, 32 say "Produtos da Premix"
   @  8,  8 say "Codigo.................:"
   @  9,  8 say "Produto................:"
   @ 10,  8 say "Valor Unitario (Tabela):"
   @ 11,  8 say "Valor Unitario (Venda).:"
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   do while (Local1)
      restore screen from stela1
      select 1
      set color to (corcli)
      ccod:= Space(6)
      linclui:= .F.
      alter:= 0
      @  8, 33 get cCod picture "@!"
      read
      if (Empty(ccod) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         if (Empty(nproc))
            loop
         endif
         ccod:= codigo
         @  8, 33 get cCod picture "@!"
         clear gets
      elseif (Empty(ccod) .AND. LastKey() = K_ESC)
         exit
      endif
      set color to (corcli)
      set order to 1
      seek ccod
      if (!Found())
         linclui:= ;
            confirma("Codigo nao cadastrado! Deseja Cadastrar ?")
         cproduto:= Space(40)
         nvalunit:= 0
         nvalunitv:= 0
      else
         select 1
         cproduto:= produto
         nvalunit:= valunit
         nvalunitv:= valunitv
         @  9, 33 say cproduto picture "@!"
         @ 10, 33 say nvalunit picture "999,999.99"
         @ 11, 33 say nvalunitv picture "999,999.99"
         InKey(5)
         save screen to stela_ant
         set color to gr+/b
         sombra(10, 18, 14, 46)
         @ 11, 20 say "Codigo Existente:" color "R/n"
         set color to (corcli)
         alter:= botao(mopcao)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?"))
               delete
            endif
         endif
      endif
      if (alter = 1 .OR. linclui)
         @  9, 33 get cProduto picture "@!"
         @ 10, 33 get nValunit picture "999,999.99"
         @ 11, 33 get nValunitv picture "999,999.99"
         read
         if (confirma("Os dados estao corretos ?"))
            if (linclui)
               append blank
            endif
            replace codigo with ccod
            replace produto with cproduto
            replace valunit with nvalunit
            replace valunitv with nvalunitv
         else
            loop
         endif
      endif
      Local1:= ;
         confirma("Deseja Continuar na Manutencao de Itens da Premix ?")
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOF
