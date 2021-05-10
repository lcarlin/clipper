
/*
BOP cemtest.PRG

PROGRAMA : cemtest.PRG
DATA     : 09/06/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : MANUTENCAO DE ITENS NO ESTOQUE
SISTEMA  : CONTROLE DE ESTOQUE
LINGUAGEM: CLIPPER 5.01
*/

LOCAL CONF := .T.

SELE 1
USE CEBEST INDEX CEIEST, CEIEST2

SELE 2
USE CEBLANCA

SELE 3
USE CEBFOR INDEX CEIFOR, CEIFOR2

SELE 4
USE CEBAGEN INDEX CEIAGEN


SOMBRA(07,07,17,75)
@ 07,30 SAY "Manuten‡„o de Estoques"
@ 08,08 say "Codigo.................:"
@ 09,08 say "Produto................:"
@ 10,08 say "Embalagem..............:"
@ 11,08 say "Valor Unitario (Compra):"
@ 12,08 say "Valor Unitario (Venda).:"
@ 13,08 say "Quantidade.............:"
@ 14,08 say "Quantidade Min.........:"
@ 15,08 SAY "Codigo do Fornecedor...:"
@ 16,08 SAY "Nome...................:"
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
      cEmbalagem := space(25)
      cCodFor    := space(06)
      cNomeFor   := space(40)
      nValunit   := 0
      nValunitv  := 0
      nQtd       := 0
      nQtdmin    := 0
   ELSE
      SELE 1
      cProduto   := Produto
      cEmbalagem := Embalagem
      nValunit   := Valunit
      nValunitv  := Valunitv
      nQtd       := Qtd
      nQtdmin    := Qtdmin
      cCodfor    := COD_PES
      cNomefor   := PESSOA
      @ 09,33 SAY cProduto   PICT "@!"
      @ 10,33 SAY cEmbalagem PICT "@!"
      @ 11,33 SAY nValunit   PICT "999,999.99"
      @ 12,33 SAY nValunitv  PICT "999,999.99"
      @ 13,33 SAY nQtd       PICT "9999"
      @ 14,33 SAY nQtdmin    PICT "999"
      @ 15,33 SAY cCodfor    PICT "@!"
      @ 16,33 SAY cNomeFor   PICT "@!"
      CLEAR GETS
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
      @ 10,33 GET cEmbalagem PICT "@!"
      @ 11,33 GET nValunit   PICT "999,999.99"
      @ 12,33 GET nValunitv  PICT "999,999.99"
      @ 13,33 GET nQtd       PICT "9999"  WHEN(nQtd=0)
      @ 14,33 GET nQtdmin    PICT "999"   valid(nQtdMin<nQtd)
      READ
      @ 15,33 GET cCodFor    PICT "@!"
      READ
      SELE 3
      IF empty(cCodFOR) .and. lastkey()=13
         SET ORDER TO 2
         nProc := tabela()
         IF empty(nProc)
            LOOP
         ENDIF
         cCodFOR = Codigo
         @ 15,33 GET cCod PICT "@!"
         CLEAR GETS
      ELSEIF empty(cCod) .and. lastkey()=27
         LOOP
      ENDIF
      setcolor(corcli)
      SET ORDER TO 1
      SEEK cCodFOR
      IF .NOT. FOUND()
         mensagem("Fornecedor nao cadastrado !!")
         LOOP
      ENDIF
      cNomefor := nome
      @ 16,33 GET cNomefor PICT "@!"
      CLEAR GEts
      IF confirma("Os Dados Estao Corretos")
         SELE 1
         IF lInclui
            dbappend()
         ENDIF
         REPLACE Codigo    WITH cCod
    	 REPLACE Produto   WITH cProduto
	 REPLACE Embalagem WITH cEmbalagem
	 REPLACE Valunit   WITH nValunit
	 REPLACE Valunitv  WITH nValunitv
	 REPLACE Qtd       WITH nQtd
	 REPLACE Qtdmin    WITH nQtdmin         
         REPLACE COD_PES   WITH cCodfor
         REPLACE PESSOA    WITH cNomefor
         IF lInclui
            IF confirma("Deseja Registrar Pagamento na agenda?")
               SELE 4
               gera_agd(nQtd*nValunit, "D", cCodfor, cNomefor)
            ELSE
               SELE 2
               APPEND BLANK
               REPLACE Descricao WITH "Compra de Materiais para o Estoque"
               REPLACE Valor     WITH nQtd*nValunit
               REPLACE Tipo      WITH "D"
               REPLACE Data      WITH DATA_SIS
            ENDIF
         ENDIF
      ELSE
         LOOP
      ENDIF
   ENDIF
   CONF:=confirma("Deseja Continuar na Manutencao de Estoques?")
ENDDO
RELEASE ALL
CLOSE ALL
RETURN

* eop cemtest.prg