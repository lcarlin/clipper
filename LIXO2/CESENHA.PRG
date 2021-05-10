if  file ([senha.mem])
   CLEAR
   @ 01,19 TO 06,46 DOUBLE
   @ 02,20 SAY "Digite o codigo de acesso"
   @ 03,25 SAY "ou <ENTER> P/ Sair"
   sen_=SEGURAN(5,27)
   sen_=verisenha(sen_)
   restore from senha additive
   if empty(sen_)
      CLEAR
      QUIT
   ENDIF
   IF sen_<>senha_mem
      CLEAR
      ?"Senha Inv lida"
      ?"Acesso negado"
      ?"Retorno Normal Ao DOS"
      quit
   ENDIF
ENDIF
