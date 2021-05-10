******************************************************
*                                                    *
* PROGRAMA: RFILMES.PRG                              *
* FINALIDADE: LISTAGEM DE FILMES - SISTEMA LOCADORA  *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 15/06/92                                     *
*                                                    *
******************************************************

set date brit
save screen to TELALI
@ 06,02 clear to 21,78
select 1
goto top
@ 08,23 say 'L I S T A G E M   D E   F I L M E S'
@ 15,23 say 'VERIFIQUE SE A IMPRESSORA ESTA ATIVA'
CONFIRMA()
if lastkey() = 27
   restore screen from TELALI
   return
endif   
if MCONF = 'N'
   do finaliza
else
   @ 19,23 say ' A G U A R D E   I M P R E S S A O '
   set device to print
   PAG = 0
   do while .NOT. eof()
      CABECALHO()
      @ 08,24 say 'R E L A C A O   D E   F I L M E S'   
      @ prow()+3,01 say '  CODIGO   NOME'
      @ prow(),33 say ' GENERO   AQUISICAO   QUALIF'
      LINHA=0
      @ prow()+1,1 say " "
      do while .NOT. eof() .AND. LINHA <=50
         LINHA = LINHA + 1
         @ prow()+1,04 say CODFIL
         @ prow(),pcol()+3 say NOMEFIL
         @ prow(),pcol()+5 say GENERO
         @ prow(),pcol()+6 say DATAQUI
         @ prow(),pcol()+5 say QUALIF
         skip
      enddo
   eject
   enddo
endif
do FINALIZA

          
          