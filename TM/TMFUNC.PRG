****************************************************
procedure sai
if confirma("Deseja Realmente Sair ?")
   set color to r+/w*
   @ 23,10 say "Aguarde... Reindexando Arquivos..."
   use tmbcli index tmicli1
   pack
   reindex
   use tmbfun index tmifun
   pack
   reindex
   use tmbfor  index tmifor
   pack
   reindex
   use tmbest  index tmiest
   pack
   reindex
   use tmbrest index tmiest2
   pack
   reindex
   use tmbbest index tmiest1
   pack
   reindex
   close all
   set color to
   @ 23,10 say "Retorno ao Sistema Operacional...."
   inkey(.7)
   for i=0 to 40
       @ 00,i clear to 24,i
       @ 00,79-i clear to 24,79-i
       inkey(0.01)
   next
   Restore screeN from tela_dos
   @ linha,coluna
   CLOSE ALL
   clear memory
   QUIT
   CANCEL
ENDIF
RETURN
RESTORE SCREEN FROM TELA

***********************************************************
* procedure que alerta que o modulo selecionado nao e' disponivel
function modulo
save screen to t_mod
parameters lin1, colu1
sombra(lin1,colu1,lin1+2,colu1+21,.t.)
@ lin1,colu1 to lin1+2,colu1+21
@ lin1+1,colu1+1 say "Modulo Nao Residente"
inkey (0)
restore screen from t_mod

*******************************************************
* procedure para realizar o efeito de sombra

PROCEDURE SOMBRA
parameters x1, y1, x2, y2, sam
PRIVATE cororig, x1, x2,y1,y2, sam
if empty(sam)
   sam=.f.
endif
cororig= setcolor()
if sam
   SET COLOR TO w/n
   for i=x1 to x2
       @ x1,y1 clear to i,y2
       set color to gr+/b
       @ x1,y1 to i, y2
       border(x1,y1+1,i,y2)
       set color to
       inkey(.05)
   next
   tone (130,1)
   set color to &cororig
else
   set color to
   @ X1+1,Y1+1 CLEAR TO X2-1,Y2-1
   border(x1,y1+1,x2,y2)
   set color to &cororig
   @ x1,y1 to x2,y2
endif
set color to &cororig
RETURN
****************************************
* continuacao da funcao SOMBRA
function shadow
private corf, corb, y, x, y2, x2, atr, nlen, svt, tmp,
parameters y, x, y2, x2, corf, corb
if type([y])+type([x])+type([y2])+type([x2])<>"NNNN" .or. y < 0 .or. x < 0 .or. y2 > 24 .or. x2 > 79
   return .f.
endif
if y > y2
   swap(@y,@y2)
endif
if x > x2
   swap(@x,@x2)
endif
corf=if(type([corf])="U",8,min(corf,15))
corb=if(type([corb])="U",0,min(corb,15))
atr=(corb*16)+corf
nlen=(x2-x+1)*(y2-y+1)+(x2-x)
if nlen>960
   return .f.
endif
svt=savescreen(y,x,y2,x2)
restscreen(y,x,y2,x2,transform(svt,replicate([x]+chr(atr),nlen)))
return .t.

********************
* continuacao da funcao SHADOW
function border
private l, c, l2, c2, frt
parameters l, c, l2, c2, frt
if type([l])+type([c])+type([l2])+type([c2])<>"NNNN" .or. l < 0 .or. c < 0 .or. l2 > 24 .or. c2 > 77
   return .f.
endif
if l > l2
   swap(@l,@l2)
endif
if c > c2
   swap(@c,@c2)
endif
frt=if(type([frt])="U",8,min(frt,15))
shadow(l+1,c2+1,l2+1,c2+2,frt)
shadow(l2+1,c+1,l2+1,c2+2,frt)
return .t.
******************
* continuacao da funcao BORDER
function swap
private par1, par2, temp
parameters par1, par2
temp=par1
par1=par2
par2=temp
return .t.

