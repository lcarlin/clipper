******************************************************
*                                                    *
* PROGRAMA: FILMES.PRG                               *
* FINALIDADE: MENU FILMES - SISTEMA LOCADORA         *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 13/05/92                                     *
*                                                    *
******************************************************

sele 1
@ 06,02 clear to 21,78
@ 07,23 say 'C A D A S T R O   D E   F I L M E S'
MENSA = '<Esc> - Retorna ao menu principal'
MOSTRA(MENSA)
OPCAO=1
@ 10,29 to 18,49 
do while .t.
   @ 11,30 prompt 'INCLUSAO DE FILMES'
   @ 13,30 prompt 'ALTERACAO DE FILMES'
   @ 15,30 prompt 'EXCLUSAO DE FILMES'
   @ 17,30 prompt 'CONSULTA DE FILMES'
   menu to OPCAO
   save screen to TELAFIL
   do case
      case OPCAO=1 
           do INCFIL
      case OPCAO=2
           do ALTFIL 
      case OPCAO=3
           do EXCFIL
      case OPCAO=4
           do CONFIL
      case OPCAO=0 .or. OPCAO>4
         exit
      endcase         
enddo
restore screen from TELAMENU
OPCAO = 2
return
