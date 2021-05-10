
/*
BOP camtest.PRG

PROGRAMA : camtest.PRG
DATA     : 07/07/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : MANUTENCAO DE ITENS NO ESTOQUE
SISTEMA  : CONTROLE DE ACOUGUES
LINGUAGEM: CLIPPER 5.01
*/

LOCAL CONF := .T.

USE caBEST INDEX caIEST, CAIEST2


SOMBRA(07,07,11,75)
@ 07,30 SAY "Manuten‡„o de Estoques"
@ 08,08 say "Codigo.........:"
@ 09,08 say "Tipo de carne..:"
@ 10,08 say "Preco por Kilo.:"

SAVE SCREEN TO sTela1
corcli := setcolor()
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   SELE 1
   setColor(corcli)
   cCod       := space(6)
   lInclui    := .F.
   ALTER      := 0
   @ 08,25 GET cCod PICT "@!"
   READ
   IF empty(cCod) .and. lastkey()=13
      SET ORDER TO 2
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCod = Codigo
      @ 8,25 GET cCod PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCod) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   SET ORDER TO 1
   SEEK cCod
   IF .NOT. FOUND()
      IF confirma("Codigo nao cadastrado! Deseja Cadastrar ?")
         cProduto := space(40)
         nValunit := 0
         lInclui  := .T.
      ENDIF
   ELSE
      @ 09,25 SAY Produto   PICT "@!"
      @ 10,25 SAY Valunit   PICT "999,999.99"
      INKEY(5)
      SAVE SCREEN TO sTela_ant
      mOpcao := array(3,3)
      mOpcao := {{12,20,"Alterar"},{12,29,"Excluir"},{12,38,"Voltar"}}
      centra(24,"<ENTER> - Seleciona; <F1> - Help; <ESC> - Sair","gr+/bg")
      set color to gr+/b
      sombra(10,18,14,46)
      @ 11,20  SAY "Codigo Existente:" Color "w+/n"
      setcolor(corcli)
      alter:=botao(mOpcao)
      RESTORE SCREEN FROM sTela_ant
      IF ALTER = 2
         IF confirma("Deseja REALMENTE Excluir o Registro ?")
	    DELE
	 ENDIF
      ELSEIF ALTER = 1
         cProduto   := Produto
         nValunit   := Valunit
      ENDIF
   ENDIF
   IF lInclui .OR. ALTER = 1
      centra(24,"<F1> - Help; <ESC> - Sair","gr+/bg")

      @ 09,25 GET cProduto   PICT "@!"
      @ 10,25 GET nValunit   PICT "999,999.99"
      READ 
      IF confirma("Os Dados Estao Corretos")
         IF lInclui
            dbAPPEND()
         ENDIF
         REPLACE Codigo    WITH cCod
         REPLACE Produto   WITH cProduto
	 REPLACE Valunit   WITH nValunit
      ENDIF
   ENDIF
   CONF=confirma("Deseja Continuar na Manutencao de Estoques?")
ENDDO
RELEASE ALL
CLOSE ALL
RETURN

* eop camtest.prg