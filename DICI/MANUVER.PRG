*************************************************
cont="S"
ARQ=.T.
save screen to tela_1
use verbos index indice3
do while cont<> "N"
   status()
   use verbos index indice3
   conf="S"
   alter="V"
   sim="S"
   sombra(05,16,22,74,.t.)
   @ 05,20 SAY "Inclusao, Alteracao, Exclusao De Verbos"
   mveii  = space(20)
   mvepi  = space(20)
   mveip  = space(20)
   mveit  = space(20)
   mveig  = space(20)
   mveie  = space(20)
   mtipo  = space(15)
   @ 07,17 say "Verbo Em Ingles No Infinitivo...:" get mveii picture "@!"
   @ 09,17 say "Verbo Em Portugues No Infinitivo:"+space(23)
   @ 11,17 say "Verbo Em Ingles No Presente.....:"+space(23)
   @ 13,17 say "Verbo Em Ingles No Passado......:"+space(23)
   @ 15,17 say "Verbo Em Ingles No Participio...:"+space(23)
   @ 17,17 say "Verbo Em Ingles No Gerundio.....:"+space(23)
   @ 19,17 say "Tipo De Verbo...................:"+space(18)
   @ 21,17 say "Digite <ENTER> P/ Sair"
   read
   @ 21,17 say "                      "
   if empty(mveii)
      exit
   endif
   use verbos index indice3
   seek mveii
   status()
   if eof()
      @ 21,17 say "Verbo Novo; Cadastra <S/N> ?" get conf pict "!"
      read
      @ 21,17 say "                                        "
      if conf="N"
         loop
      endif
      @ 09,17 say "Verbo Em Portugues No Infinitivo:" get mvepi picture "@!"
      @ 11,17 say "Verbo Em Ingles No Presente.....:" get mveie picture "@!"
      @ 13,17 say "Verbo Em Ingles No Passado......:" get mveip picture "@!"
      @ 15,17 say "Verbo Em Ingles No Participio...:" get mveit picture "@!"
      @ 17,17 say "Verbo Em Ingles No Gerundio.....:" get mveig picture "@!"
      @ 19,17 say "Tipo De Verbo...................:" get mtipo picture "@!"
      read
      @ 21,17 say "Esta Correto <S/N> ? " get sim pict "@!"
      read
      @ 21,17 say "                               "
      do while sim="N"
         @ 09,17 say "Verbo Em Portugues No Infinitivo:" get mvepi picture "@!"
         @ 11,17 say "Verbo Em Ingles No Presente.....:" get mveie picture "@!"
         @ 13,17 say "Verbo Em Ingles No Passado......:" get mveip picture "@!"
         @ 15,17 say "Verbo Em Ingles No Participio...:" get mveit picture "@!"
         @ 17,17 say "Verbo Em Ingles No Gerundio.....:" get mveig picture "@!"
         @ 19,17 say "Tipo De Verbo...................:" get mtipo picture "@!"
          read
          @ 21,17 say "Esta Correto <S/N> ? " get sim pict "@!"
          read
          @ 21,17 say "                              "
      enddo
      if sim<>"N"
         append blank
         replace veii with  mveii
         replace vepi with  mveip
         replace veip with  mvepi
         replace veit with  mveit
         replace veig with  mveig
         replace veie with  mveie
         replace tipo with  mtipo
         @ 21,17 say "Continua <S/N> ? " get cont Picture "!"
         read
         @ 21,17 say "                        "
      endif
   else
      mvepi  = veip
      mveip  = vepi
      mveit  = veit
      mveig  = veig
      mveie  = veie
      mtipo  = tipo
      @ 09,17 say "Verbo Em Portugues No Infinitivo:" get mvepi picture "@!"
      @ 11,17 say "Verbo Em Ingles No Presente.....:" get mveie picture "@!"
      @ 13,17 say "Verbo Em Ingles No Passado......:" get mveip picture "@!"
      @ 15,17 say "Verbo Em Ingles No Participio...:" get mveit picture "@!"
      @ 17,17 say "Verbo Em Ingles No Gerundio.....:" get mveig picture "@!"
      @ 19,17 say "Tipo De Verbo...................:" get mtipo picture "@!"
      clear gets
      @ 21,17 say "<A>ltera ; <E>xclui ; <V>olta" get alter pict "!"
      read
      @ 21,17 SAY "                                          "
      if alter <> "A" .and. alter<> "E"
         loop
      elseif alter = "E"
         @ 21,17 SAY "Tem Certeza <S/N> " get sim picture "!"
         read
         @ 21,17 say "                           "
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
            @ 09,17 say "Verbo Em Portugues No Infinitivo:" get mvepi picture "@!"
            @ 11,17 say "Verbo Em Ingles No Presente.....:" get mveie picture "@!"
            @ 13,17 say "Verbo Em Ingles No Passado......:" get mveip picture "@!"
            @ 15,17 say "Verbo Em Ingles No Participio...:" get mveit picture "@!"
            @ 17,17 say "Verbo Em Ingles No Gerundio.....:" get mveig picture "@!"
            @ 19,17 say "Tipo De Verbo...................:" get mtipo picture "@!"
            read
            @ 21,17 say "Esta Correto <S/N> ? " get sim pict "@!"
             read
             @ 21,17 say "                              "
         enddo
         replace vepi with  mveip
         replace veip with  mvepi
         replace veit with  mveit
         replace veig with  mveig
         replace veie with  mveie
         replace tipo with  mtipo
         @ 21,17 say "Continua <S/N> ? " get cont Picture "!"
         read
         @ 21,17 say "                        "
      endif
   endif
enddo
ARQ=.F.
close all
restore screen from tela_1

