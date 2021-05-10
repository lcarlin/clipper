#include "common.ch"
#include "inkey.ch"

********************************
function USEFILE(Arg1, Arg2, Arg3)

   local Local1, Local2
   Local1:= 5
   Local2:= .F.
   do while (.T.)
      dbUseArea(.T., Arg3, Arg1, Nil, Arg2)
      if (!neterr())
         Local2:= .T.
         exit
      endif
      if (Local1 > 0)
         InKey(1)
         Local1--
         loop
      elseif (lockwin(procname(), Arg1))
         Local1:= 5
         loop
      else
         exit
      endif
   enddo
   return Local2

* EOF
