/*
bop CAincag.prg
PROGRAMA CAINCAG.PRG
AUTOR    LUIZ ANTONIO CARLIN
DATA     07/07/95
FUNCAO   INCLUSAO DE AGENDA DE PAGAMENTO
SISTEMA  CONTROLE DE ACOUGUES
LINGUAGEM  CLIPPER 5.01
*/

IF pcount() = 1
   PARAMETERS nValor
   FECHA := .f.
ELSE
   nValor := 0
   FECHA := .T.
ENDIF
SAVE SCREEN TO sTela_agd1

SELE 5
USE CABCLI INDEX CAICLI

SELE 6
USE CABAGEN INDEX CAIAGEN

FIM := .T.
somBRa(07,07,13,69)
@ 08,08 SAY "Codigo............:"
@ 09,08 SAY "Nome do Cliente...:"
@ 10,08 SAY "Tipo de Carne.....:"
@ 11,08 SAY "Valor.............:"
@ 12,08 SAY "Data do Pagamento.:"

SAVE SCREEN TO sTela_agd
CORCLI := SETCOLOR()
DO WHILE FIM
   SELE 5
   restore screen from sTela_agd
   cTipo    := space(40)
   cCodigo  := space(6)
   dData    := ctod("  /  /  ")
   nValor   := if(FECHA,0,nValor)
   @ 08,28 GET cCodigo PICT "@!"
   READ
   IF empty(cCodigo) .and. lastkey()=13
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCodigo = Codigo
      @ 8,28 GET cCodigo PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCodigo) .and. lastkey()=27
      exit
   ENDIF
   set color to &corcli
   seek cCodigo
   IF .NOT. found()
      mensagem("Cliente nao cadastrado")
      LOOP
   ENDIF
   cNome := NOME
   @ 09,28 GET cNome
   CLEAR GETS
   @ 10,28 GET cTipo  PICT "@!"
   @ 11,28 GET nValor PICT "999,999.99"
   @ 12,28 GET dData  PICT "99/99/99" valid(dia_util(dData))
   READ
   INKEY(5)
   IF confirma("Os dados estao corretos ?")
      SELE 6
      APPEND BLANK
      REPLACE Codigo   WITH cCodigo
      REPLACE Nome_for WITH cNome
      REPLACE Valor    WITH nValor
      REPLACE Data_pg  WITH dData
      REPLACE tipo_car WITH cTipo
      REPLACE TIPO     WITH "V"
   ENDIF
   FIM := confirma("Deseja Continuar na Agenda de Pagamentos?")
ENDDO
IF FECHA
   CLOSE CABCLI
   CLOSE CABAGEN
ENDIF
RELEASE ALL
RESTORE SCREEN FROM sTela_agd1
RETURN

* EOP CEINCAG.PRG