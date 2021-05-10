***************************************************************
* PROGRAMA     : ESTO.PRG                                     *
* AUTOR        : LUIZ A. CARLIN                               *
* DATA         : 15/10/93                                     *
* DATA ATUAL   :   /  /                                       *
* FUNCAO       : DAR ACESSO A PROGRAMAS SOMENTA COM SENHA     *
*                                                             *
***************************************************************
SETCANCEL(.T.)
if pcount()=1
   parameters teste
else
   teste="0"
endif
PUBLIC FLAG , MSX1 , FLG2 , TEL_0 , COLUNA , LINHA
LINHA=ROW()
COLUNA=COL()
SAVE SCREEN TO TEL_0
SET SCORE OFF
if .not. file("inx1.ntx")
    clear
    ? "Indexando arquivo de Materiais"
    USE MATERIAL
    INDEX ON CODMAT TO INX1
    close all
endif
if .not. file ("inx2.ntx")
   ? "Indexando arquivo de Escolas"
   USE ESCOLA
   INDEX ON CODESCO TO INX2
   close all
endif
if .not. file ([inx3.ntx])
   ?"Indexando arquivo de Baixas"
   USE MOVIME
   INDEX ON CODMAT+CODESCO TO INX3
   INDEX ON DATA TO INX4
   close all
endif
if .not. file ([senha.mem])
   do tela
else
   CLEAR
   @ 01,19 TO 06,46 DOUBLE
   @ 02,20 SAY "Digite o codigo de acesso"
   @ 03,25 SAY "ou <ENTER> P/ Sair"
   sen_=SEGURAN(5,27)
   restore from senha additive
   if empty(sen_)
      CLEAR
      QUIT
   ENDIF
   IF sen_=senha_mem
      CLEAR
      SET INTEN ON
      if teste="1"
         DO menu
      endif
      do tela
      CANCEL
   ELSE
      CLEAR
      ?"Senha Inv lida"
      ?"Acesso negado"
      ?"Retorno Normal Ao DOS"
   ENDIF
ENDIF
