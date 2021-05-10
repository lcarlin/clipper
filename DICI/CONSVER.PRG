***************************************************
cont="S"
ARQ=.T.
save screen to tela_1
use verbos index indice3
status()
sombra(05,16,22,74,.t.)
@ 05,20 say "Consulta De Verbos"
do while .t.
      @ 05,20 say "Consulta De Verbos"
      mveii  = space(20)
      mvepi  = space(20)
      mveip  = space(20)
      mveit  = space(20)
      mveig  = space(20)
      mveie  = space(20)
      mtipo  = space(15)
      if mo
         @ 07,17 say "Verbo Em Ingles No Infinitivo...:" get mveii picture "@!"
         @ 09,17 say "Verbo Em Portugues No Infinitivo:"+space(23)
	 use verbos index indice3
	 campocve="mveii"
      else
         @ 07,17 say "Verbo Em Ingles No Infinitivo...:" + space(23)
	 @ 09,17 say "Verbo Em Portugues No Infinitivo:" get mveip picture "@!"
	 use verbos index indice4
	 campocve="mveip"
      endif
      @ 11,17 say "Verbo Em Ingles No Presente.....:"+space(23)
      @ 13,17 say "Verbo Em Ingles No Passado......:"+space(23)
      @ 15,17 say "Verbo Em Ingles No Participio...:"+space(23)
      @ 17,17 say "Verbo Em Ingles No Gerundio.....:"+space(23)
      @ 19,17 say "Tipo De Verbo...................:"+space(18)
      @ 21,17 say "Digite <ENTER> P/ Sair"
      read
      @ 21,17 say "                      "
      if empty(&campocve)
         exit
      endif
      seek &campocve
      status()
      if .not. found()
         @ 21,17 say "Nao Encontrei!!!"
         inkey(1.9)
         @ 21,17 say "                "
         loop
      else
         mveii  = veii
         mvepi  = vepi
         mveip  = veip
         mveit  = veit
         mveig  = veig
         mveie  = veie
         mtipo  = tipo
         @ 07,17 say "Verbo Em Ingles No Infinitivo...:" get mveii picture "@!"
         @ 09,17 say "Verbo Em Portugues No Infinitivo:" get mveip
         @ 11,17 say "Verbo Em Ingles No Presente.....:" get mveie
         @ 13,17 say "Verbo Em Ingles No Passado......:" get mvepi
         @ 15,17 say "Verbo Em Ingles No Participio...:" get mveit
         @ 17,17 say "Verbo Em Ingles No Gerundio.....:" get mveig
         @ 19,17 say "Tipo De Verbo...................:" get mtipo
         clear gets
         inkey(0)
         loop
     endif
enddo
close all
ARQ=.F.
restore screen from tela_1

