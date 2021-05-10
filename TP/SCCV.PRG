****************************
* Bop sccv.prg
* programa : SCCV.PRG
* autor    : Wilson dos Santos Junior - Oswaldo C de Oliveira Junior.
* coment   : Telas do Sistema de Controle de Concession ria
****************************

setcancel(.f.)
set proc to cvtelas
set device to screen
set print off
set cons on
set date brit
set deleted on
set proc to cv_func
set key -1 to DISKspace()
set key -2 to CONSORcalc()
set key 301 to saida()
set talk off
set wrap on
set score off
set cursor on
clear
public ia5, id5, i10, i12, i20
ia5=CHR(14)     && ativa a expansao em uma linha
id5=CHR(20)     && desativa a expansao
i10=CHR(30)+"0" && impressao a 10 cpp
i12=CHR(30)+"2" && impressao a 12 cpp
i20=CHR(15)+CHR(14)     && ativa condensacao de caracteres
if .not. file("cvialm1.ntx")
   use cvalmox
   index on codalm to cvialm1
   close all
endif
if .not. file("cvicli1.ntx")
   use cvbclien
   index on codcli to cvicli1
   CLOSE ALL
endif
if .not. file("cvipec1.ntx")
   use cvbpecas
   index on codpec to cvipec1
   close databases
endif
if .not. file("cvifor1.ntx")
   use cvbforne
   index on codfor to cvifor1
   close all
endif
if .not. file("cvifun1.ntx")
   use cvbfunc
   index on codfun to cvifun1
   close all
endif
if .not. file ([cvifro1.ntx])
   use cvbfrota
   index on codcar to cvifro1
   close all
endif
IF .not. file("cvigra1.ntx")
   use cvvcar
   index on descar to cvigra1
   close all
endif
if .not. file ("cvirep1.ntx")
   use cvrepar
   index on codorc to cvirep1
   close all
endif
if .not. file ("cvigrap1.ntx")
   use cvvpec
   index on despec to cvigrap1
   close all
endif
if .not. file ("cvigrav1.ntx")
   use cvvcar
   index on descar to cvigrav1
   close all
endif

if .not. file ([cvigru1.ntx])
   use cvbgrupo
   index on codcar to cvigru1
   close all
endif
if .not. file('cvigru2.ntx')
   use cvbgrupo
   index on codgru to cvigru2
   close all
endif
if .not. file ([cvigruc1.ntx])
   use cvbgruco
   index on codcon to cvigruc1
   close all
endif
if .not. file ([cvmgrupo.mem])
   mcodgru=0
   save to cvmgrupo all like mcodgru
endif
if .not. file("cvivpec1")
    use cvpecas
    index on  codpec to cvivpec1
    close databases
endif
if .not. file("cvipec1")
    use cvbpecas
    index on codpec to cvipec1
    close databases
endif
if .not. file("cvipent1.ntx")
    use cvbpent
    index on codcar to cvipent1
    close all
