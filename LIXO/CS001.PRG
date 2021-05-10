/* Bop cs-01.prg
*Biblioteca de funcoes
*data       08/11/95
*autor      L.A.C.
*/
#include "INKEY.CH"

/********************************************

 Area de funcoes de Saida de tela/Impressora
************************************************* */


*******************************************************
*procedure que desenha qa sombra real . Parametros : coordenadas da tela.
PROCEDURE SOMBRA (x1, y1, x2, y2)
cororig := setcolor("w/n")
@ x1,y1 clear to x2,y2
* border(x1,y1+1,x2,y2)
shadow(x1,y1,x2,y2)
setcolor(cororig)
@ x1,y1 to x2,y2
setcolor(cororig)
RETURN

******************************************************
procedure centra(linha,texto,cor)
NUMERO := LEN(TEXTO)
CI     := int((80 - NUMERO)/2)
@ LINHA,00 SAY REPLICATE(" ",80) COLOR COR
@ linha,ci SAY texto COLOR COR
RETURN

**********************************************
procedure cent_imp (Lin, Mensa)
col := Int(80 - Len(alltrim(mensa))) / 2
@ lin,col say mensa

*********************************************************
function shadow(nT,nL,nB,nR)
RestScreen( nT+1, nL+2, nB+1, nR+2, ;
   Transform( SaveScreen(nT+1, nL+2, nB+1, nR+2), ;
   Replicate("X" + Chr(8), Len(SaveScreen(nT+1, nL+2, nB+1, nR+2)) )))
return nil

****************************
 function   Confirma (texto)
****************************
local nL, nAx, n_Numero, CI, nL1,nL2
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
   n_Numero := LEN(TEXTO[1])+2
   CI     := INT((80 - n_Numero)/2)
   nL1    := nAx-1
   nL2    := nAx+2+nL
ELSE
   n_Numero := LEN(TEXTO)+2
   CI     := INT((80 - n_Numero)/2)
   nL1 := 10
   nL2 := 14
ENDIF

setcolor("gr+/b")
SOMBRA(nL1,CI,nL2,CI+n_Numero)
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
LOCAL nL, nAx, n_Numero, CI, nL1,nL2, cor
save screen to tela_ant
cor    := setcolor("w/n")
nCurso := setcursor(0)
IF valtype (texto) = "A"
   nL     := len(texto)
   nAx    := int((25-nl)/2)
   n_Numero := LEN(TEXTO[1])+2
   CI     := INT((80 - n_Numero)/2)
   nL1    := nAx-1
   nL2    := nAx+2+nL
ELSE
   n_Numero := LEN(TEXTO)+2
   CI     := INT((80 - n_Numero)/2)
   nL1 := 10
   nL2 := 14
ENDIF

setcolor("gr+/b")
SOMBRA(nL1,CI,nL2,CI+n_Numero)
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

function dia_util(_dData)
a_matDia := {"Domingo      ",;
            "Segunda-Feira",;
            "Terca-Feira  ",;
            "Quarta-Feira ",;
            "Quinta-Feira ",;
            "Sexta-Feira  ",;
            "Sabado       "}
_nDia := dow(_dData)
IF empty(_dData)
   return .f.
ENDIF
@ row(),col()+1 say a_Matdia[_nDia]
IF _nDia = 1
   return .f.
ENDIF
RETURN .T.

**************************************
function ESTADOS(_Arg1)

   if (_Arg1 $ ;
         "AC,AL,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP,TO")
      return .T.
   endif
   return .F.
/***************************************

   Area de Funcoes de Tabelas de Dados

****************************************/

********************************
function TABELA ( nT, nL, nB, nR)
* #include "INKEY.CH"

LOCAL oNewCol, oTbObj
LOCAL I, lNewRecord := .f.
LOCAL nKey
LOCAL lScrlBar
LOCAL nThumbpos
LOCAL cScrlClr := "w/b"
LOCAL cThumbClr := "w+/n"
LOCAL cAppClr := setcolor()
LOCAL nRecsSkipped := 1
LOCAL nRow, nCol
LOCAL cPrevScr := savescreen(nT, nL, nB, nR)
LOCAL nCursor := set(_SET_CURSOR,0)
LOCAL vcamp := { FieldName(1) , FieldName(2)}
LOCAL vmasc := { "@!" , "@!"}
LOCAL vcab  := { "Codigo" , "Nome"}
LOCAL nRetorna := 0
goto top
cFileName := alias()
IF empty(cFileName)
   RETURN nil
ENDIF
IF pCount() < 4
   nT := 07
   nL := 10
   nB := 20
   nR := 73
