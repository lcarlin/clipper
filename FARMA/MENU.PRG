*********************************************
*programa: menu.prg
*autores:Audrey,Wilson,Rodrigo
*comentarios:menu para controle de produtos
*********************************************

clear
use codaut index codin
tetra = 0
declare vet[3]
vet[1] = "INCLUSAO"
vet[2] = "CONSULTA"
vet[3] = "THE END "
do while .t.
   do telain
   set color to n/w,w/n
   @ 09,04 clear to 13,68
   @ 09,04 to 13,68
   op = achoice(10,35,12,44,vet,.t.)
   set color to w/n
   do case
      case op = 1
           do prog4
      case op = 2
           do prog5
      case op = 3
           exit
    endcase
enddo