endif
DECLARE VET[1]
VET[1] = 0
PUBLIC OP, ESC, VARA, SAIR, TECLA
tecla=lastkey()
declare clie[3], cons[3], forn[3], serv[5], esto[5]
clie[1] = " Manuten‡„o "
clie[2] = " Consulta  "
clie[3] = " Relat¢rio  "
acopy(clie,cons)
acopy(clie,forn)
serv[1] = " Venda Pecas "
serv[2] = " Reparos     "
serv[3] = " Cons¢rcios  "
serv[4] = " Pronta Entr "
serv[5] = " Relatorio   "
esto[1] = " Pe‡as        "
esto[2] = " Almoxarifado "
esto[3] = " Frota        "
esto[4] = " Relatorio    "
esto[5] = " Graficos     "
clea
set color to w/bg
@ 01,00 clear to 23,79
set color to w+/b
@ 1,0 clear to 1,79
meio("S.C.C.V - Controle de Concessionaria Versao 1.0",01)
@23,00 clear to 23,79
@23,00 SAY "Mensagens..:"
set color to w/r+
@ 22,0 say "     <F1>-Espaco de Disco         <F2>-Calculadora          <ALT>+<X>-Sair      "
cl=1
mov=0
op = 0
item0="   Clientes   "
item1=" Funcion rios "
item2=" Fornecedores "
item3="  Servi‡os    "
item4="   Estoques   "
@ 02,00 say space(80)
@ 02,00 say item0
@ 02,17 say item1
@ 02,33 say item2
@ 02,50 say item3
@ 02,62 say item4
save screen to tel_men
sai=.t.
do while .T.
   restore screen from tel_men
   inverso='item'+str(mov,1,0)
   set color to b/bg
   @ 2,cl say &inverso
   set color to w/b,w/r+
   tecla = lastkey()
   do case
      case mov = 0
	   borda(3, 1, 7, 14)
	   op = achoice(4, 2, 6, 13, clie, "funac" ,.t.)
			
	   If op = 1
	      do cvmtcli
	   ELSEIF OP=2
	      DO cvconcli
	   ELSEIF OP=3
	      DO CVRCLI
	   endif
      case mov = 1
	   @ 3, 17 to 7, 30
	   borda(3, 17, 7, 30)
	   op = achoice(4, 18, 6, 29, cons, "funac", .t.)
			
	   if op = 1
	      do cvmtfunc
	   elseif op = 2
	      do cvconfun
	   elseif op = 3
	      do cvrfunc
	  endif
      case mov = 2
	   @ 3, 33 to 7, 46
	   borda(3,33,7,46)
	   op = achoice(4, 34, 6, 45, forn,"funac", .t.)
			
	   if op = 1
	      do cvmtfor
	   elseif op = 2
	      do cvconfor
	   elseif op=3
	      do cvrfor
	   endif
      case mov = 3
	   @ 3, 49 to 9, 65
	   borda(3,49,9,65)
	   op = achoice(4, 50, 8, 64, serv, "funac", .t.)
	   if op=1
	       do cvmtvpec
	   elseif op=2
	       do cvmtvrep
	   elseif op=3
	       do cvmtcon2
	   elseif op=4
	       do cvmtpent
	   elseif op=5
	       do cvrserv
	   endif
      case mov = 4
	   @ 3, 63 to 9, 77
	   borda(3,63,9,77)
	   op = achoice(4, 64, 8, 76, esto, "funac",.t.)
	   if op = 1
	      do cvmtpec
	   elseif op = 2
	      do cvmtalmx
	   elseif op = 3
	      do cvmtfro
	   elseif op = 4
	      DO CVREST
	   elseif op = 5
	      borda(7,57,10,70,"w/b")
              @8,58 prompt "   Frota    "
	      @9,58 prompt "   Pecas    "
              menu to op1
	      if op1= 1
		 do cvgrafro
	      elseif op1= 2
		 do cvgrapec
              endif
           endif
   endcase
   TECLA=LASTKEY()
   if tecla = 4
      cl=cl+16
      mov = mov + 1
      if mov > 4
	 mov = 0
	 cl=1
      endif
   elseif tecla = 19
      cl=cl-16
      mov = mov - 1
      if mov < 0
	 mov = 4
	 cl=65
      endif
   elseif tecla=-9
      saida()
   endif
   set color to w/n
   normal='item'+str(mov,1,0)
   @ 2,cl say &normal
   set color to n/w
   inverso='item'+str(mov,1,0)
   @ 2,cl say &inverso
   set color to w/n
   tecla=lastkey()
enddo
return


***************************
function funac
****************************
save screen to tela_te
parameters modo, elto, pos
do case
   case modo=4
	ret=0
   case modo=3
	if lastkey()=27
	    ret=2
	elseif lastkey()=13
	    ret=1
	elseif lastkey()=4
	    ret=0
	elseif lastkey()=301
	    saida()
	elseif lastkey()=19
	    ret=0
	endif
   case modo=1
	keyboard chr(30)
	ret = 2
   case modo = 2
	keyboard chr(31)
	ret = 2
   case modo=0
	ret=2
endcase
restore screen from tela_te
tecla=lastkey()
return(ret)

*EOP SCCV
