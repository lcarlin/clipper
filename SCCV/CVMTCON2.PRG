*************************************************
* bop cvmtcon2.prg
* programa     : CVMTCON2 .prg                  *
* autores      : WILSON, LUIZ, OSWALDO, EVERTON *
* coment       : GRUPO DE ESPERA DO CONSORCIO   *
* data         : 24/06/94			*
*************************************************
sele 1
use cvbgruco index cvigruc1
sele 2
use cvbfrota index cvifro1
sele 3
use cvbpedid
tela(18)
PRIVATE MCOcon
mcodcon=0
sele 1
@08,38 get mcodcon pict "99999"
read
if empty(mcodcon) .and. lastkey()=13
   tabela()
   if empty(mcodcon) .and. lastkey()=27
      return
   endif
   @ 10,38 get mcodcon pict "99999"
   clear gets
endif
limpa()
seek mcodcon
if .not. found()
   mensagem("Consorciado n„o Cadastrado")
   return
endif
mnomcli = nomcon
mcodcar = codcar
mcodgru = codgru
mnummes = nummes
mdatcon = datcon
mvalpre = valpre
mnumpag = numpag
msort   = sort
if msort = .T. .or.  msort = .t.
   msort = "S"
else
   msort = "N"
endif
mnumfala = 0
@ 09,38 get mnomcli
@ 10,38 get mcodcar
@ 11,38 get mcodgru
clear gets
@ 12,38 get mnumfala pict "999"
read 
mnumfal = mnummes - mnumfala
replace nummes with mnumfal
num=recno()
if mnumfal =  0
   mensagem("Todas As prestacoes ja quitadas",2)
   replace quit with .t.
endif
@ 13,38 get msort pict "!" valid (msort$"SN")
read
if msort = "S"
   replace sort with .T.
else
   replace sort with .F.
endif
if msort = "S"
   sele 2
   seek mcodcar
   mqtacar = quantcar
   if mqtacar = 0
      set color to w/b
      @23,14 say "Quantidade esgotada!!; Aguarde aproximadamente 10 dias pelo carro"
      inkey(0)
      @23,14 say space(65)
      set color to w/n
      @24,0 clear
      return
  endif
  mqtacar=mqtacar-1
  replace quantcar with mqtacar
  sele 1
  go num
endif
return

* eop cvmtcon2.prg