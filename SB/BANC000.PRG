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
 
PUBLIC WORD1, WORD1A, WORD1B, VALORA, NOMEA, NUM_A, ;
       WORD2, WORD2A, WORD2B, VALORB, NOMEB, NUM_B, ;
       WORD3, WORD3A, WORD3B
 
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCorAnt)
   restore screen from CHEQUE
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCorAnt)
   restore screen from CHEQUE
   close all
   return
endif
 
SELECT 3
IF NETUSE("CHEQUE",.F.,10)
   SET INDEX TO FLYch_A,FLYch_B,FLYch_C,FLYch_D,FLYch_E,FLYch_F
ELSE
   quemtrava("CHEQUE")
   RESTORE SCREEN FROM CHEQUE
   setcolor(cCorAnt)
   CLOSE ALL
   return
endif
 
SELECT 4
IF NETUSE("FORNECED",.F.,10)
   SET INDEX TO FORN_A
ELSE
   quemtrava("FORNECED")
   RESTORE SCREEN FROM CEHQUE
   setcolor(cCorAnt)
   CLOSE ALL
   return
endif
 
SELECT 5
IF NETUSE("devoluc",.F.,10)
   SET INDEX TO FLYDO_A,FLYDO_B,FLYDO_C,FLYDO_D,FLYDO_E,FLYDO_F
ELSE
   quemtrava("DEVOLUC")
   RESTORE SCREEN FROM CHEQUE
   setcolor(cCorAnt)
   CLOSE ALL
   return
endif
 
SELECT 6
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   quemtrava("BANCO")
   RESTORE SCREEN FROM CHEQUE
   setcolor(cCorAnt)
   CLOSE ALL
   return
endif
 
declare CAMPOS[11],CABEC[11],TITULO,CHAVE[11],ORDEM
aOpcrel := {{11,17,'BRADESCO',""},;
            {13,17,'BRASIL  ',""},;
            {15,17,'BANESPA ',""},;
            {17,17,'CAIXA   ',""}}
ordem      = 1
nApre := setcursor(1)
CcOR := setcolor(cCorPadra)
SOMBRA(10,10,14,53)
centracl(10,10,53,"Dados do Arqu¡vo",.T.)
v_banco = space(2)
@ 11,12 say    "C¢digo..> " get v_banco pict "@!"
read
IF lastkey() = 27
   setcolor(cCorAnt)
   close databases
   restore screen from cheque
   CLOSE ALL
   return
ENDIF
select BANCO
setcursor(nApre)
set order to 1
seek v_banco
if .not. found()
   mensagemT("Banco n„o cadastrado. Favor conferir...")
   setcolor(cCorAnt)
   close databases
   restore screen from cheque
   return
else
   @ 12,12 say "Banco...> "+banco
   @ 13,12 SAY "C/C.....> "+conta
   vbanco = banco
   vconta = conta
   centra(24, "Pressione Qualquer Tecla p/ Continuar.")
   inkey(0)
