function _MAKECODE(Arg1)

   local Local1, Local2, Local3
   Arg1:= alltrim(Arg1)
   Local1:= Len(Arg1)
   for Local2:= 1 to Local1
      Local3:= Asc(SubStr(Arg1, Local2, 1)) - (Local1 + Local2)
      Local3:= iif(Local3 < 0, 256 + Local3, Local3)
      Arg1:= stuff(Arg1, Local2, 1, Chr(Local3))
   next
   USE SCCPAS
   REPLACE PASS_NOM WITH "LUIZ"
   REPLACE PASS_COD WITH arg1
   REPLACE PASS_NIV WITH "99999"
   @ ROW(),COL() SAY arg1
   RETURn .t.