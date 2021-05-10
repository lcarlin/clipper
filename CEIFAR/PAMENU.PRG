/*
bop pamenu
sistema  : ceifar
objetivo : menu principal do sistema programa de acompanhamento
data     : 04/03/96
autor    : Luiz
*/
 
#include "winclas.ch"
 
LOCAL nOpc, nOpc3, nOpc4, nOpc5, nOpc6, nOpc6a
OBJECT STATIC oJanMenu
OBJECT STATIC oJanGeral
PUBLIC nDosLIn := row()
PUBLIC nDosCol := col()
PUBLIC sDosTela := savescreen (00,00,maxrow(),maxcol())
PUBLIC cCortela ,cCorTitulo, cCorBat, cCorBin, cCorSubMenu, cCorServ, cCorDialog
 
 
/* ambiente */
 
SET SCORE OFF
SET DATE   TO BRITISH
SET DELETE ON
SET MESSAGE TO 23
SETBLINK(.T.)
 
 
 
/* VERIFICAR DBF'S , NTX'S , MEM'S */
 
IF .NOT. file("cores.mem")
   IF .F.
      cCortela   := "gr+/bg,n  /w"
      cCorTitulo := "gr+/b"
      cCorBat    := "w+ /r"
      cCorBin    := "n+ /w"
      cCorSubMenu:= "gr+/rb"
      cCorServ   := "gr+/b"
      cCorDialog := "gr+/r"
   ELSE
      cCortela   := "w  /n,n  /w"
      cCorTitulo := "w+ /n"
      cCorBat    := "n  /w"
      cCorBin    := "w+ /n"
      cCorSubMenu:= "w+ /n"
      cCorServ   := "w  /n"
      cCorDialog := "n  /w"
 
   ENDIF
ELSE
   RESTORE FROM CORES ADDITIVE
ENDIF
 
 
?
? "Aguarde ....."
?
 
/* arquivos de DADOS */
 
IF (.NOT. file("PABUSUA1.DBF"))    //  .OR. (.NOT file("PABUSUA1.DBT"))
  ?"Criando Arquivo de usuarias - I"
   aEstru := {{"CODIGO    ","C",05,0},;
              {"NOME      ","C",40,0},;
              {"DATINSC   ","D",08,0},;
              {"PROCEDe   ","C",35,0},;
              {"CIDRES    ","C",35,0},;
              {"INSTRUTORA","C",05,0},;
              {"DATNASC   ","D",08,0},;
              {"ENDERECO  ","C",40,0},;
              {"FONERES   ","C",16,0},;
              {"FONETRAB  ","C",16,0},;
              {"SITCONJU  ","N",01,0},;
              {"GRINSTRU  ","N",01,0},;
              {"NOMECOMP  ","C",40,0},;
              {"ENDCOMP   ","C",40,0},;
              {"FONERESCMP","C",16,0},;
              {"FONTRABCMP","C",16,0},;
              {"GRINSTRUCP","N",01,0},;
              {"NRFILHOS  ","N",02,0},;
              {"ID_ULT_FIL","N",02,0},;
              {"INDICACAO ","N",02,0},;
              {"ULTMENST  ","D",08,0},;   // DIVIDIR AQUI, SE NECESSARIO
              {"PLANFAMI  ","N",01,0},;
              {"PLANFAMIPO","N",01,0},;
              {"AMAMENTA  ","N",01,0},;
              {"P_PART_AMA","N",01,0},;
              {"ABORTO_RES","N",01,0},;
              {"MENOPAUSA ","N",01,0},;
              {"OVULACAO  ","N",01,0},;
              {"CICLOS    ","N",01,0},;
              {"PILULAS   ","N",01,0},;
              {"NOME_PILU ","C",20,0},;
              {"ULT_PIL_D ","C",10,0},;
              {"MOTIVO_PIL","C",40,0},;
              {"EFEITO_P  ","C",40,0},;
              {"DIU       ","N",01,0},;
              {"TEMPO_DIU ","C",15,0},;
              {"MOTIVO_DIU","C",40,0},;
              {"EFEITO_DIU","C",40,0},;
              {"ENGR_PIL  ","N",01,0},;
              {"ENGR_DIU  ","N",01,0},;
              {"MART_ANT_P","N",01,0},;
              {"MART_ANT_D","N",01,0},;
              {"MART_ANT_C","N",01,0},;
              {"MART_ANT_E","N",01,0},;
              {"ENGR_MART ","N",01,0},;
              {"ENG_MART_N","C",25,0},;
              {"ENG_MART_T","C",10,0},;
              {"MOT_OVOLU1","C",01,0},;
              {"MOT_OVOLU2","C",01,0},;
              {"MOT_OVOLU3","C",01,0},;
              {"SITUACAO  ","N",01,0},;
              {"SITUA_1   ","N",02,0}}
   dbcreate("PABUSUA1",aEstru)
