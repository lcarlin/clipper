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
 
SAVE SCREEN to CHEQUE
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCorCAIXA)
   restore screen from cheque
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCorCAIXA)
   restore screen from cheque
   close all
   return
endif
 
SELECT 3
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A,FLAYGR_B
ELSE
   quemtrava("BANCO")
   setcolor(cCorCaixa)
   RESTORE SCREEN FROM CHEQUE
   close all
   return
endif
 
SELECT 4
IF NETUSE("debito",.F.,10)
   SET INDEX TO FLYDE_A,FLYde_B,FLYde_C,FLYde_D,FLYde_E,FLYDE_F
ELSE
   quemtrava("DEBITO")
   setcolor(cCorCaixa)
   RESTORE SCREEN FROM CHEQUE
   close all
   return
endif
 
SELECT 5
IF NETUSE("credito",.F.,10)
   SET INDEX TO FLYCR_A,FLYcr_B,FLYcr_C,FLYcr_D,FLYcr_E,FLYCR_F
ELSE
   quemtrava("CREDITO")
   setcolor(cCorCaixa)
   RESTORE SCREEN FROM CHEQUE
   close all
   return
endif
 
declare CAMPOS[7],CABEC[7],CHAVE[7]
 
ordem      = 1
select banco
CAMPOS[ 1]  = "CODIGO"
CAMPOS[ 2]  = "CONTA"
CAMPOS[ 3]  = "BANCO"
CAMPOS[ 4]  = "SALDO"
CAMPOS[ 5]  = "APLICA"
CAMPOS[ 6]  = "RESGATA"
CAMPOS[ 7]  = "TOTAL"
 
CABEC[ 1] = "C¢digo"
CABEC[ 2] = "N§ da Conta"
CABEC[ 3] = "Banco"
CABEC[ 4] = "Saldo inicial"
CABEC[ 5] = "Aplica‡„o"
CABEC[ 6] = "Resgate"
CABEC[ 7] = "Valor Aplicado"
 
CHAVE[1] = "C¢digo"
CHAVE[2] = "Banco"
 
go top
 
aOpcRel := {{05,06," APLICA  ",""},;
           {07,06," RESGATA ",""}}
L1 =  2
C1 =  0
L2 = 21
C2 = 79
 
TITULO1 = "Dados"
TITULO2 = "Mensagens"
TITULO3 = "Dados Bancarios"
 
cFileName := alias()
IF empty(cFileName)
   RETURN nil
ENDIF
 
nT := 2
nL := 0
nB := 21
nR := 79
 
nThumbpos := nT+3
cPrevScr := savescreen(nT, nL, nB, nR)
 
lScrlBar := if(lastrec() > nB-nT-2,.T.,.F.)
OtBoBJ := tbrowsedb(nT+1,nL+1,nB-1,nR-1)
 
FOR I := 1 TO 7
    oNewCol := tbcolumnNew(Cabec[i],fieldblock( Campos[i]) )
    oTbObj:addColumn(oNewCol)
NEXT
 
