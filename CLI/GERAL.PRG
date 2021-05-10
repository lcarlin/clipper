*************************************************************************
* Bop geral.prg
* programa  : geral.prg
* autor     : Luiz
* data      : 31/03/94
* objetivo  : procedures do sistema
* sistema   : contabilidade
***************************************************************************
procedure sai
@ 20,09 to 22,30
set color to n+*/w
@ 21,10 SAY "Reindexando Arquivos"
set color to
reindex
clear
close all
clear memory
quit
return

***********************************
procedure tela
parameters mensagem
coluna=int(80-len(alltrim(mensagem)))/2
clear
set color to b+/w
@ 00,00,24,79 box quadro
@ 01,coluna say mensagem
set color to
@ 04,05 say "C¢digo........:"
@ 06,05 say "Nome..........:"
@ 08,05 say "Endere‡o......:"
@ 10,05 say "Cidade........:"
@ 12,05 say "Estado........:"
@ 14,05 say "CEP...........:"
@ 16,05 say "Telefone......:"
@ 23,15 say "Pressione <ESC> Para Sair"
return

***********************************************************
procedure variaveis
parameters modo
if modo=1
   MCOD  = 0
   MNOME = space(30)
   MEND  = space(45)
   MCID  = space(20)
   MEST  = space(2)
   MCP   = 0
   MTEL  = 0
   MOBS  = space(10)
elseif modo=2
   MCOD  = BCOD   
   MNOME = bNOME
   MEND  = BEND
   MCID  = BCID
   MEST  = BEST
   MCP   = BCP
   MTEL  = BTEL
   MOBS  = BOBS
   MOBS2 = MOBS
endif
return

*******************************************************************
procedure arquivo
if file("clientes.dbf")
   if .not. file ("ind_cli.ntx")
      use clientes
      index on bcod to ind_cli
      index on str(bcod,5,0)+bnome to ind_cli2
      close all
   Endif
else
   clear
   ?"Arquivo n„o encontrado"
   inkey(3)
   sai()
endif
**********************************************************************

FUNCTION tabela
declare mcab[2]
mcab[1] = "C¢digo"
mcab[2] = "Nome"
declare mcamp[2]
mcamp[1] = "bcod"
mcamp[2] = "bnome"
declare mmas[2]
mmas[1] = "@!"
mmas[2] = "@!"
save screen to tela
@ 06,14 to 21,62
dbedit(07,15,19,60,mcamp,"contro",mmas,mcab,.t.,.t.,.t.)
restore screen from tela
return MCOD
****************************************
function contro
parameters statu, indice
@ 20,17 say "<ENTER> Seleciona a op‡„o"
if statu=4
   if lastkey()=13
      variaveis(2)
      return 0
   elseif lastkey()=27
      return 0
      return 1
   endif
else   
  return 1
endif

*****************************************************
FUNCTION obser
IF PCOUNT()=2
   parameters mdo,M2
ELSE
   PARAMETERS MDO
   M2=.F.
endif
save screen to obs
@ 10,39 to 23,78
@ 10,46 say "º Observa‡”es º"
if mdo
   IF M2
      texto=MOBS2
   ELSE
      TEXTO=BOBS
   ENDIF
   @ 22,41 SAY "^W Grava; ^Y Apaga Linha; <ESC> Sai"
   MOBS=memoedit(texto,11,40,21,77,.t.)
   restore screen from obs
else
   texto=bobs
   @ 22,41 SAY " <ESC> Sai"
   set cursor off
   MOBS2=memoedit(texto,11,40,21,77,.f.)
   tel_=savescreen(11,40,21,77)
   IF LASTKEY() = 27
      MOBS=BOBS
      restscreen(11,40,21,77,tel_)
      set cursor on
   ENDIF
   set cursor on
   restscreen(11,40,21,77,tel_)
endif

RETURN MOBS

* eop geral.prg 