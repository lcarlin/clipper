#include "common.ch"
#include "inkey.ch"

********************************
function APND(Arg1)

   local Local1, Local2
   Local1:= 5
   Local2:= .F.
   default Arg1 to .T.
   do while (.T.)
      dbAppend(Arg1)
      if (!neterr())
         Local2:= .T.
         exit
      endif
      if (Local1 > 0)
         InKey(1)
         Local1--
         loop
      elseif (lockwin(procname(), alias()))
         Local1:= 5
         loop
      else
         exit
      endif
   enddo
   return Local2

* EOF
