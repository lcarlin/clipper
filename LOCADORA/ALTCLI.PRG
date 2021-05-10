**********************************************************************
* Programa : ALTCLI.PRG                                              *
* Objetivo : Alteracao de clientes                                   *
* Data : 12.07.92                                                    *
**********************************************************************
@ 06,02 clear to 21,78 
TCLIENTES()
@ 07,20 say 'A L T E R A C A O   D E   C L I E N T E S'
save screen to TELAALT
do while .t.
   if OPCAO <> 0
      store 0 to MCODCLI
      MENSA = '<Esc> - Retorna ao cadastro de clientes'
      MOSTRA(MENSA)
      set color to w/n,w/n+
      @ 09,19 get MCODCLI  pict "99999" valid MCODCLI > 0
      read
      if lastkey()=27
         exit
      endif   
      seek MCODCLI
      if eof()
         MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
         MENSAGEM(MENSA)
         loop
      endif    
   endif
   MENSA = '<Esc> - Cancela operacao'
   MOSTRA(MENSA)
   set color to w/n,w/n+
   MNOMECLI  = NOMECLI
   MENDERECO = ENDERECO
   MBAIRRO   = BAIRRO
   MTELEF    = TELEF
   MCIDADE   = CIDADE
   MESTADO   = EST
   MCEP      = CEP 
   @ 09,20 say MCODCLI   pict "99999"
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
      if OPCAO = 0 
         SAI = 1
         exit
      endif   
      restore screen from TELAALT
      loop
   endif    
   CONFIRMA()
   if lastkey()=27
      if OPCAO = 0 
         SAI = 1
         exit
      endif   
      restore screen from TELAALT
      loop
   endif    
   if MCONF = "S"    
      replace NOMECLI with MNOMECLI;
              ENDERECO with MENDERECO,BAIRRO with MBAIRRO;
              TELEF with MTELEF, CIDADE with MCIDADE, EST with MESTADO;
              CEP with MCEP   
   endif     
   if OPCAO = 0
      SAI = 1 
      exit
   endif   
   restore screen from TELAALT
enddo
set color to
restore screen from TELACLI
OPCAO = 2
return
