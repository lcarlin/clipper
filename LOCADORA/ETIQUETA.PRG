
******************************************************
*                                                    *
* PROGRAMA: ETIQUETA.PRG                             *
* FINALIDADE: ETIQUETAS CLIENTES - SISTEMA LOCADORA  *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 18/06/92                                     *
*                                                    *
******************************************************

set console off
save screen to TELALI   
@ 06,02 clear to 21,78
@ 08,23 say 'E T I Q U E T A S   C L I E N T E S'
@ 15,23 say 'VERIFIQUE SE A IMPRESSORA ESTA ATIVA'
set color to w/n,w/n
CONFIRMA()
if lastkey() = 27
   restore screen from TELALI
   return
endif   
if MCONF = 'N'
   do finaliza
else
   do while .T.
      MCONT = ' '
      set device to print
      for cont=0 to 4
         @ prow()+1,00 say replicate ('*',35)
         @ prow(),36 say replicate ('*',35)
      next
      @ prow()+1,79 say ' ' 
      set device to screen
      @ 23,00 clear
      set color to w/n+,w/n+
      @ 23,29 say 'Mais exemplos? (S/N) 'get MCONT pict '@!';
        valid MCONT $ ('S/N')
      read
      if MCONT = 'S'
         loop
      endif   
      @ 19,23 say ' A G U A R D E   I M P R E S S A O '
      set device to print 
      sele 2
      label form etiqcli to print
      set device to screen
      exit
   enddo
endif
set color to
restore screen from TELALI
OPCAO = 5
return
