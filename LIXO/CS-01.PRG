/* Bop cs-01.prg
Biblioteca de funcoes
data       08/11/95
autor      L.A.C.
*/


*******************************************************
*procedure que desenha qa sombra real . Parametros : coordenadas da tela.
PROCEDURE SOMBRA (x1, y1, x2, y2)
cororig := setcolor("w/n")
@ x1,y1 clear to x2,y2
border(x1,y1+1,x2,y2)
setcolor(cororig)
@ x1,y1 to x2,y2
setcolor(cororig)
RETURN

*********************************************************
function shadow
parameters  y, x, y2, x2, corf, corb
*Private corf, corb, y, x, y2, x2, atr, nlen, svt, tmp,

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
parameters l , c, l2, c2, frt
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
***3***************
function swap (par1, par2)
temp=par1
par1=par2
par2=temp
return .t.



****************************
 function   Confirma (texto)
****************************
cBotao1:="Sim"
cBotao2:="Nao"
nTecla := 0
nOpc   := 1
lRet   := .T.
nCBotao:=34
nCurs:=setcursor(0)
save screen to tela_ant
cor    := setcolor("w/n")
nCursor := setcursor(0)
IF valtype (texto) = "A"
   nL     := len(texto)
   nAx    := int((25-nl)/2)
   NUMERO := LEN(TEXTO[1])+2
   CI     := INT((80 - NUMERO)/2)
   nL1    := nAx-1
   nL2    := nAx+2+nL
ELSE
   NUMERO := LEN(TEXTO)+2
   CI     := INT((80 - NUMERO)/2)
   nL1 := 10
   nL2 := 14
ENDIF

setcolor("gr+/b")
SOMBRA(nL1,CI,nL2,CI+NUMERO)
setcolor("r+/N")
IF valtype(texto) = "A"
   FOR I := 1 TO nL
       @ nL1+i,CI+1 SAY TEXTO[I]
   NEXT
   nL1+=nL-1
ELSE
    @ nL1+1,CI+1 SAY TEXTO
ENDIF
setcolor("r+/b")
@ nL1+2,34 SAY CHR(16)+cBotao1+chr(17)
@ nL1+2,39 SAY     "Ü" COLOR "N+/N"
@ nL1+3,35 SAY "ßßßßß" COLOR "N+/N"
@ nL1+2,42 SAY " Nao "
@ nL1+2,47 SAY     "Ü" COLOR "N+/N"
@ nL1+3,43 SAY "ßßßßß" COLOR "N+/N"
DO WHILE .T.
   nTecla := inkey(0)
   IF nTecla = 19       // seta p/ esquerda
      nOpc --
      nCBotao := 34
      IF nOpc <1
         nOpc := 2
         nCBotao := 42
      ENDIF
   ELSEIF nTecla = 4    // seta p/ direita
      nOpc ++
      nCBotao := 42
      IF nOpc > 2
         nOpc := 1
         nCBotao := 34
      ENDIF
   ELSEIF nTecla = 13  // Enter
      sTela:=Savescreen(nL1+2,nCBotao,nL1+3,nCbotao+6)
      @ nL1+2,nCBotao SAY "      " color "w/n"
      @ nL1+3,nCBotao SAY "      " color "w/n"
      cBotAx := "cBotao"+str(nOpc,1,0)
      @ nL1+2,nCBotao+1 SAY CHR(16)+ &cBotAx + chr(17)
      INKEY(.2)
      restscreen(nL1+2,nCBotao,nL1+3,nCbotao+6,sTela)
      INKEY(.2)
      lRet := if(nOpc=1,.T.,.F.)
      EXIT
   ELSEIF nTecla = 27  //Esc
      lRet := .f.
      EXIT
   ENDIF
   @ nL1+2,34 SAY " Sim "
   @ nL1+2,42 SAY " Nao "
   cBotAx := "cBotao"+str(nOpc,1,0)
   @ nL1+2,nCBotao SAY CHR(16)+ &cBotAx + chr(17)
ENDDO
setcursor(nCurs)
setcolor(cor)
restore screen from tela_ant
RETURN (lRet)

