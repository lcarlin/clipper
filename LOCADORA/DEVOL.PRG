********************************************************
*                                                      *
* PROGRAMA: DEVOL.PRG                                  *
* FINALIDADE: DEVOLUCAO DE FILMES - SISTEMA LOCADORA   *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                       *
* DATA: 17/05/92                                       *
*                                                      *
********************************************************

save screen to TELAFIL 
@ 06,02 clear to 21,78
@ 07,22 say 'D E V O L U C A O   D E   F I L M E S'
@ 12,08 say "Codigo do filme ...........: " 
@ 13,08 say "Nome do filme .............: "
@ 14,08 say "Data de emprestimo ........: "
@ 15,08 say "Cliente ...................: "
MENSA = '<Esc> - Retorna ao menu principal'
MOSTRA(MENSA)
save screen to TELADEV
store 0 to MCODCLI  
do while .t.
   store 0 to MCODFIL 
   set color to w/n,w/n+ 
   @ 12,38 get MCODFIL  pict "99999" valid MCODFIL > 0
   read
   if lastkey()=27
      exit
   endif   
   sele 1
   seek MCODFIL
   if found()  
      set color to w/n+,w/n
      @ 13,38 say NOMEFIL 
      if ALUGAD = 'SIM'
         @ 14,38 say DATARET
         MCODCLI = CODCLI
         sele 2
         seek MCODCLI
         @ 15,38 say NOMECLI         
         sele 1
         CONFIRMA()
         if lastkey()=27
            restore screen from TELADEV
            loop
         endif            
         if MCONF = 'S'
            replace ALUGAD with 'NAO',DATADEV with DATE() 
         endif   
         restore screen from TELADEV
         loop
      else           
         MENSA = 'Filme nao se encontra alugado. Tecle algo para continuar.'
         MENSAGEM(MENSA)
         @ 13,38 say space(20)
      endif      
   else
      MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
      loop
   endif
enddo
set color to
restore screen from TELAFIL
OPCAO = 4
return
