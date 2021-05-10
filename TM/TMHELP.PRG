
*************************************************
* HELP On Line
procedure HELP
PARAMETERS PROG,LIN,VAR
save screen to tela_hlp
cor_hlp=setcolor()
prog=lower(prog)
sombra(11,07,13,36,.f.)
set color to r*/w
@ 12,08 say "Aguarde! Pesquisando Ajuda."
set color to &cor_hlp

prg=substr(prog,1,2)
if prg<>"tm"
   var_hlp=memoread("tmhelp.hlp")
   var="# "+prog+" "+lower(var)
else        
   var="# "+prog+" "+lower(var)
   arquivo=prog+".hlp"
   if .not. file(arquivo)
       sombra(11,15,13,50,.f.)
       @ 12,16 say "Ajuda Nao esta Disponivel"
       inkey(8)
       restore screen from tela_hlp
       return
    endif
    var_hlp=memoread(arquivo)
endif
posicao = 0
acha = .t.
if .not. empty(var_hlp)
    do while acha
       posicao = posicao +1
       if memoline(var_hlp,39,posicao) = var
          acha = .f.
       endif
    enddo
    if posicao=mlcount(Var_hlp,39)
       return
    endif
    posicao=posicao+1
    socorro = " "
    do while substr(memoline(var_hlp,39,posicao),1,5) <>"# fim"
       socorro = socorro+memoline(var_hlp,39,posicao)
       posicao=posicao+1
    enddo
endif
sombra(10,03,20,44,.t.)
@ 10,16 say " Ajuda "
@ 20,10 say "<ESC> - Retorna"
set key 28 to
set color to w/n
ajuda=memoedit(socorro,11,04,19,43,.f.,"fmemo",39)
set color to &cor_hlp
restore screen from tela_hlp
set key 28 to help
RETURN

* eop tmhelp.prg