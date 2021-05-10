/*
BOP CACCEST.PRG
PROGRAMA   CACCEST.PRG
DATA       18/07/95
AUTOR      LUIZ ANTONIO CARLIN
FUNCAO     CONSULTA DE MOVIMENTACOES
SISTEMA    CONTROLE DE ACOUGUES
LINGUAGEM  CLIPPER 5.01
*/

PUBLIC tipo_agd := 4, dat_fil 
PUBLIC Tipo_c := 0

CLOSE ALL

USE CABAGEN NEW

USE CABLANCA NEW

USE CABCEST NEW

SOMBRA( 04,01,22,77)

aVet_campos := {"selec","DATA_COM","DESCRICAO","PROCEDENC","DATA_VEN","DIAS_PRAZ","VAL_ARR","VAL_TOT","ARROBAS"}
VETOR_CAB  := {"Selec.","Data da Compra" ,"Descricao ","Procedencia","Data do Vencimento","Dias de Prazo","Valor da Arroba/Kilo","Valor total","Arrobas"}
aVet_MASC := {"!","99/99/99","@!","@!","99/99/99","99","999,999.99","999,999.99","9999.999"}

@ 04,20 SAY "Consulta de Compras"
@ 21,05 SAY "<F2> - Pesquisa data/Limpa Pesquisa"
@ 22,07 SAY "<F5> - Marca; <F6> - Exclui; <ENTER> - Edita"

dbedit(05,02,20,76,aVet_CAMPos,"CONS_MV",aVet_MASC,VETOR_CAB,"Ä","³")
SET FILTER TO
CLOSE ALL
RELEASE ALL
RETURN

function cons_MV (modo,_indice)
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
   ELSEIF lastkey() = -4
      cNome := alias()
      IF cNome = "CABMEST" .OR. cNome = "CABCEST"
         REPLACE selec WITH if(selec="S"," ","S")
      ENDIF
      return 2
   ELSEIF lastkey() = -5
      nMarc := 0
      COUNT TO nMarc FOR SELEC = "S"
      IF nMarc = 0
         mensagem("Nao ha registros Marcados !!")
         RETURN 1
      ENDIF
      IF .not. confirma("Deseja realmente excluir as movimentacoes ?")
         return 1
      ENDIF
      aMatcamp := {}
      dbSetfilter( {||selec="S" } )
      dbgotop()
      DO WHILE .NOT. eof()
         aadd(aMatCamp,NMOV)
         DELE
         SKIP
      ENDDO
      FOR I := 1 TO len(aMatCamp)
          SELE CABLANCA
          DELETE FOR NMOV=aMatCamp[i]
          SELE CABAGEN
          DELE FOR NMOV=aMatCamp[i]
      NEXT
      mensagem("Movimenta‡oes Excluidas !!")
      RETURN 0
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


* EOP CACCEST.PRG