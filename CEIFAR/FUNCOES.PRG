*ARQUIVO DE FUNCOES DO USUARIO
*ARTOR : Wergilio Antunes Fabrin
*************************************
#include "\clipper5\include\inkey.ch"
FUNCTION TELA()
SET DATE TO BRIT
SETCOLOR("")
CLEAR
 
QUADRO(02,00,21,79,7,TELAFRENTE+"/"+TELAFUNDO,,.T.)
QUADRO(22,00,24,79,7,TELAFRENTE+"/"+TELAFUNDO,"Mensagens",.T.)
setcolor(TELAFRENTE+"/"+TELAFUNDO)
@ 05,01 SAY '              ÚÛÛÛÛÛÛÚÛÛ   ÚÛÛ  ÚÛÛÚÛÛÛÛÛÛÚÛÛÛÛÛÛÛÚÛÛÛÛÛÛÚÛÛÛÛÛÛ              '
@ 06,01 SAY '              ³ÛÛÄÄÙ ³ÛÛ   ³ÛÛ  ³ÛÛ³ÛÛÄÄÄÙ³ÛÛÄÄ¿ÛÛ³ÛÛÄÄÙ ÀÄ¿ÛÛÙ               '
@ 07,01 SAY '              ³ÛÛÛÛÛ ³ÛÛ   À¿ÛÛÛÛÛ ³ÛÛÛÛÛÛ³ÛÛ  ³ÛÛ³ÛÛÛÛÛ   ³ÛÛ                '
@ 08,01 SAY '              ³ÛÛÄÙ  ³ÛÛ    À¿ÛÛÛ  ÀÄÄÄ¿ÛÛ³ÛÛ  ³ÛÛ³ÛÛÄÙ    ³ÛÛ                '
@ 09,01 SAY '              ³ÛÛ    ³ÛÛÛÛÛÛ ³ÛÛÛ  ÚÛÛÛÛÛÛ³ÛÛÛÛÛÛÛ³ÛÛ      ³ÛÛ                '
@ 10,01 SAY '              ÀÄÙ    ÀÄÄÄÄÄÙ ÀÄÄÙ  ÀÄÄÄÄÄÙÀÄÄÄÄÄÄÙÀÄÙ      ÀÄÙ                '
@ 13,01 SAY 'ÚÛÛÚÛÛÛÛÛÛ ÚÛÛÛÛÛÛÚÛÛÛÛÛÛÛÚÛÛÛÛÛÛÛÚÛÛÛÛÛÛÛÛÛÛÚÛÛÛÛÛÛÛÚÛÛÛÛÛÛÚÛÛÚÛÛÛÛÛÛÚÛÛÛÛÛÛÛ'
@ 14,01 SAY '³ÛÛ³ÛÛÄÄ¿ÛÛ³ÛÛÄÄÙ ³ÛÛÄÄ¿ÛÛ³ÛÛÄÄ¿ÛÛ³ÛÛÄ¿ÛÛÄ¿ÛÛ³ÛÛÄÄ¿ÛÛÀÄ¿ÛÛÙ ³ÛÛ³ÛÛÄÄÙ ³ÛÛÄÄ¿ÛÛ'
@ 15,01 SAY '³ÛÛ³ÛÛ  ³ÛÛ³ÛÛÛÛÛ ³ÛÛ  ³ÛÛ³ÛÛÛÛÛÛÛ³ÛÛ ³ÛÛ ³ÛÛ³ÛÛÛÛÛÛÛ  ³ÛÛ  ³ÛÛ³ÛÛ    ³ÛÛÛÛÛÛÛ'
@ 16,01 SAY '³ÛÛ³ÛÛ  ³ÛÛ³ÛÛÄÙ  ³ÛÛ  ³ÛÛ³ÛÛÄ¿ÛÛÙ³ÛÛ ³ÛÛ ³ÛÛ³ÛÛÄÄ¿ÛÛ  ³ÛÛ  ³ÛÛ³ÛÛ    ³ÛÛÄÄ¿ÛÛ'
@ 17,01 SAY '³ÛÛ³ÛÛ  ³ÛÛ³ÛÛ    ³ÛÛÛÛÛÛÛ³ÛÛ ³ÛÛÛ³ÛÛ ³ÛÛ ³ÛÛ³ÛÛ  ³ÛÛ  ³ÛÛ  ³ÛÛ³ÛÛÛÛÛÛ³ÛÛ  ³ÛÛ'
@ 18,01 SAY 'ÀÄÙÀÄÙ  ÀÄÙÀÄÙ    ÀÄÄÄÄÄÄÙÀÄÙ ÀÄÄÙÀÄÙ ÀÄÙ ÀÄÙÀÄÙ  ÀÄÙ  ÀÄÙ  ÀÄÙÀÄÄÄÄÙ ÀÄÙ  ÀÄÙ'
SETCOLOR(OPCAOFRENTE+"/"+OPCAOFUNDO)
@ 01,01 SAY "                                  -     Date¯¯¯>           Time¯¯¯>           "
@ 01,01 SAY "Usu rio...: "+identifica+" - "+vquem
@ 01,50 say date()
@ 01,70 say time()
SETCOLOR("")
RETURN
*************************************
FUNCTION MENSAGEM1()
PARAMETER DADO
DO LMEN
SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
@ 23,1 CLEAR TO 23,78
@ 23,1 SAY DADO
SETCOLOR("")
INKEY(0)
RETURN
*****************************
PROCEDURE MENSAGEM
PARAMETERS mensagem
do lmen
SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
@ 23,01 SAY RTRIM(mensagem)
SETCOLOR("")
RETURN
**************************************
FUNCTION CENTRA
PARAMETERS TESTO,LARG_LINHA
TEXTO=TRIM(TEXTO)
IF LARG_LINHA=NIL
   LARG_LINHA=80
ENDIF
RETURN ((LARG_LINHA-LEN(TEXTO))/2)
**************************************
FUNCTION SOMBRA2(LS,CS,LI,CI)
COL=SAVESCREEN(LS+1,CI+1,LI+1,CI+1)
LIN=SAVESCREEN(LI+1,CS+1,LI+1,CI+1)
FOR I = 2 TO LEN(COL)  STEP 2
 COL=STUFF(COL,I,1,CHR(8))
NEXT
FOR I = 2 TO LEN(LIN) STEP 2
 LIN=STUFF(LIN,I,1,CHR(8))
NEXT
RESTSCREEN(LS+1,CI+1,LI+1,CI+1,COL)
RESTSCREEN(LI+1,CS+1,LI+1,CI+1,LIN)
RETURN(.T.)
**************************************
 
FUNCTION QUADRO(LS,cs,li,ci,tipo,COR,TEXTO,CHEIO)
local q[9]
CORBOX=COR
IF TIPO=NIL
 TIPO=1
ENDIF
IF CHEIO=NIL
CHEIO=.F.
ENDIF
q[1]=CHR(201)+CHR(205)+CHR(187)+CHR(186)+;
CHR(188)+CHR(205)+CHR(200)+CHR(186)
q[2]=CHR(218)+CHR(196)+CHR(191)+CHR(179)+;
CHR(217)+CHR(196)+CHR(192)+CHR(179)
q[3]=CHR(213)+CHR(205)+CHR(184)+CHR(179)+;
CHR(190)+CHR(205)+CHR(212)+CHR(179)
q[4]=CHR(214)+CHR(196)+CHR(183)+CHR(186)+;
CHR(189)+CHR(196)+CHR(211)+CHR(186)
q[5]=CHR(220)+CHR(220)+CHR(220)+CHR(219)+;
CHR(219)+CHR(220)+CHR(219)+CHR(219)
q[6]=CHR(218)+CHR(196)+CHR(183)+CHR(186)+;
CHR(188)+CHR(205)+CHR(212)+CHR(179)
q[7]=CHR(201)+CHR(205)+CHR(184)+CHR(179)+;
CHR(217)+CHR(196)+CHR(211)+CHR(186)
IF VALTYPE(TIPO)="C"
 Q[9]=REPL(TIPO,8)
 TIPO=9
ENDIF
IF (tipo >=176 .AND.tipo <=178) .OR.tipo=219
 IF CHEIO
 q[8]=REPLICATE(CHR(tipo),9)
 ELSE
 q[8]=REPLICATE(CHR(tipo),8)
 ENDIF
 tipo=8
ENDIF
IF TIPO<>8 .AND. CHEIO    // LIMPA O FUNDO DO BOX
 Q[TIPO]=Q[TIPO]+CHR(32)
