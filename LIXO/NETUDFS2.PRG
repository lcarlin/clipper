* Bop NetUdfs2.prg
 
FUNCTION SOMBRA2(LINHA1,COLUNA1,LINHA2,COLUNA2)
COLUNA=SAVESCREEN(LINHA1+1,COLUNA2+1,LINHA2+1,COLUNA2+1)
LINHA =SAVESCREEN(LINHA2+1,COLUNA1+1,LINHA2+1,COLUNA2+1)
FOR I = 2 TO LEN(COLUNA)  STEP 2
 COLUNA=STUFF(COLUNA,I,1,CHR(8))
NEXT
FOR I = 2 TO LEN(LINHA) STEP 2
 LINHA=STUFF(LINHA,I,1,CHR(8))
NEXT
RESTSCREEN(LINHA1+1,COLUNA2+1,LINHA2+1,COLUNA2+1,COLUNA)
RESTSCREEN(LINHA2+1,COLUNA1+1,LINHA2+1,COLUNA2+1,LINHA)
RETURN(.T.)
 
***************************************************
FUNCTION SEEKREC ( Key )
RETURN dbseek(Key)
 
**********************************************
FUNCTION GRAVA
FOR i=1 TO FCOUNT()
    CPO=FIELDNAME(i)
    VAR="V"+CPO
    IF &VAR.!=&CPO.
       REPLACE  &CPO. WITH &VAR.
       COMMIT
    ENDIF
NEXT
RETURN ""
 
****************************************************************************
FUNCTION STRPIC (w_valor , v_tam, w_dec)
DO CASE                 && VALIDACAO DE PARAMETROS
   CASE w_dec == NIL
        w_dec = 0
   CASE PCOUNT()=1
        w_tam = INT(LEN(STR(INT(w_valor))) + (LEN(STR(INT(w_valor)))-1)/3)
        w_dec = 0
ENDCASE
IF w_valor < 0
   neg = .T.
   w_valor = 0 - w_valor
ELSE
   neg = .F.
ENDIF
xw_valor = LTRIM(str(int(w_valor)))
xw_dec   = SUBSTR( LTRIM(  STR((w_valor - int(w_valor)),18,w_dec) ),3,w_dec)
xlen   = LEN(  xw_valor )
result = space(0)
DO WHILE .T.
   IF ( xlen - 3 ) > 0
      result = "." + SUBSTR(xw_valor,xlen-3+1,3)  + result
      xlen = xlen - 3
   ELSE
      result = SUBSTR(xw_valor,1,xlen) + result
      EXIT
   ENDIF
ENDDO
* SET COLOR TO
IF w_dec > 0          &&  decimais
   result = result + "," + xw_dec
ENDIF
IF neg                && negative number
   result = "-" + result
ENDIF
IF w_tam - LEN(result) >= 0        && alinhado a direita
   RETURN SPACE( w_tam-LEN(result) ) + result
ELSE
   RETURN replicate ("*",w_tam)    && insuficiente space
ENDIF
 
*************************************
FUNCTION ADDREC(nSegundos)
LOCAL PSEMPRE
APPEND BLANK
IF .NOT. neterr()
   RETURN (.T.)
ENDIF
PSEMPRE = (nSegundos = 0)
DO WHILE (PSEMPRE .OR. nSegundos > 0)
   APPEND BLANK
   IF .NOT. neterr()
      RETURN (.T.)
   ENDIF
   INKEY(0.5)
   SEGUNDOS = SEGUNDOS - 0.5
ENDDO
RETURN (.F.)
 
*************************************
FUNCTION QUENTRAVA()
IF ASSINATURA <> "   "
   mensagem("O Usu rio " +ASSINATURA+ " travou o Registro")
   RETURN
ENDIF
cArquivo := alias()
SELECT SEMAFORO
SEEK cArquivo
IF ASSINATURA <> "   "
   mensagem("O Usu rio " +ASSINATURA+" travou o Arquivo")
   SELECT (cArquivo)
   RETURN
ENDIF
SELECT (cArquivo)
RETURN
 
*************************************
FUNCTION NETUSE(cArquivo,lModo,nSegundos,cRdd)
LOCAL PSEMPRE
IF cRdd == NIL
   cRdd := "DBFNTX"
ENDIF
PSEMPRE = (PSEMPRE = 0)
DO WHILE (PSEMPRE .OR. nSegundos > 0)
   dbUseArea(.T., cRdd, cArquivo, Nil, lModo)
   IF .NOT. neterr()
      RETURN (.T.)
   ENDIF
   nSegundos = nSegundos - 1
ENDDO
RETURN (.F.)
 
*************************************
FUNCTION RECLOCK (nSegundos)
LOCAL PSEMPRE
    IF rlock()
       REPLACE ASSINATURA WITH IDENTIFICA
       COMMIT
       RETURN (.T.)
    ENDIF
PSEMPRE = (nSEGUNDOS = 0)
DO WHILE (PSEMPRE .OR. nSEGUNDOS > 0)
   IF RLOCK()
      REPLACE ASSINATURA WITH IDENTIFICA
      COMMIT
      RETURN (.T.)
   ENDIF
   INKEY(0.5)
   nSEGUNDOS = nSEGUNDOS - 0.5
