**
*
**
set scoreboard off
set message to 24
public mensagem
set wrap on
set escape off
corpdr=setcolor()
declare lin[4]
lin[1] = 07
lin[2] = 09
lin[3] = 11
lin[4] = 13
linaux=chr(199)+replicate(chr(196),15)+chr(182)
clear
declare opc1[4]
opc1[1] = "  mensagens    "
opc1[2] = "  lista ASCII  "
OPC1[3] = "FORMATO CLIPPER"
OPC1[4] = "      DOS      "
DECLARE OPC2[4]
OPC2[1] = "Digitar Mensagem A Ser Codificada"
opc2[2] = "Exibe o valor ASCII de cada elemento da mensagem"
opc2[3] = "Exibe o codigo a ser usado para programacao em clipper"
opc2[4] = "Encerra o programa e retorna p/ o Sistema"
declare opc3[4]
opc3[1] = "mens()"
opc3[2] = "converte(1)"
opc3[3] = "converte(2)"
opc3[4] = "sair"
op=1
set color to w/b
@ 00,00 say space(29)+ "Codifier v 1.0 Plus"+ space(32)
set color to b/w+
@ 01,00 say space(13)+"Thronos Sistemas- + Autor Desconhecido"+space(15)
do while .t.
   set color to w/b
   @ 00,00 say space(29)+ "Codifier v 1.0 Plus"+ space(32)
   set color to b/w+
   @ 01,00 say space(13)+"Thronos Sistemas - + Desenvolvido Por - Desconhecido"+space(15)
   set color to &corpdr
   @ 2,0 CLEAR
   SET COLOR TO B/BG+
   @ 06,30 TO 14,46
   FOR X=1 TO 3
      @ LIN[X] +1,30 SAY LINAUX
   NEXT
   SET COLOR TO W/BG+
   @ 24,00 CLEAR
   FOR X=1 TO 4
       @ LIN[X],31 PROMPT OPC1[X] MESSAGE OPC2[X]
   NEXT
   MENU TO OP
   IF LASTKEY()=27
      OP=4
   ENDIF
   DO CASE
      CASE OP=1
           MENS()
      CASE OP=2
           CONVERTE(1)
      CASE OP=3
           CONVERTE(2)
      CASE OP=4
           SAI()
   ENDCASE
  ?OPC3[OP]
ENDDO
***********************************
PROCEDURE MENS
MENSAGEM = SPACE(80)
@ 16,0 SAY "DIGITE A MENSAGEM : "
@ 17,00 GET MENSAGEM
READ
SET COLOR TO W/R
@ 24,00 CLEAR
IF EMPTY(MENSAGEM) .OR. .NOT. CONFIRMA("CONFIRMA MENSAGEM?",24,2)
   MENSAGEM =SPACE(80)
   RETURN
ENDIF
MENSAGEM=TRIM (MENSAGEM)
PUBLIC LIMITE
LIMITE= LEN(MENSAGEM)
RETURN
****************************************
PROCEDURE CONVERTE
PARAMETERS ARG
IF EMPTY(MENSAGEM)
   PRESS("LAMENTO, MAS VOCE DEVE DIGITAR A MENSAGEM.")
   RETURN
ENDIF
SET COLOR TO &CORPDR
@ 02,00 CLEAR
IF ARG=1
   LINHA=2
   COLU=8
ELSE
   @ 07,00 SAY "MENSAGEM = "
   @ 08,00 SAY "CHR("
ENDIF
FOR X=1 TO LIMITE
   CARAC=ASC(SUBSTR(MENSAGEM,X))
   NUM=SUBSTR(str(CARAC),8)
   IF ARG=1
      linha=linha+1
      @ linha,colu say chr(carac)+" - "+ num
      IF LINHA = 22
         LINHA=2
         COLU=COLU+20
      ENDIF
   ELSE
      @ ROW(),COL() SAY NUM + ")"
      IF  X!= LIMITE
          ?? "+chr("
        * @ row()+1,col() say "+CHR("
      ENDIF
   ENDIF
NEXT
PRESS(SPACE(24))
***********************************
PROCEDURE SAI
SET COLOR TO W*/R
IF CONFIRMA("DESEJA RETORNAR AO DOS",19,25)
   SET COLOR TO &CORPDR
   CLEAR
   QUIT
ENDIF
SET COLOR TO &CORPDR
***********************************
FUNCTION CONFIRMA
PARAMETERS CONF, L, C
SN=" "
@ L,C SAY CONF+ " <S/N>? " GET SN PICTURE "@!" VALID (SN$"SN")
READ
IF SN = "S"
   RETURN (.T.)
ENDIF
RETURN (.F.)
***********************************
PROCEDURE PRESS
PARAMETERS PARA
SET COLOR TO W/R
@ 24,00 CLEAR
@ 24,02 SAY PARA+" PRESSIONA ALGUMA TECLA..."
INKEY(0)

