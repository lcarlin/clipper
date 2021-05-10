/* bop CNmenu.prg
   data  05-01-96
   funcao menu principal do programa
   linguagem clipper 5.2
   autor luiz antonio carlin
   sistema tabela de precos
*/
#include "Winclas.ch"
PUBLIC aServico
PUBLIC cCorBAt, cCorBIn, cCorFun, cCorTT, cCorPad, cCorJane, cCorTm, cCorJan2
 
SAVE SCREEN TO sTelaDos
nColDOs := col()
nLInDos := row()
 
SET WRAP ON
SET SCORE OFF
SET DELETE ON
SET PROCEDURE TO CNFUNC
SET KEY -19 TO CALC()
SETBLINK(.T.)

IF .NOT. FILE ("CNBCLI.DBF")
   ?"Criando arquivo de Clientes"
   aEstru := {{"Codigo","C",06,0},;
              {"NOme  ","C",40,0},;
              {"Telefone","C",20,0},;
              {"Ender ","C",40,0},;
              {"Munici","C",35,0},;
              {"Uf    ","C",02,0},;
              {"InscMn","C",05,0},;
              {"InscEs","C",20,0},;
              {"Cgc   ","C",20,0}}
   dbcreate("CNBCLI",aEstru)
ENDIF
 
IF .NOT. FILE ("CNBSERV.DBF")
   ?"Criando Arquivo de Servicos"
   aEstru := {{"CodServ  ","C",02,0},;
              {"Descricao","C",40,0},;
              {"Unidade  ","C",03,0},;
              {"Valor_Uni","N",11,2},;
              {"Marcado  ","C",01,0}}
   dbcreate("CNBSERV",aEstru)
ENDIF
 
IF .NOT. FILE ("CNBSER1.DBF")
   ?"Criando Arquivo de Servi‡os Prestados - I"
   aEstru := {{"NOTA     ","N",06,0},;
              {"Nome_cli ","C",40,0},;
              {"Cod_cli  ","C",06,0}}
   dbcreate("CNBSER1",aEstru)
ENDIF
 
IF .NOT. FILE ("CNBSER2.DBF")
   ?"Criando Arquivo de Servi‡os Prestados - II"
   aEstru := {{"_NOta    ","N",06,0},;
              {"_COD_CLI ","C",06,0},;
              {"_NOME_CLI","C",40,0},;
              {"_COD_SERV","C",06,0},;
              {"_Des_serv","C",40,0},;
              {"val_UNIT ","N",11,2},;
              {"_Quant   ","N",03,0},;
              {"UNIDADE  ","C",03,0}}
   dbcreate("CNBSER2",aEstru)
ENDIF
 
IF .NOT. file("CNICLI1.NTX") .OR. .NOT. file("CNICLI2.NTX")
   ?"Aguarde ! Organizando arquivo de clientes..."
   USE CNBCLI
   INDEX ON CODIGO TO CNICLI1
   INDEX ON NOME   TO CNICLI2
   CLOSE ALL
ENDIF
 
IF .NOT. file("CNISER1.NTX") .OR. .NOT. file("CNISER2.NTX")
   ?"Aguarde ! Organizando arquivo de Servi‡os..."
   USE CNBSERV
   INDEX ON CODSERV   TO CNISER1
   INDEX ON DESCRICAO TO CNISER2
   CLOSE ALL
ENDIF
 
IF .NOT. file("CNISER3.NTX")  // OR. .NOT. file("CNISER2.NTX")
   ?"Aguarde ! Organizando arquivo de Servi‡os Prestados I"
   USE CNBSER1
   INDEX ON NOTA      TO CNISER3
   CLOSE ALL
ENDIF
 
IF .NOT. file("CNISER4.NTX")  // OR. .NOT. file("CNISER2.NTX")
   ?"Aguarde ! Organizando arquivo de Servi‡os Prestados II"
   USE CNBSER2
   INDEX ON _NOTA     TO CNISER4
   CLOSE ALL
ENDIF
 
criarray()
 
