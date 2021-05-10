*********************************************************
*
*
*
*
*
*
*
*****************************************
set inten off
use codes index codx
@ 11,25,19,77 BOX CHR(176)
sen=space(10)
@ 10,24 CLEAR TO 18,76
@ 10,24 TO 18,76
@ 10,30 say "Exclus„o de Baixas"
@ 11,25 SAY "Digite A Senha Ou <ENTER> P/ Sair"
sen=seguran(12,26)
if empty(sen)
   return
endif
restore from senha additive
if sen<>senha_mem
   @ 13,28 say "Senha Invalida!!"
   inkey (.9)
   set inten on
   return
endif
DO WHILE .T.
   @ 13,25 clear to 16,70
   MCODMAT=SPACE(15)
   SET INTEN ON
   use movime index inx3
   @ 13,25 SAY "Digite o Codigo do Material: "GET MCODMAT PICT "@!"
   @ 14,25 SAY "Ou <ENTER> P/ Sair"
   READ
   SAVE SCREEN TO TELA6A
   set intensity on
   IF MCODMAT=SPACE(15)
      SET INTEN ON
      EXIT
   ENDIF
   USE MOVIME INDEX INX3
   SEEK MCODMAT
   IF .NOT. FOUND()
       @ 15,40 SAY "N„o Encontrado; tecle <ENTER>"
       INKEY (0)
       loop
   ENDIF
   CERT="N"
   @ 15,25 SAY "Material: "+alltrim(material)
   @ 16,25 SAY "Tem Certeza <S/N>? " GET CERT PICT "!"
   READ
   IF CERT="N"
      loop
   ENDIF
   USE MOVIME INDEX INX3
   DELE FOR CODMAT=MCODMAT
   PACK
ENDDO
