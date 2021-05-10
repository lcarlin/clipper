*************************************************
* programa     : CVMTCON                        *
* autores      : WILSON, LUIZ, OSWALDO, EVERTON *
* coment       : GRUPO DE ESPERA DO CONSORCIO   *
*************************************************
parameters mcodcon, mnomcon
sele 1
use cvbgrupo index cvigru1
sele 2
use cvbfrota index cvifro1
sele 3
use cvbgrucon
sele 4
use cvbfunc index cvifun1
sele 5
use cvbgrupo index cvigru2
tela(12)
mcodcar=0
@ 08,30 get mcodcon
@ 09,30 get mnomcon
clear gets
sele 2
@ 10,30 get mcodcar pict "99999"
read
if empty(mcodcar) .and. lastkey()=13
   tabela()
   if empty(mcodcar) .and. lastkey()=27
      return
   endif
   @ 10,30 get mcodcar pict "99999"
   clear gets
endif
seek mcodcar
*locate for codcar=mcodcar
if eof() &&.not. found()
   mensagem("Carro n„o Cadastrado")
   return
endif
mcarmod = descar
mvalpre = valcar
sele 1
seek mcodcar
*locate for codcar = mcodcar
if .not. found()
   numpart = 0
   sele 5            
   @ 11,30 get numpart pict "999"
   read
   mnumpag = 0
   mgrufec = .f.
   maior = 0
   cod=codgru
   @ 4,2 say "Grupo"
   @ 4,10 say codgru
   delete for codgru = 0
   pack
   goto top
   numero=reccount()
   for i = 1 to numero       
       cod1=codgru
       skip
       cod2=codgru
       if cod2 > cod1
	   maior = cod2
       elseif cod1 < cod2
	   maior = cod1
       elseif cod2 = cod1
           maior = cod2
       endif
   next
   maior=maior+1
   append blank
   replace codcon with mcodcon
   replace nomcon with mnomcon
   replace codcar with mcodcar
   replace codgru with maior
   replace valpre with mvalpre
   replace numpag with mnumpag
*  replace numgru with mnumgru
   replace grufec with mgrufec
   replace numpar with numpart
   return
else
   mnumpar = numpar
   @ 4,2 say "Grupo"
   @ 4,10 say codgru
   @ 11,30 get mnumpar pict "999"
   clear gets
   mnumpag = 0
   mgrufec = .f.
   mcodgru = codgru
   count to tot_ban for codgru = mcodgru
   if tot_ban = numpar
      sele 3
      append from cvbgrupo for codgru = mcodgru
      do while codgru = mcodgru
         replace grufec with .t.
         skip
      enddo
      sele 1
      delete for codgru = mcodgru
      pack
   else
      append blank
      replace codcon with mcodcon
      replace nomcon with mnomcon
      replace codcar with mcodcar
*     replace codgru with mcodgru
      replace valpre with mvalpre
      replace numpag with mnumpag
      replace grufec with mgrufec
      replace numpar with mnumpar
      @ 6,2 say codgru
      wait ""
   endif
endif
sele 4
comiss=mvalpre*0.0015
mcodfun = 0
@ 12,30 get mcodfun pict "99999"
read
if empty(mcodfun) .and. lastkey()=13
   tabela()
   if empty(mcodfun) .and. lastkey()=27
      return
   endif
   @ 12,30 get mcodfun pict "99999"
   clear gets
endif
seek mcodfun
if .not. found()
   mensagem("Funcionario nao Cadastrado")
   return
endif
replace comfun with comfun+comiss
close all
return