******************************************
* funcao de controle para a funcao ACHOICE
function controle
save screen to tela_te
parameters modo, elto, pos
do case
   case modo=4
	ret=0
   case modo=3
	if lastkey()=27
	    ret=0
	elseif lastkey()=13
	    ret=1
	elseif lastkey()=28
	    ret=0
	elseif lastkey()=4  
	    ret=0
	elseif lastkey()=19
	    ret=0
	elseif LASTKEY()=-9
	    ret=0
	else
	    ret=2
	endif
   case modo=2
	keyboard chr(31)
	ret=2
   case modo=1
	keyboard chr(30)
	ret=2
   case modo=0
	ret=2
endcase
restore screen from tela_te
tecla=lastkey()
return(ret)

****************************
 function   Confirma
****************************
Parameters TEXTO
save screen to tela_ant
cor = setcolor()
SET COLOR TO
NUMERO = LEN(TEXTO)+2
CI = (80 - NUMERO)/2
set color to gr+/b
SOMBRA(12,CI,15,CI+NUMERO,.F.)
set color to r/n
@ 13,CI+1 SAY TEXTO
SET COLOR TO
var = 0
@ 14,35 PROMPT " Sim "
@ 14,41 PROMPT " Nao "
menu to var
setcolor(cor)
restore screen from tela_ant
IF var=1
   RETURN .T.
ENDIF
RETURN .F.

**********************************************************************
* procedure que tem por finalidade fazer uma tabela com os codigos
* e nomes para a escolha.
FUNCTION TABELA
****************************
DECLARE VCAMP[2]
PUBLIC  L, NUMERO, COR_DB,
VCAMP[1] = FIELDNAME(1)
VCAMP[2] = FIELDNAME(2)
DECLARE VMASC[2]
VMASC[1] = "@!"
VMASC[2] = "@!"
DECLARE VCAB[2]
VCAB[1] = "CODIGO"
VCAB[2] = "NOME"
SAVE SCREEN TO TELANT
GO TOP
sombra(7,10,20,73,.f.)
numero=RECCOUNT()/10
ax=1
cv=1
l=8
COR_DB=SETCOLOR()
desbarr(08,19,73,1)
DBEDIT(08,11,19,71,VCAMP,"FUNDB",VMASC,VCAB,.T.,.T.,.T.)
RESTORE SCREEN FROM TELANT
IF PCOUNT()<>0
   CONTEUDO = FIELDNAME(1)   
   RETURN &CONTEUDO
ENDIF

********************************
FUNCTION FUNDB
********************************
PARAMETERS MODO, NUM_ELT
SET COLOR TO &COR_DB
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
   IF LASTKEY()=24
      desbarr(08,19,73,0)
      ax=mov_bai(l,cv,numero,73,18)
      cv=ax
      RETURN 1
   ELSEIF LASTKEY()=5
      desbarr(08,19,73,0)
      ax=mov_cim(l,cv,numero,73,08)
      cv=ax
      RETURN 1
   endif
   return 1
ELSEIF MODO=3
   RETURN 0
ELSEIF MODO=2
   l=18
   cv=numero-1
   desbarr(08,19,73,2)
   RETURN 1
ELSEIF MODO=1
   l=9
   cv=1
   desbarr(08,19,73,1)
   return 1
endif

*********************************************
* FUNCAO DO MENU DE MANUTENCAO (ALTERA, EXCLUI, RETORNA)

FUNCTION ALTER
private cor
save screen
COR=SETCOLOR()
SET COLOR TO GR+/B
sombra(19,35,22,61,.f.)
SET COLOR TO R/N
@ 20,36 SAY "Codigo Ja Cadastrado!"
SET COLOR TO
ESCOLHA=0
@ 21,37 PROMPT "Altera "
@ 21,45 PROMPT "Exclui "
@ 21,53 PROMPT "Retorna"
MENU TO ESCOLHA
restore screen
SET COLOR to &COR
RETURN ESCOLHA

**********************************************
* Funcao de consulta do dbedit(consulta)
function consulta
SET COLOR TO CORC
parameters modo,indice
if modo = 4
   if lastkey() = 27
      ret =  0
   ELSE
      ret  = 1
   endif
elseif modo = 0
   if lastkey()=24
      desbarr(07,19,76,0)
      ax=mov_bai(L,CV,NUMERO,76,19)
      CV=AX
      RET =  1
   elseif lastkey()=5
      desbarr(07,19,76,0)
      ax=mov_CIM(L,CV,NUMERO,76,07)
      CV=AX
      RET =  1
   endif
   ret = 1
