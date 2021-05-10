/*
BOP cemest.PRG

PROGRAMA : cemest.PRG
DATA     : 09/06/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : ENTRADAS E BAIXAS NO ESTOQUE
SISTEMA  : CONTROLE DE ESTOQUE
LINGUAGEM: CLIPPER 5.01
*/

PARAMETERS Modo

LOCAL CONF := .T.

SELE 1
USE CEBMEST INDEX CEIMEST

IF MODO = 1
   SELE 2
   USE CEBFOR INDEX CEIFOR, CEIFOR2
   cMostra1 := "Codigo do Fornecedor:"
   cMostra2 := "Quantidade Comprada.:"
   cMostra3 := "Fornecedor "
   cTipo    := "C"
   cMostra4 := "Entrada"
   cMostra5 := "Reposicao de Materiais em Estoque"
   cMostra6 := "D"
   cMostra7 := "Pagamento "
ELSE
   SELE 2
   USE CEBCLI INDEX CEICLI, CEICLI2
   cMostra1 := "Codigo do Cliente...:"
   cMostra2 := "Quantidade Vendida..:"
   cMostra3 := "Cliente "
   cTipo    := "V"
   cMostra4 := "Saida  "
   cMostra5 := "Venda de Materiais em Estoque"
   cMostra6 := "C"
   cMostra7 := "Recebimento "
ENDIF

SELE 3
USE CEBEST INDEX CEIEST, CEIEST2

SELE 4
USE CEBLANCA

SELE 5
USE CEBAGEN INDEX CEIAGEN

sombra(07,07,18,70)
@ 07,27 SAY cMostra4+" de Produtos"
@ 08,08 say cMostra1
@ 09,08 say "Nome................:"
@ 10,08 say "Codigo do Produto...:"
@ 11,08 say "Produto.............:"
@ 12,08 say "Valor Unitario......:"
@ 13,08 say "Quantidade Estocada.:"
@ 14,08 say cMostra2
@ 15,08 say "Valor Total.........:"
@ 16,08 SAY "Quantidade Atual....:"
@ 17,08 say "Data................:"
SAVE SCREEN TO sTela1
corcli := setcolor()
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   setcolor(corcli)
   cCod_pes   := space(6)
   cPessoa    := space(40)
   cCod_item  := space(06)
   cItem      := space(40)
   nQuant_es  := 0
   nQuant     := 0
   nQuant_tot := 0
   nVal_uni   := 0
   nVal_tot   := 0
   nQuant_min := 0
   @ 08,30 GET cCod_pes PICT "@!"
   READ
   SELE 2
   IF empty(cCod_pes) .and. lastkey()=13
      SET ORDER TO 2
      nProc := tabela()
      SET ORDER TO 1
      IF empty(nProc)
        LOOP
      ENDIF
      cCod_pes = Codigo
      @ 8,30 GET cCod_pes PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCod_pes) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   SEEK cCod_pes
   IF .NOT. FOUND()
      mensagem(cMostra3+"Nao Cadastrado")
      LOOP
   ENDIF
   cPessoa:= Nome
   @ 09,30 GET cPessoa PICT "@!"
   CLEAR GETS
   @ 10,30 GET cCod_item PICT "@!"
   READ
   SELE 3
   IF empty(cCod_item) .and. lastkey()=13
      SET ORDER TO 2
      nProc := tabela()
      SET ORDER TO 1
      IF empty(nProc)
        LOOP
      ENDIF
      cCod_item := Codigo
      @ 10,30 GET cCod_item PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCod_item) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   SEEK cCod_item
   IF .NOT. FOUND()
      mensagem("Item  Nao  Cadastrado")
      LOOP
   ENDIF
   cItem     := produto
   nQuant_es := qtd
   nVal_uni  := if(modo=1,valunit,valunitv)
   nQuant_min:= Qtdmin
   nLucro    := if(modo=2,valunitv-valunit,0)
   @ 11,30 get cItem PICT "@!"
   @ 12,30 get nVal_uni  PICT "999,999.99"
   @ 13,30 get nQuant_es  PICT "9999"
   CLEAR GETS
   @ 14,30 GET nQuant PICT "9999" valid(nQuant > 0)
   READ
   nVal_tot := nQuant*nVal_uni
   IF Modo = 1
      nQuant_tot := nQuant + nQuant_es
   ELSE
      nQuant_tot := nQuant_es - nQuant
      IF nQuant_tot < nQuant_min
         mensagem("Quantidade Insuficiente em Estoque")
         LOOP
      ENDIF
   ENDIF
   @ 15,30 GET nVal_tot PICT "999,999.99"
   @ 16,30 GET nQuant_tot PICT "9999"
   @ 17,30 GET data_sis PICT "99/99/99"
   CLEAR GETS
   inkey(5)
   IF confirma("Os Dados Estao Corretos")
      SELE 1
      APPEND BLANK
      REPLACE Cod_pes  WITH cCod_pes
      REPLACE Pessoa   WITH cPessoa
      REPLACE Cod_item WITH cCod_item
      REPLACE Item     WITH cItem
      REPLACE Quant    WITH nQuant
      REPLACE Val_uni  WITH nVal_uni
      REPLACE Val_tot  WITH nVal_tot
      REPLACE Data_neg WITH Data_sis
      REPLACE tipo     WITH cTipo
      REPLACE lucro    WITH nLucro
      SELE 3
      REPLACE qtd WITH nQuant_tot
      IF  confirma("Deseja registrar o "+cMostra7+" na agenda?")
         SELE 5
         gera_agd(nVal_Tot, cMostra6, cCod_pes, cPessoa)
      ELSE
         SELE 4
         APPEND BLANK
         REPLACE Descricao WITH cMostra5
         REPLACE Valor     WITH nVal_tot
         REPLACE Tipo      WITH cMostra6
         REPLACE Data      WITH DATA_SIS
      ENDIF
   ENDIF
   CONF=confirma("Deseja Continuar na "+cMostra4+" de Produtos?")
ENDDO
RELEASE ALL
CLOSE ALL
RETURN

* eop cemest.prg