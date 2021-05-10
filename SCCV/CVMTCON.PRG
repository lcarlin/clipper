*************************************************
* programa     : CVMTCON                        *
* autores      : WILSON, LUIZ, OSWALDO, EVERTON *
* coment       : GRUPO DE ESPERA DO CONSORCIO   *
*************************************************
parameters mcodcon, mnomcon
sele 1
use cvbgrupo index cvigru1
sele 2
use cvbfrota index cvifro1
sele 3
use cvbgruco
sele 4
use cvbfunc index cvifun1
tela(12)
PRIVATE MCODGRU
mcodcar=0
@ 08,30 get mcodcon
@ 09,30 get mnomcon
clear gets
sele 2
@ 10,30 get mcodcar pict "99999"
read
if lastkey() = 27
   return
endif
if empty(mcodcar) .and. lastkey()=13
   tabela()
   if empty(mcodcar) .and. lastkey()=27
      return
   endif
   @ 10,30 get mcodcar pict "99999"
   clear gets
endif
limpa()
seek mcodcar
if .not. found()
   mensagem("Carro n„o Cadastrado")
   return
endif
mcarmod = descar
mvalpre = valcar
sele 1
seek mcodcar
if .not. found()
   restore from cvmgrupo additive
   mcodgru =  mcodgru+1
   mnumpar =  0
   mnummes =  0
   mvalpre =  0
   mdatcon = date()
   mgrufec = .f.
   mnupgru = 1
   @ 11,30 get mcodgru pict "99999"
   clear gets
   @ 12,30 get mnumpar pict "999"
   @ 13,30 get mvalpre pict "999,999,999.99"
   READ
   mnummes = mnumpar
   @ 14,30 get mnummes pict "999"
   CLEAR GETS
   @ 15,30 get mdatcon pict "99/99/99"
   READ
   @ 16,30 get mnupgru pict "99"
   clear gets
   save to cvmgrupo all like mcodgru
else
   mnumpar = numpar
   mcodgru = codgru
   mnummes = nummes
   mvalpre = valpre
   mdatcon = datcon
   mgrufec = .f.
   count all for mcodgru=codgru to mnupgru
   mnupgru = mnupgru + 1
   @ 11,30 get mcodgru pict "99999"
   @ 12,30 get mnumpar pict "999"
   @ 13,30 get mvalpre pict "999,999,999.99"
   @ 14,30 get mnummes pict "99"
   @ 15,30 get mdatcon pict "@e"
   @ 16,30 get mnupgru pict "99"
   clear gets
endif
sele 4
comiss=mvalpre*0.0015
mcodfun = 0
do while empty(mcodfun)
   @ 17,30 get mcodfun pict "99999"
   read
   if empty(mcodfun) .and. lastkey()=13
      tabela()
      if empty(mcodfun) .and. lastkey()=27
         return
      endif
      @ 17,30 get mcodfun pict "99999"
      clear gets
   endif
   seek mcodfun
   if .not. found()
      mensagem("Funcionario nao Cadastrado")
      LIMPA()
      loop
   endif
   com=comfun+comiss
   replace comfun with com
enddo
limpa()
sele 1
if .not. confirma(23,10,"Cadastrar Consorciado")
   return
endif  
append blank
replace codcon with mcodcon
replace nomcon with mnomcon
replace codcar with mcodcar
replace codgru with mcodgru
replace valpre with mvalpre
*replace numpag with mnumpag
*replace numgru with mnumgru
replace grufec with mgrufec
replace numpar with mnumpar
replace nummes with mnummes
replace datcon with mdatcon
replace nupgru with mnupgru
count all  for codgru = mcodgru to totpan
if totpan >= mnumpar
   SET COLOR TO N/W*+
   @ 19,14 say "Aguarde!!! Grupo Fechado Transferindo dados..."
   declare grfec[totpan]
   set filter to codgru=mcodgru
   go top
   for i = 1 to totpan
       grfec[i] = recno()
       skip
   next
   go top
   k=0
   for k = 1 to totpan
       sele 1
       go grfec[k]
       _mnumpar = numpar
       _mcodgru = codgru
       _mnummes = nummes
       _mvalpre = valpre
       _mdatcon = datcon
       _mcodcar = codcar
       _mgrufec = .t.
       _mcodcon = codcon
       _mnumgru = numgru
       _mnupgru = nupgru
       _mnomcon = nomcon
       dele
       sele 3
       append blank
       replace codcon with _mcodcon
       replace nomcon with _mnomcon
       replace codcar with _mcodcar
       replace codgru with _mcodgru
       replace valpre with _mvalpre
       *replace numpag with _mnumpag
       *replace numgru with _mnumgru
       replace grufec with _mgrufec
       replace numpar with _mnumpar
       replace nummes with _mnummes
       replace datcon with _mdatcon
       replace nupgru with _mnupgru
   next
   set filter to
endif
limpa()
DO CVMTCLI