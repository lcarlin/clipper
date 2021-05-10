
* programa popmenu.prg
* biblioteca paraa geracao de menus do tipo popup
* funcoes  :_mopcao, _mborda, _mcores, _mchoice
* compilar com /a /n /w /m
* _mopcao ( <par> ) define  as opcoes do menu
#include "winclas.ch"

PROCEDURE _MOPCAO (_PAR)
if type("_nlin")=="U"
   public _nlin
   _nlin={}
endif
if type ("_ncol")=="U"
   public _Ncol
   _ncol={}
endif
if type ("_Cop")=="U"
   public _Cop
   _cop={}
endif
if type ("_cos")=="U"
   public _cos
   _cos={}
endif
Aadd( _nlin,  _par[1] )  //linha
Aadd( _ncol, _par[2] )  // coluna
Aadd( _cop,  _par[3] )  // opcao primaria
Aadd( _cos,  _par[4] )  // opcao secundaria
return

// _mborda (<par>) define o tipo de borda usada no menu
Procedure _Mborda (_par1)
public _cborda
_cborda := _par1
return

// _mcores (<par1>,<par2>,<par3>) - define as cores do menu
procedure _mcores (_par1,_par2,_par3)
public _cCorBorda, _ccorp, _ccors
_cCorBorda = _par1   // cor da borda
_ccorp    = _par2   // cor do menu primario
_ccors    = _par3   // cor do menu secundario
return

// _mchoice() processa o menu
function _mchoice()
OBJECT STATIC oJanMenu
local l, i, ccorant, nt, nl, nb, nr, ctela, ntecla, ccursor, nopcoes, nlin, ncol, nret, lsetwrap, aux
STATIC NOP := 1
STATIC nOs := {}
STATIC nS  := {}
oJanMEnu := windownew()
ccursor  = setcursor()
lsetwrap = set(_SET_WRAP)
SETCURSOR(0)
// AVALIA A Borda
if type ("_cborda")=="U"
   public _cborda
   _cborda= "ÚÄ¿³ÙÄÀ³"  // "+-+|+-+|"
endif
// avalia a cor da borda
if type ("_cCorBorda")=="U"
   public _cCorBorda
   _cCorBorda="w/n"
endif
// avalia a cor do menu primario
if type ("_ccorp")=="U"
   public _ccorp
   _ccorp = "w/n,n/w"
endif
// avalia a cor do menu secundario
if type ("_Ccors")=="U"
   public _ccors
   _ccors = "w/n,n/w"
endif
// avalia o vetor das linhas
if type ("_nlin")=="U"
   public _nlin
   _nlin = {}
endif
// avalia o vetor das colunas
if type ("_Ncol")=="U"
   public _ncol
   _ncol = {}
endif
// avalia o vetor das opcoes primarias
if type ("_cop")=="U"
   public _cop
   _cop = {}
endif
// avalia o vetor das opcoes secundarias
if type ("_cos")=="U"
   public _cos
   _cos = {}
endif
ccorant=setcolor(_cCorP)
// exibe todas as opcoes primarias
for i = 1 to leN(_cop)
    @ _nLin[i], _ncol[i] say _cop[i]
next
// comeca o menu
* nop := 1    // numero da opcao d menu primario
*nos := {}   // numero da opcao do menu secundario
*ns  := {}   // maior tamanho das opcoes secundarias
 // preenche o vetor do numero das opcoes secundarias com 1
for i = 1 to leN(_cop)
    aadd(nos,1)
next
// obtem o tamanho da maior opcao secundaria e armazena o ns
for l = 1 to len(_cop)
    aadd(ns,0)
    if _cos[l] != nil
       for i = 1 to len(_cos[l])
           if len( _cos[l,i] ) > ns[l]
              ns[l] = len(_cos[l,i])
           endif
       next
    endif
next

// comeca a edicao
do while .t.
   // seleciona a opcao primeira
   aux=at(",",_ccorp)+1
   setcolor(substr(_ccorp,aux,len(_ccorp)-aux+1))
   @ _nlin[nOp], _ncol[nOp] say _cOp[nOp]
   if _cos[nOp] != nil
      nt  :=   _nlin[nOp] +2
