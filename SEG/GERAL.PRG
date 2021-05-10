*************************************************************ç
*******
FUNCTION SEGURAN
PARAMETERS L1,C1
SET INTEN OFF
@ L1,C1-1 SAY SPACE(11)
@ L1,C1-01 SAY "["
@ L1,C1+10 SAY "]"
MSX=space(10)
REL=" "
CC=0
TECLA=LASTKEY()
PRIVATE CC,REL,TECLA,MSX
DO WHILE CC<=10
   REL=" "
   @ L1,C1 GET REL PICT "!"
   READ
   TECLA=LASTKEY()
   IF TECLA=13
      EXIT
   ENDIF
   REL2=REL
   @ L1,C1 SAY "*"
   STORE MSX+REL2 TO MSX
   MSX=ALLTRIM(MSX)
   C1=C1+1
   CC=CC+1
ENDDO
MSX1=ALLTRIM(MSX)
SEEK MSX1
IF EMPTY(MSX1)
   FLG2=.T.
   RETURN FLG2
ENDIF
IF FOUND()
   FLAG=.T.
   RETURN FLAG
ELSE
   FLAG=.F.
   RETURN FLAG
ENDIF
****************************************************
procedure sai
SAI="N"
sombra(09,24,11,50,.t.)
TONE(250,2)
@ 10,25 say "Deseja Realmente Sair" get sai pict "!"
read
If sai= "S"
   clear
   Restore screeN from tela_dos
   @ linha,coluna+4 say "***> Dici; Dicionario De Portugues/ingles Ingles/Portuges; v1.1 <***"
   CLOSE ALL
   QUIT
   CANCEL
ENDIF
RETURN
RESTORE SCREEN FROM TELA
***********************************************************
procedure modulo
save screen to t_mod
parameters lin1, colu1
sombra(lin1,colu1,lin1+2,colu1+21)
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
SET COLOR TO w/n
if sam
   tela_3=savescreen(x2+1,y1+1,x2+1,y2+1)
   for i=x1 to x2
       @ x1,y1 clear to i,y2
       @ x1+1,y1+1,i+1,y2+1 box "         "
       @ x1,y1 to i,y2
       inkey(.05)
   next
   set color to nw/n
   set color to w/n
else
   @ x1,y1 clear to x2,y2
   tela_3=savescreen(x2+1,y1+1,x2+1,y2+1)
   @ x1+1,y1+1,x2+1,y2+1 box "         "
   set color to nw/n
   set color to w/n
   @ x1,y1 to x2,y2
endif
SET COLOR TO &cororig
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
if deleted()
   apa="<Deletado>"
else
   apa="          "
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
@ 23,01 SAY mo2+space(2)+"Dir.:"+alltrim(dire)+space(2)+"Arq.:"+alltrim(arq)+space(2)+"Posi.:"+posis+space(2)+apa
set color to &cor
*return (.t.)
*************************************************************ç
****************
PROCEDURE BANCO
DO EDITADBF
RETURN
***************
procedure imp
do imprime
return
