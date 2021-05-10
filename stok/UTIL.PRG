************************************************
* PROGRAMA   : UTIL.PRG
* AUTOR      : LUIZ A. CARLIN
* DATA       : 22/12/93
* DATA ATUA. :   /  /
* FUNCAO     : UTILITARIO DO SISTEMA DE CONTROLE DE ESTOQUE
*
********************************
OPU=0
SET PROCEDURE TO UTIL
SAVE SCREEN TO TELA1
SET WRAP ON
SET INTEN ON
SET COLOR TO N/W
SET COLOR TO W/N
@ 13,32,20,58 BOX CHR(176)
@ 12,32 CLEAR TO 19,57
@ 12,31 TO 19,56 DOUBLE
SET COLOR TO N/W
@ 13,56 SAY CHR(24)
@ 14,56 SAY CHR(177)
@ 15,56 SAY CHR(177)
@ 16,56 SAY CHR(177)
@ 17,56 SAY CHR(177)
@ 18,56 SAY CHR(25)
SET COLOR TO
save screen to tela1_a1
DO WHILE .T.
   restore screen from tela1_a1
   set intensity on
   @ 12,39 SAY "UTILITARIO:"
   @ 13,33 PROMPT "1.MANUTEN€O DE SENHAS"
   @ 14,33 PROMPT "2.ESPA€O DE DISCO...."
   @ 15,33 PROMPT "3.RODA DOS..........."
   @ 16,33 PROMPT "4.FAZ BACKUP DO SIST."
   @ 17,33 PROMPT "5.COPIA ARQ. DE DADOS"
   @ 18,33 PROMPT "6.RETORNA P/ MENU...."
   if lastkey()=27
      opu=6
      keyboard chr(13)
   endif
   MENU TO OPU
   DO CASE
      CASE OPU=1
           DO MANUTSEN
      CASE OPU=2
           DO ESPACO
      CASE OPU=3
           DO RODADOS
      CASE OPU=4
           DO COPSEG
      CASE OPU=5
            DO COPARQ
      CASE OPU=6
           SET PROCEDURE TO
           RESTORE SCREEN FROM TELA1
           SET INTEN ON
           RETURN
  ENDCASE
ENDDO
*********************************************************************
PROCEDURE MANUTSEN
@ 13,40,17,78 BOX "°"
@ 12,39 clear to 16,77
@ 12,39 TO 16,77
IF FILE ([SENHA.MEM])
   RESTORE FROM SENHA   additive
   @ 13,40 SAY "Digite A Senha Anterior"
   v_senha_1=seguran(13,66)
   if empty(V_senha_1)
      return
   endif
   if V_senha_1<>senha_mem
      senha_inv()
      return
   endif
else
   V_SENHA_1=SPACE(10)       
   V_SENHA_2=SPACE(10)
   V_SENHA_3=SPACE(10)
   SENHA_MEM=SPACE(10)
ENDIF
@ 14,40 say "Digite a Nova Senha"
v_senha_2=Seguran(14,66)
if empty(v_senha_2)
   return
endif
@ 15,40 say "Confirme a Nova Senha"
v_senha_3=seguran(15,66)
if empty(v_senha_3)
   return
endif
if v_senha_2=V_senha_3
   senha_mem=V_senha_2
   save to senha all like senha_mem
else
   senha_inv()
   return
endif
*****************************************************************************
PROCEDURE ESPACO
SAVE SCREEN TO TELA2
OPCAO="S"
DRIVE="A"
ESP=0
DO WHILE OPCAO="S"
   RESTORE SCREEN FROM TELA2
   @ 13,49,17,72 box "°"
   @ 12,48 CLEAR TO 16,71
   @ 12,48 TO 16,71
   @ 13,49 SAY "ENTRE C/ O DRIVE: " GET DRIVE PICTURE "!"
   READ
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
      @ 14,49 SAY "ESPACO: "+STR(ESP,9,2)
      @ 15,49 SAY "MEGA-BYTES"
      @ 17,58 SAY "OUTRO DRIVE?" GET OPCAO PICTURE "!"
      READ
      @ 17,58 SAY "                   "
   ELSE
      @ 17,58 SAY "DRIVE INVALIDO!!"
      INKEY(0)
      @ 17,50 SAY "                         "
   ENDIF