ENDIF
telant := savescreen(nT,nL,nB+2,nR+2)
nThumbpos := nT+3
lScrlBar := if(lastrec() > nB-nT-2,.T.,.F.)
OtBoBJ := tbrowsedb(nT+1,nL+1,nB-1,nR-1)
FOR I := 1 TO 2
    oNewCol := tbcolumnNew(vCab[i] , fieldblock( vCamp[i] ) )    
    oTbObj:addColumn(oNewCol)
NEXT
oTbObj:HeadSep := "ÍÑÍ"
oTbObj:ColSep := chr(32)+chr(179)+chr(32)

// Utilizacao da funcao sombra, caso nao funcione legal,
// utilize a funcao WINSHADE fornecida com o disco

Sombra(nT,nL,nB,nR)

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
       nRetorna := 0
       EXIT
   ELSEIF nKey == K_ENTER
       nRetorna := 1
       EXIT
   ENDIF
ENDDO
restscreen(nT,nL,nB+2,nR+2,TELant)
RETURN nRetorna


* LIVRO DE CLIPPER PG 269 A 274
* cria tbrowse com barra de rolagem

FUNCTION TBGENERIC( nT, nL, nB, nR, aMatCols, cTitulo)
* #include "INKEY.CH"
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

/*************************************************
   area DE FUNCAO DE CALCULADORA

***************************************************/

********************************
function CALCULAD

   parameters calc_lin, calc_col, calc_cor
   private c_cor_ant, clin, corrente, atual, decimal, ult_char, ;
      operador, primeiro, tecla_pres, dp, calc_char, corvisor, ;
      corcalc, corteccalc, cor_calc, cor_tecla_, cor_visor_, enter, ;
      igual, esc, setadir, setaesq, setabaixo, setacima, move_tecla, ;
      cortemp, lowcortemp, cont_opera, tl_calc, tl_ant, estcur
   if (PCount() < 2 .OR. Type("calc_lin") != "N" .OR. ;
         Type("calc_col") != "N")
      calc_lin:= 1
      calc_col:= 53
   else
      if (calc_lin > 8)
         calc_lin:= 8
      endif
      if (calc_col > 53)
         calc_col:= 53
      endif
   endif
   estcur:= setcursor()
   setcursor(0)
   corvisor:= "n/w, n/w, "
   corcalc:= "w+/n, w+/n, "
   corteccalc:= corcalc
   if (Type("calc_cor") = "C")
      lowcortemp:= Lower(calc_cor)
      if (lowcortemp $ "n\b\g\bg\r\rb\gr\w")
         cortemp:= "w+"
         corteccalc:= "n/" + calc_cor + ", n/" + calc_cor + ", "
         if (lowcortemp = "n")
            corteccalc:= "w+/n, w+/n, "
         elseif (lowcortemp = "w" .OR. lowcortemp = "bg" .OR. ;
               lowcortemp = "gr")
            if (lowcortemp = "w")
               corvisor:= "w+/n, w+/n, "
            endif
            cortemp:= "n"
         endif
         corcalc:= cortemp + "/" + calc_cor + ", " + cortemp + "/" + ;
            calc_cor + ", "
      endif
   endif
   cor_calc:= corcalc
   cor_tecla_:= corteccalc
   cor_visor_:= corvisor
   esc:= 27
   enter:= 13
   igual:= 61
   setadir:= 4
   setaesq:= 19
   setacima:= 5
   setabaixo:= 24
   move_tecla:= Chr(setadir) + Chr(setaesq) + Chr(setacima) + ;
      Chr(setabaixo)
   tam_max_nu:= 19
   clin:= 0
   c_cor_ant:= SetColor(cor_calc)
   tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
      23)
   @ calc_lin, calc_col to calc_lin + 15, calc_col + 23
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 to calc_lin + clin + 3, calc_col ;
      + 22
   clin:= clin + 1
   set color to (cor_visor_)
   @ calc_lin + clin, calc_col + 2 say Space(20)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 2 say Space(20)
   clin:= clin + 2
   set color to (cor_calc)
   @ calc_lin + clin, calc_col + 1 say "  C    cE   Sr     ö/ "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  7    8    9      *  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  4    5    6      +  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  1    2    3      -  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  0    .    Yü     =  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   tl_calc:= SaveScreen(calc_lin, calc_col, calc_lin + 15, calc_col ;
      + 23)
   tecla_pres:= dp:= 0
   corrente:= atual:= 0
   operador:= " "
   ult_char:= "C"
   decimal:= .F.
   primeiro:= .T.
   cont_opera:= 0
   algarismo:= .F.
   calc_char:= " "
   do while (tecla_pres != esc)
      set color to (cor_visor_)
      if (calc_char $ "+-*Y/")
         @ calc_lin + 2, calc_col + 2 say calc_char
      endif
      @ calc_lin + 3, calc_col + 2 say corrente picture ;
         "@E 9,999,999,999,999.99"
      tecla_pres:= 0
      tecla_pres:= InKey(0)
      if (tecla_pres = enter)
         tecla_pres:= igual
      elseif ((tecla_pres = 114 .OR. tecla_pres = 82) .AND. ;
            procname(3) = "GET")
         exit
      endif
      calc_char:= Upper(Chr(tecla_pres))
      if (calc_char $ "+-/*Y")
         algarismo:= .F.
         if (cont_opera == 0)
            cont_opera:= 1
         else
            operador:= calc_char
            loop
         endif
      else
         cont_opera:= 0
      endif
      do case
      case tecla_pres = esc
      case calc_char $ move_tecla
         do case
         case tecla_pres = setadir
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_col:= calc_col + 1
            if (calc_col + 23 > 78)
               calc_col:= 1
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         case tecla_pres = setaesq
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_col:= calc_col - 1
            if (calc_col < 1)
               calc_col:= 55
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         case tecla_pres = setacima
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_lin:= calc_lin - 1
            if (calc_lin < 1)
               calc_lin:= 9
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         case tecla_pres = setabaixo
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_lin:= calc_lin + 1
            if (calc_lin + 15 > 24)
               calc_lin:= 1
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         endcase
         if (!algarismo)
            cont_opera:= 1
         endif
      case calc_char = "E"
         corrente:= 0
         dp:= 0
      case calc_char = "C"
         @ calc_lin + 2, calc_col + 2 say " "
         ult_char:= calc_char
         corrente:= 0
         atual:= 0
      case calc_char = "="
         @ calc_lin + 2, calc_col + 2 say " "
         if (atual = 0 .AND. operador != "Y")
            atual:= corrente
            operador:= " "
         endif
         calc_math()
         ult_char:= "="
      case calc_char = "S"
         if (ult_char = "=")
            corrente:= atual:= Sqrt(corrente)
         else
            corrente:= Sqrt(corrente)
         endif
      case calc_char $ "+-/*Y"
         if (ult_char $ "=C")
            @ calc_lin + 2, calc_col + 2 say " "
            if (ult_char = "C")
               atual:= corrente
            endif
            ult_char:= " "
            primeiro:= .T.
         else
            calc_math()
         endif
         operador:= ult_char:= calc_char
         dp:= 0
      case calc_char = "."
         decimal:= .T.
      case calc_char $ "0123456789"
         algarismo:= .T.
         get_corren()
      endcase
   enddo
   RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + 23, ;
      tl_ant)
   set color to (c_cor_ant)
   setcursor(estcur)
   if (tecla_pres = 114 .OR. tecla_pres = 82)
      keyboard alltrim(Str(corrente, 10, 2))
   else
      clear typeahead
   endif
   return .T.

