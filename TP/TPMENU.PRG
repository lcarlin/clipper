/* bop tpmenu.prg
   data  05-01-96
   funcao menu principal do programa
   linguagem clipper 5.2
   autor luiz antonio carlin
   sistema tabela de precos
*/
#include "Winclas.ch"
PUBLIC aCatego
PUBLIC cCorBAt, cCorBIn, cCorFun, cCorTT, cCorPad, cCorJane, cCorTm, cCorJan2

SAVE SCREEN TO sTelaDos
nColDOs := col()
nLInDos := row()

SET WRAP ON
SET SCORE OFF
SET DELETE ON
SET PROCEDURE TO TPFUNC
SETBLINK(.T.)

IF .NOT. FILE ("TABELA.DBF")
   ?"Criando arquivo de tabela"

   aEstru := {{"CODIGO   ","c",07,0},;
              {"DEsCRICAO","C",40,0},;
              {"UN       ","C",02,0},;
              {"marcado  ","C",01,0},;
              {"PRECO    ","N",11,2}}
   dbcreate("tabela",aEstru)
ENDIF

IF .NOT. FILE ("catego.DBF")
   ?"Criando Arquivo de Categorias"
   aEstru := {{"categoria","C",02,0},;
              {"cat_des  ","C",20,0}}
   dbcreate("catego",aEstru)
ENDIF

IF .NOT. FILE ("tpborc.DBF")
   ?"Criando Arquivo de Orcamentos - I"
   aEstru := {{"numero   ","C",07,0},;
              {"Cliente  ","C",40,0},;
              {"MaoObra  ","N",11,2},;
              {"Objetivo1","C",50,0},;
              {"Objetivo2","C",50,0},;
              {"Objetivo3","C",50,0}}
   dbcreate("TPBORC",aEstru)
ENDIF

IF .NOT. FILE ("tpborc2.DBF")
   ?"Criando Arquivo de Orcamentos - II"
   aEstru := {{"numero   ","C",07,0},;
              {"Cod_mat  ","C",07,0},;
              {"material ","C",40,0},;
              {"qTD_MAT  ","N",07,2},;
              {"VAL_UNIT ","N",11,2},;
              {"UNIDADE  ","C",02,0}}
   dbcreate("TPBORC2",aEstru)
ENDIF


?"Aguarde ! Organizando Arquivo "
IF .NOT. file("iTab1.ntx")
   USE TABELA
   INDEX ON CODIGO    TO ItAB1
   CLOSE ALL
ENDIF


IF .NOT. file("iCat1.ntx")
   use CATEGO
   INDEX ON CAT_DES TO iCat1
   CLOSE ALL
ENDIF

aCatego := {}
DO WHILE .NOT. eof()
   aadd(aCatego,categoria+" - "+cat_des)
   SKIP
ENDDO
CLOSE ALL

IF .NOT. file("TPIORC.ntx")
   use TPBORC
   INDEX ON numero TO TPIORC
ELSE
   USE TPBORC INDEX TPIORC
   REINDEX
ENDIF
CLOSE ALL


IF .NOT. file("tpiorc2.ntx")
   USE TPBORC2
   INDEX ON COD_MAT TO tpiorc2
ELSE
   USE TPBORC2 INDEX TPIORC2
   REINDEX
ENDIF
CLOSE ALL



aMatMenu := {{05,05,"1 - Manutencao de Materiais"},;
             {07,05,"2 - Inclusao de Codigos de Categorias"},;
             {09,05,"3 - Impressao de Tabela de Precos"},;
             {11,05,"4 - Orcamentos"},;
             {13,05,"5 - Reajuste de Precos"},;
             {15,05,"6 - Sair"}}
IF  IsColor()
   cCorBAt := "w+/B"
   cCorBIn := "N+/w"
   cCorFun := "Bg/b"
   cCorTT  := "gr+/bg"
   cCorPad := "Bg/n,n/r"
   cCorJane:= "gr+/b"
   cCorTm  := "w+/n"
   cCorJan2:= "Bg/n"
   cCorMens:= "r+/n"
ELSE
   cCorBAt := "N/W"
   cCorBIn := "W/N"
   cCorFun := "N/W"
   cCorTT  := "W/N"
   cCorPad := "W/N,N/W"
   cCorJane:= "w/n"
   cCorTM  := "w/n"
   cCorJan2:= "w/n"
   cCorMens:= "w/n"
ENDIF
cCorDos := seTCOlor(cCorFun)
@ 00,00,24,79 BOX replicate("±",9)
centra(00," - Meta Engenharia - ",cCorTT)
centra(01,"Tabela de Precos",cCortt)
oJanMenu := windowNew(03,02,17,44)
oJangeral:= windowNew(04,04,15,52)
.oJanMenu:color := cCorJane
.oJanMenu:title := " Menu Principal "
.oJanMenu:Coltitle := cCorTM
.oJanMenu:OpenWin()
DO WHILE .T.
   setcolor(cCorPad)
   centra(24,"<ESC> - Sair ",cCorTT)
   nOp := botao(aMatMenu,,cCorBIn,cCOrBAt)
   IF lastkey() = 27
      nOP := 6
   ENDIF
   DO CASE
      CASE nOp = 1
           .oJanGeral:top    := 09
           .oJanGeral:left   := 07
           .oJanGeral:bottom := 14
           .oJanGeral:right  := 68
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Manutencao de Materiais"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO TPMTMAT
           .oJanGeral:CloseWin()
      CASE nop = 2
           .oJanGeral:top    := 09
           .oJanGeral:left   := 24
           .oJanGeral:bottom := 12
           .oJanGeral:right  := 62
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Manutencao de Categorias"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO TPMTcat
           .oJanGeral:CloseWin()
      CASE nop = 3
           .oJanGeral:top    := 09
           .oJanGeral:left   := 04
           .oJanGeral:bottom := 12
           .oJanGeral:right  := 65
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Impressao de Tabela de Precos"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO TPrelat
           .oJanGeral:CloseWin()
      CASE nop = 4
           .oJanGeral:top    := 04
           .oJanGeral:left   := 03
           .oJanGeral:bottom := 23
           .oJanGeral:right  := 77
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Or‡amentos"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO TPmtORC
           .oJanGeral:CloseWin()
      CASE nop = 5
           .oJanGeral:top    := 04
           .oJanGeral:left   := 01
           .oJanGeral:bottom := 23
           .oJanGeral:right  := 77
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Reajuste de Pre‡os de Materiais"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO TPrjes
           .oJanGeral:CloseWin()
      CASE nOP = 6
           IF confirma("Deseja Realmente Sair ?")
              EXIT
           ENDIF
   ENDCASE
ENDDO
.oJanMenu:Closewin()

USE TABELA INDEX ITAB1
PACK
REINDEX EVAL { || NtxProgress()} EVERY 3
CLOSE ALL

USE CATEGO INDEX ICAT1
PACK
REINDEX  EVAL { || NtxProgress() } EVERY 3

RESTORE SCREEN FROM sTelaDos
setpos(nLinDos,nColDos)
quit

* eop tmneu.prg