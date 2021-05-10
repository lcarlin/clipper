PROCEDURE ForeGround
  PARAM sMen, sCor
  PRIVATE sOld, nQua

  sOld = setcolor( sCor )
  nQua = ( 80 * 25 ) / len( sMen )

  @ 0, 0 say ""

  FOR nInd = 1 TO nQua
    ?? sMen
  NEXT

  setcolor( sOld )

RETURN

PROCEDURE Window
  PARAM nTop, nLeft, nBottom, nRight, sTit
  PRIVATE sTela, nInd, sCor

  setattr( nTop + 1, nLeft + 1, nBottom + 1, nRight + 1, 8 )

  @ nTop, nLeft CLEAR TO nBottom, nRight
  @ nTop, nLeft TO nBottom, nRight double

  sCor = setcolor( "GR+/B" )
  @ nTop, nLeft + 3 SAY sTit
  setcolor( sCor )
  if len( sTit ) > 0
    @ nTop, col()     SAY " Æ"
    @ nTop, nLeft + 1 SAY "µ "
  endif

RETURN

FUNCTION InputSN
  PARAM sMen, nLin
  PRIVATE nCol, sRes, sTela, sOld

  sOld = SETCOLOR( "W+/R*" )

  SAVE SCREEN TO sTela

  sRes = "S"

  nCol = ( 80 - len( sMen ) ) / 2 - 2

  window( nLin, nCol, nLin + 2, nCol + len( sMen ) + 6, "" )
  @ nLin + 1, nCol + 2 SAY sMen GET sRes PICT "!" VALID ( sRes $ "SN" )
  READ

  RESTORE SCREEN FROM sTela

  SETCOLOR( sOld )

RETURN sRes

PROCEDURE Message
  PARAM sMen, nLin
  PRIVATE nCol, sRes, sTela, sOld

  sOld = setcolor( "W+/R*" )

  SAVE SCREEN TO sTela

  nCol = ( 80 - len( sMen ) ) / 2 - 2

  window( nLin, nCol, nLin + 2, nCol + len( sMen ) + 4, "" )
  @ nLin + 1, nCol + 2 SAY sMen
  INKEY( 0 )

  RESTORE SCREEN FROM sTela

  setcolor( sOld )

RETURN

PROCEDURE SayCenter
  PARAM nRow, sMen

  nCol = ( 80 - len( sMen ) ) / 2
  @ nRow, nCol SAY sMen

RETURN

FUNCTION Senha
  PARAM nLin, nCol, sCompara
  PRIVATE lCon, sSenha, nKey, lRet, sCor

  lCon = .t.
  sSenha = ""

  sCor = setcolor( "W+/R*" )

  save screen to tSenha
  window( nLin, nCol, nLin + 2, nCol + 34, "" )

  @ nLin + 1, nCol + 2 say "Senha....: "

  set cursor on

  setcolor( "N/W" )

  do while lCon .and. len( sSenha ) < 20
    @ nLin + 1, nCol + 13 say space( 20 )
    @ nLin + 1, nCol + 13 say replicate( "þ", len( sSenha ) )

    nKey = inkey(0)

    if nKey = 27 .or. nKey = 13
      lCon = .f.
    elseif nKey = 08
      if len( sSenha ) > 0
        sSenha = left( sSenha, len( sSenha ) - 1 )
      endif
    else
      sSenha = sSenha + chr( nKey )
    endif

    @ nLin + 1, nCol + 13 say replicate( "þ", len( sSenha ) )

  enddo

  restore screen from tSenha

  sSenha = alltrim( upper( sSenha ) )

  setcolor( sCor )

return ( sSenha = upper( sCompara ) ) .and. (len( sCompara ) = len( sSenha ))

FUNCTION DeviceInit
  PRIVATE nOpc, sTela, nLin, nCol, sCor
  PUBLIC nDeviceOpc

  nLin = 8
  nCol = 20

  SAVE SCREEN TO sTela

  window( nLin, nCol, nLin + 4, nCol + 41,  "Direcione a saida e tecle <ENTER>" )

  @ nLin + 2, nCol  + 2 PROMPT " Impressora "
  @ nLin + 2, col() + 2 PROMPT "   Video   "
  @ nLin + 2, col() + 2 PROMPT "  Cancelar "
  MENU TO nOpc

  IF nOpc = 3
    nOpc = 0
  ENDIF

  nDeviceOpc = nOpc

  IF nOpc = 2
    SET PRINTER TO TEMP.TXT
  ENDIF

  IF nOpc <> 0
    SET DEVICE TO PRINTER
  ELSE
    SET DEVICE TO SCREEN
  ENDIF

  RESTORE SCREEN FROM sTela

RETURN nOpc

FUNCTION DeviceClose
  PRIVATE sTela

  SET PRINTER TO

  EJECT

  SET DEVICE TO SCREEN

  IF nDeviceOpc = 2
    SAVE SCREEN TO sTela

    window( 1, 0, 24, 79, "Relatorio em Tela" )
    @ 24, 25 SAY "µ Tecle <ESC> para sair... Æ"
    memoedit( memoread( "TEMP.TXT" ), 2, 1, 23, 78, .f., "", 256 )

    RESTORE SCREEN FROM sTela
  ENDIF

RETURN .T.
