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