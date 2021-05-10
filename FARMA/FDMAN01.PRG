PROCEDURE FDMREL
  PRIVATE nOpc, sTela, nLin, nCol

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 12
    nCol = 28

    window( nLin, nCol, nLin + 7 , nCol + 20, "Relatorios" )
    @ nLin + 1, nCol + 1 PROMPT " 1 -      Clientes "
    @ nLin + 2, nCol + 1 PROMPT " 2 -  Fornecedores "
    @ nLin + 3, nCol + 1 PROMPT " 3 -  Funcionarios "
    @ nLin + 4, nCol + 1 PROMPT " 4 -      Produtos "
    @ nLin + 5, nCol + 0 SAY   "픔컴컴컴컴컴컴컴컴컴�"
    @ nLin + 6, nCol + 1 PROMPT " 5 - Menu anterior "
    MENU TO nOpc

    DO CASE
      CASE nOpc = 1
        DO FDRELCLI
      CASE nOpc = 2
        DO FDRELFOR
      CASE nOpc = 3
        DO FDRELFUN
      CASE nOpc = 4
        DO FDRELPRO
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE
  ENDDO

  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDRELCLI
  PRIVATE sTela, nCol, nLin
  PRIVATE pLin, pPag

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 15
    nCol = 10

    SELECT ArqCli
    SET ORDER TO 2
    GO TOP

    pLin = 0
    pPag = 1

    IF DeviceInit() <> 0
      DO WHILE !EOF()
        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Relatorio de Clientes"
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "COD.   NOME" + space(28) + ;
            "TELEFONE          CIDADE               UF"
          pLin = 4

        ENDIF

        @ pLin, 0 SAY TRANSFORM( BCODCLI, "99999" ) + "  " + BNOMCLI + "  " + ;
          BFONCLI + "  " + left( BCIDCLI, 19 ) + "  " + BESTCLI

        pLin = pLin + 1

        SKIP

        IF pLin = 56 .OR. EOF()
          pLin = 56
          @ pLin + 3, 0 SAY REPLICATE( "-", 80 )
          @ pLin + 4, 0 SAY "Pagina...: " + TRANSFORM( pPag, "9999" )
          pPag = pPag + 1
          pLin = 0
        ENDIF

      ENDDO

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

PROCEDURE FDRELFOR
  PRIVATE sTela, nCol, nLin
  PRIVATE pLin, pPag

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 15
    nCol = 10

    SELECT ArqFor
    SET ORDER TO 2
    GO TOP

    pLin = 0
    pPag = 1

    IF DeviceInit() <> 0
      DO WHILE !EOF()
        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Relatorio de Fornecedores"
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "COD.   NOME" + space(28) + ;
            "TELEFONE          CIDADE               UF"
          pLin = 4
         ENDIF

        @ pLin, 0 SAY TRANSFORM( BCODFOR, "99999" ) + "  " + BNOMFOR + "  " + ;
          BFONFOR + "  " + left( BCIDFOR, 19 ) + "  " + BESTFOR

        pLin = pLin + 1

        SKIP

        IF pLin = 56 .OR. EOF()
          pLin = 56
          @ pLin + 3, 0 SAY REPLICATE( "-", 80 )
          @ pLin + 4, 0 SAY "Pagina...: " + TRANSFORM( pPag, "9999" )
          pPag = pPag + 1
          pLin = 0
        ENDIF

      ENDDO

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

PROCEDURE FDRELFUN
  PRIVATE sTela, nCol, nLin
  PRIVATE pLin, pPag

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 15
    nCol = 10

    SELECT ArqFun
    SET ORDER TO 2
    GO TOP

    pLin = 0
    pPag = 1

    IF DeviceInit() <> 0
      DO WHILE !EOF()
        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Relatorio de Funcionarios"
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "COD.   NOME" + space(28) + ;
            "TELEFONE          CIDADE               UF"
          pLin = 4
        ENDIF

        @ pLin, 0 SAY TRANSFORM( BCODFUN, "99999" ) + "  " + BNOMFUN + "  " + ;
          BFONFUN + "  " + left( BCIDFUN, 19 ) + "  " + BESTFUN

        pLin = pLin + 1

         SKIP

        IF pLin = 56 .OR. EOF()
          pLin = 56
          @ pLin + 3, 0 SAY REPLICATE( "-", 80 )
          @ pLin + 4, 0 SAY "Pagina...: " + TRANSFORM( pPag, "9999" )
          pPag = pPag + 1
          pLin = 0
        ENDIF

      ENDDO

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

PROCEDURE FDRELPRO
  PRIVATE sTela, nCol, nLin
  PRIVATE pLin, pPag

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 15
    nCol = 10

    SELECT ArqPro
    SET ORDER TO 2
    GO TOP

    pLin = 0
    pPag = 1

    IF DeviceInit() <> 0
      DO WHILE !EOF()
        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Relatorio de Produtos"
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "COD.     DESCRICAO" + SPACE( 25 ) + ;
            "  TIPO                    VALOR "
          pLin = 4
        ENDIF

        @ pLin, 0 SAY transform( BCODPRO, "99999" ) + "    " + BDESPRO + "    " + ;
          BTIPPRO + "         " + transform( BVALPRO, "@E 99,999,999.99" )

        pLin = pLin + 1

         SKIP

        IF pLin = 56 .OR. EOF()
          pLin = 56
          @ pLin + 3, 0 SAY REPLICATE( "-", 80 )
          @ pLin + 4, 0 SAY "Pagina...: " + TRANSFORM( pPag, "9999" )
          pPag = pPag + 1
          pLin = 0
        ENDIF

      ENDDO

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
