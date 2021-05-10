MCODESCO=SPACE(08)
USE MOVIME INDEX INX3
DO WHILE .T.
   CLEAR
   @ 0,0,24,79 BOX "°°°°"
   USE MOVIME INDEX INX3
   MCODESCO=SPACE(08)
   SET COLOR TO N/W
   centra(0,"CONSULTA DE BAIXAS")
   centra(24,"<F4>-Consulta Geral")
   SET COLOR TO W/N
   MCODESCO=SPACE(08)
   @ 04,15 to 08,64 DOUBLE
   @ 11,09 clear to 17,40
   centra(05,"Entre c/ o Codigo da Escola, <ENTER> p/ a tabela")
   centra(06,"ou <ENTER> para sair :")
   do while empty(mcodesco)
      @ 07,35 GET MCODESCO PICTURE "@!"
      READ
      IF empty(MCODESCO) .and. lastkey()=27
         CLOSE DATABASES
         CLEAR
         RETURN
      elseif lastkey()=13 .and. empty(mcodesco)
         use escola index inx2
         tabela(2)
         @ 07,35 GET MCODESCO PICTURE "@!"
      ENDIF
   enddo
   USE MOVIME INDEX INX3
   GOTO TOP
   LOCATE FOR CODESCO=MCODESCO
   IF .NOT. FOUND()
      centra(09,"Escola n„o cadastrada")
      centra(10,"Ou sem movimentacoes; tecle <ENTER>")
      INKEY (0)
      @ 09,15 CLEAR TO 10,50
      LOOP
  ENDIF
  CLEAR
  @ 0,0,24,79 BOX "°°°°"
  SET COLOR TO N/W
  centra(00,"Consulta de baixas")
  SET COLOR TO W/N
  @ 01,01 TO 23,78 DOUBLE
  PAG=1
  LIN=4
  @ 03,03 SAY "PAG. "+STR(PAG,3,0)
  @ LIN+1,5 SAY "Escola : "+ESCOLA
  @ LIN+2,4 SAY "DATA    "+ "   MATERIAL"+SPACE(40)+"QTDE "
  TOTAL=0
  DO WHILE MCODESCO=CODESCO
     @ LIN + 3,04 SAY DATA
     @ LIN + 3,14 SAY MATERIAL
     @ LIN + 3,62 SAY QTDENDTR
     LIN=LIN+1
     CONTINUE
     DO WHILE LIN >= 20
        LIN=4
        centra(23,"Pressione algo p/ continuar")
        inkey (0)
        @ 07,04 clear to 22,75
        PAG=PAG+1
        @ 03,03 SAY "PAG. "+STR(PAG,3,0)
     ENDDO
  ENDDO
  @ LIN+5,04 SAY REPLICATE ("#",70)
  centra(lin+7,"Pressione algo p/ continuar")
  INKEY(0)
  clear
ENDDO
CLOSE ALL
CLEAR
