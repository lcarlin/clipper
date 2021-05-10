**********************************************************************
* Programa : INCCLI.PRG                                              *
* Objetivo : Inclusao de clientes                                    *
* Data : 12.07.92                                                    *
**********************************************************************
@ 06,02 clear to 21,78 
TCLIENTES()
@ 07,21 say 'I N C L U S A O   D E   C L I E N T E S'
save screen to TELAINC
set order to 1
do while .t.
   MENSA = '<Esc> - Retorna ao cadastro de clientes'
   MOSTRA(MENSA)
   MNOMECLI  = space(30)
   MENDERECO = space(30)
   MBAIRRO   = space(15)
   MCIDADE   = space(15)
   MESTADO   = space(02)
   store 0 to MCODCLI,MTELEF,MCEP 
   set color to w/n,w/n+
   @ 09,19 get MCODCLI  pict "99999" valid MCODCLI > 0
   read
   if lastkey()=27
      exit
   endif   
   seek MCODCLI
   if eof()
      MENSA = '<Esc> - Cancela operacao'
      MOSTRA(MENSA)
      set color to w/n,w/n+
      @ 10,19 get MNOMECLI  pict "@!" valid MNOMECLI  <> space(1)
      @ 11,19 get MENDERECO pict "@!" valid MENDERECO <> space(1)
      @ 12,19 get MBAIRRO   pict "@!" valid MBAIRRO   <> space(1) 
      @ 12,50 get MTELEF    pict "9999999" 
      @ 13,19 get MCIDADE   pict "@!" valid MCIDADE   <> space(1)
      @ 13,50 get MESTADO   pict "@!" ;
              valid MESTADO $('AC,AM,AP,AL,BA,CE,ES,GO,MA,MG,MS,MT,PA,PB,PE,PR,PI,RJ,RN,RS,RR,RO,SP,SE,SC,TO')
      @ 13,63 get MCEP      pict "99999999" 
      read
      if lastkey()=27
         restore screen from TELAINC
         loop
      endif    
      CONFIRMA()
      if lastkey()=27
         restore screen from TELAINC 
         loop
      endif   
      if MCONF = "S"    
        append blank
        replace CODCLI with MCODCLI,NOMECLI with MNOMECLI;
                ENDERECO with MENDERECO,BAIRRO with MBAIRRO;
                TELEF with MTELEF, CIDADE with MCIDADE, EST with MESTADO;
                CEP with MCEP   
      endif     
   else 
      MENSA = 'Codigo ja cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
   endif   
   restore screen from TELAINC
enddo
set color to
restore screen from TELACLI
OPCAO = 1
return
