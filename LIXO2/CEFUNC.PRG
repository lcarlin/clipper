* Bop cefunc.prg
**********************************************

function verisenha(USERSENHA)
drowssap :=" "
usersenha:=alltrim(upper(usersenha))
for k:=1 to len(usersenha)
    password:=asc(substr(usersenha,k,1)) + k + 99
    drowssap:= drowssap+chr(password)
next
return alltrim(drowssap)

*****************************************************************************
procedure sai
SAI:="N"
sombra(09,24,11,55,.t.)
TONE(250,1)
if confirma(10,25,"Deseja realmente Sair")
   set color to r+/w*
   @ 23,10 say "Aguarde... Reindexando Arquivos..."
   @ 23,10 say "Retorno ao Sistema Operacional...."
   inkey(.7)
   SET COLOR TO
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
PROCEDURE SOMBRA (x1, y1, x2, y2, sam)
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
       border(x1,y1+1,i,y2,)
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

*************************************************************
procedure nada
t_nada:= savescreen(22,20,22,61)
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
        @ 24,13 SAY TIME()
	ret=2
endcase
restore screen from tela_te
return(ret)

*************************************************
procedure HELP
PARAMETERS prog, lin, var
save screen to tela_hlp
cor:=setcolor()
set color to
prog:=UPPER(prog)

var = lower(var)
var_hlp := space(10)
do case
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
   case prog="CONFIRMA"
	if var="sn"
	   var_hlp = "Digite <S> Para Sair ou <N> para Continuar"
	endif
   case prog="achoice"
	var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
   case prog="editadbf"
	var_hlp = "Use as Setas e <ENTER> P/ Selecionar"
   case prog="dbedit"
	var_hlp = "Use as Setas, <HOME>, <END>, <PGUP>, <PGDW>"
   otherwise
        ?? prog+" "+str(lin,5,0)+" "+VAR
        modulo(08,15)
endcase
if .not. empty(var_hlp)
    num_hlp=len(var_hlp)
    sombra(11,20,13,21+num_hlp,.t.)
    @ 12,21 say var_hlp
    inkey(0)
endif
setcolor(cor)
restore screen from tela_hlp
return
**********************************************
function conta_linha
l=l+1
skip
if l>=60
   l=3
   eject
   p=p+1
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

**********************************************
procedure impress_
impn=savescreen(23,11,21,65)
tone (300,3)
@ 23,11 say "A Impressora Nao Pode Estar Pronta"
inkey (0)
restscreen(23,11,21,65,impn)
restore screen from tela_ed
return

******************************************************
procedure direitos
save screen to tela_dire
sombra(05,24,15,49,.t.)
@ 05,28 say " Sobre o Sistema  "
@ 07,25 say "  Controle De Estoque "
@ 08,25 say "      Vers„o  1.0     "
@ 10,25 say "   Desenvolvido Por   "
@ 11,25 say "  Luiz Antonio Carlin "
@ 13,25 say "         1994         "
inkey(0)
restore screen from tela_dire
return

****************************************
function shadow
*Private corf, corb, y, x, y2, x2, atr, nlen, svt, tmp,
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
*privatE l, c, l2, c2, frt
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
function swap (par1, par2)
*private par1, par2, temp
temp=par1
par1=par2
par2=temp
return .t.

****************************
 function   Confirma
****************************
Parameters TEXTO
save screen to tela_ant
cor = setcolor()
SET COLOR TO
NUMERO = LEN(TEXTO)+2
CI = (80 - NUMERO)/2
set color to gr+/b
SOMBRA(12,CI,15,CI+NUMERO,.F.)
set color to r/n
@ 13,CI+1 SAY TEXTO
SET COLOR TO
var = 0
@ 14,35 PROMPT " Sim "
@ 14,41 PROMPT " Nao "
menu to var
setcolor(cor)
restore screen from tela_ant
IF var=1
   RETURN .T.
ENDIF
RETURN .F.

**********************************************
FUNCTION SEGURAN
PRIVATE CC,REL,TECLA,MSX
PARAMETERS L1,C1
CC=C1+10
SET INTEN OFF
@ L1,C1  SAY SPACE(11)
@ L1,C1-1 SAY "["
@ L1,CC   SAY "]"
private msx[10]
for i:=1 to 10
    msx[i]:=" "
next
V_senha:=" "
J:=1
do while j <10
   @ L1,C1 GET MSX[J] PICT "!"
   READ
   IF lastkey()=13
      EXIT
   ELSEIF LASTKEY()=27
      RETURN (V_senha)
   ENDIF
   
   @ L1,C1 SAY "*"
   NUM := ASC(MSX[J])
   TONE (NUM,1)
   c1++
   j++
enddo
set intensit on
FOR K := 1 TO 10
    V_senha:=V_senha+MSX[K]
NEXT
V_senha:=ALLTRIM(V_senha)
RETURN (V_senha)


**************************
FUNCTION INDICE(NUM,VET1,VET2)
SAVE SCREEN TO TELAINDI
VETESC:={}
FOR I := 1 TO NUM
    VETESC[I] := STR(I,3,0)+" "+VET1[I]+" "+VET2[I]
NEXT
SOMBRA(14,19,21,71,.T.)
@ 14,20 SAY "Num. Codigo  Descricao"
AUX=ACHOICE(15,20,20,70,VETESC,.T.)
RESTORE SCREEN FROM TELAINDI
RETURN VET1[AUX]

* eop cefunc.prg