ENDIF
IF COR<>NIL
 CORANTIGA=SETCOLOR()
 SETCOLOR("&CORBOX")
 @ls,cs,li,ci box q[tipo]
 TAM=CI-CS
 IF TEXTO<>NIL
    NOVAPOS=(TAM-LEN(TEXTO))/2
    @ LS,CS+NOVAPOS SAY TEXTO
 ENDIF
 SETCOLOR("&CORANTIGA")
ELSE
 @LS,CS,LI,CI BOX Q[TIPO]
 TAM=CI-CS
 IF TEXTO<>NIL
    NOVAPOS=(TAM-LEN(TEXTO))/2
    @ LS,CS+NOVAPOS SAY TEXTO
 ENDIF
ENDIF
 
**************************************
PROCEDURE LMEN
SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
@ 23,01 CLEAR TO 23,78
SETCOLOR("")
RETURN
**************************************
FUNCTION CENTRAV
PARAMETERS LIN,MENS
@ LIN,(79-LEN(MENS))/2 SAY MENS
RETURN ''
**************************************
PROCEDURE EXCLUI
DO mensagem WITH "Exclui (S/N) ?"
PUBLIC ex
ex = " "
@ 23,COL()+2 GET ex PICT "!" VALID(ex$"SN")
READ
DO lmen
IF ex = "S"
  DO mensagem1 WITH "Exclu¡do  !"
ELSE
  DO mensagem1 WITH "N„o Exclu¡do  !"
ENDIF
RETURN
**************************************
FUNCTION MOK
do lmen
SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
CENTRAV(23,' Pressione [ENTER] p/ Confirmar! [ESC] p/ Abandonar!')
SETCOLOR("")
INKEY(0)
RETURN ''
**************************************
FUNCTION SEEKREC
PARAMETERS KEY
SEEK KEY
RETURN FOUND()
FUNCTION GRAVA
FOR i=1 TO FCOUNT()
    CPO=FIELDNAME(i)
    VAR="V"+CPO
    IF &VAR.!=&CPO.
       REPLACE  &CPO. WITH &VAR.
       COMMIT
    ENDIF
NEXT
***************************************
PROCEDURE GRAVASENHA
LOCAL GETLIST:={} , LIN:=10 , COL:=10, CODIGO:=SPACE(3)
SELECT 1
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
ELSE
   DO Mensagem WITH "O Arquivo de Senha N„o se Encontra dispon¡vel !"
   INKEY(0)
   RETURN
endif
select 2
if netuse("semafaro",.f.,10)
   set index to semafaro
else
   Do Mensagem WITH "O arqu¡vo de dados n„o se encontra dispon¡vel !"
   inkey(0)
   return
endif
SELECT CONSEN
SET ORDER TO 1
SET CURSOR ON
TELASENHA:=SAVESCREEN(0,0,24,79)
@ LIN-1,COL-1 CLEAR TO LIN+3,COL+40
@ LIN-1,COL-1 TO       LIN+3,COL+40
DO WHILE .T.
 CODIGO=SPACE(3)
 VQUEM =SPACE(10)
 @ LIN,COL SAY "OPERADOR.: " GET CODIGO  pict "@!"
 @ LIN+1,COL SAY "NOME.....: " GET VQUEM pict "@!"
 READ
 SEEK CODIGO
 IF .NOT. EOF()
      SET Conso OFF
      @ LIN,COL+20 SAY 'SENHA: '
      WAIT TO Tw1
      TONE(100,1)
      @ LIN,COL() SAY '*'
      WAIT TO Tw2
      TONE(300,1)
      @ LIN,COL() SAY '*'
      WAIT TO Tw3
      TONE(500,1)
      @ LIN,COL() SAY '*'
      WAIT TO Tw4
      TONE(700,1)
      @ LIN,COL() SAY '*'
      WAIT TO Tw5
      TONE(900,1)
      @ LIN,COL() SAY '*'
      SET CONS ON
 A=180
 B=230
 SENHA = CHR(VAL(Tw1)+A++)+CHR(VAL(Tw2)+B++)+CHR(VAL(Tw3)+A++)+;
         CHR(VAL(Tw4)+B++)+CHR(VAL(Tw5)+A++)
         SELECT CONSEN
         IF RECLOCK(5)
            REPLACE CODSEN WITH SENHA
            REPLACE QUEM  WITH VQUEM
            COMMIT
            destrava()
         ELSE
            MENSAGEM("** Registro N„o Dispon¡vel p/ Altera‡o‰s **")
            INKEY(3)
            DO LMEN
            QUENTRAVA()
          ENDIF
 
         COR=SETCOLOR()
         DO LMEN
         SETCOLOR(mesafrente+"/"+mesafundo)
         CENTRAV(23,"Manutenc‡„o de Senha Realizada...")
         INKEY(4)
         SETCOLOR("&COR")
         RESTSCREEN(0,0,24,79,TELASENHA)
         close databases
         SET CURSOR OFF
         tela()
         RETURN
ELSE
 @ LIN+2,COL SAY "OPERADOR NAO CADASTRADO"
 INKEY(2)
 @ LIN+2,COL SAY SPACE(40)
 IF CONFIRMA("CADASTRA ESSE CODIGO DE OPERADOR ?") =1
    IF ADDREC(5)
       REPLACE CODOP WITH codigo
       REPLACE QUEM  WITH VQUEM
       COMMIT
       destrava()
    ELSE
       MENSAGEM("** Registro N„o Dispon¡vel p/ Incluso‰s **")
       INKEY(3)
       DO LMEN
       QUENTRAVA()
     ENDIF
    @ LIN+2,COL SAY "REDIGITE O C¢DIGO E INFORME A SENHA"
    INKEY(2)
    @ LIN+2,COL SAY SPACE(40)
    LOOP
 ENDIF
ENDIF
ENDDO
close databases
SET CURSOR OFF
RESTSCREEN(0,0,24,79,TELASENHA)
*************************************************
FUNCTION CONFIRMA(TEXTO)
local les,ces,largjan,telavelha
largjan=LEN(texto)+2
IF largjan<16
largjan=16
ENDIF
ces=(80-largjan)/2
les=19
telavelha=SAVESCREEN(les,0,les+4,79)
corantig=SETCOLOR()
cornova="W/B,N/W"
SET COLOR TO &CORNOVA
@les,ces CLEAR TO les+3,ces+largjan
@les,ces TO les+3,ces+largjan double
@les+1,ces+2 SAY texto
coluna=(largjan-9)/2
@les+2,ces+coluna PROMPT "Sim"
@les+2,ces+coluna+6 PROMPT "N„o"
MENU TO CONFIRM
SET COLOR TO &CORANTIG
RESTSCREEN(les,0,les+4,79,telavelha)
RETURN (CONFIRM )
***************************************
function editmemo()
local tela,vobs
save screen to tela
vobs :=obs
SOMBRA2(08,13,20,68)
QUADRO(08,13,20,68,7,"G/R","Observa‡o‰s",.T.)
do lmen
setcolor(MESAFRENTE+"/"+MESAFUNDO)
@ 23,01 say "Precione [CRTL+W] p/ gravar e abandonar!"
SETCOLOR("G/R")
vobs = memoedit(vobs,09,14,19,67,.T.)
IF RECLOCK(5)
   replace obs with vobs
   destrava()
ENDIF
setcolor("")
restore screen from tela
return
****************************************************************************
procedure esquerda
keyboard chr(13) + chr(5) + chr(13)
tec=0
return
****************************************************************************
procedure direita
keyboard chr(13) + chr(4) + chr(13)
tec=0
return
****************************************************************************
FUNCTION STRPIC
PARAMETERS  w_valor,w_tam,w_dec
DO CASE                 && VALIDACAO DE PARAMETROS
   CASE PCOUNT()=2
        w_dec = 0
   CASE PCOUNT()=1
        w_tam = INT(LEN(STR(INT(w_valor))) + (LEN(STR(INT(w_valor)))-1)/3)
        w_dec = 0
ENDCASE
IF w_valor < 0
   neg = .T.
   w_valor = 0 - w_valor
ELSE
   neg = .F.
ENDIF
xw_valor = LTRIM(str(int(w_valor)))
xw_dec   = SUBSTR( LTRIM(  STR((w_valor - int(w_valor)),18,w_dec) ),3,w_dec)
xlen   = LEN(  xw_valor )
result = space(0)
DO WHILE .T.
   IF ( xlen - 3 ) > 0
      result = "." + SUBSTR(xw_valor,xlen-3+1,3)  + result
      xlen = xlen - 3
   ELSE
      result = SUBSTR(xw_valor,1,xlen) + result
      EXIT
   ENDIF
ENDDO
SET COLOR TO
IF w_dec > 0          &&  decimais
   result = result + "," + xw_dec
ENDIF
IF neg                && negative number
   result = "-" + result
