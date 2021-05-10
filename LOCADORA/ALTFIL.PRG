******************************************************
*                                                    *
* PROGRAMA: ALTFIL.PRG                               *
* FINALIDADE: ALTERACAO DE FILMES - SISTEMA LOCADORA *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 27/05/92                                     *
*                                                    *
******************************************************

do TFILMES
@ 07,24 say 'A L T E R A C A O   D E   F I L M E S'
save screen to TELAALT  
do while .t.
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
   if .not. eof()
      MENSA = '<Esc> - Cancela operacao'
      MOSTRA(MENSA)
      set color to w/n,w/n+
      MNOMEFIL = NOMEFIL
      MGENERO  = GENERO
      MDATAQUI = DATAQUI
      MQUALIF  = QUALIF
      @ 10,37 get MNOMEFIL pict "@!" valid MNOMEFIL <> space(1)
      @ 11,37 get MGENERO  pict "@!" valid MGENERO $("RTCEADS")
      @ 12,37 get MDATAQUI pict "@E" valid MDATAQUI <> ctod ("  /  /  ") 
      @ 13,37 get MQUALIF  pict "@!" valid MQUALIF $("PRBO")  
      read
      if lastkey()=27
         restore screen from TELAALT
         loop
      endif    
      CONFIRMA()
      if lastkey()=27
         restore screen from TELAALT
         loop
      endif    
      if MCONF = "S"    
         replace NOMEFIL with MNOMEFIL,GENERO with MGENERO;
                 DATAQUI with MDATAQUI,QUALIF with MQUALIF
      endif     
   else 
      MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
      loop
   endif    
   restore screen from TELAALT
enddo
set color to
restore screen from TELAFIL
OPCAO = 2
return

