PROCEDURE FDMR01
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 9
    nCol = 33

    window( nLin, nCol, nLin + 7, nCol + 16, "[ Opcoes ]" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Consultar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 1 PROMPT " 4 -   Excluir "
    @ nLin + 5, nCol + 0 SAY   "쳐컴컴컴컴컴컴컴�"
    @ nLin + 6, nCol + 1 PROMPT " 5 -  Retornar "
    MENU TO nOpc

    SELECT ArqCli
    SET ORDER TO 2
    GO TOP
    DO CASE
      CASE nOpc = 1
        SET ORDER TO 1
        DO FDMRCAD
      CASE nOpc = 2
        DO FDMRCON
      CASE nOpc = 3
        DO FDMRALT
      CASE nOpc = 4
        DO FDMREXC
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE
    SET ORDER TO 1
  ENDDO
  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMRCAD           && CADASTRO DE CLIENTES
  PRIVATE sTela

  SAVE SCREEN TO sTela

  SELECT ArqCli

  DO WHILE .T.
    DO FD_DCLI
    FD_TCLI( .T. )
    READ

    IF lastkey() <> 27 .and. InputSN( "Confirma cadastro do cliente (S/N)?", 20 ) = "S" .and. lastkey() <> 27
      APPEND BLANK
      DO FD_SCLI
      COMMIT
    ENDIF

    IF InputSN( "Deseja continuar cadastro (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF
    CLI_EST = SPACE(2)
  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDMRCON
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODCLI"
  vDados[2] = "BNOMCLI"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqCli

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "[ Consulta ]" )
    @ nLin + 10, nCol + 1 SAY " ESCOLHA O CLIENTE E TECLE <ENTER> "

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DCLI
      DO FD_LCLI
      FD_TCLI( .F. )
      CLEAR GETS
    ENDIF

    IF InputSN( "Deseja continuar consulta (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FDMRALT
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODCLI"
  vDados[2] = "BNOMCLI"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqCli

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "[ Alteracao ]" )
    @ nLin + 10, nCol + 1 SAY " ESCOLHA O CLIENTE E TECLE <ENTER> "

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DCLI
      DO FD_LCLI
      FD_TCLI( .F. )
      READ

      IF lastkey() <> 27 .AND. InputSN( "Confirma alteracao (S/N)?", 20 ) = "S" .AND. lastkey() <> 27
        DO FD_SCLI
        COMMIT
      ENDIF
    ENDIF

    IF InputSN( "Deseja continuar alteracao (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FDMREXC
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODCLI"
  vDados[2] = "BNOMCLI"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqCli

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "[ Exclusao ]" )
    @ nLin + 10, nCol + 1 SAY " ESCOLHA O CLIENTE E TECLE <ENTER> "

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DCLI
      DO FD_LCLI
      FD_TCLI( .F. )
      CLEAR GETS
      IF lastkey() <> 27 .and. InputSN( "Confirma exclusao (S/N)?", 20 ) = "S" .and. lastkey() <> 27
        DELETE
        PACK
      ENDIF
    ENDIF

    IF InputSN( "Deseja continuar exclusao (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FD_DCLI        && DEFINE VARIAVEIS DO CLIENTE
  PUBLIC CLI_COD, CLI_NOM, CLI_END, CLI_NUM
  PUBLIC CLI_BAI, CLI_FON, CLI_CID, CLI_EST

  CLI_COD = space(  5 )
  CLI_NOM = space( 30 )
  CLI_END = space( 25 )
  CLI_NUM = 0
  CLI_BAI = space( 25 )
  CLI_FON = space( 16 )
  CLI_CID = space( 25 )
  CLI_EST = space(  2 )
RETURN

PROCEDURE FD_LCLI        && LE VARIAVEIS DO ARQUIVO
  CLI_COD = BCODCLI
  CLI_NOM = BNOMCLI
  CLI_END = BENDCLI
  CLI_NUM = BNUMCLI
  CLI_BAI = BBAICLI
  CLI_FON = BFONCLI
  CLI_CID = BCIDCLI
  CLI_EST = BESTCLI
RETURN

PROCEDURE FD_SCLI
  REPLACE BCODCLI WITH CLI_COD
  REPLACE BNOMCLI WITH CLI_NOM
  REPLACE BENDCLI WITH CLI_END
  REPLACE BNUMCLI WITH CLI_NUM
  REPLACE BBAICLI WITH CLI_BAI
  REPLACE BFONCLI WITH CLI_FON
  REPLACE BCIDCLI WITH CLI_CID
  REPLACE BESTCLI WITH CLI_EST
RETURN

FUNCTION FD_TCLI        && TELA CLIENTE
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 12
  nCol = 18

  Window( nLin, nCol, nLin + 8, nCol + 50, "[ Manutencao de Clientes ]" )

  IF lCad
    @ nLin + 1, nCol + 2 SAY "Codigo...:" GET CLI_COD PICT "@!" VALID FDVERCLI( CLI_COD )
  ELSE
    @ nLin + 1, nCol + 2 SAY "Codigo...: " + CLI_COD
  ENDIF

  @ nLin + 3, nCol + 2 SAY "Nome.....:" GET CLI_NOM PICT "@!" VALID !EMPTY(CLI_NOM)
  @ nLin + 4, nCol + 2 SAY "Endereco.:" GET CLI_END PICT "@!"
  @ nLin + 4, col()+ 2 SAY "No.:"       GET CLI_NUM PICT "9999"
  @ nLin + 5, nCol + 2 SAY "Bairro...:" GET CLI_BAI PICT "@!"
  @ nLin + 6, nCol + 2 SAY "Telefone.:" GET CLI_FON PICT "(!999) !99-9999"
  @ nLin + 7, nCol + 2 SAY "Cidade...:" GET CLI_CID PICT "@!"
  @ nLin + 7, col()+ 2 SAY "UF.:"       GET CLI_EST PICT "!!" VALID VER_EST( CLI_EST )

RETURN .T.

FUNCTION FDVERCLI
  PARAM sCod

  IF empty( sCod )
    RETURN .F.
  ENDIF

  SELECT ArqCli
  GO TOP
  SEEK sCod

  IF FOUND()
    message( "Codigo de cliente ja cadastrado!!!", 12 )
    RETURN .F.
  ENDIF

RETURN .T.
