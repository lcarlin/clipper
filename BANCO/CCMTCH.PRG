/************************************
* bop ccmtban.prg
* data 02/07/1996
* funcao  cadastro de cheques
* sistema  controle de cheques
* autor   luiz
* linguagem clipper 5.2e
***********************************/
PROCEDURE cheques ()
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
PUBLIC aBancos := {}, nBanc := 0
USE CCBBANC INDEX CCIBAN2, CCIBAN1  NEW
DO WHILE .NOT. eof()
   aaDd(aBancos,str(NBANCO,2,0)+" - "+nConta+" - "+Banco)
   SKIP
ENDDO
USE CCBchq  INDEX CCIch1, ccich2, ccIch3 NEW
 
 
Cabec := {"Numero do Cheque","Valor","Conta","Banco","Data de Emiss„o","Beneficiado"}
Campos := {"NCHEQUE","VALOR","CONTA","BANCO","DATAEM","BENEFI"}
 
aImp1 := {{11,12,"Periodo determinado"},;
          {11,34,"Todo o arquivo"},;
          {11,51,"Cancelar"}}
 
aImp2 := {{13,17,"Banco"},;
          {13,24,"N§ dos cheques"},;
          {13,41,"Data"},;
          {13,48,"Cancelar"}}
 
 
cFileName := alias()
IF empty(cFileName)
   RETURN nil
ENDIF
 
