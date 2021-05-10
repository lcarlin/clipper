************************************************
* PROGRAMA   : CEUTIL.PRG
* AUTOR      : LUIZ A. CARLIN
* DATA       : 28/06/94
* DATA ATUA. :   /  /
* FUNCAO     : UTILITARIO DO SISTEMA DE CONTROLE DE ESTOQUE
*
********************************
PROCEDURE ESPACO
SAVE SCREEN TO TELA2
OPCAO="S"
DRIVE="A"
ESP=0
DO WHILE OPCAO="S"
   RESTORE SCREEN FROM TELA2
   sombra(03,47,08,70,.t.)
   @ 04,49 SAY "ENTRE C/ O DRIVE: " GET DRIVE PICTURE "!"
   READ
   IF EMPTY(DRIVE)
      RETURN
   ENDIF
   IF DRIVE>="A" .AND. DRIVE <="C"
      IF DRIVE="A"
         SET DEFA TO A:
         !A:
         ESP=DISKSPACE()
       ELSEIF DRIVE="B"
          SET DEFA TO B:
          !B:
          ESP=DISKSPACE()
      ELSEIF DRIVE="C"
         SET DEFA TO C:
         !C:
         ESP=DISKSPACE()
      ENDIF
      SET DEFA TO C:
      !C:
      ESP=ESP/1024
      ESP=ESP/1024
      @ 05,49 SAY "ESPACO: "+STR(ESP,9,2)
      @ 06,49 SAY "MEGA-BYTES"
      if confirma(07,50,"Outro Drive")
         loop
      endif
   ELSE
      @ 07,50 SAY "DRIVE INVALIDO!!"
      INKEY(0)
      @ 07,50 SAY "                         "
   ENDIF   2
ENDDO
RESTORE SCREEN FROM TELA2
RETURN
******************************************************************************
PROCEDURE RODADOS
SAVE SCREEN TO TELA4
set intensit on
DO WHILE .T.
   SOMBRA(10,13,13,60,.T.)
   COMA:=SPACE(40)
   @ 11,15 SAY "Digite o Comando Ou <ENTER> P/ Sair"
   @ 12,15 get COMA PICT "@!"
   READ
   IF COMA=SPACE(40)
      RESTORE SCREEN FROM TELA4
      RETURN
   ENDIF
   COMA:=ALLTRIM(COMA)
   SAVE SCREEN TO TELA4A
   COR:=SETCOLOR()
   SET COLOR TO
   CLEAR
   RUN &COMA
   @ ROW(),25 SAY "Tecle algo p/ Continuar"
   inkey (0)
   SETCOLOR(&COR)
   RESTORE SCREEN FROM TELA4A
ENDDO
RETURN
*****************************************************************************
PROCEDURE COPSEG
SAVE SCREEN TO TELA5
UNI:="  "
sombra(04,44,08,75,.t.)
@ 05,46 SAY "Unidade Destino : " GET UNI PICT "@!"
@ 06,46 SAY "Ou <ENTER> P/ Sair"
READ
save screen to tela5a
IF empty(UNI)
   RESTORE SCREEN FROM TELA5
   SET INTEN ON
   RETURN
ENDIF
if uni >="A:" .AND. UNI<="B:"
   SAVE SCREEN TO TELA5A
   CLEAR
   RUN BACKUP C: &UNI
   RESTORE SCREEN FROM TELA5A   
ELSE
   @ 07,45 SAY "Drive Invalido!!"
   inkey(.9)
   restore screen from tela5a
   return
endif
RETURN
*****************************************************************************
PROCEDURE COPARQ
UNI:="  "
set intens on
CLOSE DATABASES
SAVE SCREEN TO TELA7
CA=0
USE CEMOVIME INDEX CEIMOV1
mcodmat:=space(15)
IF .NOT. FILE ([CPI.MEM])
   CA=0
ELSE
   RESTORE FROM CPI ADDITIVE
ENDIF
sombra(04,44,10,74,.t.)
@ 05,45 SAY "Codigo Do Material:"
@ 06,45 say "Ou Enter P/ Sair"
@ 07,45 get mcodmat pict "@!"
read
IF empty(mcodmat)
   RESTORE SCREEN FROM TELA7
   SET INTEN ON
   return
ENDIF
SEEK MCODMAT
IF .NOT. FOUND()
   @ 08,45 SAY "Nao encontrado"
   inkey (2)
   return
endif
@ 08,45 SAY "Unidade Destino :" GET UNI PICT "@!"
READ
IF empty(uni)   
   RESTORE SCREEN FROM TELA7
   SET INTEN ON
   return
ENDIF
if uni >="A:" .OR. UNI<="B:"
   SET CONSOLE OFF
   SET TALK OFF
   SET ECHO OFF
   CA=CA+1
   use cemovime
   COPY TO TMP.DBF FOR CODMAT=MCODMAT
   ARQ=ALLTRIM(STR(CA,5,0))
   FIL="TMP"+ARQ
   FIL2=FIL+".DBF"
   fil2=alltrim(fil2)
   uni=ALLTRIM(UNI)
   RUN COPY TMP.DBF &UNI&FIL2
   SAVE TO CPI ALL LIKE CA
   SET CONSOLE ON
else
   @ 19,45 SAY "DRIVE INVALIDO!!"
   inkey(0)
   RETURN
ENDIF
RETURN

