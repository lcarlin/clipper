*****************************
* HELP.PRG
*
*
SAVE SCREEN TO TELA_1
if .not. file("socorro.hlp")
   sombra (09,24,11,52,.t.)
   @ 10,25 say "Arquivo De Help Inexistente"
   inkey(0)
   restore screen from tela_1
   return
endif
SOMBRA(08,16,20,75,.t.)
txt_soco=memoread("socorro.hlp")
set cursor off
set key 27 to
txt_soco=memoedit(txt_soco,09,17,19,74,.f.,"",58,1)
if lastkey()=27
   continuar=.t.
endif
set cursor on
RESTORE SCREEN FROM TELA_1
RETURN

