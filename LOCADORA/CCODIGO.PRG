**********************************************************************
* Programa : CCODIGO.PRG                                             *
* Objetivo : Consulta de clientes por codigo                         *
* Data : 12.07.92                                                    *
**********************************************************************
@ 06,02 clear to 21,78 
TCLIENTES()
@ 7,21 say 'C O N S U L T A   D E   C L I E N T E S'
save screen to TELACON
do while .t.
   if OPCAO<>0
      go top
      store 0 to MCODCLI
      MENSA='<Esc> - Retorna ao menu anterior'
      MOSTRA(MENSA)
      set color to w/n,w/n+
      @ 09,19 get MCODCLI pict '99999' 
      read
      set color to
      if lastkey()=27
         restore screen from TMENU1
         exit
      endif   
   endif
   seek MCODCLI
   if eof()
      MENSA='Codigo nao cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
   else
      set color to w/n+,w/n+
      @ 10,19 say NOMECLI 
      @ 11,19 say ENDERECO
      @ 12,19 say BAIRRO 
      @ 12,50 say TELEF
      @ 13,19 say CIDADE
      @ 13,63 say CEP  
      MENSA='Tecle algo para continuar a consulta.'
      MENSAGEM(MENSA)
   endif
   if OPCAO=0
      exit
   endif       
   restore screen from TELACON
   loop
enddo
if OPCAO<>0
   restore screen from TMENU1
   OPCAO=1
endif   
return
