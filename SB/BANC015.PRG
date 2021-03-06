#include "INKEY.CH"
LOCAL oNewCol, oTbObj
LOCAL I, lNewRecord := .f.
LOCAL nKey
LOCAL lScrlBar
LOCAL nThumbpos
LOCAL cScrlClr  := "w/b"
LOCAL cThumbClr := "w+/n"
LOCAL cCorAnt   := setcolor()
LOCAL cAppClr   := setcolor(cCorJanela)
LOCAL nRecsSkipped := 1
LOCAL nRow, nCol
LOCAL cPrevScr
LOCAL nCursor := set(_SET_CURSOR,0)
LOCAL Titulo1, Titulo2, TiTulo3
 
SAVE SCREEN to CHEQUE
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCorAnt)
   RESTORE SCREEN FROM CHEQUE
   CLOSE ALL
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   RESTORE SCREEN FROM CHEQUE
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT 3
IF NETUSE("devoluc",.F.,10)
   SET INDEX TO FLYDO_A,FLYDO_B,FLYDO_C,FLYDO_D,FLYDO_E,FLYDO_F
ELSE
   quemtrava("DEVOLUC")
   RESTORE SCREEN FROM CHEQUE
   close all
   setcolor(cCorAnt)
   return
endif
 
SELECT 4
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   QUEMTRAVA("BANCO")
   RESTORE SCREEN FROM CHEQUE
   close all
   setcolor(cCorAnt)
   return
endif
 
SAVE SCREEN to CHEQUE
 
declare CAMPOS[6],CABEC[6],CHAVE[6]
ordem      = 1
cCor  := setcolor(cCorPadra)
nApre := setcursor(1)
sombra(10,10,14,53)
centracl(10,10,53,"Dados do Arqu�vo")
v_banco = space(2)
@ 11,12 say    "C�digo..> " get v_banco pict "@!"
read
IF lastkey() = 27
   SETCOLOR(CcORaNT)
   close all
   restore screen from cheque
   return
ENDIF
setcursor(nApre)
select BANCO
set order to 1
seek v_banco
if .not. found()
   mensagemt("Banco n�o Cadastrado. Favor Conferir...")
   close all
   setcolor(cCorAnt)
   return
else
   @ 12,12 say "Banco...> "+banco
   @ 13,12 SAY "C/C.....> "+conta
   vbanco = banco
   vconta = conta
   centra(24,"Pressione Qualquer Tecla p/ Continuar.")
   inkey(0)
endif
setcolor(cCorJanela)
SELECT devoluc
SET ORDER TO 2
SET FILTER TO banco = v_banco
GO TOP
 
CAMPOS[ 1]  = "NUMERO"
CAMPOS[ 2]  = "VALOR"
CAMPOS[ 3]  = "FORNECEDOR"
CAMPOS[ 4]  = "DATA"
CAMPOS[ 5]  = "DATVEN"
CAMPOS[ 6]  = "CANCELADA"
 
CABEC[ 1] = "N�mero"
CABEC[ 2] = "Valor"
CABEC[ 3] = "Hist�rico"
CABEC[ 4] = "Data"
CABEC[ 5] = "Vencimento"
CABEC[ 6] = "Baixa"
 
CHAVE[1] = "Ordem"
CHAVE[2] = "Hist�rico"
CHAVE[3] = "Data"
CHAVE[4] = "Vencimento"
CHAVE[5] = "N�mero"
CHAVE[6] = "Baixa"
 
GOTO TOP
 
L1 =  2
C1 =  0
L2 = 21
C2 = 79
 
TITULO1 = "Dados"
TITULO2 = "Mensagens"
TITULO3 = "Devolu��es de Cheque do banco.> "+vBANCO+" C/C N�.> "+vCONTA
 
nT := 2
nL := 0
nB := 21
nR := 79
 
nThumbpos := nT+3
cPrevScr := savescreen(nT, nL, nB, nR)
 
lScrlBar := if(lastrec() > nB-nT-2,.T.,.F.)
OtBoBJ := tbrowsedb(nT+1,nL+1,nB-1,nR-1)
 
FOR I := 1 TO 6
    oNewCol := tbcolumnNew(Cabec[i],fieldblock( Campos[i]) )
    oTbObj:addColumn(oNewCol)
NEXT
 
oTbObj:HeadSep := "   "
oTbObj:ColSep := chr(32)+chr(179)+chr(32)
 
 
setcolor(cCorJanela)
Sombra(nT,nL,nB,nR)
 
IF lScrlbar
   setcolor(cScrlClr)
   @ nT+3,nR, nB-1, nR BOX "�"
   setcolor(cThumbClr)
   @ nThumbPos, nR SAY "�"
   setcolor(cAppClr)
ENDIF
 
