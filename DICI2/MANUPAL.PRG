*************************************************
cont="S"
ARQ=.T.
save screen to tela_1
use palavras index indice1
do while cont<> "N"
   status()
   conf="S"
   alter="V"
   sim="S"
   sombra(05,16,18,74,.t.)
   @ 05,20 SAY "Inclusao, Alteracao, Exclusao De Palavras"
   mpling=space(30)
   mplpor=space(30)
   mplingp=space(30)
   mplporp=space(30)
   moutros=space(30)
   @ 07,17 say "Palavra Em Ingles......:" get mpling picture "@!"
   @ 09,17 say "Palavra Em Portugues...:"+space(33)
   @ 11,17 say "Em Ingles No Plural....:"+space(33)
   @ 13,17 say "Em Portugues No Plural.:"+space(33)
   @ 15,17 say "Outros Significados....:"+space(33)
   @ 17,17 say "Digite <ENTER> P/ Sair"
   read
   @ 17,17 say "                      "
   if empty(mpling)
      if reccount()>550
	 tela_apa=savescreen(22,00,24,79)
	 cor = setcolor()
	 set color to r*/b+
	 @ 23,25 say "Aguare... Organizando A Estrutura do Arquivo"
	 set color to &cor
	 num=reccount()
	 num2=num-550
	 goto 550
	 dele  next num2
	 pack
	 restscreen(22,00,24,79,tela_apa)
      endif
      status()
      exit
   endif
   use palavras index indice1
   seek mpling
   status()
   if eof()
      @ 17,17 say "Palavra Nova; Cadastra <S/N> ?" get conf pict "!"
      read
      @ 17,17 say "                                        "
      if conf="N"
	 loop
      endif                             .
      @ 09,17 say "Palavra Em Portugues...:" get mplpor pict "@!"
      @ 11,17 say "Em Ingles No Plural....:" get mplingp picture "@!"
      @ 13,17 say "Em Portugues No Plural.:" get mplporp picture "@!"
      @ 15,17 say "Outros Significados....:" get moutros picture "@!"
      read
      @ 17,17 say "Esta Correto <S/N> ? " get sim pict "@!"
      read
      @ 17,17 say "                               "
      do while sim="N"
	  @ 09,17 say "Palavra Em Portugues...:" get mplpor pict "@!"
	  @ 11,17 say "Em Ingles No Plural....:" get mplingp picture "@!"
	  @ 13,17 say "Em Portugues No Plural.:" get mplporp picture "@!"
	  @ 15,17 say "Outros Significados....:" get moutros picture "@!"
	  read
	  @ 17,17 say "Esta Correto <S/N> ? " get sim pict "@!"
	  read
	  @ 17,17 say "                              "
      enddo
      if sim<>"N"
	 append blank
	 replace pling  with mpling
	 replace plpor  with mplpor
	 replace plingp with mplingp
	 replace plporp with mplporp
	 replace outros with moutros
	 @ 17,17 say "Continua <S/N> ? " get cont Picture "!"
	 read
	 @ 17,17 say "                        "
      endif
   else
      mplpor=plpor
      mplingp=plingp
      mplporp=plporp
      moutros=outros
      @ 09,17 say "Palavra Em Portugues...:" get mplpor pict "@!"
      @ 11,17 say "Em Ingles No Plural....:" get mplingp picture "@!"
      @ 13,17 say "Em Portugues No Plural.:" get mplporp picture "@!"
      @ 15,17 say "Outros Significados....:" get moutros picture "@!"
      clear gets
      @ 17,17 say "<A>ltera ; <E>xclui ; <V>olta" get alter pict "!"
      read
      @ 17,17 SAY "                                          "
      if alter <> "A" .and. alter<> "E"
	 loop
      elseif alter = "E"
	 @ 17,17 SAY "Tem Certeza <S/N> " get sim picture "!"
	 read
	 @ 17,17 say "                           "
	 if sim<>"S"
	    loop
	 endif
	 delete
	 pack
	 loop
      endif
      if alter="A"
	 sim="N"
	 do while sim="N"
	     @ 09,17 say "Palavra Em Portugues...:" get mplpor pict "@!"
	     @ 11,17 say "Em Ingles No Plural....:" get mplingp picture "@!"
	     @ 13,17 say "Em Portugues No Plural.:" get mplporp picture "@!"
	     @ 15,17 say "Outros Significados....:" get Moutros picture "@!"
	     read
	     @ 17,17 say "Esta Correto <S/N> ? " get sim pict "@!"
	     read
	     @ 17,17 say "                              "
	 enddo
	 replace plpor  with mplpor
	 replace plingp with mplingp
	 replace plporp with mplporp
	 replace outros with moutros
	 @ 17,17 say "Continua <S/N> ? " get cont Picture "!"
	 read
	 @ 17,17 say "                        "
      endif
   endif
enddo
ARQ=.F.
close all
restore screen from tela_1