ENDIF
 
IF (.NOT. file("PABINST.DBF"))
  ?"Criando Arquivo de Instrutoras"
   aEstru := {{"CODIGO    ","C",05,0},;
              {"NOME      ","C",40,0},;
              {"DATINIC   ","D",08,0},;
              {"DATNASC   ","D",08,0},;
              {"ENDERECO  ","C",40,0},;
              {"FONERES   ","C",16,0},;
              {"FONETRAB  ","C",16,0}}
   dbcreate("PABINST",aEstru)
ENDIF
 
IF (.NOT. file("PABATV.DBF"))
  ?"Criando Arquivo de atividades"
   aEstru := {{"COD_ATI   ","N",02,0},;
              {"DESC_ATI  ","C",30,0}}
   dbcreate("PABATV",aEstru)
ENDIF
 
IF (.NOT. file("PABLATV.DBF"))
  ?"Criando arquivo de Lan‡amentos de Atividades"
   aEstru := {{"COD_ATIV  ","N",02,0},;
              {"DESC_ATIV ","C",30,0},;
              {"DAT_ATIV  ","D",08,0}}
   dbcreate("PABLATV",aEstru)
ENDIF
 
IF (.NOT. file("PABGRU.DBF"))
  ?"Criando Arquivo de Grupos"
   aEstru := {{"COD_gru   ","N",02,0},;
              {"DESC_GRU  ","C",30,0}}
   dbcreate("PABgru",aEstru)
ENDIF
 
IF (.NOT. file("PABPATG.DBF"))
  ?"Criando Arquivo de Participantes de Grupos"
   aEstru := {{"COD_GR    ","N",02,0},;
              {"NOME      ","C",40,0},;
              {"COD_USUA  ","C",05,0},;
              {"NOME_USUA ","C",40,0},;
              {"DATNASC   ","D",08,0},;
              {"ENDERECO  ","C",40,0},;
              {"FONERES   ","C",16,0},;
              {"FONETRAB   ","C",16,0}}
   dbcreate("PABPATG",aEstru)
ENDIF
 
IF (.NOT. file("PABatd.DBF"))
  ?"Criando Arquivo de Atendimentos..."
   aEstru := {{"COD_atd   ","N",02,0},;
              {"DESC_atd  ","C",30,0}}
   dbcreate("PABatd",aEstru)
ENDIF
 
 
 
IF (.NOT. file("PABLATd.DBF"))
  ?"Criando Arquivo de Lan‡amentos de Atendimentos"
   aEstru := {{"COD_UsU   ","C",05,0},;
              {"NOME      ","C",40,0},;
              {"DAT_ATEND ","D",08,0},;
              {"DESC_ATD  ","C",30,1},;
              {"COD_ATD   ","N",01,0}}
   dbcreate("PABLATd",aEstru)
ENDIF
 
/* NTX'S */
IF .NOT. file("paiinst1.ntx") .OR. (.NOT. file("PAIINST2.NTX"))
   ?"Aguarde ! Organizando Arquivo de Instrutoras..."
   USE PABINST
   INDEX ON CODIGO TO PAIINST1
   INDEX ON NOME   TO PAIINST2
   CLOSE ALL
ENDIF
 
IF .NOT. file("paiatv1.ntx") .OR. (.NOT. file("PAIatv2.NTX"))
   ?"Aguarde ! Organizando Arquivo de Atividades..."
   USE PABATV
   INDEX ON COD_ATI  TO PAIATV1
   INDEX ON DESC_ATI TO PAIATV2
   CLOSE ALL
ENDIF
 
IF .NOT. file("paiusu1.ntx") .OR. (.NOT. file("PAIusu2.NTX"))
   ?"Aguarde ! Organizando Arquivo de Usu rias..."
   USE PABusuA1
   INDEX ON CODIGO   TO PAIUSU1
   INDEX ON NOME     TO PAIUSU2
   CLOSE ALL
ENDIF
 
IF .NOT. file("paigru1.ntx") .OR. (.NOT. file("PAIgru2.NTX"))
   ?"Aguarde ! Organizando Arquivo de Grupos I"
   USE PABgru
   INDEX ON COD_GRU  TO PAIGRU1
   INDEX ON DESC_GRU TO PAIGRU2
   CLOSE ALL
ENDIF
 
IF .NOT. file("paiatd1.ntx") .OR. (.NOT. file("PAIatd2.NTX"))
   ?"Aguarde ! Organizando Arquivo de Atendimentos I "
   USE PABATD
   INDEX ON COD_ATD  TO PAIATD1
   INDEX ON DESC_ATD TO PAIATD2
   CLOSE ALL
