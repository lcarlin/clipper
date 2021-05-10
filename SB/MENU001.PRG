#include "winclas.ch"
LOCAL nOpc, nOpc3, nOpc4, nOpc5, nOpc6, nOpc6a
OBJECT STATIC oJanMenu
OBJECT STATIC oJanGeral
PUBLIC cCortela ,cCorTitulo, cCorBat, cCorBin, cCorSubMenu, cCorServ, cCorDialog, cCorBat2
PUBLIC cCorMenu ,cCorPAdra , cCorJanela, cCorRegua
PUBLIC vDados1, vDados2, vDados3, vDados4,vDados5,vDados5,vDados6
PUBLIC aNivel, cNivel, lAtlCor
 
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   quentrava()
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   quentrava()
   return
endif
SELECT 3
IF netuse("dados",.f.,10)
   vdados1 := SPACE(40)
   vdados2 := SPACE(30)
   vdados3 := SPACE(20)
   vdados4 := SPACE(18)
   vdados5 := SPACE(15)
   vdados6 := SPACE(10)
   vdados7 := SPACE(10)
   vdados8 := SPACE(10)
   vdados1 := dados1
   vdados2 := dados2
   vdados3 := dados3
   vdados4 := dados4
   vdados5 := dados5
   vdados6 := dados6
   vdados7 := dados7
   vdados8 := dados8
   if dados1 = SPACE(40) .or. dados2 =  SPACE(30) .or. ;
      dados3 = SPACE(20) .or. dados4 =  SPACE(18) .or. ;
      dados5 = SPACE(15) .or. dados6 =  SPACE(10) .or. ;
      dados7 = SPACE(10) .or. dados8 =  SPACE(10)
 
      SOMBRA(08,09,18,70,,"W/R")
      SETCOLOR("W/R")
      centracl(08,09,70,"Dados para o Sistema")
      @ 09,11 SAY '  Razao Social  :                                         '
      @ 10,11 SAY '      Endereco  :                                         '
      @ 11,11 SAY '        Cidade  :                                         '
      @ 12,11 SAY '        CGC/MF  :                                         '
      @ 13,11 SAY 'Insc. Estadual  :                                         '
      @ 15,11 SAY 'Grafico de tela :                                         '
      @ 16,11 SAY '                                                          '
      @ 17,11 SAY '                                                          '
      @ 09,29 GET vdados1 PICT "@" VALID VDADOS1 <> SPACE(40)
      @ 10,29 GET vdados2 PICT "@" VALID VDADOS2 <> SPACE(30)
      @ 11,29 GET vdados3 PICT "@" VALID VDADOS3 <> SPACE(20)
      @ 12,29 GET vdados4 PICT "@ 99.999.999/9999-99" VALID VDADOS4 <> SPACE(18)
      @ 13,29 GET vdados5 PICT "@ 999.999.999.999"    VALID VDADOS5 <> SPACE(15)
      @ 15,29 GET vdados6 PICT "@!"
      @ 16,29 GET vdados7 PICT "@!"
      @ 17,29 GET vdados8 PICT "@!"
      READ
 
      if reclock(0)
         replace  dados1 with vdados1 ,;
                  dados2 with vdados2 ,;
                  dados3 with vdados3 ,;
                  dados4 with vdados4 ,;
                  dados5 with vdados5 ,;
                  dados6 with vdados6 ,;
                  dados7 with vdados7 ,;
                  dados8 with vdados8
          destrava()
       endif
      vdados1 := dados1
      vdados2 := dados2
      vdados3 := dados3
      vdados4 := dados4
      vdados5 := dados5
      vdados6 := alltrim(dados6)
      vdados7 := alltrim(dados7)
      vdados8 := alltrim(dados8)
   ENDIF
else
   QUENTRAVA()
   return
ENDIF
CLOSE ALL
IF .NOT. file("cores.mem")
   cCorTmpa:= "w+ /n  ,n  /w  ,n,n,gr+/n  "
   cCorTmme:= "n  /w  ,w+ /b  ,n,n,w+ /b  "
   cCorTmbo:= "w+ /r  ,n  /g  ,n,n,w+ /r  "
   cCorTmca:= "w+ /bg "
   cCorTmre:= "w+ /bg "
   cCorTmla:= "w+ /b  "
   cCorTmte:= "b  /bg "
   save all like cCortm* to cores
   cCorpadra:= cCorTmpa
   cCormenu:= cCorTmme
   cCortela:= cCorTmte
   cCorbotao:= cCorTmbo
   cCorregua:= cCorTmre
   cCorlayou:= cCorTmla
   cCorcaixa:= cCorTmca
ELSE
   RESTORE FROM CORES ADDITIVE
   cCorpadra:= cCorTmpa   //   := "w+ /n  ,n  /w  ,n,n,gr+/n  "
   cCormenu := cCorTmme   //   := "n  /w  ,w+ /b  ,n,n,w+ /b  "
   cCortela := cCorTmte   //   := "b  /bg "
   cCorbotao:= cCorTmbo   //   := "w+ /r  ,n  /g  ,n,n,w+ /r  "
   cCorregua:= cCorTmre   //   := "w+ /bg "
   cCorlayou:= cCorTmla   //   := "w+ /b  "
   cCorcaixa:= cCorTmca   //   := "w+ /bg "
ENDIF
 
