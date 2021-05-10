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
   restore screen from produto
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCorAnt)
   restore screen from produto
   close all
   return
endif
 
SELECT 3
IF NETUSE("duplicat",.F.,10)
   SET INDEX TO FLYdu_A,FLYdu_B,FLYdu_C,FLYdu_D,FLYdu_E
ELSE
   QUEMTRAVA("DUPLICAT")
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT 4
IF NETUSE("FORNECED",.F.,10)
   SET INDEX TO FORN_A
ELSE
   QUEMTRAVA("FORNECED")
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT 5
IF NETUSE("nota",.F.,10)
   SET INDEX TO FLYNO_A,FLYNO_B,FLYNO_C,FLYNO_D,FLYNO_E,FLYNO_F
ELSE
   QUEMTRAVA("NOTA")
   setcolor(cCorAnt)
   close all
   return
endif
 
declare CAMPOS[11],CABEC[11],CHAVE[11]
 
 
select duplicat
 
CAMPOS[ 1]  = "NUMERO"
CAMPOS[ 2]  = "VALOR"
CAMPOS[ 3]  = "FORNECEDOR"
CAMPOS[ 4]  = "DATA"
CAMPOS[ 5]  = "DATVEN"
CAMPOS[ 6]  = "CANCELADA"
 
CABEC[ 1] = "N£mero"
CABEC[ 2] = "Valor"
CABEC[ 3] = "Hist¢rico"
CABEC[ 4] = "Data"
CABEC[ 5] = "Vencimento"
CABEC[ 6] = "Baixa"
 
CHAVE[1] = "Ordem"
CHAVE[2] = "Hist¢rico"
CHAVE[3] = "Data"
CHAVE[4] = "Vencimento"
CHAVE[5] = "N£mero"
CHAVE[6] = "Baixa"
 
GOTO TOP
 
L1 =  2
C1 =  0
L2 = 21
C2 = 79
 
