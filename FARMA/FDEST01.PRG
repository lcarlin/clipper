PRIVATE sTela, nOpc, nLin, nCol

SAVE SCREEN TO sTela

DO WHILE .T.
  nLin = 10
  nCol = 28

  window( nLin, nCol, nLin + 6, nCol + 25, "Relatorios" )
  @ nLin +  1, nCol + 1 PROMPT " 1 -   Tabela de Precos "
  @ nLin +  2, nCol + 1 PROMPT " 2 - Produtos comprados "
  @ nLin +  3, nCol + 1 PROMPT " 3 -  Produtos em Falta "
  @ nLin +  4, nCol SAY       "픔컴컴컴컴컴컴컴컴컴컴컴캘"
  @ nLin +  5, nCol + 1 PROMPT " 4 -      Menu anterior "
  MENU TO nOpc

  DO CASE
    CASE nOpc = 1
      DO FDTABPRE
    CASE nOpc = 2
      DO FDPROCOM
    CASE nOpc = 3
      DO FDPROFAL
    CASE nOpc = 4 .OR. nOpc = 0
      EXIT
  ENDCASE

ENDDO

RESTORE SCREEN FROM sTela

PROCEDURE FDTABPRE
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
          @ pLin +  1, 0 SAY "Tabela de Precos"
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

PROCEDURE FDPROCOM
  PRIVATE sTela, nCol, nLin, dIni, dFim
  PRIVATE pLin, pPag

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 15
    nCol = 20

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

    SELECT ArqPro
    SET ORDER TO 1

    SELECT ArqEnt
    SET ORDER TO 2
    SET RELATION TO BPROENT INTO ArqPro
    SET FILTER TO BDATENT >= dIni .AND. BDATENT <= dFim
    GO TOP

    pLin = 0
    pPag = 1

    IF DeviceInit() <> 0
      DO WHILE !EOF()
        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Produtos comprados no periodo de " + ;
            dtoc( dIni ) + " a " + dtoc( dFim )
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "COD.     DESCRICAO" + SPACE( 25 ) + ;
            "  TIPO            N� LOTE  DATA"
          pLin = 4
        ENDIF

        @ pLin, 0 SAY transform( ArqPro->BCODPRO, "99999" ) + "    " + ArqPro->BDESPRO + "    " + ;
          ArqPro->BTIPPRO + "  " + transform( BLOTENT, "99999999" ) + "  " + ;
          dtoc( BDATENT )

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

PROCEDURE FDPROFAL
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
      SET FILTER TO ( BQTEPRO <= 3 )
      GO TOP

      DO WHILE !EOF()
        IF pLin = 0
          @ pLin +  0, 0 SAY CHR(14) + "SISTEMA FARMA DRUGSTORE v1.0"
          @ pLin +  1, 0 SAY "Produtos em Falta"
          @ pLin +  2, 0 SAY REPLICATE( "-", 80 )
          @ pLin +  3, 0 SAY "  COD.      DESCRICAO" + SPACE( 25 ) + ;
            " TIPO                     QUANT"
          pLin = 4
        ENDIF

        @ pLin, 0 SAY "  " + transform( BCODPRO, "99999" ) + "     " + BDESPRO + "     " + ;
          BTIPPRO + "          " + transform( BQTEPRO, "@E 9,999" )

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

      SET FILTER TO

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