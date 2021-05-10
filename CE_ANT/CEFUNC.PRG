/* bop cefunc.prg
programa cefunc.prg
data     08/06/95
funcao   funcoes do sistema
autor    luiz antonio carlin
sistema  controle de estoque
linguagem clipper 5.01
*/
  
  
*******************************************
function controle
save screen to tela_te
parameters modo, elto, pos
do case
   case modo=4
	ret=3
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
	elseif lastkey() =-9
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
return(ret)


***********************************
procedure sai
TONE(250,1)
if confirma("Deseja realmente Sair")
   set color to r+/w*
   @ 23,10 say "Aguarde... Reindexando Arquivos..."

   USE cebcli INDEX ceicli
   pack
   REINDEX
   CLOSE ALL

   USE CEBCLI INDEX CEICLI2
   REINDEX
   CLOSE ALL

   USE cebfor INDEX ceifor
   pack
   REINDEX
   CLOSE ALL

   USE cebfor INDEX ceifor2
   REINDEX
   CLOSE ALL

   USE cebest INDEX ceiest
   PACK
   REINDEX
   CLOSE ALL

   USE CEBEST INDEX CEIEST2
   REINDEX
   CLOSE ALL

   USE CEBMEST INDEX CEIMEST
   PACK
   REINDEX
   CLOSE ALL

   USE CEBAGEN INDEX CEIAGEN
   PACK
   REINDEX
   CLOSE ALL

   USE cebped INDEX ceiped
   PACK
   REINDEX
   CLOSE ALL

   USE   ceborc INDEX ceiorc
   PACK
   REINDEX
   CLOSE ALL

   USE  cebpre INDEX ceipre
   PACK
   REINDEX
   CLOSE ALL

   USE cebpre INDEX ceipre2
   REINDEX
   CLOSE ALL

   @ 23,10 say "Retorno ao Sistema Operacional...."
   inkey(.7)
   SET COLOR TO
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


**********************************************************************
* procedure que tem por finalidade fazer uma tabela com os codigos
* e nomes para a escolha.
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
GO TOP
sombra(7,10,20,73)
COR_DB=SETCOLOR()
DBEDIT(08,11,19,71,VCAMP,"FUNDB",VMASC,VCAB,.T.,.T.,.T.)
RESTORE SCREEN FROM TELANT
setcolor(cor_db)
IF lastkey() = 13
   return 1
else
   RETURN 0
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
ELSE
   RETURN 1
endif


*****************************************************
* funcao que perite a edicao de campos do tipo memo
* para registrar observacoes sobre os clientes

FUNCTION obser
parameters mdo,nota
save screen to tobs
cor_memo := setcolor()
set color to bg/n
sombra(09,23,22,62,.f.)
@ 09,30 say "º Observa‡”es º"
if mdo
   @ 21,24 SAY "^W Grava; ^Y Apaga Linha; <ESC> Sai"
   @ 21,59 say space(03)
   set color to w/n
   MOBS=memoedit(nota,10,24,20,61,.t.)
   restore screen from tobs
else
   @ 21,25 SAY " <ESC> Sai"
   _CURSOR_AP := setcursor(0)
   tel_=savescreen(09,23,21,62)
   MOBS=memoedit(nota,10,24,20,61,.f.)
   setcursor(_cursor_ap)
   restscreen(10,24,20,61,tel_)
endif
restore screen from tobs
setcolor(cor_memo)
RETURN MOBS


FUNCTION ESTADOS (VAR_)
IF VAR_$"AC,Al,AM,AP,BA,CE,DF,ES,FN,GO,MA,MG,MS,MT,PA,PB,PE,PI,PR,RJ,RN,RO,RR,RS,RC,SE,SP,TO"
   RETURN .T.
ENDIF
RETURN .F.


**********************************************
* Funcao de consulta do dbedit(consulta)

function consulta (modo,_indice)
local  ret

if modo = 4
   if lastkey() = 27
      return  0
   ELSEIF lastkey() = 13
      cCampo := field(_indice)
      IF valtype(cCampo) = "M"
         obser(.f.,cCampo)
         return 1
      ENDIF
      return  1
   endif
elseif modo = 3
   mensagem ("Nao ha dados nesse arquivo!!")
   return 0
elseif modo = 2
   return 1
elseif modo = 1
   return 1
else   
   return 1
endif


*************************************
procedure Sobre
sombra(09,19,21,60)