ENDDO
RESTORE SCREEN FROM TELA2
RETURN
******************************************************************************
PROCEDURE RODADOS
SAVE SCREEN TO TELA4
COMA=SPACE(40)
set intensit on
DO WHILE .T.
   @ 21,16,24,77 box "°"
   @ 20,14 clear to 23,76
   @ 20,14 to 23,76
   @ 21,15 SAY "Digite o Comando : "get COMA PICT "@!"
   @ 22,15 say "Ou <ENTER> P/ Sair"
   READ
   IF COMA=SPACE(40)
      RESTORE SCREEN FROM TELA4
      RETURN
   ENDIF
   COMA=ALLTRIM(COMA)
   SAVE SCREEN TO TELA4A
   CLEAR
   RUN &COMA
   @ 24,25 SAY "Tecle <ENTER> p/ Continuar"
   inkey (0)
   RESTORE SCREEN FROM TELA4A
   COMA=SPACE(40)
ENDDO
RETURN
*****************************************************************************
PROCEDURE COPSEG
SAVE SCREEN TO TELA5
set path to c:\dos
DO WHILE .T.
   UNI="  "
                      
   @ 15,46,19,76 box "°"
   @ 14,44 clear to 18,75
   @ 14,44 to 18,75
   @ 15,46 SAY "Unidade Destino : " GET UNI PICT "@!"
   @ 16,46 SAY "Ou <ENTER> P/ Sair"
   READ
   save screen to tela5a
   IF UNI=" "
      RESTORE SCREEN FROM TELA5
      SET INTEN ON
      EXIT
   ENDIF
   if uni >="A:" .AND. UNI<="B:"
      SAVE SCREEN TO TELA5A
      CLEAR
      RUN BACKUP C: &UNI
      RESTORE SCREEN FROM TELA5A
   ELSE
      @ 17,45 SAY "Drive Invalido!!"
      inkey(.9)
      restore screen from tela5a
      loop
  endif
ENDDO
RETURN
*****************************************************************************
PROCEDURE COPARQ
UNI="  "
set intens on
CLOSE DATABASES
SAVE SCREEN TO TELA7
CA=0
USE MOVIME INDEX INX3
DO WHILE .T.
    mcodmat=space(15)
   IF .NOT. FILE ([CPI.MEM])
      CA=0
   ELSE
      RESTORE FROM CPI ADDITIVE
   ENDIF
   UNI="  "
   RESTORE SCREEN FROM TELA7
   @ 15,46,21,75 box "°"
   @ 14,44 clear to 20,74
   @ 14,44 to 20,74
   @ 15,45 SAY "Codigo Do Material:"
   @ 16,45 say "Ou Enter P/ Sair"
   @ 17,45 get mcodmat pict "@!"
   read
   IF mcodmat=space(15)
      RESTORE SCREEN FROM TELA7
      SET INTEN ON
      EXIT
   ENDIF
   SEEK MCODMAT
   IF .NOT. FOUND()
       @ 19,45 SAY "Nao encontrado"
       inkey (.9)
       loop
   endif
   @ 18,45 SAY "Unidade Destino :" GET UNI PICT "@!"
   READ
   IF uni="  "
      RESTORE SCREEN FROM TELA7
      SET INTEN ON
      EXIT
   ENDIF
   if uni >="A:" .OR. UNI<="B:"
      SET CONSOLE OFF
      SET TALK OFF
      SET ECHO OFF
      CA=CA+1
      use movime
      COPY TO AR.DBF FOR CODMAT=MCODMAT
      ARQ=STR(CA,6,0)
      ARQ=ALLTRIM(ARQ)
      FIL="AR"+ARQ
      FIL2=FIL+".DBF"
      fil2=alltrim(fil2)
      uni=ALLTRIM(UNI)
      RUN COPY AR.DBF &UNI&FIL2
      SAVE TO CPI ALL LIKE CA*
      SET CONSOLE ON
   else
      @ 19,45 SAY "DRIVE INVALIDO!!"
      inkey(0)
      loop
   ENDIF
ENDDO
RETURN

*****************************************
FUNCTION SEGURAN
*SET KEY 8 TO _V
PRIVATE CC,REL,TECLA,MSX
PARAMETERS L1,C1
CC=C1+10
SET INTEN OFF
@ L1,C1  SAY SPACE(11)
@ L1,C1-1 SAY "["
@ L1,CC   SAY "]"
declare msx[10]
for i= 1 to 10
    msx[i] = " "
next
V_senha=" "
J=1
do while j <10
   @ L1,C1 GET MSX[J] PICT "!"
   READ
   IF lastkey()=13
      EXIT
   ELSEIF LASTKEY()=27
      RETURN (V_senha)
   ENDIF
   @ L1,C1 SAY "*"
   c1=c1+1
   j=j+1
enddo  
set intensit on
FOR K = 1 TO 10
    V_senha=V_senha+MSX[K]
