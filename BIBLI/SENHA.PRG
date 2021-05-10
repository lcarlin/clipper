**********************************************************************
* PROGRAMA     : SENHA.PRG                                           *
* AUTOR        : LUIZ No 18 / WILSON No 30                           *
* DATA	       : 05/11/93                                            *
* DATA ATUAL   :   /  /                                              *
* FUNCAO       : DAR ACESSO A PROGRAMAS SOMENTA COM SENHA            *
*                                                                    *
**********************************************************************
SET STATUS OFF
SET TALK OFF
SET SCORE OFF
SET ESCAPE ON
COD="*****"
DO WHILE COD="*****"
   CLEAR
   @ 00,19 TO 03,48
   @ 01,20 SAY "Digite o codigo de acesso"
   @ 02,30 GET COD
   READ
   DO CASE
      CASE UPPER(COD)="CORSA"
           do tela
      CASE COD<>"CORSA" .OR. COD="     "
           CLEAR
           @ 11,19 TO 13,44
           @ 12,20 SAY "VIOLACAO DE SEGURANCA!!!"
           DO WHILE .T.
              ??CHR(7)
           ENDDO
     ENDCASE
COD="     "
ENDDO
