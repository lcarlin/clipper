******************************************************
*                                                    *
* PROGRAMA: CONFIL.PRG                               *
* FINALIDADE: MENU CONSULTA FILMES - LOCADORA        *
* AUTOR: CLAUDIO                                     *
* DATA: 08/07/92                                     *
*                                                    *
******************************************************

MENSA = '<Esc> - Retorna ao menu de opcoes'
MOSTRA(MENSA)

OPCAO=1
@ 16,45,19,56 box Q3
do while .t.
   @ 17,46 prompt 'INDIVIDUAL'
   @ 18,46 prompt 'GERAL'
   menu to OPCAO
   save screen to TELACON
   do case
      case OPCAO=1
           do INDIV
      case OPCAO=2
           do GERAL
      case OPCAO=0 .or. OPCAO>2
           exit
   endcase
enddo  
OPCAO = 4                     
restore screen from TELAFIL
return
