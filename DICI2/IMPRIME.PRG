*****************************************************************************
* programa : imprime.prg
* Obj      : Emissao de relatorios a partir de filtros nos DBF's
*****************************************************************************
corant=setcolor()
set key -2 to nada
clear gets
set color to gb/n,n/r
save screen to tela_ed
set deleted on
sombra(11,14,16,25,.t.)
ip=0
public ed, mcamp, mmasc, mcab, exp1, PROCURA, MCAMP, MCAB, MMAC
set filter to
@ 11,15 say    " Imprimir "
@ 12,15 prompt "Palavras.."
@ 13,15 prompt "Verbos...."
@ 14,15 prompt "Expressoes"
@ 15,15 prompt "Retorna..."
menu to ip
if lastkey()=27
   set deleted on
   restore screen from tela_ed
   set color to &corant
   set key -2 to imp
   read
   return
endif
do case
   case ip=1
        imp_pl()
   case ip=2
        imp_ver()
   case ip=3
       imp_ex()
   case ip=4
        restore screen from tela_ed
        set key -2 to imp
        set color to &cornat
        read
        return
endcase
set key -2 to imp
*****************************************************************************
*                 procedimentos gerais  de impressao
*****************************************************************************

*******************************************
* procedimentos de impressao de palavras
********************************************
procedure imp_pl
save screen to tela_ipp
sombra(11,22,15,35,.t.)
edp=0
@ 12,23 prompt "Arquivo Todo"
@ 13,23 prompt "Especifica.."
@ 14,23 prompt "Volta......."
menu to edp
if lastkey()=27
   restore screen from tela_ipp
   inkey(.05)
   restore screen from tela_ed
   set key -2 to imp
   read
   return
endif
if mo
   campo1="pling"
   texto1="Palavra Em Ingles    "
   campo2="plpor"
   Texto2="Palavra Em Portugues "
   select 1
   use palavras index indice1
else
   texto1="Palavra Em Portugues "
   Texto2="Palavra Em Ingles    "
   campo1="plpor"
   campo2="pling"
   select 1
   use palavras index indice2
endif
do case
   case edp=1
        select 1
        conta=reccount()
        imp_pl2()
   case edp=2
        close all
        letra=" "
        @ 20,15 say "Digite a 1§ Letra" get letra picture "@!"
        read
        if empty(letra)
           return
        endif
        use palavras
	set filter to &campo1=letra
        count for &campo1=letra to conta
        imp_pl2()
   case edp=3
        restore screen from tela_ipp
        inkey(.05)
        restore screen from tela_ed
	set key -2 to imp
        read
        return
endcase
*****************************************
*procedimentos de impressao de palavras (2)
*************************************
function imp_pl2
numero()
if  isprinter()
   set color to r*/w
   @ 23,19 say "Imprimindo..."
   set color to
   p=1
   l=3
   @ 21,35 say p
   set console off
   set device to printer
   titulo()
   goto top
   do while .not. eof()
      @ l,0 say &campo1
      @ l,22 say &campo2
      @ l,44 say plingp
      @ l,66 say Plporp
      @ l,88 say outros
      conta_linha()
  enddo
  eject
  set filter to
  set console on
  set device to screen
  restore screen from tela_ed
  set key -2 to imp
else
  impress_()
endif
*******************************************************
* procedimentos de impressao de verbos
****************************************************
procedure imp_ver
save screen to tela_ipp
sombra(11,22,15,35,.t.)
edp=0
@ 12,23 prompt "Arquivo Todo"
@ 13,23 prompt "Especifica.."
@ 14,23 prompt "Volta......."
menu to edp
if lastkey()=27
   restore screen from tela_ipp
   inkey(.05)
   restore screen from tela_ed
   set key -2 to imp
   read
   return
endif
if mo
   use verbos index indice3
   campo1="veii"
   texto1="Em Ingles No Infin. "
   campo2="veip"
   Texto2="Em Port. No Infini. "
   select 1
   use verbos index indice3
else
   use Verbos index indice4
   texto1="Em Port. No Infin.  "
   Texto2="Em Ingles No Infi.  "
   campo1="veip"
   campo2="veii"
   select 1
   use verbos index indice4
endif
do case
   case edp=1
        select 1
        conta=reccount()
        imp_ver2()
   case edp=2
        close all
        letra=" "
        @ 20,15 say "Digite a 1§ Letra" get letra picture "@!"
        read
        if empty(letra)
           return
        endif
	if mo
           letra="TO "+LETRA
	endif
	INKEY(2)
        use verbos
        set filter to &campo1=letra
	count for &campo1=letra to conta
        imp_ver2()
   case edp=3
        restore screen from tela_ipp
        inkey(.05)
        restore screen from tela_ed
	set key -2 to imp
        read
        return
endcase
*************************************************************************
*procedimentos de impressao de verbos(2)
************************************************************************
function imp_ver2
numero()
if  isprinter()
   set color to r*/w
   @ 23,19 say "Imprimindo..."
   set color to
   p=1
   l=3
   @ 21,35 say p
   set console off
   set device to printer
   titulo()
   goto top
   do while .not. eof()
      @ l,0   say &campo1
      @ l,21  say &campo2
      @ l,42  say veie
      @ l,63  say vepi
      @ l,84  say veit
      @ l,105 say veig
      @ l,126 say tipo
      conta_linha()
  enddo
  eject
  set console on
  set device to screen
  restore screen from tela_ed
else
  impress_()
endif
****************************************************************
* procedimentos de impressao de EXPRESSOES
**********************************************************
PROCEDURE IMP_EX
save screen to tela_ipp
sombra(11,22,15,35,.t.)
edp=0
@ 12,23 prompt "Arquivo Todo"
@ 13,23 prompt "Especifica.."
@ 14,23 prompt "Volta......."
menu to edp
if lastkey()=27
   restore screen from tela_ipp
   inkey(.05)
   restore screen from tela_ed
   set key -2 to imp
   read
   return
endif
if mo
   use palavras index indice1
   campo1="EXPING"
   texto1="Expressao Em Ingles                     "
   campo2="exppor"
   Texto2="Expressao Em Portugues                  "
   select 1
   use expresso index indice5
else
   texto1="Expressao Em Portugues                  "
   Texto2="Expressao Em Ingles                     "
   campo1="exppor"
   campo2="exping"
   select 1
   use expresso index indice6
endif
do case
   case edp=1
        select 1
        conta=reccount()
        imp_ex2()
   case edp=2
        close all
        letra=" "
        @ 20,15 say "Digite a 1§ Letra" get letra picture "@!"
        read
        if empty(letra)
           return
        endif
        use expresso
	set filter to &campo1=letra
	count for &campo1=letra TO CONTA
        imp_ex2()
   case edp=3
        restore screen from tela_ipp
        inkey(.05)
        restore screen from tela_ed
	set key -2 to imp
        read
        return
endcase
*****************************************************
* procedimentos de impressao de expressoes(2)
****************************************************
function imp_ex2
numero()
if  isprinter()
   l=3
   p=1
   set color to r*/w
   @ 23,19 say "Imprimindo..."
   set color to
   @ 21,35 say p
   set console off
   set device to printer
   titulo()
   goto top
   do while .not. eof()
      @ l,0  say &campo1
      @ l,40 say &campo2
      conta_linha()
  enddo
  eject
  set console on
  set device to screen
  restore screen from tela_ed
else
  impress_()
endif

*****************************************************************************
*                     fim das rotinas gerais de impressao
*****************************************************************************