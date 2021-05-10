/*****************
*
*  Arquivo: CLIENTE.DBF
*  NOME        Character   50     0
*  ENDERECO    Character   50     0
*  TELEFONE    Character   15     0
*  OBSERVACAO  Character   50     0
*  CODIGO      Character   06     0
*
*/

#INCLUDE "INKEY.CH"
#INCLUDE "SETCURS.CH"
***************************************************************************
FUNCTION CLIENTES()
LOCAL aCab, aCamp, cAlias, nOrdem
LOCAL cTela := SAVESCREEN(00,00,24,79)

CLS
USE CLIENTE ALIAS CLI NEW
SET INDEX TO NOME

aCab   := { ;
           "C¢digo"           ,;
           "Nome"             ,;
           "Endere‡o"         ,;
           "Telefone"         ,;
           "Observa‡„o"       }

aCamp  := { ;
           "CODIGO"           ,;
           "NOME"             ,;
           "ENDERECO"         ,;
           "TELEFONE"         ,;
           "OBSERVACAO"       }

cAlias := "CLI"
nOrdem := 1

Visualiza( aCab, aCamp, cAlias, nOrdem)
RESTSCREEN(00,00,24,79,cTela)
RETURN NIL

***************************************************************************

FUNCTION Visualiza( aCab, aCamp, cAlias, nOrdem )
LOCAL oTAB, oCol, nKey, nRow, nCol, cTela, cArea

SELECT( cAlias )
SET ORDER TO nOrdem
GO TOP

SETCURSOR(0)
cArea := SAVESCREEN( 00, 00, 24, 79 )

@ 04,04,16,77 BOX CHR(219)

//               /-------------> Cor do TBrowse
//              /    /---------> Cor da barra em destaque
//             /    /      /---> Cor da barra luminosa
SET COLOR TO "W/N,W/B,,,N/W"

oTab := TBrowseDB( 05, 05, 15, 76 )
oTab:colsep := " "+CHR(219)+" "
oTab:headsep:= CHR(223)+CHR(219)+CHR(223)

FOR I = 1 TO LEN( aCamp )
   IF VALTYPE(aCamp[I]) == "B"
      oCol:=TBcolumnNew( aCab[I], ( aCamp[I] ) )
   ELSE
      oCol:=TBcolumnNew( aCab[I], FIELDWBLOCK( aCamp[I], SELECT()))
   ENDIF
   oTab:addColumn( oCol )
NEXT

nCol_Reg := (oTab:nRight-oTab:nLeft+2) / LEN(aCamp)

DO WHILE .T.
   nRow := ROW()
   nCol := COL()

   @ oTab:nBottom+1,oTab:nLeft SAY REPLICATE("°",oTab:nRight-oTab:nLeft+1) // COLOR cCOR28
   nCol_ := oTab:nLeft+IF(ROUND((nCol_Reg*(oTab:colpos-1)),0)<=0,0,IF(oTab:colpos>=LEN(aCamp),LEN(aCamp)*nCol_Reg,ROUND(nCol_Reg*(oTab:colpos-1),0)))
   @ oTab:nBottom+1,IF(nCol_+nCol_Reg>oTab:nRight,nCol_:=oTab:nRight-ROUND(nCol_Reg,0)+1,nCol_) SAY REPLICATE("²",ROUND(nCol_Reg,0)) // COLOR cCOR29
   oTab:colorRect({oTab:rowPos, oTab:freeze + 1, oTab:rowPos,oTab:colCount},{1, 1})

   DO WHILE ! oTab:Stabilize() ; ENDDO

   oTab:colorRect({oTab:rowPos, oTab:freeze + 1, oTab:rowPos,oTab:colCount}, {5, 2})
   oTAB:hilite()

   SETPOS( nRow, nCol )
   nKey := inkey()

   IF oTAB:stable
      IF oTAB:hitbottom
         @ 24,10  SAY "Atingiu o final do arquivo"
         INKEY(3)
         @ 24,00  SAY SPACE(80)
      ELSEIF oTAB:hittop
         @ 24,10 SAY "Atingiu o in¡cio do arquivo"
         INKEY(3)
         @ 24,00  SAY SPACE(80)
      ENDIF

      SETPOS( nRow, nCol )
      nKey := Inkey(0)

   ENDIF
   IF nKey == K_F1
   ELSEIF nKey == K_F2
   ELSEIF nKey == K_F3
   ELSEIF nKey == K_F4
   ELSEIF nKey == K_F5
   ELSEIF nKey == K_F6
   ELSEIF nKey == K_F7
   ELSEIF nKey == K_UP         ; oTab:UP()
   ELSEIF nKey == K_DOWN       ; oTab:DOWN()
   ELSEIF nKey == K_LEFT       ; oTab:LEFT()
   ELSEIF nKey == K_CTRL_LEFT  ; oTab:PANLEFT()
   ELSEIF nKey == K_RIGHT      ; oTab:RIGHT()
   ELSEIF nKey == K_CTRL_RIGHT ; oTab:PANRIGHT()
   ELSEIF nKey == K_PGUP       ; oTab:PAGEUP()
   ELSEIF nKey == K_CTRL_PGUP  ; oTab:GOTOP()
   ELSEIF nKey == K_PGDN       ; oTab:PAGEDOWN()
   ELSEIF nKey == K_CTRL_PGDN  ; oTab:GOBOTTOM()
   ELSEIF nKey == K_HOME       ; oTab:HOME()
   ELSEIF nKey == K_CTRL_HOME  ; oTab:PANHOME()
   ELSEIF nKey == K_END        ; oTab:END()
   ELSEIF nKey == K_CTRL_END   ; oTab:PANEND()
   ELSEIF nKey == K_ESC        ; EXIT
   ENDIF

ENDDO
RESTSCREEN(00,00,24,79,cArea)
SETCURSOR(1)
RETURN NIL
***************************************************************************
