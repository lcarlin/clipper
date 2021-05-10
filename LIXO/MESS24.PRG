#include "common.ch"
#include "inkey.ch"

********************************
function MESS24(Arg1)

   local Local1
   if (iscolor())
      Local1:= SetColor("B/W")
   endif
   default Arg1 to " "
   @ 24,  1 say padr(Arg1, 78)
   if (iscolor())
      set color to (Local1)
   endif
   return Nil

* EOF
