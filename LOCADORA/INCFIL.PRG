******************************************************
*                                                    *
* PROGRAMA: INCFIL.PRG                               *
* FINALIDADE: INCLUSAO DE FILMES - SISTEMA LOCADORA  *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 13/05/92                                     *
*                                                    *
******************************************************

do TFILMES
@ 07,23 say 'I N C L U S A O   D E   F I L M E S'
save screen to TELAINC
do while .t.
   MENSA = '<Esc> - Retorna ao cadastro de filmes'
   MOSTRA(MENSA)
   MNOMEFIL = space(20)
   MGENERO  = space(01)
   MDATAQUI = ctod ("  /  /  ")
   MQUALIF  = space(1)
   store 0 to MCODFIL
   set color to w/n,w/n+
   @ 09,37 get MCODFIL  pict "99999" valid MCODFIL > 0
   read
   if lastkey()=27
      exit
   endif   
   seek MCODFIL
   if eof()
      MENSA = '<Esc> - Cancela operacao'
      MOSTRA(MENSA)
      set color to w/n,w/n+
      @ 10,37 get MNOMEFIL pict "@!" valid MNOMEFIL <> space(1)
      @ 11,37 get MGENERO  pict "@!" valid MGENERO $("RTCEADS")
      @ 12,37 get MDATAQUI pict "@e" valid MDATAQUI <> ctod ("  /  /  ")    
      @ 13,37 get MQUALIF  pict "@!" valid MQUALIF $("PRBO")  
      read
      if lastkey()=27
         restore screen from TELAINC
         loop
      endif   
      CONFIRMA()
      if lastkey()=27
         restore screen from TELAINC
         loop
      endif   
      if MCONF = "S"    
        append blank
        replace CODFIL with MCODFIL,NOMEFIL with MNOMEFIL,GENERO with MGENERO;
                DATAQUI with MDATAQUI,QUALIF with MQUALIF,ALUGAD with 'NAO' 
      endif     
   else 
      MENSA = 'Codigo ja cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
   endif   
   restore screen from TELAINC
enddo
set color to
restore screen from TELAFIL
OPCAO = 1
return
