***************************************************
cont="S"
save screen to tela_1
ARQ=.T.
use palavras
sombra(05,16,18,74,.t.)
@ 05,20 say "Consulta De Palavras"
do while .t.
   status()
   use palavras index indice1
   @ 05,20 say "Consulta De Palavras"
   mpling=space(30)
   mplpor=space(30)
   mplingp=space(30)
   mplporp=space(30)
   moutros=space(30)
   if mo
      campocpl="mpling"
      use palavras index indice1
      @ 07,17 say "Palavra Em Ingles......:" get mpling picture "@!"
      @ 09,17 say "Palavra Em Portugues...:"+ space(33)
   else
      campocpl="mplpor"
      use palavras index indice2
      @ 07,17 say "Palavra Em Ingles......:"+ space(33)
      @ 09,17 say "Palavra Em Portugues...:" get mplpor picture "@!"
   endif
   @ 11,17 say "Em Ingles No Plural....:"+space(33)
   @ 13,17 say "Em Portugues No Plural.:"+space(33)
   @ 15,17 say "Outros Sigificados.....:"+space(33)
   @ 17,17 say "Digite <ENTER> P/ Sair"
   read
   @ 17,17 say "                      "
   if empty(&campocpl)
      exit
   endif
   seek &campocpl
   status()
   if .not. found()
      @ 17,17 say "Nao Encontrei!!!"
      inkey(1.9)
      @ 17,17 say "                "
      loop
   else
      mpling=pling
      mplpor=plpor
      mplingp=plingp
      mplporp=plporp
      moutros=outros
      @ 07,17 say "Palavra Em Ingles......:" get mpling pict "@!"
      @ 09,17 say "Palavra Em Portugues...:" get mplpor pict "@!"
      @ 11,17 say "Em Ingles No Plural....:" get mplingp picture "@!"
      @ 13,17 say "Em Portugues No Plural.:" get mplporp picture "@!"
      @ 15,17 say "Outros Significados....:" get moutros picture "@!"
      clear gets
      inkey(0)
      loop
   endif
enddo
close all
ARQ=.F.
restore screen from tela_1

