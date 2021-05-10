#include "common.ch"
#include "inkey.ch"

********************************
function MAT

   local Local1
   if (iscolor())
      Local1:= SetColor("w/b,,w")
   endif
   @  0,  0, 24, 79 box "‹‹‹±Æ€Ø±±"
   @  1,  0 say Replicate("€", 80)
   @  2,  0 say Replicate("ﬂ", 80)
   set color to (Local1)
   @  1,  2 say padl(" ", 76)
   return Nil

* EOF
