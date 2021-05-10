****************************************************************************
* BOP CV_FUNC.PRG
* AUTORES   :  LUIZ/EVERTON/OSWALDO/WILSON
* DATA      :  10/05/94
* OBJETIVO  :  FUNCOES DO SISTEMA S.C.C.V.
*************************************************************************

**************************************************************************
function DISKspace
**************************************************************************
borda(08,20,10,30,"w/b")
@ 9,22 say "Espaco de Disco==>" + diskspace()
mensagem("",1)
return .t.

*************************************************************************
function CONSORcalc
*************************************************************************
set confirm on
borda(10,00,12,66,"w/b")
@ 11,12 say " 1  2  3  4  5  6  7  8  9  0  +  -  *  /  =  ^"
for i=12 to 67 step 3
    @ 10,i say "Â"
    @ 11,i say "³"
    @ 12,i say "Á"
next
sinal = " "
declare accalc [500], acsina[500]
j=0
result = 0
do while lastkey() <> 27
   do while lastkey() = 61
       j = j + 1
       calc = 0
       set confirm on
       @ 11,1 get calc pict "@E 9,999,999.99"
       set confirm off
       @ 11,14 get sinal pict "X"
       read
       accalc[j] = calc
       acsina[j] = sinal
   enddo
   for k = 1 to j
       result = result+acsina[k]+accalc[k]
   next
   @ 11,1 get result
   clear gets
   wait ""
enddo
set confirm off
return .t.

**************************************************************************
function Caber
***************************************************************************
PARAMETERS titulo1,titulo2,empresa,telimp
titulo1=TRIM(SUBSTR(titulo1,1,40))
titulo2=TRIM(SUBSTR(titulo2,1,40))
sistema="Sistema Concessionaria de Veiculos"
sist    = SPACE( ( 40 - LEN(sistema) ) / 2 ) + sistema
tit1    = SPACE( ( 40 - LEN(titulo1) ) / 2 ) + titulo1
tit2    = SPACE( ( 40 - LEN(titulo2) ) / 2 ) + titulo2
pg = pg + 1
telimp=.F.
if telimp
   SET PRINT ON
   ?? i10
   SET PRINT OFF
endif
@ 01, 01 SAY "Emissao:"
@ 01, 11 SAY DATE()
?? i12
@ 01, 66 SAY "Pagina No." + STR(pg,3)
@ 02, 0  SAY REPLICATE("=",80)
@ 03, 01 say  ia5+sist
@ 04, 01 say  ia5+tit1
?? id5
@ 05, 01 say  ia5+tit2
@ 06, 0 say REPLICATE("=",80)
ncol=80
RETURN .t.


********************
function   Meio
*********************
PARAMETERS TIT,LIN
@LIN,INT((80-LEN(TRIM(TIT)))/2) SAY  SPACE(LEN(TIT))
@LIN,INT((80-LEN(TRIM(TIT)))/2) SAY TIT
RETURN .T.


**********************
procedure  saida
**********************
save screen
borda(07,19,09,50)
tone(250,1)
clear gets
conf = " "
@8,20 say "Deseja Realmente Sair <S/N> " get conf pict "!" valid conf $ "SN"
read
if conf = "S"
   borda(14,10,18,70)
   set color to n/w
   @14,10 clear to 18,70
   @14,10 to 18,70
   set color to w/b
   meio("Reorganizando Arquivos, Aguarde !!!",15)
   @16,14 say replicate("°",50)
   @16,13 say "0"
   @16,64 say "100"
   set color to w/r+
   USE CVBFROTA INDEX CVIFRO1
   REINDEX
   for i=4 to 16
       @16,i+10 say "²"
       @17,13 say str(i*2,2,0)+"%"
   next
   USE CVBCLIEN INDEX CVIcli1
   pack
   REINDEX
   use cvalmox index cvialm1
   reindex
   use cvbforne index cvifor1
   pack
   Reindex
   use cvbpecas index cvipec1
   reindex
   for j=16 to 36
       @16,j+10 say "²"
       @17,13 say str(j*2,2,0)+"%"
   next
   use cvbfunc index cvifun1
   pack
   reindex
   use cvbgruco index cvigruc1
   reindex
   use cvbgrupo index cvigru1
   reindex
   use cvpecas index cvipec1
   reindex
   use cvbpecas index cvivpec1
   reindex
   use cvbgrupo index cvigru2
   reindex
   clear all
   for l=36 to 53
       @16,l+10 say "²"
       @17,13 say str((l*2)-3,3,0)+"%"
   next
   @18,17 say "Reorganizacao Completa !!!"
   set cursor on
   set color to
   BC_FIM(0)
   for k=1 to 24
       ? ""
   next
   cancel
endif
RESTORE SCREEN
RETURN

**********************
function    borda
**********************
IF PCOUNT() = 4
   COR="W/N"
   PARAMETERS LC,CC,LB,CB
ELSE
   PARAMETERS LC,CC,LB,CB,COR
ENDIF
CORATU = setcolor()
SET COLOR TO N+
@LC,CC CLEAR TO LB,CB
@LC+1,CC+2,LB+1,CB+2  box "         "
SET COLOR TO &CORATU
@ LC,CC TO LB,CB
RETURN .T.

