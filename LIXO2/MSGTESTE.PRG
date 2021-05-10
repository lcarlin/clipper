/*
  BOP MSGTESTE.PRG
  TESTE DA CLASSE DE MENSAGEMS
  MS 137 PG 34,35,36
*/
#include "MSGCLASS.CH"
SET PROCEDURE TO MSGCLASS
CLS
OBJECT PUBLIC MODULO
modulo:=msgnew(10,10)
.modulo:block := {|x| padc(x,80)}
.modulo:MSGdisplay(" Modulo Master ")
inkey(0)
mod1()
inkey(0)
mod2()
inkey(0)
.modulo:msgrecall()

return

************
function mod1
.modulo:msgdisplay(" MODULO 1 ")
INKEY(0)
MOD11()
INKEY(0)
.modulo:msgrecall()
return nil

***************
function mod11
.modulo:msgdisplay(" MODULO 1.1 ")
inkey(0)
.MODULO:MSGRECALL()
RETURN NIL

********************
FUNCTION MOD2
.MODULO:MSGDISPLAY(" MODULO 2 ")
INKEY(0)
.MODULO:MSGRECALL()
RETURN NIL

