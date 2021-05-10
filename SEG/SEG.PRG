*************************
*
*************************
set color to w+/n,x
cod=space(4)
@ 22,30 say "digite a cod: " get  cod valid Senha(cod,"xyzk")
read
set color to 
return
Function Senha
parameters vsenha, vchave
if vsenha<> vchave
   set color to w+*/n
   @ 24,32 say "Senha Invalida, Pressione Uma tecla..."
   set color to w+/n,x
   inkey(0)
   @24,00 clear
   return .f.
endif
return .t.