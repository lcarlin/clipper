* BOP
#include "common.ch"
#include "inkey.ch"
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
 
