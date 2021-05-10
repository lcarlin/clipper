/* Bop CcFunc.prg
* Funcao  Funcoes especificas do sistema
* Data 02/07/1996
* Autor  Luiz
* Sistema  Controle de Cheques
* Linguagem Clipper 5.2e
*****************************/
FUNCTION ExistBanc(_nBanc)
lret := .F.
BEGIN SEQUENCE
      SELECT CCBBANC
      SET ORDER TO 2
      SEEK _nBanc
      IF found()
         lRet := .t.
         BREAK
      ENDIF
      cCor1 := setcolor(cCorBox)
      sTelaBanc := saveScreen(14,05,18,57)
      sombra(14,05,18,55)
      @ 14,05 SAY "Bancos cadastrados"
      nTemp := Achoice(15,05,18,55,aBancos,.T.,"FunAch")
      RestScreen(14,05,18,57,sTelaBanc)
      SetColor(cCor1)
      IF nTemp = 0
         lRet := .F.
         BREAK
      ENDIF
      nBanc := Val(SubStr(aBancos[nTemp],1,2))
      keyboard chr(13)
END SEQUENCE
SELECT CCBCHQ
RETURN lRet
 
****************************************************
FUNCTION FunAch ( nModo, nElto, nLinha)
IF (nModo = 1) .OR. (nModo = 2)
   tone(250,1)
   Return 2
ELSEIF (nModo = 0) .OR. (nModo = 4)
   RETURN 2
ELSE
   IF lastkey() = 13
      RETURN 1
   ENDIF
ENDIF
 
**********************************************
FUNCTION NtxProgress ()
STATIC nPosAtua := 0
nPosAtua++
win_sgraph(LastRec(),nPosAtua,2,cCorDad)
IF nPosAtua=LastRec()
   nPosAtua := 0
ENDIF
Return .T.
 
procedure __contas()
CALCULAD(15,43,"G")
RETURN
**************************************************
FUNCTION STRPIC
PARAMETERS  w_valor,w_tam,w_dec
DO CASE                 && VALIDACAO DE PARAMETROS
   CASE PCOUNT()=2
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
SET COLOR TO
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
* EOP CCFUNC.PRG
