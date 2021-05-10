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
CLOSE ALL

SELE 1
USE CABAGEN  INDEX CAIAGEN

SELE 2
USE CABLANCA


PUBLIC tipo_agd



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
@ 19,05 SAY "<F2> - Pesquisa data/Limpa Pesquisa"
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
         SET FILTER TO
         GO TOP
         RETURN 2
      ELSE
         dat_fil := dMes+"/"+dAno
         SET FILTER TO substr(dtoc(if(tipo_agd=3,data_pg,data_ven)),4,8) = dat_fil
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

* EOP CACEAGD.PRG