******************************************************
*                                                    *
* PROGRAMA: EXCFIL.PRG                               *
* FINALIDADE: EXCLUSAO DE FILMES - SISTEMA LOCADORA  *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 27/05/92                                     *
*                                                    *
******************************************************

set delete on
do TFILMES
@ 07,23 say 'E X C L U S A O   D E   F I L M E S'
save screen to TELAEXC
do while .t.
   @ 10,37 clear to 16,50
   store 0 to MCODFIL
   MENSA = '<Esc> - Retorna ao cadastro de filmes'
   MOSTRA(MENSA)
   set color to w/n,w/n+
   @ 09,37 get MCODFIL  pict "99999" valid MCODFIL > 0
   read
   if lastkey()=27
      pack
      exit
   endif   
   seek MCODFIL
   if .not. eof()
      set color to w/n+,w/n+ 
      @ 10,37 say NOMEFIL 
      @ 11,37 say GENERO  
      @ 12,37 say DATAQUI 
      @ 13,37 say QUALIF  
      CONFIRMA()
      if lastkey()=27
         restore screen from TELAEXC
         loop
      endif   
      if MCONF = "S"    
         delete 
      else 
         MENSA = 'Dados nao excluidos. Tecle algo para continuar.'
         MENSAGEM(MENSA)
         loop
      endif      
   else 
      MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
   endif   
   restore screen from TELAEXC
enddo
set color to 
restore screen from TELAFIL
OPCAO = 3
return
