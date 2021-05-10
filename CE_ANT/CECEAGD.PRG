
/*
BOP CECEAGD.PRG
PROGRAMA   CECEAGD.PRG
DATA       28/06/95
AUTOR      LUIZ ANTONIO CARLIN
FUNCAO     CONSULTA/EXCLUSAO DA AGENDA
SISTEMA    CONTROLE DE ESTOUE
LINGUAGEM  CLIPPER 5.01
*/
PARAMETERS TIPO_AGD
FIELD Selec, codigo, Nome_FOR, Data_pg, Valor, TIPO

PUBLIC cTipo3, cTitulo2, Dat_fil, dAno, dMes


SELE 2
USE CEBLANCA

SELE 1
USE CEBAGEN INDEX CEIAGEN

IF TIPO_AGD = 1
   cTitulo := "Exclusao de Pagamentos Agendados"
   cTitulo2:= "Pagamento"
   cTitulo3:= "Fornecedor"
   cTipo3  := "D"
ELSEIF TIPO_AGD = 2
   cTitulo := "Exclusao de Recebimentos agendados"
   cTitulo2:= "Recebimento"
   cTitulo3:= "Cliente"
   cTipo3  := "C"
ENDIF
VETOR_CAMP := {"Selec","codigo","Nome_FOR","Data_pg"   ,"Valor"}
VETOR_CAB  := {"Sel." ,"Codigo",cTitulo3  ,"Data Pagto","Valor"}
VETOR_MASC := {"!"    ,"@!"    ,"@!"      ,"99/99/99"  ,"999,999.99"}

SOMBRA( 04,00,22,78)
@ 04,20 SAY cTitulo
@ 19,05 SAY "<F2> - Pesquisa data/Limpa Pesquisa"
@ 20,29 say "<F4> - Efetua "+cTitulo2+" da divida"
@ 20,05 say "<F3> - Marca/descarca"

SELE 1
SET FILTER TO TIPO=cTipo3
GO TOP
dbedit(05, 01, 18, 77, VETOR_CAMP, "CONS_AGD", VETOR_MASC, VETOR_CAB, "Ä", "³")
CLOSE ALL
RETURN

**********************************************
* Funcao de consulta do dbedit(consulta)

function cons_agd (modo,_indice)

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
      @ 21,42 SAY "/" COLOR "W/R"
      @ 21,43 GET dAno PICT "99"
      READ
      RESTORE SCREEN FROM sTela_ant
      setcursor(apre)
      IF LASTKEY()=27
         RETURN 1
      ENDIF
      IF EMPTY(dMes) .or. Empty(dAno)
         SET FILTER TO TIPO = cTipo3
         GO TOP
         RETURN 2
      ELSE
         dat_fil := dMes+"/"+dAno
         SET FILTER TO (TIPO=cTipo3) .AND. (SUBST(dtoc(data_pg),4,8)=DAT_FIL)
         GO TOP
         RETURN 2
      ENDIF
   ELSEIF lastkey() = -3
      IF confirma("Realizar o "+cTitulo2+" das dividas Marcadas ?")
         COUNT FOR SELEC = "S" TO PAGAR
         IF PAGAR < 1
            MENSAGEM("Nao ha registros marcados!")
            RETURN 1
         ENDIF
         LOCATE FOR SELEC = "S"
         for i := 1 to PAGAR
             nValor  := Valor
             cDesc   := if(Tipo="D","Pagamento","Recebimento")+" de Divida Agendada-"+dtoc(data_pg)
             cTipo   := TIPO
             DELE
             sele 2
             APPEND BLANK
             REPLACE descricao WITH cDesc
             REPLACE Valor    WITH nValor
             REPLACE TIPO     WITH cTipo
             REPLACE DATA     WITH DATA_SIS
             SELE 1
             CONTINUE
         NEXT
         mensagem("Pagamentos efetuados!!")
         RETURN 0
      ENDIF
   ELSEIF LASTKEY() = -2
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

* EOP CECEAGD.PRG