********************************************************************
procedure mensagem (texto)
save screen to tela_ant
cor    := setcolor("w/n")
nCurso := setcursor(0)
IF valtype (texto) = "A"
   nL     := len(texto)
   nAx    := int((25-nl)/2)
   NUMERO := LEN(TEXTO[1])+2
   CI     := INT((80 - NUMERO)/2)
   nL1    := nAx-1
   nL2    := nAx+2+nL

ELSE
   NUMERO := LEN(TEXTO)+2
   CI     := INT((80 - NUMERO)/2)
   nL1 := 10
   nL2 := 14
ENDIF

setcolor("gr+/b")
SOMBRA(nL1,CI,nL2,CI+NUMERO)
setcolor("r+/N")
IF valtype(texto) = "A"
   FOR I := 1 TO nL
       @ nL1+i,CI+1 SAY TEXTO[I]
   NEXT
   nL1+=nL-1
ELSE
    @ nL1+1,CI+1 SAY TEXTO
ENDIF
setcolor("r+/b")

@ nL1+2,38 SAY CHR(16)+" Ok "+chr(17)
@ nL1+2,44 SAY      "Ü" COLOR "N+/N"
@ nL1+3,39 SAY "ßßßßßß" COLOR "N+/N"
nTecla := 0
DO WHILE nTecla <> 13
   nTEcla :=inkey(0)
ENDDO
sTela:=Savescreen(nL1+2,38,nL1+3,44)
@ nL1+2,38 SAY "      " color "w/n"
@ nL1+3,39 SAY "      " color "w/n"
@ nL1+2,39 SAY CHR(16)+ " Ok " + chr(17)
INKEY(.2)
restscreen(nL1+2,38,nL1+3,44,sTela)
INKEY(.2)
setcolor(cor)
setcursor(nCurso)
restore screen from tela_ant
RETURN

**********************************************
FUNCTION SEGURAN (l1, c1)
PRIVATE CC,REL,TECLA,MSX
cCor := setcolor()
nCursor1 := setcursor(0)
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
   setcolor("x,x")
   @ L1,C1 GET MSX[J] PICT "!"
   READ
   IF lastkey()=13 .OR. lastkey() = 27
      EXIT
   ENDIF
   setcolor(cCor)
   @ L1,C1 SAY "*"
   NUM := ASC(MSX[J])
   c1++
   j++
enddo
setcolor(cCor)
set intensit on
FOR K := 1 TO 10
    V_senha:=V_senha+MSX[K]
NEXT
V_senha:=ALLTRIM(V_senha)
setcursor(nCursor1)
RETURN (V_senha)


*************************************************
FUNCTION MANUTSEN()
sombra(07,19,11,57)
@ 08,20 SAY "Digite a Senha Anterior.:"
@ 09,20 say "Digite a Nova Senha.....:"
@ 10,20 say "Confirme a Nova Senha...:"
IF FILE ([CS.MEM])
   RESTORE FROM CS   additive
   cSenha1=seguran(08,46)
   IF EMPTY(cSenha1)
      return
   endif
   cSenha1=verisenha(cSenha1)
   if cSenha1==senha_mem
   ELSE
      mensagem("Senha Invalida !!!")
      return
   endif
ELSE
   cSenha1=SPACE(10)       
   cSenha2=SPACE(10)
   cSenha3=SPACE(10)
   SENHA_MEM=SPACE(10)
ENDIF
cSenha2=Seguran(09,46)
cSenha3=seguran(10,46)
if empty(cSenha2) .and. empty(cSenha3)
   IF confirma("Excluir a Senha Atual ?")
      DELETE FILE cs.mem
   ENDIF
   return
ENDIF
if cSenha2=cSenha3
   senha_mem=cSenha2
   senha_mem=verisenha(senha_mem)
   SAVE TO CS ALL LIKE Senha_mem
else
   mensagem("Senha Invalida !!")
   return
endif

*********************************************************
FUNCTION EXISTSENHA ()
IF .NOT. file("CS.MEM")
   return .t.
ENDIF
RESTORE FROM cs ADDITIVE
sombra(11,20,13,50)
@ 12,21 SAY "Digite a Senha:  "
cSenha := Seguran(12,col())
cSenha := verisenha(cSenha)
IF cSenha == senha_mem
ELSE
   mensagem("Senha Invalida !!!")
   RETURN .F.
ENDIF
RETURN .T.

**********************************************************