endif
setcolor(cCorJanela)
SELECT cheque
SET ORDER TO 2
SET FILTER TO banco = v_banco
GO TOP
 
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
TITULO3 = "Cheques Emitidos Do banco.> "+vBANCO+" C/C N§.> "+vCONTA
 
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
         centracl(00,1,79,titulo3,CCORSERV)
      ENDIF
     centra(24,"Pressione [ALT+H] Para Ajuda")
   ENDDO
   nRow := row()
   nCol := col()
   IF BAIXA = "B"
      @ 21,60 say 'Emitido'
   else
      @ 21,60 say '       '
   endif
   IF CANCELADA = "C"
      @ 21,68 say 'Baixado'
   else
      @ 21,68 say '       '
   endif
   Setpos(nRow,nCol)
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
       SAVE SCREEN TO PROD
       SELECT cheque
       SET ORDER TO 1
       REC=RECNO()
       nApre := SETCURSOR(1)
       cCor := setcolor(cCorPadra)
       GO BOTTOM
       VCOD = VAL(ORDEM) + 1
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
          centra(24,"")
          select cheque
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
          sombra(12,04,18,70)
          centracl(12,04,70,"Cadastro de Cheque")
          @ 13,06 say "    N£mero..> " GET  VNUMERO
          READ
          IF lastkey() = 27
             EXIT
          ENDIF
          SEEK VNUMERO
          IF FOUND()
             MENSAGEMt("Cheque j  lan‡ado.")
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
              @ 15,21 GET VFORNECEDOR PICT "@!"
           ENDIF
          SELECT cheque
          @ 16,06 say "      Data..> " GET VDATA
          @ 17,06 say "Vencimento..> " GET VDATVEN
          READ
          IF VDATVEN < VDATA
             MENSAGEMT("Data de vencimento inv lida.!")
          ENDIF
          IF confirma("Confirma Inclus„o ?",cCorCaixa)
             if addrec(1)
                REPLACE      ORDEM WITH VORDEM,;
                            NUMERO WITH VNUMERO,;
                             VALOR WITH VVALOR,;
                        FORNECEDOR WITH VFORNECEDOR,;
                              DATA WITH VDATA,;
                            DATVEN WITH VDATVEN,;
                             banco WITH V_banco
                             destrava()
             ELSE
                QUENTRAVA()
             ENDIF
             centra(24,"OK... Dados confirmado! Pressione qualquer tecla.")
             inkey(0)
             SEGUE = 'N'
          ELSE
             centra(24,"OK... Dados n„o confirmado! Pressione qualquer tecla.")
             INKEY(0)
             GO REC
          ENDIF
       ENDDO
       RESTORE SCREEN FROM PROD
       SELECT CHEQUE
       SET ORDER TO 2
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = -5
       nApre := setcursor(1)
       cCor := setcolor(cCorserv)
       save screen to telacod
       XTEMP = 0
       sombra(15,15,17,41)
       centracl(15,15,41,"Consulta por N£mero")
       @ 16,19 SAY "N£mero..> " GET XTEMP PICT "99999999"
       READ
       SET ORDER TO 5 // numero
       REC := RECNO()
       SEEK XTEMP
       IF .NOT. found()
          mensagemT("Numero de cheque n„o cadastrado!!")
          go Rec
       ENDIF
       RESTORE SCREEN FROM telacod
       setcursor(nApre)
       setcolor(cCor)
       oTbObj:RefreshAll()
   ELSEIF nKey = -6
       save screen to teladesc
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       XTEMP = date()
       sombra(15,15,17,41)
       centracl(15,15,41,"Consulta por Data")
       @ 16,19 SAY "data....> " GET XTEMP
       READ
       SET ORDER TO 3 // numero
       SET SOFTSEEK ON
       SEEK XTEMP
       SET SOFTSEEK OFF
       setcolor(cCor)
       restore screen from teladesc
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = -7
       save screen to teladesc
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       XTEMP = space(45)
       sombra(15,15,17,76)
       centracl(15,15,76,"Consulta Hist¢rico")
       @ 16,19 SAY "Dados...> " GET XTEMP PICT "@!KX"
       READ
       SET ORDER TO 2 // historico
       SET SOFTSEEK ON
       SEEK ALLTRIM(XTEMP)
       SET SOFTSEEK OFF
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = -8
       save screen to teladesc
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       XTEMP = date()
       sombra(15,15,17,40)
       centracl(15,15,40,"Consulta Vencimento")
       @ 16,19 SAY "Data....> " GET XTEMP
       READ
       SET ORDER TO 4 // vencimento
       SET SOFTSEEK ON
       SEEK XTEMP
       SET SOFTSEEK OFF
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
   ELSEIF nKey = 7
          IF reclock(1)
             IF Confirma({"Deseja REALMENTE Excluir o registro",;
                          "Selecionado ?"},cCorCaixa)
                delete
                commit
             endif
          else
             quentrava()
          ENDIF
          oTbObj:RefreshAll()
   ELSEIF nKey = 112
       cCor := setcolor(cCorPadra)
       nApre := setcursor(1)
       SAVE SCREEN TO ALTE
       SELECT CHEQUE
       CRIOU   = .F.
       VLOCAL  = SPACE(15)
       VLOCAL  = VDADOS3
       VNOMIN  = SPACE(1)
       VPREDA  = SPACE(1)
       VDATA   = DATE()
       SEGUE   = SPACE(1)
       sombra(08,11,16,56)
       centracl(08,11,56,"Emiss„o de cheque")
       @ 09,13 SAY 'Cheque nominal :        (S/N).           '
       @ 11,13 SAY 'Pr‚-datado:      (S/N).                  '
       @ 13,13 SAY 'Local...:                                '
       @ 15,13 SAY 'Data....:                                '
       @ 09,32 GET VNOMIN  PICT "!" VALID VNOMIN $ 'SN'
       @ 11,26 GET VPREDA  PICT "!" VALID VPREDA $ 'SN'
       @ 13,23 GET VLOCAL
       @ 15,23 GET VDATA
       READ
       VAR1 = 1
       setcolor(cCormenu)
       sombra(10,16,18,26)
       centracl(10,16,26,"Banco")
       VAR1 := botao(aOpcRel,,cCorBin,cCorBAt)
       IF confirma("Confirma a Impress„o ?",cCorCaixa)
          mensagem("verifique a Impressora !",cCorcaixa)
          IF .NOT. isprinter()
              mensagem("A impressora nao pode estar pronta !",cCorcaixa)
          ELSE
             SET CONSOLE OFF
             SET DEVICE TO PRINT
             SET PRINT ON
             ?? CHR(27) + "0"
             ?? CHR(27) + "C" + CHR(24)
             SET PRINT OFF
             SETPRC(0,0)          &&   INICIALIZA LINHA=0 COL=0
             IF VAR1 == 1
                VDATAPIC  =   EXTDATA(VDATA)
                LEGAL = SETCOLOR()
                DATA_X =  VLOCAL +", "+ VDATAPIC
                DATA_A =  DATA_X
                VALOR_TMP = 0
                VALOR_TMP = VALOR
                EXTENDA(VALOR_TMP)
                VALORA    =   STRPIC(VALOR,14,2)
                WORD1A    =   WORD1
                WORD2A    =   WORD2
                WORD3A    =   WORD3
                IF VNOMIN = "S" .OR. VNOMIN = "S"
                   NOMEA  =   FORNECEDOR
                ELSE
                   NOMEA  =  SPACE(30)
                ENDIF
                DATA_A    =   DATA_X
                CRIOU = .T.
                @  00,  51 SAY '***'+LTRIM(VALORA)+'***'
                @  00,  51 SAY '***'+LTRIM(VALORA)+'***'
                @  03,  11 SAY WORD1A
                @  05,  04 SAY WORD2A
                @  06,  07 SAY WORD3A
                @  07,  04 SAY NOMEA
                @  09,  26 SAY DATA_A
                IF VPREDA = "S" .OR. VPREDA = "S"
                   @  19,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  19,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  19,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                ENDIF
                IF RECLOCK(0)
                   REPLACE BAIXA WITH 'B'
                   COMMIT
                   destrava()
                ENDIF
             ELSEIF VAR1 == 2
                VDATAPIC  =   EXTDATA(VDATA)
                LEGAL = SETCOLOR()
                DATA_X =  VLOCAL +", "+ VDATAPIC
                DATA_A =  DATA_X
                VALOR_TMP = 0
                VALOR_TMP = VALOR
                DO EXTENDA WITH VALOR_TMP
                VALORA    =   STRPIC(VALOR,14,2)
                WORD1A    =   WORD1
                WORD2A    =   WORD2
                WORD3A    =   WORD3
                IF VNOMIN = "S" .OR. VNOMIN = "S"
                   NOMEA  =   FORNECEDOR
                ELSE
                   NOMEA  =  SPACE(30)
                ENDIF
                DATA_A    =   DATA_X
                CRIOU = .T.
                @  00,  51 SAY '***'+LTRIM(VALORA)+'***'
                @  00,  51 SAY '***'+LTRIM(VALORA)+'***'
                @  03,  14 SAY WORD1A
                @  05,  06 SAY WORD2A
                @  06,  06 SAY WORD3A
                @  07,  06 SAY NOMEA
                @  09,  30 SAY DATA_A
                IF VPREDA = "S" .OR. VPREDA = "S"
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                ENDIF
                IF RECLOCK(0)
                   REPLACE BAIXA WITH 'B'
                   COMMIT
                   destrava()
                ENDIF
             ELSEIF VAR1 == 3
                VDATAPIC  =   EXTDATA(VDATA)
                LEGAL = SETCOLOR()
                DATA_X =  VLOCAL +", "+ VDATAPIC
                DATA_A =  DATA_X
                VALOR_TMP = 0
                VALOR_TMP = VALOR
                DO EXTENDA WITH VALOR_TMP
                VALORA    =   STRPIC(VALOR,14,2)
                WORD1A    =   WORD1
                WORD2A    =   WORD2
                WORD3A    =   WORD3
                IF VNOMIN = "S" .OR. VNOMIN = "S"
                   NOMEA  =   FORNECEDOR
                ELSE
                   NOMEA  =  SPACE(30)
                ENDIF
                DATA_A    =   DATA_X
                CRIOU = .T.
                @  00,  51 SAY '***'+LTRIM(VALORA)+'***'
                @  00,  51 SAY '***'+LTRIM(VALORA)+'***'
                @  02,  17 SAY WORD1A
                @  04,  09 SAY WORD2A
                @  05,  09 SAY WORD3A
                @  06,  09 SAY NOMEA
                @  08,  29 SAY DATA_A
                IF VPREDA = "S" .OR. VPREDA = "S"
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                ENDIF
                IF RECLOCK(0)
                   REPLACE BAIXA WITH 'B'
                   COMMIT
                   destrava()
                ENDIF
             ELSEIF VAR1 == 4
                VDATAPIC  =   EXTDATA(VDATA)
                LEGAL = SETCOLOR()
                DATA_X =  VLOCAL +", "+ VDATAPIC
                DATA_A =  DATA_X
                VALOR_TMP = 0
                VALOR_TMP = VALOR
                DO EXTENDA WITH VALOR_TMP
                VALORA    =   STRPIC(VALOR,14,2)
                WORD1A    =   WORD1
                WORD2A    =   WORD2
                WORD3A    =   WORD3
                IF VNOMIN = "S" .OR. VNOMIN = "S"
                   NOMEA  =   FORNECEDOR
                ELSE
                   NOMEA  =  SPACE(30)
                ENDIF
                DATA_A    =   DATA_X
                CRIOU = .T.
                @  00,  55 SAY '***'+LTRIM(VALORA)+'***'
                @  00,  55 SAY '***'+LTRIM(VALORA)+'***'
                @  02,  11 SAY WORD1A
                @  04,  04 SAY WORD2A
                @  05,  07 SAY WORD3A
                @  06,  04 SAY NOMEA
                @  08,  23 SAY DATA_A
                IF VPREDA = "S" .OR. VPREDA = "S"
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   @  17,  50 SAY 'PARA O DIA: '+DTOC(DATVEN)
                ENDIF
                IF RECLOCK(0)
                   REPLACE BAIXA WITH 'B'
                   COMMIT
                   destrava()
                ENDIF
             ENDIF
             SET PRINT ON
             @ 0, 0 SAY ""
             ?? CHR(27) + "1"
             ?? CHR(27)+CHR(67)
             SET PRINT OFF
             DECISAO = 100
          ENDIF
       ENDIF
       SET CONSOLE ON
       SET DEVICE TO SCREEN
       RESTORE SCREEN FROM ALTE
       setcursor(nApre)
       setcolor(cCor)
   ELSEIF nKey = 98
       IF RECLOCK(1)
          SAVE SCREEN TO WER
          nApre := SETCURSOR(1)
          cCor := setcolor(cCorPadra)
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
             biip()
             MensagemT("Cheque j  baixado! Verifique.")
             setcolor(cCor)
             setcursor(nApre)
             loop
          endif
          sombra(10,04,13,20)
          centracl(10,04,20,"Dados")
          @ 11,05 GET A PICT '9999,999,999.99' VALID A > 0
          @ 12,12 GET B
          READ
          IF V_VALOR = A
             centra(24,'Valor Correto...')
          ELSE
             IF confirma('Valor incorreto! Deseja retificar o valor. ?',cCorCaixa)
                REPLACE VALOR WITH A
                centra(24,"Ok... Valor retificado! Pressione uma tecla.")
             ELSE
                centra(24,"Ok... Valor n„o retificado! Pressione uma tecla.")
             ENDIF
             inkey(0)
          ENDIF
          IF B >= V_DATVEN
             centra(24,'Data correta...')
          ELSE
             IF confirma('Data incorreta! Deseja fazer devolu‡„o. ?',cCorcaixa)
                SELECT DEVOLUC
                IF ADDREC(5)
                   REPLACE      ORDEM WITH V_ORDEM,;
                               NUMERO WITH V_NUMERO,;
                                VALOR WITH V_VALOR,;
                           FORNECEDOR WITH V_FORNECEDOR,;
                                 DATA WITH V_DATA,;
                                BANCO WITH V_BANCO,;
                               DATVEN WITH V_DATVEN,;
                               DATBAIX WITH B,;
                               CANCELADA WITH 'C'
                               COMMIT
                               destrava()
 
                   SELECT CHEQUE
                   centra(24,"OK... Devolu‡„o arquivada! Pressione uma tecla.")
                ELSE
                   QUENTRAVA()
                ENDIF
             ELSE
                centra(24,"OK... Devolucao n„o arquivada! Pressione uma tecla.")
             ENDIF
             inkey(0)
          ENDIF
          IF confirma("Confirma a Baixa do Arquivo ?",cCorCaixa)
             REPLACE CANCELADA WITH "C"
             REPLACE DATBAIX   WITH B
             COMMIT
             destrava()
          ENDIF
          RESTORE SCREEN FROM WER
          setcolor(cCor)
          setcursor(nApre)
          oTbObj:RefreshAll()
       ELSE
          QUENTRAVA()
       ENDIF
   ELSEIF nkey = 99
       IF RECLOCK(5)
          IF confirma("Retorna o Arquivo Baixado ?",cCorCaixa)
            REPLACE CANCELADA WITH " "
            REPLACE DATBAIX   WITH DATE()
            destrava()
          ENDIF
       ELSE
          QUENTRAVA()
       ENDIF
       oTbObj:RefreshCurrent()
   ELSEIF nKey = -41
       CALCULAD(15,43,"G")
   ELSEIF nKey = 291
       save screen to help
       cCor := setcolor(cCorCaixa)
       sombra(04,08,18,57)
       centracl(04,08,57,"Teclas de Fun‡”es")
       @ 05,10 say "   [ p ] - Gera cheque na impressora."
       @ 06,10 say "   [ b ] - Baixa o Cheque."
       @ 07,10 say "   [ c ] - Cancela baixa do cheque."
       @ 08,10 say "      F4 - Cadastra cheque."
       @ 09,10 say "      F6 - Consulta pelo n£mero do Cheque."
       @ 10,10 say "      F7 - Consulta pela data de Emiss„o."
       @ 11,10 say "      F8 - Consulta pelo Hist¢rico."
       @ 12,10 say "      F9 - Consulta pelo vencimento."
       @ 13,10 say "  INSERT - Altera a C‚lula Posicionada."
       @ 14,10 say "  DELETE - Deleta a Linha Posicionada."
       @ 15,10 say "  PAGEup - Rola uma tela p/ cima."
       @ 16,10 say "PAGEdown - Rola uma tela p/ baixo."
       @ 17,10 say CHR(24)+" "+CHR(25)+" "+CHR(26)+" "+CHR(27)+"  - Teclas de Direcionamento da C‚lula."
       centracl(18,08,57,"** Pressione Qualquer Tecla Para Abandonar **")
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