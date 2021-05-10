*******************
*
*
*******************
USE FDADUPLI
INDEX ON BCODDUPL+BNDUPL TO ARQDUPL
DO WHILE .T.
   DO TELA
   @ 4,42 SAY "INCLUSAO DE DUPLICATAS"
   @ 4,42 SAY REPLI("-",22)
   COD = SPACE(4)
   @ 5,32 SAY "CODIGO..............:" GET COD PICT "@!"
   READ
   IF LASTKEY() = 27
      DO FDMDUPL
   ENDIF
   NDUPL = SPACE(9)
   @ 7,32 SAY "NUMERO DA DUPLICATA.:" GET NDUPL PICT "@!"
   READ
   IF LASTKEY() = 27
      DO FDMDUPL
   ENDIF
   LOCATE FOR COD=BCODDUPL .AND. NDUPL=BNDUPL
   IF ! EOF()
      @ 22,43 SAY "DUPLICATA JA CADASTRADA"
      @ 23,43 SAY "     TECLE <ENTER>     "
      WAIT ""
      DO LIMPA
   ELSE
      NOME = SPACE(30)
      VAL = 0
      DTVENC = CTOD("  /  /  ")
      @ 9,32 SAY  "NOME DO FORNECEDOR....:" GET NOME PICT "@!"
      READ
      IF LASTKEY() = 27
         DO FDMDUPL
      ENDIF