function verisenha(USERSENHA)
drowssap :=" "
usersenha:=alltrim(upper(usersenha))
for k:=1 to len(usersenha)
    password:=asc(substr(usersenha,k,1)) + k + 99
    drowssap:= drowssap+chr(password)
next
return alltrim(drowssap)


******************************************************
procedure centra(linha,texto,cor)
NUMERO := LEN(TEXTO)
CI     := int((80 - NUMERO)/2)
@ LINHA,00 SAY REPLICATE(" ",80) COLOR COR
@ linha,ci SAY texto COLOR COR
RETURN

*****************************************************
FUNCTION BOTAO(aOpc, lAtiva, cCorIna, cCorAt)
cCorAnt := setcolor()
IF lAtiva = Nil
   lAtiva := .t.
ENDIF
IF cCorIna = Nil
   cCorIna := "n+/w"
ENDIF
IF cCorAt = Nil
   cCorAt :="w/b"
ENDIF
nOpc := len(aOpc)
nEsc := 0
cCorF := " "
lFlag := .t.
cCorEsq := cCorIna+","+cCorAt
nCursor:=setcursor(0)
FOR I := 1 TO 6
    IF substr(cCorAnt,i,1) = "/"
       lFlag := .f.
       I++
       DO WHILE substr(cCorAnt,i,1) <> ","
          cCorF +=substr(cCorAnt,i,1)
          I++
       ENDDO
    ENDIF
    IF .not. lFlag
       EXIT
    ENDIF
NEXT
cCorSom := "n+/"+cCorf

BEGIN SEQUENCE
      setcolor(cCorIna+","+cCorAt)
      FOR I := 1 TO nOpc
          nTam := len(aOpc[i][3])
          IF lAtiva
             @ aOpc[i][1],aOpc[i][2] PROMPT aOpc[i][3]
          ELSE
             @ aOpc[i][1],aOpc[i][2] SAY aOpc[i][3] COLOR cCorIna
          ENDIF
          @ aOpc[i][1],aOpc[i][2]+nTam SAY "Ü" COLOR cCorSom
          @ aOpc[i][1]+1,aOpc[i][2]+1 SAY replicate("ß",nTam) COLOR cCorSom
      NEXT
      IF lAtiva
         MENU TO nEsc
         IF lastkey() = 27
            nEsc := 0
            BREAK
         ENDIF
         nTam := len(aOpc[nEsc][3])
         nL := aOpc[nEsc][1]
         nC := aOpc[nEsc][2]
         sTela := savescreen(nL,nC,nL+1,nC+nTam+1)
         @ nL,nC SAY replicate(" ",ntam+1) COLOR cCorSom
         @ nL+1,nC+1 SAY replicate(" ",ntam) COLOR cCorSom
         @ nL,nC+1 SAY aOpc[nEsc][3] COLOR cCorat
         INKEY(.2)
         restscreen(nL,nC,nL+1,nC+nTam+1,sTela)
         inkey(.2)
      ELSE
         nEsc := 0
      ENDIF
END SEQUENCE
setcursor(nCursor)
SETCOLOR(cCorAnt)
RETURN (nEsc)
**************************************************
function dia_util(dData)
amatDia := {"Domingo      ",;
            "Segunda-Feira",;
            "Terca-Feira  ",;
            "Quarta-Feira ",;
            "Quinta-Feira ",;
            "Sexta-Feira  ",;
            "Sabado       "}
nDia := dow(dData)
@ row(),col()+1 say aMatdia[nDia]
IF nDia = 1
   return .f.
ENDIF
RETURN .T.

******************************
* LIVRO DE CLIPPER PG 269 A 274
* cria tbrowse com barra de rolagem
FUNCTION TBGENERIC( nT, nL, nB, nR, aMatCols, cTitulo)
#include "INKEY.CH"
LOCAL oNewCol, oTbObj
LOCAL I, lNewRecord := .f.
LOCAL nKey
LOCAL lScrlBar
LOCAL nThumbpos := nT+3
LOCAL cScrlClr := "w/b"
LOCAL cThumbClr := "w+/n"
LOCAL cAppClr := setcolor()
LOCAL nRecsSkipped := 1
LOCAL nRow, nCol
LOCAL cPrevScr := savescreen(nT, nL, nB, nR)
LOCAL nCursor := set(_SET_CURSOR,0)

