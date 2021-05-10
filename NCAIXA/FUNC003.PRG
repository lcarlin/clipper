** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RRETCHQ
 
   PARAMETERS wTipo
   PUBLIC wSub1:= 0
   PUBLIC wSub2:= 0
   PUBLIC wSub3:= 0
   PUBLIC wSub4:= 0
   PUBLIC wSums:= 0
   PUBLIC wTot1:= 0
   PUBLIC wTot2:= 0
   PUBLIC wTot3:= 0
   PUBLIC wTot4:= 0
   PUBLIC wSumt:= 0
   SELECT A
   USE CHEQUER
   SET FILTER TO
   IF ( wTipo == 1 )
      SET FILTER TO IDENT_SER $ "06,07,09,10,15,16"
   ELSEIF ( wTipo == 2 )
      SET FILTER TO IDENT_SER = "02"
   ELSEIF ( wTipo == 3 )
      ordcondset([IDENT_SER = "11"], { || iDent_Ser = "11" }, Nil, ;
         Nil, Nil, Nil, RecNo(), Nil, Nil, Nil, Nil)
      ordcreate("IDATA1", Nil, "DTOS(DT_VENC)", { || DToS(dT_Venc) ;
         }, Nil)
   ENDIF
   GOTO TOP
   IF ( EOF() )
      alert("NAO EXISTE NENHUM REGISTRO PARA ESTE RELATORIO", Nil, ;
         "W/BG")
   ELSE
      verimp()
      IF ( LastKey() == K_ESC )
      ELSE
         SELECT B
         USE EMPRESA
         SET CONSOLE OFF
         setprc(61, 0)
         wPag:= 0
         SET DEVICE TO PRINTER
         IF ( PRow() + 1 > 60 )
            EJECT
            wPag:= wPag + 1
         ENDIF
         IF ( wTipo == 1 )
            cabecr("CONFIRMACAO DE BAIXAS/LIQUIDACAO DE CHEQUES")
         ELSEIF ( wTipo == 2 )
            cabecr("CONFIRMACAO DE ENTRADAS DE CHEQUES")
         ELSEIF ( wTipo == 3 )
            cabecr("C H E Q U E S   E M   C A R T E I R A")
         ENDIF
         wNr_Conta:= mOdalidade + SubStr(nR_Conta, 2, 7)
         @ PRow() + 2,  0 SAY Space(133)
         @ PRow() + 1,  3 SAY "EMPRESA : " + nOme
         @ PRow() + 1,  3 SAY "AGENCIA : " + Transform(cOd_Age, ;
            "@R 9999-9")
         @ PRow() + 1,  3 SAY "NR.CONTA: " + Transform(wNr_Conta, ;
            "@R 99-999.999-9")
         @ PRow() + 2,  0 SAY Space(133)
         tit_col(wTipo)
         SELECT A
         DO WHILE ( .NOT.EOF() .AND. LastKey() != K_ESC )
            IF ( EOF() )
               EXIT
            ENDIF
            IF ( PRow() > 60 )
               sub_tot(wTipo)
               wPag++
               IF ( wTipo == 1 )
                  cabecr("CONFIRMACAO DE BAIXAS/LIQUIDACAO")
               ELSEIF ( wTipo == 2 )
                  cabecr("CONFIRMACAO DE ENTRADAS")
               ELSEIF ( wTipo == 3 )
                  cabecr("TITULOS EM CARTEIRA")
               ENDIF
               tit_col(wTipo)
            ENDIF
            detalhe(wTipo)
            SKIP
            InKey(0.5)
         ENDDO
         tot_ger(wTipo)
         SET FILTER TO
         SET PRINTER OFF
         SET DEVICE TO SCREEN
         SET CONSOLE ON
         CLOSE DATABASES
         SELECT 1
         CLOSE FORMAT
         RETURN
      ENDIF
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RRETFAT
 
   PARAMETERS wTipo
   PUBLIC wSub1:= 0
   PUBLIC wSub2:= 0
   PUBLIC wSub3:= 0
   PUBLIC wSub4:= 0
   PUBLIC wSums:= 0
   PUBLIC wTot1:= 0
   PUBLIC wTot2:= 0
   PUBLIC wTot3:= 0
   PUBLIC wTot4:= 0
   PUBLIC wSumt:= 0
   SELECT A
   USE FATURAR
   SET FILTER TO
   IF ( wTipo == 1 )
      SET FILTER TO IDENT_SER $ "06,07,09,10,15,16"
   ELSEIF ( wTipo == 2 )
      SET FILTER TO IDENT_SER = "02"
   ELSEIF ( wTipo == 3 )
      DBEval({ || FIELD->dT_Ocor:= CToD(dT_Venc) }, { || iDent_Ser = ;
         "11" }, Nil, Nil, Nil, .F.)
      ordcondset([IDENT_SER = "11"], { || iDent_Ser = "11" }, Nil, ;
         Nil, Nil, Nil, RecNo(), Nil, Nil, Nil, Nil)
      ordcreate("IDATA", Nil, "DTOS(DT_OCOR)", { || DToS(dT_Ocor) }, ;
         Nil)
   ENDIF
   GOTO TOP
   IF ( EOF() )
      alert("NAO EXISTE NENHUM REGISTRO PARA ESTE RELATORIO", Nil, ;
         "W/BG")
   ELSE
      verimp()
      IF ( LastKey() == K_ESC )
      ELSE
         SELECT B
         USE EMPRESA
         SET CONSOLE OFF
         setprc(61, 0)
         wPag:= 0
         SET DEVICE TO PRINTER
         IF ( PRow() + 1 > 60 )
            EJECT
            wPag:= wPag + 1
         ENDIF
         IF ( wTipo == 1 )
            cabecr("CONFIRMACAO DE BAIXAS/LIQUIDACAO DE TITULOS")
         ELSEIF ( wTipo == 2 )
            cabecr("CONFIRMACAO DE ENTRADAS DE TITULOS")
         ELSEIF ( wTipo == 3 )
            cabecr("T I T U L O S   E M   C A R T E I R A")
         ENDIF
         wNr_Conta:= mOdalidade + SubStr(nR_Conta, 2, 7)
         @ PRow() + 2,  0 SAY Space(133)
         @ PRow() + 1,  3 SAY "EMPRESA : " + nOme
         @ PRow() + 1,  3 SAY "AGENCIA : " + Transform(cOd_Age, ;
            "@R 9999-9")
         @ PRow() + 1,  3 SAY "NR.CONTA: " + Transform(wNr_Conta, ;
            "@R 99-999.999-9")
         @ PRow() + 2,  0 SAY Space(133)
         tit_col(wTipo)
         SELECT A
         DO WHILE ( .NOT.EOF() .AND. LastKey() != K_ESC )
            IF ( EOF() )
               EXIT
            ENDIF
            IF ( PRow() > 60 )
               sub_tot(wTipo)
               wPag++
               IF ( wTipo == 1 )
                  cabecr("CONFIRMACAO DE BAIXAS/LIQUIDACAO")
               ELSEIF ( wTipo == 2 )
                  cabecr("CONFIRMACAO DE ENTRADAS")
               ELSEIF ( wTipo == 3 )
                  cabecr("TITULOS EM CARTEIRA")
               ENDIF
               tit_col(wTipo)
            ENDIF
            detalhe(wTipo)
            SKIP
            InKey(0.5)
         ENDDO
         tot_ger(wTipo)
         SET FILTER TO
         SET PRINTER OFF
         SET DEVICE TO SCREEN
         SET CONSOLE ON
         CLOSE DATABASES
         SELECT 1
         CLOSE FORMAT
         RETURN
      ENDIF
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RRETORNO
 
   wOpa:= 1
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem(" IMPRESSAO DE RELATORIO DE RETORNO", "T")
      @  8,  5, 10, 38 BOX wMold
      @ 12,  5, 14, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 12, 41, 14, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "   CONFIRMACAO DE BAIXAS    "
      @ 13,  8 PROMPT "  ENTRADAS  -  CONFIRMACAO  "
      @ 17,  8 PROMPT "    TITULOS EM CARTEIRA     "
      @ 17, 44 PROMPT "  VOLTA AO MENU ANTERIOR    "
      MENU TO wOpa
      DO CASE
      CASE wOpa = 1
         rretfat(1)
      CASE wOpa = 2
         rretfat(2)
      CASE wOpa = 3
         rretfat(3)
      CASE wOpa = 4
         RETURN
      CASE wOpa = 5 .OR. wOpa = 0
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION SCRNREST( Arg1 )
 
   RestScreen(Asc(SubStr(Arg1, 1, 1)), Asc(SubStr(Arg1, 2, 1)), ;
      Asc(SubStr(Arg1, 3, 1)), Asc(SubStr(Arg1, 4, 1)), SubStr(Arg1, ;
      5))
   RETURN Nil
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION SCRNSAVE( Arg1, Arg2, Arg3, Arg4 )
 
   RETURN Chr(Arg1) + Chr(Arg2) + Chr(Arg3) + Chr(Arg4) + ;
      SaveScreen(Arg1, Arg2, Arg3, Arg4)
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION SHADOW( Arg1, Arg2, Arg3, Arg4, Arg5 )
 
   LOCAL Local1:= sHad_Cnt:= sHad_Len:= 0, Local2:= ""
   Static1++
   Arg3++
   Arg4++
   asize(Static2[ 1 ], Static1)
   asize(Static2[ 2 ], Static1)
   Arg5:= IIF( ISNUMBER( Arg5 ), Arg5, 7 )
   Static2[ 1 ][ Static1 ]:= scrnsave(Arg3, Arg2 + 1, Arg3, Arg4 + 1)
   Static2[ 2 ][ Static1 ]:= scrnsave(Arg1 + 1, Arg4, Arg3, Arg4 + 1)
   IF ( Arg3 <= MaxRow() .AND. Arg4 <= MaxCol() - 1 )
      FOR sHad_Cnt:= 1 TO 2
         sHad_Len:= Len(Static2[ sHad_Cnt ][ Static1 ])
         Local2:= Static2[ sHad_Cnt ][ Static1 ]
         FOR Local1:= 6 TO sHad_Len STEP 2
            Local2:= stuff(Local2, Local1, 1, Chr(Arg5))
         NEXT
         scrnrest(Local2)
      NEXT
   ENDIF
   RETURN Nil
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE SUB_TOT( Arg1 )
 
   @ PRow() + 2,  3 SAY "SUB-TOTAL"
   @ PRow(), 14 SAY wSums PICTURE "9999"
   IF ( Arg1 == 1 )
      @ PRow(), 63 SAY wSub1 PICTURE "@E 99999,999,999.99"
      @ PRow(), 78 SAY wSub2 PICTURE "@E 99,999,999,999.99"
      @ PRow(), 117 SAY wSub4 PICTURE "@E 99,999,999,999.99"
   ELSEIF ( Arg1 == 2 )
      @ PRow(), 67 SAY wSub1 PICTURE "@E 99,999,999,999.99"
      @ PRow(), 110 SAY wSub2 PICTURE "@E 99,999,999,999.99"
   ELSEIF ( Arg1 == 3 )
      @ PRow(), 67 SAY wSub1 PICTURE "@E 99,999,999,999.99"
   ENDIF
   EJECT
   wSub1:= 0
   wSub2:= 0
   wSub3:= 0
   wSub4:= 0
   wSums:= 0
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION SYSSAVE
 
   LOCAL Local1, Local2, Local3
   PARAMETERS wMode, wFilelist
   Local1:= Set(_SET_DATEFORMAT)
   Local2:= alerta(15, 40, "Qual o Drive para Copia?", {" A ", ;
      " B ", "Cancela"})
   IF ( Local2 == 1 )
      wDrive:= "A:"
   ELSEIF ( Local2 == 2 )
      wDrive:= "B:"
   ELSE
      RETURN 99
   ENDIF
   wClippath:= gete("PATH")
   SET PATH TO (wClippath)
   setcursor(0)
   PRIVATE wInitsize:= wNeeded:= wRet_Value:= wRemaining:= wTotal:= ;
      wShandle:= wSize:= wThandle:= 0
   PRIVATE wBackfile:= wBacktext:= wBackupid:= wBuffer:= wDisktext:= ;
      wSourceti:= wSource:= wTarget:= ""
   PRIVATE wDiskno:= 1, wSourcedt
   Local3:= SaveScreen(8, 0, 23, 79)
   IF ( wMode == 1 )
      caixa(9, 9, 21, 72)
      SET COLOR TO N/W
      @  9,  9 CLEAR TO 21, 72
      @  9, 10 SAY ;
         "Esta funcao usa o programa FORMAT do DOS se  detectar um disco"
      @ 10, 10 SAY ;
         "nao formatado durante a operacao de COPIA.  FORMAT.COM    deve"
      @ 11, 10 SAY ;
         "estar presente no diretorio corrente ou no caminho especifica-"
      @ 12, 10 SAY "do pelo path do DOS."
      @ 14, 10 SAY ;
         "Rotule o numero de todos os discos durante a copia,      pelas"
      @ 15, 10 SAY ;
         "instrucoes da tela. Na restauracao voce devera colocar os Dis-"
      @ 16, 10 SAY "cos na sequencia solicitada."
      @ 18, 10 SAY ;
         "Os arquivos do diretorio corrente utilizado para copia poderao"
      @ 19, 10 SAY ;
         "ser apagados no momento da copia.                       "
      @ 20, 10 SAY ;
         "PARA FAZER MAIS DE UMA COPIA, UTILIZE NOVAMENTE A OPCAO BACKUP"
      SET COLOR TO
   ELSE
      caixa(9, 9, 21, 72)
      SET COLOR TO N/W
      @  9,  9 CLEAR TO 21, 72
      @  9, 10 SAY ;
         "Esta funcao restaura os arquivos  gravados  com  a  opcao   de"
      @ 10, 10 SAY ;
         "BACKUP. E de suma importancia a colocacao dos discos na  ordem"
      @ 11, 10 SAY ;
         "pedida, para que a Restauracao seja bem sucedida.             "
      @ 14, 10 SAY ;
         "Caso haja duvida a respeito da numeracao basta dar um dir   no"
      @ 15, 10 SAY ;
         "disquete, que o arquivo Backup__.DAT revelara o numero do dis-"
      @ 16, 10 SAY "co, na posicao que esta sublinhada."
      @ 18, 10 SAY ;
         "Se voce der um TYPE no arquivo BACKUP__.DAT vera o nome    dos"
      @ 19, 10 SAY ;
         "arquivos que fazem parte do backup e o dia e hora em que foram"
      @ 20, 10 SAY ;
         "executados.                                                   "
      SET COLOR TO
   ENDIF
   mensagem("Tecle <ENTER> para continuar.", "P")
   RestScreen(8, 0, 23, 79, Local3)
   wBackfile:= wDrive + "BACKUP" + LTrim(Str(wDiskno)) + ".DAT"
   wInitsize:= memory(1) * 1024 / 4
   IF ( wInitsize <= 2048 )
      alert("MEMORIA INSUFICIENTE - TECLE ALGO", Nil, "/BG")
      RETURN 1
   ENDIF
   wSize:= wInitsize
   wBuffer:= Space(wSize)
   IF ( wMode == 1 )
      wNum_Files:= Len(wFilelist)
      FOR wI:= 1 TO wNum_Files
         wCurr_File:= filesize(wFilelist[ wI ])
         IF ( wCurr_File <= 0 )
            alert("Erro na leitura do arquivo " + wFilelist[ wI ] + ;
               "- TECLE ALGO. ", Nil, "/BG")
            RETURN 5
         ENDIF
         wNeeded:= wNeeded + wCurr_File
      NEXT
      setcursor(2)
      mensagem("Copia necessitara aproximadamente " + ;
         LTrim(Str(Int(wNeeded / 1024 + 2))) + "K de espaco no disco")
   ELSE
   ENDIF
   setcursor(0)
   insertdisk()
   IF ( LastKey() == K_ESC )
      setcursor(1)
      RETURN 0
   ENDIF
   IF ( wMode == 1 )
      backup()
   ELSE
      restore()
   ENDIF
   setcursor(1)
   SET DATE FORMAT TO Local1
   RETURN wRet_Value
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION SYSSAVE1
 
   LOCAL Local1, Local2, Local3
   PARAMETERS wMode, wFilelist
   Local1:= Set(_SET_DATEFORMAT)
   Local2:= alerta(15, 40, "Qual o Drive para Copia?", {" A ", ;
      " B ", "Cancela"})
   IF ( Local2 == 1 )
      wDrive:= "A:"
   ELSEIF ( Local2 == 2 )
      wDrive:= "B:"
   ELSE
      RETURN 99
   ENDIF
   wClippath:= gete("PATH")
   SET PATH TO (wClippath)
   setcursor(0)
   PRIVATE wInitsize:= wNeeded:= wRet_Value:= wRemaining:= wTotal:= ;
      wShandle:= wSize:= wThandle:= 0
   PRIVATE wBackfile:= wBacktext:= wBackupid:= wBuffer:= wDisktext:= ;
      wSourceti:= wSource:= wTarget:= ""
   PRIVATE wDiskno:= 1, wSourcedt
   Local3:= SaveScreen(8, 0, 23, 79)
   IF ( wMode == 1 )
      caixa(9, 9, 21, 72)
      SET COLOR TO N/W
      @  9,  9 CLEAR TO 21, 72
      @  9, 10 SAY ;
         "Esta funcao usa o programa FORMAT do DOS se  detectar um disco"
      @ 10, 10 SAY ;
         "nao formatado durante a operacao de COPIA.  FORMAT.COM    deve"
      @ 11, 10 SAY ;
         "estar presente no diretorio corrente ou no caminho especifica-"
      @ 12, 10 SAY "do pelo path do DOS."
      @ 14, 10 SAY ;
         "Rotule o numero de todos os discos durante a copia,      pelas"
      @ 15, 10 SAY ;
         "instrucoes da tela. Na restauracao voce devera colocar os Dis-"
      @ 16, 10 SAY "cos na sequencia solicitada."
      @ 18, 10 SAY ;
         "Os arquivos do diretorio corrente utilizado para copia poderao"
      @ 19, 10 SAY ;
         "ser apagados no momento da copia.                       "
      @ 20, 10 SAY ;
         "PARA FAZER MAIS DE UMA COPIA, UTILIZE NOVAMENTE A OPCAO BACKUP"
      SET COLOR TO
   ELSE
      caixa(9, 9, 21, 72)
      SET COLOR TO N/W
      @  9,  9 CLEAR TO 21, 72
      @  9, 10 SAY ;
         "Esta funcao restaura os arquivos  gravados  com  a  opcao   de"
      @ 10, 10 SAY ;
         "BACKUP. E de suma importancia a colocacao dos discos na  ordem"
      @ 11, 10 SAY ;
         "pedida, para que a Restauracao seja bem sucedida.             "
      @ 14, 10 SAY ;
         "Caso haja duvida a respeito da numeracao basta dar um dir   no"
      @ 15, 10 SAY ;
         "disquete, que o arquivo Backup__.DAT revelara o numero do dis-"
      @ 16, 10 SAY "co, na posicao que esta sublinhada."
      @ 18, 10 SAY ;
         "Se voce der um TYPE no arquivo BACKUP__.DAT vera o nome    dos"
      @ 19, 10 SAY ;
         "arquivos que fazem parte do backup e o dia e hora em que foram"
      @ 20, 10 SAY ;
         "executados.                                                   "
      SET COLOR TO
   ENDIF
   mensagem("Tecle <ENTER> para continuar.", "P")
   RestScreen(8, 0, 23, 79, Local3)
   wBackfile:= wDrive + "BACKUP" + LTrim(Str(wDiskno)) + ".DAT"
   wInitsize:= memory(1) * 1024 / 4
   IF ( wInitsize <= 2048 )
      alert("MEMORIA INSUFICIENTE - TECLE ALGO", Nil, "/BG")
      RETURN 1
   ENDIF
   wSize:= 402
   wBuffer:= Space(402)
   IF ( wMode == 1 )
      wNum_Files:= Len(wFilelist)
      FOR wI:= 1 TO wNum_Files
         wCurr_File:= filesize(wFilelist[ wI ])
         IF ( wCurr_File <= 0 )
            alert("Erro na leitura do arquivo " + wFilelist[ wI ] + ;
               "- TECLE ALGO. ", Nil, "/BG")
            RETURN 5
         ENDIF
         wNeeded:= wNeeded + wCurr_File
      NEXT
      setcursor(2)
      mensagem("Copia necessitara de aproximadamente " + ;
         LTrim(Str(Int(wNeeded / 1024 + 2))) + "K de espaco no disco")
   ELSE
   ENDIF
   setcursor(0)
   insertdisk()
   IF ( LastKey() == K_ESC )
      setcursor(1)
      RETURN 0
   ENDIF
   IF ( wMode == 1 )
      backup1()
   ELSE
      restore()
   ENDIF
   setcursor(1)
   SET DATE FORMAT TO Local1
   RETURN wRet_Value
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE TELA
 
   PUBLIC wT1
   CLEAR SCREEN
   CLEAR GETS
   SET COLOR TO BG
   @  5,  0 CLEAR TO 21, 79
   mOld_Sp_Cp:= "ÕÍ¸³¾ÍÔ³°"
   @  6,  0, 20, 79 BOX mOld_Sp_Cp
   SET COLOR TO W+/W+
   @  1,  1 CLEAR TO  4, 22
   SET COLOR TO N/W
   @  1,  2 SAY "ÜÜÜÜÜÜÜÜÜ"
   @  2,  2 SAY "ÛÛÛÛÛÛÛÛÛ"
   @  4,  2 SAY "c a i x a"
   @  4, 13 SAY "B A N C O"
   SET COLOR TO R/W
   @  1, 13 SAY "ÜÜÜÜÜÜÜÜÜ"
   @  2, 13 SAY "ÛÛÛÛÛÛÛÛÛ"
   @  4,  7 SAY ">"
   SET COLOR TO W+/N
   @  3,  2 SAY "n o s s a"
   SET COLOR TO W+/R
   @  3, 13 SAY "N O S S O"
   SET COLOR TO
   @  1, 25 TO  4, 79
   @  2, 52 - Len(wSist) / 2 SAY wSist
   @  4, 60 SAY dia(Date()) + ", " + DToC(Date())
   @  4, 27 SAY " Versao: 2.7 "
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION TELA_ESC( Arg1, Arg2 )
 
   LOCAL Local1, Local2, Local3, Local4
   Local1:= 8
   Local3:= 42
   wIncl:= Len(Arg2) + 4
   Arg1:= "  " + Arg1 + " "
   wIncc:= Len(Arg1) + 2
   IF ( wIncc > 34 )
      wIncc:= 34
      Arg1:= SubStr(Arg1, 1, 34)
   ENDIF
   Local2:= Local1 + wIncl
   Local4:= Local3 + wIncc
   wT2:= SaveScreen(Local1, Local3, Local2 + 2, Local4 + 2)
   caixa(Local1, Local3, Local2, Local4)
   SET COLOR TO /BG,N/BG
   @ Local1, Local3 CLEAR TO Local2, Local4
   @ Local1, Local3 TO Local2, Local4 DOUBLE
   @ Local1 + 0, Local3 SAY "É"
   @ Local1 + 0, Local4 SAY "»"
   @ Local1 + 1, Local3 + 1 SAY Arg1
   @ Local1 + 2, Local3 SAY "Ç"
   @ Local1 + 2, Local3 + 1 TO Local1 + 2, Local4 - 1
   @ Local1 + 2, Local4 SAY "¶"
   SET INTENSITY ON
   SET COLOR TO N/BG,W/N,N
   @ Local1 + 3, Local3 + 1 PROMPT "  " + Arg2[ 1 ] + " "
   @ Local1 + 4, Local3 + 1 PROMPT "  " + Arg2[ 2 ] + " "
   IF ( wIncl - 4 >= 3 )
      @ Local1 + 5, Local3 + 1 PROMPT "  " + Arg2[ 3 ] + " "
   ENDIF
   IF ( wIncl >= 4 )
      @ Local1 + 6, Local3 + 1 PROMPT "  " + Arg2[ 4 ] + " "
   ENDIF
   MENU TO w_Sel_R
   SET COLOR TO W/N,N/W,N/W,,,N/W
   SET INTENSITY ON
   RestScreen(Local1, Local3, Local2 + 2, Local4 + 2, wT2)
   RETURN w_Sel_R
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION TELA_ZS( Arg1, Arg2, Arg3, Arg4 )
 
   LOCAL Local1, Local2, Local3, Local4, Local5
   Local5:= 1
   Local1:= SetColor()
   Local2:= Int(( Arg4 - Arg2 ) / 2)
   SET COLOR TO /W
   Local3:= Arg2 + Local2
   Local4:= Arg4 - Local2
   DO WHILE ( .T. )
      @ Arg1, Local3 CLEAR TO Arg3, Local4
      @ Arg1, Local3 TO Arg3, Local4 DOUBLE
      IF ( .NOT.( Local3 = Arg2 ) )
         Local3:= Local3 - 1
      ENDIF
      IF ( .NOT.( Local4 = Arg4 ) )
         Local4:= Local4 + 1
      ENDIF
      IF ( Local3 = Arg2 .AND. Local4 = Arg4 )
         EXIT
      ENDIF
      IF ( Local5 < 4 )
         Local5++
      ELSE
         InKey(0.01)
         Local5:= 0
      ENDIF
   ENDDO
   SET COLOR TO /N+
   @ Arg3 + 1, Arg2 + 1 SAY Space(Arg4 - Arg2)
   FOR i:= Arg1 + 1 TO Arg3 + 1
      @ i, Arg4 SAY Space(1)
   NEXT
   SET COLOR TO (Local1)
   RETURN .T.
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE TIT_COL( Arg1 )
 
   @ PRow() + 3,  0 SAY " "
   IF ( Arg1 == 1 )
      @ PRow(),  0 SAY ""
      @ PRow(),  3 SAY "N.Nr."
      @ PRow(), 13 SAY "Nr.Doc."
      @ PRow(), 24 SAY "S A C A D O"
      @ PRow(), 46 SAY "Dt.Venc"
      @ PRow(), 55 SAY "Dt.Pag."
      @ PRow(), 67 SAY "Valor "
      @ PRow(), 83 SAY "Pagamento"
      @ PRow(), 98 SAY "Cod."
      @ PRow(), 104 SAY "Oscilacao"
      @ PRow(), 121 SAY "Tarifa"
   ELSEIF ( Arg1 == 2 )
      @ PRow(),  0 SAY ""
      @ PRow(),  6 SAY "Nosso Nr."
      @ PRow(), 19 SAY "Nr.Doc."
      @ PRow(), 32 SAY "S a c a d o"
      @ PRow(), 56 SAY "Dt.Venc."
      @ PRow(), 70 SAY "V a l o r"
      @ PRow(), 91 SAY "Doc."
      @ PRow(), 100 SAY "Cart."
      @ PRow(), 112 SAY "Tarifa"
   ELSEIF ( Arg1 == 3 )
      @ PRow(),  0 SAY ""
      @ PRow(),  6 SAY "Nosso Nr."
      @ PRow(), 19 SAY "Nr.Doc."
      @ PRow(), 32 SAY "S a c a d o"
      @ PRow(), 56 SAY "Dt.Venc."
      @ PRow(), 70 SAY "V a l o r"
      @ PRow(), 91 SAY "Doc."
      @ PRow(), 100 SAY "Cart."
      @ PRow(), 110 SAY "Cobradora"
   ENDIF
   @ PRow() + 3,  0 SAY " "
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE TOT_GER( Arg1 )
 
   @ PRow() + 2,  3 SAY "TOTAL.."
   @ PRow(), 14 SAY wSumt PICTURE "9999"
   IF ( Arg1 == 1 )
      @ PRow(), 63 SAY wTot1 PICTURE "@E 99999,999,999.99"
      @ PRow(), 78 SAY wTot2 PICTURE "@E 99,999,999,999.99"
      @ PRow(), 117 SAY wTot4 PICTURE "@E 99,999,999,999.99"
   ELSEIF ( Arg1 == 2 )
      @ PRow(), 67 SAY wTot1 PICTURE "@E 99,999,999,999.99"
      @ PRow(), 110 SAY wTot2 PICTURE "@E 99,999,999,999.99"
   ELSEIF ( Arg1 == 3 )
      @ PRow(), 67 SAY wTot1 PICTURE "@E 99,999,999,999.99"
   ENDIF
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION T_MOEDA
 
   LOCAL Local1, Local2
   Local2:= SetColor()
   IF ( .NOT.( wTipo_Moed $ "0" ) )
      @ 10, 43 SAY "Û"
      SET COLOR TO "B/W,W/B"
      Local1:= SaveScreen(13, 59, 18, 79)
      vMoeda:= {}
      AAdd(vMoeda, "0 - Real    ")
      caixa(14, 59, 17, 77, "S", "S", "N")
      wMo:= achoice(15, 60, 15, 76, vMoeda, .T., "FOPCOESCO")
      wTipo_Moed:= SubStr(vMoeda[ wMo ], 1, 1)
      SET COLOR TO (Local2)
      RestScreen(13, 59, 18, 79, Local1)
   ENDIF
   RETURN .T.
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERALFA
 
   IF ( wProv = Space(3) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERCNAB
 
   tEcla:= 0
   w:= 1
   RESTORE SCREEN FROM wT1
   mensagem("CHECAGEM DE LAYOUT DO ARQUIVO NO PADRAO CNAB", "T")
   PRIVATE wMcampo[45]
   wArqcriar:= "Auxiliar"
   i:= 1
   wMcampo[ i++ ]:= "COD_REG    C 001 0"
   wMcampo[ i++ ]:= "FILLER1    C 016 0"
   wMcampo[ i++ ]:= "COD_AGE    C 004 0"
   wMcampo[ i++ ]:= "MODALID    C   2 0"
   wMcampo[ i++ ]:= "CONTA      C   8 0"
   wMcampo[ i++ ]:= "FILLER2    C   6 0"
   wMcampo[ i++ ]:= "FILLER3    C  25 0"
   wMcampo[ i++ ]:= "NOSSO_NR   C 008 0"
   wMcampo[ i++ ]:= "NR_CONT    C  10 0"
   wMcampo[ i++ ]:= "COD_TARIFA C 002 0"
   wMcampo[ i++ ]:= "COD_REAPR  C 001 0"
   wMcampo[ i++ ]:= "FILLER4    C  24 0"
   wMcampo[ i++ ]:= "COD_CART   C 001 0"
   wMcampo[ i++ ]:= "IDENT_SER  C 002 0"
   wMcampo[ i++ ]:= "NR_DOC     C 010 0"
   wMcampo[ i++ ]:= "DT_VENC    C 006 0"
   wMcampo[ i++ ]:= "VAL_TITULO C 013 0"
   wMcampo[ i++ ]:= "BANCO_COB  C 007 0"
   wMcampo[ i++ ]:= "FILLER5    C   1 0"
   wMcampo[ i++ ]:= "ESP_DOC    C 002 0"
   wMcampo[ i++ ]:= "ACEITE     C 001 0"
   wMcampo[ i++ ]:= "DT_EMIS    C 006 0"
   wMcampo[ i++ ]:= "INST_COB   C 004 0"
   wMcampo[ i++ ]:= "COD_MORA   C 001 0"
   wMcampo[ i++ ]:= "MORA       C 012 0"
   wMcampo[ i++ ]:= "DT_DESC    C   6 0"
   wMcampo[ i++ ]:= "VAL_DESC   C  13 0"
   wMcampo[ i++ ]:= "VAL_IOC    C  13 0"
   wMcampo[ i++ ]:= "ABATIMENTO C  13 0"
   wMcampo[ i++ ]:= "TIPO_CIC   C   2 0"
   wMcampo[ i++ ]:= "NR_CIC     C  14 0"
   wMcampo[ i++ ]:= "NOME_SAC   C  37 0"
   wMcampo[ i++ ]:= "SUP_CEP    C   3 0"
   wMcampo[ i++ ]:= "END_SAC    C  40 0"
   wMcampo[ i++ ]:= "FILLER6    C  15 0"
   wMcampo[ i++ ]:= "CEP        C   5 0"
   wMcampo[ i++ ]:= "CIDADE     C  15 0"
   wMcampo[ i++ ]:= "ESTADO     C   2 0"
   wMcampo[ i++ ]:= "NR_SACADOR C  10 0"
   wMcampo[ i++ ]:= "NO_SACADOR C  30 0"
   wMcampo[ i++ ]:= "PRAZO_PROT C   2 0"
   wMcampo[ i++ ]:= "TIPO_MOEDA C   1 0"
   wMcampo[ i++ ]:= "NR_SEQ     C   6 0"
   wQtcampos:= 43
   pcriarq()
   precarq("ENTRE COM O NOME DO ARQUIVO PARA TESTE? ", "TXT")
   IF ( wArq = Space(8) )
   ELSE
      CLOSE DATABASES
      USE AUXILIAR
      ZAP
      APPEND FROM (wArq) SDF ALL
      PRIVATE wErro[500]
      afill(wErro, Space(70))
      i:= 0
      GOTO TOP
      verheader()
      SKIP
      DO WHILE ( .NOT.EOF() )
         IF ( cOd_Reg = "0" )
            verheader()
         ELSEIF ( cOd_Reg = "9" )
            vertrailer()
         ELSEIF ( cOd_Reg = "1" )
            verreg()
         ELSE
            wMerro:= ;
               " Cod. de Registro incompativel - Nao sera analisado o conteudo do Reg. "
            wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
               " / Cod. Registro: " + cOd_Reg + wMerro
         ENDIF
         SKIP
         IF ( w >= 240 )
            EXIT
         ENDIF
      ENDDO
      GOTO TOP
      DO WHILE ( .NOT.EOF() )
         IF ( cOd_Reg = "0" )
            SKIP
            DO WHILE ( .NOT.EOF() .AND. cOd_Reg = "1" )
               SKIP
            ENDDO
            IF ( EOF() )
               wErro[ w++ ]:= Str(RecNo(), 3) + ;
                  " - Sequencia Header, Registros e Trailler nao confere"
               EXIT
            ELSE
               IF ( cOd_Reg != "9" )
                  wErro[ w++ ]:= Str(RecNo(), 3) + ;
                     " - Sequencia Header, Registros e Trailler nao confere"
                  EXIT
               ENDIF
               SKIP
            ENDIF
            IF ( EOF() )
               EXIT
            ELSE
               LOOP
            ENDIF
         ELSE
            wErro[ w++ ]:= ;
               "  Sequencia Header, Registros e Trailler nao confere"
            EXIT
         ENDIF
      ENDDO
      IF ( wErro[ 1 ] = Space(30) .AND. wErro[ 2 ] = Space(30) )
         mensagem("SUCESSO NA CHECAGEM DO LAYOUT DO ARQUIVO", "P")
      ELSE
         mensagem("PREPARE A IMPRESSORA PARA IMPRESSAO DO RELATORIO DE POSSIVEIS ERROS", ;
            "P")
         DO WHILE ( .NOT.isprinter() )
            mensagem("IMPRESSORA NAO PRONTA - POR FAVOR TECLE ALGO QUANDO OK!", ;
               "P")
         ENDDO
         SET DEVICE TO PRINTER
         wPag:= 1
         cabecr("PADRAO CNAB")
         @ PRow() + 1,  1 SAY " "
         wI:= 0
         DO WHILE ( wI < 150 .AND. LastKey() != K_ESC )
            wI++
            IF ( wErro[ wI ] = Space(30) )
               wI:= 200
            ELSE
               @ PRow() + 1,  5 SAY SubStr(wErro[ wI ], 1, 120)
               IF ( PRow() > 55 )
                  EJECT
                  wPag++
                  cabecr("PADRAO CNAB")
                  @ PRow() + 1,  1 SAY " "
               ENDIF
            ENDIF
            InKey(0.5)
         ENDDO
         SET DEVICE TO SCREEN
         CLOSE DATABASES
      ENDIF
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERDT
 
   wProv1:= SubStr(wProv, 1, 2) + "/" + SubStr(wProv, 3, 2) + "/" + ;
      SubStr(wProv, 5, 2)
   IF ( wProv1 = "00/00/00" )
   ELSE
      IF ( wProv1 = "  /  /  " )
         wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
            " / Cod. Registro: " + cOd_Reg + wMerro + wProv
      ELSE
         wProv1:= CToD(wProv1)
         IF ( wProv1 = CToD("  /  /  ") )
            wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
               " / Cod. Registro: " + cOd_Reg + wMerro + wProv
         ENDIF
      ENDIF
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERHEADER
 
   IF ( cOd_Reg != "0" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         "Identificacao do registro Header INVALIDO - " + cOd_Reg
   ENDIF
   IF ( SubStr(fIller1, 1, 1) != "1" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Identificacao do arquivo Remessa = " + SubStr(fIller1, ;
         1, 1) + " - quando deveria ser 1"
   ENDIF
   wProv:= SubStr(fIller1, 2, 8)
   IF ( Upper(wProv) != "REMESSA" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Identificacao por extenso do tipo do movimento deveria ser: Remessa"
   ENDIF
   wProv:= SubStr(fIller1, 9, 2)
   IF ( wProv != "01" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Identificacao do tipo de servico = " + wProv + ;
         " - quando deveria ser 01"
   ENDIF
   wProv:= SubStr(cOnta, 8, 1) + SubStr(fIller2, 1, 1)
   pmodal()
   wProv:= SubStr(cOnta, 4, 5) + fIller2 + SubStr(fIller3, 1, 3)
   pnr_conta()
   wProv:= SubStr(fIller3, 9, 16) + nOsso_Nr + SubStr(nR_Cont, 1, 6)
   IF ( wProv = Space(20) .OR. isdigit(wProv) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Nome por extenso da Empresa esta invalido"
   ENDIF
   wProv:= SubStr(nR_Cont, 7, 3)
   IF ( wProv != "151" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Nr. do Banco so pode ser 151 e nao " + wProv
   ENDIF
   wProv:= SubStr(nR_Cont, 10, 1) + cOd_Tarifa + cOd_Reapr + ;
      SubStr(fIller4, 1, 10)
   IF ( wProv != "NC-NB" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Nome por extenso do Banco diferente de NC-NB verifique"
   ENDIF
   wProv:= SubStr(fIller4, 12, 2) + "/" + SubStr(fIller4, 14, 2) + ;
      "/" + SubStr(fIller4, 16, 2)
   wProv:= CToD(wProv)
   IF ( wProv = CToD("  /  /  ") )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Data de gravacao do arquivo invalida no registro Header"
   ENDIF
   wProv:= SubStr(fIller4, 18, 7) + cOd_Cart + iDent_Ser + nR_Doc + ;
      dT_Venc + vAl_Titulo + bAnco_Cob + fIller5 + eSp_Doc + aCeite ;
      + dT_Emis + iNst_Cob + cOd_Mora + mOra + dT_Desc + vAl_Desc + ;
      vAl_Ioc + aBatimento + tIpo_Cic + nR_Cic + nOme_Sac
   wProv:= wProv + sUp_Cep + eNd_Sac + fIller6 + cEp + cIdade + ;
      eStado + nR_Sacador + SubStr(nO_Sacador, 1, 27)
   IF ( wProv != Space(287) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - HEADER - pos. 101 a 389 deve estar em branco"
   ENDIF
   wProv:= SubStr(nO_Sacador, 28, 3) + pRazo_Prot + tIpo_Moeda
   IF ( wProv = Space(6) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Nr. sequencial do Arquivo no Tipo de Servico deve estar zerado e nao em branco"
   ENDIF
   wProv:= nR_Seq
   IF ( wProv = Space(6) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Nr. sequencial do registro no arquivo deve estar zerado e nao em branco"
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERIMP
 
   DO WHILE ( .NOT.isprinter() )
      tone(700, 2)
      mensagem("Impressora Nao Ativa!. Tecle <ENTER> Quando Ok, ou <ESC> Para Retornar.", ;
         "P")
      IF ( LastKey() == K_ESC )
         EXIT
      ENDIF
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERNR
 
   wT:= Len(wProv)
   IF ( wProv = Space(wT) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ELSE
      FOR j:= 1 TO wT
         IF ( .NOT.isdigit(SubStr(wProv, j, 1)) )
            wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
               " / Cod. Registro: " + cOd_Reg + wMerro + wProv
         ENDIF
      NEXT
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERREG
 
   wProv:= mOdalid
   pmodal()
   wProv:= cOd_Age + mOdalid + cOnta
   pnr_conta()
   wNosso_Nr:= nOsso_Nr
   wConta:= SubStr(cOd_Age, 1, 4) + mOdalid + cOnta + nOsso_Nr
   IF ( cOd_Cart = "4" .OR. cOd_Cart = "5" .OR. eSp_Doc < "20" )
      IF ( nOsso_Nr = Space(5) )
         wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
            " / Cod. Registro: " + cOd_Reg + ;
            " - Nosso Nr. nao pode estar em branco "
      ELSEIF ( .NOT.fnossonr() )
         wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
            " / Cod. Registro: " + cOd_Reg + ;
            " - Nosso Nr. nao esta correto verifique "
      ENDIF
   ELSEIF ( nOsso_Nr != "00000000" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Nosso Nr. nao esta ZERADO verifique "
      RETURN
   ENDIF
   wMerro:= " Numero do Contrato nao numerico "
   wProv:= nR_Cont
   vernr()
   wMerro:= " Codigo da Tarifa nao numerica "
   wProv:= cOd_Tarifa
   vernr()
   wMerro:= " Codigo da Tarifa fora da faixa "
   IF ( cOd_Tarifa < "00" .OR. cOd_Tarifa > "99" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + cOd_Tarifa
   ENDIF
   wMerro:= " Cod. de Reapresentacao deve ser 0 ou 1 "
   wProv:= cOd_Reapr
   IF ( cOd_Reapr < "0" .OR. cOd_Reapr > "1" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + cOd_Reapr
   ENDIF
   wMerro:= " Cod. da Carteira deve estar entre 0 e 6 "
   wProv:= cOd_Cart
   IF ( cOd_Cart < "0" .OR. cOd_Reapr > "7" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Identificacao do Servico invalida "
   wProv:= iDent_Ser
   IF ( wProv > "00" .OR. wProv <= "10" .OR. wProv = "13" .OR. wProv ;
         = 31 .OR. wProv = "34" .OR. wProv = "99" )
   ELSE
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Data de vencimento invalida ou em branco "
   wProv:= dT_Venc
   verdt()
   wMerro:= " Valor do titulo nao numerico "
   wProv:= vAl_Titulo
   vernr()
   wMerro:= ;
      " Banco e Agencia Cobradora nao numericos - preencher ou zerar "
   wProv:= bAnco_Cob
   vernr()
   wMerro:= " Especie de Documento nao numerico ou em branco "
   wProv:= eSp_Doc
   vernr()
   IF ( eSp_Doc < "20" .AND. nOsso_Nr = "00000000" )
      wMerro:= ;
         " Especie de Documento abaixo de 20 exige Nosso Numero preenchido "
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Aceite deve ser A ou N - Aceito ou Nao aceito "
   wProv:= aCeite
   IF ( aCeite != "N" .AND. aCeite != "A" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Data de Emissao em branco ou nao valida "
   wProv:= dT_Emis
   verdt()
   wMerro:= " Instrucao de Cobranca nao numerico ou em branco "
   wProv:= iNst_Cob
   vernr()
   wMerro:= " Codigo de Mora nao numerico "
   wProv:= cOd_Mora
   vernr()
   wMerro:= " Valor da Mora nao numerico ou em branco "
   wProv:= mOra
   vernr()
   wMerro:= " Data de Desconto invalida ou em branco "
   wProv:= dT_Desc
   verdt()
   wMerro:= " Valor de Desconto nao numerico ou em branco "
   wProv:= vAl_Desc
   vernr()
   wMerro:= " Valor do Ioc nao numerico ou em branco "
   wProv:= vAl_Ioc
   vernr()
   wMerro:= " Valor do Abatimento nao numerico ou em branco "
   wProv:= aBatimento
   vernr()
   wMerro:= " Tipo de Inscricao diferente de 01 CPF ou 02 CGC "
   wProv:= tIpo_Cic
   IF ( cOd_Cart < "6" )
      IF ( tIpo_Cic < "00" .OR. tIpo_Cic > "02" )
         wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
            " / Cod. Registro: " + cOd_Reg + wMerro + wProv
      ENDIF
   ELSEIF ( tIpo_Cic != "00" )
      wMerro:= ;
         " Tipo de Inscricao (CPF ou CGC para Cheques deve estar zerada "
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Nr. de Inscricao CPF ou CGC invalido "
   wProv:= nR_Cic
   IF ( cOd_Cart < "6" )
      IF ( .NOT.fnr_cic(tIpo_Cic, nR_Cic) )
         wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
            " / Cod. Registro: " + cOd_Reg + wMerro + wProv
      ENDIF
   ELSE
      wMerro:= ;
         " Nr. de Inscricao (CPF/CGC) deve estar zerado para CHEQUES "
      IF ( nR_Cic != "00000000000000" )
         wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
            " / Cod. Registro: " + cOd_Reg + wMerro + wProv
      ENDIF
   ENDIF
   wMerro:= " Nome do Sacado em branco "
   wProv:= nOme_Sac
   veralfa()
   wMerro:= " Endereco do Sacado em branco "
   wProv:= eNd_Sac
   veralfa()
   wMerro:= " CEP Invalido "
   wProv:= cEp
   IF ( ( cEp = Space(5) .OR. cEp = "00000" ) .AND. cOd_Cart != "6" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ELSEIF ( cOd_Cart = "6" .AND. cEp = Space(5) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wProv:= cIdade
   IF ( cOd_Cart != "6" )
      wMerro:= " Cidade  nao deve estar em branco "
      veralfa()
   ELSEIF ( wProv != Space(15) )
      wMerro:= " Cidade nao precisa estar preenchido para CHEQUES "
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Estado nao pode estar em branco "
   wProv:= eStado
   IF ( cOd_Cart != "6" )
      veralfa()
   ELSEIF ( wProv != Space(2) )
      wMerro:= " Estado nao precisa estar preenchido para CHEQUES "
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Prazo de Protesto deve ser numerico ou zerado "
   wProv:= pRazo_Prot
   vernr()
   wMerro:= " Tipo de moeda deve ser 0 - Real "
   wProv:= tIpo_Moeda
   IF ( tIpo_Moeda != "0" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro + wProv
   ENDIF
   wMerro:= " Nr. sequencial do registro nao numerico ou em branco "
   wProv:= nR_Seq
   vernr()
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE VERTRAILER
 
   wProv:= fIller1 + cOd_Age + mOdalid + cOnta + fIller2 + fIller3 + ;
      nOsso_Nr + nR_Cont + cOd_Tarifa + cOd_Reapr + fIller4
   wProv:= wProv + cOd_Cart + iDent_Ser + nR_Doc + dT_Venc + ;
      vAl_Titulo + bAnco_Cob + fIller5 + eSp_Doc + aCeite + dT_Emis ;
      + iNst_Cob + cOd_Mora + mOra + dT_Desc + vAl_Desc + vAl_Ioc + ;
      aBatimento + tIpo_Cic + nR_Cic + nOme_Sac
   wProv:= wProv + sUp_Cep + eNd_Sac + fIller6 + cEp + cIdade + ;
      eStado + nR_Sacador + nO_Sacador + pRazo_Prot + tIpo_Moeda
   IF ( wProv != Space(391) )
      wMerro:= " Header - posicao 002 a 394 deve estar em branco "
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + wMerro
   ENDIF
   wMerro:= ;
      " Nr. Sequencial do registro no arquivo deve ser numerico e nao em branco "
   wProv:= nR_Seq
   vernr()
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE ZERACCHQ
 
   wCodages:= Space(4)
   wNage:= Space(16)
   wNbanco:= Space(20)
   wFone:= Space(8)
   wNome_Sac:= Space(28)
   wNr_Doc:= Space(10)
   wVal_Tit:= 0
   wNome_Sac:= Space(28)
   wDt_Venc:= CToD("  /  /  ")
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE ZERACFAT
 
   wNosso_Nr:= Space(8)
   wCod_Reapr:= Space(1)
   wNr_Doc:= Space(10)
   wDt_Venc:= CToD("  /  /  ")
   wVal_Tit:= 0
   wBanco_Cob:= Space(7)
   wAceite:= Space(1)
   wDt_Emis:= CToD("  /  /  ")
   wInst_Cob:= 0
   wCod_Mora:= 0
   wMora:= 0
   wDt_Desc:= CToD("  /  /  ")
   wVal_Desc:= 0
   wVal_Ioc:= 0
   wTipo_Cic:= 0
   wNr_Cic:= Space(15)
   wNome_Sac:= Space(37)
   wSup_Cep:= Space(3)
   wEnd_Sac:= Space(40)
   wCep:= Space(5)
   wCidade:= Space(15)
   wEstado:= Space(2)
   wNo_Sacado:= wNome
   wPrazo_Pro:= 0
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE ZERACHQ
 
   PUBLIC wCod_Reapr, wNr_Doc, wDt_Venc, wVal_Tit, wDt_Emis, ;
      wNome_Sac, wFone, wNbanco, wCodages, wNage, wSoma, wNra_Lote, ;
      wCapa_Lote, wTsoma
   wSoma:= 0
   wTsoma:= 0
   wCod_Reapr:= " "
   wDt_Emis:= CToD("  /  /  ")
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE ZERAEMP
 
   PUBLIC wNome, wCod_Age, wModalid, wNr_Conta, wUlt_Mov
   wNome:= Space(30)
   wCod_Age:= Space(5)
   wModalid:= Space(2)
   wNr_Conta:= Space(7)
   wUlt_Mov:= CToD("  /  /  ")
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE ZERAFAT
 
   PUBLIC wNosso_Nr, wCod_Tarif, wCod_Reapr, wCod_Cart, wIdent_Ser, ;
      wNr_Doc, wDt_Venc, wVal_Tit, wBanco_Cob, wEsp_Doc, wAceite, ;
      wDt_Emis, wInst_Cob, wCod_Mora, wMora, wDt_Desc, wVal_Desc, ;
      wVal_Ioc, wTipo_Cic, wNr_Cic, wNome_Sac, wSup_Cep, wEnd_Sac, ;
      wCep, wCidade
   PUBLIC wEstado, wNo_Sacado, wPrazo_Pro, wTipo_Moed, wSoma, ;
      wNra_Lote, wCapa_Lote, wTsoma
   wCod_Tarif:= Space(2)
   wCod_Cart:= Space(1)
   wIdent_Ser:= Space(2)
   wEsp_Doc:= Space(2)
   wTipo_Moed:= Space(1)
   wSoma:= 0
   wTsoma:= 0
 
* EOP
