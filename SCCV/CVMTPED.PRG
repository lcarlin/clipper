**********************************************
* bop cvmtpedd.prg
* programa ; cvmtped
* objetivo : inclusao de pedidos
* data     : 24/6/94
* autores  ; luiz, everton, wilson, oswaldo
****************************************************
parameters mcodite, mdescite
sele 1
use cvbpedid index cviped1
sele 2
tela(19)
mcodped = 0
mcodite = 0
mdesite = space(30)
mqtdite = 0
@ 08,30 get mcodped pict "99999"
read
if lastkey()=27
   return
endif
seek mcodped
if .not. found()
   @ 09,30 get mcodite pict "99999"
   @ 10,30 get mdesite pict "@!"
   clear gets
   @ 11,30 get mqtdite pict "99"
   read
   append blank
   replace codped with mcodped
   replace codite with mcodite
   replace desite with mdesite
   replace qtdite with mqtdite
   if isprinter()
      set device to printer
      set console off
      eject
      @ 00,00 say replicate("-",80)
      meio(01,"Pedidos")
      @ 02,01 say "Codigo do pedido"+str(mcodped,5,0)
      @ 03,01 say "Codigo do Item.."+str(mcodite,5,0)
      @ 04,01 say "Decricao........"+mdesite
      @ 05,01 say "Quantidade.....:"+str(mqtdite,3,0)
      @ 06,00 say replicate("-",80)
      for i = 1 to 5
          ?""
      next
      set device to screen
      set console on
else
   @ 20,20 say "Codigo ja existente"
   return
endif
return