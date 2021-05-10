**********************************************************************
* Programa : GERAL.PRG                                               *
* Objetivo : Consulta geral de filmes                                *
* Data : 12.07.92                                                    *
**********************************************************************

X=reccount()
declare ARQ[X]
@ 06,02 clear to 21,78 
@ 7,23 say 'C O N S U L T A   D E   F I L M E S'
save screen to TELAG
do while .t.
   @ 08,02 clear to 21,78
   go top
   MCONT=1
   do while .not. eof()
      ARQ[MCONT]=str(CODFIL)+spac(2)+NOMEFIL
      MCONT=MCONT+1
      skip
      enddo
   @ 09,26 to 20,54 
   @ 10,27 say ' Fita  Nome'
   set color to bg+/n,n/bg+
   Y=achoice(11,27,19,53,ARQ)
   set color to
   if Y=0
      exit
   endif
   @ 10,26 clear to 20,54
   MCODFIL=VAL(substr(ARQ[Y],1,5))
   set order to 1
   go top
   seek MCODFIL
   OPCAO = 0
   do INDIV with OPCAO 
enddo
restore screen from TELACON
OPCAO = 2   
return