ENDIF
 
 
/* Variaveis dos botoes dos menus */
 
aOpcoes :={{05,03,"1 - Cadastro de Usu rias    "},;
           {07,03,"2 - Cadastro de Instrutoras "},;
	   {09,03,"3 - Controle de Atividades  "},;
	   {11,03,"4 - Controle de Grupos      "},;
	   {13,03,"5 - Controle de Atendimentos"},;
	   {15,03,"6 - Relat¢rios Diverso      "},;
           {17,03,"7 - Saida                   "}}
 
aOpcoes3:={{11,10,"1 - Cadastro das Atividades  "},;
           {13,10,"2 - Lancamento das Atividades"},;
           {15,10,"3 - Menu Anterior            "}}
 
aOpcoes4:={{13,10,"1 - Cadastro dos Grupos                  "},;
           {15,10,"2 - Cadastro das Participantes dos Grupos"},;
           {17,10,"3 - Menu Anterior                        "}}
 
aOpcoes5:={{15,10,"1 - Lan‡amento de Atendimentos        "},;
           {17,10,"2 - Cadastro das Tipos de Atendimentos"},;
           {19,10,"3 - Menu Anterior                     "}}
 
aOpcoes6:={{05,10,"1 - Usu rias por Ordem Alfabetica                "},;
           {07,10,"2 - Usu rias por Ordem Numerica                  "},;
           {09,10,"3 - Usu rias Ativas (Classificadas p/ Situa‡„o)  "},;
	   {11,10,"4 - Usu rias Inativas (Classificadas p/ Situa‡„o)"},;
	   {13,10,"5 - Instrutoras Cadastradas                      "},;
	   {15,10,"6 - Atividades p/ determinado Periodo            "},;
	   {17,10,"7 - Resumo dos Grupos (tipo do Grupo e Usu rios) "},;
	   {19,10,"8 - Resumo de Atendimento                        "},;
	   {21,10,"9 - Menu Anterior                                "}}
 
aOpcoes6a:={{17,10,"1 - Antendimento                                "},;
            {19,10,"2 - Atendimento de Seguimento                   "},;
            {21,10,"3 - Menu Principal                              "}}
 
nOpc := nOpc3 := nOpc4 := nOpc5 := nOpc6 := nOpc6a := 0
oJanMenu := WindowNew(04,02,19,32)
oJanGeral := WindowNew(10,09,17,40)
oJanServ  := WindowNew(10,09,17,40)
 
.oJanMenu:border  := "         "
.oJangeral:Border := "         "
.oJanServ:Border  := "         "
 
.oJanmenu:Color   := cCorTitulo
.oJanGeral:Color  := cCorSubMenu
.oJanServ:Color    := cCorServ
 
.oJanMEnu:ColTitle  := cCorTitulo
.oJanGeral:ColTitle := cCorSubMenu
.oJanServ:ColTitle  := cCorServ
 
.oJanMenu:Title := "Menu Principal"
setcolor(cCorTela)
@ 00,00,maxrow(),maxcol() BOX "±±±±±±±±±"
*@ 00,00 CLEAR TO maxrow(),maxcol()
setcolor(cCorTitulo)
centra(00," Programa p/ Acompanhamento de Usu rias de Planejamento Natural de Familia ",cCortitulo)
centra(01," Centro de Integra‡„o Familiar ",cCorTitulo)
centra(02," Piraju - SP",cCortitulo)
centra(24," Desenvolvido por Tec Maq Inform tica - Fone : (014) 351-1728",cCorTitulo)
 
DO WHILE .T.
   .oJanMenu:OpenWin()
   setcolor(cCorTitulo)
   nOpc := Botao(aOpcoes,,cCorBin,cCorbat)
