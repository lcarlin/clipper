/*
BOP CACCPSEG.PRG
DATA       14/11/95
AUTOR      LUIZ A. CARLIN
FUNCAO     CONSULTA DE DADOS NO DISCO FLEXIVEL
SISTEMA    CONTROLE DE ACOUGUES
LINGUAGEM  CLIPPER 5.2
*/
#include "INKEY.CH"

aMatOpc := array(8,3)
aMatOpc := {{06,10,"Registros de VENDAS de produtos"},;
            {08,10,"Registros de COMPRAS de produtos"},;
            {10,10,"Lancamentos DIARIOS do caixa"},;
            {12,10,"Lancamentos MENSAIS do caixa"},;
            {14,10,"Registros de Custos diarios"},;
            {16,10,"Registros de RECEBIMENTOS"},;
            {18,10,"Registros de PAGAMENTOS"},;
            {20,10,"Cancelar"}}
aMatOpc2 := array(03,3)
aMatOpc2 := {{08,20,"Unidade A:"},{10,20,"Unidade B:"},{12,20,"Cancelar"}}
nArq  := 0
nDrive := 0
sombra(05,09,22,50)
@ 05,10 SAY "Escolha o Tipo de Dado a ser consultado"
nArq := botao(aMatOpc)
IF nArq = 0 .OR. nArq = 8
   RETURN
ENDIF
sombra(07,19,14,41)
@ 07,20 SAY "Selecione a Unidade:"
nDrive := botao(aMatopc2)
IF nDrive = 0 .OR. nDrive = 3
   RETURN
ENDIF
cDrive := if(nDrive = 1,"A:","B:")
ARQTESTE := FCREATE(cDRIVE+"TESTE.000",0)
IF ARQTESTE = -1
   mensagem("Atencao! Problemas c/ Drive ou disquete !")
   RETURN
ELSE
   FCLOSE(ARQTESTE)
   DELE FILE cDRIVE+"TESTE.000"
ENDIF
aVetArq :={"CABMEST","CABCEST","CABLANCA","CABLMC","CABCUSTO","CABAGEN","CABAGEN"}
IF .NOT. file(cDrive+aVetArq[nArq]+".DB?")
   mensagem("Arquivo Nao encontrado !")
   RETURN
ENDIF
// cabmest
aMatDado1 := {{"data_neg","Data"},;
              {"cod_pes","Codigo"},;
              {"pessoa","Cliente"},;
              {"cod_item","Cod. Item"},;
              {"item","Item"},;
              {"quant","Kilos"},;
              {"Val_tot","Valor Total"}}

aMatDado2 :={{"data_com","Data da Compra"},;
             {"Descricao","Descricao"},;
             {"Procedenc","Procedencia"},;
             {"data_ven","Data do Vencimento"},;
             {"Dias_Praz","Dias de Prazo"},;
             {"Val_arr","Valor da Arroba/Kilo"},;
             {"Val_tot","Valor total"},;
             {"Arrobas","Arrobas/Kilos"}}

aMatDado3 := {{"Data","Data:"},{"Valor","Valor:"},{"Descricao","Descri‡„o:"},{"Tipo:","Tipo"}}

aMatDado4 := {{"Data","Data:"},{"Valor","Valor:"},{"Descricao","Descri‡„o:"},{"Tipo:","Tipo"}}

aMatDado5 := {{"Data","Data:"},{"Valor","Valor:"},{"Descricao","Descri‡„o:"},{"Tipo:","Tipo"}}

aMatDado6 := {{"codigo","Codigo"},;
              {"nome_for","Cliente"},;
              {"data_pg","Data Pagto"},;
              {"tipo_car","Produto"},;
              {"qtd_car","Quantidade"},;
              {"valor","Valor"}}

aMatDado7 := {{"codigo","Codigo"},;
              {"nome_for","Cliente"},;
              {"data_pg","Data Pagto"},;
              {"valor","Valor"}}
cFileName := cDrive+aVetarq[nArq]
USE &cFileName

IF nArq >= 6
   dbsetfilter({ || tipo=if(nArq=6,"V","C") } )
ENDIF
dbgotop()
cMatriz := 'aMatDado'+str(nArq,1,0)
tbgeneric(2,5,21,75,&cmatriz,"Consulta de : "+aMatOpc[nArq][3])
CLOSE ALL
RETURN

* EOP CACCSEG.PRG