ENDIF
IF w_tam - LEN(result) >= 0        && alinhado a direita
   RETURN SPACE( w_tam-LEN(result) ) + result
ELSE
   RETURN replicate ("*",w_tam)    && insuficiente space
ENDIF
**************************************
PROCEDURE CONFIRME
PARAMETERS oque
SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
DO mensagem WITH "Confirma "+RTRIM(oque)+" (S/N) ?"
PUBLIC confirme
confirme = " "
@ 23,COL()+2 GET confirme PICT "!" VALID(confirme$"SN")
READ
DO lmen
IF confirme = "S"
  SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
  DO mensagem1 WITH "Confirmado !"
ELSE
  SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
  DO mensagem1 WITH "N„o Confirmado !"
ENDIF
RETURN
*************************************
FUNCTION ADDREC(SEGUNDOS)
LOCAL PSEMPRE
      APPEND BLANK
      IF .NOT. NETERR()
         RETURN (.T.)
      ENDIF
PSEMPRE = (SEGUNDOS = 0)
DO WHILE (PSEMPRE .OR. SEGUNDOS > 0)
   APPEND BLANK
   IF .NOT. NETERR()
      RETURN (.T.)
   ENDIF
   INKEY(0.5)
   SEGUNDOS = SEGUNDOS - 0.5
ENDDO
RETURN (.F.)
*************************************
FUNCTION QUENTRAVA()
IF ASSINATURA <> "   "
   MENSAGEM("O usu rio " +ASSINATURA+ " travou o registro")
   RETURN
ENDIF
ARQUIVO := DBF()
SELECT SEMAFARO
SEEK ARQUIVO
IF ASSINATURA <> "   "
   MENSAGEM("O usu rio " +ASSINATURA+" travou o arqu¡vo")
   SELECT (ARQUIVO)
   RETURN
ENDIF
SELECT (ARQUIVO)
RETURN
*************************************
FUNCTION NETUSE(ARQUIVO,MODO,SEGUNDOS)
LOCAL PSEMPRE
PSEMPRE = (PSEMPRE = 0)
DO WHILE (PSEMPRE .OR. SEGUNDOS > 0)
   IF MODO
      USE (ARQUIVO) EXCLUSIVE
   ELSE
      USE (ARQUIVO) SHARED
   ENDIF
   IF .NOT. NETERR()
      RETURN (.T.)
   ENDIF
   SEGUNDOS = SEGUNDOS - 1
ENDDO
RETURN (.F.)
***********  FUNCTION BIIP
FUNCTION BIIP
TONE (1283,1)
RETURN ''
*************************************
FUNCTION RECLOCK (SEGUNDOS)
LOCAL PSEMPRE
    IF RLOCK()
       REPLACE ASSINATURA WITH IDENTIFICA
       COMMIT
       RETURN (.T.)
    ENDIF
PSEMPRE = (SEGUNDOS = 0)
DO WHILE (PSEMPRE .OR. SEGUNDOS > 0)
   IF RLOCK()
      REPLACE ASSINATURA WITH IDENTIFICA
      COMMIT
      RETURN (.T.)
   ENDIF
   INKEY(0.5)
   SEGUNDOS = SEGUNDOS - 0.5
ENDDO
RETURN (.F.)
*************************************
FUNCTION DESTRAVA
IF ASSINATURA = IDENTIFICA
   REPLACE ASSINATURA WITH "   "
   UNLOCK
   RETURN
ENDIF
ARQUIVO := DBF()
SELECT SEMAFARO
SEEK ARQUIVO
IF ASSINATURA = IDENTIFICA
   REPLACE ASSINATURA WITH "   "
ENDIF
SELECT (ARQUIVO)
UNLOCK
RETURN
*************************************
FUNCTION FILOCK(SEGUNDOS)
LOCAL PSENPRE, ARQUIVO
ARQUIVO := DBF()
IF FLOCK()
   SELECT SEMAFARO
   SEEK ARQUIVO
   IF RECLOCK(4)
      REPLACE ASSINATURA WITH IDENTIFICA
   ENDIF
   SELECT (ARQUIVO)
   RETURN (.T.)
ENDIF
PSEMPRE := (SEGUNDOS = 0 )
DO WHILE (PSEMPRE .OR. SEGUNDOS > 0)
   INKEY (.5)
   SEGUNDOS = SEGUNDOS - 0.5
   IF FLOCK()
      SELECT SEMAFARO
      SEEK ARQUIVO
      IF RECLOCK(4)
         REPLACE ASSINATURA WITH IDENTIFICA
      ENDIF
      SELECT (ARQUIVO)
      RETURN (.T.)
   ENDIF
ENDDO
RETURN (.F.)
****************************************
PROCEDURE retorno
DO mensagem WITH "Retorna Arquivo Baixado. (S/N) ?"
PUBLIC ex
ex = " "
@ 23,COL()+2 GET ex PICT "!" VALID(ex$"SN")
READ
DO lmen
IF ex = "S"
  SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
  DO mensagem1 WITH "Retornado !"
ELSE
  SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
  DO mensagem1 WITH "N„o Retornado !"
ENDIF
RETURN
*************************
PROCEDURE apaga
*************************
SOMBRA2(05,04,08,75)
QUADRO(05,04,08,75,7,menufrente+"/"+menufundo,"Transferencia",.T.)
SETCOLOR(menufrente+"/"+menufundo)
@ 06,05 SAY "          Quantidade de dias p/ transferencia dos arquivos.           "
SOMBRA2(10,04,21,75)
QUADRO(10,04,21,75,7,menufrente+"/"+menufundo,,.T.)
SETCOLOR(menufrente+"/"+menufundo)
@ 14,05 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
@ 11,07 SAY "Os Arquivos baixados com data inferior a    dia(s) da data de hoje"
@ 13,06 SAY "ser„o transferidos definitivamente todos os arquivos p/arquivo morto"
@ 15,06 SAY "           transferencia  de arquivos com data inferior a           "
@ 19,06 SAY "               Foram transferidos      Arquivos da movimentacao.    "
@ 20,06 SAY "               Foram transferidos      Arquivos da Creditacao.      "
SETCOLOR("")
RETURN
****************************************
PROCEDURE baixa
DO mensagem WITH "Baixa Arquivo (S/N) ?"
PUBLIC ex
ex = " "
@ 23,COL()+2 GET ex PICT "!" VALID(ex$"SN")
READ
DO lmen
IF ex = "S"
  SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
  DO mensagem1 WITH "baixado  !"
ELSE
  SETCOLOR(MESAFRENTE+"/"+MESAFUNDO)
  DO mensagem1 WITH "N„o Baixado  !"
ENDIF
RETURN
*************************************************************************
PROCEDURE EXTENDA
PARAMETERS mant
camt =""
WORD1=""
WORD2=""
WORD3=""
STORE "     UM    DOIS  TRES  QUATROCINCO SEIS  SETE  OITO  NOVE  ";
                                      TO uns
STORE "DEZ      ONZE     DOZE     TREZE    QUATORZE QUINZE   "+;
      "DEZESSEISDEZESSETEDEZOITO  DEZENOVE " TO undez
STORE "VINTE    TRINTA   QUARENTA CINQUENTASESSENTA SETENTA  "+;
      "OITENTA  NOVENTA  " TO dezena
STORE "CENTO       DUZENTOS    TREZENTOS   QUATROCENTOSQUINHENTOS  " +;
      "SEISCENTOS  SETECENTOS  OITOCENTOS  NOVECENTOS  " to centenas
 cnum = SUBSTR (STR(mant,12,2),1,9)