********************************
static function CALC_MATH

   do case
   case operador = "+"
      atual:= atual + corrente
   case operador = "-"
      atual:= atual - corrente
   case operador = "*"
      atual:= atual * corrente
   case operador = "/"
      if (corrente == 0)
         atual:= 0
         corrente:= 0
         @ calc_lin + 3, calc_col + 2 say "          E r r o!!"
         InKey(0)
         clear typeahead
         keyboard "C"
      else
         atual:= atual / corrente
      endif
   case operador = "Y"
      atual:= atual ^ corrente
   endcase
   corrente:= atual
   primeiro:= .T.
   dp:= 0
   return .T.


********************************
static function GET_CORREN

   if (decimal)
      if (primeiro)
         primeiro:= .F.
         corrente:= Val("0." + calc_char)
      else
         corrente:= Val(LTrim(Str(corrente, tam_max_nu, 0)) + "." + ;
            calc_char)
      endif
      decimal:= .F.
      dp:= 1
   elseif (primeiro)
      primeiro:= .F.
      corrente:= Val(calc_char)
   else
      corrente:= Val(LTrim(Str(corrente, tam_max_nu, dp)) + calc_char)
      if (dp > 0)
         dp:= dp + 1
      endif
   endif
   return .T.


/****************************************************

  Area de funcoes de seguranca

******************************************************/
function cripto ( cMens )
LOCAL cRet := '' , nIi, nCar
FOR nIi := 1 TO len ( cMens )
    nCar := asc(substr(cMens , nII , 1))+ 100 + nIi
    cRet+=chr( ncar )
