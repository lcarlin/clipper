* BOP
#include "common.ch"
#include "inkey.ch"
 
STATIC Static1:= 0, Static2:= {{""}, {""}}
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION ALERTA( Arg1, Arg2, Arg3, Arg4, Arg5 )
 
   LOCAL Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
      Local15
   Local1:= ""
   Local2:= ""
   Local3:= IIF( ISNUMBER( Arg4 ), Arg4, 0 )
   Local4:= -2
   Local5:= 0
   Local6:= 0
   Local7:= 0
   Local8:= 0
   Local9:= 0
   Local10:= {}
   Local13:= setcursor(0)
   Local6:= 0
   IF ( ValType(Arg5) == "U" )
      Arg5:= .T.
   ENDIF
   IF ( Arg5 )
      Local14:= SetColor("R/W, W/B")
   ELSE
      Local14:= SetColor("B/W, W/R")
   ENDIF
   DO WHILE ( Local6 <= Len(Arg3) )
      Local2:= SubStr(Arg3, ++Local6, 1)
      IF ( Local2 != "%" )
         Local9:= Len(Local1:= Local1 + Local2)
      ELSE
         AAdd(Local10, Local1)
         Local1:= ""
      ENDIF
      IF ( Local9 > Local8 )
         Local8:= Local9
         Local9:= 0
      ENDIF
   ENDDO
   AAdd(Local10, Local1)
   Local11:= Arg1 + IIF( ISNUMBER( Arg4 ), 3, 5 ) + Len(Local10)
   IF ( ISARRAY( Arg4 ) )
      aeval(Arg4, { |_1| Local4:= Local4 + ( Len(_1) + 2 ) })
   ENDIF
   Local12:= Max(Arg2 + 5 + Local8, Arg2 + 5 + Local4)
   Local15:= SaveScreen(Arg1, Arg2, Local11 + 1, Local12 + 2)
   caixa(Arg1, Arg2, Local11, Local12, "S", "S", "S")
   FOR Local6:= 1 TO Len(Local10)
      @ Row() + 1, Arg2 + 2 SAY padc(Local10[ Local6 ], Local12 - ;
         Arg2 - 2)
   NEXT
   IF ( Local3 == 0 )
      Local7:= ( Local12 - Arg2 - Local4 ) / 2 + Arg2
      DO WHILE ( .T. )
         SetPos(Local11 - 2, Local7 - 1)
         FOR Local6:= 1 TO Len(Arg4)
            @ Row(), Col() + 2 PROMPT Arg4[ Local6 ]
         NEXT
         MENU TO Local5
         IF ( Local5 > 0 )
            EXIT
         ENDIF
      ENDDO
   ELSE
      InKey(Local3)
   ENDIF
   setcursor(Local13)
   SET COLOR TO (Local14)
   RestScreen(Arg1, Arg2, Local11 + 1, Local12 + 2, Local15)
   RETURN Local5
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE ALTVALOR
 
   CLOSE DATABASES
   RESTORE SCREEN FROM wT1
   mensagem("ALTERANDO VALOR/DATA DAS FATURAS", "T")
   wValor:= 0
   wData:= CToD("  /  /  ")
   DO WHILE ( .T. )
      @ 10, 10 SAY "ENTRE COM O VALOR DAS FATURAS: " GET WVALOR ;
         PICTURE "999,999,999.99"
      @ 12, 10 SAY "ENTRE COM A DATA DE VENCIMENTO: " GET WDATA
      READ
      mensagem("CONFIRMA A ALTERACAO COM OS DADOS ACIMA (S/N)? ", "S")
      IF ( wConf = "S" )
         USE FATURA
         wData1:= wData - 30
         IF ( Date() > wData - 32 )
            wData1:= Date()
         ENDIF
         DBEval({ || ( FIELD->vAl_Titulo:= wValor, FIELD->dT_Venc:= ;
            wData, FIELD->dT_Emis:= wData1 ) }, { || cApa_Lote != ;
            "S" }, Nil, Nil, Nil, .F.)
         RETURN
      ENDIF
   ENDDO
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE BACKUP
 
   LOCAL Local1:= 1, Local2:= 0
   newdisk()
   IF ( LastKey() == K_ESC )
      wRet_Value:= 12
   ELSE
      SET CENTURY OFF
      wBackupid:= DToC(Date()) + " " + Time() + " "
      wBacktext:= wBackupid
      DO WHILE ( Local1 <= Len(wFilelist) )
         wSource:= LTrim(Upper(wFilelist[ Local1 ]))
         wTarget:= Upper(wDrive) + wSource
         IF ( .NOT.opensource() .OR. .NOT.opentarget() )
            wRet_Value:= 2
            RETURN
         ENDIF
         mensagem("Copiando o arquivo " + wSource + " para o drive " ;
            + wDrive + " - Disco Nr. " + LTrim(Str(wDiskno)))
         DO WHILE ( wRemaining > 0 )
            Local2:= diskspace(Asc(wDrive) - 64)
            IF ( Local2 <= 2048 )
               wSize:= wInitsize
               wBuffer:= ""
               wBuffer:= Space(wSize)
               fclose(wThandle)
               IF ( Empty(filedate(wTarget, wSourcedt)) .OR. ;
                     Empty(filetime(wTarget, wSourceti)) )
                  alert("Erro gravando o arquivo com data e hora " + ;
                     wTarget, Nil, "/BG")
                  wRet_Value:= 6
                  RETURN
               ENDIF
               wBackfile:= wDrive + "BACKUP" + LTrim(Str(wDiskno)) + ;
                  ".DAT"
               wBacktext:= wBacktext + SubStr(wTarget, 3) + "+ "
               IF ( .NOT.memowrit(wBackfile, wBacktext) )
                  alert("Erro na gravacao da identificacao do arquivo de backup ", ;
                     Nil, "/BG")
                  wRet_Value:= 7
                  RETURN
               ENDIF
               wBacktext:= wBackupid
               wDiskno++
               insertdisk()
               newdisk()
               IF ( LastKey() == K_ESC )
                  wRet_Value:= 12
                  RETURN
               ENDIF
               wThandle:= fcreate(wTarget)
               IF ( ferror() > 0 )
                  alert("ERRO FATAL! Nao pode criar arquivo " + ;
                     wTarget, Nil, "/BG")
                  wRet_Value:= 6
                  RETURN
               ENDIF
               mensagem("Copiando arquivo " + wSource + ;
                  " para drive " + wDrive + " - Disco Nr. " + ;
                  LTrim(Str(wDiskno)), " ")
            ELSE
               IF ( Local2 - 2048 > wInitsize )
                  wSize:= wInitsize
               ELSE
                  wSize:= Local2 - 2048
               ENDIF
               wBuffer:= ""
               wBuffer:= Space(wSize)
            ENDIF
            IF ( .NOT.copybuffer() )
               RETURN
            ENDIF
         ENDDO
         IF ( .NOT.closefiles() )
            RETURN
         ENDIF
         wBackfile:= wDrive + "BACKUP" + LTrim(Str(wDiskno)) + ".DAT"
         wBacktext:= wBacktext + SubStr(wTarget, 3) + "! "
         IF ( .NOT.memowrit(wBackfile, wBacktext) )
            alert("Erro na gravacao do backup ", Nil, "/BG")
            wRet_Value:= 7
            RETURN
         ENDIF
         Local1++
      ENDDO
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE BACKUP1
 
   LOCAL Local1:= 1, Local2:= 0
   newdisk()
   IF ( LastKey() == K_ESC )
      wRet_Value:= 12
   ELSE
      SET CENTURY OFF
      wBackupid:= DToC(Date()) + " " + Time() + " "
      wBacktext:= wBackupid
      DO WHILE ( Local1 <= Len(wFilelist) )
         wSource:= LTrim(Upper(wFilelist[ Local1 ]))
         wTarget:= Upper(wDrive) + wSource
         IF ( .NOT.opensource() .OR. .NOT.opentarget() )
            wRet_Value:= 2
            RETURN
         ENDIF
         mensagem("Copiando o arquivo " + wSource + " para o drive " ;
            + wDrive + " - Disco Nr. " + LTrim(Str(wDiskno)))
         DO WHILE ( wRemaining > 0 )
            Local2:= diskspace(Asc(wDrive) - 64)
            IF ( Local2 <= 2048 )
               wSize:= 402
               wBuffer:= Space(402)
               fclose(wThandle)
               IF ( Empty(filedate(wTarget, wSourcedt)) .OR. ;
                     Empty(filetime(wTarget, wSourceti)) )
                  alert("Erro gravando o arquivo com data e hora " + ;
                     wTarget, Nil, "/BG")
                  wRet_Value:= 6
                  RETURN
               ENDIF
               wBackfile:= wDrive + "BACKUP" + LTrim(Str(wDiskno)) + ;
                  ".DAT"
               wBacktext:= wBacktext + SubStr(wTarget, 3) + "+ "
               IF ( .NOT.memowrit(wBackfile, wBacktext) )
                  alert("Erro na gravacao da identificacao do arquivo de backup ", ;
                     Nil, "/BG")
                  wRet_Value:= 7
                  RETURN
               ENDIF
               wBacktext:= wBackupid
               wDiskno++
               insertdisk()
               newdisk()
               IF ( LastKey() == K_ESC )
                  wRet_Value:= 12
                  RETURN
               ENDIF
               wThandle:= fcreate(wTarget)
               IF ( ferror() > 0 )
                  alert("ERRO FATAL! Nao pode criar arquivo " + ;
                     wTarget, Nil, "/BG")
                  wRet_Value:= 6
                  RETURN
               ENDIF
               mensagem("Copiando arquivo " + wSource + ;
                  " para drive " + wDrive + " - Disco Nr. " + ;
                  LTrim(Str(wDiskno)), " ")
            ELSE
               wSize:= 402
               wBuffer:= Space(402)
            ENDIF
            IF ( .NOT.copybuffe1() )
               RETURN
            ENDIF
         ENDDO
         IF ( .NOT.closefiles() )
            RETURN
         ENDIF
         wBackfile:= wDrive + "BACKUP" + LTrim(Str(wDiskno)) + ".DAT"
         wBacktext:= wBacktext + SubStr(wTarget, 3) + "! "
         IF ( .NOT.memowrit(wBackfile, wBacktext) )
            alert("Erro na gravacao do backup ", Nil, "/BG")
            wRet_Value:= 7
            RETURN
         ENDIF
         Local1++
      ENDDO
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE BLOQUETE
 
   wOpa:= 1
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem(" IMPRESSAO DE BLOQUETES", "T")
      @  9,  5, 11, 38 BOX wMold
      @ 15,  5, 17, 38 BOX wMold
      @  9, 41, 11, 74 BOX wMold
      @ 15, 41, 17, 74 BOX wMold
      @ 10,  8 PROMPT "A U T O    C O P I A T I V O"
      @ 16,  8 PROMPT "    DUPLO  PRE  IMPRESSO    "
      @ 10, 44 PROMPT [   T I P O  "T R I P A O"   ]
      @ 16, 44 PROMPT "  VOLTA AO MENU ANTERIOR    "
      MENU TO wOpa
      DO CASE
      CASE wOpa = 1
         wTbloq:= 1
         impbloq()
      CASE wOpa = 2
         wTbloq:= 2
         impbloq()
      CASE wOpa = 3
         wTbloq:= 3
         impbloq()
      CASE wOpa = 4 .OR. wOpa = 0
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE CABECCE
 
   @ PRow() + 1,  1 SAY Space(133)
   @ PRow() + 1,  3 SAY "Nr.Cheque"
   @ PRow(), 16 SAY "Valor Cheque"
   @ PRow(), 33 SAY "Vencimento"
   @ PRow(), 46 SAY "Sacado"
   @ PRow(), 77 SAY "Fone"
   @ PRow(), 88 SAY "Nome Do Banco"
   @ PRow(), 111 SAY "Cod./Nome Da Agencia"
   @ PRow() + 1,  3 SAY "========="
   @ PRow(), 16 SAY "============"
   @ PRow(), 33 SAY "=========="
   @ PRow(), 46 SAY "======"
   @ PRow(), 77 SAY "===="
   @ PRow(), 88 SAY "============="
   @ PRow(), 111 SAY "===================="
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE CABECR( Arg1, Arg2 )
 
   @ PRow(),  0 SAY ""
   @ PRow() + 1,  0 SAY padc("SISTEMA DE ENTRADA DE DADOS COBRANCA", ;
      67)
   @ PRow(), 68 SAY "Data: " + DToC(Date()) + ""
   @ PRow() + 1,  0 SAY padc("RELATORIO PARA CONFERENCIA", 67)
   @ PRow(), 68 SAY "Hora: " + Time() + ""
   @ PRow() + 1,  0 SAY padc(Arg1, 67)
   @ PRow(), 68 SAY "Pag.: " + strzero(wPag, 3) + ""
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION CAIXA( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7 )
 
   IF ( Arg6 != "N" .OR. Arg6 = Nil )
      tela_zs(Arg1, Arg2 + 1, Arg3 - 1, Arg4)
   ENDIF
   IF ( Arg5 != "N" .OR. Arg5 = Nil )
      shadow(Arg1, Arg2, Arg3, Arg4, 8)
   ENDIF
   IF ( Arg7 != "S" .OR. Arg7 = Nil )
      @ Arg1, Arg2 CLEAR TO Arg3, Arg4
   ELSE
      @ Arg1, Arg2 TO Arg3, Arg4
      @ Arg1 + 1, Arg2 + 1 CLEAR TO Arg3 - 1, Arg4 - 1
   ENDIF
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION CHECKNEXT
 
   LOCAL Local1
   Local1:= 0
   setint24(.T.)
   DO WHILE ( .T. )
      diskspace(Asc(wDrive) - 64)
      Local1:= getint24()
      IF ( Local1 > 0 )
         alert("Drive " + wDrive + "nao esta pronto.", Nil, "/BG")
         IF ( LastKey() != K_ESC )
            LOOP
         ELSE
            wRet_Value:= 12
            RETURN .F.
         ENDIF
      ENDIF
      EXIT
   ENDDO
   setint24(.F.)
   wBackfile:= wDrive + "BACKUP" + LTrim(Str(wDiskno)) + ".DAT"
   DO WHILE ( .NOT.file(wBackfile) )
      alert("Disco Incorreto - Verifique!!!", Nil, "/BG")
      insertdisk()
      IF ( LastKey() == K_ESC )
         wRet_Value:= 12
         RETURN .F.
      ENDIF
   ENDDO
   wDisktext:= memoread(wBackfile)
   IF ( wDiskno == 1 )
      wBackupid:= SubStr(wDisktext, 1, 17)
   ELSE
      DO WHILE ( .NOT.( wBackupid == SubStr(wDisktext, 1, 17) ) .OR. ;
            .NOT.( wTarget == SubStr(wDisktext, 19, Len(wTarget)) ) )
         alert("Disco Invalido! - Verifique a sequencia.", Nil, "/BG")
         IF ( LastKey() == K_ESC )
            wRet_Value:= 12
            RETURN .F.
         ENDIF
      ENDDO
   ENDIF
   wBacktext:= SubStr(wDisktext, 19)
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
STATIC FUNCTION CLOSEFILES
 
   fclose(wThandle)
   fclose(wShandle)
   IF ( Empty(filedate(wTarget, wSourcedt)) .OR. ;
         Empty(filetime(wTarget, wSourceti)) )
      alert("ERRO de gravacao do arquivo " + wTarget, Nil, "/BG")
      wRet_Value:= 10
      RETURN .F.
   ENDIF
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION CLRSHADOW
 
   IF ( Static1 > 0 )
      scrnrest(Static2[ 1 ][ Static1 ])
      scrnrest(Static2[ 2 ][ Static1 ])
      Static1--
   ENDIF
   RETURN Nil
 
