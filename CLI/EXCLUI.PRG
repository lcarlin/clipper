*********************************************************************
* bop exclui.prg
* programa   : exclui.prg
* autor      : Luiz
* data       : 31/03/94
* objetivo   : exclusao de clientes
* sistema    : contabil
**************************************************************
do while .t.
   tela ("Exclus„o de Clientes")
   variaveis(1)
   @ 22,15 say '<ENTER> Para a tabela ou'
   do while empty(mcod)
      @ 04,20 get mcod picture "99999"
      read
      if lastkey()=27
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
   seek mcod
   if .not. found()
      @ 23,15 say "C¢digo n„o cadastrado ; Pressione algo para continuar....."
      inkey(0)
   else
      variaveis(2)
      @ 06,20 get mnome picture "@!"
      @ 08,20 get mend  picture "@!"
      @ 10,20 get mcid  picture "@!"
      @ 12,20 get mest  picture "@!"
      @ 14,20 get mcp   picture "99999-999"
      @ 16,20 get mtel  picture "999-999-9999"
      clear gets
      obser(.f.)
      conf=" "
      @ 23,15 say "Excluir <S/N>?" get conf picture "!"
      read
      if conf="S"
         dele
         pack
      else
         loop
      endif
   endif
enddo

* eop inclui.prg