*  .oJanMEnu:CloseWin()
   DO CASE
      CASE nOpc = 1
           .oJanServ:Title := "Manuten‡„o de Usu rias"
           .oJanServ:top   := 07
           .oJanServ:Left  := 07
           .oJanServ:Bottom:= 18
           .oJanServ:Right := 73
           .oJanServ:OpenWin()
           DO pamtusu1
           .oJanServ:closewin()
      CASE nOpc = 2
           .oJanServ:Title := "Manuten‡„o de Instrutoras"
           .oJanServ:top   := 07
           .oJanServ:Left  := 07
           .oJanServ:Bottom:= 15
           .oJanServ:Right := 69
           .oJanServ:OpenWin()
           DO pamtinst
           .oJanServ:closewin()
      CASE nOpc = 3
           .oJanGeral:top   := 10
           .oJanGeral:Left  := 09
           .oJanGeral:Bottom:= 17
           .oJanGeral:Right := 40
           .oJanGeral:TiTle := "Controle De Atividades"
	   .oJanGeral:OpenWin()
           setcolor(cCorSubmenu)
           nOpc3 := Botao(aOpcoes3,,cCorBin,cCorbat)
           setcolor(cCorTitulo)
           IF nOpc3 = 1
              .oJanServ:top   := 09
              .oJanServ:Left  := 06
              .oJanServ:Bottom:= 12
              .oJanServ:Right := 58
              .oJanServ:TiTle := "Cadastro De Atividades"
	      .oJanServ:OpenWin()
              DO pamtatv
              .oJanServ:CloseWin()
           ELSEIF nOpc3 = 2
              .oJanServ:top   := 09
              .oJanServ:Left  := 06
              .oJanServ:Bottom:= 13
              .oJanServ:Right := 61
              .oJanServ:TiTle := "Lan‡amento de Atividades"
	      .oJanServ:OpenWin()
              DO palcatv
              .oJanServ:CloseWin()
           ENDIF
      CASE nOpc = 4
           .oJanGeral:top   := 12
           .oJanGeral:Left  := 09
           .oJanGeral:Bottom:= 18
           .oJanGeral:Right := 53
           .oJanGeral:TiTle := "Controle De Grupos"
	   .oJanGeral:OpenWin()
           setcolor(cCorSubmenu)
           nOpc4 := Botao(aOpcoes4,,cCorBin,cCorbat)
           setcolor(cCorTitulo)
           IF nOpc4 = 1
              .oJanServ:top   := 09
              .oJanServ:Left  := 06
              .oJanServ:Bottom:= 12
              .oJanServ:Right := 58
              .oJanServ:TiTle := "Cadastro De Grupos"
	      .oJanServ:OpenWin()
              DO pamtgru
              .oJanServ:CloseWin()
           ELSEIF nOpc4 = 2
              .oJanServ:top   := 09
              .oJanServ:Left  := 09
              .oJanServ:Bottom:= 18
              .oJanServ:Right := 71
              .oJanServ:TiTle := "Cadastro das Participantes de Grupos"
	      .oJanServ:OpenWin()
              DO pacapgr
              .oJanServ:CloseWin()
           ENDIF
      CASE nOpc = 5
           .oJanGeral:top   := 14
           .oJanGeral:Left  := 09
           .oJanGeral:Bottom:= 20
           .oJanGeral:Right := 50
           .oJanGeral:TiTle := "Controle De Atendimentos"
	   .oJanGeral:OpenWin()
           setcolor(cCorSubmenu)
           nOpc5 := Botao(aOpcoes5,,cCorBin,cCorbat)
           setcolor(cCorTitulo)
           IF nOpc5 = 1
              .oJanServ:top   := 09
              .oJanServ:Left  := 06
              .oJanServ:Bottom:= 15
              .oJanServ:Right := 71
              .oJanServ:TiTle := "Lan‡amentos de Atendimentos"
	      .oJanServ:OpenWin()
              DO palcatd
              .oJanServ:CloseWin()
           ELSEIF nOpc5 = 2
              .oJanServ:top   := 09
              .oJanServ:Left  := 06
              .oJanServ:Bottom:= 13
              .oJanServ:Right := 61
              .oJanServ:TiTle := "Cadastro de Atendimentos"
	      .oJanServ:OpenWin()
              DO pamtatd
              .oJanServ:CloseWin()
           ENDIF
      CASE nOpc = 6
           .oJanGeral:top   := 04
           .oJanGeral:Left  := 09
           .oJanGeral:Bottom:= 22
           .oJanGeral:Right := 60
           .oJanGeral:TiTle := "Relatorios Diversos"
	   .oJanGeral:OpenWin()
           setcolor(cCorSubmenu)
           nOpc6 := Botao(aOpcoes6,,cCorBin,cCorbat)
           setcolor(cCorTitulo)
           IF nOpc6 > 0 .AND. nOpc6 < 9
              mensagem("Modulo N„o Residente !")
            ENDIF
           .oJanGeral:CloseWin()
     CASE nOpc = 0 .OR. nOpc = 7
          IF confirma("Deseja Realmente Sair ?",cCorDialog)
             EXIT
          ENDIF
   ENDCASE
   IF nOpc >= 3 .AND. nOpc < 7
      .oJanGeral:CloseWin()
   ENDIF
ENDDO
restscreen(00,00,maxrow(),maxcol(),sDosTela)
setpos(nDosLin,nDosCol)
QUIT
 
* eop pamenu.prg