nT := 3
nL := 3
nB := 21
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
@ nT,nL+1 SAY "Cadastro de Cheques"
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
        sTelaInc := saveScreen(08,07,17,59)
        cCorAnt1:= SetColor(cCorInc)
        nApre := setcursor(1)
        BEGIN SEQUENCE
              sombra(08,07,16,57)
              nChq   := 0
              dData  := date()
              nValor := 0
              cBenefi:= space(30)
              cBanco := space(30)
              cConta := space(10)
              @ 08,07 SAY "Cadastro de Cheques"
              @ 09,08 SAY "Numero do Cheque:"
              @ 10,08 SAY "Valor...........:"
              @ 11,08 SAY "Data de Emiss„o.:"
              @ 12,08 SAY "Beneficiado.....:"
              @ 13,08 SAY "N§ do Banco.....:"
              @ 14,08 SAY " - Banco........:"
              @ 15,08 SAY " - Conta........:"
              nColuna := col()+1
              @ 09,nColuna GET nChq    PICT "99999999"
              @ 10,nColuna GET nValor  PICT "999,999,999.99"
              @ 11,nColuna GET dData   PICT "99/99/99"
              @ 12,nColuna GET cBenefi PICT "@!"
              @ 13,nColuna GET nBanc   PICT "99" VALID (ExistBanc(nBanc))
              READ
              IF lastkey() = 27
                 BREAK
              ENDIF
              cBanco := Substr(aBancos[ascan(aBancos,str(nBanc,2,0))],19,30)
              cConta := Substr(aBancos[ascan(aBancos,str(nBanc,2,0))],6 ,10)
              @ 13,nColuna GET nBanc  PICT "99"
              @ 14,nColuna SAY cBanco
              @ 15,nColuna SAY cConta
              CLEAR GETS
              Inkey(3)
              IF .NOT. confirma("Confirma os dados do banco ?",cCorBox)
                 BREAK
              ENDIF
 
              DbAppend()
              REPLACE NCHEQUE   WITH nChq
              REPLACE DataEm    WITH dData
              REPLACE Valor     WITH nValor
              REPLACE Conta     WITH cConta
              REPLACE Banco     WITH cBanco
              REPLACE benefi    WITH cBenefi
              REPLACE nBanco    WITH nBanc
              DbCommit()
              oTbObj:RefreshAll()
        END SEQUENCE
        setcolor(cCorAnt1)
        setcursor(nApre)
        restscreen(08,07,17,59,sTelaInc)
   ELSEIF nKey == K_ENTER  // ALTERAR
        getit(oTbObj)
        DbCommit()
        oTbObj:RefreshCurrent()
   ELSEIF nKey == 7       // eXCLUIR
       IF confirma("Deseja realmente excluir o Cheque ?",cCorBox)
          DELETE
          Skip
          DbCommit()
          oTbObj:RefreshAll()
       ENDIF
   ELSEIF nKey == K_ESC
       IF confirma("Deseja Retornar ?",cCorbOX)
          EXIT
       ENDIF
   ELSEIF nKey = K_SPACE
       aMostra := {"Dados do Cheque "+space(33),;
                   "Numero do Cheque:"+str(ncheque,11,0),;
                   "Valor...........:"+strpic(valor,19,2),;
                   "Data de Emiss„o.:"+dtoc(dataem),;
                   "Beneficiado.....: "+ benefi,;
                   "Banco...........: "+banco,;
                   "Conta...........: "+conta,;
                   "Cheque "+if(impresso,"j ","n„o")+ " impresso"}
       mensagem(aMostra,cCorfun)
   ELSEIF nKey = K_F2
       cCorAtua := Setcolor(cCorImp)
       sTelaImp := SaveScreen(00,00,MaxRow(),MaxCol())
       nRec := recNo()
       SET CENTURY ON
       BEGIN SEQUENCE
             IF .NOT. isprinter()
                Mensagem("A impressora nao esta pronta!!",cCorbOx)
                BREAK
             ENDIF
             Sombra(10,10,13,62)
             @ 10,10 SAY "Impress„o de registros "
             nOpcImp1 := Botao(aImp1,,cCorBin,cCorBat)
             IF (nOpcImp1 = 0) .OR. (nOpcImp1 = 3)
                BREAK
             ELSEIF nOpcImp1 = 1
                dData1 := dData2 := date()
                nCursor := setcursor(1)
                sombra(12,19,15,44)
                @ 13,20 SAY "Data inicial:" Get dData1 PICT "99/99/99"
                @ 14,20 SAY "Data final  :" Get dData2 PICT "99/99/99"
                READ
                setcursor(nCursor)
                SET FILTER TO DATAem >= dData1 .AND. Dataem <= dData2
                GO TOP
             ENDIF
 
             sombra(12,16,15,60)
             @ 12,16 SAY "Organizado por ?"
             nOpcImp2 := Botao(aImp2,,cCorBin,cCorBat)
             IF nOpcImp2 = 1
                SET ORDER TO 3
             ELSEIF nOpcImp2 = 2
                SET ORDER TO 1
             ELSEIF nOpcImp2 = 3
                SET ORDER TO 2
             ELSE
                BREAK
             ENDIF
             GO TOP
             sombra(12,20,14,50)
             @ 13,23 SAY "Aguarde!! Imprimindo..."
             SET CONSOLE OFF
             SET  DEVICE TO PRINTER
             nPag := 1
             @ 00,00 SAY CHR(64)
             @ 00,00 SAY replicate("=",80)
             @ 01,00 SAY "Relatorio de Cheques Emitidos"
             @ 01,67 SAY "Pagina: "+str(nPag,4,0)
             @ 02,00 SAY aImp1[nOpcImp1][3]+" Organizado por "+aImp2[nOpcImp2][3]
             @ 02,66 SAY "Data:"+dtoc(Date())
             @ 03,00 SAY replicate("=",80)
             @ 04,00 SAY chr(15)+"|Numero do cheque | Valor"+space(13)+"|Numero da conta | Banco"+space(24)+"|Data de emiss„o   | Favorecido"+space(19)+"|"+chr(18)
             nLInhaImp := Prow()+1
             DO WHILE .NOT. eof()
                @ nLinhaImp,00 SAY chr(15)
                @ nLinhaImp,00 SAY "|"
                @ nLinhaImp,Pcol()+9 SAY ncheque
                @ nLinhaImp,Pcol() SAY "|"+strpic(Valor,19,2)+"|"+space(6)+conta+"|"+banco+"|"
                @ nLinhaImp,Pcol()+08 SAY dataem
                @ nLinhaImp,Pcol() SAY "|"+benefi+"|"
                @ nLInhaImp,pCol() SAY chr(18)
                nLInhaImp++
                Skip
                IF nLinhaImp >= 54
                   nPag++
                   @ 00,00 SAY replicate("=",80)
                   @ 01,00 SAY "Relatorio de Cheques Emitidos"
                   @ 01,67 SAY "Pagina: "+str(nPag,4,0)
                   @ 02,00 SAY aImp1[nOpcImp1]+" Organizado por "+aImp2[nImp2]
                   @ 02,66 SAY "Data:"+dtoc(Date())
                   @ 03,00 SAY replicate("=",80)
                   @ 04,00 SAY chr(15)+"|Numero do cheque | Valor"+space(13)+"| Banco"+space(24)+"|Data de emiss„o   | Favorecido"+space(19)+"|"+chr(18)
                   nLInhaImp := Prow()+1
                ENDIF
             ENDDO
             EJECT
             SET FILTER TO
             GO TOP
             SET CONSOLE ON
             SET DEVICE TO SCREEN
             SET ORDER TO 1
       END SEQUENCE
       go nRec
       SET CENTURY OFF
       setcolor(cCorAtua)
       Restscreen(00,00,MaxRow(),Maxcol(),sTelaImp)
       oTbObj:RefreshAll()
   ELSEIF nKey = K_F1
      aAjuda := {"Ajuda                               ",;
                 "                                    ",;
                 "<ESPACO> - Visualiza registro   ",;
                 "<ENTER>  - Edita o campo         ",;
                 "<DELETE> - Exclui o  registro      ",;
                 "<INSERT> - Inclui novo registro  ",;
                 "<F2>     - Imprime Listagem  ",;
                 "<F3>     - Gera cheque na Impressora",;
                 "<F12>    - Calculadora  "}
      mensagem(aAjuda,cCorBox)
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
* eop CcMtCh.prg
