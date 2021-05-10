/*
bop capagto.prg

Programa capagto.prg
autor    Luiz antonio carlin
data     08/07/95
funcao   recebimento de dividas
sistema  Controle dew acougues
linguagem cliipper 5.01
*/

PUBLIC  aVet_campo, aVet_masc


SELE 1
USE cabagen INDEX caiagen

SELE 2
USE cabcli INDEX caicli, CAICLI2

SELE 3
USE CABLANCA

aVet_campo := {"data_pg","tipo_car","qtd_car","valor"}
aVet_masc   := {"99/99/99","@!","9999.999","999,999.99"}
aVet_cab    := {"Data","Tipo de carne","Kilos","Valor Total"}
sombra(06,07,11,77)
@ 06,15 SAY "Recebimento de Dividas"
@ 07,08 SAY "Codigo do Cliente.:"
@ 08,08 SAY "Nome..............:"
@ 09,08 SAY "Total da divida...:"
@ 10,08 SAY "Valor Pago........:"
CONF := .T.
SAVE SCREEN TO sTelaPrin
cor := setcolor()
DO WHILE CONF
   setcolor(cor)
   RESTORE SCREEN FROM sTelaPrin
   cCodigo := space(6)
   cNOme   := space(40)
   nValot_r:= 0
   nValorP := 0
   @ 07,28 GET cCodigo PICT "@!"
   READ
   SELE 2
   IF empty(cCodigo) .and. lastkey()=13
      nProc := tabela()
      SET ORDER TO 2
      IF empty(nProc)
        LOOP
      ENDIF
      cCodigo = Codigo
      @ 7,28 GET cCodigo PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCodigo) .and. lastkey()=27
      exit
   ENDIF
   setcolor(cor)
   SET ORDER TO 1
   SEEK cCodigo
   IF .NOT. FOUND()
      mensagem("Clienete Nao cadastrado.")
      LOOP
   ENDIF
   cNome := Nome
   @ 08,28 get cNome
   clear gets
   SELE 1
   SET FILTER TO CODIGO = cCodigo .AND. TIPO = "V"
   GO TOP
   IF eof()
      mensagem("O cliente nao esta devendo !!")
      LOOP
   ENDIF
   SUM  valor to  nValor_t for Codigo = cCodigo
   go top
   @ 09,28 get nValor_t pict "9,999,999.99"
   clear gets
   SAVE SCREEN TO sTela1
   set color to
   sombra(10,03,22,77)
   @ 21,10 say "Valor Total:"
   @ 21,col()+2 say nValor_t pict "9,999,999.99"
   setcolor(cor)
   @ 22,05 say "<ESC> - Volta para realizar o pagamento; <ENTER> Edita;"
   dbedit(11,04,20,76,aVet_campo,"consulta",aVet_masc,aVet_cab,"Ä","³")
   aVetOpc := array(3,3)
   aVetOpc := {{13,20,"Pagamento Parcial"},{13,39,"Pagamento Integral"},{13,59,"Cancelar"}}
   sombra(11,19,15,69)
   @ 12,20 SAY "Tipos de Pagamento:"
   nOpcao := botao(aVetOpc)
   setcolor(cor)
   IF nOpcao = 0 .OR. nOpcao = 3
      LOOP
   ENDIF
   RESTORE SCREEN FROM sTela1
   IF CONFIRMA("Deseja realizar o "+aVetOpc[nOpcao][3]+" desta conta ?")
      IF nOpcao = 1
         @ 10,28 GET nValorP PICTURE "9,999,999.99" VALID(nValorp<=nValor_t)
         READ
         DELETE  FOR CODIGO = CCODIGO
         APPEND BLANK
         nSub := nValor_t-nValorp
         REPLACE CODIGO    WITH cCodigo
         REPLACE NOME_FOR  WITH cNome
         REPLACE VALOR     WITH nSub
         REPLACE DATA_PG   WITH DATA_SIS
         REPLACE TIPO_CAR  WITH "Restante de Divida"
         REPLACE TIPO      WITH "V"
         SELE 3
         APPEND BLANK
         REPLACE Descricao WITH "Recebimento parcial (cliente) "+cCodigo
         REPLACE Valor     with nValorp
         REPLACE Data      WITH data_sis
         REPLACE TIPO      WITH "C"
      ELSEIF nOpcao = 2
         DELETE  FOR CODIGO = CCODIGO
         SELE 3
         APPEND BLANK
         REPLACE Descricao WITH "Recebimento de divida do cliente "+cCodigo
         REPLACE Valor     with nValor_t
         REPLACE Data      WITH data_sis
         REPLACE TIPO      WITH "C"
      ENDIF
   ENDIF
   conf:= confirma("Deseja continuar ?")
ENDDO
CLOSE ALL
RELEASE ALL
RETURN

* eop capgto.prg