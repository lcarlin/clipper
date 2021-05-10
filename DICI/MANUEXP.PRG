*************************************************
cont="S"
save screen to tela_1
ARQ=.T.
use expresso index indice5
do while cont<> "N"
   status()
   conf="S"
   alter="V"
   sim="S"
   sombra(05,16,12,74,.t.)
   @ 05,20 SAY "Inclusao, Alteracao, Exclusao De Expressoes"
   mexping = space(30)
   mexppor = space(30)
   @ 07,17 say "Expressao Em Ingles....:" get mexping picture "@!"
   @ 09,17 say "Expressao Em Portugues.:"+space(33)
   @ 11,17 say "Digite <ENTER> P/ Sair"
   read
   @ 11,17 say "                      "
   if empty(mexping)
      exit
   endif
   use expresso index indice5
   seek mexping
   status()
   if eof()
      @ 11,17 say "Expressao Nova; Cadastra <S/N> ?" get conf pict "!"
      read
      @ 11,17 say "                                          "
      if conf="N"
         loop
      endif                             .
      @ 09,17 say "Expressao Em Portugues.:" get mexppor pict "@!"
      read
      @ 11,17 say "Esta Correto <S/N> ? " get sim pict "@!"
      read
      @ 11,17 say "                               "
      do while sim="N"
          @ 09,17 say "Expressao Em Portugues.:" get mexppor pict "@!"
          read
          @ 11,17 say "Esta Correto <S/N> ? " get sim pict "@!"
          read
          @ 11,17 say "                              "
      enddo
      if sim<>"N"
         append blank
         replace exping  with mexping
         replace exppor  with mexppor
         @ 11,17 say "Continua <S/N> ? " get cont Picture "!"
         read
         @ 11,17 say "                        "
      endif
   else
      mexppor = exppor
      @ 09,17 say "Expressao Em Portugues.:" get mexppor pict "@!"
      clear gets
      @ 11,17 say "<A>ltera ; <E>xclui ; <V>olta" get alter pict "!"
      read
      @ 11,17 SAY "                                          "
      if alter <> "A" .and. alter<> "E"
         loop
      elseif alter = "E"
         @ 11,17 SAY "Tem Certeza <S/N> " get sim picture "!"
         read
         @ 11,17 say "                           "
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
             @ 09,17 say "Expressao Em Portugues.:" get mexppor pict "@!"
             read
             @ 11,17 say "Esta Correto <S/N> ? " get sim pict "@!"
             read
             @ 11,17 say "                              "
         enddo
         replace exppor with mexppor
         reindex
         @ 11,17 say "Continua <S/N> ? " get cont Picture "!"
         read
         @ 11,17 say "                        "
      endif
   endif
enddo
ARQ=.F.
close all
restore screen from tela_1

