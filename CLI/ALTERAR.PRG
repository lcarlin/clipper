***********************************************************************
* bop alterar.prg
* programa   : alterar.prg
* autor      : Luiz
* data       : 31/03/94
* objetivo   : alteracao de clientes
* sistema    : contabil
************************************************************************
do while .t.
   tela ("Altera‡„o de Clientes")
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
      @ 12,20 get MEST  picture "@!" valid (mest$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
      @ 14,20 get mcp   picture "99999-999"
      @ 16,20 get mtel  picture "9999-999-9999"
      clear gets
      obser(.f.)
      conf=" "
      tel_2=savescreen(23,13,24,79)
      @ 23,15 say "Deseja alterar os dados <S/N>?" get conf picture "!"
      read
      restscreen(23,13,24,79,tel_2)
      if conf="S"
         alter="N"
      else
         alter="S"
      endif
      do while alter<>"S"
         MOBS=MOBS2
         @ 06,20 get mnome picture "@!"
         @ 08,20 get mend  picture "@!"
         @ 10,20 get mcid  picture "@!"
         @ 12,20 get MEST  picture "@!" valid (mest$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP")
         @ 14,20 get mcp   picture "99999-999"
         @ 16,20 get mtel  picture "9999-999-9999"
         read
         obser(.t.,.T.,.t.)
	 MOBS2=MOBS
         @ 23,15 say "Os dados Est„o corretos <S/N>? " get alter picture "!"
         read
	 @ 23,15 say "                                                "
      enddo
      replace bcod   with mcod
      replace bnome  with mnome
      replace bend   with mend
      replace best   with mest
      replace bcid   with mcid
      replace bcp    with mcp
      replace btel   with mtel
      replace BOBS   with mobs
   endif
enddo

* eop alterar.prg