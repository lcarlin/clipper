*programa : Prog4.prg
*autores  : Wilson, Rodrigo e Audrey
*coment   : programa de inclusao com codigo automatico

use codaut index codin
do while .t.
   do telain
   set color to w+/n,n/w
   go bottom
   codauto = substr(str(val(codigo) + 10001,5),2,4)
   @3,15 say "Codigo do Produto =>" get codauto
   clear gets
   vdes = space(30)
   quan = 0
   prec = 0
   dcom = ctod('  /  /  ')
   dven = ctod('  /  /  ')
   @4,15 say "Descricao.....=>" get vdes pict '@!'
   @5,15 say "Quantidade....=>" get quan pict '999'
   @6,15 say "Preco.........=>" get prec pict '@E 999,999.99'
   @7,15 say "Data Compra...=>" get dcom pict '99/99/99'
   @8,15 say "Data Vencimeto=>" get dven pict '99/99/99'
   read
   conf = ' '
   set color to w/b
   @23,15 say "Os Dados Estao Corretos <S/N> ?" get conf pict "!" valid conf $ "SN"
   read
   if conf = "S"
      append blank
      replace codigo with codauto
      replace desc   with vdes
      replace quant  with quan
      replace preco  with prec
      replace datacom with dcom
      replace dataven with dven
   else
      @23,15 say "         Operacao Cancelada                "
      wait ""
   endif
   cont = ' '
   @23,15 say space(40)
   @23,15 say "Deseja Continuar <S/N> ?" get cont pict "!" valid cont $ "SN"
   read
   if cont = "N"
      set color to w/n
      exit
   endif
enddo
?
?
?
return

******
proc telain
******
set color to w/g
@0,0 clear to 0,79
@23,0 clear to 23,79
@0,20 say "Sistema de Controle de Produtos"
@23,0 say "Mensagem=>"
set color to w+/n
@1,0,22,79 box "같같같같�"
@1,0 to 22,79
set color to w/n
