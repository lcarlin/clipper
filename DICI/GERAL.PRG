* Bop Geral.prg
****************************************************
procedure sai
SAI="N"
sombra(09,24,11,50,.t.)
TONE(250,1)
@ 10,25 say "Deseja Realmente Sair" get sai pict "!"
read
If sai= "S"
   set color to r+/w*
   @ 23,10 say "Aguarde... Reindexando Arquivos..."
   use palavras index indice1
   reindex
   use palavras index indice2
   reindex
   use verbos index indice3
   reindex
   use verbos index indice4
   reindex
   use expresso index indice5
   reindex
   use expresso index indice6
   reindex
   close all
   set color to
   @ 23,10 say "Retorno ao Sistema Operacional...."
   inkey(.7)
   for i=0 to 40
       @ 00,i clear to 24,i
       @ 00,79-i clear to 24,79-i
       inkey(0.01)
   next
   Restore screeN from tela_dos
   @ linha,coluna
   CLOSE ALL
   clear memory
   QUIT
   CANCEL
ENDIF
RETURN
RESTORE SCREEN FROM TELA

***********************************************************
function modulo
save screen to t_mod
parameters lin1, colu1
sombra(lin1,colu1,lin1+2,colu1+21,.t.)
@ lin1,colu1 to lin1+2,colu1+21
@ lin1+1,colu1+1 say "Modulo Nao Residente"
inkey (0)
restore screen from t_mod

*******************************************************
PROCEDURE SOMBRA
parameters x1, y1, x2, y2, sam
PRIVATE cororig, x1, x2,y1,y2, sam
if empty(sam)
   sam=.f.
endif
cororig= setcolor()
if sam
   SET COLOR TO w/n
   for i=x1 to x2
       @ x1,y1 clear to i,y2
       set color to r+/w
       @ x1,y1 to i, y2
       border(x1,y1+1,i,y2)
       set color to
       inkey(.05)
   next
   tone (130,1)
   set color to &cororig
else
   set color to
   border(x1,y1+1,x2,y2)
   set color to &cororig
   @ x1,y1 to x2,y2
endif
set color to &cororig
RETURN

**********************************************************
function modo
tela_3=savescreen(00,00,22,79)
cor =setcolor()
set color to n/w
if mo
   mo= .f.
   @ 23,01 say "Portugues/Ingles"
else
   mo= .t.
   @ 23,01 say "Ingles/Portugues"
endif
set color to &cor
restscreen(00,00,22,79,tela_3)
return (modo)

***********************************************************
PROCEDURE status
cor=setcolor()
arq=dbf()
posis=alltrim(str(recno(),8,0))+"/"+alltrim(str(reccount(),8,0))
if bof()
   posis="<bof>"+"/"+alltrim(str(reccount(),8,0))
elseif  eof()
   posis="<eof>"+"/"+alltrim(str(reccount(),8,0))
endif
dire=curdir()
if mo
   mo2="Ingles/Portugues"
else
   mo2="Portugues/Ingles"
endif
set color to n/w
@ 23,01 SAY SPACE(78)
set color to n/w
@ 23,01 say replicate (" ",78)
@ 23,01 SAY mo2+space(2)+"Dir.:"+alltrim(dire)+space(2)+"Arq.:"+alltrim(arq)+space(2)+"Posi.:"+posis+space(2)
set color to &cor
*return (.t.)

*************************************************************
procedure nada
t_nada= savescreen(22,20,22,61)
@ 22,20 say "Opcao ja selecionada ; Pressione algo..."
inkey(0)
@ 22,20 say "                                         "
restscreen(22,20,22,61,t_nada)
return

*******************************************
function controle
save screen to tela_te
parameters modo, elto, pos
do case
   case modo=4
	ret=0
   case modo=3
	if lastkey()=27
	    ret=0
	elseif lastkey()=13
	    ret=1
	elseif lastkey()=28
	    ret=0
	elseif lastkey()=4  
	    ret=0
	elseif lastkey()=19
	    ret=0
	elseif tecla=-1 .or. tecla=-2 .or. tecla=-3
	    ret=0
	else
	    ret=2
	endif
   case modo=2
	keyboard chr(31)
	ret=2
   case modo=1
	keyboard chr(30)
	ret=2
   case modo=0
	ret=2
endcase
restore screen from tela_te
tecla=lastkey()
return(ret)

