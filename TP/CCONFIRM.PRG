****************************
 function   Confirma (texto)
****************************
LOCAL cBotao1:="Sim"
LOCAL cBotao2:="Nao"
LOCAL nTecla := 0
LOCAL nOpc   := 1
LOCAL lRet   := .T.
LOCAL nCBotao:=34
LOCAL nCurs:=setcursor(0)
LOCAL nL, nAx, NUMERO, CI, NL1, NL2
save screen to tela_ant
cor    := setcolor("w/n")
nCursor := setcursor(0)
IF valtype (texto) = "A"
   nL     := len(texto)
   nAx    := int((25-nl)/2)
   NUMERO := LEN(TEXTO[1])+2
   CI     := INT((80 - NUMERO)/2)
   nL1    := nAx-1
   nL2    := nAx+2+nL
ELSE
   NUMERO := LEN(TEXTO)+2
   CI     := INT((80 - NUMERO)/2)
   nL1 := 10
   nL2 := 14
ENDIF

setcolor("gr+/b")
SOMBRA(nL1,CI,nL2,CI+NUMERO)
setcolor("r+/N")
IF valtype(texto) = "A"
   FOR I := 1 TO nL
       @ nL1+i,CI+1 SAY TEXTO[I]
   NEXT
   nL1+=nL-1
ELSE
    @ nL1+1,CI+1 SAY TEXTO
ENDIF
setcolor("r+/b")
@ nL1+2,34 SAY CHR(16)+cBotao1+chr(17)
@ nL1+2,39 SAY     "�" COLOR "N+/N"
@ nL1+3,35 SAY "�����" COLOR "N+/N"
@ nL1+2,42 SAY " Nao "
@ nL1+2,47 SAY     "�" COLOR "N+/N"
@ nL1+3,43 SAY "�����" COLOR "N+/N"
DO WHILE .T.
   nTecla := inkey(0)
   IF nTecla = 19       // seta p/ esquerda
      nOpc --
      nCBotao := 34
      IF nOpc <1
         nOpc := 2
         nCBotao := 42
      ENDIF
   ELSEIF nTecla = 4    // seta p/ direita
      nOpc ++
      nCBotao := 42
      IF nOpc > 2
         nOpc := 1
         nCBotao := 34
      ENDIF
   ELSEIF nTecla = 13  // Enter
      sTela:=Savescreen(nL1+2,nCBotao,nL1+3,nCbotao+6)
      @ nL1+2,nCBotao SAY "      " color "w/n"
      @ nL1+3,nCBotao SAY "      " color "w/n"
      cBotAx := "cBotao"+str(nOpc,1,0)
      @ nL1+2,nCBotao+1 SAY CHR(16)+ &cBotAx + chr(17)
      INKEY(.2)
      restscreen(nL1+2,nCBotao,nL1+3,nCbotao+6,sTela)
      INKEY(.2)
      lRet := if(nOpc=1,.T.,.F.)
      EXIT
   ELSEIF nTecla = 27  //Esc
      lRet := .f.
      EXIT
   ENDIF
   @ nL1+2,34 SAY " Sim "
   @ nL1+2,42 SAY " Nao "
   cBotAx := "cBotao"+str(nOpc,1,0)
   @ nL1+2,nCBotao SAY CHR(16)+ &cBotAx + chr(17)
ENDDO
setcursor(nCurs)
setcolor(cor)
restore screen from tela_ant
RETURN (lRet)
