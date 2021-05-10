
/*
BOP cemtpre.PRG

PROGRAMA : cemtpre.PRG
DATA     : 23/08/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : MANUTENCAO DE ITENS DA PREMIX
SISTEMA  : CONTROLE DE ESTOQUE
LINGUAGEM: CLIPPER 5.2
*/

LOCAL CONF := .T.

USE CEBPRE INDEX CEIPRE, CEIPRE2


SOMBRA(07,07,12,75)
@ 07,32 SAY "Produtos da Premix"
@ 08,08 say "Codigo.................:"
@ 09,08 say "Produto................:"
@ 10,08 say "Valor Unitario (Tabela):"
@ 11,08 say "Valor Unitario (Venda).:"
SAVE SCREEN TO sTela1
corcli := setcolor()
mOpcao := array(3,3)
mOpcao := {{12,20,"Alterar"},{12,29,"Excluir"},{12,38,"Voltar"}}
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   SELE 1
   setcolor(corcli)
   cCod       := space(6)
   lInclui    := .f.
   alter      := 0
   @ 08,33 GET cCod PICT "@!"
   READ
   IF empty(cCod) .and. lastkey()=13
      SET ORDER TO 2
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCod = Codigo
      @ 8,33 GET cCod PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCod) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   SET ORDER TO 1
   SEEK cCod
   IF .NOT. FOUND()
      lInclui := confirma("Codigo nao cadastrado! Deseja Cadastrar ?")
      cProduto   := space(40)
      nValunit   := 0
      nValunitv  := 0
   ELSE
      SELE 1
      cProduto   := Produto
      nValunit   := Valunit
      nValunitv  := Valunitv
      @ 09,33 SAY cProduto   PICT "@!"
      @ 10,33 SAY nValunit   PICT "999,999.99"
      @ 11,33 SAY nValunitv  PICT "999,999.99"
      INKEY(5)
      SAVE SCREEN TO sTela_ant
      set color to gr+/b
      sombra(10,18,14,46)
      @ 11,20  SAY "Codigo Existente:" Color "R/n"
      setcolor(corcli)
      alter:=botao(mOpcao)
      RESTORE SCREEN FROM sTela_ant
      IF ALTER = 2
         IF confirma("Deseja REALMENTE Excluir o Registro ?")
	    DELE
	 ENDIF
      ENDIF
   ENDIF
   IF ALTER = 1 .OR. lInclui
      @ 09,33 GET cProduto   PICT "@!"
      @ 10,33 GET nValunit   PICT "999,999.99"
      @ 11,33 GET nValunitv  PICT "999,999.99"
      READ
      IF confirma("Os dados estao corretos ?")
         IF lInclui
            dbappend()
         ENDIF
         REPLACE Codigo    WITH cCod
    	 REPLACE Produto   WITH cProduto
	 REPLACE Valunit   WITH nValunit
	 REPLACE Valunitv  WITH nValunitv
      ELSE
         LOOP
      ENDIF
   ENDIF
   CONF:=confirma("Deseja Continuar na Manutencao de Itens da Premix ?")
ENDDO
RELEASE ALL
CLOSE ALL
RETURN

* eop cemtpre.prg