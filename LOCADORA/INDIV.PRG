******************************************************
*                                                    *
* PROGRAMA: INDIV.PRG                                *
* FINALIDADE: CONSULTA DE FILMES - SISTEMA LOCADORA  *
* AUTOR: CLAUDIO                                     *
* DATA: 08/07/92                                     *
*                                                    *
******************************************************

@ 06,02 clear to 21,78 
do TFILMES
@ 07,23 say 'C O N S U L T A   D E   F I L M E S'
save screen to TELAI
do while .t.
   if OPCAO <> 0
      MQUAL = space(7)
      store 0 to MCODFIL
      MENSA = '<Esc> - Retorna ao cadastro de filmes'
      MOSTRA(MENSA)
      set color to w/n,w/n+
      @ 09,37 get MCODFIL  pict "99999" valid MCODFIL > 0
      read
      if lastkey()=27
         exit
      endif   
      seek MCODFIL
   endif 
   if .not. eof()
      set color to w/n+,w/n+
      @ 10,38 say CODFIL
      @ 10,37 say NOMEFIL 
      do case
         case GENERO = 'R'
              MGEN   = 'Romance'
         case GENERO = 'T'
              MGEN   = 'Terror'
         case GENERO = 'C'
              MGEN   = 'Comedia'
         case GENERO = 'E'
              MGEN   = 'Erotico'
         case GENERO = 'A'
              MGEN   = 'Aventura'
         case GENERO = 'D'
              MGEN   = 'Drama'
         case GENERO = 'S'
              MGEN   = 'Suspense'
      endcase
      @ 11,37 say MGEN
      @ 12,37 say DATAQUI 
      do case
         case QUALIF = 'P'
              MQUAL  = 'Pessimo'
         case QUALIF = 'R'
              MQUAL  = 'Regular'
         case QUALIF = 'B'
              MQUAL  = 'Bom'
         case QUALIF = 'O'
              MQUAL  = 'Otimo'
      endcase 
      @ 13,37 say MQUAL  
      MENSA = 'Tecle algo para continuar a consulta.'
      MENSAGEM(MENSA)
   else 
      MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
   endif   
   restore screen from TELAI
   if OPCAO = 0
      exit
   endif   
enddo
set color to
restore screen from TELACON
OPCAO = 1
return
