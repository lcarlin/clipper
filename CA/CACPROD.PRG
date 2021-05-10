/*
bop cacprod.prg
data     17/07/95
autor    Luiz Antonio Carlin
funcao   Compra de produtos
Sistema  Controle de Acougues
Linguagem Clipper 5.01
*/

IF .NOT. file("CACOMPRA.MEM")
   nNcompra := 0
ELSE
   RESTORE FROM CACOMPRA ADDITIVE
ENDIF

SELE 1
USE CABCEST

SELE 2
USE CABLANCA

SELE 3
USE CABAGEN INDEX CAIAGEN

lCOnt := .t.
SOMBRA(07,07,16,72)
@ 07,20 SAY "Compra de Mercadorias"
@ 08,08 SAY "Descricao............:"
@ 09,08 SAY "Procedencia..........:"
@ 10,08 SAY "Data da Compra.......:"
@ 11,08 SAY "Dias de Prazo........:"
@ 12,08 SAY "Data do Vencimento...:"
@ 13,08 SAY "Arrobas/Kilos........:"
@ 14,08 SAY "Valor da Arroba/Kilo.:"
@ 15,08 SAY "Valor Total..........:"
SAVE SCREEN TO sTela_com
cCor := Setcolor()
DO WHILE lCont
   RESTORE SCREEN FROM sTela_com
   setcolor(cCor)
   cDesc    := space(40)
   cProced  := space(40)
   dDataC   := data_sis
   nDiasPra := 0
   dDataVen := CtoD("  /  /  ")
   nArrobas := 0
   nVlArroba:= 0
   nVal_tot := 0
   @ 08,31 GET cDesc    PICTURE "@!"
   @ 09,31 GET cProced  PICTURE "@!"
   @ 10,31 GET dDatac   PICTURE "99/99/99" valid(dia_util(dDatac))
   @ 11,31 GET nDiasPra PICTURE "99"
   READ
   IF lastkey()=27
      EXIT
   ENDIF
   dDataVen := dDataC+nDiasPra
   @ 12,31 GET dDataVen PICTURE "99/99/99" valid(dia_util(dDataVen))
   @ 13,31 GET nArrobas PICTURE "9999.999"
   @ 14,31 GET nVlArroba PICTURE "9,999,999.99"
   READ
   nVal_tot := nVlArroba*nArrobas
   @ 15,31 SAY nVAL_Tot PICTURE "9,999,999.99"
   CLEAR GETS
   INKEY(7)
   IF confirma("Os Dados da Compra Estao Corretos")
      nNcompra++
      cNcompra := "C"+alltrim(str(nNcompra))
      SELE 1
      APPEND BLANK
      REPLACE DESCRICAO WITH cDesc
      REPLACE PROCEDENC WITH cProced
      REPLACE DATA_COM  WITH dDataC
      REPLACE DIAS_PRAZ WITH nDiasPra
      REPLACE DATA_VEN  WITH dDataVen
      REPLACE ARROBAS   WITH nArrobas
      REPLACE VAL_ARR   WITH nVlArroba
      REPLACE VAL_TOT   WITH nVal_tot      
      REPLACE NMOV      WITH cNCompra
      IF confirma("Pagamento da compra a vista?")
         SELE 2
         APPEND BLANK
         REPLACE DESCRICAO WITH "Compra de Produtos"
         REPLACE VALOR     WITH nVAl_Tot
         REPLACE DATA      WITH dATA_SIS
         REPLACE TIPO      WITH "D"
         REPLACE NMOV      WITH cNCompra
      ELSE
         SELE 3
         APPEND BLANK
         REPLACE CODIGO   WITH "COMPRA"
         REPLACE NOME_FOR WITH cProced
         REPLACE VALOR    WITH nVAl_tot
         REPLACE DATA_PG  WITH dDataVen
         REPLACE TIPO_CAR WITH cDesc
         REPLACE TIPO     WITH "C"
         REPLACE QTD_CAR  WITH nArrobas
         REPLACE NMOV     WITH cNCompra
      ENDIF
   ENDIF
   lConT := confirma("Deseja continuar na Compra de Produtos?")
ENDDO
SAVE TO CACOMPRA ALL LIKE nNcompra
CLOSE ALL
RELEASE ALL
RETURN

* EOP CACPROD.PRG