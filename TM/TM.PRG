*************************************************
* bop tm.prg
* programa   : tm.prg
* data       : 22/09/94
* funcao     : menu principal do sistema
* autores    : Ana Paula, Danielle, Everton, LU
**************************************************
save screen to tela_dos
linha = row()
coluna=col()
set score off
set procedure to tmfunc
set procedure to tmhelp
set wrap on
set delete on
set date british
clear
public data_sis,VAZIOS
* ARQUIVOS DE INDICES

if .not. file("tmicli1.ntx")
   ?"Orgarnizando arquivo de clientes"
   use tmbcli
   index on cod to tmicli1
   close all
endif
if .not. file("tmiest.ntx")
   ?"Orgarnizando arquivo de estoque"
   use tmbest
   index on codest to tmiest
   close all
endif
if .not. file("tmifun.ntx")
   ?"Orgarnizando arquivo de funcionarios"
   use tmbfun
   index on codfun to tmifun
   close all
endif
if .not. file("tmiest1.ntx")
   ?"Orgarnizando arquivo de baixas de estoque"
   use tmbbest
   index on datab to tmiest1
   close all
endif
if .not. file("tmiest2.ntx")
   ?"Orgarnizando arquivo de reposicao de estoques"
   use tmbrest
   index on datae to tmiest2
   close all
endif
if .not. file ("tmifor.ntx")
   ?"Orgarnizando arquivo de fornecedores"
   use tmbfor
   index on codfor to tmifor
   close all
endif

* tela do menu principal

QUADRO  = REPLICATE (CHR(178),8)
QUADRO2 = REPLICATE (CHR(176),9)

SET COLOR TO B/N
@ 00,00,24,79 BOX QUADRO
SET COLOR TO n/gb
@ 01,01,23,78 BOX QUADRO2
@ 00,01 SAY " Sistema Tec Maq  û 1.0 "
set color to
@ 01,03 clear to 03,76
* 01,02 to 03,75
* 01,02 say chr(195)
* 01,75 say chr(180)
sombra(01,03,03,75,.f.)
for i = 15 to 63 step 12
    @ 01, i say chr(194)
    @ 02, i say chr(179)
    @ 03, i say chr(193)
next
sombra(20,01,22,28,.f.)
@ 21,02 say "<F1> - HELP ³ <F10> - SAIR"

sombra(07,20,16,56,.t.)
@ 08,30 say " Sistema Tec Maq "
@ 10,27 say "Sistema de Controle Geral"
@ 12,22 say "Desenvolvido  por  alunos do 3§ A"
@ 14,30 say "Set/94 - Dez/94"

OP  = 1
C   =  4
* itens do menu principal

ITEM1= [Manutencao]
ITEM2= [ Caixa    ]
ITEM3= [ Estoque  ]
ITEM4= [ Agenda   ]
ITEM5= [ Servicos ]
ITEM6= [Relatorios]
*********************
* vetores
* vetor da manutencao
declare vetor1[4]
vetor1[1] = "Clientes"
vetor1[2] = "Funcionarios"
vetor1[3] = "Fornecedores"
vetor1[4] = "Estoque"

*vetor do caixa
declare vetor2[2]
vetor2[1] = "Lan‡amentos"
vetor2[2] = "Fechamento"

* vetor do estoque
declare vetor3[3]
vetor3[1] = "Baixas"
vetor3[2] = "Entrada"
Vetor3[3] = "Consulta"

* vetor da agenda
declare vetor4[3]
vetor4[1] = "Inclusao"
vetor4[2] = "Exclus„o"
vetor4[3] = "Consulta"

* Vetor do Servicos
declare vetor5[3]
vetor5[1] = "Reparos"
vetor5[2] = "Vendas"
vetor5[3] = "Consulta"

* Vetor do relatorio
declare vetor6[5]
vetor6[1] = "Caixa"
vetor6[2] = "Estoque"
vetor6[3] = "Clientes"
vetor6[4] = "Agenda"
vetor6[5] = "Funcion."
save screen
sombra(10,24,12,45,.F.)
DATA_SIS=DATE()
@ 11,25 say "Data Atual:" get data_sis pict "99/99/99"
read
VAZIOS = 1
VERI_AGD()
VERI_DIA()
restore screen

