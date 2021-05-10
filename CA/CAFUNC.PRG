/* bop cafunc.prg
programa cafunc.prg
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

   USE cabcli INDEX caicli
   pack
   REINDEX
   CLOSE ALL

   USE CABCLI INDEX CAICLI2
   REINDEX
   CLOSE ALL

   USE cabest INDEX caiest
   PACK
   REINDEX
   CLOSE ALL

   USE CABEST INDEX CAIEST2
   REINDEX
   CLOSE ALL

   USE caBMEST INDEX caIMEST
   PACK
   REINDEX
   CLOSE ALL

   USE caBAGEN INDEX caIAGEN
   pack
   REINDEX
   CLOSE ALL

   USE cabcest
   PACK
   CLOSE ALL

   USE CABMEST INDEX CAIMEST
   PACK
   REINDEX
   CLOSE ALL

   USE CABLANCA
   PACK
   CLOSE ALL

   USE CABCUSTO
   PACK
   CLOSE ALL

   USE CABLMC
   PACK
   CLOSE ALL

   @ 23,10 say "Retorno ao Sistema Operacional...."
   inkey(.7)
   SET COLOR TO
/*
   for i=0 to 40
       @ 00,i clear to 24,i
       @ 00,79-i clear to 24,79-i
       inkey(0.01)
   next
*/
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
SETCOLOR(COR_DB)
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
set color to &cor_memo
RETURN MOBS


**********************************************
* Funcao de consulta do dbedit(consulta)

function consulta (modo,_indice)
local  ret

if modo = 4
   if lastkey() = 27
      return  0
   ELSEIF lastkey() = 13
      cCampo   := aVet_campos[_indice]
      IF valtype(&cCampo) = "M"
         obser(.f.,&cCampo)
         return 1
      ENDIF
      IF upper(alias())= "CABAGEN"
         nApCus := setcursor(1)
         cMascara := aVet_masc[_indice]
         @ row(),col() get &cCampo PICT cMascara
         READ
         setcursor(nApCus)
      ENDIF
      return  1
   ELSEIF lastkey() = -1
      SAVE SCREEN TO sTela_ant
      dAno := "  "
      dMes := "  "
      apre := setcursor(1)
      @ 21,15 say "Entre com a data (MM/AA)"
      @ 21,40 GET dMes PICT "99" valid(val(dMes) <= 12)
      @ 21,42 SAY "/" COLOR "N/W"
      @ 21,43 GET dAno PICT "99"
      READ
      RESTORE SCREEN FROM sTela_ant
      setcursor(apre)
      IF LASTKEY()=27
         RETURN 1
      ENDIF
      IF EMPTY(dMes) .or. Empty(dAno)
         SET FILTER TO
         GO TOP
         RETURN 2
      ELSE
         dat_fil := dMes+"/"+dAno
         cVar := if(alias()="CABMEST","DATA_NEG","DATA_COM")
         dbsetFilter({ || substr(dtoc(&cVar),4,8) = dat_fil })
         GO TOP
         RETURN 2
      ENDIF
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

**********************************************************************
function consulta2 (modo,_indice)
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
   ELSEIF lastkey() = -7
      sTela := savescreen(11,05,14,72)
      SOMBRA(11,05,13,69)
      cCusto := space(40)
      nCusto := 0
      cSit   := space(8)
      nCcusto := 0
      nDcusto := 0
      nTam   := 0
      nCursor := setcursor(1)
      @ 12,06 SAY "Entre com a Descricao:" GET cCusto PICT "@!"
      READ
      setcursor(nCursor)
      restscreen(11,05,14,72,sTela)
      IF lastkey() = 27 .OR. empty(cCusto)
         RETURN 1
      ENDIF
      nTam := len(alltrim(cCusto))
      SUM VALOR TO nDcusto FOR UPPER(substr(DESCRICAO,1,nTam))= alltrim(cCusto) .AND. TIPO="D" 
      SUM VALOR TO nCcusto FOR UPPER(substr(DESCRICAO,1,nTam))= alltrim(cCusto) .AND. TIPO="C" 
      nCusto := if(nCCusto>nDcusto,nCCusto-nDcusto,nDcusto-nCusto)
      cSit   := if(nCCusto>nDcusto,"Credito","Debito ")
*      dbsetfilter({|| DESCRICAO = alltrim(cCusto) }, "DESCRICAO = alltrim(cCusto)")
      go top
      SET FILTeR TO UPPER(substr(DESCRICAO,1,nTam)) = alltrim(cCusto)
      dbGOTOP()
      @ 23,08 SAY cCusto
      @ 23,COL()+2 SAY nCusto PICT "999,999,999.99"
      @ 23,col()+2 SAY cSit
      RETURN 2
   ELSEIF LASTKEY() = -8
      SET FILTER TO
      GO TOP
      @ 23,05 TO 23,75
      RETURN 2
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


