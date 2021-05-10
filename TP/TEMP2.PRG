      @ 11,20 SAY DESCRICAO
      @ 12,20 SAY UN
      @ 13,20 SAY PRECO
      inkey(5)
      save screen to stela1
      corcli := setcolor(cCorJane)
      sombra(10, 18, 14, 46)
      @ 11, 20 say "Codigo Existente:" color "R/n"
      set color to (corcli)
      alter:= botao(mopcao)
      restore screen from stela1
      IF ALTER = 3 .OR. ALTER = 0
         LOOP
      ELSEIF ALTER = 2
         IF confirma("Deseja realmente Excluir o Registro ?")
            DELETE
         ENDIF
      ENDIF
   ELSE
      cDesc   := space(40)
      cUn     := space(02)
      nPreco  := 0
      IF confirma("Codigo Nao Encontrado ! Deseja Incluir ?")
         lGrava := .t.

      ENDIF
   ENDIF