*************************************************
procedure HELP
PARAMETERS PROG,LIN,VAR
save screen to tela_hlp
cor=setcolor()
set color to
prog=lower(prog)
var=lower(var)
do case
   case prog="manupal"
	do case
	   case var="mplingp"
		var_hlp = "Digite a Palavra Em Ingles No Plural"
	   case var="mplporp"
		var_hlp = "Digite a Palavra Em Portugues no Plural"
	   case var="moutros"
		var_hlp = "Digite os Outros Significados"
	   case var="mpling"
		var_hlp = "Digite a Palavra Em Ingles"
	   case var="mplpor"
		var_hlp = "Digite a Palavra Em Portugues"
	   case var="conf" .or. var="cont" .or. var="sim"
		var_hlp = "Digite <S> Ou <N>"
	   case var="alter"
		var_hlp = "Digite <A>lterar; <E>xcluir; <V>oltar"
	endcase
   case prog="conspal"
	do case
	   case var="mpling"
		var_hlp = "Digite a Palavra Em Ingles"
	   case var="mplpor"
		var_hlp = "Digite a Palavra Em Portugues"
	endcase
   case prog="manuver"
	do case
	   case var="mveii"
		var_hlp = "Digite o Verbo Em Ingles no Infinitivo"
	   case var="mvepi"
		var_hlp = "Digite o Verbo Em Portugues no Infinitivo"
	   case var="mveie"
		var_hlp = "Digite o Verbo Em Ingles No Presente"
	   case var="mveip"
		var_hlp = "Digite o Verbo Em Ingles No Passado"
	   case var="mveit"
		var_hlp = "Digite o Verbo Em Ingles No Participio"
	   case var="mveig"
		var_hlp = "Digite o Verbo Em Ingles No Gerundio"
	   case var="mtipo"
		var_hlp = "Digite o Tipo Do Verbo. Ex. Regular, aux.,etc.."
	   case var="conf" .or. var="cont" .or. var="sim"
		var_hlp = "Digite <S> Ou <N>"
	   case var="alter"
		var_hlp = "Digite <A>lterar; <E>xcluir; <V>oltar"
	endcase
   case prog="consver"
	do case
	   case var="mveii"
		var_hlp = "Digite o Verbo Em Ingles no Infinitivo"
	   case var="mvepi"
		var_hlp = "Digite o Verbo Em Portugues no Infinitivo"
	endcase
   case prog="manuexp"
	do case
	   case var="mexping"
		var_hlp = "Digite a Expressao Em Ingles"
	   case var="mexppor"
		var_hlp = "Digite a Expressao Em Portugues"
	  case var="conf" .or. var="cont" .or. var="sim"
		var_hlp = "Digite <S> Ou <N>"
	   case var="alter"
		var_hlp = "Digite <A>lterar; <E>xcluir; <V>oltar"
	endcase
   case prog="consexp"
	do case
	   case var="mexping"
		var_hlp = "Digite a Expressao Em Ingles"
	   case var="mexppor"
		var_hlp = "Digite a Expressao Em Portugues"
	endcase
   case prog="manutsen"
	if var="opsn"
	   var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
	endif
   case prog="seguran"
	if var="rel"
	   var_hlp = "Digite a Senha Desejada"
	endif
   case prog="espaco"
	if var="drive"
	   var_hlp = "Digite a Especificacao da Unidade"
	endif
   case prog="rodados"
	if var="coma"
	   var_hlp = "Digite o comando do DOS a ser Executado"
	endif
   case prog="anotar"
	if var="oe"
	   var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
	elseif var="nome"
	   var_hlp = "Digite o Nome da Anotacao"
	endif
   case prog="memoedit"
	var_hlp = "Use as Setas, <ESC> P/ sair e ^W p/ Gravar"
   case prog="copseg"
	if var="uni"
	   var_hlp = "Digite a Especificacao da Unidade"
	endif
   case prog="sai"
	if var="sai"
	   var_hlp = "Digite <S> Para Sair ou <N> para Continuar"
	endif
   case prog="achoice"
	var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
   case prog="imprime"
	if var="ip"
	    var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
	endif
   case prog="imp_pl"
	if var="edp"
	   var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
	elseif var="letra"
	   var_hlp = "Digite a 1§ Letra para especificar a impress„o"
	endif
   case prog="imp_exp"
	if var="edp"
	   var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
	elseif var="letra"
	   var_hlp = "Digite a Letra A especificar a impresao"
	endif
   case prog="imp_ver"
	if var="edp"
	   var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
	elseif var="letra"
	   var_hlp = "Digite a Letra A especificar a impresao"
	endif
   case prog="editadbf"
	var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
   case prog="dbedit"
	var_hlp = "Use as Setas, <HOME>, <END>, <PGUP>, <PGDW>"
   otherwise
       modulo(08,15)
endcase
num_hlp=len(var_hlp)
sombra(11,20,13,21+num_hlp,.t.)
@ 12,21 say var_hlp
inkey(0)
PROG=" "
LIN=0
VAR=" "
set color to &cor
restore screen from tela_hlp
RETURN
**********************************************
function conta_linha
l=l+1
skip
if l>=60
   l=3
   eject
   p=p+1
   titulo()
   @ 1,1 say "Pagina: "+alltrim(str(p,8,0))
   set device to screen
   @21,35 say p
   set device to printer