*************************************************
* HELP On Line
************************************

procedure help (prog, lin, var)

save screen to tela_hlp
COR_HLP := SETCOLOR("gr+/b")
CURSOR := SETCURSOR(0)
prog:=lower(prog)
prg:=substr(prog,1,2)
BEGIN SEQUENCE
      if prg<>"ca"
         arquivo :="cahelp.hlp"
      else        
         arquivo=""+prog+".hlp"
      endif
      arquivo := upper(arquivo)
      if .not. file(arquivo)
         mensagem("Ajuda Nao esta Disponivel")
         BREAK
      endif
      var_hlp1 := memoread(arquivo)
      var_hlp := {}
      sombra(11,07,13,35)
      @ 12,08 say "Aguarde! Pesquisando Ajuda." COLOR "r*/w"
      FOR in_hlp :=1 to mlcount(var_hlp1,39)
          aadd(var_hlp,memoline(var_hlp1,39,in_hlp))
      next
      var := "# "+prog+" "+lower(var)
      posicao := 0
      acha := .t.
      nPosicao1 := 0
      nPosicao2 := 0
      nPosicao1 := ascan(var_hlp,var)
      IF nPosicao1 = 0
         mensagem("Ajuda nao esta disponivel")
         break
      endif
      nPOsicao2 := aScan(var_hlp,"# fim",nPosicao1)
      IF nPosicao2 = 0
         mensagem("Ajuda nao esta disponivel")
         break
      endif
      socorro :=""
      FOR ind2 := nPosicao1+1 TO nPosicao2 -1
          socorro+=var_hlp[ind2]
      next
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
***********************************************
procedure CACEAGD
/*
BOP CACEAGD.PRG
PROGRAMA   CACEAGD.PRG
DATA       07/07/95
AUTOR      LUIZ ANTONIO CARLIN
FUNCAO     CONSULTA/EXCLUSAO DA AGENDA
SISTEMA    CONTROLE DE ACOUGUES
LINGUAGEM  CLIPPER 5.01
*/

PARAMETERS TIPO_AGD

PUBLIC VETOR_CAMP, vetor_masc, cCampo, cMAscara
CLOSE ALL

SELE 1
USE CABAGEN  INDEX CAIAGEN

SELE 2
USE CABLANCA

SOMBRA( 04,01,22,77)
SELE 1
IF TIPO_AGD= 1
   cTitulo := "Exclusao de Recebimentos Agendados"
   SET FILTER TO TIPO = "V"
   GO TOP
ELSEIF TIPO_AGD = 2
   cTitulo := "Consulta da Agenda de Recebimentos"
   SET FILTER TO TIPO = "V"
   GO TOP
ELSEIF TIPO_AGD = 3
   cTitulo := "Pagamento de Dividas agendadas"
   SET FILTER TO TIPO = "C"
   GO TOP
ENDIF
VETOR_camp := {"Selec","codigo","Nome_FOR","Data_pg","Valor"}
VETOR_CAB  := {"Sel.","Codigo"," Cliente" ,"Data Pagto","Valor"}
VETOR_MASC := {"!","@!","@!","99/99/99","999,999.99"}
@ 04,20 SAY cTitulo
@ 19,05 SAY "<F2> - Pesquisa data/Limpa Pesquisa; <ENTER> - Edita"
@ 20,29 say IF(TIPO_AGD=1 .OR. TIPO_AGD=3 ,";<F4> - Efetua recebimento"," ")
@ 20,05 say if(tipo_agd=1.OR.  TIPO_AGD=3,"<F3> - Marca/descarca"," ")
dbedit(05,02,18,76,VETOR_CAMP,"CONS_agd",VETOR_MASC,VETOR_CAB,"Ä","³")
SET FILTER TO
CLOSE ALL
RELEASE ALL
RETURN

**********************************************
* Funcao de consulta do dbedit(consulta)

