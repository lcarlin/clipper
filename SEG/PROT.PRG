*********************************
* programa : prot.prg
* Autor    : l.a.c.
* data     : 08/03/94
* funcao   : inclusao/exclusao de senhas
* obs.     : versao menhorado do programa publicado
*          : em MS-134
**********************************
public usercod, drowssap,
linha=row()
coluna=col()
save screen to tela_
clear
opcao=0
use arqsenha
do while .t.
   set color to
   clear
   scroll(00,00,24,23, 10)

   @ 08,19 prompt " Incluir Senhas "
   @ 09,19 prompt " Excluir Senhas "
   @ 10,19 prompt "Sair do Programa"
   menu to opcao
   if lastkey()=27
      opcao=3
      keyboard chr(13)
   endif
   do case
      case opcao=1
           incluisenha()
      case opcao=2
	   excluisenha()
      case opcao=3
	   exit
  endcase
enddo
clear
restore screen from tela_
@ linha,coluna say ""
close all
*verisenha()
******************
procedure incluisenha
verisenha()
set color to
if found()
   tone (8000,8)
   @ 23,15 say "Usuario ja cadastrado; pressione algo para continuar..."
   inkey(0)
   return
endif
append blank
replace coduser  with usercod
replace codsenha with drowssap
return
*************************************************
procedure excluisenha
verisenha()
set color to
if .not. found()
   tone (8000,8)
   @ 23,15 say "Usuario nao cadastrado; pessione algo para continuar..."
   inkey(0)
   return
endif
sn=" "
if alltrim(codsenha)==alltrim(drowssap)
   @ 23,15 clear
   @ 23,15 say "Excluir <S/N> ?" get sn picture "!" valid (sn$"SN")
   READ
   IF SN="S"
      dele
      pack
      return
   endif
else
   @ 23,15 clear
   @ 23,15 say "Senha nao confere"
   inkey(0)
   return
endif
return
********************************************************
function verisenha
private  tela_ant, usersenha, password,  ret, nvez, k
drowssap=" "
set color to
set cursor on
use arqsenha
set color to w/n,x
usersenha=space(40)
usercod= space(10)
set cursor on
@11,12 say " Codigo Do Usuario " get usercod
read
@12,12 say " Senha de acesso : " get usersenha
read
usercod=alltrim(upper(usercod))
usersenha=alltrim(upper(usersenha))
set color to
set color to w*+
if (len(usercod)*len(usersenha)) = 0
   tone (400,4)
   tone (300,3)
   @ 24,03 say " Dados invalidos"
   inkey(0)
endif
for k=1 to len(usersenha)
    password=asc(substr(usersenha,k,1)) + k + 99
    drowssap= drowssap+chr(password)
next
locate for coduser=usercod
            