elsEIF MODO = 2
   l=19
   cv=numero-1
   DESBARR(07,19,76,2)
   ret =1
ELSEIF MODO = 1
   l=8
   cv=1
   DESBARR(07,19,76,1)
   ret= 1
else 
   ret = 1
endif
return ret
********************************
* procedure que desenha a barra vertical

procedure desbarr
parameters lin_i, lin_f, col_i, car
if car <> 0
   FOR I = lin_i TO lin_f
       @ I,col_i SAY CHR(176)
   NEXT
endif
@ lin_i,col_i SAY CHR(24)
@ lin_f,col_i SAY CHR(25)
if car=1
   SET COLOR TO GR+/N
   @ lin_i+1,col_i sAY CHR(219)
   SET COLOR TO &COR_DB
elseif car=2
   SET COLOR TO GR+/N
   @ lin_f-1,col_i sAY CHR(219)
   SET COLOR TO &COR_DB
endif
return

*****************************************************
* procedure que move o cursor p/ baixo
function mov_bai
parameters lin, nvez, nrec, col_c, lin_ini
public lin
nvez=nvez+1
IF nvez = nrec .or. nvez > nrec
   nvez=0
   Lin=Lin+1
   IF Lin >= lin_ini
      Lin=Lin-1
   ENDIF
   COR=SETCOLOR()
   @ Lin-1,col_c SAY CHR(176)
   SET COLOR TO GR+/N
   @ Lin,col_c SAY CHR(219)
   SET COLOR TO &COR
ENDIF
l=lin
return nvez

**********************9*******************************
* procedure que move o cursor p/ cima
function mov_cim
parameters lin,cnvez,cnrec,ccol_c,clin_fim
public lin
cnvez=cnvez-1
IF cnvez = 0 .or. cnvez < 0
   cnvez=cnrec
   Lin=Lin-1
   IF Lin <= clin_fim
      Lin=Lin+1
   ENDIF
   COR=SETCOLOR()
   @ Lin+1,ccol_c SAY CHR(176)
   SET COLOR TO GR+/N
   @ Lin,ccol_c SAY CHR(219)
   SET COLOR TO &COR    
ENDIF
l=lin
return cnvez

*********************************************
* funcao para @ __,__  GET <VAR> VALID <CODICAO>
* onde a condicao e uma funcao de usuario que procura
* a chave no arquivo, se encontrar, retorna verdadeiro e sai
* do GET VALID
**********************************************
function achacod
parameters codigo
seek codigo
if .not. found() .or. empty(codigo)
   @ 19,15 say "Codigo Inexistente; Pressione Algo..."
   inkey(3)
   @ 19,15 say "                                     "
   return(.f.)
endif
return(.t.)

*****************************************************
* funcao que perite a edicao de campos do tipo memo
* para registrar observacoes sobre os clientes
FUNCTION obser
IF PCOUNT()=2
   parameters mdo,M2
ELSE
   PARAMETERS MDO
   M2=.F.
endif
save screen to obs
@ 09,23 to 22,62
sombra(09,23,22,62,.f.)
@ 09,30 say "º Observa‡”es º"
if mdo
   IF M2
      nota=MOBS2
   ELSE
      NOTA=BOBS
   ENDIF
    @ 21,24 SAY "^W Grava; ^Y Apaga Linha; <ESC> Sai"
   @ 21,59 say space(03)
   MOBS=memoedit(nota,10,24,20,61,.t.)
   restore screen from obs
else
   nota=bobs
   @ 21,25 SAY " <ESC> Sai"
   set cursor off
   MOBS2=memoedit(nota,10,24,20,61,.f.)
   tel_=savescreen(10,24,20,61)
   IF LASTKEY() = 27
      MOBS=BOBS
      restscreen(10,24,20,61,tel_)
      set cursor on
   ENDIF
   set cursor on
   restscreen(10,24,20,61,tel_)
endif

RETURN MOBS

*************************************************
* procedure que verifica se ha pagamentos para receber
* no dia
PROCEDURE VERI_AGD
USE TMBAGEN
SET FILTER TO DTPG=DATA_SIS
GO TOP
IF .NOT. EOF()
   SOMBRA(11,12,13,57,.F.)
   @ 12,13 SAY "Existem cobrancas p/ serem efetuadas hoje!!"
   inkey(3)
   if confirma("Fazer consulta de cobrancas ?")
      public cv, l
      l = 7
      cv=1
      do tmconagd
   endif
