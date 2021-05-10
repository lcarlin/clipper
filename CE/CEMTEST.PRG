#include "common.ch"
#include "inkey.ch"

********************************

   local Local1
   Local1:= .T.
   select 1
   use CEBEST index CEIEST, CEIEST2
   select 2
   use CEBLANCA
   select 3
   use CEBFOR index CEIFOR, CEIFOR2
   select 4
   use CEBAGEN index CEIAGEN
   sombra(7, 7, 18, 75)
   @  7, 30 say "Manuten‡„o de Estoques"
   @  8,  8 say "Codigo.................:"
   @  9,  8 say "Produto................:"
   @ 10,  8 say "Embalagem..............:"
   @ 11,  8 say "Valor Unitario (Compra):"
   @ 12,  8 say "Valor Unitario (Venda).:"
   @ 13,  8 say "Quantidade.............:"
   @ 14,  8 say "Quantidade Min.........:"
   @ 15,  8 say "Categoria..............:"
   @ 16,  8 say "Codigo do Fornecedor...:"
   @ 17,  8 say "Nome...................:"
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
         cembalagem:= Space(25)
         ccodfor:= Space(6)
         cnomefor:= Space(40)
         cCatego1 := space(02)
         cCatego2 := space(25)
         nvalunit:= 0
         nvalunitv:= 0
         nqtd:= 0
         nqtdmin:= 0
      else
         select 1
         cproduto:= produto
         cembalagem:= embalagem
         nvalunit:= valunit
         nvalunitv:= valunitv
         cCatego1 := categoria
         cCatego2 := cAt_des
         nqtd:= qtd
         nqtdmin:= qtdmin
         ccodfor:= cod_pes
         cnomefor:= pessoa
         @  9, 33 say cproduto picture "@!"
         @ 10, 33 say cembalagem picture "@!"
         @ 11, 33 say nvalunit picture "999,999.99"
         @ 12, 33 say nvalunitv picture "999,999.99"
         @ 13, 33 say nqtd picture "9999"
         @ 14, 33 say nqtdmin picture "999"
         @ 15, 33 say cCatego1 + " "+cCatego2
         @ 16, 33 say ccodfor picture "@!"
         @ 17, 33 say cnomefor picture "@!"
         clear gets
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
         @ 10, 33 get cEmbalagem picture "@!"
         @ 11, 33 get nValunit picture "999,999.99"
         @ 12, 33 get nValunitv picture "999,999.99"
         @ 13, 33 get nQtd picture "9999" when nqtd = 0
         @ 14, 33 get nQtdmin picture "999" valid nqtdmin < nqtd
         READ
         nProcura := ExisteCate()
         cCatego1 := substr(aCatego[nProcura],1,2)
         cCatego2 := substr(aCatego[nProcura],6,25)
         @ 15, 33 GET cCatego1
         @ 15,col()+1 SAY cCatego2
         CLEAR GETS
         @ 16, 33 get cCodFor picture "@!"
         read
         select 3
         if (Empty(ccodfor) .AND. LastKey() = K_ENTER)
            set order to 2
            nproc:= tabela()
            if (Empty(nproc))
               loop
            endif
            ccodfor:= codigo
            @ 16, 33 get cCod picture "@!"
            clear gets
         elseif (Empty(ccod) .AND. LastKey() = K_ESC)
            loop
         endif
         set color to (corcli)
         set order to 1
         seek ccodfor
         if (!Found())
            mensagem("Fornecedor nao cadastrado !!")
            loop
         endif
         cnomefor:= nome
         @ 17, 33 get cNomefor picture "@!"
         clear gets
         if (confirma("Os Dados Estao Corretos"))
            select 1
            if (linclui)
               append blank
            endif
            replace codigo    with ccod
            replace produto   with cproduto
            replace embalagem with cembalagem
            replace valunit   with nvalunit
            replace valunitv  with nvalunitv
            REPLACE categoria WITH cCatego1
            REPLACE cat_des   WITH cCatego2
            replace qtd       with nqtd
            replace qtdmin    with nqtdmin
            replace cod_pes   with ccodfor
            replace pessoa    with cnomefor
            if (linclui)
               if (confirma("Deseja Registrar Pagamento na agenda?"))
                  select 4
                  gera_agd(nqtd * nvalunit, "D", ccodfor, cnomefor)
               else
                  select 2
                  append blank
                  replace descricao with ;
                     "Compra de Materiais para o Estoque"
                  replace valor with nqtd * nvalunit
                  replace tipo with "D"
                  replace data with data_sis
               endif
            endif
         else
            loop
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manutencao de Estoques?")
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOF
