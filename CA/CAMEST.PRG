/*
BOP camest.PRG

PROGRAMA : camest.PRG
DATA     : 07/07/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : BAIXAS NO ESTOQUE
SISTEMA  : CONTROLE DE ACOUGUES
LINGUAGEM: CLIPPER 5.01
*/


LOCAL CONF := .T.
IF .NOT. file("CAVENDA.MEM")
   nNvenda := 0
ELSE
   RESTORE FROM CAVENDA ADDITIVE
ENDIF

SELE 1
USE CABMEST INDEX caIMEST

SELE 2
USE CABCLI INDEX caICLI, CAICLI2


SELE 3
USE CABEST INDEX caIEST, CAIEST2

SELE 4
USE CABLANCA

SELE 5
USE CABAGEN INDEX CAIAGEN


SOMBRA(07,07,17,70)
@ 07,27 SAY "Venda de Produtos"
@ 08,08 say "Codigo do cliente...:"
@ 09,08 say "Nome................:"
@ 10,08 say "Codigo da Carne.....:"
@ 11,08 say "Tipo da carne.......:"
@ 12,08 say "Valor por Kilo......:"
@ 13,08 say "Kilos Vendidos......:"
@ 14,08 say "Valor Total.........:"
@ 15,08 say "Data do Pagamento...:"
SAVE SCREEN TO sTela1
corcli := setcolor()
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   setcolor(corcli)
   cCod_pes   := space(6)
   cPessoa    := space(40)
   cCod_item  := space(06)
   cItem      := space(40)
   nQuant     := 0
   nVal_uni   := 0
   nVal_tot   := 0
   dData_pg   := data_sis
   @ 08,30 GET cCod_pes PICT "@!"
   READ
   SELE 2
   IF empty(cCod_pes) .and. lastkey()=13
      SET ORDER TO 2
      nProc := tabela()
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
   SET ORDER TO 1
   SEEK cCod_pes
   IF .NOT. FOUND()
      mensagem("Cliente Nao Cadastrado")
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
   SET ORDER TO 1
   SEEK cCod_item
   IF .NOT. FOUND()
      mensagem("Item  Nao  Cadastrado")
      LOOP
   ENDIF
   cItem     := produto
   nVal_uni  := valunit
   @ 11,30 get cItem PICT "@!"
   @ 12,30 get nVal_uni  PICT "999,999.99"
   CLEAR GETS
   centra(24,"<F1> - Help; <ESC> - Sair","gr+/bg")

   @ 13,30 GET nQuant PICT "9999.999" valid(nQuant > 0)
   READ
   nVal_tot := nQuant*nVal_uni
   @ 14,30 GET nVal_tot PICT "999,999.99"
   clear GETS
   @ 15,30 GET dData_pg PICT "99/99/99"  valid(dia_util(ddata_pg))
   READ
   inkey(5)
   IF confirma("Os Dados Estao Corretos")
      nNvenda++
      cNvenda := "V"+alltrim(str(nNvenda))
      SELE 1
      APPEND BLANK
      REPLACE Cod_pes  WITH cCod_pes
      REPLACE Pessoa   WITH cPessoa
      REPLACE Cod_item WITH cCod_item
      REPLACE Item     WITH cItem
      REPLACE Quant    WITH nQuant
      REPLACE Val_uni  WITH nVal_uni
      REPLACE Val_tot  WITH nVal_tot
      REPLACE Data_neg WITH dData_pg
      REPLACE tipo     WITH "V"
      REPLACE NMOV     WITH cNvenda
      IF confirma("Deseja registrar o pagamento na agenda?")
         sele 5
         APPEND BLANK
         REPLACE CODIGO    WITH cCod_pes
         REPLACE NOME_FOR  WITH cPessoa
         REPLACE VALOR     WITH nVal_tot
         REPLACE DATA_PG   WITH dData_pg
         REPLACE TIPO_CAR  WITH cItem
         REPLACE QTD_CAR   WITH nQuant
         REPLACE tipo     WITH "V"
         REPLACE NMOV     WITH cNvenda
      ELSE
         SELE 4
         APPEND BLANK
         REPLACE Descricao WITH "Venda de carnes no balcao"
         REPLACE Valor     WITH nVal_tot
         REPLACE Data      WITH dData_pg
         REPLACE tipo      WITH "C"
         REPLACE NMOV     WITH cNvenda
      ENDIF
   ENDIF
   CONF=confirma("Deseja Continuar na Venda de Produtos?")
ENDDO
SAVE TO CAVENDA ALL LIKE nNvenda
RELEASE ALL
CLOSE ALL
RETURN

* eop camest.prg