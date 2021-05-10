/* Bop ccindice.prg
* Data 02/07/1996
* Autor Luiz
* Funcao reindexacao dos arquiovos do sistema
* Sistema   Controle de Cheques
* Linguagem Clipper 5.2e
**********************************/
PROCEDURE REINDEXA ()
WININIT("WINFIL.WIN",.T.)
* WINBACK(chr(177))
sTelaInd := Savescreen(00,00,MaxRow(),MaxCol())
 
***************************************************************
USE CCBCHQ
PACK
win_sgraph(0,0,1,cCorDad,15,2,70,"Arquivo de Cheques Emitidos - I")
INDEX ON NCHEQUE TO CCICH1 Eval NtxProgress() Every 1
 
win_sgraph(0,0,1,cCorDad,15,2,70,"Arquivo de Cheques Emitidos - II")
INDEX ON DATAEM  TO CCICH2 Eval NtxProgress() Every 1
 
win_sgraph(0,0,1,cCorDad,15,2,70,"Arquivo de Cheques Emitidos - III")
INDEX ON NBANCO  TO CCICH3 Eval NtxProgress() Every 1
CLOSE ALL
 
***************************************************************
USE CCBBanC
PACK
 
win_sgraph(0,0,1,cCorDad,15,2,70,"Arquivo de Bancos - I")
INDEX  ON NBANCO TO CCIban1 Eval NtxProgress() Every 1
 
win_sgraph(0,0,1,cCorDad,15,2,70,"Arquivo de Bancos - II")
INDEX  ON  BANCO TO CCIban2 Eval NtxProgress() Every 1
 
win_sgraph(0,0,1,cCorDad,15,2,70,"Arquivo de Bancos - III")
INDEX ON NCONTA TO CCIban3 Eval NtxProgress() Every 1
 
CLOSE ALL
***************************************************************
win_sgraph(0,0,1,cCorDad,15,2,70,"Arquivo de Usuariuos")
USE CCBUSU
PACK
INDEX ON CODUSU TO CCIUSU Eval NtxProgress() Every 1
 
CLOSE ALL
WIN_SGRAPH(0,0,3)
* Winclose()   /* that background screen ! */
WINDONE()
RestScreen(00,00,MaxRow(),MaxCol(),sTelaInd)
return
 
***********************************
* EOP Ccindice.prg