cFileName := alias()
IF empty(cFileName)
   RETURN nil
ENDIF

IF pcount() < 4
   nT := 1
   nL := 1
   nB := 23
   nR := 78
ENDIF

lScrlBar := if(lastrec() > nB-nT-2,.T.,.F.)
OtBoBJ := tbrowsedb(nT+1,nL+1,nB-1,nR-1)

FOR I := 1 TO len(aMatCols)
    oNewCol := tbcolumnNew(aMatCols[i][2],fieldblock( aMatCols[i][1]) )
    oTbObj:addColumn(oNewCol)
NEXT

oTbObj:HeadSep := "ÍÑÍ"
oTbObj:ColSep := chr(32)+chr(179)+chr(32)

// Utilizacao da funcao sombra, caso nao funcione legal,
// utilize a funcao WINSHADE fornecida com o disco

Sombra(nT,nL,nB,nR)
IF cTitulo <> NIL
   @ nT,int((nR-nL-Len(cTitulo))/2) SAY cTitulo
ENDIF
IF lScrlbar
   setcolor(cScrlClr)
   @ nT+3,nR, nB-1, nR BOX "±"
   setcolor(cThumbClr)
   @ nThumbPos, nR SAY "²"
   setcolor(cAppClr)
ENDIF

DO WHILE .T.
   DO WHILE .NOT. oTbObj:stabilize()
      nKey := inkey()
      IF nKey <> 0
         EXIT
      ENDIF
   ENDDO
   IF lScrlBar
      IF nThumbPos <> int((nRecsSkipped/LastRec())*((nB-1) - (nT+3)) +(nT+3))
         nRow := row()
         nCol := col()
         setcolor(cScrlClr)
         @ nThumbpos, nR SAY "±"
         nThumbPos := int((nRecsSkipped/LastRec())*((nB-1) - (nT+3)) +(nT+3))
         IF nThumbpos < nT +3
            nThumbpos := nT+3
            nRecsSkipped := 1
         ELSEIF nThumbPos > nB -1
            nThumbPos := nb-1
            nRecsSkipped := Lastrec()
         ENDIF
         setcolor(cThumbClr)
         @ nThumbpos, nr SAY CHR(178)
         devpos(nRow,nCol)
         setcolor(cAppClr)
      ENDIF
   ENDIF
   IF oTbObj:Stable
      IF oTbObj:HitTop  .AND.  !lNewRecord .AND. nKey == K_DOWN
         lNewRecord := .T.
         nKey := K_DOWN
      ELSE
         IF oTbObj:Hittop .OR. oTbObj:HitBottom
            tone(200,1)
         ENDIF
         nKey := inkey(0)
      ENDIF
   ENDIF
   IF nKey == K_DOWN .AND. lNewRecord
      dbappend()
      oTbObj:Gobottom()
      nRecsSkipped := lastrec()
      lNewRecord := .F.
      oTbObj:refresAll()
   ELSEIF nKey == K_DOWN
      oTbObj:Down()
      lNewRecord := .F.
      nRecsSkipped++
   ELSEIF nKey == K_UP
      oTbObj:up()
      lNewRecord := .F.
      nRecsSkipped--
   ELSEIF nKey == K_PGDN
       oTbObj:pagedown()
       nRecsSkipped+=oTbObj:rowCount
       oTbObj:refreshAll()
   ELSEIF nKey == K_PGUP
       oTbObj:pageup()
       lNewrecord := .f.
       nRecsSkipped-=oTbObj:rowCount
       oTbObj:refreshAll()
   ELSEIF nKey == K_CTRL_PGUP
       oTbObj:gotop()
       lNewrecord := .f.
       nRecsSkipped:=1
   ELSEIF nKey == K_CTRL_PGDN
       oTbObj:gobottom()
       lNewrecord := .f.
       nRecsSkipped:=lastrec()
   ELSEIF nKey == K_LEFT
       oTbObj:left()
   ELSEIF nKey == K_RIGHT
       oTbObj:right()
   ELSEIF nKey == K_HOME
       oTbObj:home()
   ELSEIF nKey == K_END
       oTbObj:end()
   ELSEIF nKey == K_CTRL_LEFT
       oTbObj:panleft()
   ELSEIF nKey == K_CTRL_RIGHT
       oTbObj:panright()
   ELSEIF nKey == K_CTRL_HOME
       oTbObj:panhome()
   ELSEIF nKey == K_CTRL_END
       oTbObj:panend()
   ELSEIF nKey == K_ESC
       EXIT
   ELSEIF nKey == K_RETURN
       getit(oTbObj)
   ELSEIF nKey > 31 .AND. nKey < 127
       KEYBOARD chr(nKey)
       geTit(oTbObj)
   ENDIF
