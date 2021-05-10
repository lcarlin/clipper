CLEAR
SET ESCAPE ON
SET COLOR TO W/B+
FOR I=0 TO 24
    @ I,0 SAY REPLICATE ("ESTO ",16)
    inkey(.01)
NEXT
SET COLOR TO N/W
@ 02,7 say "***> ESTO; Programa de Controle de Estoques de Materiais; V 1.0 <***"
@ 04,25 say " Autor : L. A. Carlin 1993 "
@ 08,30 say      " CORSA SOFT # 1993"
inkey(1)
SAVE SCREEN TO TELA_1
SET COLOR TO
CLEAR
SET CURSOR ON
DO MENU
return

