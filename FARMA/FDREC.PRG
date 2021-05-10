PRIVATE sTela, nOpc, nLin, nCol

SAVE SCREEN TO sTela

DO WHILE .T.
  nLin = 08
  nCol = 15

  window( nLin, nCol, nLin + 6, nCol + 36, "Contas a Receber" )
  @ nLin + 1, nCol + 1 PROMPT " 1 -  Entrada produtos por Cliente "
  @ nLin + 2, nCol + 1 PROMPT " 2 -          Fechamento de Contas "
  @ nLin + 3, nCol + 1 PROMPT " 3 - Relatorio de Contas a Receber "
  @ nLin + 4, nCol SAY       "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
  @ nLin + 5, nCol + 1 PROMPT " 4 -                 Menu anterior "
  MENU TO nOpc

  DO CASE
    CASE nOpc = 1
      DO FDENTPRO
    CASE nOpc = 2
      DO FDFECCON
    CASE nOpc = 3
      DO FDRELCON
    CASE nOpc = 4 .OR. nOpc = 0
      EXIT
  ENDCASE

ENDDO

RESTORE SCREEN FROM sTela


PROCEDURE FDENTPRO
  PRIVATE sTela, nLin, nCol
  PUBLIC nCliCod, nProQte, nNumLan, nVenCod, nVenCom
  PUBLIC dMovDat

  SAVE SCREEN TO sTela

  nLin = 10
  nCol = 17

  DO WHILE .T.

    nCliCod = 0
    SELECT ArqRec
    SET FILTER TO
    GO BOTTOM

    nNumLan = ArqRec->(reccount()) + 1
    dMovDat = date()
    nVenCom = 0
    nVenCod = 0

    window( nLin, nCol, nLin + 12, nCol + 52, "Entrada de Produtos por Clientes" )
    SELECT ArqCli
    SET ORDER TO 1
    GO TOP
    SEEK nCliCod

    SELECT ArqFun
    SET ORDER TO 1
    GO TOP
    SEEK nVenCod

    SELECT ArqRec

    @ nLin +  1, nCol + 21 GET ArqCli->BNOMCLI
    @ nLin +  3, nCol + 21 GET ArqFun->BNOMFUN
    @ nLin +  2, nCol + 25 SAY "Lancamento.:" GET nNumLan PICT "99999"
    CLEAR GETS

    @ nLin +  1, nCol + 02 SAY "Cliente....:" GET nCliCod PICT "99999" VALID FDVERCLI2( nCliCod )
    @ nLin +  2, nCol + 02 SAY "Data.......:" GET dMovDat PICT "99/99/99" VALID !Empty( dMovDat )
    @ nLin +  3, nCol + 02 SAY "Funcionario:" GET nVenCod PICT "99999" VALID FDVERFUN2( nVenCod )
    @ nLin +  4, nCol + 02 SAY "Comissao %.:" GET nVenCom PICT "@E 999.99"
    @ nLin +  5, nCol SAY "Ç" + replicate( "Ä", 51 ) + "¶"
    @ nLin + 10, nCol SAY "Ç" + replicate( "Ä", 51 ) + "¶"
    READ

    @ nLin + 1, nCol + 21 GET ArqCli->BNOMCLI
    CLEAR GETS

    IF lastkey() <> 27
      DO WHILE .T.

        DO FD_DPRO
        nProQte = 0

        @ nLin +  7, nCol + 02 SAY "Descricao..:" GET PRO_DES
        @ nLin +  8, nCol + 02 SAY "Tipo.......:" GET PRO_TIP
        @ nLin + 11, nCol + 02 SAY "Est. Atual.:" GET PRO_QTE PICT "99999"
        @ nLin +  9, nCol + 02 SAY "Valor......:" GET PRO_VAL PICT "@E 999,999,999.99"
        @ nLin + 11, nCol + 25 SAY "Quantidade.:" GET nProQte PICT "99999" VALID (nProQte >= 0 )
        CLEAR GETS
        @ nLin +  6, nCol + 02 SAY "Produto....:" GET PRO_COD PICT "99999" VALID FDVERPRO2( PRO_COD )
        READ

        IF lastkey() <> 27
          DO FD_LPRO
          @ nLin +  7, nCol + 02 SAY "Descricao..:" GET PRO_DES
          @ nLin +  8, nCol + 02 SAY "Tipo.......:" GET PRO_TIP
          @ nLin + 11, nCol + 02 SAY "Est. Atual.:" GET PRO_QTE PICT "99999"
          @ nLin +  9, nCol + 02 SAY "Valor......:" GET PRO_VAL PICT "@E 999,999,999.99"
          CLEAR GETS
          @ nLin + 11, nCol + 25 SAY "Quantidade.:" GET nProQte PICT "99999" VALID ( nProQte <= PRO_QTE )
          READ

          IF lastkey() <> 27
            IF InputSN( "Confirma entrada deste produto (S/N)", 21 ) = "S"
              IF lastkey() <> 27
                SELECT ArqRec
                APPEND BLANK
                DO FD_SREC

                SELECT ArqPro
                REPLACE BQTEPRO WITH BQTEPRO - nProQte
                COMMIT
              ENDIF
            ENDIF
          ENDIF
        ENDIF

        IF InputSN( "Deseja continuar com cliente (S/N)?", 21 ) = "N"
          EXIT
        ENDIF

        IF lastkey() = 27
          EXIT
        ENDIF

      ENDDO

    ENDIF

    IF InputSN( "Deseja mais algum cliente (S/N)?", 21 ) = "N"
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

