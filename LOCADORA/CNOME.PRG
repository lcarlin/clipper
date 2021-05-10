**********************************************************************
* Programa : CNOME.PRG                                               *
* Objetivo : Consulta de clientes por nome                           *
* Data : 12.07.92                                                    *
**********************************************************************
sele 2
X=reccount()
declare ARQ[X]
@ 06,02 clear to 21,78 
@ 7,21 say 'C O N S U L T A   D E   C L I E N T E S'
do while .t.
   for MCONT=1 to X
       ARQ[MCONT]=space(37)
   next    
   MENSA='<Esc> - Retorna ao menu anterior'
   MOSTRA(MENSA)
   @ 09,02 clear to 21,78
   MCONT=1
   MNOMECLI = space(30)
   set color to w/n,w/n+
   @ 10,08 say 'Nome ....: 'get MNOMECLI pict '@!'
   read
   if lastkey()=27 .or. MNOMECLI=' '
      exit
   endif   
   set color to
   set order to 2
   MNOMECLI=trim(MNOMECLI)
   seek MNOMECLI
   if eof()
      MENSA='Nome nao encontrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
      loop
   else
      do while substr(NOMECLI,1,len(MNOMECLI))=MNOMECLI .and. .not. eof()
         ARQ[MCONT]=str(CODCLI)+spac(2)+NOMECLI
         MCONT=MCONT+1
         skip
      enddo
      @ 12,08 to 20,48 
      set color to bg+/n,n/bg+
      Y=achoice(13,10,19,46,ARQ)
      set color to
      if Y=0
         exit
      endif   
      @ 10,21 clear to 20,59
      MCODCLI=val(substr(ARQ[Y],1,5))
      set order to 1
      go top
      seek MCODCLI
      OPCAO=0
      do CCODIGO with OPCAO
   endif
enddo
set color to
restore screen from TMENU1
OPCAO=2
return
