#include "common.ch"
#include "inkey.ch"

********************************
function RLOK(Arg1)

   local Local1, Local2
   Local1:= 5
   Local2:= .F.
   do while (.T.)
      if (ISNIL(Arg1))
         if (dbrlock())
            Local2:= .T.
            exit
         endif
      elseif (dbrlock(Arg1))
         Local2:= .T.
         exit
      endif
      if (Local1 > 0)
         InKey(1)
         Local1--
         loop
      elseif (lockwin(procname(), alias))
         Local1:= 5
         loop
      else
         exit
      endif
   enddo
   return Local2

* EOF
