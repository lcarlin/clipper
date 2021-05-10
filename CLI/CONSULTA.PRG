**********************************************************************
* bop consulta.prg
* programa  : consulta.prg
* autor     : luiz A. carlin
* objetivo  : consulta de clientes
* sistema   : contabil
* data 06/04/94
************************************************************************
@ 17,19 clear to 19,67
@ 17,19 to 19,67
cidade=space(20)
@ 18,20 say "Cidade Para a Consulta ->" get cidade picture "@!"
read
if empty(cidade)
   return
endif
close all
use clientes
set filter to bcid=cidade
goto top
do while .t.
   tela ("Consulta De Clientes")
   variaveis(1)
   @ 22,15 say '<ENTER> Para a tabela ou'
   do while empty(mcod)
      @ 04,20 get mcod picture "99999"
      read
      if lastkey()=27
	 use clientes index ind_cli
         return
      elseif lastkey()=13 .and. empty(mcod)
         tabela()
         set color to n/w
         @ 04,20 say mcod picture "99999"
         set color to
	 exit
      endif
   enddo
   @ 22,15 say space(40)
   @ 23,10 say space(50)
   locate for bcod=mcod
   if found()
      variaveis(2)
      @ 06,20 get mnome picture "@!"
      @ 08,20 get mend picture "@!"
      @ 10,20 get mcid picture "@!"
      @ 12,20 get mest picture "@!"
      @ 14,20 get mcp  picture "99999-999"
      @ 16,20 get mtel picture "9999-999-9999"
      @ 23,10 say "Pressione algo para continuar..."
      clear gets
      obser(.f.)
      inkey(0)
   else
      @ 23,10 say "C¢digo N„o cadastrado "+"Pressione algo..."
      inkey(0)
   endif
enddo

* eop consulta.prg
