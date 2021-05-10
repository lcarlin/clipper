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
PUBLIC WORD1, WORD1A, WORD1B, VALORA, NOMEA, NUM_A, ;
       WORD2, WORD2A, WORD2B, VALORB, NOMEB, NUM_B, ;
       WORD3, WORD3A, WORD3B
SAVE SCREEN to CHEQUE
 
declare CAMPOS[8],CABEC[8],CHAVE[8]
 
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
 
select 3
IF NETUSE("nota",.F.,10)
   SET INDEX TO FLYNO_A,FLYNO_B,FLYNO_C,FLYNO_D,FLYNO_E,FLYNO_F
ELSE
   QUEMTRAVA("NOTA")
   setcolor(cCorAnt)
   restore screen from CHEQUE
   close all
   return
endif
 
SELECT 4
IF NETUSE("duplicat",.F.,10)
   SET INDEX TO FLYdu_A,FLYdu_B,FLYdu_C,FLYdu_D,FLYdu_E,FLYdu_F
ELSE
   QUEMTRAVA("DUPLICAT")
   setcolor(cCorAnt)
   restore screen from CHEQUE
   close all
   return
endif
 
SELECT 5
IF NETUSE("FORNECED",.F.,10)
   SET INDEX TO FORN_A
ELSE
   QUEMTRAVA("FORNECEDOR")
   setcolor(cCorAnt)
   restore screen from CHEQUE
   close all
   return
endif
 
SELECT 6
IF NETUSE("CHEQUE",.F.,10)
   SET INDEX TO FLYch_A,FLYch_B,FLYch_C,FLYch_D,FLYch_E,FLYch_F
ELSE
   QUEMTRAVA("CHEQUE")
   setcolor(cCorAnt)
   restore screen from CHEQUE
   close all
   return
endif
 
SELECT 7
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   QUEMTRAVA("BANCO")
   setcolor(cCorAnt)
   restore screen from CHEQUE
   close all
   return
endif
 
CAMPOS[ 1]  = "NUMERO"
CAMPOS[ 2]  = "VALOR"
CAMPOS[ 3]  = "CREDITO"
CAMPOS[ 4]  = "FORNECEDOR"
CAMPOS[ 5]  = "DATA"
CAMPOS[ 6]  = "DATent"
CAMPOS[ 7]  = "datven"
CAMPOS[ 8]  = "CANCELADA"
 
CABEC[ 1] = "N£mero"
CABEC[ 2] = "Valor"
CABEC[ 3] = "Cr‚dito ICMS"
CABEC[ 4] = "Hist¢rico"
CABEC[ 5] = "Data"
CABEC[ 6] = "Chegada"
CABEC[ 7] = "Vencimento"
CABEC[ 8] = "Baixa"
 
CHAVE[1] = "Ordem"
CHAVE[2] = "Hist¢rico"
CHAVE[3] = "Data"
CHAVE[4] = "Vencimento"
CHAVE[5] = "N£mero"
CHAVE[6] = "Entrada"
 
GOTO TOP
 
L1 =  2
C1 =  0
L2 = 21
C2 = 79
 
TITULO1 = "Dados"
TITULO2 = "Mensagens"
TITULO3 = "Arquivo de Notas Fiscais"
 
aOpcSoma := {{08,33," ENTRADA    "},;
             {10,33," EMISSAO    "},;
             {12,33," VENCIMENTO "}}
 
aOpcRel := {{17,06," CARTEIRA  "},;
            {19,06," CHEQUE    "},;
            {21,06," DUPLICATA "}}
 
nT := 2
nL := 0
nB := 21
nR := 79
 
nThumbpos := nT+3
cPrevScr := savescreen(nT, nL, nB, nR)
 
lScrlBar := if(lastrec() > nB-nT-2,.T.,.F.)
OtBoBJ := tbrowsedb(nT+1,nL+1,nB-1,nR-1)
 
FOR I := 1 TO 8
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
 