************************
procedure  dos
************************
save screen to tel_dos
cor = setcolor()
set color to
set cursor on
clear
@ 01,00 say "Digite EXIT Para Retornar ao SCCV..."
!c:\command
set color to &cor
restore screen from tel_dos
return

*************************
function      Tela
*************************
parameters NUM
IF NUM < 10
   prog="MEN_T_"+ALLTRIM(STR(NUM,1,0))
   do &PROG
ELSE
   prog="MEN_T_"+ALLTRIM(STR(NUM,2,0))
   do &PROG
ENDIF
RETURN .T.

****************************
 function   Confirma
****************************
Parameters L,C,TEXTO
SN = " "
cor = setcolor()
set color to w/b
@ 23,13 say space(66)
@ 23,14 SAY TEXTO + " (S/N)?" GET SN PICT "!" VALID SN $ "SN"
READ
@ 23,13 say space(66)
setcolor(cor)
IF SN = "S"
   RETURN .T.
ELSE
   RETURN .F.
ENDIF

*****************************
FUNCTION MENSAGEM
****************************
IF PCOUNT() = 2
   PARAMETERS TEXTO,L
ELSE
   PARAMETERS TEXTO
   L = 23
ENDIF
cor = setcolor()
setcolor("w/b")
@23,23 SAY SPACE(64)
@23,14 say TEXTO + "! Pressione algo para continuar..."
INKEY(0)
@23,23 SAY SPACE(64)
setcolor(cor)
RETURN .T.

***************************
FUNCTION LIMPA
***********************
COR = SETCOLOR()
SET COLOR TO W/B
@ 23,12 SAY SPACE(67)
SET COLOR TO &COR.
return .t.

****************************
FUNCTION TABELA
****************************
DECLARE VCAMP[2]
VCAMP[1] = FIELDNAME(1)
VCAMP[2] = FIELDNAME(2)
DECLARE VMASC[2]
VMASC[1] = "@!"
VMASC[2] = "@!"
DECLARE VCAB[2]
VCAB[1] = "CODIGO"
VCAB[2] = "NOME"
SAVE SCREEN TO TELANT
BORDA(7,10,20,72,"W+/N")
goto top
DBEDIT(08,11,19,71,VCAMP,"FUNDB",VMASC,VCAB,.T.,.T.,.T.)
RESTORE SCREEN FROM TELANT
RETURN RECNO()

********************************
FUNCTION FUNDB
********************************
PARAMETERS MODO, NUM_ELT
IF MODO = 4
   IF LASTKEY() = 13
      vara="M"+fieldname(1)
      varb=fieldname(1)
      &vara=&varb
      RETURN 0
   ELSEIF LASTKEY() = 27
      RETURN 0
   ENDIF
ELSEIF MODO=0
   RETURN 1
ELSEIF MODO=3
   RETURN 0
ELSEIF MODO=2 .OR. MODO=1
   RETURN 1
ENDIF


********************************
FUNCTION FUNDBCON
********************************
PARAMETERS MODO, NUM
PESQ=0
IF MODO = 4
   IF LASTKEY() >= 48 .AND. LASTKEY() <=128
      RETURN 1
   ELSEIF LASTKEY() = -3
      SAVE SCREEN TO TELDB
      BORDA(9,24,11,44)
      @9,24 TO 11,44
      @10,25 SAY "Codigo....:" GET PESQ PICT "99999"
      READ
      IF LASTKEY() = 27
         RETURN 1
      ENDIF
      SEEK PESQ
      PESQ = 0
      IF ! FOUND()
         MENSAGEM("Codigo Nao Cadastrado ")
         INKEY(3)
         RESTORE SCREEN FROM TELDB
         RETURN 1
      ELSE
         RESTORE SCREEN FROM TELDB
      ENDIF
      RETURN 1
   ELSEIF LASTKEY() = 13
      IF TYPE(FIELD(NUM))="M"
         save screen
         OBSER(.F.,FIELD(NUM),.F.)
         RESTORE SCREEN
      ENDIF
      RETURN 1
   ELSEIF LASTKEY() = 27
      RETURN 0
   ENDIF
ELSEIF MODO=0
   RETURN 1
ELSEIF MODO=3
   MENSAGEM("Arquivo Vazio ")
   INKEY(3)
   RETURN 0
ELSEIF MODO=2 .OR. MODO=1
   RETURN 1
ENDIF

*************************************
function menu_con
*************************************
parameters LL, CL
VAR_CONS=0
BORDA(ll-1,cl-1,lL+2,cL+11,"w/bg")
@ Ll,CL PROMPT "  Geral   "
@ LL+1,CL PROMPT "Por codigo"
menu to  var_cons
if lastkey()=27
   var_cons=0
endif
return var_cons

*****************************************************
FUNCTION obser
*****************************************************
IF PCOUNT()=2
   parameters EDT,VARBAN
   EDT2=.T.
ELSE
   parameters EDT,VARBAN,EDT2
