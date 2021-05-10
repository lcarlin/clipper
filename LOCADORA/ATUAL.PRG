******************************************************
*                                                    *
* PROGRAMA: ATUAL.PRG                                *
* FINALIDADE: TOTAL MENSAL DE EMPRESTIMOS - LOCADORA *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 17/06/92                                     *
*                                                    *
******************************************************

set date brit
save screen to TELAT
@ 07,02 clear to 19,78
select 3
set order to 1
goto top
@ 08,13 say 'T O T A L   M E N S A L   D E   E M P R E S T I M O S'
@ 15,23 say 'VERIFIQUE SE A IMPRESSORA ESTA ATIVA'
do CONFIRMA()
if lastkey() = 27
   restore screen from TELAT
   return
endif   
if MCONF = 'N'
   do FINALIZA
else
   @ 19,23 say ' A G U A R D E   I M P R E S S A O '
   set device to print
   PAG = 0
   do while .NOT. eof()
      do CABECALHO()
      @ 08,13 say 'T O T A L   M E N S A L   D E   E M P R E S T I M O S'
      @ prow()+3,26 say 'NOME                     QUANT'
      LINHA=0
      @ prow()+1,1 say " "
      do while .NOT. eof() .AND. LINHA <= 50
         @ prow()+1,26     say NOMEF
         @ prow(),pcol()+5 say QUANT
         LINHA = LINHA + 1   
         skip
      enddo
   eject
   enddo
endif
restore screen from TELAT
set device to screen
set color to
return
