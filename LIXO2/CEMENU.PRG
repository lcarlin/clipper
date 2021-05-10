*****************************************************
* Bop CEMENU.PRG
* PROGRAMA  :  CEMENU.PRG
* SISTEMA   :  CONTROLE DE ESTOQUE
* AUTOR     :  " O Corsario"
* data      :  28/06/94
* linguagem : clipper 5.01
**********************************************
SET SCORE Off
#INCLUDE "CEDEFI.CH"
LINHA := ROW()
COLUNA:= COL()
SAVE SCREEN TO TELA_DOS
set escape off
set date  british
SET WRAP ON
set procedure to CEFUNC
set procedure to CEUTIL

/*
INDICES
*/
IF .NOT. FILE("CEIMAT1.NTX")
   USE CEBMAT
   INDEX ON CODMAT TO CEIMAT1
   CLOSE ALL
ENDIF
/*
ARQUIVOS
*/
SELE 1
USE CEBMAT INDEX CEIMAT1
/*
tela do menu principal
*/

QUADRO  := REPLICATE (CHR(178),8)
QUADRO2 := REPLICATE (CHR(176),9)
SET COLOR TO B/N
@ 00,00,24,79 BOX QUADRO
SET COLOR TO n/gb
@ 01,01,23,78 BOX QUADRO2
@ 00,01 SAY " Controle De Estoque; û 1.0 "
set color to



@ 01,03 clear to 03,76
* 01,02 to 03,75
* 01,02 say chr(195)
* 01,75 say chr(180)
sombra(01,03,03,75,.f.)
for i := 15 to 63 step 12
    @ 01, i say chr(194)
    @ 02, i say chr(179)
    @ 03, i say chr(193)
next
/*
VETORES
*/

// VETOR1
public mmenu1:= {"Manuten‡„o","Consultar ","Relatorios"}

// VETOR 2
public mmenu2:= {"Manuten‡„o","Consultar ","Relatorios"}

// VETOR 3
public mmenu3:= {" Inclus„o ","  Baixas  ","Relat¢rios"}

// VETOR 4
public mmenu4:= {" Manuten‡„o De Senhas"," Espaco De Disco     "," Comandos Do D.O.S.  "," Faz Backup Do Sist  "," Copia Arquivo       "}

// VETOR 5
public mmenu5:= {"   Ajuda Geral   "," Sobre o Sistema "}

// VETOR 6
public mmenu6:= {"  Sair"}

/*
variaveis do menu principal
*/

OP  := 1
C   :=  4

/*
ITENS DO MENU PRINCIPAL
*/

ITEM1:= [ Materiais]
ITEM2:= [ Clientes ]
ITEM3:= [Movimento ]
ITEM4:= [Utilitario]
ITEM5:= [   Help   ]
ITEM6:= [   Sair   ]
*********************

do while op<>12
   set color to rg+/w
   @ 02,04 SAY ITEM1
   @ 02,16 SAY ITEM2
   @ 02,28 SAY ITEM3
   @ 02,40 SAY ITEM4
   @ 02,52 SAY ITEM5
   @ 02,64 SAY ITEM6
   set color to
   INVERSO:='ITEM'+STR(OP,1,1)
   SET COLOR TO N/R
   @ 2,C SAY UPPER(&INVERSO)
   SET COLOR TO
   set color to w/Wn+,N/B
   DO CASE
      CASE OP=1
	   SAVE SCREEN TO TELA
	   SOMBRA(04,03,08,14,.f.)
	   ac1=ACHOICE(05,04,08,13,MMENU1,.T.,"controle")
	   IF AC1<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC1=1
              DO CEMTMAT
	   ELSEIF AC1=2
*             do CONSPAL
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=2
	   SAVE SCREEN TO TELA
	   SOMBRA(04,15,08,26,.f.)
	   ac2=ACHOICE(05,16,07,25,MMENU2,.T.,"controle")
	   IF AC2<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC2=1
*             DO MANUVER
	   ELSEIF AC2=2
*             DO CONSVER
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=3
	   SAVE SCREEN TO TELA
	   SOMBRA(04,27,08,39,.f.)
	   ac3=ACHOICE(05,28,07,38,MMENU3,.T.,"controle")
	   IF AC3<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC3=1
*             DO MANUEXP
	   ELSEIF AC3=2
*             dO CONSEXP
	   ENDIF
	   RESTORE SCREEN FROM TELA
      CASE OP=4
	   SAVE SCREEN TO TELA
	   SOMBRA(04,39,10,60,.f.)
	   ac4=ACHOICE(05,40,09,59,MMENU4,.T.,"controle")
	   IF AC4<>0
	      SET COLOR TO bg/n,w/r
	   ENDIF
	   IF AC4=1
	      do manutsen
	   elseIF AC4=2
	      do espaco
	   elseif ac4=3
	      do rodados
	   elseif ac4=4
	      do copseg
	   elseif ac4=5
	      do coparq
	   ENDIF
	   RESTORE SCREEN FROM TELA
      case op=5
	   SAVE SCREEN TO TELA
	   SOMBRA(04,51,07,70,.f.)
	   ac5=ACHOICE(05,52,07,69,mmenu5,.T.,"controle")
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
	   SOMBRA(04,63,06,72,.f.)
	   AC6 = ACHOICE (05,64,05,71,MMENU6,.T.,"controle")
	   IF AC6<>0
	      SET COLOR TO  bg/n,w/r
	   ENDIF
	   IF AC6=1
	      SAI()
	   ENDIF
	   RESTORE SCREEN FROM TELA
   endcase
   tecla:=lastkey()
   do CASE
      case ESC   //tecla=27
	  op := 6
	  c  := 64
	  KEYBOARD CHR(13)
      case tecla=4
	   op++
	   C=C+12
	  if op>6 .OR. C>64
	     op:=1
	     C:=4
	  endif
     case tecla=19
	  op--
	  C:=C-12
	  if op<1 .OR. C<3
	     op:=6
	     C:=64
	  endif
   endcase
   SET COLOR TO W/N
   NORMAL:='ITEM'+ STR(OP,1,1)
   @ 2,C SAY &NORMAL
   SET COLOR TO N/W
   IVERSO:='ITEM'+STR(OP,1,1)
   @ 2,C SAY &INVERSO
   SET COLOR TO
ENDDO

* EOP cemenu.prg