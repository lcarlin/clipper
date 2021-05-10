SELECT 1
 USE MATERIAL INDEX INX1
SELECT 2
 USE ESCOLA INDEX INX2
SELECT 3
 USE MOVIME INDEX INX3
CLEAR
CONT="S"
REZA="S"
MQUANT=0
DO WHILE UPPER(CONT)="S"
   STORE SPACE(8) TO MCODESCO
   STORE SPACE(15) TO MCODMAT
   @ 0,0,24,79 BOX CHR(127)+CHR(176)+chr(127)+CHR(176)+CHR(127)+CHR(176)+CHR(127)+CHR(176)
   SET COLOR TO N/W
   centra(00,"MOVIMENTACOES (BAIXAS)")
   SET COLOR TO W/N
   @ 02,02 SAY "CODIGO DA ESCOLA...:"
   @ 04,02 SAY "ESCOLA.............:"+SPACE(37)
   @ 06,02 SAY "CODIGO DO MATERIAL.:"+SPACE(17)
   @ 08,02 SAY "MATERIAL...........:"+SPACE(52)
   @ 10,02 SAY "VALOR UNITARIO.....:"+SPACE(18)
   @ 12,02 SAY "QUANTIDADE.........:"+SPACE(18)
   @ 14,02 SAY "DATA DA ENTREGA....:"+SPACE(09)
   @ 16,02 SAY "NOTA DE ENTREGA N§.:"+SPACE(15)
   @ 18,02 SAY "TOTAL..............:"+SPACE(18)
   centra(23,"Digite o codigo da escola , <ENTER> p/ a tabela ou <ESC> p/ sair")
   select 2
   do while empty(mcodesco)
      @ 02,23 get mcodesco picture "@!"
      READ
      if lastkey()=27
         CLOSE ALL
         RETURN
      elseif lastkey()=13 .and. empty(mcodesco)
         tabela(2)
      endif
   enddo
   @ 22,02 clear to 23,78
   @ 02,23 get mcodesco pict "@!"
   clear gets
   SEEK MCODESCO
   IF .NOT. FOUND()
      centra(23,"Codigo n„o existente; tecle <ENTER>")
      INKEY(0)
      @ 22,02 clear to 23,78
      LOOP
   ELSE
      @ 04,23 GET ESCOLA
      CLEAR GETS
      MESCOLA=ESCOLA
      REZA="N"
      DO WHILE UPPER(REZA)="N"
         MCODMAT=SPACE(15)
         SELECT 1
         centra(23,"Digite o codigo do material, <ENTER> p/ a tabela ou <ESC> p/ sair")
         @ 08,02 SAY "MATERIAL...........:"+SPACE(52)
         @ 10,02 SAY "VALOR UNITARIO.....:"+SPACE(16)
         @ 12,02 SAY "QUANTIDADE.........:"+SPACE(18)
         @ 14,02 SAY "DATA DA ENTREGA....:"+SPACE(10)
         @ 16,02 SAY "NOTA DE ENTREGA N§.:"+SPACE(15)
         @ 18,02 SAY "TOTAL..............:"+SPACE(18)
	 do while empty(mcodmat)
            @ 06,23 GET MCODMAT  PICTURE "@!"
            READ
	    if lastkey()= 27
               CLOSE DATABASES
               CLEAR
               RETURN
	    elseif lastkey()=13 .and. empty(mcodmat)
	       tabela(1)
            ENDIF
	 enddo
         @ 22,02 clear to 23,78
	 @ 06,23 get mcodmat picture "@!"
	 clear gets
         SEEK MCODMAT
         IF .NOT. FOUND()
            centra(23,"Codigo n„o existente; tecle <ENTER>")
            INKEY (0)
            @ 22,02 clear to 23,78
            LOOP
         ENDIF
         @ 08,23 GET MATERIAL
         @ 10,23 GET VALUNIT PICT "999999,999.99"
         MQTDESAIDA=QTDESAIDA
         MQTAUX=QTDESAIDA
         MVALUNIT=VALUNIT
         MMATERIAL=MATERIAL
         CLEAR GETS
         SELECT 3
         MQTDENDTR= 0
         MDATA    = CTOD("  /  /  ")
         MNTDOC   = SPACE(12)
         @ 12,23 GET MQTDENDTR PICTURE "99999"
         @ 14,23 GET MDATA PICTURE "99/99/99"
         @ 16,23 GET MNTDOC PICTURE "@!"
         READ
         IF MQTDENDTR>MQTDESAIDA
            centra(23,"O estoque e de apenas "+ STR(MQTDESAIDA,5)+ " Tecle <ENTER>")
            READ
            INKEY(0)
            @ 22,02 clear to 23,78
            LOOP
         ENDIF
         MVALENTR=MQTDENDTR*MVALUNIT
         @ 18,23 GET MVALENTR PICT "999999,999.99"
         CLEAR GETS
         @ 23,15 SAY "Os dados estao corretos <S/N>?" GET REZA PICTURE "!"
         READ
         @ 23,15 SAY "                                                    "
         IF UPPER(REZA)="N"
            @ 08,02 SAY "MATERIAL...........:"+SPACE(52)
            @ 10,02 SAY "VALOR UNITARIO.....:"+SPACE(18)
            @ 12,02 SAY "QUANTIDADE.........:"+SPACE(18)
            @ 14,02 SAY "DATA DA ENTREGA....:"+SPACE(10)
            @ 16,02 SAY "NOTA DE ENTREGA N§.:"+SPACE(15)
            @ 18,02 SAY "TOTAL..............:"+SPACE(18)
             LOOP
         ENDIF
         SELECT 1
         MVALSAL    = VALSAL
         MQTDESAIDA = MQTAUX-MQTDENDTR
         MVALSAL    = MVALSAL-MVALENTR
         REPLACE QTDESAIDA WITH MQTDESAIDA
         REPLACE VALSAL    WITH MVALSAL
         SELECT 3
         APPEND BLANK
         REPLACE CODESCO   WITH  MCODESCO
         REPLACE ESCOLA    WITH  MESCOLA
         REPLACE CODMAT    WITH  MCODMAT
         REPLACE MATERIAL  WITH  MMATERIAL
         REPLACE QTDENDTR  WITH  MQTDENDTR
         REPLACE NTDOC     WITH  MNTDOC
         REPLACE VALENTR   WITH  MVALENTR
         REPLACE DATA      WITH  MDATA
         REPLACE VALSAL2   WITH  MVALSAL
         REPLACE QTDSAL    WITH  MQTDESAIDA
         @ 23,15 SAY "Deseja mais moventacoes <S/N>?" GET CONT PICTURE "!"
         READ
         @ 23,15 SAY "                                            "
     ENDDO
  ENDIF
ENDDO
CLOSE DATABASE
CLEAR
RETURN
