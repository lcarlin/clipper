********************************************************
*                                                      *
* PROGRAMA: EMPRES.PRG                                 *
* FINALIDADE: EMPRESTIMO DE FILMES - SISTEMA LOCADORA  *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                       *
* DATA: 17/05/92                                       *
*                                                      *
********************************************************

save screen to TELAFIL 
@ 06,02 clear to 21,78
@ 07,21 say 'E M P R E S T I M O   D E   F I L M E S'
@ 09,08 say "Codigo do cliente .........: " 
@ 10,08 say "Nome do cliente ...........: "
@ 11,08 say "Numero da fita ............: "
@ 12,08 say "Nome do filme .............: "
MENSA = '<Esc> - Retorna ao menu principal'
MOSTRA(MENSA)
save screen to TELAEMP
store 0 to MQUANT
MNOMEF = space(20)
do while .t.
   store 0 to MCODCLI
   set color to w/n,w/n+
   @ 09,38 get MCODCLI  pict "99999" valid MCODCLI > 0
   read
   if lastkey()=27
      exit
   endif   
   sele 2
   seek MCODCLI
   if found()
      set color to w/n+,w/n
      @ 10,38 say NOMECLI 
      CONFIRMA()
      if lastkey()=27
         restore screen from TELAEMP
         loop
      endif   
      if MCONF = "N"    
         restore screen from TELAEMP
         loop
      endif
      do while .T.
         MENSA = '<Esc> - Seleciona outro cliente'
         MOSTRA(MENSA)
         store 0 to MCODFIL,MCONT 
         sele 1
         set order to 1
         X=reccount()
         declare ARQ[X]
         MCONT=1
         set color to w/n,w/n+
         @ 11,38 get MCODFIL  pict "99999" valid MCODFIL > 0
         read
         if lastkey()=27
            exit
         endif   
         seek MCODFIL
         if found()  
            set color to w/n+,w/n
            @ 12,38 say NOMEFIL 
            CONFIRMA()
            if lastkey()=27
               @ 12,38 say space(20)
               loop
            endif   
            if MCONF = 'N'
               @ 12,38 say space(20)
               loop
            endif
            if alugad <> "SIM"
               MNOMEF = NOMEFIL
               replace ALUGAD with 'SIM', CODCLI with MCODCLI;
                    DATARET with DATE()  
               do MOVIMENTO
               CONTINUA()
               if MCON = 'S'
                  @ 12,38 say space(20) 
                  loop
               endif   
            else           
               set order to 2 
               MNOMEFIL=NOMEFIL
               seek MNOMEFIL
               do while NOMEFIL=MNOMEFIL .and. .not. eof()
                  ARQ[MCONT]=str(CODFIL)+spac(2)+NOMEFIL+spac(2)+ALUGAD
                  MCONT=MCONT+1
                  skip
               enddo                 
               MENSA = 'Fita nao se encontra na locadora. Tecle <Enter> para continuar.'
               MOSTRA(MENSA)
               set color to bg+/n,n/w
               @ 14,08 to 20,49
               set color to
               @ 15,10 say ' Fita  Nome                  Alugada'
               set color to bg+/n,n/bg+
               Y=achoice(16,10,19,47,ARQ)
               set color to
               if Y=0 .or. Y<>0
                  @ 12,38 say space(20)
                  @ 14,08 clear to 20,49
                  loop
               endif
            endif      
         else
            MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
            MENSAGEM(MENSA)
            loop
         endif
         exit     
      enddo
   else
      MENSA = 'Codigo nao cadastrado. Tecle algo para continuar.'
      MENSAGEM(MENSA)
   endif   
   restore screen from TELAEMP                
enddo
set color to
restore screen from TELAFIL
OPCAO = 3
return

procedure MOVIMENTO
sele 3
seek MNOMEF
if .NOT. found()
   MQUANT = 0
   append blank
else
   MQUANT = QUANT
endif
MQUANT = MQUANT + 1  
replace NOMEF with MNOMEF, QUANT with MQUANT  
return