ENDDO
RETURN (.F.)
 
*************************************
FUNCTION DESTRAVA ()
IF ASSINATURA = IDENTIFICA
   REPLACE ASSINATURA WITH "   "
   UNLOCK
   RETURN
ENDIF
 
ARQUIVO := DBF()
SELECT SEMAFORO
SEEK ARQUIVO
IF ASSINATURA = IDENTIFICA
   REPLACE ASSINATURA WITH "   "
ENDIF
SELECT (ARQUIVO)
UNLOCK
RETURN
 
*************************************
FUNCTION FILOCK(nSEGUNDOS)
LOCAL PSENPRE, cARQUIVO
cARQUIVO := alias()
IF FLOCK()
   SELECT SEMAFORO
   SEEK cARQUIVO
   IF RECLOCK(4)
      REPLACE ASSINATURA WITH IDENTIFICA
   ENDIF
   SELECT (ARQUIVO)
   RETURN (.T.)
ENDIF
PSEMPRE := (nSEGUNDOS = 0 )
DO WHILE (PSEMPRE .OR. nSEGUNDOS > 0)
   INKEY (.5)
   nSEGUNDOS = nSEGUNDOS - 0.5
   IF FLOCK()
      SELECT SEMAFORO
      SEEK cARQUIVO
      IF RECLOCK(4)
         REPLACE ASSINATURA WITH IDENTIFICA
      ENDIF
      SELECT (cARQUIVO)
      RETURN (.T.)
   ENDIF
ENDDO
RETURN (.F.)
****************************************
 
FUNCTION MYALERT(cMsg,aOpcoes,cColor,nLin,nCol)
LOCAL aMsg := {},nLinT := nColE := nLinB := nColD := i := nTamMax := x := 0
LOCAL nOpcao := 0,cTlAlert := "",cCorAnt := ""
 
* --- Trata os parametros passados...
IF cColor = NIL                        // Se nao passou cor assumo...
   cColor = "W+/R,N/W"
ENDIF
 
* --- Trata o array de opcoes
aOpcoes := IF(aOpcoes = NIL,{"Ok"},aOpcoes)
 
* --- Separa a string em ocorrencias do array
aMsg := xDELIMIT(cMsg)
 
* --- Calcula a MAIOR opcao do array
AEVAL(aOpcoes,{|cOpc| i += 2+LEN(ALLTRIM(cOpc))})
 
* --- Calculo mais um espaco entre as Opcoes
i += LEN(aOpcoes)-1
 
* --- Calcula a MAIOR mensagem no array
AEVAL(aMsg,{|cStr| nTamMax := MAX(LEN(ALLTRIM(cStr)),nTamMax)})
 
* --- Determina o MAIOR dos dois arrays (aMsg,aOpcoes)
nTamMax := MAX(nTamMax,i)+2
 
* --- Calcula as coordenadas do BOX
nLinT := IF(nLin=NIL,12-((LEN(aMsg)+3)/2),nLin)          // Linha do Topo
nColE := IF(nCol=NIL,40-((nTamMax+1)/2),nCol)            // Coluna Esquerda
nLinb := nLinT + LEN(aMsg)+3                             // Linha aBaixo
nColD := nColE + nTamMax + 1                             // Coluna Direita
 
* --- Salva a tela
cTlAlert = SAVESCREEN(nLinT,nColE,nLinB+1,nColD+2)
 
* --- Desenho o Box
JANELA(nLinT,nColE,nLinB,nColD," Aten‡„o ","",cColor)
 
* --- Mostra a mensagem centralizada no BOX
x := nLinT + 1
AEVAL(aMsg,{|cStr| DEVPOS(x++,CENTER_TXTBOX(nColE,nColD,LEN(cStr))),DEVOUT(cStr,cColor)})
 
* --- Calcula a Coluna da primeira opcao
i := CENTER_TXTBOX(nColE,nColD,i)
 
* --- Seta cor e salva anterior
cCorAnt := SETCOLOR(cColor)
 
* --- Monta as Opcoes
AEVAL(aOpcoes,{|cOpcao| __ATPROMPT(nLinB-1,i," "+cOpcao+" "), i+=LEN(cOpcao)+3})
 
* --- Chama MENU TO...
MENU TO nOpcao
 
* --- Restaura a area utilizada
RESTSCREEN(nLinT,nColE,nLinB+1,nColD+2,cTlAlert)
 
* --- Restaura a cor anterior
SETCOLOR(cCorAnt)
 
* --- Retorna a Opcao escolhida
RETURN(nOpcao)
*******************************
FUNCTION xDELIMIT(cString,cDelimit)
LOCAL x,a := {}
cDelimit := IF(cDelimit=NIL,";",cDelimit)
WHILE (x := AT(cDelimit,cString)) # 0
      AADD(a,SUBS(cString,1,x-1))
      cString := SUBS(cString,x+LEN(cDelimit))
END
AADD(a,SUBS(cString,x+LEN(cDelimit)))
RETURN (a)
*****************************
FUNCTION center_txtbox(col_ini,col_fin,tam_txt)
RETURN((INT((col_fin - col_ini + 1)/2) - INT(tam_txt/2))+col_ini)
 
* eop NetUdfs2.prg
