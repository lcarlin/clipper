#include "common.ch"
#include "inkey.ch"

********************************
static function LOCKWIN(Arg1, Arg2)

   local Local1, Local2, Local3
   Local3:= .F.
   winshade(8, 15, 20, 65, "ON")
   do case
   case Arg1 == "UseFile"
      @ 10, 16 say padc("Data File: " + Arg2, 49)
      @ 12, 16 say padc("This file is unavailable at this time.", 49)
      @ 14, 16 say padc("Do you want to continue attempting", 49)
      @ 16, 16 say padc("to open it for another five seconds?", 49)
   case Arg1 == "APND"
      @ 10, 16 say padc("New record creation was unsuccessful.", 49)
      @ 12, 16 say padc("Do you want to continue attempting", 49)
      @ 14, 16 say padc("to add it for another five seconds?", 49)
      @ 16, 16 say padc("Data File: " + Arg2, 49)
   case Arg1 == "RLOK"
      @ 10, 16 say padc("Record locking was unsuccessful.", 49)
      @ 12, 16 say padc("Do you want to continue attempting", 49)
      @ 14, 16 say padc("to lock it for another five seconds?", 49)
      @ 16, 16 say padc("Data File: " + Arg2, 49)
   case Arg1 == "FLOK"
      @ 10, 16 say padc("File locking was unsuccessful.", 49)
      @ 12, 16 say padc("Do you want to continue attempting", 49)
      @ 14, 16 say padc("to lock it for another five seconds?", 49)
      @ 16, 16 say padc("Data File: " + Arg2, 49)
   endcase
   @ 18, 36 prompt "YES"
   @ 18, 42 prompt "NO"
   Local2:= Set(_SET_CURSOR, .F.)
   menu to Local1
   Set(_SET_CURSOR, Local2)
   if (Local1 == 1)
      Local3:= .T.
   endif
   winshade(8, 15, 20, 65, "OFF")
   return Local3

* EOF
