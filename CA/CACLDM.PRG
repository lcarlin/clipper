/* BOP caCLDM.PRG

Programa    cacldm.prg
autor       Luiz Antonio CArlin
Data        07/07/95
Funcao      Consulta de lancamentos diarios e mensais do caixa
Sistema     Controle de acougues
linguagem   Clipper 5.01

*/

PARAMETERS  Tipo_c
PUBLIC cCusto, nCusto, nTam, cSit, nCcusto, nDcusto, aVet_campos, aVet_masc, TIPO_C

IF Tipo_c = 1
   USE caBLANCA
   cMostra1 := "Consulta de Lan‡amentos Diarios do Caixa"
ELSEIF tipo_c = 2
   USE caBLMC
   cMostra1 := "Consulta de Lancamentos Mensais do Caixa"
ELSE
   USE caBcUSTO
   cMostra1 := "Consulta de Custos Mensais"
ENDIF

aVet_campos := {"Tipo","Data","Valor","Descricao"}
aVet_masc   := {"!","99/99/99","999,999.99","@!"}
aVet_cab    := {"Tipo:","Data:","Valor:","Descri‡ao:"}

sombra(04,04,23,77)
@ 04,19 say cMostra1
@ 22,05 SAY "<ENTER> Edita; "
IF tipo_c = 3
   @ 22,col() SAY "<F8> - Pesquisa Custos; <F9> - Limpa Pesquisa"
ENDIF
dbedit(05,05,21,76,aVet_campos,"CONS_LMC",aVet_masc,aVet_cab,"Ä","³")
CLOSE ALL
RELEASE ALL
RETURN

function cons_LMC (modo,_indice)
local  ret

if modo = 4
   if lastkey() = 27
      return  0
   ELSEIF lastkey() = 13
      cCampo   := aVet_campos[_indice]
      cMascara := aVet_Masc[_indice]
      nApCur := setcursor(1)
      @ row(),col() GET &cCampo PICT cMascara WHEN ( UPPER(cCampo) <> "SELEC" .AND. upper(cCampo) <> "TIPO" )
      READ
      setcursor(nApCur)
      return  1
   ELSEIF lastkey() = -7 .AND. tipo_c = 3
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
   ELSEIF LASTKEY() = -8 .AND. tipo_c = 3
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



* EOP caCLDM.PRG