/*
BOP CACEAGD.PRG
PROGRAMA   CACEAGD.PRG
DATA       18/07/95
AUTOR      LUIZ ANTONIO CARLIN
FUNCAO     CONSULTA DE PAGAMENTOS AGENDADOS
SISTEMA    CONTROLE DE ACOUGUES
LINGUAGEM  CLIPPER 5.01
*/
CLOSE ALL

SELE 1
USE CABagen

cTitulo := "Consulta de Dividas Agendadas"


VETOR_camp := {"Selec","codigo","Nome_FOR","Data_pg","Valor"}
VETOR_CAB  := {"Sel.","Codigo","Cliente","Data Pagto","Valor"}
VETOR_MASC := {"!","@!","@!","99/99/99","999,999.99"}

SOMBRA( 04,01,22,77)
@ 04,20 SAY cTitulo
@ 19,05 SAY "<F2> - Pesquisa data/Limpa Pesquisa"
@ 20,29 say IF(TIPO_AGD=1,";<F4> - Efetua pagamento da divida"," ")
@ 20,05 say if(tipo_agd=1,"<F3> - Marca/descarca"," ")
SELE 1
dbedit(05,02,18,76,VETOR_CAMP,"CONS_agd",VETOR_MASC,VETOR_CAB,"Ä","³")
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
         SET FILTER TO substr(dtoc(data_pg),4,8) = dat_fil
         GO TOP
         RETURN 2
      ENDIF
   ELSEIF lastkey() = -3
      IF TIPO_AGD= 1
         IF confirma("Realizar o pagamento das dividas Marcadas ?")
            COUNT FOR SELEC = "S" TO PAGAR
            IF PAGAR < 1
               MENSAGEM("Nao ha registros marcados!")
               RETURN 1
            ENDIF
            LOCATE FOR SELEC = "S"
            for i := 1 to PAGAR
                nValor  := Valor
                cDesc   := if(tipo="V","Recebimento","Pagamento")+" de Divida Agendada-"+dtoc(data_pg)
                cTipo   := TIPO
                DELE
                sele 2
                APPEND BLANK
                REPLACE descricao WITH cDesc
                REPLACE Valor    WITH nValor
                REPLACE TIPO     WITH if(cTipo="V","C","D")
                REPLACE DATA     WITH DATA_SIS
                SELE 1
                CONTINUE
            NEXT
            mensagem("Pagamentos efetuados!!")
            RETURN 0
         ENDIF
      ENDIF
   ELSEIF LASTKEY() = -2 .AND. TIPO_AGD = 1
      REPLACE SELEC WITH IF(SELEC="S"," ","S")
      RETURN 1
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