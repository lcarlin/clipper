******************************************************
*                                                    *
* PROGRAMA: RTOTAL.PRG                               *
* FINALIDADE: MENU TOTAL MENSAL - SISTEMA LOCADORA   *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 15/06/92                                     *
*                                                    *
******************************************************

save screen to TELALI 
@ 06,02 clear to 21,78
@ 08,13 say 'T O T A L   M E N S A L   D E   E M P R E S T I M O S'
MENSA = '<Esc> - Retorna ao menu anterior'
MOSTRA(MENSA)
OPCAO=1
do while .t.
   @ 11,34 prompt 'MES CORRENTE'
   @ 13,34 prompt 'MES ANTERIOR'
   menu to OPCAO
   do case
      case OPCAO=1 
           do ATUAL
      case OPCAO=2
           do ANTERIOR 
      case OPCAO=0 .or. OPCAO>2
           exit
   endcase         
enddo
restore screen from TELALI
OPCAO = 4
return
