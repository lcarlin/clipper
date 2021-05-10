PRIVATE sTela, nOpc, nLin, nCol

SAVE SCREEN TO sTela

DO WHILE .T.
  nLin = 07
  nCol = 15

  window( nLin, nCol, nLin + 6, nCol + 26, "Estoque" )
  @ nLin +  1, nCol + 1 PROMPT " 1 - Entrada de Produtos "
  @ nLin +  2, nCol + 1 PROMPT " 2 -  Reajuste de Precos "
  @ nLin +  3, nCol + 1 PROMPT " 3 -   Relatorios Gerais "
  @ nLin +  4, nCol SAY       "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
  @ nLin +  5, nCol + 1 PROMPT " 4 -       Menu anterior "
  MENU TO nOpc

  DO CASE
    CASE nOpc = 1
      DO FDESTENT
    CASE nOpc = 2
      DO FDREAPRE
    CASE nOpc = 3
      DO FDEST01
    CASE nOpc = 4 .OR. nOpc = 0
      EXIT
  ENDCASE

ENDDO

RESTORE SCREEN FROM sTela

PROCEDURE FDESTENT
  PRIVATE sTela, nLin, nCol
  PUBLIC nForCod, nProQte, dProVen, nProLot, nNumNot
  PUBLIC dMovDat

  SAVE SCREEN TO sTela

  nLin = 10
  nCol = 17

  DO WHILE .T.

    nForCod = 0
    nNumNot = 0
    dMovDat = date()

    window( nLin, nCol, nLin + 11, nCol + 52, "Entrada de Produtos" )
    SELECT ArqFor
    SET ORDER TO 1
    GO TOP
    SEEK nForCod

    @ nLin + 1, nCol + 21 GET ArqFor->BNOMFOR
    CLEAR GETS

    @ nLin +  1, nCol + 02 SAY "Fornecedor.:" GET nForCod PICT "99999" VALID FDVERFOR2( nForCod )
    @ nLin +  2, nCol + 02 SAY "Data.......:" GET dMovDat PICT "99/99/99" VALID !Empty( dMovDat )
    @ nLin +  2, col() + 2 SAY "N§ da Nota.:" GET nNumNot PICT "99999999" VALID !EMPTY( nNumNot )
    @ nLin +  3, nCol SAY "Ç" + replicate( "Ä", 51 ) + "¶"
    @ nLin +  8, nCol SAY "Ç" + replicate( "Ä", 51 ) + "¶"
    READ

    @ nLin + 1, nCol + 21 GET ArqFor->BNOMFOR
    CLEAR GETS

    IF lastkey() <> 27
      DO WHILE .T.

        DO FD_DPRO
        nProQte = 0
        dProVen = ctod(space(8))
        nProLot = 0

        @ nLin +  5, nCol + 02 SAY "Descricao..:" GET PRO_DES
        @ nLin +  6, nCol + 02 SAY "Tipo.......:" GET PRO_TIP
        @ nLin +  9, nCol + 02 SAY "Est. Atual.:" GET PRO_QTE PICT "99999"
        @ nLin +  7, nCol + 02 SAY "Valor......:" GET PRO_VAL PICT "@E 999,999,999.99"
        @ nLin +  9, nCol + 25 SAY "Quantidade.:" GET nProQte PICT "99999" VALID (nProQte >= 0 )
        @ nLin + 10, nCol + 02 SAY "N§ do Lote.:" GET nProLot PICT "99999"
        @ nLin + 10, nCol + 25 SAY "Vencimento.:" GET dProVen PICT "99/99/99" VALID !Empty( dProVen )
        CLEAR GETS
        @ nLin +  4, nCol + 02 SAY "Produto....:" GET PRO_COD PICT "99999" VALID FDVERPRO2( PRO_COD )
        READ

        IF lastkey() <> 27
          DO FD_LPRO
          @ nLin +  5, nCol + 02 SAY "Descricao..:" GET PRO_DES
          @ nLin +  6, nCol + 02 SAY "Tipo.......:" GET PRO_TIP
          @ nLin +  9, nCol + 02 SAY "Est. Atual.:" GET PRO_QTE PICT "99999"
          CLEAR GETS
          @ nLin +  7, nCol + 02 SAY "Valor......:" GET PRO_VAL PICT "@E 999,999,999.99"
          @ nLin +  9, nCol + 25 SAY "Quantidade.:" GET nProQte PICT "99999" VALID (nProQte >= 0 )
          @ nLin + 10, nCol + 02 SAY "N§ do Lote.:" GET nProLot PICT "99999"
          @ nLin + 10, nCol + 25 SAY "Vencimento.:" GET dProVen PICT "99/99/99" VALID !Empty( dProVen )
          READ

          IF lastkey() <> 27
            IF InputSN( "Confirma entrada (S/N)", 21 ) = "S"
              IF lastkey() <> 27
                SELECT ArqEnt
                APPEND BLANK
                DO FD_SENT
                COMMIT

                SELECT ArqPro
                REPLACE BQTEPRO WITH BQTEPRO + nProQte
                COMMIT
              ENDIF
            ENDIF
          ENDIF
        ENDIF

        IF InputSN( "Deseja continuar com fornecedor (S/N)?", 21 ) = "N"
          EXIT
        ENDIF

        IF lastkey() = 27
          EXIT
        ENDIF

      ENDDO

    ENDIF

    IF InputSN( "Deseja entrada de mais algum fornecedor (S/N)?", 21 ) = "N"
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