DO WHILE .T.
   DO WHILE .NOT. oTbObj:stabilize()
      nKey := inkey()
      IF nKey <> 0
         EXIT
      ENDIF
      IF .NOT. EMPTY(CHAVE[1])
          centracl(00,1,79,titulo3,CCORSERV)
      ENDIF
      centra(24,"Pressione [ALT+H] Para Ajuda")
   ENDDO
   nRow := row()
   nCol := col()
   IF CANCELADA = "C"
      @ 21,68 say 'Baixado'
   else
      @ 21,68 say '       '
   endif
   setpos(nRow,nCol)
   IF lScrlBar
      IF nThumbPos <> int((nRecsSkipped/LastRec())*((nB-1) - (nT+3)) +(nT+3))
         nRow := row()
         nCol := col()
         setcolor(cScrlClr)
         @ nThumbpos, nR SAY "�"
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
       IF confirma("Deseja Retornar ?",cCorCaixa)
          EXIT
       ENDIF
   ELSEIF nKey == K_INS
       IF nNivel = 1 .OR. nNivel = 4
          IF reclock(1)
             cCor:= setcolor(cCorPadra)
             getit(oTbObj)
             setcolor(cCor)
             DESTRAVA()
          ELSE
             QUENTRAVA()
          ENDIF
          OTBOBJ:REFRESHCURRENT()
       ELSE
          mensagemT("Operador n�o autorizado a realizar  esta opera��o")
       ENDIF
   ELSEIF nKey = -5
       nApre := setcursor(1)
       cCor := setcolor(cCorserv)
       SAVE SCREEN TO telacod
       XTEMP = space(8)
       sombra(15,15,17,41)
       centracl(15,15,41,"Consulta por N�mero")
       @ 16,19 SAY "N�mero..> " GET XTEMP PICT "@!"
       READ
       nRec := RecNo()
       SET ORDER TO 5 // numero
       SEEK ALLTRIM(XTEMP)
       IF .NOT. found()
          mensagemt("Numero do Cheque n�o cadastrado !")
          go nRec
       ENDIF
       RESTORE SCREEN FROM telacod
       oTbObJ:RefreshAll()
       setcursor(nApre)
       setcolor(cCor)
   ELSEIF nKey = -6
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       SAVE SCREEN TO telacod
       XTEMP = date()
       SOMBRA(15,15,17,41)
       CENTRACL(15,15,41,"Consulta por Data")
       @ 16,19 SAY "data....> " GET XTEMP
       READ
       SET ORDER TO 3 // data
       SET SOFTSEEK ON
       SEEK XTEMP
       SET SOFTSEEK OFF
       RESTORE SCREEN FROM telacod
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = -7
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       SAVE SCREEN TO telacod
       XTEMP = space(45)
       SOMBRA(15,15,17,76)
       CENTRACL(15,15,76,"Consulta Hist�rico")
       @ 16,19 SAY "Dados...> " GET XTEMP PICT "@!KX"
       READ
       SET ORDER TO 2 // historico
       SET SOFTSEEK ON
       SEEK ALLTRIM(XTEMP)
       SET SOFTSEEK OFF
       RESTORE SCREEN FROM telacod
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = -8
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       SAVE SCREEN TO telacod
       XTEMP = date()
       SOMBRA(15,15,17,40)
       CENTRACL(15,15,40,"Consulta Vencimento")
       @ 16,19 SAY "Data....> " GET XTEMP
       READ
       SET ORDER TO 4 // vencimento
       SET SOFTSEEK ON
       SEEK XTEMP
       SET SOFTSEEK OFF
       RESTORE SCREEN FROM telacod
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = 7
       IF Confirma({"Deseja REALMENTE Excluir o registro",;
                    "Selecionado ?"},cCorCaixa)
          IF reclock(5)
             delete
             commit
          else
             quentrava()
          ENDIF
       endif
       oTbObj:RefreshAll()
   ELSEIF nKey = -41
       CALCULAD(15,43,"G")
   ELSEIF nKey = 291
       save screen to help
       cCor := setcolor(cCorCaixa)
       sombra(08,08,18,57)
       centracl(08,08,57,"Teclas de Fun��es")
       @ 09,10 say "      F6 - Consulta pelo n�mero."
       @ 10,10 say "      F7 - Consulta pela data de Emiss�o."
       @ 11,10 say "      F8 - Consulta pelo Hist�rico."
       @ 12,10 say "      F9 - Consulta pelo vencimento."
       @ 13,10 say "  INSERT - Altera a C�lula Posicionada."
       @ 14,10 say "  DELETE - Deleta a Linha Posicionada."
       @ 15,10 say "  PAGEup - Rola uma tela p/ cima."
       @ 16,10 say "PAGEdown - Rola uma tela p/ baixo."
       @ 17,10 say CHR(24)+" "+CHR(25)+" "+CHR(26)+" "+CHR(27)+"  - Teclas de Direcionamento da C�lula."
       @ 18,10 say CHR(24)+" "+CHR(25)+" "+CHR(26)+" "+CHR(27)+"  - Teclas de Direcionamento da C�lula."
       inkey(0)
       setcolor(cCor)
       restore screen from help
   ENDIF
ENDDO
setcolor(cCorAnt)
restore screen from cheque
tone( 100,3 )
close ALL
retorna = 0
RETURN NIL
