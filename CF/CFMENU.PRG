/* bop cfmenu.prg
   data  24-01-96
   funcao menu principal do programa
   linguagem clipper 5.2
   autor luiz antonio carlin
   sistema cadastro de filiados
*/
#include "Winclas.ch"
PUBLIC aCatego, DATA_SIS := date()
PUBLIC cCorBAt, cCorBIn, cCorFun, cCorTT, cCorPad, cCorJane, cCorTm, cCorJan2

SAVE SCREEN TO sTelaDos
nColDOs := col()
nLInDos := row()

SET WRAP ON
SET DATE TO BRITISH
SET SCORE OFF
SET DELETE ON
SET PROCEDURE TO CFFUNC
SETBLINK(.T.)

IF .NOT. FILE ("CFBFILIA.DBF")
   ?"Criando arquivo de Filiados"

   aEstru := {{"TITULO     ","C",15,0},;
	      {"NOME       ","C",40,0},;
	      {"SECAO      ","C", 4,0},;
	      {"FILIACAO   ","D", 8,0},;
	      {"INSCRICAO  ","C", 5,0},;
	      {"ENDERECO   ","C",40,0},;
	      {"BAIRRO     ","C",25,0},;
	      {"CIDADE     ","C",30,0},;
	      {"UF         ","C", 2,0},;
	      {"CEP        ","C", 9,0},;
	      {"PARTIDO    ","C", 6,0},;
	      {"MARCADO    ","C", 1,0}}
   dbcreate("CFBFILIA",aEstru)
ENDIF


?"Aguarde ! Organizando Arquivo "
IF .NOT. file("CFIFILI1.ntx") .OR. (.NOT. file("CEIFILI2.NTX"))
   USE CFBFILIA
   INDEX ON TITULO TO CFIFILI1
   INDEX ON NOME   TO CFIFILI2
ELSE
   USE CFBFILIA INDEX CFIFILIA, CFIFILI2
   reindex
ENDIF
CLOSE ALL

aMatMenu := {{05,05,"1 - Manuten‡„o de Filiados"},;
	     {07,05,"2 - Impress„o de Relat¢rios de Filiados"},;
	     {09,05,"3 - Impress„o de Etiquetas"},;
	     {11,05,"4 - Consulta"},;
	     {13,05,"5 - Sair"}}
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
centra(00,"- Tec Maq Inform tica LTDA - Fone : (0143) 51-1728 - Piraju - SP -",cCorTT)
centra(01,"Controle de Filiados v1.0",cCortt)
oJanMenu := windowNew(03,02,15,46)
oJangeral:= windowNew(11,29,13,51)
.oJanMenu:color := cCorJane
.oJanMenu:title := " Menu Principal "
.oJanMenu:Coltitle := cCorTM
.oJanGeral:OpenWin()
setcolor(cCorDos)
@ 12, 30 say "Data Atual:" get data_sis picture "99/99/99"
read
setcolor(cCorFun)
.oJanGeral:CloseWin()

.oJanMenu:OpenWin()
DO WHILE .T.
   setcolor(cCorPad)
   centra(24,"<ESC> - Sair ",cCorTT)
   nOp := botao(aMatMenu,,cCorBIn,cCOrBAt)
   IF lastkey() = 27
      nOP := 5
   ENDIF
   DO CASE
      CASE nOp = 1
	   .oJanGeral:top    := 07
	   .oJanGeral:left   := 04
	   .oJanGeral:bottom := 19
	   .oJanGeral:right  := 70
	   .oJanGeral:color  := cCorJan2
	   .oJanGeral:title  := "Manuten‡„o de Filiados"
	   .oJangeral:coltitle:=cCorJan2
	   .oJanGeral:OpenWin()
	   DO CFMTFILI           
	   .oJanGeral:CloseWin()
      CASE nop = 2 .OR. nOp = 3
	   aMatRel := {{12,7,"Todos os Registros"},{12,28,"Registros Selecionados"},{12,52,"Por Partido"},{12,65,"Cancelar"}}
	   .oJanGeral:top    := 11
	   .oJanGeral:left   := 06
	   .oJanGeral:bottom := 14
	   .oJanGeral:right  := 75
	   .oJanGeral:color  := cCorJan2
	   .oJanGeral:title  := "Op‡„o do Tipo de Impress„o"
	   .oJangeral:coltitle:=cCorJan2
	   .oJanGeral:OpenWin()
	   nRelat := botao(aMatRel,,cCorBin,cCorBat)
	   BEGIN SEQUENCE
		 USE CFBFILIA INDEX CFIFILI2
		 IF nRelat = 4 .OR. nRelat = 0
		    BREAK
		 ENDIF
		 IF nRelat = 2
		    nMarcado := 0
		    COUNT TO nMarcado FOR MARCADO="S"
		    IF nMarcado = 0
		       mensagem("N„o h  registros Marcados!!")
		       BREAK
		    ENDIF
		    SET FILTER TO MARCADO = "S"
		    GO TOP
		 ELSEIF nRelat = 3
		    cFiltro := space(06)
		    sombra(12,20,14,48)
		    @ 13,21 SAY "Entre c/ o Partido:" GET cFiltro PICTURE "@!"
		    READ
		    IF empty(cFiltro)
		       BREAK
		    ENDIF
		    SET FILTER TO partido = cFiltro
		    GO TOP
		    IF eof()
		       mensagem("N„o h  dados para serem impressos !")
		       BREAK
		    ENDIF
		 ENDIF
		 mensagem("Verifique a Impressora !")
		 IF .NOT. isprinter()
		     mensagem("A Impressora n„o pode estar pronta !")
		     BREAK
		 ENDIF
		 @ 12,15 TO 14,39
		 @ 13,16 SAY   "Aguarde ! Imprimindo..." COLOR "W*/N"
		 IF nOp = 3
		    IF .NOT. file("CFFORM.LBL")
			mensagem("N„o ‚ Possivel Imprimir etiqutas !!")
			BREAK
		    ENDIF              
		    SET CONSOLE OFF
		    LABEL FORM CFFORM TO PRINTER
		    SET CONSOLE ON
		    mensagem("Etiquetas Impressas !")
		 ELSEIF nOp = 2
		    DO CFRELAT WITH if(nRelat = 3,"Rela‡„o de Filiados ao Partido: "+cFiltro," ")
		 ENDIF
	   END SEQUENCE
	   CLOSE ALL
	   .oJanGeral:CloseWin()
      CASE nop = 4
	   .oJanGeral:top    := 03
	   .oJanGeral:left   := 03
	   .oJanGeral:bottom := 22
	   .oJanGeral:right  := 77
	   .oJanGeral:color  := cCorJan2
	   .oJanGeral:title  := "Consulta de Registros de Filiados"
	   .oJangeral:coltitle:=cCorJan2
	   .oJanGeral:OpenWin()
	   DO CFCONS
	   .oJanGeral:CloseWin()
      CASE nop = 5
	   IF confirma("Deseja Realmente Sair ?")
	      EXIT
	   ENDIF
   ENDCASE
ENDDO
.oJanMenu:Closewin()
RESTORE SCREEN FROM sTelaDos
setpos(nLinDos,nColDos)
quit

* eop cfmenu.prg