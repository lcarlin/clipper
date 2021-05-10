/***************************************************
* Bop ccmenu.prg
* data       01/07/1996
* sistema    Cadastro de Cheques
* modulo     CCmenu.prg
* Linguagem  Clipper 5.2e
* Autor      Luiz Antonio Carlin
***********************************/
/* Tela do Dos */
LOCAL nLinDos := Row()
LOCAL nColDos := Col()
LOCAL sTelaDos := SaveScreen(00,00,MaxRow(),MaxCol())
PUBLIC cCorBin ,cCorBaT,cCorTIT,cCorInc,cCorbOX,cCorImp,cCorFun,cCorMen,cCorDad
 
/* Ambiente */
SET DELETE ON
SET DATE TO BRITISH
SET MESSAGE TO 24
SET SCORE OFF
SET KEY -41 TO __CONTAS()
/* bancos de dados */
 
/* Arquivo de Bancos */
IF .NOT. File ("CCBBanc.db?")
   ?"Criando arquivo de Bancos"
   aEstru := {{"NBANCO   ","N",02,0},;
              {"BANCO    ","C",30,0},;
              {"NCONTA   ","C",10,0}}
   DbCreate("CCBBanc",aEstru)
ENDIF
 
/* Arquivo de Cheques */
IF .NOT. File ("CCBChq.DBF")
   ?"Criando arquivo de cheques"
   aEstru := {{"NCHEQUE  ","N",08,0},;
              {"DATAEM   ","D",08,0},;
              {"VALOR    ","N",15,2},;
              {"CONTA    ","C",10,0},;
              {"BANCO    ","C",30,0},;
              {"BENEFI   ","C",30,0},;
              {"DATACOM  ","D",08,0},;
              {"NBANCO   ","N",02,0},;
              {"IMPRESSO ","L",01,0},;
              {"BAIXA    ","L",01,0}}
   DbCreate("CCBchq.DBF",aEstru)
ENDIF
 
IF .NOT. file("CCBUSU.DBF")
   ?"Criando arquivo de Usuarios"
   aEstru := {{"CodUsu  ","C",03,0},;
              {"NOME    ","C",30,0},;
              {"SENHA   ","C",10,0}}
   DbCreate("CCBUSU",aEstru)
   USE CCBUSU
   DbAppend()
   replace CodUsu WITH "999"
   replace nOME   WITH "Luiz Antonio Carlin"
   replace SENHA  WITH cripto("999")
   CLOSE ALL
ENDIF
 
/* Arquivos de Indices */
IF .NOT. File ("CCIBAN1.NTX")
   ?"Organizando auquivo de bancos I"
   USE CCBBANC
   INDEX ON NBANCO TO CCIBAN1
   CLOSE ALL
ENDIF
 
IF .NOT. File ("CCIBAN2.NTX")
   ?"Organizando auquivo de bancos II"
   USE CCBBANC
   INDEX ON BANCO TO CCIBAN2
   CLOSE ALL
ENDIF
 
IF .NOT. File ("CCIBAN3.NTX")
   ?"Organizando auquivo de bancos III"
   USE CCBBANC
   INDEX ON NCONTA TO CCIBAN3
   CLOSE ALL
ENDIF
 
/* INDICES DOS CHEQUES */
IF .NOT. File ("CCIch1.ntx")
   ?"Organizando auquivo de cheques I"
   USE CCBCHQ
   INDEX ON NCHEQUE TO CCICH1
   CLOSE ALL
ENDIF
 
IF .NOT. File ("CCIch2.ntx")
   ?"Organizando auquivo de cheques II"
   USE CCBCHQ
   INDEX ON DATAEM  TO CCICH2
   CLOSE ALL
ENDIF
 
IF .NOT. File ("CCIch3.ntx")
   ?"Organizando auquivo de cheques III"
   USE CCBCHQ
   INDEX ON NBANCO TO CCICH3
   CLOSE ALL
ENDIF
 
IF .NOT. File("ccIusu.nTX")
   ?"Organizando arquivo de Usuarios"
   USE CCBUSU
   INDEX ON CODUSU TO CCIUSU
   CLOSE ALL
ENDIF
/* Cores */
IF .NOT. FILE ("Cores.mem")
   cCorBin := "W/N+"
   cCorBaT := "GR+/R"
   cCorTIT := "W/G"
   cCorInc := "W/B,R/W,,,r+/n"
   cCorbOX := "GR+/R"
   cCorImp := "W+/g"
   cCorFun := "b/w"
   cCorDad := "w+/bg"
 *  cCorMen := "n/w"
 *  cCorMen := "n/w"
ENDIF
 
/****** TELA DO PROGRAMA *********/
CLS
setcolor(cCorFun)
@ 00,00,MaxRow(),MaxCol() BOX "±±±±±±±±±"
Centra(00,"Controle de Cheques v1.0")
Centra(01,"Desenvolvido Por Tec Maq - Fone (014) 351-1728 - Piraju - SP")
aMenu := {{06,07,"Cheques    ","Lan‡a, Imprime cheques"},;
          {08,07,"Bancos     ","Cadastra contas bancarias"},;
          {10,07,"Usuarios   ","Cadastra Usuarios"},;
          {12,07,"Reindexa‡„o","Reorganiza Arquivos de dados "},;
          {14,07,"BackUp     ","Cria copia de seguran‡a / Restaura arquivos"},;
          {16,07,"Sair       ","Sai do programa"}}
setcolor(cCorMen)
Sombra(04,04,17,20)
@ 04,04 SAY "Menu Principal"
sTelaMenu := savescreen(00,00,MaxRow(),MaxCol())
DO WHILE .T.
   RestScreen(00,00,MaxRow(),MaxCol(),sTelaMenu)
   nOpc := Botao(aMenu,,cCorBin,cCorbat)
   IF nOPc = 1
      Cheques()
   ELSEIF nOpc = 2
      Bancos()
   ELSEIF nOpc = 3
      Usuarios()
   ELSEIF nOpc = 4
      Reindexa()
   ELSEIF nOpc = 5
*     Backup()
   ELSE
     EXIT
   ENDIF
ENDDO
restscreen(00,00,MaxRow(),MaxCol(),sTelaDos)
SetPos(nLInDos,nCOlDos)
* EOP CCMENU.PRG