do while op<>12
   set color to rg+/w
   aux=1
   cv=1
   clear gets
   @ 02,04 SAY ITEM1
   @ 02,16 SAY ITEM2
   @ 02,28 SAY ITEM3
   @ 02,40 SAY ITEM4
   @ 02,52 SAY ITEM5
   @ 02,64 SAY ITEM6
   set color to
   INVERSO ='ITEM'+STR(OP,1,1)
   SET COLOR TO N/R
   @ 2,C SAY UPPER(&INVERSO)
   SET COLOR TO
   set color to w/Wn+,N/B
   DO CASE
      CASE OP=1
	   SAVE SCREEN TO TELA
	   SOMBRA(04,03,09,16,.f.)
	   ac1=ACHOICE(05,04,08,15,Vetor1,.T.,"controle")
	   IF AC1<>0
	      SET COLOR TO
	      @ 21,17 SAY "ESC"
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC1=1
	       DO TMMTCLI
	   ELSEIF AC1=2
	      do TMMTFUN
	   ELSEIF AC1=3
	      do tmmtfor
	   ELSEIF AC1=4
	      DO TMMTEST
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=2
	   SAVE SCREEN TO TELA
	   SOMBRA(04,15,07,26,.f.)
	   ac2=ACHOICE(05,16,07,25,Vetor2,.T.,"controle")
	   IF AC2<>0
	      SET COLOR TO
	      @ 21,17 SAY "ESC"
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC2=1
	      DO TMLANCA
	   ELSEIF AC2=2
	     NPRG = 0
	     SOMBRA(05,20,08,29,.F.)
	     @ 06,21 PROMPT " DIARIO "
	     @ 07,21 PROMPT " MENSAL "
	     MENU TO NPRG
	     IF NPRG = 1
		DO TMFCD
	     ELSEIF NPRG = 2
		DO TMFCM
	     ENDIF
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=3
	   SAVE SCREEN TO TELA
	   SOMBRA(04,27,08,36,.f.)
	   ac3=ACHOICE(05,28,07,35,Vetor3,.T.,"controle")
	   IF AC3<>0
	      SET COLOR TO
	      @ 21,17 SAY "ESC"
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC3=1
	      DO TMBXEST
	   ELSEIF AC3=2
	      DO TMRPEST
	   ELSEIF AC3=3
	       NPRG = 0
	       SOMBRA(05,32,08,43,.F.)
	       @ 06,33 PROMPT "  BAIXAS  "
	       @ 07,33 PROMPT " ENTRADAS "
	       MENU TO NPRG
	       IF NPRG<>0
		 SOMBRA(07,40,09,74,.F.)
		 @ 08,41 SAY "Aguarde!!! Organizando arquivo..."
	       endif
	       IF NPRG=1
		  DO TMCBEST
	       ELSEIF NPRG = 2
		  DO TMCREST
	      ENDIF
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=4
	   SAVE SCREEN TO TELA
	   SOMBRA(04,39,08,48,.f.)
	   ac4=ACHOICE(05,40,07,47,vetor4,.T.,"controle")
	   IF AC4<>0
	      SET COLOR TO
	      @ 21,17 SAY "ESC"
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC4=1
	      do  tmincag
	   elseIF AC4=2
	      do TMEXCAG
	   elseif ac4=3
	     do TMCONAGD
	   ENDIF
	   RESTORE SCREEN FROM TELA
      case op=5
	   SAVE SCREEN TO TELA
	   SOMBRA(04,51,08,60,.f.)
	   ac5=ACHOICE(05,52,07,59,vetor5,.T.,"controle")
	   IF AC5<>0
	      SET COLOR TO
	      @ 21,17 SAY "ESC"
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   if ac5=1
	      do TMMTREP
	   elseif ac5=2
	      do TMMTVEND
	   elseif ac5=3
	      do TMCSERV
	   endif
	   RESTORE SCREEN FROM TELA
      CASE OP=6
	   SAVE SCREEN TO TELA
	   SOMBRA(04,63,10,73,.f.)
	   AC6 = ACHOICE (05,64,09,72,vetor6,.T.,"controle")
	   IF AC6<>0
	      SET COLOR TO
	      @ 21,17 SAY "ESC"
	      SET COLOR TO  bg/n,w/r
	   ENDIF
	   IF AC6=1
	      DO TMRCX
	   ELSEIF AC6=2
	      DO TMREST
	   ELSEIF AC6 = 3
	      DO TMRCLIS
	   ELSEIF AC6 = 4
	       AG = 0
	       SAVE SCREEN
	       SOMBRA(08,60,11,78,.F.)
	       @ 09,62 PROMPT "     GERAL     "
	       @ 10,62 PROMPT "DIA DETERMINADO"
	       MENU TO AG
	       IF LASTKEY()=27
		  RESTORE SCREEN from tela
		  LOOP
	       ENDIF
	       IF AG = 1
		  DO TMRGER
	       ELSE
		  DO TMRAGD
	       ENDIF
	   elseif ac6 = 5
	       do tmrfunc
	   ENDIF
	   RESTORE SCREEN FROM TELA
   endcase
   restore screen from tela
   TECLA=LASTKEY()
   do CASE
     case TECLA = -9
	  SAI()
	  op = 6
	  c  = 64
	  KEYBOARD CHR(13)
      case tecla=4
	   op=op+1
	   C=C+12
	  if op>6 .OR. C>64
	     op=1
	     C=4
	  endif
     case tecla=19
	  op=op-1
	  C =C-12
	  if op<1 .OR. C<3
	     op =6
	     C  =64
	  endif
   OTHERWISE
	  VERI_DIA()
   endcase
   SET COLOR TO W/N
   @ 21,17 SAY "F10"
   NORMAL ='ITEM'+ STR(OP,1,1)
   @ 2,C SAY &NORMAL
   SET COLOR TO N/W
   IVERSO='ITEM'+STR(OP,1,1)
   @ 2,C SAY &INVERSO
   SET COLOR TO
ENDDO

* EOP tm.prg