aMatMenu := {{05,05,"1 - Manuten‡„o de Clientes                 "},;
             {07,05,"2 - Manuten‡„o de Descri‡„o de Servi‡os    "},;
             {09,05,"3 - Cadastro/Impress„o de Notas de Servi‡os"},;
             {11,05,"4 - Reajuste de Pre‡os            "},;
             {13,05,"5 - Relat¢rio de Clientes         "},;
             {15,05,"6 - Agenda de Recebimentos        "},;
             {17,05,"7 - Sair      "} }
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
relogio (01,70)
cCorDos := seTCOlor(cCorFun)
@ 00,00,24,79 BOX replicate("±",9)
centra(00,"- Tec Maq Inform tica LTDA - Fone : (0143) 51-1728 - Piraju - SP -",cCorTT)
centra(01,"Controle de Notas v1.0",cCortt)
SETCOLOR("GR+/B")
sombra(19,62,22,76)
@ 20,63 SAY "<SHIFT>+<F10>" color "w/b"
@ 21,63 SAY " Calculadora " color "w/b"
setcolor(cCorFun)

oJanMenu := windowNew(03,02,19,50)
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
      nOP := 7
   ENDIF
   DO CASE
      CASE nOp = 1
           .oJanGeral:top    := 07
           .oJanGeral:left   := 04
           .oJanGeral:bottom := 17
           .oJanGeral:right  := 64
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Manuten‡„o de Clientes"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO CNMTCLI
           .oJanGeral:CloseWin()
      CASE nop = 2
           .oJanGeral:top    := 07
           .oJanGeral:left   := 04
           .oJanGeral:bottom := 12
           .oJanGeral:right  := 64
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Manuten‡„o de Servi‡o"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO CNMTSER
           criarray()
           .oJanGeral:CloseWin()
      CASE nop = 3
           .oJanGeral:top    := 04
           .oJanGeral:left   := 03
           .oJanGeral:bottom := 23
           .oJanGeral:right  := 77
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Cadastro de Notas de Servi‡os"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO CNMTSER2
           .oJanGeral:CloseWin()
      CASE nop = 4
           .oJanGeral:top    := 04
           .oJanGeral:left   := 03
           .oJanGeral:bottom := 23
           .oJanGeral:right  := 77
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Reajuste de Pre‡os de Servi‡os"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO CNRJPSE
           criarray()
           .oJanGeral:CloseWin()
      CASE nop = 5
           .oJanGeral:top    := 09
           .oJanGeral:left   := 04
           .oJanGeral:bottom := 13
           .oJanGeral:right  := 64
           .oJanGeral:color  := cCorJan2
           .oJanGeral:title  := "Op‡oes do Relatorio"
           .oJangeral:coltitle:=cCorJan2
           .oJanGeral:OpenWin()
           DO CNRCLI
           .oJanGeral:CloseWin()
      CASE nOP = 7 .OR. nOp = 0
           IF confirma("Deseja Realmente Sair ?")
              EXIT
           ENDIF
   ENDCASE
ENDDO
.oJanMenu:Closewin()

@ 23,15 SAY "Aguarde !!! Reorganizando Arquivos..." COLOR "R*/W"

USE CNBCLI INDEX CNICLI1, CNICLI2
IF lupdate() = DATE()
     PACK
     REINDEX
ENDIF
CLOSE ALL
 
USE CNBSERV INDEX CNISER1, CNISER2
IF lupdate() = DATE()
   PACK
   REINDEX
ENDIF
CLOSE ALL
 
 
 
USE CNBSER1 INDEX CNISER3
IF lupdate() = DATE()
   PACK
   REINDEX
ENDIF
CLOSE ALL
 
USE CNBSER2 INDEX CNISER4
IF lupdate() = DATE()
   PACK
   REINDEX
ENDIF
CLOSE ALL
 
RESTORE SCREEN FROM sTelaDos
setpos(nLinDos,nColDos)
CLEAR TYPEAHEAD
quit
 
*********************
PROCEDURE CALC ()
CALCULAD(02,69,"B")
RETURN
* eop tmneu.prg