IF SUBSTR (cnum,1,3) > '   ' .AND. SUBSTR (cnum,1,3) <= '999'
   IF SUBSTR (cnum,1,3) > "100"
      camt=camt + RTRIM(SUBSTR(centenas,VAL(SUBSTR(cnum,1,1))*12-11,12))
   ELSE
      IF SUBSTR (cnum,1,3)="100"
         camt= camt + "CEM"
      ENDIF
   ENDIF
   DO CASE
      CASE SUBSTR(cnum,2,1)>"1"
           IF SUBSTR (cnum,1,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt+ RTRIM(SUBSTR(dezena,VAL(SUBSTR(cnum,2,1))*9-17,9))
           IF SUBSTR(cnum,3,1)>"0"
              camt=camt+ " E " + RTRIM(SUBSTR(uns,VAL(SUBSTR(cnum,3,1))*6,6))
           ENDIF
           camt=camt+" MILHOES"
      CASE SUBSTR(cnum,2,1)="1"
           IF SUBSTR (cnum,1,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt+  RTRIM(SUBSTR(undez,VAL(SUBSTR(cnum,3,1))*9+1,9)) +;
           " MILHOES"
      CASE SUBSTR(cnum,2,2)="00"
           camt=camt+" MILHOES"
      CASE SUBSTR(cnum,3,1)>" "
           IF SUBSTR (cnum,1,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt+  RTRIM(SUBSTR(uns,VAL(SUBSTR(cnum,3,1))*6,6))
           IF SUBSTR (cnum,3,1) = "1"
              camt = camt + " MILHAO"
           ELSE
              camt = camt + " MILHOES"
           ENDIF
   ENDCASE
   IF SUBSTR (cnum,4,6) > "000000"
      IF SUBSTR (cnum,7,3) = "000" .AND. ;
         SUBSTR (STR (MANT,12,2),11,2) = "00"
         camt = camt + ' E '
      ELSE
         camt = camt + ", "
      ENDIF
   ELSE
      camt = camt + ' DE REAIS'
   ENDIF
ENDIF
IF SUBSTR (cnum,4,3) >= "  1" .AND. SUBSTR (cnum,4,3) <> "000"
   IF SUBSTR (cnum,4,3) > "100"
      camt=camt + RTRIM(SUBSTR(centenas,VAL(SUBSTR(cnum,4,1))*12-11,12))
   ELSE
      IF SUBSTR (cnum,4,3)="100"
         camt= camt + "CEM"
      ENDIF
   ENDIF
   DO CASE
      CASE SUBSTR(cnum,5,1)>"1"
           IF SUBSTR (cnum,4,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt+ RTRIM(SUBSTR(dezena,VAL(SUBSTR(cnum,5,1))*9-17,9))
           IF SUBSTR(cnum,6,1)>"0"
              camt=camt+" E "+RTRIM(SUBSTR(uns,VAL(SUBSTR(cnum,6,1))*6,6))
           ENDIF
           camt=camt+" MIL"
      CASE SUBSTR(cnum,5,1)="1"
           IF SUBSTR (cnum,4,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt+RTRIM(SUBSTR(undez,VAL(SUBSTR(cnum,6,1))*9+1,9))+" MIL"
      CASE SUBSTR(cnum,5,2)="00"
           camt=camt+" MIL"
      CASE SUBSTR(cnum,6,1)>" "
           IF SUBSTR (cnum,4,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt+RTRIM(SUBSTR(uns,VAL(SUBSTR(cnum,6,1))*6,6))+" MIL"
   ENDCASE
   IF SUBSTR (cnum,7,3) > "000"
      camt = camt + ", "
   ELSE
      camt = camt + " REAIS"
   ENDIF
ENDIF
IF SUBSTR (cnum,7,3) >= "  1" .AND. SUBSTR (cnum,7,3) <> "000"
   IF SUBSTR (cnum,7,3) > "100"
      camt=camt + RTRIM(SUBSTR(centenas,VAL(SUBSTR (cnum,7,1))*12-11,12))
   ELSE
      IF SUBSTR (cnum,7,3)="100"
         camt=camt + "CEM"
      ENDIF
   ENDIF
   DO CASE
      CASE SUBSTR(cnum,8,1)>"1"
           IF SUBSTR (cnum,7,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt+ RTRIM(SUBSTR(dezena,VAL(SUBSTR(cnum,8,1))*9-17,9))
           IF SUBSTR(cnum,9,1)>"0"
              camt=camt+" E "+RTRIM(SUBSTR(uns,VAL(SUBSTR(cnum,9,1))*6,6))
           ENDIF
           camt=camt+" REAIS"
      CASE SUBSTR(cnum,8,1)="1"
           IF SUBSTR (cnum,7,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt + RTRIM(SUBSTR(undez,VAL(SUBSTR(cnum,9,1))*9+1,9))+;
           " REAIS"
      CASE SUBSTR(cnum,8,2)="00"
           camt=camt+" REAIS"
      CASE SUBSTR(cnum,9,1)>" "
           IF SUBSTR (cnum,7,1) >= "1"
              camt = camt + " E "
           ENDIF
           camt=camt + RTRIM(SUBSTR(uns,VAL(SUBSTR(cnum,9,1))*6,6))+;
           " REAIS"
   ENDCASE
ENDIF
cents=SUBSTR (STR(mant,12,2),11,2)
IF cents >= "01"
   camt = camt + " E "
   DO CASE
      CASE SUBSTR(cents,1,1)>"1"
           camt=camt+ RTRIM(SUBSTR(dezena,VAL(SUBSTR(cents,1,1))*9-17,9))
           IF SUBSTR(cents,2,1)>"0"
              camt=camt+" E "+RTRIM(SUBSTR(uns,VAL(SUBSTR(cents,2,1))*6,6))
           ENDIF
           camt=camt+" CENTAVOS"
      CASE SUBSTR(cents,1,1)="1"
           camt=camt + RTRIM(SUBSTR(undez,VAL(SUBSTR(cents,2,1))*9+1,9))+;
           " CENTAVOS"
      CASE SUBSTR(cents,1,2)="00"
           camt=camt+" CENTAVOS"
      CASE SUBSTR(cents,2,1)>" "
           camt=camt + RTRIM(SUBSTR(uns,VAL(SUBSTR(cents,2,1))*6,6))
           IF SUBSTR (cents,2,1) <> "1"
              camt = camt + " CENTAVOS"
           ELSE
              camt = camt + " CENTAVO"
           ENDIF
   ENDCASE
ENDIF
camt=camt + ". "
length = LEN(camt)
IF LENGTH > 170
   word1 = ' '
   word2 = ' '
   word3 = ' '
   return
ENDIF
IF length > 57
   counter = 57
   DO WHILE .NOT. SUBSTR(camt,counter,1) $ " "
      counter = counter - 1
   ENDDO
   word1 = SUBSTR(camt, 1, counter) +  REPLIC("-",57-counter)
   word2 = SUBSTR(camt,counter+1,length-counter)
   len2 = LEN (word2)
   IF len2 <= 57        && nao e preciso subdividir word2
      word2 = word2 + REPLIC("*",57-len2)
      word3 = " "
   ELSE
      counter = 57
      DO WHILE .NOT. SUBSTR(word2,counter,1) $ " "
         counter = counter - 1
      ENDDO
      word3 = SUBSTR(word2,counter+1,len2-counter)
      len3  = LEN (word3)
      word3 = word3 + REPLIC("*",57-len3)
      word2 = SUBSTR(word2,1,counter)+ REPLIC("-",57-counter)
   ENDIF
ELSE
   word1 = camt + REPLIC("*",57-length)
   word2 =        REPLIC("*",57)
   word3 =        " "
ENDIF
RETURN
FUNCTION EXTDATA
PARAMETERS VDATA
*  VMES = MONTH(VDATA)
*  VANO = YEAR(VDATA)
*  VDIA = DAY(VDATA)
MESES = "JANEIRO  FEVEREIROMARCO    ABRIL    MAIO     JUNHO  "     + ;
        "  JULHO    AGOSTO   SETEMBRO OUTUBRO  NOVEMBRO DEZEMBRO"
RETURN  STR(  DAY(VDATA),2  ) + SPACE(5) + ;
        SUBSTR(  MESES, MONTH(VDATA)*9 -8,9) + SPACE(6) +;
        SUBSTR(  STR(  YEAR(VDATA),4 ),3,2  )
**************************************
FUNCTION INIMES
PARAMETERS DATA1
RETURN (DATA1 - DAY(DATA1) + 1)
*********************
PROCEDURE TELACONSbanco
*********************
 
@ 01,00 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 02,00 SAY "³                                                                              ³"
@ 03,00 SAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 04,00 SAY "³"+space(66)+"            ³"
@ 05,00 SAY "ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
FOR h = 6 TO 22
  @ h,00 SAY "³"+space(66)+"            ³"
NEXT
@ 23,00 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
SET COLOR TO +W/BG
@ 04,01 SAY 'NUMERO              VALOR  NOME                            EMISSAO   VENC.    '
RETURN
*****************************
FUNCTION MYALERT(cMsg,aOpcoes,cColor,nLin,nCol)
LOCAL aMsg := {},nLinT := nColE := nLinB := nColD := i := nTamMax := x := 0
LOCAL nOpcao := 0,cTlAlert := "",cCorAnt := ""
 
* --- Trata os parametros passados...
IF cColor = NIL                        // Se nao passou cor assumo...
   cColor = "W+/R,N/W"
ENDIF
 
* --- Trata o array de opcoes
aOpcoes := IF(aOpcoes = NIL,{"Ok"},aOpcoes)
 
* --- Separa a string em ocorrencias do array
aMsg := xDELIMIT(cMsg)
 
* --- Calcula a MAIOR opcao do array
AEVAL(aOpcoes,{|cOpc| i += 2+LEN(ALLTRIM(cOpc))})
 
* --- Calculo mais um espaco entre as Opcoes
i += LEN(aOpcoes)-1
 
* --- Calcula a MAIOR mensagem no array
AEVAL(aMsg,{|cStr| nTamMax := MAX(LEN(ALLTRIM(cStr)),nTamMax)})
 
* --- Determina o MAIOR dos dois arrays (aMsg,aOpcoes)
nTamMax := MAX(nTamMax,i)+2
 
* --- Calcula as coordenadas do BOX
nLinT := IF(nLin=NIL,12-((LEN(aMsg)+3)/2),nLin)          // Linha do Topo
nColE := IF(nCol=NIL,40-((nTamMax+1)/2),nCol)            // Coluna Esquerda
nLinb := nLinT + LEN(aMsg)+3                             // Linha aBaixo
nColD := nColE + nTamMax + 1                             // Coluna Direita
 
* --- Salva a tela
cTlAlert = SAVESCREEN(nLinT,nColE,nLinB+1,nColD+2)
 
* --- Desenho o Box
JANELA(nLinT,nColE,nLinB,nColD," Aten‡„o ","",cColor)
 
* --- Mostra a mensagem centralizada no BOX
x := nLinT + 1
AEVAL(aMsg,{|cStr| DEVPOS(x++,CENTER_TXTBOX(nColE,nColD,LEN(cStr))),DEVOUT(cStr,cColor)})
 
* --- Calcula a Coluna da primeira opcao
i := CENTER_TXTBOX(nColE,nColD,i)
 
* --- Seta cor e salva anterior
cCorAnt := SETCOLOR(cColor)
 
* --- Monta as Opcoes
AEVAL(aOpcoes,{|cOpcao| __ATPROMPT(nLinB-1,i," "+cOpcao+" "), i+=LEN(cOpcao)+3})
 
* --- Chama MENU TO...
MENU TO nOpcao
 
* --- Restaura a area utilizada
RESTSCREEN(nLinT,nColE,nLinB+1,nColD+2,cTlAlert)
 
* --- Restaura a cor anterior
SETCOLOR(cCorAnt)
 
* --- Retorna a Opcao escolhida
RETURN(nOpcao)
*******************************
FUNCTION xDELIMIT(cString,cDelimit)
LOCAL x,a := {}
cDelimit := IF(cDelimit=NIL,";",cDelimit)
WHILE (x := AT(cDelimit,cString)) # 0
      AADD(a,SUBS(cString,1,x-1))
      cString := SUBS(cString,x+LEN(cDelimit))
END
AADD(a,SUBS(cString,x+LEN(cDelimit)))
RETURN (a)
*****************************
FUNCTION center_txtbox(col_ini,col_fin,tam_txt)
RETURN((INT((col_fin - col_ini + 1)/2) - INT(tam_txt/2))+col_ini)
*****************************
FUNCTION JANELA(nLin1,nCol1,nLin2,nCol2,cTit,cRod,cCor,lShad)
IF cTit==NIL
   cTit:=""
ENDIF
IF cRod==NIL
   cRod:=""
ENDIF
IF lShad==NIL
   lShad:=.T.
ENDIF
cTit:=ALLTRIM(cTit)
cRod:=ALLTRIM(cRod)
@ nLin1,nCol1,nLin2,nCol2 BOX "         " COLOR cCor
DISPBOX( nLin1, nCol1, nLin2, nCol2, 2, cCor)
IF ! EMPTY(cTit)
   @ nLin1,nCol1+((nCol2-nCol1-LEN(cTit))/2) SAY " "+cTit+" " COLOR cCor
ENDIF
IF ! EMPTY(cRod)
   @ nLin2,nCol1+((nCol2-nCol1-LEN(cRod))/2)+1 SAY cRod Color cCor
ENDIF
IF lShad
   *c_chcolor(nLin1,nCol1,nLin2,nCol2)
   @ nLin1,nCol1 to nLin2,nCol2 color cCor
ENDIF
return nil
******************************
FUNCTION MOLDURA(nLIN1,nCOL1,nLIN2,nCOL2,nTEXTO,DUPLO,ALTO)
IF PCOUNT()<7
   RETURN (NIL)
ENDIF
IF DUPLO=NIL
   DUPLO=.F.
ENDIF
IF ALTO=NIL
   ALTO=.F.
ENDIF
IF DUPLO
   @nLIN1,nCOL1 CLEAR TO nLIN2,nCOL2
   @nLIN1,nCOL1 TO nLIN2,nCOL2 DOUBLE
ELSE
   @nLIN1,nCOL1 CLEAR TO nLIN2,nCOL2
   @nLIN1,nCOL1 TO nLIN2,nCOL2
ENDIF
TAM=nCOL2-nCOL1
NOVAPOS=(TAM-LEN(nTEXTO))/2
IF ALTO
   @nLIN1,nCOL1+NOVAPOS SAY nTEXTO
ELSE
   @nLIN2,nCOL1+NOVAPOS SAY nTEXTO
ENDIF
RETURN (NIL)
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ FUNCTION CONS_PLU                                                     ³
³ =================                                                     ³
³                                                                       ³
³ Objetivo  : Consulta da PLU                                           ³
³ Parametros: Nil (Void)                                                ³
³                                                                       ³
³ Retorna...: Nil (Void)                                                ³
³                                                                       ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
 
FUNCTION CONS_PLU
LOCAL CAMPOS[11],CABEC[11],TITULO,CHAVE[11],ORDEM
LOCAL bConsAnt := SETKEY(K_F4, NIL)
 
CCORPADRAO= TELAFRENTE+"/"+TELAFUNDO
select 1
if netuse("pdv_plu",.f.,10)
   set index to pdv_plu,prod_b,prod_c,plu_dsc,prod_e
else
DO Mensagem WITH "O arqu¡vo de produto n„o se encontra dispon¡vel !"
   inkey(0)
   restore screen from produto
   set inte on
   return
endif
 
CAMPOS[ 1] = "COD_ITEM"
CAMPOS[ 2] = "DSC_ITEM"
CAMPOS[ 3] = "UND_ITEM"
CAMPOS[ 4] = "PRC_ITEM"
CAMPOS[ 5] = "PRC_PROM"
CAMPOS[ 6] = "DTF_PROM"
CAMPOS[ 7] = "SIT_TRIB"
CAMPOS[ 8] = "IND_ICMS"
CAMPOS[ 9] = "PCT_COMI"
CAMPOS[10] = "PCT_DESC"
CAMPOS[11] = "STAT_ITEM"
 
CABEC[ 1] = "CODIGO"
CABEC[ 2] = "DESCRICAO DO ITEM"
CABEC[ 3] = "UND"
CABEC[ 4] = "PRECO A VISTA"
CABEC[ 5] = "PRECO PROMOCAO"
CABEC[ 6] = "FIM PROMOCAO"
CABEC[ 7] = "SIT. TRIB"
CABEC[ 8] = "IND. ICMS"
CABEC[ 9] = "% COMISSAO"
CABEC[10] = "% DESCTO"
CABEC[11] = "STATUS"
 
TITULO = "PRODUTOS"
 
CHAVE[1] = "CODIGO DO PRODUTO"
CHAVE[2] = "DESCRICAO"
 
DBMAT_EDIT(CAMPOS,CABEC,TITULO,CHAVE)
 
SELECT PDV_PLU
SETKEY(K_F4, bConsAnt)
 
RETURN
 
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ FUNCTION DBMAT_EDIT                                                   ³
³ ===================                                                   ³
³                                                                       ³
³ Objetivo  : Consulta da PLU                                           ³
³ Parametros: CAMPOS                                                    ³
³             CABEC                                                     ³
³             TITULO                                                    ³
³             CHAVE                                                     ³
³                                                                       ³
³ Retorna...: Nil (Void)                                                ³
³                                                                       ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
 
FUNCTION DBMAT_EDIT(CAMPOS,CABEC,TITULO,CHAVE)
LOCAL aGetList :={},cTelaEdt := SAVESCREEN(0,0,24,79)
 
PRIVATE RETORNO:=""
PRIVATE L1,C1,L2,C2,CONTINUA,MENSAGEM,nRecNo
PRIVATE WNOME_PROC,COR_ANT,lFlgAcess := .F.
 
IF GETACTIVE() != NIL
   aGetList := GetList
ENDIF
 
GetList := {}
 
GOTO TOP
COR_ANT = SETCOLOR(cCORPADRAO)
 
L1 =  0
C1 =  0
L2 = 24
C2 = 79
CONTINUA = .T.
DO WHILE CONTINUA
   TITULO1 = TITULO
   IF .NOT. EMPTY(CHAVE[1])
      TITULO1 = TITULO1 + " CLASSIFICADOS POR DESCRI€Ž E CODIGO"
   ENDIF
 
   JANELA(L1,C1,L2,C2,TITULO1,,,.F.)
 
   @ 21, 0 SAY "Ì" + REPLICATE("Í",78) + "¹" COLOR cCORPADRAO
   @ 22, 1 SAY " FUNCOES: Pesquisa  : C-por Codigo D-por Descri‡„o | TAB-Ordem ENTER-fim"
   @ 23, 1 SAY "          Manuten‡„o: INS-Inclus„o A-Altera‡„o DEL-Exclus„o | ESC-Aborta"
 
   DBEDIT(L1+1,C1+1,L2-3,C2-1,CAMPOS,"MTCONTR_EDIT","",CABEC,"ÍÑÍ"," ³ ","ÍÏÍ")
 
ENDDO
RESTSCREEN(0,0,24,79,cTelaEdt)
SETCOLOR(COR_ANT)
 
IF READVAR() = "CCODITM" .AND. ! EMPTY(RETORNO)
   cCodItm = RETORNO
ENDIF
 
IF LEN(aGetList) > 0
   GetList := aGetList
ENDIF
 
RETURN
 
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ FUNCTION MTCONTR_EDIT                                                 ³
³ =====================                                                 ³
³                                                                       ³
³ Objetivo  : Controla a Consulta de PLU                                ³
³ Parametros: MODO                                                      ³
³             ELEMENTO                                                  ³
³                                                                       ³
³ Retorna...: Controle para DBEDIT()                                    ³
³                                                                       ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
 
FUNCTION MTCONTR_EDIT(MODO,ELEMENTO)
LOCAL cTlEdt := SAVESCREEN(0,0,24,79)
LOCAL cCOD_ITEM  := SPACE(13),;
      cDSC_ITEM  := SPACE(40),;
      cUND_ITEM  := SPACE(03),;
      nPRC_ITEM  := 0.00,;
      nPRC_PROM  := 0.00,;
      dDTF_PROM  := CTOD(""),;
      cSIT_TRIB  := "T",;
      cIND_ICMS  := "01",;
      nPCT_COMI  := 0.00,;
      nPCT_DESC  := 0.00,;
      cSTAT_ITEM := "1",;
      lInclusao  := .T.
 
PRIVATE EDICAO,XTEMP,X,Y
PUBLIC L1,C1,L2,C2,CONTINUA,MENSAGEM
 
DO CASE
   CASE MODO < 4          //  Nenhuma Pendencia
        RETURN 1
 
   CASE MODO = 0          //  Nenhuma Pendencia
        RETURN 1          //  Continua Normalmente
 
   CASE MODO = 1          //  Top of File
        RETURN 1          //  Continua Normalmente
 
   CASE MODO = 2 .OR. MODO = 3    //  end of file / file empty
        RETURN 1          //  Continua Normalmente
 
   CASE MODO = 4          // Foi Pressionada Tecla de Excessao
        DO CASE
           CASE LASTKEY() = K_ESC     //     ESC  (sair da edicao)
                CONTINUA = .F.
                GETLIST := {}
                RETURN 0             //     finaliza edicao
 
           CASE LASTKEY() = K_ENTER   //     ENTER  (sair da edicao, devolvendo o codigo)
                *RETORNO = PLU->COD_ITEM
                keyb PDV_PLU->COD_ITEM+chr(13)
                CONTINUA = .F.
                RETURN 0                //     finaliza edicao
 
           CASE UPPER(CHR(LASTKEY())) = "C"    // pesquisa por codigo
                XTEMP = SPACE(13)
                @ 23, 01 SAY SPACE(78)
                @ 23, 10 SAY "Indique o codigo a ser pesquisado:" GET XTEMP PICT "@K "+REPLI("9",13) ;
                         VALID IF(!EMPTY(xtemp),EVAL({|| xtemp := STRZERO(VAL(xtemp),13),.T.}),.T.)
                READ
                SET ORDER TO 1 // codigo
                SET SOFTSEEK ON
                SEEK XTEMP
                SET SOFTSEEK OFF
                RESTSCREEN(0,0,24,79,cTlEdt)
 
                CONTINUA = .T.
                RETURN 0       //  fim da edicao
 
           CASE UPPER(CHR(LASTKEY())) = "D"    // descricao
                XTEMP = SPACE(40)
                @ 23, 01 SAY SPACE(78)
                @ 23, 10 SAY "Indique a descricao:" GET XTEMP PICT "@!KX"
                READ
                SET ORDER TO 4 // descricao
                SET SOFTSEEK ON
                SEEK ALLTRIM(XTEMP)
                SET SOFTSEEK OFF
                RESTSCREEN(0,0,24,79,cTlEdt)
 
                CONTINUA = .T.
                RETURN 0       //  fim da edicao
 
           OTHERWISE
              RETURN 1            //  continua normalmente
 
        ENDCASE
ENDCASE
CONTINUA = .F.
RETURN 0
 
 
FUNCTION cotacao
 save screen to imp
 do lmen
 setcolor(mesafrente+"/"+mesafundo)
 centrav(23,'Aguarde! Imprimindo dados solicitados.')
 setcolor("")
 set device to print
 set print on
 ?? chr(27)+chr(77)+chr(15)
 set print off
 store 0 to li
 store 0 to total1
 store 0 to total2
 store 0 to total3
 store 0 to total4
 SELECT COTACAO
 SET ORDER TO 2
 GO TOP
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab01
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if a # 0
          aa = a + (a * porce01 / 100)
       else
          aa = a
       endif
       if b # 0
          vb = b         + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c         + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d         + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e         + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f         + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g         + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h         + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i         + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j         + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k         + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l         + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m         + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n         + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o         + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p         + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q         + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r         + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s         + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t         + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if aa <= vb .and. aa <= vc .and. aa <= vd .and. aa <= ve .and.;
          aa <= vf .and. aa <= vg .and. aa <= vh .and. aa <= vi .and.;
          aa <= vj .and. aa <= vk .and. aa <= vl .and. aa <= vm .and.;
          aa <= vn .and. aa <= vo .and. aa <= vp .and. aa <= vq .and.;
          aa <= vr .and. aa <= vs .and. aa <= vt .and. aa <> 0
          total1 = quant * aa
          total2 = total2 + total1
          total3 = total3 + total1
          soma01 = total1
          @ li,00 say produto+' '+strpic(aa,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          li = li + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab02
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if b # 0
          bb = b + (b * porce02 / 100)
       else
          bb = b
       endif
       if a # 0
          va = a        + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if c # 0
          vc = c        + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d        + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e        + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f        + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g        + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h        + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i        + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j        + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k        + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l        + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m        + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n        + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o        + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p        + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q        + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r        + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s        + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t        + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if bb <= va .and. bb <= vc .and. bb <= vd .and. bb <= ve .and.;
          bb <= vf .and. bb <= vg .and. bb <= vh .and. bb <= vi .and.;
          bb <= vj .and. bb <= vk .and. bb <= vl .and. bb <= vm .and.;
          bb <= vn .and. bb <= vo .and. bb <= vp .and. bb <= vq .and.;
          bb <= vr .and. bb <= vs .and. bb <= vt .and. bb <> 0
          total1 = quant * bb
          total2 = total2 + total1
          total3 = total3 + total1
          soma02 = total1
          @ li,00 say produto+' '+strpic(bb,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab03
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if c # 0
          cc = c + (c * porce03 / 100)
       else
          cc = c
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if cc <= va .and. cc <= vb .and. cc <= vd .and. cc <= ve .and.;
          cc <= vf .and. cc <= vg .and. cc <= vh .and. cc <= vi .and.;
          cc <= vj .and. cc <= vk .and. cc <= vl .and. cc <= vm .and.;
          cc <= vn .and. cc <= vo .and. cc <= vp .and. cc <= vq .and.;
          cc <= vr .and. cc <= vs .and. cc <= vt .and. cc <> 0
          total1 = quant * cc
          total2 = total2 + total1
          total3 = total3 + total1
          soma03 = total1
          @ li,00 say produto+' '+strpic(cc,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab04
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if d # 0
          dd = d + (d * porce04 / 100)
       else
          dd = d
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if dd <= va .and. dd <= vb .and. dd <= vc .and. dd <= ve .and.;
          dd <= vf .and. dd <= vg .and. dd <= vh .and. dd <= vi .and.;
          dd <= vj .and. dd <= vk .and. dd <= vl .and. dd <= vm .and.;
          dd <= vn .and. dd <= vo .and. dd <= vp .and. dd <= vq .and.;
          dd <= vr .and. dd <= vs .and. dd <= vt .and. dd <> 0
          total1 = quant * dd
          total2 = total2 + total1
          total3 = total3 + total1
          soma04 = total1
          @ li,00 say produto+' '+strpic(dd,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab05
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if e # 0
          ee = e + (e * porce05 / 100)
       else
          ee = e
       endif
       if a # 0
          va = a        + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b        + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c        + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d        + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if f # 0
          vf = f        + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g        + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h        + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i        + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j        + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k        + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l        + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m        + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n        + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o        + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p        + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q        + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r        + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s        + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t        + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if ee <= va .and. ee <= vb .and. ee <= vc .and. ee <= vd .and.;
          ee <= vf .and. ee <= vg .and. ee <= vh .and. ee <= vi .and.;
          ee <= vj .and. ee <= vk .and. ee <= vl .and. ee <= vm .and.;
          ee <= vn .and. ee <= vo .and. ee <= vp .and. ee <= vq .and.;
          ee <= vr .and. ee <= vs .and. ee <= vt .and. ee <> 0
          total1 = quant * ee
          total2 = total2 + total1
          total3 = total3 + total1
          soma05 = total1
          @ li,00 say produto+' '+strpic(ee,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab06
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if f # 0
          ff = f + (f * porce06 / 100)
       else
          ff = f
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if ff <= va .and. ff <= vb .and. ff <= vc .and. ff <= vd .and.;
          ff <= ve .and. ff <= vg .and. ff <= vh .and. ff <= vi .and.;
          ff <= vj .and. ff <= vk .and. ff <= vl .and. ff <= vm .and.;
          ff <= vn .and. ff <= vo .and. ff <= vp .and. ff <= vq .and.;
          ff <= vr .and. ff <= vs .and. ff <= vt .and. ff <> 0
          total1 = quant * ff
          total2 = total2 + total1
          total3 = total3 + total1
          soma06 = total1
          @ li,00 say produto+' '+strpic(ff,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab07
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if g # 0
          gg = g + (g * porce07 / 100)
       else
          gg = g
       endif
       if a # 0
          va = a        + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b        + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c        + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d        + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e        + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f        + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if h # 0
          vh = h        + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i        + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j        + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k        + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l        + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m        + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n        + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o        + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p        + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q        + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r        + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s        + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t        + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if gg <= va .and. gg <= vb .and. gg <= vc .and. gg <= vd .and.;
          gg <= ve .and. gg <= vf .and. gg <= vh .and. gg <= vi .and.;
          gg <= vj .and. gg <= vk .and. gg <= vl .and. gg <= vm .and.;
          gg <= vn .and. gg <= vo .and. gg <= vp .and. gg <= vq .and.;
          gg <= vr .and. gg <= vs .and. gg <= vt .and. gg <> 0
          total1 = quant * gg
          total2 = total2 + total1
          total3 = total3 + total1
          soma07 = total1
          @ li,00 say produto+' '+strpic(gg,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab08
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if h # 0
          hh = h + (h * porce08 / 100)
       else
          hh = h
       endif
       if a # 0
          va = a        + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b        + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c        + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d        + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e        + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f        + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g        + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if i # 0
          vi = i        + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j        + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k        + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l        + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m        + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n        + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o        + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p        + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q        + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r        + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s        + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t        + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if hh <= va .and. hh <= vb .and. hh <= vc .and. hh <= vd .and.;
          hh <= ve .and. hh <= vf .and. hh <= vg .and. hh <= vi .and.;
          hh <= vj .and. hh <= vk .and. hh <= vl .and. hh <= vm .and.;
          hh <= vn .and. hh <= vo .and. hh <= vp .and. hh <= vq .and.;
          hh <= vr .and. hh <= vs .and. hh <= vt .and. hh <> 0
          total1 = quant * hh
          total2 = total2 + total1
          total3 = total3 + total1
          soma08 = total1
          @ li,00 say produto+' '+strpic(hh,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab09
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if i # 0
          ii = i + (i * porce09 / 100)
       else
          ii = i
       endif
       if a # 0
          va = a        + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b        + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c        + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d        + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e        + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f        + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g        + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h        + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if j # 0
          vj = j        + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k        + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l        + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m        + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n        + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o        + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p        + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q        + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r        + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s        + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t        + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if ii <= va .and. ii <= vb .and. ii <= vc .and. ii <= vd .and.;
          ii <= ve .and. ii <= vf .and. ii <= vg .and. ii <= vh .and.;
          ii <= vj .and. ii <= vk .and. ii <= vl .and. ii <= vm .and.;
          ii <= vn .and. ii <= vo .and. ii <= vp .and. ii <= vq .and.;
          ii <= vr .and. ii <= vs .and. ii <= vt .and. ii <> 0
          total1 = quant * ii
          total2 = total2 + total1
          total3 = total3 + total1
          soma09 = total1
          @ li,00 say produto+' '+strpic(ii,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab10
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if j # 0
          jj = j + (j * porce10 / 100)
       else
          jj = j
       endif
       if a # 0
          va = a           + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b           + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c           + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d           + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e           + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f           + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g           + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h           + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i           + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if k # 0
          vk = k           + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l           + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m           + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n           + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o           + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p           + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q           + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r           + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s           + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t           + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if jj <= va .and. jj <= vb .and. jj <= vc .and. jj <= vd .and.;
          jj <= ve .and. jj <= vf .and. jj <= vg .and. jj <= vh .and.;
          jj <= vi .and. jj <= vk .and. jj <= vl .and. jj <= vm .and.;
          jj <= vn .and. jj <= vo .and. jj <= vp .and. jj <= vq .and.;
          jj <= vr .and. jj <= vs .and. jj <= vt .and. jj <> 0
          total1 = quant * jj
          total2 = total2 + total1
          total3 = total3 + total1
          soma10 = total1
          @ li,00 say produto+' '+strpic(jj,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab11
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if l # 0
          kk = k + (k * porce11 / 100)
       else
          kk = k
       endif
       if a # 0
          va = a      + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b      + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c      + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d      + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e      + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f      + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g      + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h      + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i      + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j      + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if l # 0
          vl = l      + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m      + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n      + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o      + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p      + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q      + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r      + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s      + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t      + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if kk <= va .and. kk <= vb .and. kk <= vc .and. kk <= vd .and.;
          kk <= ve .and. kk <= vf .and. kk <= vg .and. kk <= vh .and.;
          kk <= vi .and. kk <= vj .and. kk <= vl .and. kk <= vm .and.;
          kk <= vn .and. kk <= vo .and. kk <= vp .and. kk <= vq .and.;
          kk <= vr .and. kk <= vs .and. kk <= vt .and. kk <> 0
          total1 = quant * kk
          total2 = total2 + total1
          total3 = total3 + total1
          soma11 = total1
          @ li,00 say produto+' '+strpic(kk,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab12
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if l # 0
          ll = l + (l * porce12 / 100 )
       else
          ll = 0
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if ll <= va .and. ll <= vb .and. ll <= vc .and. ll <= vd .and.;
          ll <= ve .and. ll <= vf .and. ll <= vg .and. ll <= vh .and.;
          ll <= vi .and. ll <= vj .and. ll <= vk .and. ll <= vm .and.;
          ll <= vn .and. ll <= vo .and. ll <= vp .and. ll <= vq .and.;
          ll <= vr .and. ll <= vs .and. ll <= vt .and. ll <> 0
          total1 = quant * ll
          total2 = total2 + total1
          total3 = total3 + total1
          soma12 = total1
          @ li,00 say produto+' '+strpic(ll,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab13
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if m # 0
          mm = m + (m * porce13 / 100)
       else
          mm = m
       endif
       if a # 0
          va = a        + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b        + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c        + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d        + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e        + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f        + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g        + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h        + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i        + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j        + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k        + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l        + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if n # 0
          vn = n        + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o        + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p        + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q        + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r        + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s        + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t        + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if mm <= va .and. mm <= vb .and. mm <= vc .and. mm <= vd .and.;
          mm <= ve .and. mm <= vf .and. mm <= vg .and. mm <= vh .and.;
          mm <= vi .and. mm <= vj .and. mm <= vk .and. mm <= vl .and.;
          mm <= vn .and. mm <= vo .and. mm <= vp .and. mm <= vq .and.;
          mm <= vr .and. mm <= vs .and. mm <= vt .and. mm <> 0
          total1 = quant * mm
          total2 = total2 + total1
          total3 = total3 + total1
          soma13 = total1
          @ li,00 say produto+' '+strpic(mm,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para : "+cab14
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if n # 0
          nn = n + (n * porce14 / 100)
       else
          nn = n
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (n * porce13 / 100)
       else
          vm = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if nn <= va .and. nn <= vb .and. nn <= vc .and. nn <= vd .and.;
          nn <= ve .and. nn <= vf .and. nn <= vg .and. nn <= vh .and.;
          nn <= vi .and. nn <= vj .and. nn <= vk .and. nn <= vl .and.;
          nn <= vm .and. nn <= vo .and. nn <= vp .and. nn <= vq .and.;
          nn <= vr .and. nn <= vs .and. nn <= vt .and. nn <> 0
          total1 = quant * nn
          total2 = total2 + total1
          total3 = total3 + total1
          soma14 = total1
          @ li,00 say produto+' '+strpic(nn,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para :"+cab15
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if o # 0
          oo = o + (o * porce15 / 100)
       else
          oo = o
       endif
       if a # 0
          va = a        + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b        + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c        + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d        + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e        + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f        + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g        + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h        + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i        + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j        + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k        + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l        + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m        + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n        + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if p # 0
          vp = p        + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q        + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r        + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s        + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t        + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if oo <= va .and. oo <= vb .and. oo <= vc .and. oo <= vd .and.;
          oo <= ve .and. oo <= vf .and. oo <= vg .and. oo <= vh .and.;
          oo <= vi .and. oo <= vj .and. oo <= vk .and. oo <= vl .and.;
          oo <= vm .and. oo <= vn .and. oo <= vp .and. oo <= vq .and.;
          oo <= vr .and. oo <= vs .and. oo <= vt .and. oo <> 0
          total1 = quant * oo
          total2 = total2 + total1
          total3 = total3 + total1
          soma15 = total1
          @ li,00 say produto+' '+strpic(oo,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para :"+cab16
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if p # 0
          pp = p + (p * porce16 / 100)
       else
          pp = p
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
 
       if pp <= va .and. pp <= vb .and. pp <= vc .and. pp <= vd .and.;
          pp <= ve .and. pp <= vf .and. pp <= vg .and. pp <= vh .and.;
          pp <= vi .and. pp <= vj .and. pp <= vk .and. pp <= vl .and.;
          pp <= vm .and. pp <= vn .and. pp <= vo .and. pp <= vq .and.;
          pp <= vr .and. pp <= vs .and. pp <= vt .and. pp <> 0
          total1 = quant * pp
          total2 = total2 + total1
          total3 = total3 + total1
          soma16 = total1
          @ li,00 say produto+' '+strpic(pp,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para :"+cab17
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if q # 0
          qq = q + (q * porce17 / 100)
       else
          qq = q
       endif
       if a # 0
          va = a           + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b           + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c           + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d           + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e           + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f           + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g           + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h           + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i           + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j           + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k           + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l           + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m           + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n           + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o           + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p           + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if r # 0
          vr = r           + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s           + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t           + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if qq <= va .and. qq <= vb .and. qq <= vc .and. qq <= vd .and.;
          qq <= ve .and. qq <= vf .and. qq <= vg .and. qq <= vh .and.;
          qq <= vi .and. qq <= vj .and. qq <= vk .and. qq <= vl .and.;
          qq <= vm .and. qq <= vn .and. qq <= vo .and. qq <= vp .and.;
          qq <= vr .and. qq <= vs .and. qq <= vt .and. qq <> 0
          total1 = quant * qq
          total2 = total2 + total1
          total3 = total3 + total1
          soma17 = total1
          @ li,00 say produto+' '+strpic(qq,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para :"+cab18
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if r # 0
          rr = r + (r * porce18 / 100)
       else
          rr = r
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if rr <= va .and. rr <= vb .and. rr <= vc .and. rr <= vd .and.;
          rr <= ve .and. rr <= vf .and. rr <= vg .and. rr <= vh .and.;
          rr <= vi .and. rr <= vj .and. rr <= vk .and. rr <= vl .and.;
          rr <= vm .and. rr <= vn .and. rr <= vo .and. rr <= vp .and.;
          rr <= vq .and. rr <= vs .and. rr <= vt .and. rr <> 0
          total1 = quant * rr
          total2 = total2 + total1
          total3 = total3 + total1
          soma18 = total1
          @ li,00 say produto+' '+strpic(rr,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,56 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para :"+cab19
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if s # 0
          ss = s + (s * porce19 / 100)
       else
          ss = s
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if t # 0
          vt = t       + (t * porce20 / 100)
       else
          vt = 1000000
       endif
       if ss <= va .and. ss <= vb .and. ss <= vc .and. ss <= vd .and.;
          ss <= ve .and. ss <= vf .and. ss <= vg .and. ss <= vh .and.;
          ss <= vi .and. ss <= vj .and. ss <= vk .and. ss <= vl .and.;
          ss <= vm .and. ss <= vn .and. ss <= vo .and. ss <= vp .and.;
          ss <= vq .and. ss <= vr .and. ss <= vt .and. ss <> 0
          total1 = quant * ss
          total2 = total2 + total1
          total3 = total3 + total1
          soma19 = total1
          @ li,00 say produto+' '+strpic(ss,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,56 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 GO TOP
 store 0 to total2
 @ li,00 say vdados1
 li = li + 1
 @ li,00 say "Cotacao para :"+cab20
 li = li + 1
 @ li,00 say "Descri‡„o                               V.Unit. Quant.     Valor"
 li = li + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 1
 do while .not. eof()
       if t # 0
          tt = t + (t * porce20 / 100)
       else
          tt = t
       endif
       if a # 0
          va = a       + (a * porce01 / 100)
       else
          va = 1000000
       endif
       if b # 0
          vb = b       + (b * porce02 / 100)
       else
          vb = 1000000
       endif
       if c # 0
          vc = c       + (c * porce03 / 100)
       else
          vc = 1000000
       endif
       if d # 0
          vd = d       + (d * porce04 / 100)
       else
          vd = 1000000
       endif
       if e # 0
          ve = e       + (e * porce05 / 100)
       else
          ve = 1000000
       endif
       if f # 0
          vf = f       + (f * porce06 / 100)
       else
          vf = 1000000
       endif
       if g # 0
          vg = g       + (g * porce07 / 100)
       else
          vg = 1000000
       endif
       if h # 0
          vh = h       + (h * porce08 / 100)
       else
          vh = 1000000
       endif
       if i # 0
          vi = i       + (i * porce09 / 100)
       else
          vi = 1000000
       endif
       if j # 0
          vj = j       + (j * porce10 / 100)
       else
          vj = 1000000
       endif
       if k # 0
          vk = k       + (k * porce11 / 100)
       else
          vk = 1000000
       endif
       if l # 0
          vl = l       + (l * porce12 / 100)
       else
          vl = 1000000
       endif
       if m # 0
          vm = m       + (m * porce13 / 100)
       else
          vm = 1000000
       endif
       if n # 0
          vn = n       + (n * porce14 / 100)
       else
          vn = 1000000
       endif
       if o # 0
          vo = o       + (o * porce15 / 100)
       else
          vo = 1000000
       endif
       if p # 0
          vp = p       + (p * porce16 / 100)
       else
          vp = 1000000
       endif
       if q # 0
          vq = q       + (q * porce17 / 100)
       else
          vq = 1000000
       endif
       if r # 0
          vr = r       + (r * porce18 / 100)
       else
          vr = 1000000
       endif
       if s # 0
          vs = s       + (s * porce19 / 100)
       else
          vs = 1000000
       endif
       if tt <= va .and. tt <= vb .and. tt <= vc .and. tt <= vd .and.;
          tt <= ve .and. tt <= vf .and. tt <= vg .and. tt <= vh .and.;
          tt <= vi .and. tt <= vj .and. tt <= vk .and. tt <= vl .and.;
          tt <= vm .and. tt <= vn .and. tt <= vo .and. tt <= vp .and.;
          tt <= vq .and. tt <= vr .and. tt <= vs .and. tt <> 0
          total1 = quant * tt
          total2 = total2 + total1
          total3 = total3 + total1
          soma20 = total1
          @ li,00 say produto+' '+strpic(tt,7,2)+' '+strpic(quant,7)+' '+strpic(total1,9,2)
          LI = LI + 1
       endif
       SKIP
 ENDDO
 li= li + 2
 @ li,54 say "----------"
 li = li + 1
 @ li,54 say strpic(total2,10,2)
 li = li + 4
 @ li,00 say "----------------------------------------------------------------"
 LI = LI + 1
 @ li,00 say "TOTAL DA COTA€AO.........."
 @ li,54 say strpic(total3,10,2)
 LI = LI + 1
 @ li,00 say "----------------------------------------------------------------"
 li = li + 2
 eject
 set print on
 ?? chr(27)+chr(80)+chr(18)
 set print off
 set device to screen
 restore screen from imp
RETURN ""
