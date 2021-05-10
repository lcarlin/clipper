*****************************************************
* Bop Dici.prg
* PROGRAMA  :  DICI.PRG
* SISTEMA   :  DICIONARIO
* AUTOR     :  " O Corsario"
* data      :  19/01/94
**********************************************
SET SCORE Off
set escape off
tecla=lastkey()
set date  british
set procedure to geral
set procedure to util
mo=.t.
flag=.t.
flg2=.f.
SET WRAP ON
set key -1 to modo
set key -2 to imp
set key -3 to banco
PUBLIC OP, AC1, AC2, AC3, AC4, AC5, AC6, MMENU1, MMENU2, MMENU3, MMENU4,
public ed, mcamp, mmasc, mcab, exp1, PROCURA, MCAMP, MCAB, c
public MMAC, MODO, ARQ, flag, flg2, MMENU5, TECLA, continua, conta, p, l
STORE 0 TO AC1, AC2, AC3, AC4, AC5, AC6
QUADRO=REPLICATE (CHR(178),8)
QUADRO2=REPLICATE (CHR(176),9)
SAVE SCREEN TO TELA_DOS
LINHA=ROW()
COLUNA=COL()
ITEM1= [ Palavras ]
ITEM2= [  Verbos  ]
ITEM3= [Expressoes]
ITEM4= [Utilitario]
ITEM5= [   Help   ]
ITEM6= [   Sair   ]
if .not. file([palavras.dbf])
   ??"Arquivos N„o Encontrados..."
   quit
endif
if .not.  file ([verbos.dbf])
   ??"Arquivos N„o Encontrados..."
   quit
endif
if .not.  file ([expresso.dbf])
   ??"Arquivos N„o Encontrados..."
   quit
endif
if .NOT. FILE ([INDICE1.NTX]) .OR. .NOT. FILE ([INDICE2.NTX])
   ?"Indexando Arquivo de Palavras"
   USE PALAVRAS
   INDEX ON PLING TO INDICE1
   INDEX ON PLPOR TO INDICE2
   CLOSE ALL
ENDIF
IF .NOT. FILE([INDICE3.NTX]) .OR. .NOT. FILE([INDICE4.NTX])
  ?"Indexando Arquivos De Verbos"
   USE VERBOS
   INDEX ON VEII TO INDICE3
   INDEX ON VEIP TO INDICE4
   CLOSE ALL
ENDIF
IF .NOT. FILE([INDICE5.NTX]) .OR. .NOT. FILE([INDICE6.NTX])
   ?"Indexando Arquivo De Expressoes"
   USE EXPRESSO
   INDEX ON EXPING TO INDICE5
   INDEX ON EXPPOR TO INDICE6
   CLOSE ALL
ENDIF
fundo=replicate ("Dici ",16)
set color to bg/w+
for i=0 to 24
    @  i,00 say fundo
    inkey(0.01)
next
inkey(.3)
**- tela do menu principal
SET COLOR TO B/N
@ 00,00,24,79 BOX QUADRO
SET COLOR TO n/gb
@ 01,01,23,78 BOX QUADRO2
@ 00,01 SAY " Corsa Soft  Dici; û 1.0 "
@ 00,35 say " S‚rie DEMO "
OP=1
SAI="N"
set color to gb/b
sombra(08,02,20,11,.f.)
@ 09,03 say "<F1>    "
@ 10,03 say " Help   "
@ 11,03 say "        "
@ 12,03 say "<F2>    "
@ 13,03 say " Modos  "
@ 14,03 say "        "
@ 15,03 say "<F3>    "
@ 16,03 say " Imprime"
@ 17,03 say "        "
@ 18,03 say "<F4>    "
@ 19,03 SAY "Consulta"
set color to
C=3
* - ITENS DO MENU PRINCIPAL
ITEM1= [ Palavras ]
ITEM2= [  Verbos  ]
ITEM3= [Expressoes]
ITEM4= [Utilitario]
ITEM5= [   Help   ]
ITEM6= [   Sair   ]
********************
* VETORES

* VETOR1
DECLARE MMENU1[2]
MMENU1[1] =  "Manuten‡„o"
MMENU1[2] =  "Consultar "
declare mop1[2]
mop1[1] = .t.
mop1[2] = .t.

* VETOR 2
DECLARE MMENU2[2]
MMENU2[1] =  "Manuten‡„o"
MMENU2[2] =  "Consultar "
declare mop2[2]
mop2[1] = .t.
mop2[2] = .t.

* VETOR 3
DECLARE MMENU3[2]
MMENU3[1] =  "Manuten‡„o"
MMENU3[2] =  "Consultar "
declare mop3[2]
mop3[1] = .t.
mop3[2] = .t.

