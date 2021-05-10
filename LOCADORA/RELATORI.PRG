
******************************************************
*                                                    *
* PROGRAMA: RELATORIOS.PRG                           *
* FINALIDADE: MENU RELATORIOS - SISTEMA LOCADORA     *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 15/06/92                                     *
*                                                    *
******************************************************

set console off
save screen to TELAMENU 
@ 06,02 clear to 21,78
@ 07,30 say 'R E L A T O R I O S'
MENSA = '<Esc> - Retorna ao menu principal'
MOSTRA(MENSA)
OPCAO=1
do while .t.
   @ 11,30 prompt 'RELACAO DE CLIENTES'
   @ 13,30 prompt 'RELACAO DE FILMES'
   @ 15,30 prompt 'FILMES ALUGADOS'
   @ 17,30 prompt 'TOTAL MENSAL DE EMPRESTIMOS'
   @ 19,30 prompt 'ETIQUETAS CLIENTES'
   menu to OPCAO
   do case
      case OPCAO=1 
           do RCLIENTES
      case OPCAO=2
           do RFILMES 
      case OPCAO=3
           do RALUGAD
      case OPCAO=4 
           do RTOTAL
      case OPCAO=5 
           do ETIQUETA
      case OPCAO=0 .or. OPCAO>4
           exit
   endcase         
enddo
restore screen from TELAMENU
OPCAO = 5
return

procedure FINALIZA
restore screen from TELALI
set device to screen
set color to
return
