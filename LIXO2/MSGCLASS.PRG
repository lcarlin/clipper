#include "msgclass.ch"
CONSTRUCTOR msgnew(l,c,cor,block)
local obj[5]
obj[1] := {}
obj[2] := if(COR==nil,setcolor(),cor)
obj[3] := if(valtype(block)="B",block,{|x|x})
obj[4] := l
obj[5] := c
return (obj)

METHOD msgdisplay CLASS oMSG MESSAGES cMSG
local dMSG, nstack
nstack = len( .oMSG:stack )
if nstack=0
   aadd(.omsg:stack, savescreen(.omsg:nrow,.omsg:ncol,.omsg:nrow,79))
endif
if cmsg=nil .and. nstack >1
   dmsg:=atail(.omsg:stack)
elseif cmsg == nil
   .omsg:msgclear()
elseif !cmsg==nil
   dmsg=eval(.omsg:block,cmsg)
   aadd(.omsg:stack,cmsg)
   .omsg:msgclear()
   @ .omsg:nrow, .omsg:ncol say dmsg color .omsg:color
endif
return

METHOD msgrecall CLASS omsg
local cmsg, dmsg, nstack
nstack := len(.omsg:stack)
if nstack > 2
   asize(.omsg:stack,nstack-1)
   cmsg:= atail(.omsg:stack)
   dmsg:= eval(.omsg:block,cmsg)
   .omsg:msgclear()
   @ .omsg:nrow, .omsg:ncol say dmsg color .omsg:color
else
   .omsg:msgclear()
   .omsg:stack := {}
endif
return

METHOD msgclear CLASS omsg
if len(.omsg:stack)=0
   return
else
   restscreen(.omsg:nrow,.omsg:ncol,.omsg:nrow,79,.omsg:stack[1])
endif
return
* EOP