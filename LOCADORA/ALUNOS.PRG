* Programa = alunos.prg
* Data     = 06/05/92

clear
select 1
use alunos

@ 2,3 say 'calculo da media final'
@ 2,30 say date() pict '@e'

do while .t.
   MVAR1=space(10)
   MVAR2=space(10)
   MNOME=space(30) 
   store 0 to MN1,MN2,MN3,MN4,MM
   @ 5,15 say 'Nome do Aluno: 'get MNOME pict '@!'
   @ 6,15 say 'Primeiro Bimestre: 'get MN1 pict '99.9'
   @ 7,15 say 'Segundo Bimestre: 'get MN2 pict '99.9'
   @ 8,15 say 'Terceiro Bimestre: 'get MN3 pict '99.9'
   @ 9,15 say 'Quarto Bimestre: 'get MN4 pict '99.9'
   read
   if lastkey ()=27
      exit
   endif
   
   MM=(1*MN1+2*MN2+3*MN3+4*MN4)/10
   if MM>=7
      MVAR1='APROVADO'
      do case
         case MM<8
           MVAR2='REGULAR'
         case MM<9
           MVAR2='BOM'
         case MM<=10
           MVAR2='OTIMO'
      endcase
    else
      VAR1='REPROVADO'
      VAR2='PESSIMO'
    endif
    @ 10,10 say 'VAR1: ' get MVAR1 pict '@!'
    
    @ 11,10 say 'VAR2: ' get MVAR2 pict '@!'
    wait
    append blank
    replace NOME with MNOME, N1 with MN1, N2 with MN2, N3 with MN3,;
    N4 with MN4, M with MM, VAR1 with MVAR1, VAR2 with MVAR2
        
    
  enddo
  return
  close
          	     	    	    
	     
	            
 
    