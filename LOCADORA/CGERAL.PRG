**********************************************************************
* Programa : CGERAL.PRG                                              *
* Objetivo : Consulta geral de clientes                              *
* Data : 12.07.92                                                    *
**********************************************************************
sele 2
X=reccount()
declare ARQ[X]
@ 06,02 clear to 21,78 
@ 7,21 say 'C O N S U L T A   D E   C L I E N T E S'
do while .t.
   MENSA='<Esc> - Retorna ao menu anterior'
   MOSTRA(MENSA)
   go top
   MCONT=1
   do while .not. eof()
      ARQ[MCONT]=str(CODCLI)+spac(2)+NOMECLI
      MCONT=MCONT+1
      skip
   enddo
   @ 09,02 clear to 20,78
   @ 09,20 to 20,60 
   @ 10,21 say 'Codigo  Nome'
   set color to bg+/n,n/bg+
   Y=achoice(11,22,19,58,ARQ)
   set color to
   if Y=0
      exit
   endif   
   @ 10,21 clear to 20,59
   MCODCLI=val(substr(ARQ[Y],1,5))
   go top
   seek MCODCLI
   OPCAO=0
   do CCODIGO with OPCAO
enddo   
restore screen from TMENU1
OPCAO = 3  
return
