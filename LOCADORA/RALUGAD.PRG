
******************************************************
*                                                    *
* PROGRAMA: RALUGAD.PRG                              *
* FINALIDADE: FILMES ALUGADOS SISTEMA LOCADORA       *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 17/06/92                                     *
*                                                    *
******************************************************

set date brit
save screen to TELALI
@ 07,02 clear to 19,78
select 1
goto top
@ 08,26 say 'F I L M E S   A L U G A D O S'
@ 15,23 say 'VERIFIQUE SE A IMPRESSORA ESTA ATIVA'
CONFIRMA()
if lastkey() = 27
   restore screen from TELALI
   return
endif   
if MCONF = 'N'
   do FINALIZA
else
   @ 19,23 say ' A G U A R D E   I M P R E S S A O '
   set device to print
   PAG = 0
   do while .NOT. eof()
      CABECALHO()
      @ 08,26 say 'F I L M E S   A L U G A D O S'
      @ prow()+3,01 say '  CODIGO   NOME'
      @ prow(),34 say 'GENERO    RETIRADA      CLIENTE'                     
      LINHA=0
      @ prow()+1,1 say " "
      do while .NOT. eof() .AND. LINHA <= 50
         if ALUGAD = 'SIM'
         @ prow()+1,04 say CODFIL
         @ prow(),pcol()+3 say NOMEFIL
         @ prow(),pcol()+5 say GENERO  
         @ prow(),pcol()+6 say DATARET
         @ prow(),pcol()+5 say CODCLI
      endif
      LINHA = LINHA + 1   
      skip
      enddo
   eject
   enddo
endif
do FINALIZA