** Function Recovered By [O Cors rio(TM)] **
STATIC FUNCTION COPYBUFFE1
 
   wSize:= Len(wBuffer)
   IF ( wRemaining < wSize )
      wSize:= wRemaining
   ENDIF
   IF ( fread(wShandle, @wBuffer, wSize) != wSize )
      alert("ERRO de gravacao do arquivo " + wSource, Nil, "/BG")
      wRet_Value:= 8
      RETURN .F.
   ENDIF
   IF ( fwrite(wThandle, wBuffer, wSize) != wSize )
      alert("ERRO de gravacao do arquivo " + wTarget, Nil, "/BG")
      wRet_Value:= 9
      RETURN .F.
   ENDIF
   wRemaining:= wRemaining - wSize
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
STATIC FUNCTION COPYBUFFER
 
   wSize:= Len(wBuffer)
   IF ( wRemaining < wSize )
      wSize:= wRemaining
   ENDIF
   IF ( fread(wShandle, @wBuffer, wSize) != wSize )
      alert("ERRO de gravacao do arquivo " + wSource, Nil, "/BG")
      wRet_Value:= 8
      RETURN .F.
   ENDIF
   IF ( fwrite(wThandle, wBuffer, wSize) != wSize )
      alert("ERRO de gravacao do arquivo " + wTarget, Nil, "/BG")
      wRet_Value:= 9
      RETURN .F.
   ENDIF
   wRemaining:= wRemaining - wSize
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION C_CARTEIRA
 
   LOCAL Local1, Local2
   Local2:= SetColor()
   IF ( .NOT.( wCod_Cart $ "12456" ) )
      @ 10, 21 SAY "Û"
      SET COLOR TO "B/W,W/B"
      Local1:= SaveScreen(14, 42, 21, 79)
      vCarteira:= {}
      AAdd(vCarteira, "1 - Cob. Simples P.J.             ")
      AAdd(vCarteira, "2 - Cob. Simples P.F.             ")
      AAdd(vCarteira, "4 - Direta c/s Registro/Pers(P.J.)")
      AAdd(vCarteira, "5 - Direta c/s Registro/Pers(P.F.)")
      AAdd(vCarteira, "6 - Cob. de Cheques               ")
      caixa(14, 42, 20, 77, "S", "S", "N")
      wCar:= achoice(15, 43, 19, 76, vCarteira, .T., "FOPCOESCO")
      wCod_Cart:= SubStr(vCarteira[ wCar ], 1, 1)
      SET COLOR TO (Local2)
      RestScreen(14, 42, 21, 79, Local1)
   ENDIF
   RETURN .T.
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE DETALHE( Arg1 )
 
   @ PRow() + 1,  0 SAY ""
   IF ( Arg1 == 1 )
      @ PRow(),  3 SAY nOsso_Nr PICTURE "@R 9999999-9"
      @ PRow(), 13 SAY nR_Doc
      @ PRow(), 24 SAY SubStr(sAcado, 1, 20)
      @ PRow(), 46 SAY dT_Venc
      @ PRow(), 55 SAY dT_Pag
      @ PRow(), 63 SAY vAl_Titulo PICTURE "@E 99999,999,999.99"
      @ PRow(), 78 SAY vAl_Pago PICTURE "@E 99,999,999,999.99"
      @ PRow(), 98 SAY iDent_Ser
      @ PRow(), 100 SAY vAl_Pago - vAl_Titulo PICTURE ;
         "@E 9,999,999,999.99"
      @ PRow(), 117 SAY vAlor_Tar PICTURE "@E 99,999,999,999.99"
      wTot1:= vAl_Titulo + wTot1
      wTot2:= vAl_Pago + wTot2
      wTot3:= vAl_Pago - vAl_Titulo + wTot3
      wTot4:= vAlor_Tar + wTot4
      wSub1:= vAl_Titulo + wSub1
      wSub2:= vAl_Pago + wSub2
      wSub3:= vAl_Pago - vAl_Titulo + wSub3
      wSub4:= vAlor_Tar + wSub4
   ELSEIF ( Arg1 == 2 )
      @ PRow(),  6 SAY nOsso_Nr PICTURE "@R 9999999-9"
      @ PRow(), 19 SAY nR_Doc
      @ PRow(), 32 SAY SubStr(sAcado, 1, 20)
      @ PRow(), 56 SAY dT_Venc
      @ PRow(), 67 SAY vAl_Titulo PICTURE "@E 99,999,999,999.99"
      @ PRow(), 91 SAY eSp_Doc
      @ PRow(), 100 SAY cOd_Cart
      @ PRow(), 110 SAY vAlor_Tar PICTURE "@E 99,999,999,999.99"
      wTot1:= vAl_Titulo + wTot1
      wTot2:= vAlor_Tar + wTot2
      wSub1:= vAl_Titulo + wSub1
      wSub2:= vAlor_Tar + wSub2
   ELSEIF ( Arg1 == 3 )
      @ PRow(),  6 SAY nOsso_Nr PICTURE "@R 9999999-9"
      @ PRow(), 19 SAY nR_Doc
      @ PRow(), 32 SAY SubStr(sAcado, 1, 20)
      @ PRow(), 56 SAY dT_Venc
      @ PRow(), 67 SAY vAl_Titulo PICTURE "@E 99,999,999,999.99"
      @ PRow(), 91 SAY eSp_Doc
      @ PRow(), 100 SAY cOd_Cart
      @ PRow(), 110 SAY bAnco_Cob
      wTot1:= vAl_Titulo + wTot1
      wSub1:= vAl_Titulo + wSub1
   ENDIF
   wSums++
   wSumt++
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION DIA
 
   PARAMETERS wDataso
   PRIVATE w_Dt
   w_Dt:= DoW(wDataso)
   DO CASE
   CASE w_Dt == 1
      RETURN " Domingo"
   CASE w_Dt == 2
      RETURN " Segunda"
   CASE w_Dt == 3
      RETURN " Terca"
   CASE w_Dt == 4
      RETURN " Quarta"
   CASE w_Dt == 5
      RETURN " Quinta"
   CASE w_Dt == 6
      RETURN " Sexta"
   CASE w_Dt == 7
      RETURN " Sabado"
   ENDCASE
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE EXPORTA
 
   CLOSE DATABASES
   SELECT 1
   USE EMPRESA
   zeraemp()
   leemp()
   CLOSE
   SELECT 2
   USE REG
   ZAP
   SELECT 1
   USE FATURA
   IF ( EOF() )
      USE CHEQUE
      wCheque:= "S"
   ENDIF
   GOTO TOP
   wCheque:= "N"
   wNr_Lote:= 0
   wDatah:= CToD("  /  /  ")
   RESTORE SCREEN FROM wT1
   mensagem("G E R A   A R Q U I V O   P A R A   N C - N B", "T")
   DO WHILE ( .T. )
      @ 12, 15 SAY "ENTRE COM A DATA DO MOVIMENTO " GET WDATAH
      READ
      IF ( wDatah != Date() )
         mensagem("CONFIRMA A DATA DO MOVIMENTO (S/N)? ", "N")
         IF ( wConf = "N" )
            LOOP
         ENDIF
      ENDIF
      EXIT
   ENDDO
   wData1:= DToC(wDatah)
   wDatahc:= SubStr(wData1, 1, 2) + SubStr(wData1, 4, 2) + ;
      SubStr(wData1, 7, 2)
   wTrailler:= "N"
   mensagem("GERANDO ARQUIVO PARA ENVIO A NOSSA CAIXA NOSSO BANCO", ;
      " ")
   SET COLOR TO N/W
   caixa(9, 9, 17, 71)
   @ 10, 10 SAY ;
      "Lembre-se de que somente na opcao - FAZ COPIA DE SEGURANCA do"
   @ 12, 10 SAY ;
      "Menu de Manutencao e que o arquivo de Faturas e Cheques pode-"
   @ 14, 10 SAY ;
      "ra ser REINICIALIZADO. Portanto nao deixe de fazer a Copia de"
   @ 16, 10 SAY ;
      "Seguranca apos ter gerado o arquivo no padrao CNAB para NC-NB"
   SET COLOR TO W/N
   DO WHILE ( .NOT.EOF() )
      SELECT 1
      IF ( cApa_Lote = "S" )
         IF ( wTrailler = "S" )
            SELECT 2
            APPEND BLANK
            REPLACE cAmpo1 WITH "9" + Space(199)
            REPLACE cAmpo2 WITH Space(194) + "000000"
            wTrailler:= "N"
            LOOP
         ELSE
            wVar1:= "01REMESSA01COBRANCA" + Space(7) + ;
               SubStr(wCod_Age, 1, 4) + wModalid + "0" + wNr_Conta + ;
               Space(1) + "*" + Space(4) + wNome + "151" + "NC-NB" + ;
               Space(10) + wDatahc + Space(289) + "00000000000"
            wTrailler:= "S"
         ENDIF
      ELSE
         IF ( nOsso_Nr = Space(4) )
            wNossonu:= 0
         ELSE
            wNossonu:= Val(nOsso_Nr)
         ENDIF
         IF ( cOd_Tarifa = Space(2) )
            wCodtarifa:= 0
         ELSE
            wCodtarifa:= Val(cOd_Tarifa)
         ENDIF
         wVar1:= "1" + Space(16) + SubStr(wCod_Age, 1, 4) + wModalid ;
            + "0" + wNr_Conta + Space(6) + Space(25) + ;
            strzero(wNossonu, 8) + "0000000000" + ;
            strzero(wCodtarifa, 2) + strzero(Val(cOd_Reapr), 1) + ;
            Space(24) + strzero(Val(cOd_Cart), 1) + ;
            strzero(Val(iDent_Ser), 2) + nR_Doc
         wData1:= DToC(dT_Venc)
         IF ( wData1 = "  /  /  " )
            wData1:= "00/00/00"
         ENDIF
         wData:= SubStr(wData1, 1, 2) + SubStr(wData1, 4, 2) + ;
            SubStr(wData1, 7, 2)
         wValor:= strzero(vAl_Titulo * 100, 13)
         wValorcon:= wValor
         wVar1:= wVar1 + wData + wValorcon + strzero(Val(bAnco_Cob), ;
            7) + Space(1) + strzero(Val(eSp_Doc), 2) + aCeite
         wData1:= DToC(dT_Emis)
         IF ( wData1 = "  /  /  " )
            wData1:= "00/00/00"
         ENDIF
         wData:= SubStr(wData1, 1, 2) + SubStr(wData1, 4, 2) + ;
            SubStr(wData1, 7, 2)
         wVar1:= wVar1 + wData + strzero(iNst_Cob, 4) + ;
            strzero(cOd_Mora, 1) + strzero(mOra * 100, 12)
         wData1:= DToC(dT_Desc)
         IF ( wData1 = "  /  /  " )
            wData1:= "00/00/00"
         ENDIF
         wData:= SubStr(wData1, 1, 2) + SubStr(wData1, 4, 2) + ;
            SubStr(wData1, 7, 2)
         IF ( nR_Cic = Space(5) )
            wNr_Cic:= "00000000000000"
         ELSE
            wNr_Cic:= nR_Cic
         ENDIF
         wVar1:= wVar1 + wData + strzero(vAl_Desc * 100, 13) + ;
            strzero(vAl_Ioc * 100, 13) + strzero(aBatimento * 100, ;
            13) + strzero(tIpo_Cic, 2) + wNr_Cic + nOme_Sac + ;
            strzero(Val(sUp_Cep), 3) + eNd_Sac + Space(15) + ;
            strzero(Val(cEp), 5) + cIdade + eStado + nR_Sacador
         wVar1:= wVar1 + nO_Sacador + strzero(pRazo_Prot, 2) + ;
            tIpo_Moeda + "000000"
      ENDIF
      SELECT 2
      APPEND BLANK
      REPLACE cAmpo1 WITH SubStr(wVar1, 1, 200)
      REPLACE cAmpo2 WITH SubStr(wVar1, 201, 200)
      SELECT 1
      SKIP
      IF ( EOF() .AND. wCheque = "N" )
         USE CHEQUE
         wCheque:= "S"
      ENDIF
   ENDDO
   SELECT 2
   APPEND BLANK
   REPLACE cAmpo1 WITH "9" + Space(199)
   REPLACE cAmpo2 WITH Space(194) + "000000"
   IF ( file("ECPP.TXT") )
      ERASE ECPP.TXT
   ENDIF
   IF ( file("F88CNAB.TXT") )
      ERASE F88CNAB.TXT
   ENDIF
   COPY TO ECPP.TXT SDF ALL
   CLOSE DATABASES
   IF ( alert("Voce quer Copiar o arquivo CNAB para Disquete?", ;
         {"Sim", "Nao"}, "W/R") == 1 )
      PRIVATE fIlelist[1]
      IF ( alert("Arquivo sera usado na Cobranca via Disquete", ;
            {"Sim", "Nao"}, "W/R") == 1 )
         RENAME ECPP.TXT TO F88CNAB.TXT
         fIlelist[ 1 ]:= "F88CNAB.TXT"
      ELSE
         fIlelist[ 1 ]:= "ECPP.TXT"
      ENDIF
      DO WHILE ( .T. )
         eRror_Flag:= syssave1(1, fIlelist)
         IF ( eRror_Flag != 0 )
            mensagem("OPERACAO DE BACKUP COM ERRO " + ;
               LTrim(Str(eRror_Flag)), "P")
            RETURN
         ELSEIF ( alert("Voce quer Copiar para outro Disquete?", ;
               {"Sim", "Nao"}, "W/R") == 1 )
            LOOP
         ELSE
            RETURN
         ENDIF
      ENDDO
   ENDIF
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FCOD_AGE
 
   wDig:= 0
   FOR i:= 1 TO 4
      wDig:= Val(SubStr(wCod_Age, i, 1)) * ( 6 - i ) + wDig
   NEXT
   wDig:= wDig % 11
   IF ( wDig == 0 )
      wDig:= 1
   ELSEIF ( wDig == 1 )
      wDig:= 0
   ELSE
      wDig:= 11 - wDig
   ENDIF
   IF ( wDig = Val(SubStr(wCod_Age, 5, 1)) )
      RETURN .T.
   ELSE
      RETURN .F.
   ENDIF
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FESPECIE( Arg1 )
 
   LOCAL Local1
   Local1:= SetColor()
   IF ( Val(Arg1) > 20 )
      SET COLOR TO "B/W"
      caixa(14, 3, 17, 77, "S", "S")
      @ 15,  3 SAY ;
         "Lembrete: Codigo implica que Bloquete sera impresso na NOSSA CAIXA"
      @ 16,  3 SAY "          NOSSO NUMERO Devera ficar em branco"
   ELSEIF ( Val(Arg1) < 20 )
      @ 15,  3 SAY ;
         "Lembrete: Codigo implica que Bloquete sera impresso no proprio cliente"
      @ 16,  3 SAY "          NOSSO NUMERO Devera ser preenchido"
   ENDIF
   SET COLOR TO (Local1)
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FILESIZE( Arg1 )
 
   LOCAL Local1
   Local1:= fIle_Size:= 0
   Local1:= fopen(Arg1, 0)
   fIle_Size:= IIF( Local1 != -1, fseek(Local1, 0, 2), -1 )
   fclose(Local1)
   RETURN fIle_Size
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE FILTRABLOQ
 
   LOCAL Local1[4]
   Local1[ 1 ]:= "Nao Seleciona  "
   Local1[ 2 ]:= "Documento (Nr) "
   Local1[ 3 ]:= "Sacado  (Nome) "
   Local1[ 4 ]:= "Nosso Numero   "
   wOpb:= tela_esc("Seleciona  por: ", Local1)
   PUBLIC wFiltroi, wFiltrof
   DO WHILE ( .T. )
      DO CASE
      CASE wOpb = 2
         wFiltroi:= wFiltrof:= Space(10)
         @ 16, 10 SAY "ENTRE COM O NR. DOCUMENTO INICIAL: " GET ;
            WFILTROI PICTURE "@!"
         @ 18, 10 SAY "ENTRE COM O NR. DOCUMENTO FINAL  : " GET ;
            WFILTROF PICTURE "@!"
         READ
      CASE wOpb = 3
         wFiltroi:= Space(37)
         @ 16, 10 SAY "ENTRE COM O NOME DO SACADO: " GET WFILTROI ;
            PICTURE "@!"
         READ
      CASE wOpb = 1
         RESTORE SCREEN FROM wT1
         mensagem("IMPRESSAO DE BLOQUETES", "T")
         RETURN
      CASE wOpb = 4
         RESTORE SCREEN FROM wT1
         wFiltroi:= wFiltrof:= 0
         @ 16, 13 SAY "ENTRE COM O NOSSO NR. INICIAL: " GET WFILTROI ;
            PICTURE "9999999"
         @ 18, 13 SAY "ENTRE COM O NOSSO NR. FINAL  : " GET WFILTROF ;
            PICTURE "9999999"
         READ
      ENDCASE
      mensagem("CONFIRMA OS DADOS DE SELECAO DO ARQUIVO (S/N)?", "S")
      IF ( wConf = "S" )
         EXIT
      ENDIF
   ENDDO
   IF ( wOpb = 2 )
      IF ( wFiltrof = Space(10) )
         wFiltrof:= "ZZZZZZZZZZ"
      ENDIF
      SET FILTER TO NR_DOC >= WFILTROI .AND. NR_DOC <= WFILTROF
   ELSEIF ( wOpb = 3 )
      wFiltroi:= alltrim(wFiltroi)
      SET FILTER TO SUBSTR(NOME_SAC,1,LEN(WFILTROI)) = WFILTROI
   ELSEIF ( wOpb = 4 )
      IF ( wFiltrof == 0 )
         wFiltrof:= 9999999.0
      ENDIF
      ordcondset("VAL(SUBSTR(NOSSO_NR,1,7)) >= WFILTROI .AND.  VAL(SUBSTR(NOSSO_NR,1,7)) <= WFILTROF", ;
         { || Val(SubStr(nOsso_Nr, 1, 7)) >= wFiltroi .AND. ;
         Val(SubStr(nOsso_Nr, 1, 7)) <= wFiltrof }, Nil, Nil, Nil, ;
         Nil, RecNo(), Nil, Nil, Nil, Nil)
      ordcreate("IPROV", Nil, "NOSSO_NR", { || nOsso_Nr }, Nil)
   ENDIF
   GOTO TOP
   mensagem("Confira a Selecao e apos tecle ESC para retornar", " ")
   setcursor(0)
   PRIVATE wNcampo[5], wMasc[5], wCabec[5]
   wNcampo[ 1 ]:= "NR_DOC"
   wNcampo[ 2 ]:= "VAL_TITULO"
   wNcampo[ 3 ]:= "DT_VENC"
   wNcampo[ 4 ]:= "NOME_SAC"
   wNcampo[ 5 ]:= "NOSSO_NR"
   wCabec[ 1 ]:= "NR. DOC. "
   wCabec[ 2 ]:= "VALOR TITULO"
   wCabec[ 3 ]:= "DT. VENC."
   wCabec[ 4 ]:= "NOME DO SACADO"
   wCabec[ 5 ]:= "NOSSO NR."
   wMasc[ 1 ]:= "@!"
   wMasc[ 2 ]:= "999,999,999.99"
   wMasc[ 3 ]:= " "
   wMasc[ 4 ]:= "@S20"
   wMasc[ 5 ]:= "@R 9999999-9"
   dbedit(7, 2, 19, 77, wNcampo, Nil, wMasc, wCabec)
   RESTORE SCREEN FROM wT1
   mensagem("IMPRESSAO DE BLOQUETES", "T")
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FMODALID
 
   IF ( wModalid = "01" .OR. wModalid = "04" .OR. wModalid = "13" ;
         .OR. wModalid = "16" .OR. wModalid = "17" )
      RETURN .T.
   ELSE
      RETURN .F.
   ENDIF
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FNOSSONR( Arg1 )
 
   IF ( Arg1 != Nil )
      wNosso_Nr:= Str(Arg1, 7)
   ELSEIF ( wNosso_Nr = Space(5) )
      RETURN .T.
   ENDIF
   wConta:= SubStr(wCod_Age, 1, 4) + wModalid + "0" + wNr_Conta + ;
      wNosso_Nr
   PRIVATE wDig[22]
   FOR i:= 1 TO 22
      wDig[ i ]:= Val(SubStr(wConta, i, 1))
   NEXT
   wDigito:= wDig[ 1 ] * 3 + wDig[ 2 ] * 1 + wDig[ 3 ] * 9 + ;
      wDig[ 4 ] * 7 + wDig[ 5 ] * 3 + wDig[ 6 ] * 1 + wDig[ 7 ] * 9 ;
      + wDig[ 8 ] * 7 + wDig[ 9 ] * 3 + wDig[ 10 ] * 1 + wDig[ 11 ] ;
      * 9 + wDig[ 12 ] * 7
   wDigito:= wDigito + wDig[ 13 ] * 3 + wDig[ 14 ] * 1 + wDig[ 15 ] ;
      * 9 + wDig[ 16 ] * 7 + wDig[ 17 ] * 3 + wDig[ 18 ] * 1 + ;
      wDig[ 19 ] * 9 + wDig[ 20 ] * 7 + wDig[ 21 ] * 3
   wDigito:= 10 - wDigito % 10
   IF ( wDigito == 10 )
      wDigito:= 0
   ENDIF
   IF ( Arg1 = Nil )
      IF ( wDigito = wDig[ 22 ] )
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   ENDIF
   wNosso_Nr:= strzero(Arg1, 7) + Str(wDigito, 1)
   RETURN wNosso_Nr
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FNR_CIC
 
   PARAMETERS wTipocic, wNrcic
   IF ( wTipocic != Nil )
      wTipo_Cic:= Val(wTipocic)
      IF ( wTipo_Cic == 1 )
         wNr_Cic:= SubStr(wNrcic, 4, 9) + "0000" + SubStr(wNrcic, ;
            13, 2)
      ELSE
         wNr_Cic:= "0" + wNrcic
      ENDIF
      IF ( wNr_Cic = "00000000000000" )
         RETURN .T.
      ENDIF
   ELSEIF ( wNr_Cic = Space(5) .OR. wTipo_Cic = 0 )
      wNr_Cic:= "000000000000000"
      RETURN .T.
   ENDIF
   IF ( wTipo_Cic == 1 )
      wDig:= 0
      FOR i:= 1 TO 9
         wDig:= Val(SubStr(wNr_Cic, i, 1)) * ( 11 - i ) + wDig
      NEXT
      wDig:= 11 - wDig % 11
      IF ( wDig = 10 .OR. wDig = 11 )
         wDig:= 0
      ENDIF
      IF ( wDig != Val(SubStr(wNr_Cic, 14, 1)) )
         RETURN .F.
      ENDIF
      wDig:= 0
      FOR i:= 1 TO 9
         wDig:= Val(SubStr(wNr_Cic, i, 1)) * ( 12 - i ) + wDig
      NEXT
      wDig:= Val(SubStr(wNr_Cic, 14, 1)) * 2 + wDig
      wDig:= 11 - wDig % 11
      IF ( wDig = 10 .OR. wDig = 11 )
         wDig:= 0
      ENDIF
      IF ( wDig != Val(SubStr(wNr_Cic, 15, 1)) )
         RETURN .F.
      ELSE
         RETURN .T.
      ENDIF
   ELSE
      wDig:= 0
      PRIVATE wDigito[14]
      FOR i:= 2 TO 15
         wDigito[ i - 1 ]:= Val(SubStr(wNr_Cic, i, 1))
      NEXT
      FOR i:= 1 TO 7
         wTy:= i % 2 + 1
         wD:= IIF( wDigito[ i ] * wTy > 9, wDigito[ i ] * wTy - 9, ;
            wDigito[ i ] * wTy )
         wDig:= wDig + wD
      NEXT
      wDig:= 10 - wDig % 10
      IF ( wDig == 10 )
         wDig:= 0
      ENDIF
      IF ( wDig != wDigito[ 8 ] )
         RETURN .F.
      ENDIF
      wDig:= 0
      FOR i:= 1 TO 4
         wDig:= wDigito[ i ] * ( 6 - i ) + wDig
      NEXT
      FOR i:= 5 TO 12
         wDig:= wDigito[ i ] * ( 14 - i ) + wDig
      NEXT
      wDig:= 11 - wDig % 11
      IF ( wDig = 10 .OR. wDig = 11 )
         wDig:= 0
      ENDIF
      IF ( wDig != wDigito[ 13 ] )
         RETURN .F.
      ENDIF
      wDig:= 0
      FOR i:= 1 TO 5
         wDig:= wDigito[ i ] * ( 7 - i ) + wDig
      NEXT
      FOR i:= 6 TO 12
         wDig:= wDigito[ i ] * ( 15 - i ) + wDig
      NEXT
      wDig:= wDigito[ 13 ] * 2 + wDig
      wDig:= 11 - wDig % 11
      IF ( wDig = 10 .OR. wDig = 11 )
         wDig:= 0
      ENDIF
      IF ( wDig != wDigito[ 14 ] )
         RETURN .F.
      ELSE
         RETURN .T.
      ENDIF
   ENDIF
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FNR_CONTA
 
   wConta:= SubStr(wCod_Age, 1, 4) + wModalid + wNr_Conta
   wDig:= 0
   FOR i:= 1 TO 6
      wDig:= Val(SubStr(wConta, i, 1)) * ( 8 - i ) + wDig
   NEXT
   FOR i:= 7 TO 12
      wDig:= Val(SubStr(wConta, i, 1)) * ( 14 - i ) + wDig
   NEXT
   wDig:= wDig % 11
   IF ( wDig == 0 )
      wDig:= 1
   ELSEIF ( wDig == 1 )
      wDig:= 0
   ELSE
      wDig:= 11 - wDig
   ENDIF
   IF ( wDig = Val(SubStr(wConta, 13, 1)) )
      RETURN .T.
   ELSE
      RETURN .F.
   ENDIF
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION FOPCOESCO( Arg1, Arg2, Arg3 )
 
   IF ( Arg1 == 3 )
      IF ( LastKey() == K_ENTER )
         RETURN 1
      ELSEIF ( LastKey() == K_ESC )
         RETURN 3
      ELSE
         RETURN 3
      ENDIF
   ELSEIF ( Arg1 == 1 )
      KEYBOARD Chr(30)
      RETURN 2
   ELSEIF ( Arg1 == 2 )
      KEYBOARD Chr(31)
      RETURN 2
   ELSE
      RETURN 2
   ENDIF
   RETURN 0
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE GETCCHQ
 
   @ 13,  2 CLEAR TO 19, 78
   @ 14,  3 SAY "Nr. Cheque:"
   @ 14, 15 GET WNR_DOC PICTURE "!!!!!!!!!!" VALID wNr_Doc != Space(5)
   @ 14, 30 SAY " Valor Cheque: "
   @ 14, 44 GET WVAL_TIT PICTURE "@R 99,999,999.99" VALID wVal_Tit ;
      != 0
   @ 16,  3 SAY "Vencimento:"
   @ 16, 16 GET WDT_VENC VALID wDt_Venc > wDt_Emis
   @ 16, 26 SAY "Sacado:"
   @ 16, 34 GET WNOME_SAC PICTURE "@!" VALID wNome_Sac != Space(4)
   @ 16, 64 SAY "Fone: "
   @ 16, 70 GET WFONE PICTURE "999-9999"
   @ 18,  3 SAY "  Nome do Banco "
   @ 19,  3 GET wnbanco PICTURE "!!!!!!!!!!!!!!!!!!!!" VALID wNbanco ;
      != Space(4)
   @ 18, 30 SAY "Codigo  e  Nome da Agencia "
   @ 19, 31 GET wcodages PICTURE "9999" VALID wCodages != Space(3)
   @ 19, 41 GET wnage PICTURE "!!!!!!!!!!!!!!!!" VALID wNage != ;
      Space(3)
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE GETCFAT
 
   @  7,  2 CLEAR TO 19, 78
   @  7,  3 SAY " Nr. doc. "
   @  8,  3 GET WNR_DOC PICTURE "!!!!!!!!!!"
   @  7, 15 SAY "Dt.Emissao "
   @  8, 16 GET WDT_EMIS VALID wDt_Emis > CToD("01/01/93")
   @  7, 29 SAY "   Valor Titulo "
   IF ( wTipo_Moed $ "0" )
      @  8, 31 GET WVAL_TIT PICTURE "@R 99,999,999,999.99"
   ELSE
      @  8, 28 GET WVAL_TIT PICTURE "@R 99,999,999,999.99999"
   ENDIF
   @  7, 52 SAY "Vencimento "
   @  8, 53 GET WDT_VENC VALID wDt_Venc > wDt_Emis
   @  7, 65 SAY "Nosso Nr. "
   @  8, 65 GET WNOSSO_NR PICTURE "@R 9999999-9" VALID fnossonr()
   @  9,  3 SAY "Prazo Protesto "
   @ 10,  8 GET WPRAZO_PRO PICTURE "99"
   @  9, 21 SAY "Cod. e Valor da Mora "
   @ 10, 22 GET WCOD_MORA PICTURE "9" VALID wCod_Mora < 2
   @ 10, 24 GET WMORA PICTURE "@R 9,999,999,999.99"
   @  9, 45 SAY "Dt. Desconto "
   @ 10, 47 GET WDT_DESC
   @  9, 59 SAY " Valor Desconto  "
   @ 10, 59 GET WVAL_DESC PICTURE "@R 9,999,999,999.99" VALID ;
      wVal_Desc < wVal_Tit
   @ 11,  3 SAY "Aceite "
   @ 12,  5 GET WACEITE PICTURE "!" VALID wAceite $ "AN"
   @ 11, 11 SAY " Cobradora "
   @ 12, 13 GET WBANCO_COB PICTURE "@R 999-9999"
   @ 11, 24 SAY "Inst. Cob. "
   @ 12, 27 GET WINST_COB PICTURE "9999"
   @ 11, 37 SAY "    Valor IOC   "
   @ 12, 37 GET WVAL_IOC PICTURE "@r 9,999,999,999.99"
   @ 14,  3 SAY "         Nome Sacado "
   @ 15,  3 GET WNOME_SAC PICTURE "@!S30 " VALID wNome_Sac != ;
      Space(20)
   @ 14, 47 SAY "End.Sacado  "
   @ 15, 37 GET WEND_SAC PICTURE "@!" VALID wEnd_Sac != Space(15)
   @ 16,  3 SAY "UF "
   @ 17,  3 GET WESTADO PICTURE "!!" VALID wEstado $ ;
      "SP,PR,SC,RS,RJ,MG,ES,MS,MT,GO,TO,SE,PE,BA,RN,AL,CE,PR,AM,RO,RD,AC,PI,MA,DF,PB,AP"
   @ 16, 10 SAY "   Cep    "
   @ 17,  8 GET WCEP PICTURE "99999" VALID wCep != Space(5)
   @ 17, 14 GET WSUP_CEP PICTURE "999"
   @ 16, 22 SAY "  Cidade   "
   @ 17, 22 GET WCIDADE PICTURE "@!" VALID wCidade != Space(5)
   @ 16, 41 SAY "Tipo CGC/CPF "
   @ 17, 45 GET WTIPO_CIC PICTURE "99" VALID wTipo_Cic < 3 .AND. ;
      wTipo_Cic >= 0
   @ 16, 54 SAY "     CGC/CPF     "
   @ 17, 54 GET WNR_CIC PICTURE "@R 999.999.999/9999-99" VALID ;
      fnr_cic()
   @ 19,  3 SAY "Nome do Sacador " GET WNO_SACADO PICTURE "@K!"
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE GETCHQ
 
   @  7,  2 CLEAR TO 19, 78
   @  8,  3 SAY "Nr. do Lote"
   SET COLOR TO N/W
   IF ( tEcla == -1 )
      @  8, 17 SAY wNr_Lotec PICTURE "999"
   ELSE
      @  8, 17 SAY wNra_Lote PICTURE "999"
   ENDIF
   SET COLOR TO
   @  8, 25 SAY "CODIGO REAPRESENTACAO " GET WCOD_REAPR PICTURE "9" ;
      VALID wCod_Reapr $ "01"
   @  8, 52 SAY "Dt.Emissao:"
   @  8, 64 GET WDT_EMIS VALID wDt_Emis > CToD("01/01/93")
   @ 10,  3 SAY "SOMA DOS VALORES DOS CHEQUES DO LOTE"
   @ 10, 41 GET WSOMA PICTURE "@R 99,999,999,999.99"
   @ 11,  3 SAY Replicate("-", 74)
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE GETEMP
 
   SELECT 1
   @  8, 10 SAY "NOME DA EMPRESA " GET WNOME PICTURE "@!"
   @ 10, 10 SAY "CODIGO AGENCIA  " GET WCOD_AGE PICTURE "@R 9999-9" ;
      VALID fcod_age()
   @ 12, 10 SAY "NR. DA CONTA " GET WMODALID PICTURE "99" VALID ;
      fmodalid()
   @ 12, 27 GET WNR_CONTA PICTURE "@R 999.999-9" VALID fnr_conta()
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE GETFAT
 
   @  7,  2 CLEAR TO 19, 78
   @  8,  3 SAY "Nr. do Lote"
   SET COLOR TO N/W
   IF ( tEcla == -1 )
      @  8, 17 SAY wNr_Lote PICTURE "999"
      wNo_Sacado:= wNome
   ELSE
      @  8, 17 SAY wNra_Lote PICTURE "999"
   ENDIF
   SET COLOR TO
   @  8, 25 SAY "Especie de doc."
   @  8, 42 GET WESP_DOC PICTURE "99" VALID fespecie(wEsp_Doc)
   @  8, 48 SAY "Identificacao do servico"
   @  8, 74 GET WIDENT_SER PICTURE "99" VALID wIdent_Ser != "  "
   @ 10,  3 SAY "Cod. da Carteira"
   @ 10, 21 GET WCOD_CART PICTURE "9" VALID c_carteira()
   @ 10, 25 SAY "Tipo de Moeda"
   @ 10, 43 GET WTIPO_MOED PICTURE "9" VALID t_moeda()
   @ 10, 48 SAY "Cod. da Tarifa"
   @ 10, 74 GET WCOD_TARIF PICTURE "99"
   @ 12,  3 SAY "SOMA DOS VALORES DAS FATURAS DO LOTE"
   @ 12, 41 GET WSOMA PICTURE "@R 999,999,999.99999"
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE HELP
 
   PARAMETERS pRog, lI, vAri
   SAVE SCREEN TO wTh
   mensagem("Voce esta na tela de Ajuda - Leia com atencao", " ")
   SET COLOR TO W+/R
   @  9,  6 CLEAR TO 21, 79
   @  9,  6 TO 21, 79 DOUBLE
   SET COLOR TO
   @ 22,  0
   mensagem("    ESC ->  Retorna   --   SETAS e PGDN/PGUP ->  Rolam a tela", ;
      " ")
   SELECT 3
   USE EMIH
   INDEX ON PROGRAMA TO EMIHI
   IF ( LastRec() == 0 )
      SET COLOR TO
      mensagem("O ARQUIVO CONTENDO O HELP ESTA VAZIO - TECLE ENTER", ;
         "P")
      SET COLOR TO W+/R
   ENDIF
   lI:= Str(lI, 3)
   vAr:= pRog + vAri
   SEEK vAr
   IF ( EOF() )
      mensagem("AJUDA NAO DISPONIVEL PARA ESTE ITEM - TECLE ENTER", ;
         "P")
   ELSE
      memoedit(cHelp, 10, 8, 20, 77, .F.)
   ENDIF
   InKey(1)
   IF ( LastKey() == K_F9 )
      setcursor(1)
      mensagem("CRIANDO OU ALTERANDO HELP - CONTROL + W GRAVA ALTERACOES", ;
         " ")
      IF ( EOF() )
         APPEND BLANK
         REPLACE pRograma WITH vAr
      ENDIF
      REPLACE cHelp WITH memoedit(cHelp, 10, 8, 20, 77, .T.)
      mensagem(" ", " ")
   ENDIF
   RESTORE SCREEN FROM wTh
   CLOSE
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE IMPBLOQ
 
   RESTORE SCREEN FROM wT1
   CLOSE DATABASES
   USE EMPRESA
   wNome:= nOme
   wCod_Age:= cOd_Age
   wModalid:= mOdalidade
   wNr_Conta:= nR_Conta
   wFlag:= .T.
   CLOSE
   SELECT A
   USE FATURA
   mensagem("IMPRESSAO DE BLOQUETES", "T")
   filtrabloq()
   SELECT B
   USE INSTBLOQ
   IF ( EOF() )
      APPEND BLANK
   ELSE
      GOTO 1
   ENDIF
   wInst1:= iNst1
   wInst2:= iNst2
   wInst3:= iNst3
   wInst4:= iNst4
   wInst5:= iNst5
   @ 14, 10 SAY "INSTRUCAO 1: " GET WINST1
   @ 15, 10 SAY "INSTRUCAO 2: " GET WINST2
   @ 16, 10 SAY "INSTRUCAO 3: " GET WINST3
   @ 17, 10 SAY "INSTRUCAO 4: " GET WINST4
   @ 18, 10 SAY "INSTRUCAO 5: " GET WINST5
   CLEAR GETS
   IF ( alert("Altera instrucoes?", {"Nao", "Sim"}, "/BG") == 2 )
      DO WHILE ( .T. )
         @ 14, 10 SAY "INSTRUCAO 1: " GET WINST1
         @ 15, 10 SAY "INSTRUCAO 2: " GET WINST2
         @ 16, 10 SAY "INSTRUCAO 3: " GET WINST3
         @ 17, 10 SAY "INSTRUCAO 4: " GET WINST4
         @ 18, 10 SAY "INSTRUCAO 5: " GET WINST5
         READ
         IF ( alert("Confirma Instrucoes", {"Sim", "Nao"}, "/BG") == ;
               1 )
            REPLACE iNst1 WITH wInst1
            REPLACE iNst2 WITH wInst2
            REPLACE iNst3 WITH wInst3
            REPLACE iNst4 WITH wInst4
            REPLACE iNst5 WITH wInst5
            EXIT
         ENDIF
      ENDDO
   ENDIF
   CLOSE
   SELECT A
   GOTO TOP
   mensagem("COLOQUE O FORMULARIO PROPRIO E ATIVE A IMPRESSORA", " ")
   wConf:= ;
      alert("Imprime HIFEN de controle sobre picote do Formulario?", ;
      {"Imprime", "Nao Imprime", "Cancela"}, "/BG")
   IF ( wConf == 1 )
      wHifen:= .T.
   ELSEIF ( wConf == 2 )
      wHifen:= .F.
   ELSE
      CLOSE DATABASES
      RETURN
   ENDIF
   DO WHILE ( .NOT.isprinter() )
      alert("Impressora NAO esta pronta - Verifique !", Nil, "/W")
   ENDDO
   mensagem("TECLE <ESC> PARA ABORTAR A IMPRESSAO", " ")
   SET DEVICE TO PRINTER
   setprc(0, 0)
   @  0,  0 SAY ""
   @  0,  0 SAY "0"
   @  0,  0 SAY " "
   IF ( wHifen )
      wConf:= 2
      DO WHILE ( wConf = 2 )
         SET DEVICE TO PRINTER
         IF ( wTbloq = 1 .OR. wTbloq = 2 )
            @  0,  0 SAY " "
            @  0, 65 SAY "=___|"
            @ PRow(),  0 SAY "|___= "
         ELSEIF ( wTbloq == 3 )
            @  0,  0 SAY " "
            @  0, 18 SAY "__|___"
            @ PRow(),  0 SAY " |___ "
            @ PRow(), 100 SAY "_|___= "
            @ PRow(), 121 SAY "_|___= "
         ENDIF
         SET DEVICE TO SCREEN
         wConf:= ;
            alert("O HIFEN esta sobre o picote nos dois lados do formulario?", ;
            {"Sim", "Nao"}, "/BG")
      ENDDO
   ENDIF
   wCont:= 1
   InKey(0.01)
   DO WHILE ( .NOT.EOF() )
      IF ( LastKey() == K_ESC )
         SET DEVICE TO SCREEN
         wConf:= alert("Confirma a Interrupcao da impressao? ", ;
            {"Sim", "Nao"}, "/BG")
         IF ( wConf == 1 )
            RETURN
         ENDIF
      ENDIF
      IF ( ( cOd_Cart != "4" .OR. cApa_Lote = "S" ) .AND. ( cOd_Cart ;
            != "5" .OR. cApa_Lote = "S" ) )
         dbSkip()
         LOOP
      ENDIF
      SET DEVICE TO PRINTER
      wVv:= " "
      wV1:= Transform(vAl_Titulo, "@E 9,999,999,999.99")
      IF ( wTbloq == 1 )
         IF ( wFlag )
            @ PRow() + 5,  0 SAY " "
            wFlag:= .F.
         ELSE
            @ PRow() + 1,  0 SAY " "
         ENDIF
         @ PRow() + 1,  0 SAY " "
         @ PRow(), 60 SAY dT_Venc
         @ PRow() + 4,  2 SAY Date()
         @ PRow(), 12 SAY nR_Doc
         @ PRow(), 31 SAY eSp_Doc
         @ PRow(), 43 SAY aCeite
         @ PRow() + 2, 23 SAY wVv
         @ PRow(), 60 SAY wV1
         IF ( cOd_Mora == 0 )
            wVmora:= mOra
         ELSE
            wVmora:= vAl_Titulo * mOra * 0.01 / 30
         ENDIF
         @ PRow() + 2,  2 SAY "Mora Diaria: " + Transform(wVmora, ;
            "@E 9,999,999,999.99")
         @ PRow() + 1,  2 SAY "Desconto: " + Transform(vAl_Desc, ;
            "@E 9,999,999,999.99")
         @ PRow(), PCol() + 2 SAY "Ate: " + DToC(dT_Desc)
         @ PRow() + 1,  3 SAY ;
            "*****   VALORES EXPRESSOS EM REAL   ***** "
         @ PRow() + 2,  3 SAY wInst1
         @ PRow() + 1,  3 SAY wInst2
         @ PRow() + 1,  3 SAY wInst3
         @ PRow() + 1,  3 SAY wInst4
         @ PRow() + 1,  3 SAY wInst5
         @ PRow() + 1, 10 SAY nOme_Sac
         @ PRow() + 1, 10 SAY eNd_Sac
         @ PRow() + 1, 10 SAY cEp + "-" + sUp_Cep + " " + cIdade + ;
            "/" + eStado + Space(10)
         IF ( nR_Cic != "0000000" )
            IF ( SubStr(nR_Cic, 1, 3) = "000" )
               @ PRow(), PCol() SAY SubStr(nR_Cic, 4, 11) PICTURE ;
                  "@R 999.999.999-99"
            ELSE
               @ PRow(), PCol() SAY nR_Cic PICTURE ;
                  "@R 99.999.999/9999-99"
            ENDIF
         ENDIF
         @ PRow() + 1, 10 SAY nO_Sacador
         @ PRow() + 10,  1 SAY " "
      ELSEIF ( wTbloq == 2 )
         IF ( wHifen )
            @ PRow() + 5,  0 SAY " "
         ELSE
            @ PRow() + 1,  0 SAY " "
         ENDIF
         @ PRow() + 2, 11 SAY wVv
         @ PRow(), 29 SAY DToC(dT_Venc)
         @ PRow(), 53 SAY wVv
         @ PRow(), 70 SAY DToC(dT_Venc)
         @ PRow() + 2,  2 SAY wV1
         @ PRow(), 42 SAY wV1
         @ PRow() + 6, 22 SAY nR_Doc
         @ PRow(), 61 SAY nR_Doc
         @ PRow() + 11, 60 SAY dT_Venc
         @ PRow() + 4,  2 SAY Date()
         @ PRow(), 12 SAY nR_Doc
         @ PRow(), 31 SAY eSp_Doc
         @ PRow(), 43 SAY aCeite
         @ PRow() + 2, 23 SAY wVv
         @ PRow(), 60 SAY wV1
         IF ( cOd_Mora == 0 )
            wVmora:= mOra
         ELSE
            wVmora:= vAl_Titulo * mOra * 0.01 / 30
         ENDIF
         @ PRow() + 2,  2 SAY "Mora Diaria: " + Transform(wVmora, ;
            "@E 9,999,999,999.99")
         @ PRow() + 1,  2 SAY "Desconto: " + Transform(vAl_Desc, ;
            "@E 9,999,999,999.99")
         @ PRow(), PCol() + 2 SAY "Ate: " + DToC(dT_Desc)
         @ PRow() + 1,  3 SAY ;
            "*****   VALORES EXPRESSOS EM REAL   ***** "
         @ PRow() + 2,  3 SAY wInst1
         @ PRow() + 1,  3 SAY wInst2
         @ PRow() + 1,  3 SAY wInst3
         @ PRow() + 1,  3 SAY wInst4
         @ PRow() + 1,  3 SAY wInst5
         @ PRow() + 1, 10 SAY nOme_Sac
         @ PRow() + 1, 10 SAY eNd_Sac
         @ PRow() + 1, 10 SAY cEp + "-" + sUp_Cep + " " + cIdade + ;
            "/" + eStado + Space(10)
         IF ( nR_Cic != "0000000" )
            IF ( SubStr(nR_Cic, 1, 3) = "000" )
               @ PRow(), PCol() SAY SubStr(nR_Cic, 4, 11) PICTURE ;
                  "@R 999.999.999-99"
            ELSE
               @ PRow(), PCol() SAY nR_Cic PICTURE ;
                  "@R 99.999.999/9999-99"
            ENDIF
         ENDIF
         @ PRow() + 1, 10 SAY nO_Sacador
         IF ( wHifen )
            @ PRow() + 6,  1 SAY " "
         ELSE
            @ PRow() + 10,  1 SAY " "
         ENDIF
      ELSEIF ( wTbloq == 3 )
         IF ( wHifen )
            @ PRow() + 6,  9 SAY DToC(dT_Venc)
            @ PRow(), 82 SAY DToC(dT_Venc)
            @ PRow(), 111 SAY DToC(dT_Venc)
            @ PRow(), 128 SAY DToC(dT_Venc)
         ELSE
            @ PRow() + 3,  9 SAY DToC(dT_Venc)
            @ PRow(), 82 SAY DToC(dT_Venc)
            @ PRow(), 111 SAY DToC(dT_Venc)
            @ PRow(), 128 SAY DToC(dT_Venc)
         ENDIF
         @ PRow() + 4,  4 SAY wVv
         @ PRow(), 22 SAY dT_Emis
         @ PRow(), 33 SAY nR_Doc
         @ PRow(), 51 SAY eSp_Doc
         @ PRow(), 63 SAY aCeite
         @ PRow(), 81 SAY nOsso_Nr PICTURE "@R 9999999-9"
         @ PRow(), 104 SAY wVv
         @ PRow() + 2,  1 SAY wV1
         @ PRow(), 47 SAY wVv
         @ PRow(), 81 SAY wV1
         @ PRow(), 102 SAY wV1
         @ PRow(), 119 SAY wV1
         IF ( cOd_Mora == 0 )
            wVmora:= mOra
         ELSE
            wVmora:= vAl_Titulo * mOra * 0.01 / 30
         ENDIF
         @ PRow() + 2, 27 SAY "Mora Diaria: " + Transform(wVmora, ;
            "@E 9,999,999,999.99")
         @ PRow() + 1, 27 SAY "Desconto: " + Transform(vAl_Desc, ;
            "@E 9,999,999,999.99")
         @ PRow(), PCol() + 2 SAY "Ate: " + DToC(dT_Desc)
         @ PRow() + 1, 23 SAY ;
            "*****   VALORES EXPRESSOS EM REAL   ***** "
         @ PRow() + 1, PCol() SAY " "
         @ PRow() + 1, 23 SAY wInst1
         @ PRow() + 1, 23 SAY wInst2
         @ PRow() + 1, 23 SAY wInst3
         @ PRow() + 1, 23 SAY wInst4
         @ PRow() + 1, 23 SAY wInst5
         @ PRow() + 1, 28 SAY nOme_Sac
         @ PRow() + 1, 28 SAY eNd_Sac
         @ PRow() + 1, 28 SAY cEp + "-" + sUp_Cep + " " + cIdade + ;
            "/" + eStado + Space(10)
         IF ( nR_Cic != "0000000" )
            IF ( SubStr(nR_Cic, 1, 3) = "000" )
               @ PRow(), PCol() SAY SubStr(nR_Cic, 4, 11) PICTURE ;
                  "@R 999.999.999-99"
            ELSE
               @ PRow(), PCol() SAY nR_Cic PICTURE ;
                  "@R 99.999.999/9999-99"
            ENDIF
         ENDIF
         @ PRow() + 1,  3 SAY nR_Doc
         @ PRow(), 28 SAY nO_Sacador
         @ PRow(), 102 SAY nR_Doc
         @ PRow(), 123 SAY nR_Doc
         IF ( wHifen )
            @ PRow() + 6,  1 SAY "__ "
            @ PRow(), 120 SAY "__ "
         ELSE
            @ PRow() + 9,  1 SAY "__ "
            @ PRow(), 120 SAY "__ "
         ENDIF
      ENDIF
      SKIP
      IF ( EOF() )
         @ PRow(),  1 SAY "2"
         EXIT
      ENDIF
      IF ( wCont == 1 )
         SET DEVICE TO SCREEN
         mensagem("IMPRESSAO ESTA CORRETA (S/N)? ", "S")
         IF ( wConf = "S" )
            wCont:= 2
         ELSE
            mensagem("VOCE QUER CONTINUAR A IMPRESSAO (S/N)? ", "S")
            IF ( wConf = "N" )
               EXIT
            ENDIF
         ENDIF
      ENDIF
      InKey(0.7)
   ENDDO
   SET FILTER TO
   CLOSE DATABASES
   SET DEVICE TO SCREEN
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE IMPORTA
 
   CLOSE DATABASES
   SELECT 3
   USE CHEQUER
   ZAP
   SELECT 2
   USE FATURAR
   ZAP
   SELECT 1
   USE REG
   ZAP
   RESTORE SCREEN FROM wT1
   mensagem("PREPARA ARQUIVO DE RETORNO", "T")
   precarq("ENTRE COM O ARQUIVO A SER RESTAURADO", "TXT")
   IF ( wArq = Space(8) )
   ELSE
      mensagem("IMPORTANDO O ARQUIVO DE RETORNO!", " ")
      APPEND FROM (wArq) SDF ALL
      GOTO TOP
      IF ( SubStr(cAmpo1, 2, 1) != "2" )
         mensagem("NAO E ARQUIVO DE RETORNO - TECLE ALGO", "P")
      ENDIF
      wNoemp:= SubStr(cAmpo1, 47, 30)
      wDtgrav:= SubStr(cAmpo1, 95, 2) + "/" + SubStr(cAmpo1, 97, 2) ;
         + "/" + SubStr(cAmpo1, 99, 2)
      mensagem("EMPRESA  " + wNoemp + " - RETORNO DE " + wDtgrav, " ")
      DO WHILE ( .NOT.EOF() )
         SELECT 1
         IF ( SubStr(cAmpo1, 1, 1) = "0" .OR. SubStr(cAmpo1, 1, 1) = ;
               "9" )
            SKIP
         ENDIF
         wCampo1:= cAmpo1 + cAmpo2
         wEsp_Doc:= SubStr(cAmpo1, 174, 2)
         IF ( wEsp_Doc = "29" )
            SELECT 3
         ELSE
            SELECT 2
         ENDIF
         APPEND BLANK
         REPLACE sAcado WITH SubStr(wCampo1, 81, 27)
         REPLACE dT_Pag WITH CToD(SubStr(wCampo1, 111, 2) + "/" + ;
            SubStr(wCampo1, 113, 2) + "/" + SubStr(wCampo1, 115, 2))
         REPLACE tIpo_Cic WITH Val(SubStr(wCampo1, 2, 2))
         REPLACE nR_Cic WITH SubStr(wCampo1, 4, 14)
         REPLACE nOsso_Nr WITH SubStr(wCampo1, 63, 8)
         REPLACE cOd_Cart WITH SubStr(wCampo1, 108, 1)
         REPLACE iDent_Ser WITH SubStr(wCampo1, 109, 2)
         REPLACE dT_Ocor WITH CToD(SubStr(wCampo1, 111, 2) + "/" + ;
            SubStr(wCampo1, 113, 2) + "/" + SubStr(wCampo1, 115, 2))
         REPLACE nR_Doc WITH SubStr(wCampo1, 117, 10)
         IF ( SubStr(wCampo1, 147, 6) = "000001" )
            REPLACE dT_Venc WITH "A VISTA"
         ELSEIF ( SubStr(wCampo1, 147, 6) = "000002" )
            REPLACE dT_Venc WITH "C/APRES."
         ELSE
            REPLACE dT_Venc WITH SubStr(wCampo1, 147, 2) + "/" + ;
               SubStr(wCampo1, 149, 2) + "/" + SubStr(wCampo1, 151, 2)
         ENDIF
         REPLACE vAl_Titulo WITH Val(SubStr(wCampo1, 153, 13)) / 100
         REPLACE bAnco_Cob WITH SubStr(wCampo1, 166, 7)
         REPLACE eSp_Doc WITH SubStr(wCampo1, 174, 2)
         REPLACE vAlor_Tar WITH Val(SubStr(wCampo1, 176, 13)) / 100
         REPLACE vAlor_Jur WITH Val(SubStr(wCampo1, 202, 13)) / 100
         REPLACE vAl_Ioc WITH Val(SubStr(wCampo1, 215, 13)) / 100
         REPLACE aBat_Con WITH Val(SubStr(wCampo1, 228, 13)) / 100
         REPLACE dEsc_Con WITH Val(SubStr(wCampo1, 241, 13)) / 100
         REPLACE vAl_Pago WITH Val(SubStr(wCampo1, 254, 13)) / 100
         REPLACE mOra_Pg WITH Val(SubStr(wCampo1, 267, 13)) / 100
         IF ( SubStr(wCampo1, 280, 2) = "00" )
            REPLACE cOd_Mora WITH Val(SubStr(wCampo1, 302, 1))
            REPLACE mOra WITH Val(SubStr(wCampo1, 303, 12)) / 100
            REPLACE vAl_Desc WITH Val(SubStr(wCampo1, 321, 13)) / 100
            REPLACE iNst_Cob WITH Val(SubStr(wCampo1, 334, 4))
            REPLACE nR_Sacador WITH SubStr(wCampo1, 338, 10)
            REPLACE nO_Sacador WITH SubStr(wCampo1, 348, 30)
            REPLACE tIpo_Moeda WITH SubStr(wCampo1, 394, 1)
         ELSE
            REPLACE eRro WITH SubStr(wCampo1, 280, 40)
         ENDIF
         SELECT 1
         SKIP
      ENDDO
      SELECT 2
      GOTO BOTTOM
      IF ( cOd_Cart = " " .AND. nR_Doc = " " .AND. vAl_Titulo = 0 )
         DELETE
         PACK
      ENDIF
      mensagem(" ", " ")
      CLOSE DATABASES
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE IMPTXT
 
   RESTORE SCREEN FROM wT1
   wNo_Arq:= Space(8)
   wPos_Ini:= 0
   wPos_Fin:= 0
   wDec:= 0
   wInfo:= Space(37)
   wCpo1:= Space(400)
   mensagem("I M P O R T A N D O  A R Q U I V O  T E X T O", "T")
   mensagem("INFORMACAO QUE NAO CONSTE NO ARQUIVO DEIXE EM BRANCO", ;
      " ")
   precarq("ENTRE COM O NOME DO ARQUIVO? ", "TXT")
   IF ( wArq = Space(8) )
   ELSE
      mensagem("VOCE JA ENTROU COM O LAY-OUT DO SEU ARQUIVO PARA IMPORTACAO (S/N)?", ;
         "N")
      IF ( wConf = "N" )
         USE LAYOUT
         GOTO 1
         FOR i:= 1 TO 31
            wPos_Ini:= pOs_Ini
            wPos_Fin:= pOs_Fin
            wDec:= dEc_Cam
            wInfo:= cOnt_Campo
            @ 14,  3 SAY "CONTEUDO"
            @ 14, 46 SAY "POSICAO INICIAL"
            @ 14, 61 SAY "/FINAL"
            @ 14, 68 SAY "QT.DECIMAIS"
            @ 16,  3 SAY iNformacao
            @ 16, 53 GET WPOS_INI PICTURE "999"
            @ 16, 62 GET WPOS_FIN PICTURE "999"
            @ 16, 71 GET WDEC PICTURE "9"
            READ
            IF ( wPos_Ini = 0 .AND. wPos_Fin = 0 )
               @ 18,  3 SAY "DIGITE A INFORMACAO SE EXISTIR? " GET ;
                  WINFO
               READ
               @ 18,  3 CLEAR TO 14, 78
            ENDIF
            REPLACE cOnt_Campo WITH wInfo
            REPLACE pOs_Ini WITH wPos_Ini
            REPLACE pOs_Fin WITH wPos_Fin
            REPLACE dEc_Cam WITH wDec
            SKIP
         NEXT
      ENDIF
      CLOSE
      SELECT A
      USE REG
      ZAP
      mensagem("CONFIRMA IMPORTACAO DO ARQUIVO", "S")
      IF ( wConf = "N" )
      ELSE
         mensagem("AGUARDE PROCESSANDO A IMPORTACAO DO ARQUIVO!!!", ;
            " ")
         APPEND FROM (wArq) SDF ALL
         PRIVATE wTi_Cam[33], wTam_Cam[33], wPini[33], wPfin[33], ;
            wConte[33], wCampol[33]
         PRIVATE wDeci[33]
         SELECT C
         USE LAYOUT
         FOR i:= 1 TO 31
            wTi_Cam[ i ]:= tIpo_Cam
            wTam_Cam[ i ]:= tAm_Cam
            wPini[ i ]:= pOs_Ini
            wPfin[ i ]:= pOs_Fin
            wConte[ i ]:= cOnt_Campo
            wDeci[ i ]:= dEc_Cam
            SKIP
         NEXT
         SELECT A
         USE REG
         SELECT C
         USE FATURA
         GOTO BOTTOM
         COPY STRUCTURE TO IMPORTA
         USE IMPORTA
         SELECT A
         DO WHILE ( .NOT.EOF() )
            FOR i:= 1 TO 31
               SELECT A
               wCpo1:= cAmpo1 + cAmpo2
               IF ( wTi_Cam[ i ] = "C" )
                  IF ( wPfin[ i ] = 0 .AND. wPini[ i ] = 0 )
                     wCampol[ i ]:= SubStr(wConte[ i ], 1, ;
                        wTam_Cam[ i ])
                  ELSE
                     wCampol[ i ]:= SubStr(wCpo1, wPini[ i ], ;
                        wPfin[ i ] - wPini[ i ] + 1)
                  ENDIF
               ELSEIF ( wTi_Cam[ i ] = "N" )
                  IF ( wPfin[ i ] = 0 .AND. wPini[ i ] = 0 )
                     wCampol[ i ]:= Val(SubStr(wConte[ i ], 1, ;
                        wTam_Cam[ i ]))
                  ELSE
                     wCampol[ i ]:= Val(SubStr(wCpo1, wPini[ i ], ;
                        wPfin[ i ] - wPini[ i ] + 1))
                     wDec:= 10 ^ wDeci[ i ]
                     wCampol[ i ]:= wCampol[ i ] / wDec
                  ENDIF
               ELSEIF ( wTi_Cam[ i ] = "D" )
                  IF ( wPfin[ i ] = 0 .AND. wPini[ i ] = 0 )
                     wCampol[ i ]:= CToD(SubStr(wConte[ i ], 1, ;
                        wTam_Cam[ i ]))
                  ELSE
                     wCampol[ i ]:= CToD(SubStr(wCpo1, wPini[ i ], ;
                        2) + "/" + SubStr(wCpo1, wPini[ i ] + 2, 2) ;
                        + "/" + SubStr(wCpo1, wPini[ i ] + 4, 2))
                  ENDIF
               ENDIF
            NEXT
            SELECT C
            APPEND BLANK
            REPLACE iMporta->nOsso_Nr WITH wCampol[ 1 ]
            REPLACE iMporta->cOd_Tarifa WITH wCampol[ 2 ]
            REPLACE iMporta->cOd_Reapr WITH wCampol[ 3 ]
            REPLACE iMporta->cOd_Cart WITH wCampol[ 4 ]
            REPLACE iMporta->iDent_Ser WITH wCampol[ 5 ]
            REPLACE iMporta->nR_Doc WITH wCampol[ 6 ]
            REPLACE iMporta->dT_Venc WITH wCampol[ 7 ]
            REPLACE iMporta->vAl_Titulo WITH wCampol[ 8 ]
            REPLACE iMporta->bAnco_Cob WITH wCampol[ 9 ]
            REPLACE iMporta->eSp_Doc WITH wCampol[ 10 ]
            REPLACE iMporta->aCeite WITH wCampol[ 11 ]
            REPLACE iMporta->dT_Emis WITH wCampol[ 12 ]
            REPLACE iMporta->iNst_Cob WITH wCampol[ 13 ]
            REPLACE iMporta->cOd_Mora WITH wCampol[ 14 ]
            REPLACE iMporta->mOra WITH wCampol[ 15 ]
            REPLACE iMporta->dT_Desc WITH wCampol[ 16 ]
            REPLACE iMporta->vAl_Desc WITH wCampol[ 17 ]
            REPLACE iMporta->vAl_Ioc WITH wCampol[ 18 ]
            REPLACE iMporta->aBatimento WITH wCampol[ 19 ]
            REPLACE iMporta->tIpo_Cic WITH wCampol[ 20 ]
            REPLACE iMporta->nR_Cic WITH strzero(Val(wCampol[ 21 ]), ;
               14)
            vV:= nR_Cic
            REPLACE iMporta->nOme_Sac WITH wCampol[ 22 ]
            REPLACE iMporta->sUp_Cep WITH wCampol[ 23 ]
            REPLACE iMporta->eNd_Sac WITH wCampol[ 24 ]
            REPLACE iMporta->cEp WITH wCampol[ 25 ]
            REPLACE iMporta->cIdade WITH wCampol[ 26 ]
            REPLACE iMporta->eStado WITH wCampol[ 27 ]
            REPLACE iMporta->nR_Sacador WITH wCampol[ 28 ]
            REPLACE iMporta->nO_Sacador WITH wCampol[ 29 ]
            REPLACE iMporta->pRazo_Prot WITH wCampol[ 30 ]
            REPLACE iMporta->tIpo_Moeda WITH wCampol[ 31 ]
            SELECT A
            SKIP
         ENDDO
         CLOSE DATABASES
         SELECT 1
         USE IMPORTA
         SELECT 2
         USE FATURA
         ZAP
         wNr_Lote:= 900
         SELECT 1
         GOTO TOP
         wEsp_Doc:= eSp_Doc
         wIdent_Ser:= iDent_Ser
         wCod_Cart:= cOd_Cart
         wTipo_Moed:= tIpo_Moeda
         wCod_Tar:= cOd_Tarifa
         SELECT 2
         APPEND BLANK
         REPLACE eSp_Doc WITH wEsp_Doc
         REPLACE iDent_Ser WITH wIdent_Ser
         REPLACE cOd_Cart WITH wCod_Cart
         REPLACE tIpo_Moeda WITH wTipo_Moed
         REPLACE cOd_Tarifa WITH wCod_Tar
         REPLACE nR_Lote WITH wNr_Lote
         REPLACE cApa_Lote WITH "S"
         SELECT 1
         PRIVATE wCampo[35]
         DO WHILE ( .NOT.EOF() )
            IF ( wEsp_Doc = eSp_Doc .AND. wIdent_Ser = iDent_Ser ;
                  .AND. wCod_Cart = cOd_Cart .AND. wTipo_Moed = ;
                  tIpo_Moeda .AND. wCod_Tar = cOd_Tarifa )
               wCampo[ 1 ]:= iMporta->nOsso_Nr
               wCampo[ 2 ]:= iMporta->cOd_Tarifa
               wCampo[ 3 ]:= iMporta->cOd_Reapr
               wCampo[ 4 ]:= iMporta->cOd_Cart
               wCampo[ 5 ]:= iMporta->iDent_Ser
               wCampo[ 6 ]:= iMporta->nR_Doc
               wCampo[ 7 ]:= iMporta->dT_Venc
               wCampo[ 8 ]:= iMporta->vAl_Titulo
               wCampo[ 9 ]:= iMporta->bAnco_Cob
               wCampo[ 10 ]:= iMporta->eSp_Doc
               wCampo[ 11 ]:= iMporta->aCeite
               wCampo[ 12 ]:= iMporta->dT_Emis
               wCampo[ 13 ]:= iMporta->iNst_Cob
               wCampo[ 14 ]:= iMporta->cOd_Mora
               wCampo[ 15 ]:= iMporta->mOra
               wCampo[ 16 ]:= iMporta->dT_Desc
               wCampo[ 17 ]:= iMporta->vAl_Desc
               wCampo[ 18 ]:= iMporta->vAl_Ioc
               wCampo[ 19 ]:= iMporta->aBatimento
               wCampo[ 20 ]:= iMporta->tIpo_Cic
               wCampo[ 21 ]:= iMporta->nR_Cic
               wCampo[ 22 ]:= iMporta->nOme_Sac
               wCampo[ 23 ]:= iMporta->sUp_Cep
               wCampo[ 24 ]:= iMporta->eNd_Sac
               wCampo[ 25 ]:= iMporta->cEp
               wCampo[ 26 ]:= iMporta->cIdade
               wCampo[ 27 ]:= iMporta->eStado
               wCampo[ 28 ]:= iMporta->nR_Sacador
               wCampo[ 29 ]:= iMporta->nO_Sacador
               wCampo[ 30 ]:= iMporta->pRazo_Prot
               SELECT 2
               APPEND BLANK
               REPLACE fAtura->nOsso_Nr WITH wCampo[ 1 ]
               REPLACE fAtura->cOd_Tarifa WITH wCampo[ 2 ]
               REPLACE fAtura->cOd_Reapr WITH wCampo[ 3 ]
               REPLACE fAtura->cOd_Cart WITH wCampo[ 4 ]
               REPLACE fAtura->iDent_Ser WITH wCampo[ 5 ]
               REPLACE fAtura->nR_Doc WITH wCampo[ 6 ]
               REPLACE fAtura->dT_Venc WITH wCampo[ 7 ]
               REPLACE fAtura->vAl_Titulo WITH wCampo[ 8 ]
               REPLACE fAtura->bAnco_Cob WITH wCampo[ 9 ]
               REPLACE fAtura->eSp_Doc WITH wCampo[ 10 ]
               REPLACE fAtura->aCeite WITH wCampo[ 11 ]
               REPLACE fAtura->dT_Emis WITH wCampo[ 12 ]
               REPLACE fAtura->iNst_Cob WITH wCampo[ 13 ]
               REPLACE fAtura->cOd_Mora WITH wCampo[ 14 ]
               REPLACE fAtura->mOra WITH wCampo[ 15 ]
               REPLACE fAtura->dT_Desc WITH wCampo[ 16 ]
               REPLACE fAtura->vAl_Desc WITH wCampo[ 17 ]
               REPLACE fAtura->vAl_Ioc WITH wCampo[ 18 ]
               REPLACE fAtura->aBatimento WITH wCampo[ 19 ]
               REPLACE fAtura->tIpo_Cic WITH wCampo[ 20 ]
               REPLACE fAtura->nR_Cic WITH wCampo[ 21 ]
               REPLACE fAtura->nOme_Sac WITH wCampo[ 22 ]
               REPLACE fAtura->sUp_Cep WITH wCampo[ 23 ]
               REPLACE fAtura->eNd_Sac WITH wCampo[ 24 ]
               REPLACE fAtura->cEp WITH wCampo[ 25 ]
               REPLACE fAtura->cIdade WITH wCampo[ 26 ]
               REPLACE fAtura->eStado WITH wCampo[ 27 ]
               REPLACE fAtura->nR_Sacador WITH wCampo[ 28 ]
               REPLACE fAtura->nO_Sacador WITH wCampo[ 29 ]
               REPLACE fAtura->pRazo_Prot WITH wCampo[ 30 ]
               REPLACE fAtura->nR_Lote WITH wNr_Lote
               REPLACE fAtura->tIpo_Moeda WITH wTipo_Moed
               REPLACE fAtura->cApa_Lote WITH "N"
            ELSE
               wNr_Lote:= nR_Lote + 1
               SELECT 1
               wEsp_Doc:= eSp_Doc
               wIdent_Ser:= iDent_Ser
               wCod_Cart:= cOd_Cart
               wTipo_Moed:= tIpo_Moeda
               wCod_Tar:= cOd_Tarifa
               SELECT 2
               APPEND BLANK
               REPLACE eSp_Doc WITH wEsp_Doc
               REPLACE iDent_Ser WITH wIdent_Ser
               REPLACE cOd_Cart WITH wCod_Cart
               REPLACE tIpo_Moeda WITH wTipo_Moed
               REPLACE cOd_Tarifa WITH wCod_Tar
               REPLACE nR_Lote WITH wNr_Lote
               REPLACE cApa_Lote WITH "S"
               SELECT 1
               LOOP
            ENDIF
            SELECT 1
            SKIP
         ENDDO
         mensagem(" ", " ")
         CLOSE DATABASES
      ENDIF
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE INSERTDISK
 
   alerta(15, 30, "Coloque o disco # " + LTrim(Str(wDiskno)) + ;
      " no drive " + wDrive + ".", {" OK "})
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE LECHQ
 
   SELECT 1
   wFone:= SubStr(nOme_Sac, 30, 8)
   wNbanco:= SubStr(eNd_Sac, 1, 20)
   wCodages:= SubStr(eNd_Sac, 21, 4)
   wNage:= SubStr(eNd_Sac, 25, 16)
   wNome_Sac:= SubStr(nOme_Sac, 1, 28)
   wCod_Reapr:= cOd_Reapr
   wNr_Doc:= nR_Doc
   wDt_Venc:= dT_Venc
   wVal_Tit:= vAl_Titulo
   wDt_Emis:= dT_Emis
   wNra_Lote:= nR_Lote
   wCapa_Lote:= cApa_Lote
   IF ( wCapa_Lote = "S" )
      wSoma:= wVal_Tit
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE LEEMP
 
   SELECT 1
   wNome:= nOme
   wCod_Age:= cOd_Age
   wModalid:= mOdalidade
   wNr_Conta:= SubStr(nR_Conta, 2, 7)
   wUlt_Mov:= dT_Ult_Mov
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE LEFAT
 
   SELECT 1
   wNosso_Nr:= nOsso_Nr
   wCod_Tarif:= cOd_Tarifa
   wCod_Reapr:= cOd_Reapr
   wCod_Cart:= cOd_Cart
   wIdent_Ser:= iDent_Ser
   wNr_Doc:= nR_Doc
   wDt_Venc:= dT_Venc
   wVal_Tit:= vAl_Titulo
   wBanco_Cob:= bAnco_Cob
   wEsp_Doc:= eSp_Doc
   wAceite:= aCeite
   wDt_Emis:= dT_Emis
   wInst_Cob:= iNst_Cob
   wCod_Mora:= cOd_Mora
   wMora:= mOra
   wDt_Desc:= dT_Desc
   wVal_Desc:= vAl_Desc
   wVal_Ioc:= vAl_Ioc
   wTipo_Cic:= tIpo_Cic
   IF ( tIpo_Cic == 1 )
      wNr_Cic:= SubStr(nR_Cic, 4, 9) + "0000" + SubStr(nR_Cic, 13, 2)
   ELSE
      wNr_Cic:= "0" + nR_Cic
   ENDIF
   wNome_Sac:= nOme_Sac
   wSup_Cep:= sUp_Cep
   wEnd_Sac:= eNd_Sac
   wCep:= cEp
   wCidade:= cIdade
   wEstado:= eStado
   wNo_Sacado:= nO_Sacador
   wPrazo_Pro:= pRazo_Prot
   wTipo_Moed:= tIpo_Moeda
   wNra_Lote:= nR_Lote
   wCapa_Lote:= cApa_Lote
   IF ( wCapa_Lote = "S" )
      wSoma:= wVal_Tit
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MANUTEN
 
   LOCAL Local1, Local2
   Local1:= wMode:= 1
   Local2:= {}
   wOpa:= 1
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem(" M E N U   D E   M A N U T E N C A O", "T")
      @  8,  5, 10, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @ 12, 23, 14, 56 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "   FAZ COPIA DE SEGURANCA    "
      @ 17,  8 PROMPT "  RESTAURA COPIA SEGURANCA   "
      @ 13, 26 PROMPT "    IMPORTA ARQUIVO TEXTO     "
      @  9, 44 PROMPT "  CHECAGEM DO PADRAO CNAB    "
      @ 17, 44 PROMPT "    VOLTA MENU ANTERIOR      "
      MENU TO wOpa
      DO CASE
      CASE wOpa = 1
         RESTORE SCREEN FROM wT1
         mensagem("C O P I A   D E   S E G U R A N C A", "T")
         asize(Local2, 5)
         Local2[ 1 ]:= "FATURA.DBF"
         Local2[ 2 ]:= "CHEQUE.DBF"
         Local2[ 3 ]:= "FATURAR.DBF"
         Local2[ 4 ]:= "CHEQUER.DBF"
         Local2[ 5 ]:= "EMPRESA.DBF"
         Local1:= syssave1(1, Local2)
         IF ( Local1 != 0 .AND. Local1 != 99 )
            mensagem("OPERACAO DE BACKUP COM ERRO " + ;
               LTrim(Str(Local1)), "P")
            RETURN
         ELSEIF ( Local1 != 99 )
            mensagem("BACKUP COM SUCESSO!! - REINICIA ARQUIVO DE COBRANCA (S/N)?", ;
               "S")
            IF ( wConf = "S" )
               USE FATURA
               ZAP
               USE CHEQUE
               ZAP
            ENDIF
         ENDIF
      CASE wOpa = 2
         RESTORE SCREEN FROM wT1
         mensagem("R E S T A U R A   C O P I A  D E  S E G U R A N C A", ;
            "T")
         Local1:= syssave(2, Local2)
         IF ( Local1 != 0 .AND. Local1 != 99 )
            mensagem("OPERACAO DE BACKUP COM ERRO " + ;
               LTrim(Str(Local1)), "P")
         ENDIF
      CASE wOpa = 3
         imptxt()
      CASE wOpa = 4
         vercnab()
      CASE wOpa = 5 .OR. wOpa = 0
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MENSAGEM( Arg1, Arg2 )
 
   PUBLIC wConf
   IF ( ISNIL( Arg2 ) )
      wConf:= " "
   ELSE
      wConf:= Arg2
   ENDIF
   Arg1:= "  " + alltrim(Arg1) + "  "
   wTam:= Len(Arg1) / 2
   SET COLOR TO W+
   IF ( wConf = "T" )
      SET COLOR TO BG
      @  6,  1 TO  6, 78 DOUBLE
      SET COLOR TO
      @  6, 40 - wTam SAY Arg1
      SET COLOR TO
   ELSE
      SET COLOR TO W+/RB
      @ 23,  0
      @ 23, 40 - wTam SAY Arg1
      SET COLOR TO
      DO CASE
      CASE wConf = " "
         SET COLOR TO
         RETURN
      CASE wConf $ "SNB"
         SET COLOR TO RB+
         IF ( wConf = "B" )
            wConf:= " "
         ENDIF
         @ 23, 42 + wTam GET WCONF PICTURE "@!" VALID wConf $ "SN"
         READ
         SET COLOR TO
      CASE wConf $ "F"
         SET COLOR TO RB+
         wConf:= " "
         @ 23, 42 + wTam GET WCONF PICTURE "@!" VALID wConf $ "SNE"
         READ
         SET COLOR TO
      CASE wConf $ "PE"
         InKey(0)
      ENDCASE
      @ 23,  0 CLEAR TO 23, 79
      SET COLOR TO
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MENUCAD
 
   wOpa:= 1
   CLOSE DATABASES
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem(" M E N U   D E   C A D A S T R O ", "T")
      @  8,  5, 10, 38 BOX wMold
      @ 12,  5, 14, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 12, 41, 14, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "     DADOS DA EMPRESA        "
      @ 13,  8 PROMPT "    F  A  T  U  R  A  S      "
      @ 17,  8 PROMPT "    C  H  E  Q  U  E  S      "
      @  9, 44 PROMPT "  ALTERA VALOR E DATA GLOBAL "
      @ 13, 44 PROMPT "    PREENCHE NOSSO NUMERO    "
      @ 17, 44 PROMPT "    VOLTA MENU ANTERIOR      "
      MENU TO wOpa
      PUBLIC wMod, wAltexc, wAcao
      DO CASE
      CASE wOpa = 1
         SELECT 1
         USE EMPRESA
         pgera1()
      CASE wOpa = 2
         SELECT 1
         USE FATURA
         wMod:= "FAT"
         wNomemod:= "CADASTRO DE FATURAS "
         wAltexc:= "SS"
         pcaplote()
      CASE wOpa = 3
         SELECT 1
         USE CHEQUE
         wMod:= "CHQ"
         wNomemod:= "CADASTRO DE CHEQUES "
         pcaplote()
      CASE wOpa = 4
         altvalor()
      CASE wOpa = 5
         preenchenr()
      CASE wOpa = 6 .OR. wOpa = 0
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MOVIMENTO
 
   DO WHILE ( .T. )
      mensagem("Para ver mais instrucoes sobre o sistema - Tecle F1 ", ;
         " ")
      mEns:= " "
      tone(300, 1)
      setcursor(0)
      tEcla:= InKey(0)
      tEcla:= IIF( tEcla > 256, tEcla - 256, tEcla )
      setcursor(1)
      IF ( LastRec() = 0 .AND. tEcla != -1 .AND. tEcla != -30 .AND. ;
            tEcla != -9 .AND. tEcla != 27 .AND. tEcla != 28 )
         mensagem("ARQUIVO VAZIO... SO PERMITE INCLUSAO!! ", "P")
         RETURN
      ENDIF
      DO CASE
      CASE tEcla = 27
         IF ( used() )
            SET FILTER TO
         ENDIF
         wFiltra:= .F.
         RETURN
      CASE tEcla = 1
         GOTO TOP
      CASE tEcla = 6
         GOTO BOTTOM
      CASE tEcla = 3
         SKIP
         IF ( EOF() )
            mensagem("VOCE ESTA NO FIM DO ARQUIVO", " ")
            tone(2000, 3)
            InKey(1)
            SKIP -1
         ENDIF
      CASE tEcla = 18
         IF ( .NOT.BOF() )
            SKIP -1
         ELSE
            mensagem("VOCE ESTA NO INICIO DO ARQUIVO", " ")
            tone(2000, 3)
            InKey(1)
         ENDIF
      CASE tEcla = -1
         mEns:= "INCLUSAO - "
         RETURN
      CASE tEcla = -2
         mEns:= "ALTERACAO - "
         RETURN
      CASE tEcla = -8
         mEns:= "EXCLUSAO - "
         RETURN
      CASE tEcla = -9
         wConfig:= .NOT.wConfig
         regua()
         LOOP
      CASE tEcla = 28
         help("PROC001", 188, "TECLA")
         LOOP
      OTHERWISE
         LOOP
      ENDCASE
      ZERA&WMOD()
      LE&WMOD()
      IF ( wMod = "FAT" .OR. wMod = "CHQ" )
         IF ( wCapa_Lote = "S" )
            GET&WMOD()
         ELSE
            GETC&WMOD()
         ENDIF
      ELSE
         GET&WMOD()
      ENDIF
      CLEAR GETS
      LOOP
   ENDDO
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE NEWDISK
 
   LOCAL Local1:= wDelcnt:= wErrorcode:= 0, Local2:= {}
   setint24(.T.)
   DO WHILE ( .T. )
      fclose(fcreate(wBackfile))
      wErrorcode:= getint24()
      IF ( wErrorcode = 1 .OR. wErrorcode = 3 )
         IF ( wErrorcode == 1 )
            alert("Disco esta protegido !!! - Verifique...", Nil, ;
               "/BG")
         ELSE
            alert("Disco nao esta pronto - Verifique!!!", Nil, "/BG")
         ENDIF
         IF ( InKey(0) != K_ESC )
            LOOP
         ELSE
            wRet_Value:= 12
            EXIT
         ENDIF
      ENDIF
      IF ( wErrorcode == 13 )
         wConf:= alert("Disco nao formatado, Formata? ", {"Sim", ;
            "Nao"}, "/BG")
         IF ( wConf == 1 )
            IF ( file("FORMAT.COM") .OR. file("FORMAT.EXE") .OR. ;
                  file("FORMAT.BAT") .AND. .NOT.Empty(wDrive) )
               SAVE SCREEN
               CLEAR SCREEN
               CLEAR GETS
               alert("EXECUTANDO A FORMATACAO DO DISCO ", Nil, "/BG")
               RUN "FORMAT &WDRIVE"
               RESTORE SCREEN
            ELSE
               alert("Programa Format nao encontrado ", Nil, "/BG")
               KEYBOARD Chr(27)
               wRet_Value:= 11
               EXIT
            ENDIF
         ELSE
            LOOP
         ENDIF
      ELSEIF ( wErrorcode > 0 )
         alert("ERRO FATAL! - PRESSIONE UMA TECLA PARA ABORTAR.", ;
            Nil, "/BG")
         wRet_Value:= 12
      ELSE
         wDelcnt:= adir(wDrive + "*.*")
         IF ( wDelcnt > 1 )
            IF ( alerta(15, 30, ;
                  "Apaga os Arquivos do DISQUETE no drive " + ;
                  wDrive, {"Apaga", "Nao"}) == 1 )
               asize(Local2, wDelcnt)
               adir(wDrive + "*.*", Local2)
               FOR Local1:= 1 TO wDelcnt
                  IF ( Local2[ Local1 ] != "COMMAND.COM" )
                     ERASE (wDrive + Local2[ Local1 ])
                  ENDIF
               NEXT
            ENDIF
         ENDIF
         EXIT
      ENDIF
   ENDDO
   setint24(.F.)
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION OPENSOURCE
 
   wSourcedt:= filedate(wSource)
   wSourceti:= filetime(wSource)
   IF ( Empty(wSourcedt) .OR. Empty(wSourceti) )
      alert("ERRO VERIFICADO " + wSource + "Arquivo ", Nil, "/BG")
      wRet_Value:= 3
      RETURN .F.
   ENDIF
   wShandle:= fopen(wSource)
   IF ( ferror() > 0 )
      alert("ERRO Fatal! Nao pode abrir o arquivo  " + wSource, Nil, ;
         "/BG")
      wRet_Value:= 2
      RETURN .F.
   ENDIF
   wTotal:= fseek(wShandle, 0, 2)
   wRemaining:= wTotal
   fseek(wShandle, 0)
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
STATIC FUNCTION OPENTARGET
 
   wThandle:= fcreate(wTarget)
   IF ( ferror() > 0 )
      alert("ERRO Fatal! Nao criou o arquivo " + wTarget, Nil, "/BG")
      wRet_Value:= 4
      RETURN .F.
   ENDIF
   RETURN .T.
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PCAPLOTE
 
   RESTORE SCREEN FROM wT1
   PUBLIC wCapalote
   mensagem(@wNomemod, "T")
   SELECT 1
   GOTO BOTTOM
   ZERA&WMOD()
   ZERAC&WMOD()
   LE&WMOD()
   IF ( cApa_Lote = "S" )
      GET&WMOD()
   ELSE
      GETC&WMOD()
   ENDIF
   CLEAR GETS
   regua()
   a:= .T.
   DO WHILE ( a )
      wB:= .T.
      @  5, 60 SAY Space(19)
      SET COLOR TO N/W
      @  5, 72 SAY "CADASTRO"
      SET COLOR TO
      movimento()
      IF ( tEcla == 27 )
         CLOSE
         RETURN
      ENDIF
      mensagem(" ", " ")
      IF ( tEcla = -1 )
         SET COLOR TO N/W
         @  5, 72 SAY "INCLUSAO"
         SET COLOR TO
         wCapa_Lote:= "S"
         DO WHILE ( wB )
            ZERA&WMOD()
            DO WHILE ( .T. )
               GET&WMOD()
               READ
               IF ( LastKey() == K_ESC )
                  wB:= .F.
                  EXIT
               ENDIF
               mensagem("CONFIRMA OS DADOS (S/N)? ", "S")
               IF ( wConf = "S" )
                  ZERAC&WMOD()
                  c:= .T.
                  DO WHILE ( c )
                     GETC&WMOD()
                     READ
                     mensagem(" ", " ")
                     wCc:= " "
                     @ 23, 15 SAY ;
                        "CONFIRMA OS DADOS (S/N) OU SAI SEM GRAVAR (E)? " ;
                        GET WCC PICTURE "!" VALID wCc $ "SNE"
                     READ
                     mensagem(" ", " ")
                     IF ( wCc = "E" )
                        RETURN
                     ENDIF
                     IF ( wCc = "S" )
                        SELECT 1
                        APPEND BLANK
                        IF ( wCapa_Lote = "S" )
                           REP&WMOD()
                           APPEND BLANK
                           REPC&WMOD()
                        ELSE
                           REPC&WMOD()
                        ENDIF
                        wTsoma:= wTsoma + wVal_Tit
                        mensagem("CONTINUA INCLUSAO NESTE MESMO LOTE", ;
                           "S")
                        IF ( wConf = "S" .AND. LastKey() != K_ESC )
                           ZERAC&WMOD()
                           wCapa_Lote:= "N"
                           LOOP
                        ELSE
                           IF ( wTsoma != wSoma )
                              mensagem("SOMA DOS VALORES DO TITULO NAO BATE COM O VALOR INFORMADO NA CAPA DE LOTE", ;
                                 "P")
                           ENDIF
                           SELECT 5
                           USE ALOTE
                           GOTO 1
                           IF ( wMod = "FAT" )
                              REPLACE nR_Lote WITH wNr_Lote
                              wNr_Lote:= wNr_Lote + 1
                           ELSE
                              REPLACE nR_Lotec WITH wNr_Lotec
                              wNr_Lotec:= wNr_Lotec + 1
                           ENDIF
                           ZERA&WMOD()
                           wCapa_Lote:= "S"
                           EXIT
                        ENDIF
                     ELSE
                        LOOP
                     ENDIF
                  ENDDO
               ELSE
                  LOOP
               ENDIF
            ENDDO
         ENDDO
      ELSEIF ( tEcla = -2 )
         IF ( SubStr(wAltexc, 1, 1) = "N" )
            mensagem("ALTERACAO NAO  PERMITIDA", "P")
            LOOP
         ENDIF
         SET COLOR TO N/W
         @  5, 71 SAY "ALTERACAO"
         SET COLOR TO
         DO WHILE ( wB )
            IF ( wMod = "FAT" .OR. wMod = "CHQ" )
               IF ( wCapa_Lote = "S" )
                  GET&WMOD()
               ELSE
                  GETC&WMOD()
               ENDIF
            ELSE
               GET&WMOD()
            ENDIF
            READ
            IF ( LastKey() == K_ESC )
               EXIT
            ENDIF
            mensagem("CONFIRMA OS DADOS (S/N)? ", "S")
            IF ( wConf = "S" )
               SELECT 1
               IF ( wCapa_Lote = "S" )
                  REP&WMOD()
                  wWnr:= RecNo()
                  SKIP
                  DO WHILE ( cApa_Lote != "S" .AND. .NOT.EOF() )
                     IF ( "&WMOD" = "FAT" )
                        REPLACE eSp_Doc WITH wEsp_Doc
                        REPLACE iDent_Ser WITH wIdent_Ser
                        REPLACE tIpo_Moeda WITH wTipo_Moed
                        REPLACE cOd_Tarifa WITH wCod_Tarif
                        REPLACE cOd_Cart WITH wCod_Cart
                     ELSE
                        REPLACE cOd_Reapr WITH wCod_Reapr
                     ENDIF
                     SKIP
                  ENDDO
                  GOTO wWnr
               ELSE
                  REPC&WMOD()
               ENDIF
               EXIT
            ELSE
               LOOP
            ENDIF
         ENDDO
      ELSEIF ( tEcla = -8 )
         IF ( SubStr(wAltexc, 2, 1) = "N" )
            mensagem("EXCLUSAO NAO  PERMITIDA", "P")
            LOOP
         ENDIF
         SET COLOR TO N/W
         @  5, 72 SAY "EXCLUSAO"
         SET COLOR TO
         mensagem("CONFIRMA A EXCLUSAO (S/N)?", "N")
         IF ( wConf = "S" )
            IF ( cApa_Lote = "N" )
               wNr_Loted:= nR_Lote
               DELETE
               wReg:= RecNo() - 1
               SKIP
               IF ( EOF() .OR. nR_Lote != wNr_Loted )
                  GOTO wReg
                  IF ( cApa_Lote = "S" )
                     DELETE
                  ENDIF
               ENDIF
            ELSE
               mensagem("EXCLUSAO DE CAPA DE LOTE NAO PERMITIDA!", ;
                  "P")
            ENDIF
            IF ( .NOT.EOF() )
               SKIP
            ELSE
               SKIP -1
            ENDIF
         ELSE
            LOOP
         ENDIF
      ENDIF
   ENDDO
   CLOSE DATABASES
   SELECT 1
   CLOSE FORMAT
   RESTORE SCREEN FROM wT1
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PCRIA
 
   PRIVATE wMcampo[40]
   IF ( .NOT.file("EMPRESA.DBF") )
      wMcampo[ 1 ]:= "NOME       C  30 0"
      wMcampo[ 2 ]:= "COD_AGE    C 005 0"
      wMcampo[ 3 ]:= "MODALIDADE C 002 0"
      wMcampo[ 4 ]:= "NR_CONTA   C 008 0"
      wMcampo[ 5 ]:= "DT_ULT_MOV D 008 0"
      wArqcriar:= "EMPRESA"
      wQtcampos:= 5
      pcriarq()
      USE EMPRESA
      APPEND BLANK
   ENDIF
   IF ( .NOT.file("FATURA.DBF") )
      wArqcriar:= "FATURA"
      wMcampo[ 1 ]:= "NOSSO_NR   C 008 0"
      wMcampo[ 2 ]:= "COD_TARIFA C 002 0"
      wMcampo[ 3 ]:= "COD_REAPR  C 001 0"
      wMcampo[ 4 ]:= "COD_CART   C 001 0"
      wMcampo[ 5 ]:= "IDENT_SER  C 002 0"
      wMcampo[ 6 ]:= "NR_DOC     C 010 0"
      wMcampo[ 7 ]:= "DT_VENC    D 008 0"
      wMcampo[ 8 ]:= "VAL_TITULO N 017 5"
      wMcampo[ 9 ]:= "BANCO_COB  C 007 0"
      wMcampo[ 10 ]:= "ESP_DOC    C 002 0"
      wMcampo[ 11 ]:= "ACEITE     C 001 0"
      wMcampo[ 12 ]:= "DT_EMIS    D 008 0"
      wMcampo[ 13 ]:= "INST_COB   N 004 0"
      wMcampo[ 14 ]:= "COD_MORA   N 001 0"
      wMcampo[ 15 ]:= "MORA       N 013 2"
      wMcampo[ 16 ]:= "DT_DESC    D   8 0"
      wMcampo[ 17 ]:= "VAL_DESC   N  14 2"
      wMcampo[ 18 ]:= "VAL_IOC    N  14 2"
      wMcampo[ 19 ]:= "ABATIMENTO N  14 2"
      wMcampo[ 20 ]:= "TIPO_CIC   N   2 0"
      wMcampo[ 21 ]:= "NR_CIC     C  14 0"
      wMcampo[ 22 ]:= "NOME_SAC   C  37 0"
      wMcampo[ 23 ]:= "SUP_CEP    C   3 0"
      wMcampo[ 24 ]:= "END_SAC    C  40 0"
      wMcampo[ 25 ]:= "CEP        C   5 0"
      wMcampo[ 26 ]:= "CIDADE     C  15 0"
      wMcampo[ 27 ]:= "ESTADO     C   2 0"
      wMcampo[ 28 ]:= "NR_SACADOR C  10 0"
      wMcampo[ 29 ]:= "NO_SACADOR C  30 0"
      wMcampo[ 30 ]:= "PRAZO_PROT N   2 0"
      wMcampo[ 31 ]:= "TIPO_MOEDA C   1 0"
      wMcampo[ 32 ]:= "NR_LOTE    N   3 0"
      wMcampo[ 33 ]:= "CAPA_LOTE  C   1 0"
      wQtcampos:= 33
      pcriarq()
   ENDIF
   IF ( .NOT.file("CHEQUE.DBF") )
      USE FATURA
      COPY STRUCTURE TO CHEQUE.DBF
      CLOSE
   ENDIF
   IF ( .NOT.file("ALOTE.DBF") )
      mensagem("CRIANDO O ARQUIVO PARA CONTROLE DE LOTES", " ")
      wArqcriar:= "ALOTE"
      wMcampo[ 1 ]:= "NR_LOTE    N   3 0"
      wMcampo[ 2 ]:= "NR_LOTEC   N   3 0"
      wQtcampos:= 2
      pcriarq()
      USE ALOTE
      APPEND BLANK
      REPLACE nR_Lote WITH 0
      REPLACE nR_Lotec WITH 0
      CLOSE
   ENDIF
   IF ( .NOT.file("EMIH.DBF") )
      mensagem("CRIANDO O ARQUIVO DE HELP DA JANELA", " ")
      wArqcriar:= "EMIH"
      wMcampo[ 1 ]:= "PROGRAMA   C  25 0"
      wMcampo[ 2 ]:= "CHELP      M  10 0"
      wQtcampos:= 2
      pcriarq()
   ENDIF
   IF ( file("REG.DBF") )
      ERASE REG.DBF
   ENDIF
   mensagem("CRIANDO O ARQUIVO DE REG DA JANELA", " ")
   wArqcriar:= "REG"
   wMcampo[ 1 ]:= "CAMPO1     C 200 0"
   wMcampo[ 2 ]:= "CAMPO2     C 200 0"
   wQtcampos:= 2
   pcriarq()
   wVv:= 0
   IF ( file("FATURAR.DBF") )
      ERASE FATURAR.DBF
   ENDIF
   IF ( .NOT.file("FATURAR.DBF") )
      mensagem("CRIANDO O ARQUIVO PARA OS CHEQUES EMITIDOS", " ")
      wArqcriar:= "FATURAR"
      wMcampo[ 1 ]:= "NOSSO_NR   C 008 0"
      wMcampo[ 2 ]:= "COD_CART   C 001 0"
      wMcampo[ 3 ]:= "IDENT_SER  C 002 0"
      wMcampo[ 4 ]:= "NR_DOC     C 010 0"
      wMcampo[ 5 ]:= "DT_VENC    C 008 0"
      wMcampo[ 6 ]:= "VAL_TITULO N 017 5"
      wMcampo[ 7 ]:= "BANCO_COB  C 007 0"
      wMcampo[ 8 ]:= "ESP_DOC    C 002 0"
      wMcampo[ 9 ]:= "INST_COB   N 004 0"
      wMcampo[ 10 ]:= "COD_MORA   N 001 0"
      wMcampo[ 11 ]:= "MORA       N 013 2"
      wMcampo[ 12 ]:= "DT_DESC    D   8 0"
      wMcampo[ 13 ]:= "VAL_DESC   N  14 2"
      wMcampo[ 14 ]:= "VAL_IOC    N  14 2"
      wMcampo[ 15 ]:= "TIPO_CIC   N   2 0"
      wMcampo[ 16 ]:= "NR_CIC     C  14 0"
      wMcampo[ 17 ]:= "NR_SACADOR C  10 0"
      wMcampo[ 18 ]:= "NO_SACADOR C  30 0"
      wMcampo[ 19 ]:= "PRAZO_PROT N   2 0"
      wMcampo[ 20 ]:= "TIPO_MOEDA C   1 0"
      wMcampo[ 21 ]:= "DT_OCOR    D   8 0"
      wMcampo[ 22 ]:= "VALOR_TAR  N  14 2"
      wMcampo[ 23 ]:= "VALOR_JUR  N  14 2"
      wMcampo[ 24 ]:= "ABAT_CON   N  14 2"
      wMcampo[ 25 ]:= "DESC_CON   N  14 2"
      wMcampo[ 26 ]:= "VAL_PAGO   N  14 2"
      wMcampo[ 27 ]:= "MORA_PG    N  14 2"
      wMcampo[ 28 ]:= "ERRO       C  40 0"
      wMcampo[ 29 ]:= "DT_PAG     D   8 0"
      wMcampo[ 30 ]:= "SACADO     C  27 0"
      wQtcampos:= 30
      pcriarq()
   ENDIF
   wVv:= 0
   IF ( file("CHEQUER.DBF") )
      ERASE CHEQUER.DBF
   ENDIF
   IF ( .NOT.file("CHEQUER.DBF") )
      USE FATURAR
      COPY STRUCTURE TO CHEQUER.DBF
      CLOSE
   ENDIF
   IF ( .NOT.file("INSTBLOQ.DBF") )
      mensagem("CRIANDO O ARQUIVO DE INSTRUCOES PARA BLOQUETE", " ")
      wArqcriar:= "INSTBLOQ"
      wMcampo[ 1 ]:= "INST1      C 045 0"
      wMcampo[ 2 ]:= "INST2      C 045 0"
      wMcampo[ 3 ]:= "INST3      C 045 0"
      wMcampo[ 4 ]:= "INST4      C 045 0"
      wMcampo[ 5 ]:= "INST5      C 045 0"
      wMcampo[ 6 ]:= "INST6      C 045 5"
      wMcampo[ 7 ]:= "INST7      C 045 0"
      wQtcampos:= 7
      pcriarq()
   ENDIF
   IF ( .NOT.file("LAYOUT.DBF") )
      mensagem("CRIANDO O ARQUIVO DE LAY-OUT PARA IMPORTACAO", " ")
      wArqcriar:= "LAYOUT"
      wMcampo[ 1 ]:= "INFORMACAO C  40 0"
      wMcampo[ 2 ]:= "NO_INF     C  10 0"
      wMcampo[ 3 ]:= "CONT_CAMPO C  40 0"
      wMcampo[ 4 ]:= "POS_INI    N   3 0"
      wMcampo[ 5 ]:= "POS_FIN    N   3 0"
      wMcampo[ 6 ]:= "TIPO_CAM   C   1 5"
      wMcampo[ 7 ]:= "TAM_CAM    N   3 0"
      wMcampo[ 8 ]:= "DEC_CAM    N   2 0"
      wQtcampos:= 8
      pcriarq()
      USE LAYOUT
      APPEND BLANK
      REPLACE iNformacao WITH "NOSSO NUMERO"
      REPLACE nO_Inf WITH "NOSSO_NR"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 8
      APPEND BLANK
      REPLACE iNformacao WITH "CODIGO DA TARIFA"
      REPLACE nO_Inf WITH "COD_TARIFA"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 2
      APPEND BLANK
      REPLACE iNformacao WITH "CODIGO DE REAPRESENTACAO"
      REPLACE nO_Inf WITH "COD_REAPR"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 1
      APPEND BLANK
      REPLACE iNformacao WITH "CODIGO DA CARTEIRA"
      REPLACE nO_Inf WITH "COD_CART"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 1
      APPEND BLANK
      REPLACE iNformacao WITH "IDENTIFICACAO DO SERVICO"
      REPLACE nO_Inf WITH "IDENT_SER"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 2
      APPEND BLANK
      REPLACE iNformacao WITH "NUMERO DO DOCUMENTO"
      REPLACE nO_Inf WITH "NR_DOC"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 10
      APPEND BLANK
      REPLACE iNformacao WITH "DATA DE VENCIMENTO"
      REPLACE nO_Inf WITH "DT_VENC"
      REPLACE tIpo_Cam WITH "D"
      REPLACE tAm_Cam WITH 8
      APPEND BLANK
      REPLACE iNformacao WITH "VALOR DO TITULO"
      REPLACE nO_Inf WITH "VAL_TITULO"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 17
      APPEND BLANK
      REPLACE iNformacao WITH "BANCO/AGENCIA COBRADORA"
      REPLACE nO_Inf WITH "BANCO_COB"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 7
      APPEND BLANK
      REPLACE iNformacao WITH "ESPECIE DE DOCUMENTO"
      REPLACE nO_Inf WITH "ESP_DOC"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 2
      APPEND BLANK
      REPLACE iNformacao WITH "ACEITE"
      REPLACE nO_Inf WITH "ACEITE"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 1
      APPEND BLANK
      REPLACE iNformacao WITH "DATA DE EMISSAO"
      REPLACE nO_Inf WITH "DT_EMIS"
      REPLACE tIpo_Cam WITH "D"
      REPLACE tAm_Cam WITH 8
      APPEND BLANK
      REPLACE iNformacao WITH "INSTRUCAO DE COBRANCA"
      REPLACE nO_Inf WITH "INST_COB"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 4
      APPEND BLANK
      REPLACE iNformacao WITH "CODIGO DE MORA"
      REPLACE nO_Inf WITH "COD_MORA"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 1
      APPEND BLANK
      REPLACE iNformacao WITH "MORA "
      REPLACE nO_Inf WITH "MORA"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 13
      APPEND BLANK
      REPLACE iNformacao WITH "DATA DE DESCONTO"
      REPLACE nO_Inf WITH "DT_DESC"
      REPLACE tIpo_Cam WITH "D"
      REPLACE tAm_Cam WITH 8
      APPEND BLANK
      REPLACE iNformacao WITH "VALOR DE DESCONTO"
      REPLACE nO_Inf WITH "VAL_DESC"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 14
      APPEND BLANK
      REPLACE iNformacao WITH "VALOR DO IOC"
      REPLACE nO_Inf WITH "VAL_IOC"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 14
      APPEND BLANK
      REPLACE iNformacao WITH "ABATIMENTO"
      REPLACE nO_Inf WITH "ABATIMENTO"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 14
      APPEND BLANK
      REPLACE iNformacao WITH "TIPO DE INSCRICAO (CPF OU CGC)"
      REPLACE nO_Inf WITH "TIPO_CIC"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 2
      APPEND BLANK
      REPLACE iNformacao WITH "NUMERO DO CPF OU CGC"
      REPLACE nO_Inf WITH "NR_CIC"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 14
      APPEND BLANK
      REPLACE iNformacao WITH "NOME DO SACADO"
      REPLACE nO_Inf WITH "NOME_SAC"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 37
      APPEND BLANK
      REPLACE iNformacao WITH "SUPLEMENTO DO CEP"
      REPLACE nO_Inf WITH "SUP_CEP"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 3
      APPEND BLANK
      REPLACE iNformacao WITH "ENDERECO DO SACADO"
      REPLACE nO_Inf WITH "END_SAC"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 40
      APPEND BLANK
      REPLACE iNformacao WITH "CEP"
      REPLACE nO_Inf WITH "CEP"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 5
      APPEND BLANK
      REPLACE iNformacao WITH "CIDADE"
      REPLACE nO_Inf WITH "CIDADE"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 15
      APPEND BLANK
      REPLACE iNformacao WITH "ESTADO"
      REPLACE nO_Inf WITH "ESTADO"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 2
      APPEND BLANK
      REPLACE iNformacao WITH "NUMERO DO SACADOR"
      REPLACE nO_Inf WITH "NR_SACADOR"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 10
      APPEND BLANK
      REPLACE iNformacao WITH "NOME DO SACADOR"
      REPLACE nO_Inf WITH "NO_SACADOR"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 30
      APPEND BLANK
      REPLACE iNformacao WITH "PRAZO DE PROTESTO"
      REPLACE nO_Inf WITH "PRAZO_PROT"
      REPLACE tIpo_Cam WITH "N"
      REPLACE tAm_Cam WITH 2
      APPEND BLANK
      REPLACE iNformacao WITH "TIPO DE MOEDA (0 = REAL)"
      REPLACE nO_Inf WITH "TIPO_MOEDA"
      REPLACE tIpo_Cam WITH "C"
      REPLACE tAm_Cam WITH 2
      CLOSE
   ENDIF
   CLOSE DATABASES
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PCRIARQ
 
   CREATE TEMPSTRU
   FOR wCont:= 1 TO wQtcampos
      APPEND BLANK
      REPLACE fIeld_Name WITH SubStr(wMcampo[ wCont ], 1, 10)
      REPLACE fIeld_Type WITH SubStr(wMcampo[ wCont ], 12, 1)
      REPLACE fIeld_Len WITH Val(SubStr(wMcampo[ wCont ], 14, 3))
      REPLACE fIeld_Dec WITH Val(SubStr(wMcampo[ wCont ], 18, 1))
   NEXT
   CLOSE
   CREATE (wArqcriar) FROM TEMPSTRU
   CLOSE
   ERASE TEMPSTRU.DBF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PGERA1
 
   RESTORE SCREEN FROM wT1
   mensagem("ALTERANDO O CADASTRO DA EMPRESA", "T")
   SELECT 1
   GOTO 1
   zeraemp()
   leemp()
   DO WHILE ( .T. )
      getemp()
      READ
      IF ( LastKey() == K_ESC )
         RETURN
      ENDIF
      mensagem("CONFIRMA OS DADOS (S/N)? OU ENCERRA SEM GRAVAR (E)? ", ;
         "F")
      IF ( wConf = "S" )
         repemp()
         RETURN
      ELSEIF ( wConf = "E" )
         RETURN
      ENDIF
   ENDDO
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PMODAL
 
   IF ( wProv != "01" .AND. wProv != "04" .AND. wProv != "13" .AND. ;
         wProv != "16" .AND. wProv != "17" )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Modalidade da conta informada = " + wProv + ;
         " - esta Incorreta"
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PNR_CONTA
 
   wConta:= wProv
   wDig:= 0
   FOR i:= 1 TO 6
      wDig:= Val(SubStr(wConta, i, 1)) * ( 8 - i ) + wDig
   NEXT
   FOR i:= 8 TO 13
      wDig:= Val(SubStr(wConta, i, 1)) * ( 15 - i ) + wDig
   NEXT
   wDig:= 11 - wDig % 11
   IF ( wDig == 11 )
      wDig:= 1
   ELSEIF ( wDig == 10 )
      wDig:= 0
   ENDIF
   IF ( wDig != Val(SubStr(wConta, 14, 1)) )
      wErro[ w++ ]:= "Registro: " + strzero(RecNo(), 3) + ;
         " / Cod. Registro: " + cOd_Reg + ;
         " - Nr. da conta corrente invalido - " + wConta
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PRECARQ
 
   PARAMETERS wMarq, wTarq
   PUBLIC wArq
   wArq:= Space(8)
   wTam:= Len(wMarq) / 2
   DO WHILE ( .T. )
      @ 10, 30 - wTam CLEAR TO 12, 49 + wTam
      @ 10, 30 - wTam TO 12, 49 + wTam
      @ 10, 32 + wTam TO 12, 44 + wTam
      @ 11, 32 - wTam SAY wMarq
      @ 11, 46 + wTam SAY wTarq
      @ 11, 34 + wTam GET WARQ
      READ
      mensagem("CONFIRMA NOME DO ARQUIVO (S/N)? ", "S")
      IF ( wConf = "N" )
         LOOP
      ENDIF
      wArq:= alltrim(wArq) + "." + alltrim(wTarq)
      IF ( .NOT.file("&WARQ") )
         mensagem("ARQUIVO NAO EXISTE OU NAO FOI ENCONTRADO!", "P")
         wArq:= Space(8)
      ENDIF
      RETURN
   ENDDO
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PREENCHENR
 
   CLOSE DATABASES
   RESTORE SCREEN FROM wT1
   mensagem("CADASTRANDO NOSSO NUMERO IMPRESSO NOS BLOQUETES", "T")
   wNosso_Nr:= Space(10)
   DO WHILE ( .T. )
      @ 10, 10 SAY "ENTRE COM O NOSSO NUMERO INICIAL: " GET ;
         WNOSSO_NR PICTURE "9999999-9"
      READ
      mensagem("CONFIRMA NOSSO NUMERO (S/N)? ", "S")
      IF ( wConf = "S" )
         USE FATURA
         wNossonu:= Val(SubStr(wNosso_Nr, 1, 7))
         DBEval({ || FIELD->nOsso_Nr:= fnossonr(wNossonu++) }, { || ;
            cApa_Lote != "S" .AND. eSp_Doc <= "20" }, Nil, Nil, Nil, ;
            .F.)
         RETURN
      ENDIF
   ENDDO
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PROC001
 
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PROC002
 
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE PROC003
 
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE REGUA
 
   IF ( wConfig )
      @ 21,  0 CLEAR TO 23, 79
      SET COLOR TO GR+
      @ 21,  1 SAY "F1"
      @ 21, 15 SAY "F2"
      @ 21, 31 SAY "F3"
      @ 21, 47 SAY "F9"
      @ 21, 63 SAY "ESC"
      @ 22,  1 SAY "PGUP "
      @ 22,  6 SAY "PGDN "
      @ 22, 11 SAY "HOME "
      @ 22, 16 SAY "END"
      @ 22, 36 SAY "ENTER"
      @ 22, 62 SAY "F10"
      SET COLOR TO
      @ 21,  4 SAY "-> HELP"
      @ 21, 18 SAY "-> INCLUI"
      @ 21, 34 SAY "-> ALTERA"
      @ 21, 50 SAY "-> EXCLUI"
      @ 21, 67 SAY "-> RETORNA"
      @ 22, 21 SAY "-> PESQUISA"
      @ 22, 42 SAY "-> CONFIRMA DADOS"
      @ 22, 66 SAY "-> APAGA REGUA"
      SET COLOR TO
   ELSE
      @ 21,  0 CLEAR TO 22, 79
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RELAT
 
   CLOSE DATABASES
   wOpa:= 1
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem(" M E N U   D E   R E L A T O R I O S ", "T")
      @  8,  5, 10, 38 BOX wMold
      @ 12,  5, 14, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 12, 41, 14, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "    ENTRADA DE FATURAS      "
      @ 13,  8 PROMPT "     FATURAS  RETORNO       "
      @ 17,  8 PROMPT "    B L O Q U E T E S       "
      @  9, 44 PROMPT "   C  H  E  Q  U  E  S      "
      @ 13, 44 PROMPT "    RETORNO DE CHEQUES      "
      @ 17, 44 PROMPT "  VOLTA AO MENU ANTERIOR    "
      MENU TO wOpa
      DO CASE
      CASE wOpa = 1
         relfate()
      CASE wOpa = 2
         rretorno()
      CASE wOpa = 3
         bloquete()
      CASE wOpa = 4
         relchke()
      CASE wOpa = 5
         relcret()
      CASE wOpa = 6 .OR. wOpa = 0
         CLOSE DATABASES
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RELCHKE
 
   verimp()
   IF ( LastKey() == K_ESC )
   ELSE
      USE EMPRESA
      SET CONSOLE OFF
      setprc(61, 0)
      wPag:= 0
      SET DEVICE TO PRINTER
      IF ( PRow() + 1 > 60 )
         EJECT
         wPag:= wPag + 1
      ENDIF
      cabecr("CHEQUES")
      wNr_Conta:= mOdalidade + SubStr(nR_Conta, 2, 7)
      @ PRow() + 1,  0 SAY Space(133)
      @ PRow() + 1,  3 SAY "EMPRESA : " + nOme
      @ PRow() + 1,  3 SAY "AGENCIA : " + Transform(cOd_Age, ;
         "@R 9999-9")
      @ PRow() + 1,  3 SAY "NR.CONTA: " + Transform(wNr_Conta, ;
         "@R 99-999.999-9")
      @ PRow(), 72 SAY "ENTRADA"
      @ PRow() + 1,  0 SAY Space(133)
      USE CHEQUE
      GOTO TOP
      w_Nr_Lote:= 0
      DO WHILE ( .NOT.EOF() .AND. LastKey() != K_ESC )
         IF ( PRow() + 3 > 60 )
            EJECT
            wPag:= wPag + 1
            cabecr("CHEQUES")
            @ PRow() + 1,  0 SAY Space(133)
         ENDIF
         @ PRow(),  0 SAY ""
         IF ( nR_Lote != w_Nr_Lote )
            IF ( PRow() + 3 > 60 )
               EJECT
               wPag:= wPag + 1
               cabecr("CHEQUES")
               @ PRow() + 1,  0 SAY Space(133)
            ENDIF
            @ PRow(),  0 SAY ""
            @ PRow() + 1,  1 SAY Replicate("-", 133)
            @ PRow() + 1,  3 SAY "Numero Do Lote: " + ;
               Transform(nR_Lote, "@Z 999")
            @ PRow(), 55 SAY "Codigo De Reapresentacao: " + cOd_Reapr
            @ PRow(), 106 SAY "Data De Emissao: " + DToC(dT_Emis)
            @ PRow() + 1,  1 SAY Replicate("-", 133)
            w_Nr_Lote:= nR_Lote
            SKIP
            IF ( PRow() + 3 > 60 )
               EJECT
               wPag:= wPag + 1
               cabecr("CHEQUES")
               @ PRow() + 1,  0 SAY Space(133)
            ENDIF
            cabecce()
         ENDIF
         IF ( PRow() + 3 > 60 )
            EJECT
            wPag:= wPag + 1
            cabecr("CHEQUES")
            @ PRow() + 1,  0 SAY Space(133)
         ENDIF
         @ PRow(),  0 SAY ""
         @ PRow() + 1,  3 SAY nR_Doc
         @ PRow(), 16 SAY vAl_Titulo PICTURE "@E 999,999,999.99"
         @ PRow(), 33 SAY DToC(dT_Venc)
         @ PRow(), 46 SAY SubStr(nOme_Sac, 1, 28)
         @ PRow(), 77 SAY SubStr(nOme_Sac, 30, 8)
         @ PRow(), 88 SAY SubStr(eNd_Sac, 1, 20)
         @ PRow(), 112 SAY SubStr(eNd_Sac, 21, 4) + "  " + ;
            SubStr(eNd_Sac, 25, 16)
         @ PRow(),  0 SAY ""
         SKIP
         InKey(0.5)
      ENDDO
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      SET CONSOLE ON
      CLOSE DATABASES
      SELECT 1
      CLOSE FORMAT
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RELCRET
 
   wOpa:= 1
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem("IMPRESSAO DE RELATORIO DE RETORNO DE CHEQUES", "T")
      @  8,  5, 10, 38 BOX wMold
      @ 12,  5, 14, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 12, 41, 14, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "   CONFIRMACAO DE BAIXAS    "
      @ 13,  8 PROMPT "  ENTRADAS -  CONFIRMACAO   "
      @ 17,  8 PROMPT "    TITULOS EM CARTEIRA     "
      @ 17, 44 PROMPT "  VOLTA AO MENU ANTERIOR    "
      MENU TO wOpa
      DO CASE
      CASE wOpa = 1
         rretchq(1)
      CASE wOpa = 2
         rretchq(2)
      CASE wOpa = 3
         rretchq(3)
      CASE wOpa = 4
         RETURN
      CASE wOpa = 5 .OR. wOpa = 0
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RELFATE
 
   verimp()
   IF ( LastKey() == K_ESC )
   ELSE
      USE EMPRESA
      SET CONSOLE OFF
      setprc(61, 0)
      wPag:= 0
      SET DEVICE TO PRINTER
      IF ( PRow() + 1 > 60 )
         EJECT
         wPag:= wPag + 1
      ENDIF
      cabecr("FATURAS")
      wNr_Conta:= mOdalidade + SubStr(nR_Conta, 2, 7)
      @ PRow() + 1,  0 SAY Space(133)
      @ PRow() + 1,  3 SAY "EMPRESA : " + nOme
      @ PRow() + 1,  3 SAY "AGENCIA : " + Transform(cOd_Age, ;
         "@R 9999-9")
      @ PRow() + 1,  3 SAY "NO.CONTA: " + Transform(wNr_Conta, ;
         "@R 99-999.999-9")
      @ PRow(), 72 SAY "ENTRADA"
      USE FATURA
      GOTO TOP
      w_Nr_Lote:= 0
      DO WHILE ( .NOT.EOF() .AND. LastKey() != K_ESC )
         IF ( PRow() + 5 > 60 )
            EJECT
            wPag:= wPag + 1
            cabecr("FATURAS")
            @ PRow() + 1,  0 SAY Space(133)
         ENDIF
         @ PRow(),  0 SAY ""
         IF ( nR_Lote != w_Nr_Lote )
            IF ( PRow() + 3 > 60 )
               EJECT
               wPag:= wPag + 1
               cabecr("FATURAS")
               @ PRow() + 1,  0 SAY Space(133)
            ENDIF
            @ PRow(),  0 SAY ""
            @ PRow() + 1,  1 SAY Replicate("_", 133)
            @ PRow() + 1,  3 SAY "Nr.Do Lote: " + Transform(nR_Lote, ;
               "@Z 999")
            @ PRow(), 22 SAY "Especie De Doc.: " + eSp_Doc
            @ PRow(), 44 SAY "Identificacao Do Servico: " + iDent_Ser
            @ PRow(), 75 SAY "Cod. Da Carteira: " + cOd_Cart
            @ PRow(), 97 SAY "Tipo De Moeda: " + tIpo_Moeda
            @ PRow(), 116 SAY "Cod.Tarifa: " + cOd_Tarifa
            @ PRow() + 1,  1 SAY Replicate("_", 133)
            w_Nr_Lote:= nR_Lote
            SKIP
            LOOP
         ENDIF
         @ PRow() + 1,  1 SAY Space(133)
         @ PRow() + 1,  3 SAY "Nr.Doc.: " + nR_Doc
         @ PRow(), 24 SAY "Emissao: " + DToC(dT_Emis)
         @ PRow(), 43 SAY "Valor Titulo: " + Transform(vAl_Titulo, ;
            "@EB 99,999,999,999.99")
         @ PRow(), 75 SAY "Vencimento: " + DToC(dT_Venc)
         @ PRow(), 97 SAY "Nosso Nr.: " + nOsso_Nr
         @ PRow(), 118 SAY "Prazo Prot.: " + Transform(pRazo_Prot, ;
            "@Z 99")
         @ PRow() + 1,  3 SAY "Cod.Mora: " + Transform(cOd_Mora, ;
            "@Z 9")
         @ PRow(), 16 SAY "Mora: " + Transform(mOra, ;
            "@EB 99,999,999,999.99")
         @ PRow(), 40 SAY "Dt.Desconto: " + DToC(dT_Desc)
         @ PRow(), 63 SAY "Valor Desconto: " + Transform(vAl_Desc, ;
            "@EB 999,999,999,999.99")
         @ PRow(), 98 SAY "Abatimento: " + Transform(aBatimento, ;
            "@EB 999,999,999,999.99")
         @ PRow() + 1,  3 SAY "Aceite: " + aCeite
         @ PRow(), 14 SAY "Cobradora: " + bAnco_Cob
         @ PRow(), 34 SAY "Instr.Cob.: " + Transform(iNst_Cob, ;
            "@Z 9999")
         @ PRow(), 52 SAY "Valor Ioc.: " + Transform(vAl_Ioc, ;
            "@EB 999,999,999,999.99")
         @ PRow(), 82 SAY "Nome Sacado: " + nOme_Sac
         @ PRow() + 1,  3 SAY "End.Sacado: " + eNd_Sac
         @ PRow(), 57 SAY "UF: " + eStado
         @ PRow(), 78 SAY "CEP: " + Transform(cEp + sUp_Cep, ;
            "@R 99999-999")
         @ PRow(), 94 SAY "Cidade: " + cIdade
         @ PRow(), 116 SAY "Tipo CGC/CPF: " + Transform(tIpo_Cic, ;
            "@Z 99")
         IF ( tIpo_Cic == 1 )
            @ PRow() + 1,  3 SAY "CPF: " + Transform(SubStr(nR_Cic, ;
               4, 11), "@R 999.999.999-99")
         ELSE
            @ PRow() + 1,  3 SAY "CGC: " + Transform(nR_Cic, ;
               "@R 99.999.999/9999-99")
         ENDIF
         @ PRow(), 33 SAY "Nr.Sacador: " + nR_Sacador
         @ PRow(), 58 SAY "Nome Do Sacador: " + nO_Sacador
         @ PRow() + 1,  1 SAY Space(133)
         @ PRow(),  0 SAY ""
         SKIP
         InKey(0.5)
         verimp()
      ENDDO
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      SET CONSOLE ON
      CLOSE DATABASES
      SELECT 1
      CLOSE FORMAT
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE REPCCHQ
 
   SELECT 1
   IF ( wNome_Sac = Space(10) .AND. wDt_Venc = CToD("  /  /  ") )
   ELSE
      REPLACE nOsso_Nr WITH "00000000"
      REPLACE cOd_Reapr WITH wCod_Reapr
      REPLACE nR_Doc WITH wNr_Doc
      REPLACE dT_Venc WITH wDt_Venc
      REPLACE vAl_Titulo WITH wVal_Tit
      REPLACE bAnco_Cob WITH "0000000"
      REPLACE aCeite WITH "A"
      REPLACE dT_Emis WITH wDt_Emis
      REPLACE iNst_Cob WITH 0
      REPLACE cOd_Mora WITH 0
      REPLACE mOra WITH 0
      REPLACE vAl_Desc WITH 0
      REPLACE vAl_Ioc WITH 0
      REPLACE aBatimento WITH 0
      REPLACE tIpo_Cic WITH 0
      REPLACE nOme_Sac WITH SubStr(wNome_Sac, 1, 28) + "F" + wFone
      REPLACE eNd_Sac WITH wNbanco + wCodages + wNage
      IF ( tEcla == -1 )
         REPLACE nR_Lote WITH wNr_Lotec
         REPLACE cApa_Lote WITH "N"
      ENDIF
      REPLACE cOd_Tarifa WITH "08"
      REPLACE cOd_Cart WITH "6"
      REPLACE iDent_Ser WITH "00"
      REPLACE tIpo_Moeda WITH "0"
      REPLACE eSp_Doc WITH "29"
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE REPCFAT
 
   SELECT 1
   REPLACE nOsso_Nr WITH wNosso_Nr
   REPLACE cOd_Reapr WITH "0"
   REPLACE nR_Doc WITH wNr_Doc
   REPLACE dT_Venc WITH wDt_Venc
   REPLACE vAl_Titulo WITH wVal_Tit
   REPLACE bAnco_Cob WITH wBanco_Cob
   REPLACE aCeite WITH wAceite
   REPLACE dT_Emis WITH wDt_Emis
   REPLACE iNst_Cob WITH wInst_Cob
   REPLACE cOd_Mora WITH wCod_Mora
   REPLACE mOra WITH wMora
   REPLACE dT_Desc WITH wDt_Desc
   REPLACE vAl_Desc WITH wVal_Desc
   REPLACE vAl_Ioc WITH wVal_Ioc
   REPLACE aBatimento WITH 0
   REPLACE tIpo_Cic WITH wTipo_Cic
   REPLACE nOme_Sac WITH wNome_Sac
   REPLACE sUp_Cep WITH wSup_Cep
   REPLACE eNd_Sac WITH wEnd_Sac
   REPLACE cEp WITH wCep
   REPLACE cIdade WITH wCidade
   REPLACE eStado WITH wEstado
   REPLACE nO_Sacador WITH wNo_Sacado
   REPLACE pRazo_Prot WITH wPrazo_Pro
   IF ( tEcla == -1 )
      REPLACE nR_Lote WITH wNr_Lote
      REPLACE cApa_Lote WITH "N"
   ENDIF
   IF ( wTipo_Cic == 1 )
      REPLACE nR_Cic WITH "000" + SubStr(wNr_Cic, 1, 9) + ;
         SubStr(wNr_Cic, 14, 2)
   ELSE
      REPLACE nR_Cic WITH SubStr(wNr_Cic, 2, 14)
   ENDIF
   REPLACE cOd_Tarifa WITH wCod_Tarif
   REPLACE cOd_Cart WITH wCod_Cart
   REPLACE iDent_Ser WITH wIdent_Ser
   REPLACE tIpo_Moeda WITH wTipo_Moed
   REPLACE eSp_Doc WITH wEsp_Doc
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE REPCHQ
 
   SELECT 1
   REPLACE cOd_Tarifa WITH "08"
   REPLACE cOd_Cart WITH "6"
   REPLACE iDent_Ser WITH "00"
   REPLACE tIpo_Moeda WITH "0"
   REPLACE eSp_Doc WITH "29"
   REPLACE cApa_Lote WITH "S"
   REPLACE vAl_Titulo WITH wSoma
   REPLACE cOd_Reapr WITH wCod_Reapr
   REPLACE dT_Emis WITH wDt_Emis
   IF ( tEcla == -1 )
      REPLACE nR_Lote WITH wNr_Lotec
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE REPEMP
 
   SELECT 1
   IF ( LastRec() == 0 )
      APPEND BLANK
   ENDIF
   REPLACE nOme WITH wNome
   REPLACE cOd_Age WITH wCod_Age
   REPLACE mOdalidade WITH wModalid
   REPLACE nR_Conta WITH "0" + wNr_Conta
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE REPFAT
 
   SELECT 1
   REPLACE cOd_Tarifa WITH wCod_Tarif
   REPLACE cOd_Cart WITH wCod_Cart
   REPLACE iDent_Ser WITH wIdent_Ser
   REPLACE tIpo_Moeda WITH wTipo_Moed
   REPLACE eSp_Doc WITH wEsp_Doc
   REPLACE cApa_Lote WITH "S"
   REPLACE vAl_Titulo WITH wSoma
   IF ( tEcla == -1 )
      REPLACE nR_Lote WITH wNr_Lote
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE RESTORE
 
   LOCAL Local1
   Local1:= .F.
   wDiskno:= 1
   IF ( .NOT.checknext() )
   ELSE
      DO WHILE ( Len(wBacktext) > 0 )
         IF ( .NOT.Local1 )
            IF ( At("!", wBacktext) > 0 )
               wTarget:= SubStr(wBacktext, 1, At("!", wBacktext) - 1)
            ELSEIF ( At("+", wBacktext) > 0 )
               wTarget:= SubStr(wBacktext, 1, At("+", wBacktext) - 1)
            ENDIF
            wSource:= wDrive + wTarget
            IF ( .NOT.opensource() .OR. .NOT.opentarget() )
               EXIT
            ENDIF
         ENDIF
         wBacktext:= SubStr(wBacktext, Len(wTarget) + 1)
         mensagem("Restaurando arquivo " + wSource + ;
            " para Disco Rigido (C:).", " ")
         IF ( Asc(wBacktext) == 33 )
            Local1:= .F.
            DO WHILE ( wRemaining > 0 )
               IF ( .NOT.copybuffer() )
                  EXIT
               ENDIF
            ENDDO
            wBacktext:= SubStr(wBacktext, 3)
         ELSEIF ( Asc(wBacktext) == 43 )
            IF ( .NOT.Local1 )
               DO WHILE ( wRemaining > 0 )
                  IF ( .NOT.copybuffer() )
                     EXIT
                  ENDIF
               ENDDO
            ENDIF
            wDiskno:= wDiskno + 1
            Local1:= .T.
            fclose(wShandle)
            insertdisk()
            IF ( checknext() )
               IF ( .NOT.opensource() )
                  EXIT
               ENDIF
               DO WHILE ( wRemaining > 0 )
                  mensagem("Restaurando arquivo " + wSource + ;
                     " para Disco Rigido.", " ")
                  IF ( .NOT.copybuffer() )
                     EXIT
                  ENDIF
               ENDDO
            ELSE
               wRet_Value:= 12
               EXIT
            ENDIF
         ENDIF
         IF ( .NOT.Local1 .OR. Local1 .AND. SubStr(wBacktext, ;
               Len(wTarget) + 1, 1) = "!" )
            IF ( .NOT.closefiles() )
               RETURN
            ENDIF
         ENDIF
      ENDDO
      RETURN
   ENDIF
 
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