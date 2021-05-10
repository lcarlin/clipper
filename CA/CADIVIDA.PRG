/*
bop CADIVIDA.prg
PROGRAMA   CAdiviDa.PRG
DATA       18/07/95
AUTOR      LUIZ ANTONIO CARLIN
FUNCAO     CONSULTA/EXCLUSAO DA AGENDA
SISTEMA    CONTROLE DE ACOUGUES
LINGUAGEM  CLIPPER 5.01
*/

PUBLIC tipo_agd = 1, VETOR_CAMP, vetor_masc, cCampo, cMascara
SELE 1
USE CABAGEN INDEX CAIAGEN

SELE 2
USE CABLANCA


SOMBRA( 04,01,22,77)
SELE 1
IF TIPO_AGD= 1
   cTitulo := "Exclusao de Pagamentos Agendados"
ENDIF
VETOR_camp := {"Selec","codigo","Nome_FOR","Data_pg","Valor"}
VETOR_CAB  := {"Sel.","Codigo"," Cliente" ,"Data Pagto","Valor"}
VETOR_MASC := {"!","@!","@!","99/99/99","999,999.99"}
@ 04,20 SAY cTitulo
@ 19,05 SAY "<F2> - Pesquisa data/Limpa Pesquisa; <ENTER> Edita"
@ 20,29 say "<F4> - Efetua pagamento"
@ 20,05 say "<F3> - Marca/descarca;"
dbedit(05,02,18,76,VETOR_CAMP,"CONS_agd",VETOR_MASC,VETOR_CAB,"Ä","³")
SET FILTER TO
CLOSE ALL
RELEASE ALL
RETURN

* eop CADIVIDA.prg