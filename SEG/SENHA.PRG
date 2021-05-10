clear memory
lin=row()
col=col()
SAVE SCREEN TO T_SENHA
@ 08,08 clear to 15,52
@ 08,08 TO 15,52
IF FILE ([SENHA.MEM])
   RESTORE FROM SENHA
    @ 09,10 SAY "Digite A Senha Anterior"
   v_senha_1=seguran(09,40)
   if V_senha_1<>senha_mem
      Senha_inv()
   endif
else
   V_SENHA_1=SPACE(10)       
   V_SENHA_2=SPACE(10)
   V_SENHA_3=SPACE(10)
   SENHA_MEM=SPACE(10)
ENDIF
@ 10,10 say "Digite a Nova Senha"
v_senha_2=Seguran(10,40)
@ 11,10 say "Confirme a Nova Senha"
v_senha_3=seguran(11,40)
if v_senha_2=V_senha_3
   senha_mem=V_senha_2
   save to senha all like senha_mem
else
   Senha_inv()
endif
restore screen from t_senha
@ lin,col
clear memory

*CLEAR
*?"Digite a Senha"
*teste=seguran(row(),col())
*?teste


*****************************************
FUNCTION SEGURAN
PRIVATE CC,REL,TECLA,MSX
PARAMETERS L1,C1
SET INTEN OFF
cor=setcolor()
@ L1,C1  SAY SPACE(11)
@ L1,C1-1 SAY "["
@ L1,C1+10 SAY "]"
declare msx[10]
for i= 1 to 10
    msx[i] = " "
next
REL=" "
TECLA=LASTKEY()
V_senha=" "
j=1
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
set color to &cor
RETURN (V_senha)

**************************************************
function senha_inv
tone(250,1)
?"Senha Invalida"
quit
