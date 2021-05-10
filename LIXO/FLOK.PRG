#include "common.ch"
#include "inkey.ch"

********************************
procedure FLOK

   local Local1
   Local1:= 5
   lretval:= .F.
   do while (.T.)
      if (FLock())
         lretval:= .T.
         return
      endif
      if (Local1 > 0)
         InKey(1)
         Local1--
         loop
      elseif (lockwin(procname(), alias))
         Local1:= 5
         loop
      else
         return
      endif
   enddo

* EOF
