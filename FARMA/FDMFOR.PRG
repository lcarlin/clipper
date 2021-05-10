PROCEDURE FDMFOR01
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 12
    nCol = 32

    window( nLin, nCol, nLin + 7 , nCol + 16, "Opcoes" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Consultar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 1 PROMPT " 4 -   Excluir "
    @ nLin + 5, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    @ nLin + 6, nCol + 1 PROMPT " 5 -  Retornar "
    MENU TO nOpc

    SELECT ArqFor
    GO TOP
    DO CASE
      CASE nOpc = 1
        DO FDMFUNCAD
      CASE nOpc = 2
        DO FDMFUNCON
      CASE nOpc = 3
        DO FDMFUNALT
      CASE nOpc = 4
        DO FDMFUNEXC
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE
    SET ORDER TO 1
  ENDDO
  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMFUNCAD           && CADASTRO DE FORCIONARIOS
  PRIVATE sTela

  SAVE SCREEN TO sTela

  SELECT ArqFor

  DO WHILE .T.
    DO FD_DFOR
    FD_TFOR( .T. )
    READ

    IF lastkey() = 27
      EXIT
    ENDIF

    IF lastkey() <> 27 .and. InputSN( "Confirma cadastro do fornecedor (S/N)?", 20 ) = "S" .and. lastkey() <> 27
      APPEND BLANK
      DO FD_SFOR
      COMMIT
    ENDIF

    IF InputSN( "Deseja continuar cadastro (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF
  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDMFUNCON
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFOR"
  vDados[2] = "BNOMFOR"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqFor

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Consulta" )
    @ nLin + 10, nCol + 1 SAY "´ESCOLHA O FORNECEDOR E TECLE <ENTER>Ã"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFOR
      DO FD_LFOR
      FD_TFOR( .F. )
      CLEAR GETS
    ENDIF

    IF InputSN( "Deseja continuar consulta (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FDMFUNALT
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFOR"
  vDados[2] = "BNOMFOR"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqFor

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Alteracao" )
    @ nLin + 10, nCol + 1 SAY "´ESCOLHA O FORNECEDOR E TECLE <ENTER>Ã"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFOR
      DO FD_LFOR
      FD_TFOR( .F. )
      READ
    ENDIF

    IF lastkey() <> 27
      IF InputSN( "Confirma alteracao (S/N)?", 20 ) = "S" .AND. lastkey() <> 27
        DO FD_SFOR
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

PROCEDURE FDMFUNEXC
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFOR"
  vDados[2] = "BNOMFOR"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqFor

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Exclusao" )
    @ nLin + 10, nCol + 1 SAY "´ESCOLHA O FORCIONARIO E TECLE <ENTER>Ã"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFOR
      DO FD_LFOR
      FD_TFOR( .F. )
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

PROCEDURE FD_DFOR        && DEFINE VARIAVEIS DO FORCIONARIO
  PUBLIC FOR_COD, FOR_NOM

  FOR_COD = space(  5 )
  FOR_NOM = space( 30 )
RETURN

PROCEDURE FD_LFOR        && LE VARIAVEIS DO ARQUIVO
  FOR_COD = BCODFOR
  FOR_NOM = BNOMFOR
RETURN

PROCEDURE FD_SFOR
  REPLACE BCODFOR WITH FOR_COD
  REPLACE BNOMFOR WITH FOR_NOM
RETURN

FUNCTION FD_TFOR        && TELA FORCIONARIO
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 14
  nCol = 25

  Window( nLin, nCol, nLin + 6, nCol + 44, "Manutencao de Fornecedores" )

  @ nLin + 2, nCol + 2 SAY "Codigo...:" GET FOR_COD PICT "@!" VALID FDVERFOR( FOR_COD )
  IF !lCad
    CLEAR GETS
  ENDIF

  @ nLin + 4, nCol + 2 SAY "Nome.....:" GET FOR_NOM PICT "@!" VALID !EMPTY(FOR_NOM)

RETURN .T.

FUNCTION FDVERFOR
  PARAM sCod

  IF empty( sCod )
    RETURN .F.
  ENDIF

  SELECT ArqFor
  GO TOP
  SEEK sCod

  IF FOUND()
    message( "Fornecedor ja cadastrado!!! - Tecle <ENTER>", 12 )
    RETURN .F.
  ENDIF

RETURN .T.

