linha=row()
coluna=col()
save screen to tela_
clear
opcao=0
do while .t.
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
           verisenha(1)
      case opcao=2
           verisenha(2)
      case opcao=3
	   exit
  endcase
enddo
clear
restore screen from tela
@ linnh,coluna say ""
close all
*verisenha()
******************
function verisenha
parameters modo
private  tela_ant, usercod, usersenha, password, drowssap, ret, nvez, k
tela_ant= savescreen (00,00,24,79)
drowssap=" "
ret=.f.
nvez=1
set color to
set cursor on
use arqsenha
do while .t.
   drorssap=" "
   set color to
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
      loop
   endif
   locate for coduser=usercod
   if .not. found()
      tone (400,4)
      tone (300,3)
      @ 24,03 say " Usuario Nao Cadastrado"
      inkey(0)
      loop
   endif
   for k=1 to len(usersenha)
       password=asc(substr(usersenha,k,1)) + k + 99
       drowssap= drowssap+chr(password)
   next k
   if alltrim(codsenha)==alltrim(drowssap)
      ?? chr(07)
      @ 24,03 say "senha Confere"
      ret= .t.
      inkey(0)
      exit
   else
      tone (400,4)
      tone (300,3)
      if nvez<=3
         @ 10,10 say drowssap
         @ 24,03 say "senha Incorreta"
         inkey(0)
         nvez=nvez+1
         loop
      else
         set color to
         scroll(24,00,24,79,0)
         @ 24,03 say "usuario nao cadastrado"
         inkey(1)
         set color to w+*
         @ 24,30 say " Acesso Negado"
        inkey(0)
         exit
      endif
   endif
enddo
close all
set cursor on
set color to
clear
restscreen (00,00,24,79,tela_ant)
return (ret)