NEXT
V_senha=ALLTRIM(V_senha)
RETURN (V_senha)
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
*******************************************************************
procedure help
paRAMETERS PROG,LIN,VAR
SAVE SCREEN TO TLHP1
DO CASE
   CASE PROG = "MENU"
       @ 9,9 TO 14,41
       @ 10,10 SAY "     Modulo Menu Principal     "
       @ 11,10 say "-Use As Setas Para  Escolher  A"
       @ 12,10 say "-Opcao Desejada Ou Pressione  A"
       @ 13,10 say "-Tecla De Funcao Desejada      "
       @ 21,15 say "Pressione Algo P/ Continuar"
       inkey(0)
       restore screen from tlhp1
       return
  CASE PROG="INCLUI"
       @ 09,09 TO 13,41
       @ 10,10 SAY "Modulo De Inclus„o de Materiais"
       @ 11,10 Say "-Preencha Os Campos Conforme Os"
       @ 12,10 say "-Seus Respectivos Titulos"
       @ 21,25 say "Pressione Algo P/ Continuar"
       inkey (0)
       RESTORE SCREEN FROM TLHP1
       return
   case prog="CADESC"
       @ 9,9 TO 13,41
       @ 10,10 SAY "Modulo  De  Inclus„o De Escolas"
       @ 11,10 Say "-Preencha Os Campos Conforme Os"
       @ 12,10 say "-Seus Respectivos Titulos"
       @ 21,25 say "Pressione Algo P/ Continuar"
       inkey (0)
       RESTORE SCREEN FROM TLHP1
       return
   case prog="MOVIME"
       @ 9,9 TO 13,41
       @ 10,10 SAY "Modulo De Movimenta‡”es(Baixas)"
       @ 11,10 Say "-Preencha Os Campos Conforme Os"
       @ 12,10 say "-Seus Respectivos Titulos"
       @ 21,25 say "Pressione Algo P/ Continuar"
       inkey (0)
       RESTORE SCREEN FROM TLHP1
       return
   case prog="IMPRI"
       @ 9,9 to 13,41
       @ 10,10 say "Modulo De Relatorios De Baixas"
       @ 11,10 Say "-Preencha Os Campos Conforme Os"
       @ 12,10 say "-Seus Respectivos Titulos"
       @ 21,25 say "Pressione Algo P/ Continuar"
       inkey (0)
       RESTORE SCREEN FROM TLHP1
       return
   case prog="CONSUL"
       @ 9,9 to 13,41
       @ 10,10 say "Modulo De Consulta De Baixas  "
       @ 11,10 Say "-Preencha Os Campos Conforme Os"
       @ 12,10 say "-Seus Respectivos Titulos"
       @ 21,25 say "Pressione Algo P/ Continuar"
       inkey (0)
       RESTORE SCREEN FROM TLHP1
       return
   case prog="EXCLUI"
       @ 9,9 to 13,41
       @ 10,10 say "Modulo de Exclus„o  De  Baixas"
       @ 11,10 Say "-Preencha Os Campos Conforme Os"
       @ 12,10 say "-Seus Respectivos Titulos"
       @ 21,25 say "Pressione Algo P/ Continuar"
       inkey (0)
       RESTORE SCREEN FROM TLHP1
       return
   case Prog="UTIL"
       @ 10,10 say "    Modulo 'Utilitarios'      "
       @ 11,10 Say "-Preencha Os Campos Conforme Os"
       @ 12,10 say "-Seus Respectivos Titulos"
       @ 21,25 say "Pressione Algo P/ Continuar"
       inkey (0)
       RESTORE SCREEN FROM TLHP1
       return
endcase
RETURN

************************************************************************
procedure edit
do edita
return

***********************************************************
PROCEDURE TABELA
PARAMETERS NPRO
IF NPRO=1   .or. npro=3
   DECLARE MCB[2]
   MCB[1]="Codigo"
   MCB[2]="Material"
   DECLARE MMC2[2]
   MMC2[1]="@!"
   MMC2[2]="@!"
   DECLARE MCP2[2]
   MCP2[1]="CODMAT"
   MCP2[2]="maTERIAL"
ELSEIF NPRO=2
   DECLARE MCB[2]
   MCB[1]="Codigo"
   MCB[2]="Escola"
   DECLARE MMC2[2]
   MMC2[1]="@!"
   MMC2[2]="@!"
   DECLARE MCP2[2]
   MCP2[1]="codesco"
   MCP2[2]="escola"
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
function centra
parameters linha_1, mensagem
coluna_1=int(80-len(alltrim(mensagem)))/2
@ linha_1,coluna_1 say mensagem

**************************************
procedure senha_inv
@ 16,41 say "Senha Invalida"
inkey(1.2)
return