SELECT nota
GOTO TOP
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
       nApre := SETCURSOR(1)
       cCor := setcolor(cCorPadra)
       SAVE SCREEN TO PROD
       SELECT nota
       SET ORDER TO 1
       REC = RECNO()
       GO BOTTOM
       VCOD = VAL(ORDEM) + 1
       SKIP
       VORDEM  = STRZERO(VCOD,5)
       SEGUE   = ' '
       VNUMERO     = 0
       VVALOR      = 0
       VCREDITO    = 0
       VFORNECEDOR = SPACE(45)
       VDATA       = DATE()
       VDATVEN     = DATE()
       VDATent     = DATE()
       VCODIGO     = 0
       OK      = ' '
       DO WHILE SEGUE <> 'N'
          select nota
          IF OK = 'S'
             GO BOTTOM
             VCOD = VAL(ORDEM) + 1
             SKIP
             VORDEM      := STRZERO(VCOD,5)
             VNUMERO     := 0
             VVALOR      := 0
             VCREDITO    := 0
             VFORNECEDOR := space(45)
             VNOMEA      := space(30)
             VDATA       := date()
             VDATVEN     := date()
             VDATent     := date()
             VCODIGO     := 0
          ENDIF
          SET ORDER TO 5
          GO TOP
          SOMBRA(04,04,17,65)
          centracl(04,04,65,"Cadastro de Notas")
          @ 05,05 say "Numero.......>"
          @ 07,05 say "Fornecedor...>"
          @ 08,05 say "Razao Social.>"
          @ 09,05 say "Fantasia.....>"
          @ 11,05 say "Valor........>"
          @ 12,05 say "Credito Icms.>"
          @ 14,05 say "Data de Entrada....>"
          @ 15,05 say "Data de Saida......>"
          @ 16,05 say "Data de Vencimento.>"
          @ 05,20 GET  VNUMERO pict "99999999"
          READ
          IF LASTKEY() = 27
             EXIT
          ENDIF
          cCorTE := setcolor(cCorPadra)
          SEEK VNUMERO
          IF FOUND()
             MENSAGEMT("Nota j  lan‡ada!")
             LOOP
          ENDIF
          SET ORDER TO 2
          @ 07,20 GET  VCODIGO  PICT "99999999";
                VALID PESQFORNE("FORNECED",@VCODIGO,"CODIGO","NOME")
          READ
          SELECT forneced
          SEEK   (VCODIGO)
          IF FOUND()
            @ 08,20 SAY nome
            @ 09,20 SAY fantasia
            VFORNECEDOR = nome
          ELSE
              SELECT nota
              @ 07,20 GET VFORNECEDOR PICT "@!"
           ENDIF
          SELECT nota
          @ 11,20 GET VVALOR   PICT '9999,999,999.99'
          @ 12,20 get Vcredito PICT '9999,999,999.99'
          @ 14,26 GET VDATA
          @ 15,26 GET VDATent
          @ 16,26 GET VDATVEN
          READ
          IF VDATVEN < VDATA
             MENSAGEMT("Data de vencimento inv lida!")
             LOOP
          ENDIF
          IF confirma("Confirma a Opera‡„o ?",cCorCaixa)
             OK = 'S'
             if addrec(1)
                REPLACE      ORDEM WITH VORDEM,;
                            NUMERO WITH VNUMERO,;
                             VALOR WITH VVALOR,;
                           CREDITO WITH VCREDITO,;
                        FORNECEDOR WITH VFORNECEDOR,;
                              DATA WITH VDATA,;
                            DATVEN WITH VDATVEN,;
                            DATent WITH VDATent
                             destrava()
             ELSE
                QUENTRAVA()
             ENDIF
             centra(24,"OK... Dados confirmado! Pressione qualquer tecla.")
             inkey(0)
             setcolor(ccormenu)
             SOMBRA(16,05,22,18)
             centracl(16,05,18,"Opcao")
             vAr1 := Botao(aOpcRel,,cCorBin,cCorBat)
             if var1 = 1
                select nota
                go rec
                if reclock(0)
                  REPLACE CANCELADA WITH "C"
                  REPLACE DATBAIX   WITH date()
                  destrava()
                ENDIF
             elseif var1 = 2
                setcolor(cCorServ)
                SOMBRA(04,04,15,72)
                CENTRACL(04,04,72,"Cadastro do Cheque")
                @ 05,05 SAY " Banco n§                    Cheque n§          R$                "
                @ 06,05 SAY " Qto de :                                                         "
                @ 07,05 SAY "                                                                  "
                @ 08,05 SAY "                                                                  "
                @ 09,05 SAY " a                                                                "
                @ 11,05 SAY "                                                                  "
                @ 12,05 SAY "                          ________________________________________"
                @ 13,05 SAY "                                                                  "
                @ 14,05 SAY "                          CGC                                     "
                SETCOLOR("W+/G")
                SOMBRA(11,06,14,18)
                @ 12,07 SAY "  Tec Maq  "
                @ 13,07 SAY "Informatica"
                vnum := 0
                vbanco  = SPACE(2)
                select BANCO
                set order to 1
                @ 05,15 get vbanco VALID !EMPTY(VBANCO)
                READ
                seek vbanco
                if found()
                   @ 05,20 SAY conta
                endif
                @ 05,44 get vnum pict "99999999"
                READ
                VDATAPIC  =   EXTDATA(VDATA)
                DATA_X =  VDADOS3 +", "+ VDATAPIC
                DATA_A =  DATA_X
                VALOR_TMP = 0
                VALOR_TMP = VVALOR
                DO EXTENDA WITH VALOR_TMP
                VALORA    =   STRPIC(VVALOR,14,2)
                WORD1A    =   WORD1
                WORD2A    =   WORD2
                WORD3A    =   WORD3
                NOMEA     =   VFORNECEDOR
                DATA_A    =   DATA_X
                CRIOU = .T.
                @  05,  56 SAY '***'+LTRIM(VALORA)+'***'
                @  06,  15 SAY WORD1A
                @  07,  06 SAY WORD2A
                @  08,  06 SAY WORD3A
                @  11,  26 SAY DATA_A
                @  13,  31 SAY VDADOS1
                @  14,  31 SAY VDADOS4
                IF VDATVEN > VDATA
                   @  16,51 SAY 'PARA O DIA: '
                   @  16,63 SAY VDATVEN
                ENDIF
                @  09,  06 GET NOMEA PICT "@!"
                READ
                select CHEQUE
                if addrec(1)
                   replace  NUMERO WITH VNUM,;
                             VALOR WITH VVALOR,;
                        FORNECEDOR WITH NOMEA,;
                              DATA WITH VDATA,;
                            DATVEN WITH VDATVEN,;
                             COD   WITH VCODIGO,;
                             banco WITH Vbanco,;
                             BAIXA WITH 'B'
                   destrava()
                ELSE
                   QUENTRAVA()
                ENDIF
                if confirma("Imprime Cheque ?",cCorCaixa)
                   VOP = ' '
                   if confirma("Cheque Nominal ?",cCorCaixa)
                      vop = 'S'
                   ELSE
                      VOP = 'N'
                   ENDIF
                   mensagem("Verifique a Impressora !!",cCorCaixa)
                   IF .NOT. isprinter()
                      mensagem("Impressora Nao Preparada !!",cCorCaixa)
                      SETCOLOR(CCORTE)
                      loop
                      EXIT
                   ENDIF
                   VDATAPIC  =   EXTDATA(VDATA)
                   LEGAL = SETCOLOR()
                   DATA_X =  VDADOS3 +", "+ VDATAPIC
                   DATA_A =  DATA_X
                   SET CONSOLE OFF
                   SET PRINT ON
                   ?? CHR(27) + "0"
                   ?? CHR(27) + "C" + CHR(24)
                   SET PRINT OFF
                   SET CONSOLE ON
                   SETPRC(0,0)          &&   INICIALIZA LINHA=0 COL=0
                   SET DEVICE TO PRINT
                   VALOR_TMP = 0
                   VALOR_TMP = VVALOR
                   DO EXTENDA WITH VALOR_TMP
                   VALORA    =   STRPIC(VVALOR,14,2)
                   WORD1A    =   WORD1
                   WORD2A    =   WORD2
                   WORD3A    =   WORD3
                   IF VOP = "S"
                      VNOMEA  =   NOMEA
                   ELSE
                      VNOMEA  =  SPACE(30)
                   ENDIF
                   DATA_A    =   DATA_X
                   CRIOU = .T.
                   @  00,  53 SAY '***'+LTRIM(VALORA)+'***'
                   @  00,  53 SAY '***'+LTRIM(VALORA)+'***'
                   @  02,  11 SAY WORD1A
                   @  04,  04 SAY WORD2A
                   @  05,  07 SAY WORD3A
                   @  06,  04 SAY VNOMEA
                   @  08,  22 SAY DATA_A
                   IF VDATVEN > VDATA
                      @  17,  48 SAY 'PARA O DIA: '+DTOC(DATVEN)
                      @  17,  48 SAY 'PARA O DIA: '+DTOC(DATVEN)
                      @  17,  48 SAY 'PARA O DIA: '+DTOC(DATVEN)
                   ENDIF
                   @ 0, 0 SAY ""
                   SET CONSOLE OFF
                   SET PRINT ON
                   ?? CHR(27) + "C" + CHR(66)
                   SET PRINT OFF
                   SET CONSOLE ON
                   SET DEVICE TO SCREEN
                ELSEIF var1 = 2
                   centra(24,"Ok! Cheque Arquivado!")
                   inkey(0)
                endif
                SELECT nota
                go rec
                if reclock(0)
                  REPLACE CANCELADA WITH "C"
                  REPLACE DATBAIX   WITH date()
                  destrava()
                ENDIF
             elseif var1 = 3
                select DUPLICAT
                if addrec(1)
                   REPLACE ORDEM      WITH VORDEM
                   REPLACE NUMERO     WITH VNUMERO
                   REPLACE VALOR      WITH VVALOR
                   REPLACE FORNECEDOR WITH VFORNECEDOR
                   REPLACE DATA       WITH VDATA
                   REPLACE DATVEN     WITH VDATVEN
                   REPLACE cod        WITH Vcodigo
                   destrava()
                ELSE
                   QUENTRAVA()
                ENDIF
                centra(24,"Ok..! Duplicata arquivada....")
                inkey(0)
             endif
             SEGUE = "N"
          ELSE
             centra(24,"OK... Dados n„o confirmado! Pressione qualquer tecla.")
             INKEY(0)
             GO REC
          ENDIF
       ENDDO
       RESTORE SCREEN FROM PROD
       SELECT nota
       SET ORDER TO 2
       setcolor(cCor)
       setcursor(nApre)
       oTbObj:RefreshAll()
 
   ELSEIF nKey = -4
       nApre := setcursor(1)
       cCor := setcolor(cCorPadra)
       SAVE SCREEN TO aa
       vDe := vAte := date()
       sombra(10,02,16,26)
       centracl(10,02,26,"Soma nota")
       @ 11,04 SAY "De..> " GET VDE  PICT "@!"
       @ 12,04 SAY "At‚.> " GET VATE PICT "@!"
       READ
       setcolor(ccormenu)
       sombra(07,32,13,46)
       centracl(07,32,46,"Menu")
       VAR1 = 0
       VAR1 := botao(aOpcSoma,,cCorBin,cCorBat)
       IF VAR1 == 1
          rec=recno()
          SELECT NOTA
          SET ORDER TO 6
          SET FILTER TO DATENT >= VDE .AND. DATENT <=VATE
          STORE 0 TO SOMA1,SOMA2
          DO WHILE .NOT. EOF()
             SOMA1 = SOMA1 + VALOR
             SOMA2 = SOMA2 + credito
             @ 14,04 SAY "Total..>"
             @ 15,04 SAY "ICMS...>"
             @ 14,13 SAY soma1 pict "9,999,999.99"
             @ 15,13 SAY soma2 pict "9,999,999.99"
             skip
          enddo
       ELSEIF VAR1 == 2
          rec=recno()
          SELECT NOTA
          SET ORDER TO 3
          SET FILTER TO DATA >= VDE .AND. DATA <=VATE
          STORE 0 TO SOMA1,SOMA2
          DO WHILE .NOT. EOF()
             SOMA1 = SOMA1 + VALOR
             SOMA2 = SOMA2 + CREDITO
             @ 14,04 SAY "Total..>"
             @ 15,04 SAY "ICMS...>"
             @ 14,13 SAY soma1 pict "9,999,999.99"
             @ 15,13 SAY soma2 pict "9,999,999.99"
             skip
          enddo
       ELSEIF VAR1 == 3
          rec=recno()
          SELECT NOTA
          SET ORDER TO 4
          SET FILTER TO DATVEN >= VDE .AND. DATVEN <=VATE
          STORE 0 TO SOMA1,SOMA2
          DO WHILE .NOT. EOF()
             SOMA1 = SOMA1 + VALOR
             SOMA2 = SOMA2 + CREDITO
             @ 14,04 SAY "Total..>"
             @ 15,04 SAY "ICMS...>"
             @ 14,13 SAY soma1 pict "9,999,999.99"
             @ 15,13 SAY soma2 pict "9,999,999.99"
             skip
          enddo
       ENDIF
       MENSAGEM("Soma Totalizada !",cCorCaixa)
       set filter to
       set order to 1
       restore screen from AA
       go rec
       oTbObJ:RefreshAll()
       setcursor(nApre)
       setcolor(cCor)
   ELSEIF nKey = -5
       nApre := setcursor(1)
       cCor := setcolor(cCorserv)
       SAVE SCREEN TO telacod
       XTEMP = 0
       sombra(15,15,17,41)
       centracl(15,15,41,"Consulta por N£mero")
       @ 16,19 SAY "N£mero..> " GET XTEMP PICT "99999999"
       READ
       nrec := recno()
       SET ORDER TO 5 // numero
       SEEK XTEMP
       IF .NOT. FOUND()
          mensagemT("Numero nao cadastrado !!!")
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
       sombra(15,15,17,41)
       centracl(15,15,41,"Consulta por Data")
       @ 16,19 SAY "Data....> " GET XTEMP
       READ
       SET ORDER TO 3 // DATA
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
       sombra(15,15,17,76)
       centracl(15,15,76,"Consulta por Historico")
       @ 16,19 SAY "Dados...> " GET XTEMP PICT "@!KX"
       READ
       SET ORDER TO 2 // historico
       SET SOFTSEEK ON
       SEEK XTEMP
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
       sombra(15,15,17,40)
       centracl(15,15,40,"Consulta por Vencimeto")
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
   ELSEIF nKey = -9
       cCor := setcolor(cCorServ)
       nApre := setcursor(1)
       SAVE SCREEN TO telacod
       XTEMP = date()
       sombra(15,13,17,43)
       centracl(15,13,43,"Consulta por data de Entrada")
       @ 16,19 SAY "Data....> " GET XTEMP
       READ
       SET ORDER TO 6 // vencimento
       SET SOFTSEEK ON
       SEEK XTEMP
       SET SOFTSEEK OFF
       RESTORE SCREEN FROM telacod
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
   ELSEIF nKey = 98
      cCor := setcolor(cCorPadra)
      nApre:= setcursor(1)
      IF RECLOCK(1)
         SAVE SCREEN TO WER
         V_VALOR = 0
         V_DATVEN= DATE()
 
         A       = 0
         B       = DATE()
 
         V_VALOR = VALOR
         V_DATVEN= DATVEN
 
         V_NUMERO     = space(8)
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
            MensagemT("Nota j  Baixada! Verifique.")
            setcolor(cCorCaixa)
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
            IF confirma("Valor incorreto! Deseja Retificar o Valor ?",cCorCaixa)
               REPLACE VALOR WITH A
               centra(24,"Ok... Valor Retificado! Pressione Uma Tecla.")
               INKEY(0)
            ELSE
               centra(24,"Ok... Valor N„o Retificado! Pressione Uma Tecla.")
               INKEY(0)
            ENDIF
         ENDIF
         IF B >= V_DATVEN
            centra(24,'Data Correta...')
         ELSE
            DO BIIP
            mensagemt('Data Incorreta...')
         ENDIF
         IF confirma("Confirma a Baixa ?",cCorcaixa)
           REPLACE CANCELADA WITH "C"
           REPLACE DATBAIX   WITH B
           destrava()
         ENDIF
         RESTORE SCREEN FROM WER
         oTbObj:RefreshCurrent()
      ELSE
         QUENTRAVA()
      ENDIF
      setcolor(cCor)
      setcursor(nApre)
   ELSEIF nKey = 99
      IF RECLOCK(1)
         IF confirma("Retorna Cheque Baixado ?",cCorCaixa)
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
       sombra(05,08,20,57)
       centracl(05,08,57,"Teclas de Fun‡”es")
       @ 06,10 say "   [ b ] - Baixa Nota."
       @ 07,10 say "   [ c ] - Cancela baixa do nota."
       @ 08,10 say "      F4 - Cadastra nota."
       @ 09,10 say "      F5 - Soma nota."
       @ 10,10 say "      F6 - Consulta pelo n£mero do Nota."
       @ 11,10 say "      F7 - Consulta pela data de Emiss„o."
       @ 12,10 say "      F8 - Consulta pelo Hist¢rico."
       @ 13,10 say "      F9 - Consulta pelo vencimento."
       @ 14,10 say "     F10 - Consulta pela entrada."
       @ 15,10 say "  INSERT - Altera a Celula Posicionada."
       @ 16,10 say "  DELETE - Deleta a Linha Posicionada."
       @ 17,10 say "  PAGEup - Rola uma tela p/ cima."
       @ 18,10 say "PAGEdown - Rola uma tela p/ baixo."
       @ 19,10 say CHR(24)+" "+CHR(25)+" "+CHR(26)+" "+CHR(27)+"  - Teclas de Direcionamento da C‚lula."
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