FUNCTION FDVERFOR2
  PARAM nCod
  PRIVATE nLin, nCol, sCor

  nLin = row()
  nCol = col() + 1
  sCor = setcolor( "N/W" )

  SELECT ArqFor
  SET ORDER TO 1
  GO TOP

  SEEK nCod
  @ nLin, nCol SAY ArqFor->BNOMFOR

  setcolor( sCor )

  IF !FOUND()
    message( "Fornecedor nao cadastrado!!!", 15 )
    RETURN .F.
  ENDIF

RETURN .T.

FUNCTION FDVERPRO2
  PARAM nCod

  SELECT ArqPro
  SET ORDER TO 1
  GO TOP

  SEEK nCod

  IF !FOUND()
    message( "Produto nao cadastrado!!!", 15 )
    RETURN .F.
  ENDIF

RETURN .T.

PROCEDURE FD_SENT
  REPLACE BFORENT WITH nForCod
  REPLACE BDATENT WITH dMovDat
  REPLACE BNOTENT WITH nNumNot
  REPLACE BPROENT WITH PRO_COD
  REPLACE BVALENT WITH PRO_VAL
  REPLACE BQTEENT WITH nProQte
  REPLACE BLOTENT WITH nProLot
  REPLACE BVENENT WITH dProVen
RETURN

PROCEDURE FDREAPRE
  PRIVATE sTela, nOpc, nLin, nCol

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 10
    nCol = 25

    window( nLin, nCol, nLin + 5, nCol + 18, "Reajuste" )
    @ nLin +  1, nCol + 1 PROMPT " 1 - por Produto "
    @ nLin +  2, nCol + 1 PROMPT " 2 -       Geral "
    @ nLin +  3, nCol SAY       "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    @ nLin +  4, nCol + 1 PROMPT " 3 -    Retornar "
    MENU TO nOpc

    DO CASE
      CASE nOpc = 1
        DO FDREAPRO
      CASE nOpc = 2
        DO FDREAGER
      CASE nOpc = 3 .OR. nOpc = 0
        EXIT
    ENDCASE

  ENDDO

  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDREAPRO
  PRIVATE sTela, nLin, nCol, nPer

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 12
    nCol = 18
    nPer = 0

    SELECT ArqPro
    DO FD_DPRO
    FD_TPRO( .F. )
    CLEAR GETS

    @ nLin + 1, nCol + 2 SAY "Codigo....:" GET PRO_COD PICT "99999" ;
      VALID !EMPTY( PRO_COD) .AND. FDVERREA( PRO_COD )
    READ

    IF lastkey() <> 27
      DO FD_LPRO
      FD_TPRO( .F. )
      CLEAR GETS

      window( nLin + 6, nCol, nLin + 8, nCol + 50, "" )
      @ nLin + 6, nCol + 00 SAY "Ì"
      @ nLin + 6, nCol + 50 SAY "¹"
      @ nLin + 7, nCol + 02 SAY "Percentual:" GET nPer PICT "@E 999.99" VALID !EMPTY( nPer )
      READ

      IF lastkey() <> 27
        PRO_VAL = ( PRO_VAL * nPer / 100 ) + PRO_VAL
        @ nLin + 7, nCol + 22 SAY "Novo Preco.:" GET PRO_VAL PICT "@E 999,999,999.99"
        CLEAR GETS

        IF InputSN( "Confirma reajuste do preco (S/N)?", 20 ) = "S"
          IF lastkey() <> 27
            DO FD_SPRO
            COMMIT
          ENDIF
        ENDIF

      ENDIF

    ENDIF

    IF InputSN( "Deseja reajustar mais algum produto (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() = 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDREAGER
  PRIVATE sTela, nLin, nCol, nPer

  SAVE SCREEN TO sTela

  nLin = 13
  nCol = 22
  nPer = 0

  window( nLin, nCol, nLin + 2, nCol + 25, "Reajuste Geral" )
  @ nLin + 1, nCol + 02 SAY "Percentual....:" GET nPer PICT "@E 999.99" VALID !EMPTY( nPer )
  READ

  IF lastkey() <> 27
    IF InputSN( "Confirma percentual para reajuste de precos (S/N)?", 20 ) = "S"
      IF lastkey() <> 27
        SELECT ArqPro
        SET ORDER TO 1
        SET FILTER TO
        GO TOP

        DO WHILE !EOF()
          REPLACE BVALPRO WITH BVALPRO + ( BVALPRO * nPer / 100 )
          COMMIT
          SKIP
        ENDDO
      ENDIF
    ENDIF
  ENDIF

  MESSAGE( "Produtos reajustados. Tecle <ENTER> para prosseguir!!!", 15 )

  RESTORE SCREEN FROM sTela
RETURN

FUNCTION FDVERREA
  PARAM nCod

  SELECT ArqPro
  SET ORDER TO 1
  GO TOP

  SEEK nCod

  IF !FOUND()
    MESSAGE( "Produto nao cadastrado!!!", 15 )
    RETURN .F.
  ENDIF

RETURN .T.