NEXT
RETURN (alltrim(cRet))
****************************************
function decripto ( cMens )
LOCAL cRet := '' , nIi, nCar
FOR nIi := 1 TO len ( cMens )
    nCar := asc(substr(cMens , nII , 1)) - 100 - nIi
    cRet+=chr( ncar )
NEXT
RETURN (alltrim(cRet))

********************************
* procedure que verifica se a senha digitada pelo usuario e correta
*******************************

function VERISENHA(Arg1)

   drowssap:= " "
   Arg1:= alltrim(Upper(Arg1))
   for k:= 1 to Len(Arg1)
      password:= Asc(SubStr(Arg1, k, 1)) + k + 99
      drowssap:= drowssap + Chr(password)
   next
   return alltrim(drowssap)

****************************************
* procedure que nao permite que terceiros vejas a digitacao da senha
*******************************************

function SEGURAN(Arg1, Arg2)

   private cc, rel, tecla, msx
   ccor_orig:= SetColor("w/n")
   cc:= Arg2 + 10
   set intensity off
   @ Arg1, Arg2 say Space(11)
   @ Arg1, Arg2 - 1 say "["
   @ Arg1, cc say "]"
   private msx[10]
   for i:= 1 to 10
      msx[i]:= " "
   next
   v_senha:= " "
   j:= 1
   do while (j < 10)
      set color to n/x
      @ Arg1, Arg2 get MSX[j] picture "!"
      read
      if (LastKey() == 13)
         exit
      elseif (LastKey() == 27)
         set color to (ccor_orig)
         return v_senha
      endif
      set color to w/n
      @ Arg1, Arg2 say "*"
      num:= Asc(msx[j])
      Arg2++
      j++
   enddo
   set intensity on
   for k:= 1 to 10
      v_senha:= v_senha + msx[k]
   next
   v_senha:= alltrim(v_senha)
   set color to (ccor_orig)
   return v_senha

****************************************
* procedure que permite que se altere as senhas do sistema.
******************************************************
procedure MANUTSEN

   begin sequence
      sombra(7, 19, 11, 57)
      cor_sen:= SetColor()
      @  8, 20 say "Digite a Senha Anterior.:"
      @  9, 20 say "Digite a Nova Senha.....:"
      @ 10, 20 say "Confirme a Nova Senha...:"
      if (file("cs.mem"))
         restore from cs additive
         v_senha_1:= seguran(8, 46)
         if (Empty(v_senha_1))
            break
         endif
         v_senha_1:= verisenha(v_senha_1)
         if (v_senha_1 == senha_mem)
         else
            mensagem("Senha Invalida!!")
            break
         endif
      else
         v_senha_1:= Space(10)
         v_senha_2:= Space(10)
         v_senha_3:= Space(10)
         senha_mem:= Space(10)
      endif
      v_senha_2:= seguran(9, 46)
      v_senha_3:= seguran(10, 46)
      if (Empty(v_senha_2) .AND. Empty(v_senha_3))
         if (confirma("Excluir Senha Atual "))
            erase cs.mem
         endif
         break
      endif
      if (v_senha_2 == v_senha_3)
         senha_mem:= v_senha_2
         senha_mem:= verisenha(senha_mem)
         save all like senha_mem to cs
      else
         mensagem("Senha Invalida!!")
         break
      endif
   end sequence
   set color to (cor_sen)
   return

********************************************
* funcao que veifica se a senha existe
****************************************************
function EXISTSENHA

   save screen to stelaseg
   lret:= .T.
   ccorant:= SetColor()
   begin sequence
      if (!file("cs.mem"))
         break
      endif
      sombra(11, 24, 13, 55)
      @ 12, 25 say "Entre com a senha"
      acesso:= seguran(12, Col() + 2)
      acesso:= verisenha(acesso)
      restore from cs.mem additive
      if (acesso == senha_mem)
         lret:= .T.
      else
         mensagem("Senha Invalida! Acesso negado!!")
         lret:= .F.
      endif
   end sequence
   restore screen from stelaseg
   set color to (ccorant)
   return lret


*********************************************
FUNCTION NtxProgress ()
LOCAL cComplete := ( STR((RECNO()/LASTREC() * 100),3,0) )
LOCAL cArq  := alias()
LOCAL cNumAr := len(cArq)
@ 23, 21 SAY "Indexando :" +padr(cArq,8," ")+"..." + cComplete + "%"
RETURN .T.


* eop cs001.prR