TITULO1 = "Dados"
TITULO2 = "Mensagens"
TITULO3 = "Arquivo De Duplicatas"
 
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
       SAVE SCREEN TO PROD
       SELECT duplicat
       SET ORDER TO 1
       REC=RECNO()
       GO BOTTOM
       VCOD =(VAL(ORDEM))+ 1
       SKIP
       VORDEM  = STRZERO(VCOD,5)
       SEGUE   = ' '
       VNUMERO     = 0
       VVALOR      = 0
       VFORNECEDOR = SPACE(45)
       VDATA       = DATE()
       VDATVEN     = DATE()
       VCODIGO     = 0
       OK      = ' '
       DO WHILE SEGUE <> 'N'
          select duplicat
          IF OK = 'S'
             GO BOTTOM
             VCOD = VAL(ORDEM) + 1
             SKIP
             VORDEM      = STRZERO(VCOD,5)
             VNUMERO     = 0
             VVALOR      = 0
             VFORNECEDOR = space(45)
             VDATA       = date()
             VDATVEN     = date()
             VCODIGO     = 0
          ENDIF
          SET ORDER TO 5
          GO TOP
          SOMBRA(12,04,18,70)
          CENTRACL(12,04,70,"Cadastro de Duplicata")
          @ 13,06 say "    N£mero..> " GET  VNUMERO pict "99999999"
          READ
          IF LASTKEY() = 27
             EXIT
          ENDIF
          SEEK VNUMERO
          IF FOUND()
             MENSAGEMT("Duplicata j  lan‡ada!")
             LOOP
          ENDIF
          SET ORDER TO 2
          @ 14,06 say "     Valor..> " GET  VVALOR  PICT '9999,999,999.99'
          @ 15,06 say "fornecedor..> " GET  VCODIGO  PICT "99999999";
                VALID PESQFORNE("FORNECED",@VCODIGO,"CODIGO","NOME")
          READ
          SELECT forneced
          SEEK   (VCODIGO)
          IF FOUND()
            @ 15,21 SAY nome
            VFORNECEDOR = nome
          ELSE
              SELECT duplicat
              @ 15,21 GET VFORNECEDOR PICT "@!"
          ENDIF
          SELECT duplicat
          @ 16,06 say "      Data..> " GET VDATA
          @ 17,06 say "Vencimento..> " GET VDATVEN
          READ
          IF VDATVEN < VDATA
             MENSAGEMT("Data de vencimento inv lida.")
             LOOP
          ENDIF
          REC=RECNO()
          IF confirma("Confirma os dados da duplicata ?",cCorcaixa)
             OK = 'S'
             if addrec(5)
                REPLACE      ORDEM WITH VORDEM,;
                            NUMERO WITH VNUMERO,;
                             VALOR WITH VVALOR,;
                        FORNECEDOR WITH VFORNECEDOR,;
                              DATA WITH VDATA,;
                              DATVEN WITH VDATVEN
                             destrava()
             ELSE
                QUENTRAVA()
             ENDIF
             centra(24,"OK... Dados confirmado! Pressione qualquer tecla.")
             inkey(0)
             SEGUE = "N"
          ELSE
             centra(24,"OK... Dados n„o confirmado! Pressione qualquer tecla.")
             INKEY(0)
             GO REC
          ENDIF
       ENDDO
       RESTORE SCREEN FROM PROD
       SELECT duplicat
       SET ORDER TO 2
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = -4
       nApre := setcursor(1)
       cCor := setcolor(cCorPadra)
       SAVE SCREEN TO aa
       vDe := vAte := Date()
       SOMBRA(10,10,15,34)
       CENTRACL(10,10,34,"Soma Duplicata")
       @ 11,12 SAY "De..> " GET VDE  PICT "@!"
       @ 12,12 SAY "At‚.> " GET VATE PICT "@!"
       READ
       rec=recno()
       SELECT DUPLICAT
       SET ORDER TO 4
       SET FILTER TO DATVEN >= VDE .AND. DATVEN <=VATE
       GO TOP
       STORE 0 TO SOMA1
       DO WHILE .NOT. EOF()
          SOMA1 = SOMA1 + VALOR
          @ 14,12 SAY "Total..>"
          @ 14,21 SAY soma1 pict "9,999,999.99"
          skip
       ENDDO
       CENTRA(24,"Soma Totalizada ! <ENTER>")
       INKEY(0)
       set filter to
       set order to 1
       restore screen from AA
       go rec
       setcursor(nApre)
       setcolor(cCor)
       oTbObJ:RefreshAll()
   ELSEIF nKey = -5
       nApre := setcursor(1)
       cCor := setcolor(cCorserv)
       SAVE SCREEN TO telacod
       XTEMP = 0
       sombra(15,15,17,41)
       centracl(15,15,41,"Consulta por N£mero")
       @ 16,19 SAY "N£mero..> " GET XTEMP PICT "99999999"
       READ
       nRec := RecNo()
       SET ORDER TO 5 // numero
       SEEK XTEMP
       IF .NOT. found()
          mensagemT("Numero da duplicata n„o cadastrado !")
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
       CENTRACL(15,15,76,"Consulta Hist¢rico")
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
             QUENTRAVA()
          ENDIF
       endif
       oTbObj:RefreshAll()
   ELSEIF nKey = 98
      cCor := setcolor(cCorPadra)
      nApre:= setcursor(1)
      IF RECLOCK(0)
         SAVE SCREEN TO WER
         V_VALOR = 0
         V_DATVEN= DATE()
 
         A       = 0
         B       = DATE()
 
         V_VALOR = VALOR
         V_DATVEN= DATVEN
 
         V_NUMERO     = 0
         V_FORNECEDOR = SPACE(30)
         V_DATA       = DATE()
 
         V_ORDEM      = ORDEM
         V_NUMERO     = NUMERO
         V_FORNECEDOR = FORNECEDOR
         V_DATA       = DATA
         V_BANCO      = BANCO
         v_cancelada  = cancelada
 
         if v_cancelada = "C"
            do biip
            MensagemT("Duplicata j  Baixada! Verifique.")
            setcolor(cCor)
            setcursor(nApre)
            loop
         endif
         sombra(10,04,13,20)
         centracl(10,04,20,"Dados")
         @ 11,05 GET A PICT '9999,999,999.99' VALID A > 0
         @ 12,12 GET B
         READ
         select nota
         set order to 5
         seek v_numero
         if found()
            V_OK = 'D'
            centra(24,"Nota fiscal Localizada pronta para baixa...")
            nota1 = valor
            nota2 = datven
            select duplicat
            if v_valor = nota1
               centra(24,'Valor Da Nota Fiscal Correto...')
            else
               IF confirma('Valor Incorreto! Deseja Retificar o Valor ?',cCorCaixa)
                  if reclock(0)
                     replace valor with nota1
                  endif
                  centra(24,"Ok... Valor Retificado! Pressione qualquer tecla.")
               ELSE
                  centra(24,"Ok... Valor Nao Retificado! Pressione qualquer tecla.")
               endif
               INKEY(0)
            endif
 
            if v_datven = nota2
               centra(24,"Data Correta...")
            else
               if confirma('Vencimento incorreto! Deseja Retificar.?',cCorCaixa)
                  if reclock(0)
                     REPLACE  datven WITH nota2
                  endif
                  centra(24,"Ok... Vencimento Retificado! Pressione qualquer tecla.")
               ELSE
                  centra(24,"Ok... Vencimento Nao Retificado! Pressione qualquer tecla.")
               endif
               inkey(0)
            endif
         else
            V_OK = ' '
            mensagemT("Nota fiscal N„o Localizada Favor Verificar...")
            select duplicat
         endif
 
         IF confirma("Confirma A baixa da Duplicata ?",cCorcaixa)
           select duplicat
           if reclock(0)
              replace cancelada with "C"
              replace datbaix   with date()
           endif
           IF V_OK = 'D'
              select nota
              if reclock(0)
                 replace cancelada with "C"
                 replace datbaix   with date()
                 destrava()
              endif
           ENDIF
         ENDIF
         restore screen from wer
         destrava()
       ELSE
          QUENTRAVA()
       ENDIF
       select duplicat
       setcursor(nApre)
       setcolor(cCor)
       oTbObj:RefreshAll()
   ELSEIF nKey = 99
      IF RECLOCK(1)
         IF confirma("Retorna Duplicata Baixada ?",cCorCaixa)
            REPLACE CANCELADA WITH " "
            REPLACE DATBAIX   WITH DATE()
            destrava()
            oTbObj:RefreshCurrent()
         ENDIF
       ELSE
         QUENTRAVA()
       ENDIF
   ELSEIF nKey = -41
       CALCULAD(15,43,"G")
   ELSEIF nKey = 291
       save screen to help
       cCor := setcolor(cCorCaixa)
       sombra(05,08,18,57)
       centracl(05,08,57,"Teclas de Fun‡”es")
       @ 06,10 say "   [ b ] - Baixa duplicata."
       @ 07,10 say "   [ c ] - Cancela baixa do duplicata."
       @ 08,10 say "      F4 - Cadastra duplicata."
       @ 09,10 say "      F5 - Soma duplicata."
       @ 10,10 say "      F6 - Consulta pelo n£mero do duplicata."
       @ 11,10 say "      F7 - Consulta pela data de Emiss„o."
       @ 12,10 say "      F8 - Consulta pelo Hist¢rico."
       @ 13,10 say "      F9 - Consulta pelo vencimento."
       @ 14,10 say "  INSERT - Altera a C‚lula Posicionada."
       @ 15,10 say "  DELETE - Deleta a Linha Posicionada."
       @ 16,10 say "  PAGEup - Rola uma tela p/ cima."
       @ 17,10 say "PAGEdown - Rola uma tela p/ baixo."
       @ 18,10 say CHR(24)+" "+CHR(25)+" "+CHR(26)+" "+CHR(27)+"  - Teclas de Direcionamento da C‚lula."
       inkey(0)
       setcolor(cCor)
       restore screen from help
   ENDIF
ENDDO
setcolor(cCorAnt)
restore screen from cheque
tone( 100,3 )
close ALL
set key 28 to
set inte on
retorna = 0
RETURN NIL