oTbObj:HeadSep := "   "
oTbObj:ColSep := chr(32)+chr(179)+chr(32)
 
 
setcolor(cCorJanela)
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
      IF .NOT. EMPTY(CHAVE[1])
         centracl(00,1,79,titulo3,CcORSERV)
      ENDIF
     centra(24,"Pressione [ALT+H] Para Ajuda")
   ENDDO
   nRow := row()
   nCol := col()
   setpos(nRow,nCol)
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
          mensagemT("Operador n„o autorizado a realizar  esta opera‡„o")
       ENDIF
 
   ELSEIF nKey = -3
       nApre := SETCURSOR(1)
       cCor := setcolor(cCorPadra)
       rec := recno()
       SAVE SCREEN TO PROD
       SELECT banco
       SET ORDER TO 1
       REC=RECNO()
       GO BOTTOM
       VCOD = VAL(CODIGO) + 1
       SKIP
       VCODIGO = STRZERO(VCOD,2)
       vconta  = space(8)
       vbanco  = space(15)
       vsaldo  = 0
       SEGUE   = ' '
       OK      = ' '
       DO WHILE SEGUE <> 'N'
          sombra(15,30,20,75)
          centracl(15,30,75,"Cadastro banc rio")
          @ 16,32 SAY "C¢digo.:                                   "
          @ 17,32 SAY "N£mero da conta :                          "
          @ 18,32 SAY "Banco:                                     "
          @ 19,32 SAY "Saldo.:                                    "
          IF OK = 'S'
             GO BOTTOM
             VCOD = VAL(CODIGO) + 1
             SKIP
             VCODIGO = STRZERO(VCOD,2)
             Vconta  = space(8)
             Vbanco  = space(15)
             Vsaldo  = 0
          ENDIF
          @ 16,41 GET VCODIGO PICT "99" VALID !EMPTY(VCODIGO) .AND. !dbseek(VCODIGO)
          @ 17,50 GET Vconta
          @ 18,39 GET Vbanco PICT "@!"
          @ 19,40 GET Vsaldo  pict '999,999,999.99'
          READ
          IF LASTKEY() = 27
             EXIT
          ENDIF
          IF confirma("Confirma a Opera‡„o ?",cCorCaixa)
             OK = 'S'
             if addrec(1)
                REPLACE     codigo WITH Vcodigo,;
                            conta WITH Vconta,;
                            banco WITH Vbanco,;
                            saldo WITH Vsaldo
                            destrava()
             ELSE
                QUENTRAVA()
             ENDIF
             centra(24,"Ok... Dados Confirmado! Pressione qualquer tecla.")
             INKEY(0)
             SEGUE = "N"
          ELSE
             centra(24,"OK... Dados N„o Confirmado! Pressione qualquer tecla.")
             INKEY(0)
             GO REC
          ENDIF
       ENDDO
       RESTORE SCREEN FROM PROD
       SELECT banco
       SET ORDER TO 2
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = 28
       nApre := setcursor(1)
       cCor := setcolor(cCorPadra)
 
       SAVE SCREEN TO PROD
       SELECT banco
       v_codigo = codigo
       REC=RECNO()
       var1 = 1
       setcolor(ccormenu)
       sombra(04,05,08,16)
       centracl(04,05,16,"Menu")
       var1 := botao(aOpcRel,,cCorBiN,cCorBat)
       if var1 = 1
          v_aplica = 0
          v_total  = 0
          sombra(11,05,13,26,)
          centracl(11,05,26,"Valor Aplicado")
          @ 12,06 get v_aplica pict "9,999,999,999,999.99"
          read
          IF confirma("Confirma a Opera‡„o ?",cCorcaixa)
             if reclock(1)
                replace aplica with aplica + v_aplica
                replace total  with total  + v_aplica
                destrava()
             ELSE
                QUENTRAVA()
             endif
             select debito
             set order to 1
             if addrec(1)
                REPLACE      ORDEM WITH "99999",;
                             VALOR WITH V_aplica,;
                        FORNECEDOR WITH "APLICACAO",;
                              DATA WITH DATE(),;
                            DATVEN WITH DATE(),;
                             banco WITH v_CODIGO,;
                         CANCELADA WITH "C",;
                           DATBAIX WITH date()
                             destrava()
             ELSE
                QUENTRAVA()
             ENDIF
             centra(24,"OK... dados confirmado! Pressione qualquer tecla.")
          ELSE
             centra(24,"OK... dados n„o confirmado! Pressione qualquer tecla.")
          ENDIF
         INKEY(0)
       elseif var1 = 2
          v_resgate= 0
          v_total  = 0
          sombra(11,05,13,26)
          centracl(11,05,26,"Valor Resgatado")
          @ 12,06 get v_resgate pict "9,999,999,999,999.99"
          read
          IF confirma("Confirma  a Opera‡„o ?",cCorCaixa)
             if reclock(1)
                replace resgata with resgata + v_resgate
                replace total   with total   - v_resgate
                destrava()
             ELSE
                QUENTRAVA()
             endif
             select credito
             set order to 1
             if addrec(1)
                REPLACE      ORDEM WITH "99999",;
                             VALOR WITH V_RESGATE,;
                        FORNECEDOR WITH "RESGATE",;
                              DATA WITH DATE(),;
                            DATVEN WITH DATE(),;
                             banco WITH v_CODIGO,;
                         CANCELADA WITH "C",;
                           DATBAIX WITH date()
                             destrava()
             ELSE
                QUENTRAVA()
             ENDIF
             centra(24,"OK... dados confirmado! Pressione qualquer tecla.")
          ELSE
             centra(24,"OK... dados n„o confirmado! Pressione qualquer tecla.")
          ENDIF
          INKEY(0)
       endif
       RESTORE SCREEN FROM PROD
       GO rec
       SELECT banco
       SET ORDER TO 1
       oTbObJ:RefreshAll()
       setcursor(nApre)
       setcolor(cCor)
   ELSEIF nKey = -6
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       SAVE SCREEN TO telacod
       XTEMP = space(2)
       sombra(15,15,17,41)
       centracl(15,15,41,"Consulta por c¢digo")
       @ 16,19 SAY "C¢digo..> " GET XTEMP PICT "@!KX"
       READ
       nRec := recno()
       SET ORDER TO 1 // codigo
       SEEK XTEMP
       IF .NOT. found()
          mensagemT("Codigo N„o encontrado !")
          go nRec
       ENDIF
       RESTORE SCREEN FROM telacod
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = -7
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       SAVE SCREEN TO telacod
       XTEMP = space(15)
       sombra(15,15,17,46)
       CENTRACL(15,15,46,"Consulta Banco")
       @ 16,19 SAY "Banco...> " GET XTEMP PICT "@!KX"
       READ
       nRec := recno()
       SET ORDER TO 2 // numero
       SEEK ALLTRIM(XTEMP)
       IF .NOT. found()
          mensagemT("Codigo N„o encontrado !")
          go nRec
       ENDIF
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
             QUENTRAVA()
          ENDIF
       endif
       oTbObj:RefreshAll()
   ELSEIF nKey = -41
       CALCULAD(15,43,"G")
   ELSEIF nKey = 291
       save screen to help
       cCor := setcolor(cCorCaixa)
       sombra(04,08,14,57)
       centracl(04,08,57,"Teclas de Fun‡”es")
       @ 05,10 say "      F1 - Aplica/Resgata."
       @ 06,10 say "      F4 - Cadastra Banco."
       @ 07,10 say "      F7 - Consulta pelo C¢digo."
       @ 08,10 say "      F8 - Consulta pelo nome do Banco."
       @ 09,10 say "  INSERT - Altera a C‚lula Posicionada."
       @ 10,10 say "  DELETE - Deleta a Linha Posicionada."
       @ 11,10 say "  PAGEup - Rola uma tela p/ cima."
       @ 12,10 say "PAGEdown - Rola uma tela p/ baixo."
       @ 13,10 say CHR(24)+" "+CHR(25)+" "+CHR(26)+" "+CHR(27)+"  - Teclas de Direcionamento da C‚lula."
       centracl(14,08,57,"** Pressione Qualquer Tecla Para Abandonar **")
       inkey(0)
       setcolor(cCor)
       restore screen from help
   ENDIF
ENDDO
setcolor(cCorAnt)
restore screen from CHEQUE
tone( 100,3 )
close ALL
set key 28 to
set inte on
retorna = 0
RETURN NIL