restore from ce additive
@ 10,20 say "Controle de Estoque v1.0"
@ 11,20 say "Desenvolvido Por:"
@ 12,20 say "Luiz Antonio Carlin, 1995"
@ 14,20 say "Este Programa esta licenciado para"
@ 15,20 say l_Nome
@ 16,20 say l_empresa
@ 18,20 say "C:\"+curdir("C:")+" | "+os()
@ 19,20 say "Espaco :" +str(diskspace()) + " Bytes  Livres"
@ 20,20 say "Memoria:"+str(memory()) + " Kbytes livres"
inkey(0)
return


*************************************************
* HELP On Line
************************************
procedure help (prog, lin, var)

save screen to tela_hlp
COR_HLP := SETCOLOR("gr+/b")
CURSOR := SETCURSOR(0)
prog:=lower(prog)
prg:=substr(prog,1,2)
var:=lower(var)
BEGIN SEQUENCE
      if prg<>"ce"
         var_hlp := memoread("cehelp.hlp")
      else        
         arquivo=prog+".hlp"
         if .not. file(arquivo)
            mensagem("Ajuda Nao esta Disponivel")
            BREAK
         endif
         var_hlp := memoread(arquivo)
      endif
      sombra(11,07,13,36)
      ?prog
      ?? lin
      ??var
      @ 12,08 say "Aguarde! Pesquisando Ajuda." COLOR "r*/w"
      var := "# "+prog+" "+lower(var)
      posicao := 0
      acha := .t.
      if .not. empty(var_hlp)
         lin_tot := mlcount(var_hlp,39)
         do while acha
            if posicao = lin_tot
               mensagem("Ajuda nao esta disponivel")
               break
            endif
            posicao++
            if memoline(var_hlp,39,posicao) = var
               acha = .f.
            endif
         enddo
         if posicao=mlcount(Var_hlp,39)
            break
         endif
         posicao++
         socorro := " "
         do while substr(memoline(var_hlp,39,posicao,0,.t.),1,5) <>"# fim"
            if posicao = lin_tot
               mensagem("Ajuda nao esta disponivel")
               break
            endif
            socorro+=memoline(var_hlp,39,posicao)
            posicao++
         enddo
      endif
      sombra(10,03,20,44)
      @ 10,16 say " Ajuda "
      @ 20,10 say "<ESC> - Retorna"
      set key 28 to
      set color to w/n
      ajuda := memoedit(socorro,11,04,19,43,.f.,,39,0)
END
SETCURSOR(CURSOR)
setcolor(cor_hlp)
restore screen from tela_hlp
set key 28 to help
RETURN

*****************************************************
PROCEDURE GERA_AGD (nValor_tot, cTipo , cCod, cNomPes)
SAVE SCREEN TO sTela_ant
sombra(08,10,21,65)
@ 08,15 SAY "Inclusao na Agenda de "+if(cTipo="C","Recebimento","Pagamento")
nNpar :=  nAcPar := 0
@ 09,11 SAY "Numero de Parcelas:"
@ 10,11 SAY "Valor Total.......:"
@ 11,11 SAY "Data do "+if(cTipo="C","Receb.","Pagto ")
@ 11,30 say "Porcentagem"
@ 11,43 SAY "Valor da Parcela:"
@ 09,31 GET nNpar PICT "99" valid(nNpar>0)
@ 10,31 GET nValor_tot PICT "9,999,999.99" valid(nValor_tot>0)
READ
aMatPar := array(nNpar,3)
nL1 := 11
FOR IA := 1 TO nNpar
    aMatPar[ia][1] := CTOD("  /  /  ")
    aMatPar[ia][2] := 0
    @ nL1+IA,11 GET aMatPar[ia][1] PICT "99/99/99" VALID(DIA_UTIL(aMatPar[ia][1]))
    @ nL1+IA,38 GET aMatPar[ia][2] PICT if(nNpar=1,"999","99") valid(aMatPar[ia][2]>0 .AND.aMatPar[ia][2]+nAcPar<=100)
    READ
    nAcPar+=aMatPar[ia][2]
    aMatPar[ia][3] := (aMatPar[ia][2]*nValor_tot)/100
    @ nL1+iA,43 SAY  aMatPar[ia][3] 
    IF IA >= 9
       scroll(12,11,20,64,1,0)
       nL1--
    ENDIF
NEXT
FOR IB := 1 TO LEN(aMatPar)
    APPEND BLANK
    REPLACE VALOR    WITH aMatPar[ib][3]
    REPLACE DATA_PG  WITH aMatPar[ib][1] 
    REPLACE TIPO     WITH cTipo
    REPLACE CODIGO   WITH cCod
    REPLACE NOME_FOR WITH cNomPes
NEXT
RESTORE SCREEN FROM sTela_ant
RETURN

* eop cefunc.prg