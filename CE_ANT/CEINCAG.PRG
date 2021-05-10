/*
bop ceincag.prg
PROGRAMA CEINCAG.PRG
AUTOR    LUIZ ANTONIO CARLIN
DATA     28/06/95
FUNCAO   INCLUSAO DE AGENDA DE PAGAMENTO
SISTEMA  CONTROLE DE ESTOQUE
LINGUAGEM  CLIPPER 5.01
*/

PARAMETERS nTipo_inc

SAVE SCREEN TO sTela_agd1

IF nTipo_inc = 1
   SELE 5
   USE CEBFOR INDEX ceifor
   cPessoa := "Fornecedor"
   cTipo   := "D"
   cTipoD  := "Pagamento  "
ELSE
   SELE 5
   USE CEBCLI INDEX ceicli
   cPessoa := "Cliente   "
   cTipo   := "C"
   cTipoD  := "Recebimento"
ENDIF

SELE 6
USE CEBAGEN INDEX CEIAGEN

FIM := .T.
somBRa(07,07,12,69)
@ 07,20 SAY "Inclusao da Agenda de "+cTipoD
@ 08,08 SAY "Codigo.............:"
@ 09,08 SAY cPessoa+".........:"
@ 10,08 SAY "Valor..............:"
@ 11,08 SAY "Data do "+cTipoD+":"

SAVE SCREEN TO sTela_agd
CORCLI := SETCOLOR()
DO WHILE FIM
   SELE 5
   restore screen from sTela_agd
   cCodigo  := space(6)
   cEmpresa := space(40)
   dData    := ctod("  /  /  ")
   nValor   := 0
   @ 08,29 GET cCodigo PICT "@!"
   READ
   IF empty(cCodigo) .and. lastkey()=13
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCodigo = Codigo
      @ 8,29 GET cCodigo PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCodigo) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   seek cCodigo
   IF .NOT. found()
      mensagem(cPessoa+" nao cadastrado")
      LOOP
   ENDIF
   cNome := NOME
   @ 09,29 GET cNome
   CLEAR GETS
   @ 10,29 GET nValor PICT "999,999.99"
   @ 11,29 GET dData  PICT "99/99/99" valid(dia_util(dData))
   READ
   IF confirma("Os dados estao corretos ?")
      SELE 6
      APPEND BLANK
      REPLACE Codigo   WITH cCodigo
      REPLACE Nome_for WITH cNome
      REPLACE Valor    WITH nValor
      REPLACE Data_pg  WITH dData
      REPLACE TIPO     WITH cTipo
   ENDIF
   FIM := confirma("Deseja Continuar na Agenda de "+cTipoD)
ENDDO
CLOSE ALL
RELEASE ALL
RESTORE SCREEN FROM sTela_agd1
RETURN

* EOP CEINCAG.PRG