function cons_agd (modo,_indice)
local  ret
LOCAL dAno, dMes, dat_fil
if modo = 4
   if lastkey() = 27
      return  0
   ELSEIF lastkey() = -1
      SAVE SCREEN TO sTela_ant
      dAno := "  "
      dMes := "  "
      apre := setcursor(1)
      @ 21,15 say "Entre com a data (MM/AA)"
      @ 21,40 GET dMes PICT "99" valid(val(dMes) <= 12)
      @ 21,42 SAY "/" COLOR "N/W"
      @ 21,43 GET dAno PICT "99"
      READ
      RESTORE SCREEN FROM sTela_ant
      setcursor(apre)
      IF LASTKEY()=27
         RETURN 1
      ENDIF
      IF EMPTY(dMes) .or. Empty(dAno)
         IF TIPO_AGD = 3
           dbSetFilter({|| TIPO = "C" })
         ELSE
           SET FILTER TO
         ENDIF
         GO TOP
         RETURN 2
      ELSE
         dat_fil := dMes+"/"+dAno
         dbsetFilter({ || substr(dtoc(data_pg),4,8) = dat_fil .and. if(tipo_agd=3,tipo="C",) })
         GO TOP
         RETURN 2
      ENDIF
   ELSEIF lastkey() = -3
      IF TIPO_AGD= 1 .OR. TIPO_AGD=3
         IF confirma("Realizar o pagamento das dividas Marcadas ?")
            COUNT FOR SELEC = "S" TO PAGAR
            GO TOP
            IF PAGAR < 1
               MENSAGEM("Nao ha registros marcados!")
               RETURN 1
            ENDIF
            CLOSE 1
            nOp := 2
            USE CABAGEN
            IF tipo_agd = 3
               nPorcent := 0
               nDias    := 0
               aMatOpc  := array(3,3)
               aMatOpc  := {{13,16,"Parcial"},{13,26,"Integral"},{13,37,"Cancelar"}}
               sombra(11,15,15,55)
               @ 12,20 SAY "Tipo de Pagamento :"
               nOp      := botao(aMatOpc)
               IF nOp = 1
                   sombra(11,15,14,72)
                   nApre    := setcursor(1)
                   SET COLOR TO
                   @ 12,16 SAY "Entre com a porcentagem paga:" GET nPorcent PICTURE "999.99" valid (nPorcent <= 100)
                   @ 13,16 SAY "Entre com os dias de prazo para o restante da divida" GET nDias PICT "99" valid(nDias>0)
                   READ
                   setcursor(nApre)
                   IF lastkey() = 27 .OR. nPorcent = 0
                      RETURN 0
                    ENDIF
               ELSEIF nOp = 3 .OR. nOp = 0
                  RETURN 1
               ENDIF
            ENDIF
            aVetval := array(PAGAR,4)
            SET FILTER TO SELEC = "S"
            GO TOP
            I := 1
            DO WHILE .NOT. EOF()
               nValorAx:= Valor
               nValor1 := if(nOp=1,Valor-((Valor*nPorcent)/100),Valor)
               aVetVal[I][1] := if(tipo_agd=1,Valor,nValor1)
               aVetval[I][2] := if(tipo="V","Recebimento","Pagamento")+" de Divida Agendada-"+dtoc(data_pg)
               aVetval[I][3] := TIPO
               aVetval[i][4] := if(nOp=1,nValorAx-nValor1,nValorAx)
               cCodigo := CODIGO
               cNome   := NOME_FOR
               dDataPg := DATA_PG
               cTipoCar:= TIPO_CAR
               nQtd    := QTD_CAR
               IF (tipo_agd = 3 .AND. nOp = 1)
                  REPLACE VALOR   WITH aVetVal[I][1]
                  REPLACE DATA_PG WITH DATA_PG+nDias
                  REPLACE SELEC   WITH " "
               ELSE
                  DELETE
               ENDIF
               I++
               SKIP
            ENDDO
            SET FILTER TO
            GO TOP
            SELE 2
            FOR K := 1 TO PAGAR
                APPEND BLANK
                REPLACE Valor     WITH if(tipo_agd=1,aVetVal[k][1],aVetval[K][4])
                REPLACE descricao WITH aVetval[K][2]
                REPLACE TIPO      WITH if(aVetVal[K][3]="V","C","D")
                REPLACE DATA      WITH DATA_SIS
            NEXT
            mensagem("Pagamentos efetuados!!")
            RETURN 0
         ENDIF
      ENDIF
   ELSEIF (LASTKEY() = -2 .AND. TIPO_AGD = 1)   .OR. (LASTKEY()=-2 .AND.  TIPO_AGD=3)
      REPLACE SELEC WITH IF(SELEC="S"," ","S")
      RETURN 2
   ELSEIF lastkey() = 13
      cMascara  := VETOR_MASC[_indice]
      cCampo    := VETOR_CAMP[_indice]
      nApCurs := setcursor(1)
      @ row(), col() GET &cCampo PICTURE cMascara WHEN(upper(cCampo)<>"SELEC" .AND. upper(cCampo)<>"CODIGO")
      READ
      setcursor(nApCurs)
      return 1
   ELSE
      RETURN 1
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

* eop cafunc.prr