* VETOR 4
 DECLARE MMENU4[5]
MMENU4[1] =  " Espa‡o de Disco    "
mmenu4[2] =  " Roda DOS           "
mmenu4[3] =  " Anota‡”es          "
mmenu4[4] =  " Faz Backup Do Sist "
declare mop4[4]
mop4[1] = .t.
Mop4[2] = .t.
mop4[3] = .t.
mop4[4] = .t.

* VETOR 5
declare mmenu5[2]
mmenu5[1] = "   Ajuda Geral    "
mmenu5[2] = "Sobre o Dicion rio"
declare mop5[2]
mop5[1]= .t.
mop5[2]= .t.

* VETOR 6
DECLARE MMENU6[1]
MMENU6[1] = "  Sair"
DECLARE MOP6[1]
MOP6[1] = .T.

*********************
do while op<>12
   tecla=lastkey()
   @ 01,03 SAY ITEM1
   @ 01,15 SAY ITEM2
   @ 01,27 SAY ITEM3
   @ 01,39 SAY ITEM4
   @ 01,51 SAY ITEM5
   @ 01,63 SAY ITEM6
   INVERSO='ITEM'+STR(OP,1,1)
   SET COLOR TO N/R
   @ 1,C SAY &INVERSO
   SET COLOR TO
   set color to w/Wn+,N/B
   DO CASE
      CASE OP=1
	   SAVE SCREEN TO TELA
	   SOMBRA(02,03,05,14,.f.)
	   ac1=achoice(03,04,05,13,MMENU1,mop1,"controle",ac1)
	   tecla=lastkey()
	   IF AC1<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC1=1
	      DO MANUPAL
	   ELSEIF AC1=2
	      do CONSPAL
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=2
	   SAVE SCREEN TO TELA
	   SOMBRA(02,15,05,26,.f.)
	   ac2=achoice(03,16,05,25,MMENU2,mop2,"controle",ac2)
	   tecla=lastkey()
	   IF AC2<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC2=1
	      DO MANUVER
	   ELSEIF AC2=2
	      DO CONSVER
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=3
	   SAVE SCREEN TO TELA
	   SOMBRA(02,27,05,39,.f.)
	   ac3=achoice(03,28,05,38,MMENU3,mop3,"controle",ac3)
	   tecla=lastkey()
	   IF AC3<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC3=1
	      DO MANUEXP
	   ELSEIF AC3=2
	      dO CONSEXP
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=4
	   SAVE SCREEN TO TELA
	   SOMBRA(02,39,07,59,.f.)
	   ac4=achoice(03,40,06,58,MMENU4,mop4,"controle",ac4)
	   tecla=lastkey()
	   IF AC4<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC4=1
	      do espaco
	   elseIF AC4=2
	      do rodados
	   elseif ac4=3
	      do anotar
	   elseif ac4=4
	      do copseg
	   ENDIF
	   RESTORE SCREEN FROM TELA
      case op=5
	   SAVE SCREEN TO TELA
	   SOMBRA(02,51,05,70,.f.)
	   ac5=achoice(03,52,05,69,mmenu5,mop5,"controle",ac5)
	   tecla=lastkey()
	   IF AC5<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   if ac5=1
	      do SOCORRO
	   elseif ac5=2
	      do direitos
	   endif
	   RESTORE SCREEN FROM TELA
      CASE OP=6
	   SAVE SCREEN TO TELA
	   SOMBRA(02,63,04,72,.f.)
	   AC6=ACHOICE(03,64,03,71,MMENU6,mop6,"controle",ac6)
	   tecla=lastkey()
	   IF AC6<>0
	      SET COLOR TO  bg/n,w/r
	   ENDIF
	   IF AC6=1
	      SAI()
	   ENDIF
	   RESTORE SCREEN FROM TELA
   endcase
   do CASE
      case tecla=27
	  op=6
	  c=63
	  KEYBOARD CHR(13)
      case tecla=4
	   op=op+1
	   C=C+12
	  if op>6 .OR. C>63
	     op=1
	     C=3
	  endif
     case tecla=19
	  op=op-1
	  C=C-12
	  if op<1 .OR. C<3
	     op=6
	     C=63
	  endif
   endcase
   SET COLOR TO W/N
   NORMAL='ITEM'+ STR(OP,1,1)
   @ 1,C SAY &NORMAL
   SET COLOR TO N/W
   IVERSO='ITEM'+STR(OP,1,1)
   @ 1,C SAY &INVERSO
   SET COLOR TO
   tecla=lastkey()
ENDDO

***********************************
procedure banco
save screen to tela_te2
do editadbf
restore screen from tela_te2
return
*****************************
procedure imp
save screen to tela_te2
do imprime
restore screen from tela_te2
return
***********************************
