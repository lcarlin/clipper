**********************************************************************
* Programa : EXCCLI.PRG                                              *
* Objetivo : Exclusao de clientes                                    *
* Data : 12.07.92                                                    *
**********************************************************************
set delete on
@ 06,02 clear to 21,78 
TCLIENTES()
@ 07,21 say 'E X C L U S A O   D E   C L I E N T E S'
save screen to TELAEXC
set order to 1 
do while .t.
   restore screen from TELAEXC
   store 0 to MCODCLI
   MENSA = '<Esc> - Retorna ao cadastro de clientes'
   MOSTRA(MENSA)
   set color to w/n,w/n+
   @ 09,19 get MCODCLI  pict "99999" valid MCODCLI > 0
   read
   if lastkey()=27
      pack
      exit
   endif   
   seek MCODCLI
   if .not. eof()
      set color to w/n+,w/n+
      @ 10,19 say NOMECLI 
      @ 11,19 say ENDERECO
      @ 12,19 say BAIRRO 
      @ 12,50 say TELEF
      @ 13,19 say CIDADE
      @ 13,50 say EST 
      @ 13,63 say CEP  
      CONFIRMA()
      if lastkey()=27
         restore screen from TELAEXC
         loop
      endif   
      if MCONF = "S"    
         delete 
      else 
         MENSA = 'Dados nao excluidos. Tecle algo para continuar.'
         MENSAGEM(MENSA)
         loop
      endif      
   else 
      MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
   endif   
   restore screen from TELAEXC
enddo
set color to
restore screen from TELACLI
OPCAO = 3
return
