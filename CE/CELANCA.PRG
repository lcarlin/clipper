#include "common.ch"
#include "inkey.ch"

********************************

   local Local1
   parameters tipo_l
   aopcoes_c:= array(3, 3)
   aopcoes_c:= {{14, 25, "Debito"}, {14, 33, "Credito"}, {14, 42, ;
      "Cancelar"}}
   if (tipo_l = 1)
      cmostra1:= "Lancamento Diarios do Caixa"
      use ceblanca
   else
      cmostra1:= "Controle de Custos de Operacoes"
      use cebcus index ceicus
   endif
   sombra(7, 7, 16, 66)
   @  7, 25 say cmostra1
   @  8,  8 say "Lan‡amento....:"
   @ 10,  8 say "Valor.........:"
   @ 12,  8 say "Data..........:"
   @ 14,  8 say "Tipo..........:"
   botao(aopcoes_c,.F.)
   conf:= .T.
   save screen to stela1
   corcli:= SetColor()
   do while (conf)
      restore screen from stela1
      set color to "&corcli"
      cdesc:= Space(40)
      nvalor:= 0
      ntipo:= 0
      ctipo:= " "
      @  8, 24 get cDesc picture "@!" valid cdesc != " "
      @ 10, 24 get nValor picture "999,999.99" valid nvalor != 0
      read
      if (LastKey() == K_ESC)
         exit
      endif
      @ 12, 24 get DATA_SIS
      clear gets
      ntipo:= botao(aopcoes_c)
      if (ntipo == 3)
         loop
      endif
      ctipo:= iif(ntipo = 1, "D", "C")
      if ;
            (confirma("Os Dados referentes ao lancamento estao corretos?"))
         append blank
         replace descricao with cdesc
         replace valor with nvalor
         replace tipo with ctipo
         replace data with data_sis
      endif
      conf:= confirma("Deseja Continuar  ?")
   enddo
   close databases
   select 1
   close format
   release all
   return

* EOF
