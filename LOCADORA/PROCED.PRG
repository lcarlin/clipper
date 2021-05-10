******************************************************
*                                                    *
* PROGRAMA: PROCED.PRG                               *
* FINALIDADE: PROCEDURES - SISTEMA LOCADORA          *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 17/06/92                                     *
*                                                    *
******************************************************

Function QUADRO
Q1 = chr(218)+chr(196)+chr(191)+chr(179)+chr(217)+;
     chr(196)+chr(192)+chr(179)+chr(176) 
Q2 = chr(201)+chr(205)+chr(187)+chr(186)+chr(188)+;
     chr(205)+chr(200)+chr(186)+chr(176)          
Q3 = chr(218)+chr(196)+chr(191)+chr(179)+chr(217)+;
     chr(196)+chr(192)+chr(179)+chr(255) 
Q4 = chr(201)+chr(205)+chr(187)+chr(186)+chr(188)+;
     chr(205)+chr(200)+chr(186)+chr(255)          
Q5 = chr(255)+chr(255)+chr(255)+chr(255)+chr(255)+;
     chr(255)+chr(255)+chr(255)+chr(255) 
return(.T.)

function MENSAGEM
parameters MENSA
set color to w/n+,w/n
AUX1 = len(MENSA)
AUX2 = int(79-AUX1)/2
MENSA = space(AUX2)+MENSA
@ 23,00 clear
@ 22,00 say ' '
wait MENSA
@ 23,00 clear
set color to 
return(.T.)

function MOSTRA
parameters MENSA
AUX1 = len(MENSA)
AUX2 = int(79-AUX1)/2
MENSA = space(AUX2)+MENSA
set color to w/n+,w/n
@ 23,00 clear
@ 23,01 say MENSA
set color to
return(.T.)

function CONFIRMA
MCONF = ' '
set color to w/n+,w/n+
@ 23,00 clear
@ 23,31 say 'Confirma ? (S/N) 'get MCONF pict '@!' valid MCONF $('SN') 
read
@ 23,00 clear
set color to
return(.T.)

function CONTINUA
MCON = ' '
set color to w/n+,w/n+
@ 23,00 clear
@ 23,31 say 'Outro filme ? (S/N) 'get MCON pict '@!' valid MCON $('SN') 
read
@ 23,00 clear
set color to
return(.T.)

function TCLIENTES
@ 09,02 clear to 21,78
@ 09,08 say "Codigo ..: " 
@ 10,08 say "Nome ....: " 
@ 11,08 say "Endereco : " 
@ 12,08 say "Bairro ..:                   Telefone ..: "
@ 13,08 say "Cidade ..:                   Estado ....:      Cep ..: "
return(.T.)

procedure TFILMES
@ 07,02 clear to 18,78
@ 09,08 say "Numero da fita ............: " 
@ 10,08 say "Nome do filme .............: " 
@ 11,08 say "Genero ....................: " 
@ 12,08 say "Data de aquisicao .........: " 
@ 13,08 say "Qualificacao ..............: " 
return

function CABECALHO
set date brit
PAG = PAG + 1
@ 01,01 say replicate ('=',79)
@ 03,01 say 'DATA:'
@ 03,pcol() + 1 say date()
@ 03,25 say chr(14)+chr(15)+'LOCADORA  MIL  FILMES  LTDA'+chr(18)+chr(20)
@ 04,01 say 'PAG: '+strzero(PAG,02)
@ 06,01 say replicate ('=',79)
set date american
return(.T.)

procedure COPIA
sele 3
copy to MOVIM_B fields CODF,NOMEF,QUANT
zap
return