endif

*********************************************
* VERIFICACAO DO DIA, SE DIA 1§ MANDA IMPRIMIR OS RELATORIOS
* E LIMPA OS DBFS

PROCEDURE VERI_DIA
SAVE SCREEN TO TELA_VER
IF VAZIOS=0
   set key -4 to
   RETURN
ENDIF
IF DAY(DATA_SIS)<>1
   set key -4 to
   RETURN
ENDIF
VAZ=ARQ_VAZIO()
IF  .NOT. VAZ
   set key -4 to
   RETURN
ENDIF
SET KEY -4 TO LIMPA_DBF()
SOMBRA(11,15,15,70,.F.)
@ 12,16 SAY "1§ DIA DO MES, IMPRIMA OS RELATORIOS DO MES ANTERIOR"
@ 13,16 SAY "E PRESSIONE <F5> PARA LIMPAR OS ARQUIVOS"
@ 14,16 SAY " Pressione algo..."
INKEY(0)
RESTORE SCREEN FROM TELA_VER


***********************************************
* funcao que verifica se os arquivos de   cruzamentos
* de dados estao vazios
FUNCTION ARQ_VAZIO
CONTA=0
USE TMBLCD
IF RECCOUNT()<>0
   CONTA=CONTA+1
ENDIF
USE TMBLMC
IF RECCOUNT()<>0
   CONTA=CONTA+1
ENDIF
USE TMBBEST
IF RECCOUNT()<>0
   CONTA=CONTA+1
ENDIF
USE TMBREST
IF RECCOUNT()<>0
   CONTA=CONTA+1
ENDIF
USE TMBREP
IF RECCOUNT()<>0
   CONTA=CONTA+1
ENDIF
USE TMBVEND
IF RECCOUNT()<>0
   CONTA=CONTA+1
ENDIF
CLOSE ALL
IF CONTA = 0
   RETURN .F.
ENDIF
RETURN .T.

****************************************************
* procedure que limpa os arquivos de cruzamento de dados
*
PROCEDURE LIMPA_DBF
SAVE SCREEN TO TELA_LIM
IF CONFIRMA("Ja foram impressos TODOS os relatorios ?")
   IF CONFIRMA("Limpa os arquivos ?")
      VAZIOS = 0
      USE TMBBEST
      ZAP
      USE TMBREST
      ZAP
      USE TMBREP
      ZAP
      USE TMBVEND
      ZAP
   ENDIF
ENDIF
RESTORE SCREEN FROM TELA_LIM
RETURN

*************************************************
* procedure que faz o cabecalho do relatorios
* parametros :
* texto = titulo do cabecalho.
* pag   = numero da pagina do relatorio
* tr    = tipo do relatorio; se (.t.) = impressora ; (.f.) = tela
* exemplo : cabecalho("Relatorio mensal de assassinatos",p,.t.)
******************************************************************

PROCEDURE CABECALHO
PARAMETERS TEXTO,PAG,TR
IF .NOT. TR
   IF PAG<>1
      INKEY(0)
    ENDIF
    CLEAR
ENDIF
@ 1,0 SAY REPLICATE ("=",80)
@ 2,33 SAY "SISTEMA TECMAQ"
CENTRA(3,TEXTO)
@ 4,2 SAY "DATA: "+ DTOC(DATA_SIS)
@ 4,70 SAY "PAG: "+STR(PAG,3,0)
@ 5,0 SAY REPLICATE("=",80)

**************************************
* procedure que centraliza a mensagem (txt)
* na linha (lh)
PROCEDURE CENTRA
PARAMETERS LH,TXT
CL = INT((80-LEN(TXT))/2)
@ LH,CL SAY TXT
RETURN

****************************************************
* funcao de controle para o dbedit(consulta)
FUNCTION CONSULTAR
****************************************************
PARAMETERS MODO, INDICE
set color to &cor_db
IF MODO = 4
   IF LASTKEY() = 27
      RETURN 0
   ELSE
      RETURN 1
   ENDIF
