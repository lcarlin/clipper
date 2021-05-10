/*
BOP CEMTMAT.PRG
PROGRAMA  : CEMTMAT.PRG
OBJETIVO  : INCLUSAO DE REGISTROS
SISTEMA   : CONTROLE DE ESTOQUE
DATA      : 10/07/94
*/
CT     := 0
VETCOD := {}
VETDES := {}
#INCLUDE "CEDEFI.CH"
//FIELD CODMAT, DESMAT, QTDMAT, QTDMIN, QTDSAL, VALUNI
//FIELD VALENT, VALSAL, NOTMAT, DATMAT, PROMAT, DESUNI

SELE 1
SOMBRA(04,04,22,78,.T.)
DO WHILE .T.
   @ 21,75 GET CT PICT "999"
   CLEAR GETS
   MCODMAT := SPACE(10)
   MDESMAT := SPACE(35)
   MNOTMAT := SPACE(10)
   MPROMAT := SPACE(10)
   MDATMAT := DATE()
   MDESUNI := SPACE(20)
   MQTDMAT := 0
   MQTDMIN := 0
   MQTDSAL := 0
   MVALUNI := 0
   MVALENT := 0
   MVALSAL := 0
   @ 05,06 SAY "Codigo............:"+space(13)
   @ 06,06 SAY "Descricao.........:"+space(38)
   @ 07,06 SAY "Nota..............:"+space(13)
   @ 08,06 SAY "Procedencia.......:"+space(23)
   @ 09,06 SAY "Data..............:"+space(13)
   @ 10,06 SAY "Unidade...........:"+space(23)
   @ 11,06 SAY "Quantidade........:"+space(8)
   @ 12,06 SAY "Quantidade Minima.:"+space(6)
   @ 13,06 SAY "Quantidade Saldo..:"+space(8)
   @ 14,06 SAY "Valor Unitario....:"+space(16)
   @ 15,06 SAY "Valor Total.......:"+space(16)
   @ 16,06 SAY "Valor Saldo.......:"+space(16)
   @ 05,27 GET MCODMAT PICT "@!"
   READ
   IF EMPTY(MCODMAT) .AND. ENTER
      TABELA()
   ELSEIF EMPTY(MCODMAT) .AND. ESC
      RETURN
   ELSEIF SH_TAB
      MCODMAT:=INDICE(CT,VETCOT,VETDES)
   ENDIF
   SEEK MCODMAT
   IF .NOT. FOUND()
      IF CONFIRMA(21,10,"Material Nao cadastrado, cadastra")
         @ 06,27 get MDESMAT pict "@!" valid (mdesmat<>" ")
         @ 07,27 get MNOTMAT pict "@!" valid (mnotmat<>" ")
         @ 08,27 get MPROMAT pict "@!" valid (mpromat<>" ")
         @ 09,27 get MDATMAT pict "99/99/99"
         @ 10,27 get MDESUNI pict "@!" valid (mdesuni<>" ")
         @ 11,27 get MQTDMAT pict "99999" valid(mqtdmat>0)
         @ 12,27 get MQTDMIN pict "999"   valid(mqtdmin>0)
         @ 14,27 get MVALUNI pict "999,999,999.99" valid(mvaluni>0)
         read
         if .not. confirma(21,10,"Os dados estao corretos")
            loop
         endif
         MVALENT := MQTDMAT*MVALUNI
         MQTDSAL := MQTDMAT
         MVALSAL := MVALENT
         @ 13,27 get MQTDSAL pict "99999" valid(mqtdsal>0)
         @ 15,27 get MVALENT pict "999,999,999.99" valid(mvalent>0)
         @ 16,27 get MVALSAL pict "999,999,999.99" valid(mvalsal>0)
         clear gets
         CT++
         VETCOD[CT] := MCODMAT
         VETDES[CT] := MDESMAT
      ENDIF
   ELSE
      CT++
      VETCOD[CT] := MCODMAT
      VETDES[CT] := MDESMAT
      @ 06,27 get DESMAT pict "@!" valid (mdesmat<>" ")
      @ 07,27 get NOTMAT pict "@!" valid (mnotmat<>" ")
      @ 08,27 get PROMAT pict "@!" valid (mpromat<>" ")
      @ 09,27 get DATMAT pict "99/99/99"
      @ 10,27 get DESUNI pict "@!" valid (mdesuni<>" ")
      @ 11,27 get QTDMAT pict "99999" valid(mqtdmat>0)
      @ 12,27 get QTDMIN pict "999"   valid(mqtdmin>0)
      @ 13,27 get QTDSAL pict "99999" valid(mqtdsal>0)
      @ 14,27 get VALUNI pict "999,999,999.99" valid(mvaluni>0)
      @ 15,27 get VALENT pict "999,999,999.99" valid(mvalent>0)
      @ 16,27 get VALSAL pict "999,999,999.99" valid(mvalsal>0)
      clear gets
      ALTER := " "
      @ 21,10 say "Material Cadastrado <A>ltera; <E>xclui; <R>etorna:" get ALTER pict "!"
      read
      IF ALTER="R"
         LOOP
      ELSEIF ALTER="E"
         IF confirma(21,10,"Confirma Exclusao")
            DELETE
         ENDIF
      ELSEIF ALTER = "A"
         do while .t.
            @ 06,27 get DESMAT pict "@!" valid (mdesmat<>" ")
            @ 07,27 get NOTMAT pict "@!" valid (mnotmat<>" ")
            @ 08,27 get PROMAT pict "@!" valid (mpromat<>" ")
            @ 09,27 get DATMAT pict "99/99/99"
            @ 10,27 get DESUNI pict "@!" valid (mdesuni<>" ")
            @ 11,27 get QTDMAT pict "99999" valid(mqtdmat>0)
            @ 12,27 get QTDMIN pict "999"   valid(mqtdmin>0)
            @ 14,27 get VALUNI pict "999,999,999.99" valid(mvaluni>0)
            read
            if confirma(21,10,"Os dados Estao corretos")
               exit
            endif
         enddo
         MVALENT := MQTDMAT*MVALUNI
         MQTDSAL := MQTDENT
         MVALSAL := MVALENT
         @ 13,27 get MQTDSAL pict "99999" valid(mqtdsal>0)
         @ 15,27 get MVALENT pict "999,999,999.99" valid(mvalent>0)
         @ 16,27 get MVALSAL pict "999,999,999.99" valid(mvalsal>0)
      ENDIF
   ENDIF
   replace codmat with mcodmat
   replace desmat with mdesmat
   Replace notmat with mnotmat
   replace promat with mpromat
   replace datmat with mdatmat
   replace desuni with mdesuni
   replace qtdmat with mqtdmat
   replace qtdmin with mqtdmin
   replace qtdsal with mqtdsal
   replace valuni with mvaluni
   replace valent with mvalent
   replace valsal with mvalsal
ENDDO

/*
EOP CEMTMAT.PRG
*/