*************************************
*programa:PROG5.PRG
*autores: Rodrigo,Wilson,Audrey
*comentarios: consulta de produtos
*************************************

use codaut index codin
reindex
do while .t.
   do telain
   set color to w/n,n/w
   aleat = space(04)
   @3,10 say "Entre com o codigo; ou <ENTER> p/ ver todos os produtos"
   @4,10 say "ou a primeira letra da descricao" get aleat pict "@!"
   read
   if lastkey() = 27
      set order to 1
      return
   endif
   if empty(aleat) .and. lastkey() = 13
      go top
      count to rec
      go top
      declare vetdat[rec]
      for i=1 to rec
          vetdat[i] = "  ³  "+desc
          skip
      next
      op = achoice(3,15,12,65,vetdat,.t.)
      if lastkey() = 27
         loop
      endif
      go op
      @5,15 say "Descricao.........=>" get desc
      @6,15 say "Quantidade........=>" get quant
      @7,15 say "Preco.............=>" get preco
      @8,15 say "Data da Compra....=>" get datacom
      @9,15 say "Data do Vencimento=>" get dataven
      clear gets
      wait ""
      set filter to
      loop
   endif
   if len(alltrim(aleat)) > 1
      set order to 1
      seek aleat
      if .not. found()
         set color to w/b
         @23,15 say "Codigo nao encontrado; tecle <ENTER>"
         wait ""
         loop
      endif
      @5,15 say "Descricao.........=>" get desc
      @6,15 say "Quantidade........=>" get quant
      @7,15 say "Preco.............=>" get preco
      @8,15 say "Data da Compra....=>" get datacom
      @9,15 say "Data do Vencimento=>" get dataven
      clear gets
      wait ""
   else
      aleat = alltrim(aleat)
      go top
      set filter to desc = aleat
      go top
      count to rec
      go top
      declare vetdad[rec]
      for i=1 to rec

          vetdad[i] = "  ³  "+desc
          skip
      next
      op = achoice(3,15,12,65,vetdad,.t.)
      if lastkey() = 27
         loop
      endif
      go op
      @5,15 say "Descricao.........=>" get desc
      @6,15 say "Quantidade........=>" get quant
      @7,15 say "Preco.............=>" get preco
      @8,15 say "Data da Compra....=>" get datacom
      @9,15 say "Data do Vencimento=>" get dataven
      clear gets
      wait ""
      set filter to
      loop
   endif
enddo
return