*     nl  :=   _ncol[nOp] - ((ns[nOp]+1-len(_cop[nop]))/2)
      nL  :=   _nCol[nOP]
      nl  :=   iif(nl<0,0,nl)
      nb  :=   nt + len(_cos[nop])+1
      nr  :=   nl + ns[nop] +1
      // mostra a tela com as opcoes secundarias
      // ctela=savescreen(nt,nl,nb,nr)
      .oJanMenu:left   := nl
      .oJanMenu:top    := nt
      .oJanMenu:right  := nr
      .oJanMenu:bottom := nb
      .oJanMenu:color  := _cCorBorda
      // setcolor(_cCorBorda)
      // @ nt,nl,nb,nr box _cborda
      .oJanMenu:openwin()
      setcolor(_ccors)
      for i = 1 to (nB-nT)-1
          @ nt+i,nl+1 say _cos[ nOp ,i ] //_cos[nop,i]
      next
      // obtem o numero total de opcoes secundarias ea linha de edicao
      nopcoes  =  (nb-nt)-1
      nlin     =  nt+nos[nop]
      ncol     =  nl+1
   endif
   // comeca a edicao das opcoes secundarias
   do while .t.
      if _cos[nop] != nil
         // mostra a opcao selecionada
         aux=at(",",_ccors)+1
         setcolor(substr(_ccors,aux,len(_ccors)-aux +1))
         // cor da opcao secundaria
         @ nlin,ncol say _cos[nop,nos[nop]]
      endif
      // aguarda por uma tecla
      // nTecla := inkey(0)
      cQualquer := " "
      SET CONSOLE OFF
      WAIT "" TO cQualquer
      SET CONSOLE ON
      nTecla := lastkey()
      do case
         case ntecla=24   // K_DOWN
              if _cos[nop] != nil
                 setcolor(_ccors)  // cor da opaco secundaria
                 @ nlin,ncol say _cos[nop,nos[nop]]
                 nlin++
                 nos[nop]++
                 if nos[nop] > len(_cos[nop])
                    if lsetwrap
                       nlin= nt+1
                       nos[nop] = 1
                    else
                       nlin--
                       nos[nop]--
                     endif
                 endif
              endif
              loop
         case ntecla=5             // K_UP
              if _cos[nop] != nil
                 setcolor(_ccors)  // cor da opaco secundaria
                 @ nlin,ncol say _cos[nop,nos[nop]]
                 nlin--
                 nos[nop]--
                 if nos[nop] < 1
                    if lsetwrap
                       nlin= nb-1
                       nos[nop] = len(_cos[nop])
                    else
                       nlin++
                       nos[nop]++
                     endif
                 endif
              endif
              loop
         case ntecla=4                    // K_RIGHT
              setcolor(_ccorp)
              @ _nlin[nop],_ncol[nop] say _cop[nop]
              .oJanMenu:closewin()
          *    restscreen(nt,nl,nb,nr,ctela)
              nop++
              if nop > len(_cop)
                 if lsetwrap
                    nop = 1
                 else
                    nop=len(_cop)
                 endif
              endif
              exit
         case ntecla=19 // K_LEFT
              setcolor(_ccorp)
              @ _nlin[nop],_ncol[nop] say _cop[nop]
              .oJanMenu:closewin()
*              *restscreen(nt,nl,nb,nr,ctela)
              nop--
              if nop <1
                 if lsetwrap
                    nop = len(_cop)
                 else
                    nop=1
                 endif
              endif
              exit
         case ntecla=13          // K_ENTER
              nret=val( str( nop,lennum(nop) )+str (nos[nop],lennum(nos[nop] ) ) )
              exit
         case ntecla=27
              nret=0
              exit
      endcase
   ENDDO
   IF nRet != NIL
      EXIT
   ENDIF

enddo

setcursor(ccursor)
setcolor(ccorant)
release _nlin, _ncol, _cop, _cos
return nret


* eop popmenu.prg