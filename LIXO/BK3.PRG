/* BOP BK3.PRG
DATA 16/06/95
*/
DO WHILE .T.
   MP2 := BK_MEM1+1
   @ 10,26 TO 13,34
   @ 11,27 PROMPT "Drive A"
   @ 12,27 PROMPT "Drive B"
   MENU TO MP2
   DO CASE
      CASE MP2 = 0
           @ 10,26 CLEAR TO 13,34
           EXIT
      CASE MP2 = 1
           BK_MEM1 :=0
           @ 06,67 SAY "A"
      CASE MP2 = 3
           BK_MEM1 := 1
           @ 06,67 SAY "B"
   ENDCASE
   @ 10,26 CLEAR TO 13,34
   EXIT
ENDDO
RETURN

* EOP BK3.PRG

