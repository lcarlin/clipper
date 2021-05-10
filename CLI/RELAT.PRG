***********************************************************************
* bop relat.prg
* programa   : relat.prg
* autor      : Luiz
* data       : 31/03/94
* objetivo   : relatorios do sistema
* sistema    : contabil
**********************************************************************
save screen to tela_001
@ 20,24 to  22,55
public p
p=0
impre=" "
@ 21,25 SAY "                              "
@ 21,25 say "<T>ela <I>mpressora <V>oltar" get impre picture "@!" valid (impre$"TIV")
read                
if lastkeY()=27
   impre="V"
endif
USE CLIENTES INDEX IND_CLI2
if impre="I"
   IF .NOT. ISPRINTER()
      tone(350,3)
      tone(250,2)
      tone(150,1)
      @ 18,25 SAY "A impressora n„o pode estar pronta"
      inkey(0)
      use clientes index ind_cli
      return
   endif
   set color to w+*/n
   @ 18,25 say "Aguarde... Imprimindo...."
   set color to
   goto top
   set device to printer
   set console off
   do while .not. eof()
      relat2()
      eject
      skip
   enddo
   restore screen from tela_001
   use clientes index ind_cli
   set device to screen
   set console on
   return
elseif impre="T"
   clear
   nl=20
   l=3
   p=1
   @ 01,00 say "Pagina"+str(p,4,0)
   @ 02,00 say "Codigo  Nome                         Telefone       Cidade                Estado"
   use clientes index ind_cli
   goto top
   do while .not. eof()
      @ l, 00 say bcod  picture "@!"
      @ l, 08 say bnome picture "@!"
      @ l, 38 say btel  picture "999-999-9999"
      @ l, 52 say bcid  picture "@!"
      @ l, 74 say best  picture "@!"
      skip
      l=l+1
      if l>=nl
          @ 23,10 say "Pressione Algo P/ Continuar"
         inkey(0)
         clear 
         l=3
         p=p+1
         @ 01,00 say "Pagina"+str(p,4,0)
         @ 02,00 say "Codigo  Nome                         Telefone       Cidade                Estado"
        
     endif
   enddo
   if nl=20
      @ 23,10 say "Pressione Algo P/ Continuar"
      inkey(0)
   endif
elseif impre="V"
   restore screen from tela_001
   USE CLIENTES INDEX IND_CLI
   return
endif
set device to screen
set console on
restore screen from tela_001
USE CLIENTES INDEX IND_CLI
return

**********************************************************************
function relat2
p=p+1
l=9
cabecalho()
mobs=bobs
n=mlcount(mobs,75)
for x=1 to n
    @ l,03 say MEMOLINE(Mobs,75,x)
    l=l+1
    if l>=60
       eject
       cabecalho()
    endif
next

***********************************************
function cabecalho
@ 01,00 say "Pagina"+str(p,4,0)
@ 02,00 say "Codigo Nome                            Telefone     Cidade                Estado"
@ 3, 00 say bcod  picture "@!"
@ 3, 07 say bnome picture "@!"
@ 3, 39 say btel  picture "999-999-9999"
@ 3, 52 say bcid  picture "@!"
@ 3, 74 say best  picture "@!"
@ 04,00 say "Endereco"+space(40)+"CEP"
@ 5, 00 say bend picture "@!"
@ 5, 48 say bcp picture "99999-999"
@ 7,10 say "O B S E R V A C O E S"
* eop relat.prg