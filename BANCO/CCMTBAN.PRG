/************************************
* bop ccmtban.prg
* data 01/07/1996
* funcao  cadastro de bancos
* sistema  controle de cheques
* autor   luiz
* linguagem clipper 5.2e
***********************************/
PROCEDURE bancos ()
#include "INKEY.CH"
LOCAL oNewCol, oTbObj
LOCAL I, lNewRecord := .f.
LOCAL nKey
LOCAL lScrlBar
LOCAL nThumbpos
LOCAL cScrlClr  := "w/b"
LOCAL cThumbClr := "w+/n"
LOCAL cCorAnt   := setcolor()
LOCAL cAppClr   := setcolor(cCorDad)
LOCAL nRecsSkipped := 1
LOCAL nRow, nCol
LOCAL cPrevScr
LOCAL nCursor := set(_SET_CURSOR,0)
LOCAL Titulo1, Titulo2, TiTulo3
LOCAL Local2
USE CCBBANc INDEX CCIBAN2, cciban1
 
Cabec := {"Codigo do Banco","Banco","Conta"}
Campos := {"nBanco","Banco","NConta"}
 
cFileName := alias()
IF empty(cFileName)
   RETURN nil
ENDIF
 
nT := 5
nL := 8
nB := 19
nR := 76
 
nThumbpos := nT+3
cPrevScr := savescreen(nT, nL, nB, nR)
 
lScrlBar := if(lastrec() > nB-nT-2,.T.,.F.)
OtBoBJ := tbrowsedb(nT+1,nL+1,nB-1,nR-1)
 
FOR I := 1 TO len(Cabec)
    oNewCol := tbcolumnNew(Cabec[i],fieldblock( Campos[i]) )
    oTbObj:addColumn(oNewCol)
NEXT
 
oTbObj:HeadSep := "   "
oTbObj:ColSep := chr(32)+chr(179)+chr(32)
 
 
setcolor(cCordad)
Sombra(nT,nL,nB,nR)
@ nT,nL+1 SAY "Cadastro de Bancos"
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
   ELSEIF nKey == K_INS     // INCLUIR
        sTelaInc := saveScreen(09,09,14,63)
        cCorAnt := SetColor(cCorInc)
        nApre := setcursor(1)
        BEGIN SEQUENCE
              nRec := recNo()
              SET ORDER TO 2
              GO BOTTOM
              nProxBanc := nBanco+1
              SET ORDER TO 1
              GO nRec
              sombra(09,09,13,61)
              cBanco := space(30)
              cConta := space(10)
              @ 09,09 SAY "Cadastro de Bancos/Contas"
              @ 10,10 SAY "Numero do Banco:"
              @ 11,10 SAY "Banco..........:"
              @ 12,10 SAY "N§ da Conta....:"
              nColuna := col()+1
              @ 10,nColuna GET nProxBanc PICT "99"
              @ 11,nColuna GET cBanco
              @ 12,nColuna GET cConta PICT "@!"
              READ
 
              IF lastkey() = 27
                 BREAK
              ENDIF
 
              IF .NOT. confirma("Confirma os dados do banco ?",cCorBox)
                 BREAK
              ENDIF
 
              DbAppend()
              REPLACE NCONTA WITH cConta
              REPLACE BANCO  WITH cBanco
              REPLACE NBANCO WITH nProxbanc
              DbCommit()
              oTbObj:RefreshAll()
        END SEQUENCE
        setcolor(cCorAnt)
        setcursor(nApre)
        restscreen(09,09,14,63,sTelaInc)
   ELSEIF nKey == K_ENTER  // ALTERAR
        getit(oTbObj)
        oTbObj:RefreshCurrent()
        DbCommit()
   ELSEIF nKey == 7       // eXCLUIR
       IF confirma("Deseja realmente excluir o Banco ?",cCorBox)
          DELETE
          Skip
          DbCommit()
          oTbObj:RefreshAll()
       ENDIF
   ELSEIF nKey == K_ESC
       IF confirma("Deseja Retornar ?",cCorbOX)
          EXIT
       ENDIF
   ELSE
      IF ( nKey  <> 0 )
         IF ( ( Local2:= SetKey(nKey) ) != Nil )
            eVal(Local2, procname(1), procline(1), "")
            LOOP
         ENDIF
      ENDIF
   ENDIF
ENDDO
setcolor(cCorAnt)
CLOSE ALL