elseIF MODO=3
   @ 12,25 SAY "Arquivo vazio !! "
   inkey(4)
   return 0
elseif modo = 0
   if lastkey()=24
      desbarr(07,19,70,0)
      ax=mov_bai(L,CV,NUMERO,70,19)
      CV=AX
      RETurn   1
   elseif lastkey()=5
      desbarr(07,19,70,0)
      ax=mov_CIM(L,CV,NUMERO,70,07)
      CV=AX
      RETurn   1
   endif
   return 1
elsEIF MODO = 2
   l=19
   cv=numero-1
   DESBARR(07,19,70,2)
   return 1
ELSEIF MODO = 1
   l=8
   cv=1
   DESBARR(07,19,70,1)
   return  1
else 
   return 1
endif

****************************************************
* funcao de controle para o dbedit (exclusao)
FUNCTION EXCLUIR
****************************************************
PARAMETERS MODO, INDICE
IF MODO = 4
   IF LASTKEY() = 13
      IF CONFIRMA("PAGAMENTO EFETUADO ?")
	 MVAL= VALOR
	 SELE 2
	 APPEND BLANK
	 REPLACE VALOR WITH  MVAL
	 REPLACE TIPO  WITH "C"
	 REPLACE DESC  WITH "RECEBIMENTO DE CONTA"
	 SELE 1
	 DELE
	 PACK
	 RETURN 0
      ENDIF
      RETURN 1
   ELSEIF LASTKEY() = 27
      RETURN 0
   ELSE
      RETURN 1
   ENDIF
elseif modo = 0
   if lastkey()=24
      desbarr(07,19,70,0)
      ax=mov_bai(L,CV,NUMERO,70,19)
      CV=AX
      RETurn   1
   elseif lastkey()=5
      desbarr(07,19,70,0)
      ax=mov_CIM(L,CV,NUMERO,70,07)
      CV=AX
      RETurn   1
   endif
   return 1
elsEIF MODO = 2
   l=19
   cv=numero-1
   DESBARR(07,19,70,2)
   return 1
ELSEIF MODO = 1
   l=8
   cv=1
   DESBARR(07,19,70,1)
   return  1
ELSEIF MODO=3
   @ 12,25 SAY "N„o h  cobran‡as para serem efetuadas"
   inkey(4)
   return 0
ELSE
   RETURN 1
ENDIF

****************************************************
* funcao de controle para o dbedit(consulta)
FUNCTION CONSUL
****************************************************
PARAMETERS MODO, INDICE
set color to &cor_db
IF MODO = 4
   IF LASTKEY() = 27
      RETURN 0
   ELSE
      RETURN 1
   ENDIF
elseIF MODO=3
   @ 12,25 SAY "Arquivo vazio !! "
   inkey(4)
   return 0
elseif modo = 0
   if lastkey()=24
      desbarr(04,20,77,0)
      ax=mov_bai(L,CV,NUMERO,77,20)
      CV=AX
      RETurn   1
   elseif lastkey()=5
      desbarr(04,20,77,0)
      ax=mov_CIM(L,CV,NUMERO,77,04)
      CV=AX
      RETurn   1
   endif
   return 1
elsEIF MODO = 2
   l=20
   cv=numero-1
   DESBARR(04,20,77,2)
   return 1
ELSEIF MODO = 1
   l=4
   cv=1
   DESBARR(04,20,77,1)
   return  1
else 
   return 1
endif

*****************************************************
* FUNCAO PARA A VERIFICACAO DO DIA, SE E UTIL OU NAO
FUNCTION DIA_UTIL
parameters data_c
IF LASTKEY()=5
   RETURN .F.
ENDIF
DECLARE DIAS[7]
DIAS[1] = "Domingo"
DIAS[2] = "Segunda- Feira"
DIAS[3] = "Ter‡a-Feira"
DIAS[4] = "Quarta-Feira"
DIAS[5] = "Quinta-Feira"
DIAS[6] = "Sexta-Feira"
DIAS[7] = "S bado"
DIA=DOW(DATA_C)
@ row(),col()+2 say dias[DIA]
if dow(data_c) = 1 .or. dow(data_c) = 7
   return .f.
endif
return .t.
* eop TMFUNC.prg