FUNCTION FDVERCLI2
  PARAM nCod
  PRIVATE nLin, nCol, sCor

  nLin = row()
  nCol = col() + 1
  sCor = setcolor( "N/W" )

  SELECT ArqCli
  SET ORDER TO 1
  GO TOP

  SEEK nCod
  @ nLin, nCol SAY ArqCli->BNOMCLI

  setcolor( sCor )

  IF !FOUND()
    message( "Cliente nao cadastrado!!!", 15 )
    RETURN .F.
  ENDIF

RETURN .T.

PROCEDURE FD_SREC
  SELECT ArqRec
  REPLACE BCLIREC WITH nCliCod
  REPLACE BDATREC WITH dMovDat
  REPLACE BLANREC WITH nNumLan
  REPLACE BPROREC WITH PRO_COD
  REPLACE BVALREC WITH PRO_VAL
  REPLACE BQTEREC WITH nProQte
  REPLACE BFUNREC WITH nVenCod
  REPLACE BCOMREC WITH nVenCom
  REPLACE BPAGREC WITH " "
  COMMIT
RETURN

PROCEDURE FDFECCON
  PRIVATE sTela, nLin, nCol, nCliCod, nTotal
  PRIVATE nDatPag

  nLin = 11
  nCol = 20

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nCliCod = 0

    SELECT ArqCli
    SET ORDER TO 1
    GO TOP
    SEEK nCliCod

    window( nLin, nCol, nLin + 5, nCol + 51, "Fechamento de Contas de Clientes" )
    @ nLin + 1, nCol + 20 GET ArqCli->BNOMCLI
    @ nLin + 2, nCol SAY "Ç" + replicate( "Ä", 50 ) + "¶"
    CLEAR GETS
    @ nLin + 1, nCol +  2 SAY "Cliente...:" GET nCliCod PICT "99999" VALID FDVERCLI2( nCliCod )
    READ

    IF lastkey() <> 27
      SELECT ArqPro
      SET ORDER TO 1

      SELECT ArqRec
      SET ORDER TO 1
      SET RELATION TO ArqRec->BPROREC INTO ArqPro
      SET FILTER TO ( ArqRec->BPAGREC = " " )
      GO TOP

      nTotal = 0

      DO WHILE !EOF()
        IF ArqRec->BCLIREC = nCliCod
          nTotal = nTotal + ( ArqPro->BVALPRO * ArqRec->BQTEREC )
        ENDIF
        SKIP
      ENDDO

      nDatPag = date()

      IF nTotal = 0
        MESSAGE( "Cliente nao tem nenhuma conta a pagar!!!", 15 )
      ELSE
        @ nLin + 3, nCol + 2 SAY "Data......:" GET nDatPag PICT "99/99/99" VALID !EMPTY( nDatPag )
        @ nLin + 4, nCol + 2 SAY "Valor.....:" GET nTotal  PICT "@E 999,999,999.99" VALID !EMPTY( nTotal )
        READ

        IF lastkey() <> 27
          IF InputSN( "Confirma pagamento do cliente (S/N)?", 21 ) = "S"
             SELECT 0
             USE FDAFEC ALIAS ArqFec
             APPEND BLANK
             REPLACE BCLIFEC WITH nCliCod
             REPLACE BDATFEC WITH nDatPag
             REPLACE BVALFEC WITH nTotal
             COMMIT
             CLOSE

             SELECT ArqRec
             GO TOP

             DO WHILE !EOF()
               IF ArqRec->BCLIREC = nCliCod
                 REPLACE BPAGREC WITH "*"
               ENDIF
               SKIP
             ENDDO

             COMMIT

          ENDIF
        ENDIF

      ENDIF

      SELECT ArqRec
      SET FILTER TO
      SET RELATION TO
      GO TOP

    ENDIF

    IF InputSN( "Deseja fechar mais alguma conta (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() = 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDRELCON
  PRIVATE sTela, nCol, nLin, nCliCod
  PRIVATE pLin, pPag, nTot

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 12
    nCol = 10

    nCliCod = 0

    SELECT ArqCli
    SET ORDER TO 1
    GO TOP
    SEEK nCliCod

    window( nLin, nCol, nLin + 2, nCol + 51, "Relatorio de Contas a Receber" )
    @ nLin +  1, nCol + 20 GET ArqCli->BNOMCLI
    CLEAR GETS

    @ nLin +  1, nCol +  2 SAY "Cliente...:" GET nCliCod PICT "99999" VALID FDVERCLI2( nCliCod )
    READ

    IF lastkey() <> 27
      SELECT ArqPro
      SET ORDER TO 1

      SELECT ArqRec
      SET FILTER TO ArqRec->BPAGREC = " "
      SET ORDER TO 1
      SET RELATION TO ArqRec->BPROREC INTO ArqPro
      GO TOP
      SEEK nCliCod

      IF EOF()
         MESSAGE( "Cliente nao possui debitos!!!", 15 )
         EXIT
      ENDIF

      pLin = 0
      pPag = 1
      nTot = 0

      IF DeviceInit() <> 0
        DO WHILE (nCliCod = ArqRec->BCLIREC)
          IF pLin = 0
            @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
            @ pLin +  1, 0 SAY "Relatorio de a Receber - " + ArqCli->BNOMCLI + ;
              space( 30 ) + dtoc( date() )
            @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
            @ pLin +  3, 0 SAY "DATA      PRODUTO" + space( 25 ) + ;
              "QUANT  UNITARIO           TOTAL"
            pLin = 4

          ENDIF

          @ pLin, 0 SAY dtoc( BDATREC ) + "  " + ArqPro->BDESPRO + "  " + ;
            transform( BQTEREC, "99999" ) + "  " + ;
            transform( ArqPro->BVALPRO, "@E 99,999,999.99" ) + "      " + ;
            transform( BQTEREC * ArqPro->BVALPRO, "@E 9,999,999.99" )

          pLin = pLin + 1

          nTot = nTot + ( BQTEREC * ArqPro->BVALPRO )

          SKIP

          IF pLin = 56 .OR. !(nCliCod = ArqRec->BCLIREC)
            pLin = 56
            @ pLin + 1, 0 SAY SPACE( 60 ) + REPLICATE( "-", 20 )
            @ pLin + 2, 0 SAY SPACE( 67 ) + TRANSFORM( nTot, "@E 99,999,999.99" )
            @ pLin + 3, 0 SAY REPLICATE( "-", 80 )
            @ pLin + 4, 0 SAY "Pagina...: " + TRANSFORM( pPag, "9999" )
            pPag = pPag + 1
            pLin = 0
          ENDIF

        ENDDO

        DeviceClose()

        SET FILTER TO
        SET RELATION TO
      ENDIF
    ENDIF

    IF InputSN( "Deseja mais algum relatorio (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() = 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela

RETURN
