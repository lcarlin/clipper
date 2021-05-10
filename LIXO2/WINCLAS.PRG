* bop winclas.prg

#include "winclas.ch"

* define a classe windownew

DEFINE CLASS windownew USING ntop, nleft, nbottom, nright
OBJECT LOCAL owindow

*verifica as mensagens recebidas
ntop    := if(valtype(ntop)    != "N",0,ntop)
nleft   := if(valtype(nleft)   != "N",0,nleft)
nbottom := if(valtype(nbottom) != "N",maxrow(),nbottom)
nright  := if(valtype(nright)  != "N",maxcol(),nright)

// cria um objeto sendo que serao armazenados os seguintes valores default
// para as variaveis/elementos

owindow := {1,;          //  border definicao da borda
	    setcolor(),; //  color  definicao da cor da janela
	    "",;         //  title  titulo
	    "",;         //  color title cor do titulo
	    "",;         //  screen tela a ser restaurada
	    ntop,;       //  top
	    nleft,;      //  left   | coordenadas 
	    nbottom,;    //  bottom | da janela
	    nright,}     //  retorna o objeto
return owindow

/**********
DEFINE o metodo openwin()
*/
DEFINE METHOD openwin MESSAGES owindow
local _coldcor  := setcolor(.owindow:color)
// salva a tela da janela no objeto, que foi passado por referencia
// veja a definicao do metodo no arq. winclas.ch
.owindow:screen := savescreen(.owindow:top,.owindow:left,.owindow:bottom+1,.owindow:right+2)
scroll(.owindow:top,.owindow:left,.owindow:bottom,.owindow:right,0)
shadow(.owindow:top,.owindow:left,.owindow:bottom,.owindow:right)
dispbox(.owindow:top,.owindow:left,.owindow:bottom,.owindow:right,.owindow:border)
@ .owindow:top, int( ( .owindow:right+.owindow:left - len(.owindow:title))/2 );
             say .owindow:title color .owindow:coltitle


setcolor(_coldcor)
return nil

/****************
define o metodo closewin()
*/
DEFINE METHOD closewin MESSAGES owindow
restscreen(.owindow:top,.owindow:left,.owindow:bottom+1,.owindow:right+2,.owindow:screen)
return nil

/* ***********************
funcao para realizar o efeito de sombra

function shadow(nT,nL,nB,nR)
RestScreen( nT+1, nL+2, nB+1, nR+2, ;
   Transform( SaveScreen(nT+1, nL+2, nB+1, nR+2), ;
   Replicate("X" + Chr(8), Len(SaveScreen(nT+1, nL+2, nB+1, nR+2)) )))
return nil

*************************************************************************
local nshadtop     := min(nBottom+1,maxrow()),;
      nshadbottom  := min(nright+1,maxrow()),;
      nshadleft    := nleft+1,;
      nshadright   := min(nright+1,maxcol())
restscreen(nshadtop,nshadleft,nshadbottom,nshadright, ;
  transform(savescreen(nshadtop,nshadleft,nshadbottom,nshadright),; 
        replicate("X"+chr(7),nshadright-nshadleft+1)))

nshadtop     := ntop+1
nshadleft    := min(nright+1,maxcol())
nshadbottom  := nbottom

restscreen(nshadtop,nshadleft,nshadbottom,nshadright, ; 
     transform(savescreen(nshadtop,nshadleft,nshadbottom,nshadright), ;
         replicate("X"+chr(7),(nshadbottom-nshadtop+1)*2)))
return nil
***************************************************************************
*/


* eop winclas.prg