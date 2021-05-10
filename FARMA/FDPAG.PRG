PRIVATE sTela, nOpc, nLin, nCol

SAVE SCREEN TO sTela

DO WHILE .T.
  nLin = 09
  nCol = 15

  window( nLin, nCol, nLin + 6, nCol + 29, "Contas a Pagar" )
  @ nLin + 1, nCol + 1 PROMPT " 1 -  Manutencao Duplicatas "
  @ nLin + 2, nCol + 1 PROMPT " 2 - Pagamento Funcionarios "
  @ nLin + 3, nCol + 1 PROMPT " 3 -       Relatorio Gerais "
  @ nLin + 4, nCol SAY       "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
  @ nLin + 5, nCol + 1 PROMPT " 4 -          Menu anterior "
  MENU TO nOpc

  DO CASE
    CASE nOpc = 1
      DO FDMANDUP
    CASE nOpc = 2
      DO FDPAGFUN
    CASE nOpc = 3
      DO FDPAGREL
    CASE nOpc = 4 .OR. nOpc = 0
      EXIT
  ENDCASE

ENDDO

RESTORE SCREEN FROM sTela

PROCEDURE FDMANDUP
  PRIVATE nOpc, sTela, nLin, nCol

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 11
    nCol = 30

    window( nLin, nCol, nLin + 7, nCol + 16, "Opcoes" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Consultar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 1 PROMPT " 4 -   Excluir "
    @ nLin + 5, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    @ nLin + 6, nCol + 1 PROMPT " 5 -  Retornar "
    MENU TO nOpc

    DO CASE
      CASE nOpc = 1
        DO FDDUPCAD
      CASE nOpc = 2
        DO FDDUPCON
      CASE nOpc = 3
        DO FDDUPALT
      CASE nOpc = 4
        DO FDDUPEXC
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE
    SET ORDER TO 1
  ENDDO

  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDDUPCAD
  PRIVATE sTela

  SAVE SCREEN TO sTela

  SELECT ArqDup

  DO WHILE .T.
    DO FD_DDUP
    FD_TDUP( .T. )
    READ

    IF lastkey() <> 27
      IF InputSN( "Confirma cadastro da duplicata (S/N)?", 20 ) = "S"
        IF lastkey() <> 27
          SELECT ArqDup
          APPEND BLANK
          DO FD_SDUP
          COMMIT
        ENDIF
      ENDIF
    ENDIF

    IF InputSN( "Deseja continuar cadastro (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() = 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDDUPCON
  PRIVATE nLin, nCol, sTela, sTotal
  DECLARE vDados[4], vNome[4], vPict[4]

  SAVE SCREEN TO sTotal

  vDados[1] = "BNUMDUP"
  vDados[2] = "ArqFor->BNOMFOR"
  vDados[3] = "BVENDUP"
  vDados[4] = "BVALDUP"

  vNome[1] = "Duplicata"
  vNome[2] = "Fornecedor"
  vNome[3] = "Vencimento"
  vNome[4] = "Valor"

  vPict[1] = "@!"
  vPict[2] = "@!"
  vPict[3] = "99/99/99"
  vPict[4] = "@E 999,999,999.99"

  SELECT ArqFor
  SET ORDER TO 1

  SELECT ArqDup
  SET RELATION TO ArqDup->BFORDUP INTO ArqFor

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 70, "Consulta de Duplicatas" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA A DUPLICATA E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 69, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DDUP
      DO FD_LDUP
      FD_TDUP( .F. )
      CLEAR GETS
    ENDIF

    IF InputSN( "Deseja continuar consulta (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() <> 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTotal
RETURN

PROCEDURE FDDUPALT
  PRIVATE nLin, nCol, sTela, sTotal
  DECLARE vDados[4], vNome[4], vPict[4]

  SAVE SCREEN TO sTotal

  vDados[1] = "BNUMDUP"
  vDados[2] = "ArqFor->BNOMFOR"
  vDados[3] = "BVENDUP"
  vDados[4] = "BVALDUP"

  vNome[1] = "Duplicata"
  vNome[2] = "Fornecedor"
  vNome[3] = "Vencimento"
  vNome[4] = "Valor"

  vPict[1] = "@!"
  vPict[2] = "@!"
  vPict[3] = "99/99/99"
  vPict[4] = "@E 999,999,999.99"

  SELECT ArqFor
  SET ORDER TO 1

  SELECT ArqDup
  SET RELATION TO ArqDup->BFORDUP INTO ArqFor


  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 70, "Alteracao de Duplicatas" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA A DUPLICATA E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 69, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DDUP
      DO FD_LDUP
      FD_TDUP( .F. )
      READ

      IF lastkey() <> 27
        IF InputSN( "Confirma alteracao (S/N)?", 20 ) = "S"
          IF lastkey() <> 27
            DO FD_SDUP
            COMMIT
          ENDIF
        ENDIF
      ENDIF

    ENDIF

    IF InputSN( "Deseja continuar alteracao (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() <> 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTotal
RETURN

PROCEDURE FDDUPEXC
  PRIVATE nLin, nCol, sTela, sTotal
  DECLARE vDados[4], vNome[4], vPict[4]

  SAVE SCREEN TO sTotal

  vDados[1] = "BNUMDUP"
  vDados[2] = "ArqFor->BNOMFOR"
  vDados[3] = "BVENDUP"
  vDados[4] = "BVALDUP"

  vNome[1] = "Duplicata"
  vNome[2] = "Fornecedor"
  vNome[3] = "Vencimento"
  vNome[4] = "Valor"

  vPict[1] = "@!"
  vPict[2] = "@!"
  vPict[3] = "99/99/99"
  vPict[4] = "@E 999,999,999.99"

  SELECT ArqFor
  SET ORDER TO 1

  SELECT ArqDup
  SET RELATION TO ArqDup->BFORDUP INTO ArqFor


  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 70, "Exclusao de Duplicatas" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA A DUPLICATA E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 69, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DDUP
      DO FD_LDUP
      FD_TDUP( .F. )
      CLEAR GETS

      IF InputSN( "Confirma duplicata para exclusao (S/N)?", 20 ) = "S"
        IF lastkey() <> 27
          DELETE
          PACK
        ENDIF
      ENDIF
    ENDIF

    IF InputSN( "Deseja continuar consulta (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() <> 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTotal
RETURN

PROCEDURE FD_DDUP
  PUBLIC DUP_NUM, DUP_FOR, DUP_VEN
  PUBLIC DUP_VAL

  DUP_NUM = SPACE( 10 )
  DUP_FOR = 0
  DUP_VEN = CTOD(SPACE(8))
  DUP_VAL = 0
RETURN

PROCEDURE FD_SDUP
  SELECT ArqDup
  REPLACE BNUMDUP WITH DUP_NUM
  REPLACE BFORDUP WITH DUP_FOR
  REPLACE BVENDUP WITH DUP_VEN
  REPLACE BVALDUP WITH DUP_VAL
RETURN

PROCEDURE FD_LDUP
  DUP_NUM = BNUMDUP
  DUP_FOR = BFORDUP
  DUP_VEN = BVENDUP
  DUP_VAL = BVALDUP
RETURN

FUNCTION FD_TDUP
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 10
  nCol = 10

  SELECT ArqFor
  SET ORDER TO 1
  GO TOP
  SEEK DUP_FOR

  window( nLin, nCol, nLin + 6, nCol + 51, "Manutencao de Duplicatas" )
  @ nLin +  3, nCol SAY "Ç" + replicate( "Ä", 50 ) + "¶"

  @ nLin + 2, nCol + 20 GET ArqFor->BNOMFOR
  CLEAR GETS

  @ nLin +  1, nCol +  2 SAY "Duplicata.:" GET DUP_NUM PICT "@!"
  @ nLin +  2, nCol +  2 SAY "Fornecedor:" GET DUP_FOR PICT "99999" VALID FDVERDUP( DUP_NUM, DUP_FOR )
  IF !lCad
    CLEAR GETS
  ENDIF

  @ nLin +  4, nCol +  2 SAY "Vencimento:" GET DUP_VEN PICT "99/99/99" VALID !EMPTY( DUP_VEN )
  @ nLin +  5, nCol +  2 SAY "Valor.....:" GET DUP_VAL PICT "@E 999,999,999.99" VALID !EMPTY( DUP_VAL )

RETURN .T.

FUNCTION FDVERDUP
  PARAM sDup, nFor
  PRIVATE nLin, nCol, sCor

  IF lastkey() = 5
    RETURN .T.
  ENDIF

  SELECT ArqDup
  SET ORDER TO 1
  GO TOP

  SEEK sDup + str(nFor,5)

  IF FOUND()
     MESSAGE( "Duplicata ja cadastrada!!!", 15 )
     RETURN .F.
  ENDIF

  Select ArqFor
  SET ORDER TO 1
  GO TOP

  SEEK nFor

  IF !FOUND()
    MESSAGE( "Fornecedor nao cadastrado!!!", 15 )
    RETURN .F.
  ENDIF

  sCor = setcolor( "N/W" )

  nLin = row()
  nCol = col() + 1

  @ nLin, nCol SAY ArqFor->BNOMFOR

  setcolor( sCor )

RETURN .T.

PROCEDURE FDPAGFUN
  PRIVATE sTela, nLin, nCol, sMes
  PRIVATE nFun, nSal, nCom, nTot

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 11
    nCol = 12

    nFun = 0
    nSal = 0
    nCom = 0
    nTot = 0
    sMes = right( dtoc( date() ), 5 )

    SELECT ArqFun
    SET ORDER TO 1
    GO TOP

    SEEK nFun

    window( nLin, nCol, nLin + 7, nCol + 60, "Pagamento de Funcionario" )
    @ nLin + 1, nCol + 22 GET ArqFun->BNOMFUN
    @ nLin + 2, nCol SAY "Ç" + replicate( "Ä", 59 ) + "¶"
    @ nLin + 5, nCol SAY "Ç" + replicate( "Ä", 59 ) + "¶"
    CLEAR GETS

    @ nLin + 1, nCol + 2 SAY "Funcionario.:" GET nFun PICT "99999" VALID FDVERFUN2( nFun )
    @ nLin + 3, nCol + 2 SAY "Mes.........:" GET sMes PICT "99/99" VALID !empty( ctod( "01/"+sMes ) )
    READ

    IF lastkey() <> 27
      nSal = ArqFun->BSALFUN

      SELECT ArqRec
      SET ORDER TO 1
      SET FILTER TO ( BFUNREC = nFun ) .AND. ( sMes = right(dtoc(BDATREC), 5 ) )
      GO TOP

      DO WHILE !EOF()
        nCom = nCom + ( (BQTEREC * BVALREC) * BCOMREC / 100 )
        SKIP
      ENDDO

      SET FILTER TO
      nTot = nCom + nSal

      @ nLin + 4, nCol +  2 SAY "Comissao....:" GET nCom PICT "@E 999,999,999.99"
      @ nLin + 4, nCol + 31 SAY "Salario.....:" GET nSal PICT "@E 999,999,999.99"
      @ nLin + 6, nCol + 31 SAY "TOTAL.......:" GET nTot PICT "@E 999,999,999.99"
      CLEAR GETS

    ENDIF

    IF InputSN( "Deseja mais algum funcionario (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() = 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela

RETURN

FUNCTION FDVERFUN2
  PARAM nCod
  PRIVATE sCor

  SELECT ArqFun
  SET ORDER TO 1
  GO TOP

  SEEK nCod

  IF !FOUND()
    MESSAGE( "Funcionario nao cadastrado!!!", 15 )
    RETURN .F.
  ENDIF

  sCor = setcolor( "N/W" )

  @ row(), col() + 1 SAY ArqFun->BNOMFUN

  setcolor( sCor )

RETURN .T.

PROCEDURE FDPAGREL
  PRIVATE sTela, nOpc, nLin, nCol

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 13
    nCol = 25

    window( nLin, nCol, nLin + 5, nCol + 30, "Relatorios" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Relatorio de Duplicatas "
    @ nLin + 2, nCol + 1 PROMPT " 2 -  Relatorio de Pagamento "
    @ nLin + 3, nCol SAY       "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    @ nLin + 4, nCol + 1 PROMPT " 3 -           Menu anterior "
    MENU TO nOpc

    DO CASE
      CASE nOpc = 1
        DO FDRELDUP
      CASE nOpc = 2
        DO FDRELPAG
      CASE nOpc = 3 .OR. nOpc = 0
        EXIT
    ENDCASE

  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDRELDUP
  PRIVATE sTela, nCol, nLin, dIni, dFim
  PRIVATE pLin, pPag, nTot

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 15
    nCol = 20
    nTot = 0

    dIni = ctod( space( 8 ) )
    dFim = dIni

    window( nLin, nCol, nLin + 2, nCol + 36, "Periodo" )
    @ nLin + 1, nCol +  2 SAY "Periodo de..:" GET dIni PICT "99/99/99" ;
      VALID !Empty( dIni )
    @ nLin + 1, col() + 1 SAY "a" GET dFim PICT "99/99/99" ;
      VALID (dIni <= dFim )
    READ

    IF lastkey() = 27
      EXIT
    ENDIF

    SELECT ArqFor
    SET ORDER TO 1

    SELECT ArqDup
    SET ORDER TO 2
    SET RELATION TO BFORDUP INTO ArqFor
    SET FILTER TO BVENDUP >= dIni .AND. BVENDUP <= dFim
    GO TOP

    pLin = 0
    pPag = 1

    IF DeviceInit() <> 0
      DO WHILE !EOF()
        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Relatorios de Duplicatas de " + ;
            dtoc( dIni ) + " a " + dtoc( dFim )
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "COD.   FORNECEDOR" + SPACE( 22 ) + ;
            "N§ DUPLIC.  VENC.    VALOR"
          pLin = 4
        ENDIF

        @ pLin, 0 SAY transform( ArqFor->BCODFOR, "@E 99999" ) + "   " + ;
          ArqFor->BNOMFOR + "   " + transform( BNUMDUP, "9999999999" ) + "   " + ;
          dtoc( BVENDUP ) + "    " + transform( BVALDUP, "@E 999,999,999.99" )

        pLin = pLin + 1

        nTot = nTot + BVALDUP

        SKIP

        IF EOF()
           @ pLin + 1, 0 SAY space( 65 ) + replicate( "-", 15 )
           @ pLin + 2, 0 SAY space( 66 ) + transform( nTot, "@E 999,999,999.99" )
           pLin = pLin + 2
        ENDIF

        IF pLin = 56 .OR. EOF()
          pLin = 56
          @ pLin + 3, 0 SAY REPLICATE( "-", 80 )
          @ pLin + 4, 0 SAY "Pagina...: " + TRANSFORM( pPag, "9999" )
          pPag = pPag + 1
          pLin = 0
        ENDIF

      ENDDO

      SET FILTER TO
      SET RELATION TO

      DeviceClose()
      SET FILTER TO
      SET RELATION TO
      SET ORDER TO 1
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

PROCEDURE FDRELPAG
  PRIVATE sTela, nLin, nCol, sMes, pLin, pPag
  PRIVATE nFun, nSal, nCom, nTot, nSub

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 11
    nCol = 40

    nFun = 0
    nSal = 0
    nCom = 0
    nTot = 0
    pPag = 1
    sMes = right( dtoc( date() ), 5 )

    window( nLin, nCol, nLin + 2, nCol + 22, "Pagamento" )
    CLEAR GETS

    @ nLin + 1, nCol + 2 SAY "Mes.........:" GET sMes PICT "99/99" VALID !empty( ctod( "01/"+sMes ) )
    READ

    SELECT ArqFun
    SET ORDER TO 2
    SET RELATION TO
    SET FILTER TO
    GO TOP

    IF DeviceInit() <> 0

      pLin = 0

      DO WHILE !EOF()

        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Relatorio de pagamento de Funcionarios - " + sMes
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "COD.   FUNCIONARIO" + SPACE( 21 ) + ;
            "SALARIO       COMISSAO        VALOR TOTAL"
          pLin = 4
        ENDIF

        nFun = ArqFun->BCODFUN

        nSal = ArqFun->BSALFUN

        SELECT ArqRec
        SET ORDER TO 1
        SET FILTER TO (BFUNREC = nFun) .AND. (sMes = right(dtoc(BDATREC), 5))
        GO TOP

        nCom = 0

        DO WHILE !EOF()
          nCom = nCom + ( (BQTEREC * BVALREC) * BCOMREC / 100 )
          SKIP
        ENDDO

        SET FILTER TO
        nSub = nCom + nSal

        nTot = nTot + nSub

        SELECT ArqFun

        @ pLin, 0 SAY transform( BCODFUN, "99999" ) + "  " + BNOMFUN + "  " + ;
          transform( nSal, "@E 9,999,999.99" ) + "  " + ;
          transform( nCom, "@E 9,999,999.99" ) + "  " + ;
          transform( nSub, "@E 99,999,999.99" )

        pLin = pLin + 1

        SKIP

        IF EOF()
           @ pLin + 1, 0 SAY space( 65 ) + replicate( "-", 15 )
           @ pLin + 2, 0 SAY space( 66 ) + transform( nTot, "@E 999,999,999.99" )
           pLin = pLin + 2
        ENDIF

        IF pLin = 56 .OR. EOF()
          pLin = 56
          @ pLin + 3, 0 SAY REPLICATE( "-", 80 )
          @ pLin + 4, 0 SAY "Pagina...: " + TRANSFORM( pPag, "9999" )
          pPag = pPag + 1
          pLin = 0
        ENDIF

      ENDDO

      DeviceClose()

    ENDIF

    IF InputSN( "Deseja mais algum relatorio de pagamentos (S/N)?", 20 ) = "N"
      EXIT
    ENDIF

    IF lastkey() = 27
      EXIT
    ENDIF

  ENDDO

  RESTORE SCREEN FROM sTela

RETURN