ENDIF
IF EDT
   texto=&VARBAN
   SET CURSOR ON
   @ 23,21 SAY "^W Grava; ^Y Apaga Linha; <ESC> Sai"
ELSE
   IF EDT2
      VARMEM="M"+upper(alltrim(VARBAN))
      TEXTO=&VARMEM
   ELSE
      texto=&VARBAN
   ENDIF
   set cursor off
   @ 23,20 SAY "<ESC> - Retorna"
ENDIF
@ 7,10 to 19,70
@ 7,32 SAY "´Oberva‡”esÃ"
aux=memoedit(texto,8,11,18,69,EDT)
if edt2
    SET CURSOR ON
endif
@ 23,21 SAY "                                   "
RETURN aux

****************************************************
PROCEDURE CABECALHO
****************************************************
PARAMETERS NP,TIPO
IF TIPO = 1
   TEXTO = "Relatorio de clientes"
ELSEIF TIPO = 2
   TEXTO = "Relatorio de consorciados"
ENDIF
@ 00,00 SAY REPLICATE ("_",80)
MEIO("S.C.C.V. - Sistema de Controle de Concessionaria de Veiculos",1)
@ 02,00 SAY "Data:"+dtoc(date())
MEIO(TEXTO,2)
@ 02,71 SAY "PAG:"+STR(NP,3,0)
@ 03,00 SAY REPLICATE ("_",80)
@ 04,00 SAY "CODIGO"
@ 04,08 SAY "NOME"
@ 04,44 SAY "TELEFONE"
@ 04,59 SAY "CIDADE"
RETURN


********************************************
FUNCTION OPREL
********************************************
PARAMETERS L,C
R = 0
BORDA(L,C,L+4,C+11)
@ L+1,C+1 PROMPT "   TELA   "
@ L+2,C+1 PROMPT "IMPRESSORA"
@ L+3,C+1 PROMPT " ETIQUETA "
MENU TO RET
RETURN RET


****************************************************
FUNCTION REL
****************************************************
PARAMETERS TIT
@ 1,0 TO 5,80
@ 2,25 SAY "FIAT  -  Fralleti  ltda."
@ 3,17 SAY "SCCV  -  Controle de Concessionaria e Veiculos"
@ 4,25 SAY "RELATORIO DE "+TIT
RETURN .F.
******************************************
FUNCTION  RG
******************************************
PARAMETERS ARQ
IF ARQ="CLI"
   @ 7,0  SAY "CODIGO"
   @ 7,8  SAY "NOME"
   @ 7,44 SAY "TELEFONE"
   @ 7,59 SAY "CIDADE"
ELSEIF ARQ="FUN"
   @ 7,0  SAY "CODIGO"
   @ 7,8  SAY "NOME"
   @ 7,48 SAY "SALARIO"
ELSEIF ARQ="FOR"
   @ 7,0 SAY "CODIGO"
   @ 7,8 SAY "DESCRICAO"
   @ 7,50 SAY "FABRICA"
ELSEIF ARQ="PEC"
   @ 7,0  SAY "CODIGO   "
   @ 7,8  SAY "DESCRICAO"
   @ 7,50 SAY "VALOR UNITARIO"
ELSEIF ARQ="FRO"
   @ 7,0  SAY "CODIGO"
   @ 7,8  SAY "DESCRICAO"
   @ 7,42 SAY "QUANTIDADE"
   @ 7,56 SAY "VALOR"
   @ 7,70 SAY "DATA"
ELSEIF ARQ="ALM"
   @ 7,0  SAY "CODIGO"
   @ 7,8  SAY "DESCRICAO"
   @ 7,48 SAY "QTD"
   @ 7,57 SAY "VALOR"
   @ 7,68 SAY "COD. FORNC."
ELSEIF ARQ="VPE"
   @ 7,0  SAY "COD. CLI."
   @ 7,10 SAY "DESCRICAO"
   @ 7,48 SAY "QUANTIDADE"
   @ 7,60 SAY "VALOR DA COMPRA"
ELSEIF ARQ="VRE"
   @ 7,0  SAY "COD. PEC. "
   @ 7,12 SAY "COD. CLI. "
   @ 7,24 SAY "QUANTIDADE"
   @ 7,36 SAY "DESCRICAO "
   @ 7,70 SAY "VALOR TOT."
ELSEIF ARQ="PRE"
   @ 7,0  SAY "COD.  CAR."
   @ 7,11 SAY "DESCRICAO "
   @ 7,42 SAY "VALOR CAR."
   @ 7,55 SAY "DATA. VEN."
   @ 7,66 SAY "COD.  CLI."
ENDIF
RETURN .T.
*****************************************************
proc rel_est
*****************************************************
save screen to tel
do while .t.
relest=0
@ 6,59  TO 10,72
@ 7,60  PROMPT "   Pecas    "
@ 8,60  PROMPT "   Frota    "
@ 9,60  PROMPT "Almoxarifado"
menu to relest
if lastkey()=27
    clear
    restore screen from tel
    do sccv
endif
if relest=1
   do cvrpecas
elseif  relest=2
   do cvrfrota
elseif relest=3
    do cvralm
else
close all
restore screen from tel
return
endif
enddo