*****************************************
PROCEDURE MANUTSEN
sombra(07,39,11,77,.t.)
@ 08,40 SAY "Digite A Senha Anterior.:"
@ 09,40 say "Digite a Nova Senha.....:"
@ 10,40 say "Confirme a Nova Senha...:"
IF FILE ([SENHA.MEM])
   RESTORE FROM SENHA   additive
   v_senha_1=seguran(08,66)
   IF EMPTY(V_SENHA_1)
      return
   endif
   v_senha_1=verisenha(v_senha_1)
   if V_senha_1<>senha_mem
      senha_inv()
      return
   endif
ELSE
   V_SENHA_1=SPACE(10)       
   V_SENHA_2=SPACE(10)
   V_SENHA_3=SPACE(10)
   SENHA_MEM=SPACE(10)
ENDIF
v_senha_2=Seguran(09,66)
v_senha_3=seguran(10,66)
if empty(v_senha_2) .and. empty(v_senha_3)
   @ 11,12 say "Excluir Senha (S/N)?" get conf pict "!"
   read
   if conf="S"
      delete file senha.mem
   endif
endif
if v_senha_2=V_senha_3
   senha_mem=V_senha_2
   senha_mem=verisenha(senha_mem)
   save to senha all like senha_mem
else
   senha_inv()
   return
endif

**************************************************
PROCEDURE imp_cod
SAVE SCREEN TO TLMENU
use material index inx1
GOTO TOP
IF ISPRINTER()
   @ 21,29 SAY "Imprimindo..."
   SET CONS OFF
   SET DEVICE TO PRINTER
   @ 00,49 SAY "Codigos De Materiais"
   PAG=1
   LIN=2
   @ 02,03 SAY "PAG. "+STR(PAG,3,0)
   @ LIN + 1,01 SAY "Codigo        "+"  Material "+space(35)+ "           Classificacao  "+"  Data de Entrada"
   DO WHILE  .NOT. EOF()
      @ LIN + 2,01 SAY CODMAT
      @ LIN + 2,17 SAY MATERIAL
      @ LIN + 2,72 SAY CLASS
      @ LIN + 2,89 SAY DATAEN
      LIN=LIN+1
      SKIP
      DO WHILE LIN >= 63
         LIN=3
         PAG=PAG+1
         EJECT
         @ 02,03 SAY "PAG.:"+STR(PAG,3,0)
      ENDDO
   ENDDO
   EJECT
   SET DEVICE TO SCREEN
   SET INTEN ON
   SET CONS ON
   @ 21,29 SAY SPACE(15)
   GOTO TOP
ELSE
   TONE (250,2)
   SET CONS ON
   @ 21,15 SAY "A impressora n„o pode estar pronta; tecle <ENTER>"
   INKEY(0)
   RESTORE SCREEN FROM TLMENU
ENDIF
CLOSE ALL
set cursor on
RESTORE SCREEN FROM TLMENU
RETURN
***************************************************************
PROCEDURE imp_esc
SAVE SCREEN TO TLMENU
use escola index inx2
GOTO TOP
IF ISPRINTER()
   @ 21,29 SAY "Imprimindo..."
   SET CONS OFF
   SET DEVICE TO PRINTER
   @ 00,49 SAY "Codigos De Escolas"
   PAG=1
   LIN=2
   @ 02,03 SAY "PAG. "+STR(PAG,3,0)
   @ LIN + 1,01 SAY "Codigo        "+"  Escola"
   DO WHILE  .NOT. EOF()
      @ LIN + 2,01 SAY CODesco
      @ LIN + 2,17 SAY ESCOLA
      LIN=LIN+1
      SKIP
      DO WHILE LIN >= 63
         LIN=3
         PAG=PAG+1
         EJECT
         @ 02,03 SAY "PAG.:"+STR(PAG,3,0)
      ENDDO
   ENDDO
   EJECT
   SET DEVICE TO SCREEN
   SET INTEN ON
   SET CONS ON
   @ 21,29 SAY SPACE(15)
   GOTO TOP
ELSE
   TONE (250,2)
   SET CONS ON
   @ 21,15 SAY "A impressora n„o pode estar pronta; tecle <ENTER>"
   INKEY(0)
   RESTORE SCREEN FROM TLMENU
ENDIF
CLOSE ALL
set cursor on
RESTORE SCREEN FROM TLMENU
RETURN

***********************************************************
PROCEDURE TABELA
PARAMETERS NPRO
IF NPRO=1   .or. npro=3
   public mcb := {"Codigo","Material"}
   public mmc2:= {"@!","@!"}
   public mcp2:= {"CODMAT","MATERIAL"}
ELSEIF NPRO=2
   public mcb := {"Codigo","Escola"}
   public mmc2:= {"@!","@!"}
   public mcp2:= {"CODESCO","ESCOLA"}
endif
save screen to tela_tab
@ 07,07 TO 22,71
@ 21,08 SAY "<ENTER> Seleciona"
dbedit(08,08,20,70,mcp2,"funcao",mmc2,mcb,.t.,.t.,.t.)
restore screen from tela_tab
return

*******************************************************************
function funcao
parameters stat, pos
if stat=4
   if lastkey()=13
      if npro=1 .or. npro=3
         mcodmat=codmat
      else
          mcode=codesco
          mcodesco=codesco
      endif
      return 0
   endif
else
  return 1
endif

******************************************************************
function centra (LINHA_1,MENSAGEM)
@ linha_1,int(80-len(alltrim(mensagem)))/2 say mensagem

**************************************
procedure senha_inv
@ 16,41 say "Senha Invalida"
inkey(1.2)
return
* Eop cefunc.prg