ENDDO

RETURN NIL

***************************************
* FUNCAO QUE FORNECE A ENTRADA DE DADOS DE PERCURSO
FUNCTION GETIT( oTbObj )
LOCAL lReadExitSet := readexit(.t.)
LOCAL oGet, ogetCol
oGetCol := oTbObj:GetColumn(oTbObj:ColPos)
oGet := getNew(row(),col(),oGetCol:block,oGetCol:heading)
SET CURSOR ON
readmodal( { oget } )
oTbObj:refreshCurrent()
SET CURSOR OFF
IF lastkey() == K_UP .OR. lastkey() == K_DOWN .OR. lastkey() == K_PGDN .OR. lastkey() == K_PGUP
   KEYBOARD chr(lastkey())
ENDIF
readexit(lreadexitSet)
RETURN NIL

**************************
PROCEDURE CALCULA()
LOCAL getlist :={}
sTelaCal := savescreen(09,40,22,75)
cCorCalc := Setcolor("w/n,n/w")
nSetCur := setcursor(1)
sombra(09,40,21,65)
nValor1 := nValor2 := nResul := nResulAnt := 0
SET KEY 43 TO MAIS()
SET KEY 45 TO MENOS()
SET KEY 42 TO VEZES()
SET KEY 47 TO DIVIDE()
SET KEY 27 TO FIM()
@ 13,42 SAY "1 º   2 º   3 º    + º "
@ 14,42 SAY "ÄÄ½   ÄÄ½   ÄÄ½    ÄÄ½ "
@ 15,42 SAY "4 º   5 º   6 º    - º"
@ 16,42 SAY "ÄÄ½   ÄÄ½   ÄÄ½    ÄÄ½"
@ 17,42 SAY "7 º   8 º   9 º    * º"
@ 18,42 SAY "ÄÄ½   ÄÄ½   ÄÄ½    ÄÄ½"
@ 19,42 SAY "0 º   . º   , º    / º"
@ 20,42 SAY "ÄÄ½   ÄÄ½   ÄÄ½    ÄÄ½"
DO WHILE lastkey() <> 27
   @ 10,41 CLEAR TO 11,62
   nValor2 := nResul := 0
   @ 10,41 GET nValor1 PICT "999,999,999,999.999999"
   READ
   nOpera := INKEY(0)
   IF nOpera = 27 .OR. LASTKEY() = 27
      EXIT
   ENDIF
   @ 11,41 GET nValor2 PICT "999,999,999,999.999999" WHEN(nOpera<>27)
   READ
   IF nOpera = 43
      nResul := nValor1+nValor2
   ELSEIF nOpera = 45
      nResul := nValor1-nValor2
   ELSEIF nOpera = 42
      nResul := nValor1*nValor2
   ELSEIF nOpera = 47
      nResul := nValor1/nValor2
   ENDIF
   @ 12,41 GET nresul PICT "999,999,999,999.999999"
   CLEAR GETS
   nValor1 := nResulAnt := nResul
ENDDO
DO WHILE nextkey() <> 0
   CLEAR TYPEAHEAD
ENDDO
restscreen(09,40,22,75,sTelaCal)
setcursor(nSetCur)
setcolor(cCorCalc)
SET KEY 43 TO
SET KEY 45 TO
SET KEY 42 TO
SET KEY 47 TO
SET KEY 27 TO
RETURN

function MAIS()
KEYBOARD CHR(13)+CHR(43)
RETURN(NIL)

FUNCTION MENOS()
KEYBOARD CHR(13)+CHR(45)
RETURN(NIL)

FUNCTION VEZES ()
KEYBOARD CHR(13)+CHR(42)
RETURN(NIL)

FUNCTION DIVIDE ()
KEYBOARD CHR(13)+CHR(47)
RETURN(NIL)


FUNCTION FIM()
KEYBOARD CHR(13)+CHR(27)


* eop cs-01.prR