PuBLIC WORD1, WORD1A, WORD1B, VALORA, NOMEA, NUM_A, ;
        WORD2, WORD2A, WORD2B, VALORB, NOMEB, NUM_B, ;
        WORD3, WORD3A, WORD3B
 
cCor := setcolor(cCorPadra)
nApre := setcursor(1)
SAVE SCREEN TO TELA1
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCorAnt)
   RESTORE SCREEN FROM TELA1
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCorAnt)
   RESTORE SCREEN FROM TELA1
   close all
   return
endif
select 1
IF NETUSE("nota",.F.,10)
   SET INDEX TO FLYNO_A,FLYNO_B,FLYNO_C,FLYNO_D,FLYNO_E,FLYNO_F
ELSE
   QUEMTRAVA("NOTA")
   RESTORE SCREEN FROM TELA1
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT 2
IF NETUSE("duplicat",.F.,10)
   SET INDEX TO FLYdu_A,FLYdu_B,FLYdu_C,FLYdu_D,FLYdu_E,FLYdu_F
ELSE
   QUEMTRAVA("DUPLICAT")
   RESTORE SCREEN FROM TELA1
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT 3
IF NETUSE("FORNECED",.F.,10)
   SET INDEX TO FORN_A
ELSE
   QUEMTRAVA("FORNECED")
   RESTORE SCREEN FROM TELA1
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT 4
IF NETUSE("CHEQUE",.F.,10)
   SET INDEX TO FLYch_A,FLYch_B,FLYch_C,FLYch_D,FLYch_E,FLYch_F
ELSE
   QUEMTRAVA("CHEQUE")
   RESTORE SCREEN FROM TELA1
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT 5
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   QUEMTRAVA("BANCO")
   RESTORE SCREEN FROM TELA1
   setcolor(cCorAnt)
   close all
   return
endif
 
SELECT nota
SET ORDER TO 1
GO BOTTOM
VCOD        := VAL(ORDEM) + 1
SKIP
VORDEM      := STRZERO(VCOD,5)
SEGUE       := ' '
VNUMERO     := 0
VVALOR      := 0
VCREDITO    := 0
VFORNECEDOR := SPACE(45)
VNOMEA      := SPACE(30)
VDATA       := DATE()
VDATVEN     := DATE()
VDATent     := DATE()
VCODIGO     := 0
VVALORC     := 0
OK          := ' '
aOpcRel := {{17,06," CARTEIRA  "},;
            {19,06," CHEQUE    "},;
            {21,06," DUPLICATA "}}
 
DO WHILE .T.
   select nota
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
   cCorTE := setcolor(cCorPadra)
   SET ORDER TO 5
   GO TOP
   @ 05,20 GET  VNUMERO PICT "99999999"
   READ
 
   IF lastkey() = 27
      setcolor(cCor)
      setcursor(nApre)
      RESTORE SCREEN FROM TELA1
      close all
      return
   ENDIF
 
   IF EMPTY(vnumero)
      SAVE SCREEN TO B
      IF VVALORC > 0
         setcolor(ccormenu)
         SOMBRA(16,05,22,18)
         centracl(16,05,18,"Opcao")
         vAr1 := Botao(aOpcRel,,cCorBin,cCorBat)
         if var1 = 1
            select nota
            if reclock(0)
               REPLACE CANCELADA WITH "C"
               REPLACE DATBAIX   WITH date()
               destrava()
            ENDIF
            SETCOLOR(CcORTE)
            VVALORC := 0
            LOOP
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
            vnum = 0
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
            VALOR_TMP = VVALORC
            DO EXTENDA WITH VALOR_TMP
            VALORA    =   STRPIC(VVALORC,14,2)
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
                         VALOR WITH VVALORC,;
                    FORNECEDOR WITH NOMEA,;
                          DATA WITH VDATA,;
                        DATVEN WITH VDATVEN,;
                         banco WITH Vbanco,;
                         BAIXA WITH 'B'
               destrava()
            ELSE
               QUENTRAVA()
            ENDIF
 
            SELECT nota
            if reclock(0)
               REPLACE CANCELADA WITH "C"
               REPLACE DATBAIX   WITH date()
               destrava()
            ENDIF
            if confirma("Imprime Cheque ?",cCorCaixa)
               VOP = ' '
               if confirma("Cheque Nominal ?",cCorCaixa)
                  vop = 'S'
               ELSE
                  VOP = 'N'
               ENDIF
 
               aOpcrel := {{11,17,'BRADESCO',""},;
                           {13,17,'BRASIL  ',""},;
                           {15,17,'BANESPA ',""},;
                           {17,17,'CAIXA   ',""}}
 
               VAR1 = 1
               setcolor(cCormenu)
               sombra(10,16,18,26)
               centracl(10,16,26,"Banco")
               VAR1 := botao(aOpcRel,,cCorBin,cCorBAt)
               mensagem("Verifique a Impressora !!",cCorCaixa)
               IF .NOT. isprinter()
                  mensagem("Impressora Nao Preparada !!",cCorCaixa)
                  SETCOLOR(CCORTE)
                  loop
                  EXIT
               ENDIF
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
                  VALOR_TMP = VALORC
                  EXTENDA(VALOR_TMP)
                  VALORA    =   STRPIC(VALORC,14,2)
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
                  VALOR_TMP = VALORC
                  DO EXTENDA WITH VALOR_TMP
                  VALORA    =   STRPIC(VALORC,14,2)
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
                  VALOR_TMP = VALORC
                  DO EXTENDA WITH VALOR_TMP
                  VALORA    =   STRPIC(VALORC,14,2)
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
                  DATA_X =  VDADOS3 +", "+ VDATAPIC
                  DATA_A =  DATA_X
                  VALOR_TMP = 0
                  VALOR_TMP = VVALORC
                  DO EXTENDA WITH VALOR_TMP
                  VALORA    =   STRPIC(VVALORC,14,2)
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
               ENDIF
            ELSEIF var1 = 2
                centra(24,"Ok! Cheque Arquivado!")
                inkey(0)
            ENDIF
            SETCOLOR(CcORTE)
            VVALORC := 0
            LOOP
         elseif var1 = 3
             select DUPLICAT
             if addrec(1)
                REPLACE ORDEM      WITH VORDEM
                REPLACE NUMERO     WITH VNUMERO
                REPLACE VALOR      WITH VVALORC
                REPLACE FORNECEDOR WITH VFORNECEDOR
                REPLACE DATA       WITH VDATA
                REPLACE DATVEN     WITH VDATVEN
                destrava()
             ELSE
                QUENTRAVA()
             ENDIF
             centra(24,"Ok..! Duplicata arquivada....")
             inkey(0)
             SETCOLOR(CcORTE)
             VVALORC := 0
             LOOP
         endif
      ELSE
         SETCOLOR(CcORTE)
         LOOP
      ENDIF
   ENDIF
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
      VVALORC = VVALORC + VVALOR
      somBRA(20,04,22,26)
      @ 21,05 SAY "Total..>            "
      @ 21,14 say vvalorc pict "9999,999.99"
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
      GO BOTTOM
      VCOD = VAL(ORDEM) + 1
      SKIP
      centra(24,"OK... Dados confirmado! Pressione qualquer tecla.")
      inkey(0)
      STORE 0 TO VNUMERO,VCODIGO
   ELSE
      centra(24,"OK... Dados n„o confirmado! Pressione qualquer tecla.")
      INKEY(0)
   ENDIF
ENDDO
SETCOLOR(CCOR)
RESTORE SCREEN FROM TELA1
close ALL
return