endif

**********************************************
function numero
numero=conta/60
sombra(19,09,22,45,.t.)
@ 20,10 say "Numero Aproximado De Paginas"+str(numero,6,2)
@ 21,10 say  "Numero Da Paginas Atual--->"

********************************
function titulo
@ 0,15 say "Corsa Soft Dici û 1.0  -  Autor: Luiz A. Carlin"
@ 01,00 say "Pagina:"+str(p,8,0)
@ 02,00 say texto1+texto2

**********************************************
procedure impress_
impn=savescreen(23,11,21,65)
tone (300,3)
@ 23,11 say "A Impressora Nao Pode Estar Pronta"
inkey (0)
restscreen(23,11,21,65,impn)
restore screen from tela_ed
set key -2 to imp
return

******************************************************
procedure direitos
save screen to tela_dire
sombra(05,24,15,49,.t.)
@ 05,28 say "Sobre o Dicion rio"
@ 07,25 say "    Corsa Soft Dici   "
@ 08,25 say "      Vers„o  1.0     "
@ 10,25 say "   Desenvolvido Por   "
@ 11,25 say "  Luiz Antonio Carlin "
@ 13,25 say "     Maio / 1994      "
inkey(0)
restore screen from tela_dire
return

****************************************
function shadow
private corf, corb, y, x, y2, x2, atr, nlen, svt, tmp,
parameters y, x, y2, x2, corf, corb
if type([y])+type([x])+type([y2])+type([x2])<>"NNNN" .or. y < 0 .or. x < 0 .or. y2 > 24 .or. x2 > 79
   return .f.
endif
if y > y2
   swap(@y,@y2)
endif
if x > x2
   swap(@x,@x2)
endif
corf=if(type([corf])="U",8,min(corf,15))
corb=if(type([corb])="U",0,min(corb,15))
atr=(corb*16)+corf
nlen=(x2-x+1)*(y2-y+1)+(x2-x)
if nlen>960
   return .f.
endif
svt=savescreen(y,x,y2,x2)
restscreen(y,x,y2,x2,transform(svt,replicate([x]+chr(atr),nlen)))
return .t.
********************
function border
private l, c, l2, c2, frt
parameters l, c, l2, c2, frt
if type([l])+type([c])+type([l2])+type([c2])<>"NNNN" .or. l < 0 .or. c < 0 .or. l2 > 24 .or. c2 > 77
   return .f.
endif
if l > l2
   swap(@l,@l2)
endif
if c > c2
   swap(@c,@c2)
endif
frt=if(type([frt])="U",8,min(frt,15))
shadow(l+1,c2+1,l2+1,c2+2,frt)
shadow(l2+1,c+1,l2+1,c2+2,frt)
return .t.
******************
function swap
private par1, par2, temp
parameters par1, par2
temp=par1
par1=par2
par2=temp
return .t.


********************************
* procedure que desenha a barra vertical

procedure desbarr
parameters lin_i, lin_f, col_i, car
if car <> 0
   FOR I = lin_i TO lin_f
       @ I,col_i SAY CHR(176)
   NEXT
endif
@ lin_i,col_i SAY CHR(24)
@ lin_f,col_i SAY CHR(25)
if car=1
   SET COLOR TO GR+/N
   @ lin_i+1,col_i sAY CHR(219)
   SET COLOR TO &COR_DB
elseif car=2
   SET COLOR TO GR+/N
   @ lin_f-1,col_i sAY CHR(219)
   SET COLOR TO &COR_DB
endif
return

*****************************************************
* procedure que move o cursor p/ baixo
function mov_bai
parameters lin, nvez, nrec, col_c, lin_ini
public lin
nvez=nvez+1
IF nvez = nrec .or. nvez > nrec
   nvez=0
   Lin=Lin+1
   IF Lin >= lin_ini
      Lin=Lin-1
   ENDIF
   COR=SETCOLOR()
   @ Lin-1,col_c SAY CHR(176)
   SET COLOR TO GR+/N
   @ Lin,col_c SAY CHR(219)
   SET COLOR TO &COR    
ENDIF
l=lin
return nvez

**********************9*******************************
* procedure que move o cursor p/ cima
function mov_cim
parameters lin,cnvez,cnrec,ccol_c,clin_fim
public lin
cnvez=cnvez-1
IF cnvez = 0 .or. cnvez < 0
   cnvez=cnrec
   Lin=Lin-1
   IF Lin <= clin_fim
      Lin=Lin+1
   ENDIF
   COR=SETCOLOR()
   @ Lin+1,ccol_c SAY CHR(176)
   SET COLOR TO GR+/N
   @ Lin,ccol_c SAY CHR(219)
   SET COLOR TO &COR    
ENDIF
l=lin
return cnvez

* eop geral.prg    
