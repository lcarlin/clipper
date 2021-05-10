********************************************************************
* bop inclui.prg
* programa  : inclui.prg
* autor     : Luiz
* data      : 31/03/94
* objetivo  : inclusao de clientes
* sistema   : contabilidade
********************************************************************
do while .t.
   tela ("Inclus„o de clientes")
   variaveis(1)
   do while empty(mcod)
      @ 04,20 get mcod picture "99999"
      read
      if lastkey()=27
         return
      endif
   enddo
   @ 23,10 say space(50)
   seek mcod
   if .not. found()
       @ 06,20 get MNOME picture "@!" valid MNOME <> SPACE(30)
       READ
       @ 08,20 get MEND picture "@!" VALID MEND <> SPACE(45)
       read
       @ 10,20 get MCID picture "@!" VALID MCID <> SPACE(20)
       READ
       @ 12,20 get MEST picture "@!" valid (mest$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
       READ
       @ 14,20 get MCP picture  "99999-999" VALID MCP <> 0
       READ
       @ 16,20 get mtel picture "9999-999-9999" VALID MTEL <> 0
       read
       if lastkey()=27
	  return
       endif
       obser (.t.)
       confirma=" "
       @ 23,10 say "Os dados estao corretos <S/N> ? " get confirma picture "!" valid (confirma$"SN")
       read
       @ 23,10 say "                                             "
       if confirma="N"
          loop
       endif
       append blank
       replace bcod  with mcod
       replace bnome with mnome
       replace bend  with mend
       replace best  with mest
       replace bcid  with mcid
       replace bcp   with mcp
       replace btel  with mtel
       replace bobs  with mobs
    else
       @ 23,10 say "Codigo exixtente Pressione algo...."
       inkey(0)
    endif
enddo     	
* eop   inclui.prg