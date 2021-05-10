***************************************************
cont="S"
save screen to tela_1
ARQ=.T.
sombra(05,16,12,74,.t.)
@ 05,20 say "Consulta De Expressoes"
USE EXPRESSO
do while .t.
   status()
   @ 05,20 say "Consulta De Expressoes"
   mexping=space(30)
   mexppor=space(30)
   if mo
      use expresso index indice5
      @ 07,17 say "Expressao Em Ingles....:" get mexping picture "@!"
      @ 09,17 say "Expressao Em Portugues.:"+ space(33)
      campocex="mexping"
      campoceb="exping"
   else
      use expresso index indice6
      @ 07,17 say "Expressao Em Ingles....:" + space(33)
      @ 09,17 say "Expressao Em Portugues.:" get mexppor picture "@!"
      campocex="mexppor"
      campoceb="exppor"
   endif
   @ 11,17 say "Digite <ENTER> P/ Sair"
   read
   @ 11,17 say "                      "
   &campocex=alltrim(&campocex)
   if empty(&campocex)
      exit
   endif
   locate for &campoceb=&campocex
*  seek campocex
   status()
   if .not. found()
      @ 11,17 say "Nao Encontrei!!!"
      inkey(1.9)
      @ 11,17 say "                "
   else
      mexppor=exppor
      mexping=exping
      @ 07,17 say "Expressao Em Ingles....:" get mexping picture "@!"
      @ 09,17 say "Expressao Em Portugues.:" get mexppor picture "@!"
      clear gets
      inkey(0)
   endif
enddo
ARQ=.F.
close all
restore screen from tela_1