cCorTitulo := substr(cCorMENU ,21,7)
cCorSubMenu:= substr(cCorMenu ,9,7)
cCorBat    := substr(cCorBotao,9,7)
cCorBat2   := substr(cCorBotao,21,7)
cCorBin    := substr(cCorBotao,1,7)
cCorServ   := substr(cCorMenu ,21,7)
cCorTitul2 := SubStr(cCorRegua,01,7)
cCorjanela := substr(cCorMenu ,09,7)+","+ substr(cCorPadra,9,7)
/* ambiente */
SET MESSAGE TO 24
SET SCORE   OFF
SET KEY     -41 TO calcul
SET DELETE  ON
SET DATE TO BRITISH
setblink(.t.)
 
 
/* Variaveis dos botoes dos menus */
aOpcoes :={{05,03," Movimento Banc rio ","Entrada no Sistema de Movimenta‡„o banc ria"},;
           {07,03," Cadastra Usuarios  ","Cadastra Usuarios Novos"},;
           {09,03," Cores do Sistema   ","Modifica todas as cores do sistema"},;
           {11,03," Reindexa Arquivos  ","Reindexa todos os ¡ndices de todos os arquivos"},;
           {13,03," Saida do sistema   ","Rertorna ao Sistema Operacional"}}
 
aNivel := {"1-Supervisor",;
           "2-Gerente   ",;
           "3-Operador  ",;
           "4-Tecnicos  "}
 
nOpc := nOpc3 := nOpc4 := nOpc5 := nOpc6 := nOpc6a := 0
oJanMenu := WindowNew(04,02,15,25)
oJanGeral := WindowNew(10,09,17,40)
oJanServ  := WindowNew(10,09,17,40)
 
.oJanMenu:border  := "         "
.oJangeral:Border := "         "
.oJanServ:Border  := "         "
 
.oJanmenu:Color   := substr(cCorMenu,1,7)
.oJanGeral:Color  := cCorSubMenu
.oJanServ:Color    := cCorServ
 
.oJanMEnu:ColTitle  := substr(cCorMenu,1,7)
.oJanGeral:ColTitle := cCorSubmenu
.oJanServ:ColTitle  := cCorServ
.oJanMenu:Title := "Menu Principal"
lAtlCor := .T.
DO WHILE .T.
   setcolor(cCorTela)
   IF lAtlCor
      nNivel := val(cNivel)
      .oJanmenu:Color   := substr(cCorMenu,1,7)
      .oJanGeral:Color  := cCorSubMenu
      .oJanServ:Color    := cCorServ
 
      .oJanMEnu:ColTitle  := substr(cCorMenu,1,7)
      .oJanGeral:ColTitle := cCorSubmenu
      .oJanServ:ColTitle  := cCorServ
 
 
      @ 00,00 CLEAR TO maxrow(),maxcol()
      setcolor(cCorTitul2)
      centra(00," Sistema de Controle Bancario V 1.00","G+/N")
      cTitulo:="-> Usu rio:"+identifica+"               Nome:"+vquem+"               Status:"+aNivel[nNivel]+"<-"
      @ 01,00 SAY padr(cTitulo,80," ")
 
      banner(03,vdados6,cCorTela)
      Banner(10,vdados7,ccorTela)
      Banner(17,vdados8,ccorTela)
 
      centra(23," Desenvolvido por TEC MAQ INFORMATICA - Fone : (014) 351-1728","W+/G")
      .oJanMenu:OpenWin()
      SAVE SCREEN TO TELA001
      lAtlCor := .F.
   endif
   RESTORE SCREEN FROM TELA001
   setcolor(cCorMenu)
   nOpc := Botao(aOpcoes,,cCorBin,cCorbat)
   DO CASE
      CASE nOpc = 1
           MenuBanc ()
      CASE nOpc = 2
           cadusu ()
      CASE nOpc = 3
           centra(24,"")
           cores()
           lAtlCor := .t.
           RESTORE FROM CORES ADDITIVE
           cCorpadra:= cCorTmpa   //   := "w+ /n  ,n  /w  ,n,n,gr+/n  "
           cCormenu := cCorTmme   //   := "n  /w  ,w+ /b  ,n,n,w+ /b  "
           cCortela := cCorTmte   //   := "b  /bg "
           cCorbotao:= cCorTmbo   //   := "w+ /r  ,n  /g  ,n,n,w+ /r  "
           cCorregua:= cCorTmre   //   := "w+ /bg "
           cCorlayou:= cCorTmla   //   := "w+ /b  "
           cCorcaixa:= cCorTmca   //   := "w+ /bg "
           cCorTitulo := substr(cCorPadra,21,7)
           cCorSubMenu:= substr(cCorMenu ,9,7)
           cCorBat    := substr(cCorBotao,9,7)
           cCorBat2   := substr(cCorBotao,21,7)
           cCorBin    := substr(cCorBotao,1,7)
           cCorServ   := substr(cCorMenu ,21,7)
           cCorTitul2 := SubStr(cCorRegua,01,7)
           cCorjanela := substr(cCorMenu ,09,7)+","+ substr(cCorPadra,9,7)
      CASE nOpc = 4
           Indexa()
     CASE nOpc = 0 .OR. nOpc = 5
          IF confirma("Deseja Realmente Sair ?",cCorCaixa)
             EXIT
          ENDIF
   ENDCASE
ENDDO
* eop menu001.prg
