PROCEDURE FDEST02
  PRIVATE sTela, nOpc, nLin, nCol, COD_PRO, ENT_PRO, sSal

  SAVE SCREEN TO sTela

  COD_PRO = space( 4 )
  ENT_PRO = 0

  DO WHILE .T.
    nLin = 12
    nCol = 18

    SAVE SCREEN TO sSal

    window( nLin - 4, nCol + 6, nLin - 2, nCol + 31, "" )
    @ nLin - 3, nCol + 8 SAY "Codigo produto..:" GET COD_PRO PICT "@!" VALID VERPRO( COD_PRO )
    READ

    IF lastkey() <> 27
      DO FD_DPRO
      DO FD_LPRO
      FD_TPRO( .T. )
      CLEAR GETS

      window( nLin + 7, nCol, nLin + 9, nCol + 50, "" )
      @ nLin + 08, nCol + 2  SAY "Estoque atual.:" GET PRO_QTE PICT "9999"
      CLEAR GETS
      @ nLin + 08, col() + 2 SAY "Quantidade entrada.:" GET ENT_PRO PICT "9999"
      READ

      IF inputsn( "Confirma entrada (S/N)?", 20 ) = "S"
        PRO_QTE = PRO_QTE + ENT_PRO
        DO FD_SPRO
      ENDIF

    ENDIF

    IF lastkey() = 27
      EXIT
    ENDIF

    IF InputSN( "Deseja continuar entrada (S/N)", 20 ) = "N"
      EXIT
    ENDIF


    RESTORE SCREEN FROM sSal

  ENDDO

  RESTORE SCREEN FROM sTela

RETURN

FUNCTION VERPRO
  PARAM sCod

  SELECT ArqPro
  GO TOP

  SEEK sCod

  IF !FOUND()
    MESSAGE( "Produto nao cadastrado!!!", 15 )
    RETURN .F.
  ENDIF

RETURN .T.
