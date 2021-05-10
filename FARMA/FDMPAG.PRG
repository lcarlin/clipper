PROCEDURE FDMCP01
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 10
    nCol = 26

    window( nLin, nCol, nLin + 5, nCol + 30, "[ Funcionarios ]" )
    @ nLin + 1, nCol + 1 PROMPT " 1 -    Ficha do Funcionario "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Controle de Funcionario "
    @ nLin + 3, nCol + 0 SAY   "쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴�"
    @ nLin + 4, nCol + 1 PROMPT " 3 -           Menu anterior "
    MENU TO nOpc

    DO CASE
      CASE nOpc = 1
        DO FDMPF01
      CASE nOpc = 3 .or. nOpc = 0
        EXIT
    ENDCASE
  ENDDO
  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMPF01
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 12
    nCol = 47

    window( nLin, nCol, nLin + 7, nCol + 16, "[ Opcoes ]" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Consultar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 1 PROMPT " 4 -   Excluir "
    @ nLin + 5, nCol + 0 SAY   "쳐컴컴컴컴컴컴컴�"
    @ nLin + 6, nCol + 1 PROMPT " 5 -  Retornar "
    MENU TO nOpc

    SELECT ArqFun
    SET ORDER TO 2
    GO TOP
    DO CASE
      CASE nOpc = 1
        SET ORDER TO 1
        DO FDMPFCAD
      CASE nOpc = 2
        DO FDMPFCON
      CASE nOpc = 3
        DO FDMPFALT
      CASE nOpc = 4
        DO FDMPFEXC
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE
    SET ORDER TO 1
  ENDDO
  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMPFCAD           && CADASTRO DE FUNCIONARIOS
  PRIVATE sTela

  SAVE SCREEN TO sTela

  SELECT ArqFun

  DO WHILE .T.
    DO FD_DFUN
    FD_TFUN( .T. )
    READ

    IF lastkey() <> 27 .and. InputSN( "Confirma cadastro do funcionario (S/N)?", 20 ) = "S" .and. lastkey() <> 27
      APPEND BLANK
      DO FD_SFUN
      COMMIT
    ENDIF

    IF InputSN( "Deseja continuar cadastro (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF
  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDMPFCON
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFUN"
  vDados[2] = "BNOMFUN"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqFun

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "[ Consulta ]" )
    @ nLin + 10, nCol + 1 SAY " ESCOLHA O FUNCIONARIO E TECLE <ENTER> "

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFUN
      DO FD_LFUN
      FD_TFUN( .F. )
      CLEAR GETS
    ENDIF

    IF InputSN( "Deseja continuar consulta (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FDMPFALT
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFUN"
  vDados[2] = "BNOMFUN"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqFun

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "[ Alteracao ]" )
    @ nLin + 10, nCol + 1 SAY " ESCOLHA O FUNCIONARIO E TECLE <ENTER> "

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFUN
      DO FD_LFUN
      FD_TFUN( .F. )
      READ
    ENDIF

    IF lastkey() <> 27
      IF InputSN( "Confirma alteracao (S/N)?", 20 ) = "S" .AND. lastkey() <> 27
        DO FD_SFUN
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

PROCEDURE FDMPFEXC
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFUN"
  vDados[2] = "BNOMFUN"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "@!"
  vPict[2] = "@!"

  SELECT ArqFun

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "[ Exclusao ]" )
    @ nLin + 10, nCol + 1 SAY " ESCOLHA O FUNCIONARIO E TECLE <ENTER> "

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFUN
      DO FD_LFUN
      FD_TFUN( .F. )
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

PROCEDURE FD_DFUN        && DEFINE VARIAVEIS DO FUNCIONARIO
  PUBLIC FUN_COD, FUN_NOM, FUN_END, FUN_NUM
  PUBLIC FUN_BAI, FUN_FON, FUN_CID, FUN_EST

  FUN_COD = space(  5 )
  FUN_NOM = space( 30 )
  FUN_END = space( 25 )
  FUN_NUM = 0
  FUN_BAI = space( 25 )
  FUN_FON = space( 16 )
  FUN_CID = space( 25 )
  FUN_EST = space(  2 )
RETURN

PROCEDURE FD_LFUN        && LE VARIAVEIS DO ARQUIVO
  FUN_COD = BCODFUN
  FUN_NOM = BNOMFUN
  FUN_END = BENDFUN
  FUN_NUM = BNUMFUN
  FUN_BAI = BBAIFUN
  FUN_FON = BFONFUN
  FUN_CID = BCIDFUN
  FUN_EST = BESTFUN
RETURN

PROCEDURE FD_SFUN
  REPLACE BCODFUN WITH FUN_COD
  REPLACE BNOMFUN WITH FUN_NOM
  REPLACE BENDFUN WITH FUN_END
  REPLACE BNUMFUN WITH FUN_NUM
  REPLACE BBAIFUN WITH FUN_BAI
  REPLACE BFONFUN WITH FUN_FON
  REPLACE BCIDFUN WITH FUN_CID
  REPLACE BESTFUN WITH FUN_EST
RETURN

FUNCTION FD_TFUN        && TELA FUNCIONARIO
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 12
  nCol = 18

  Window( nLin, nCol, nLin + 8, nCol + 50, "[ Manutencao de Funcionarios ]" )

  @ nLin + 1, nCol + 2 SAY "Codigo...:" GET FUN_COD PICT "@!" VALID FDVERFUN( FUN_COD )
  IF !lCad
    CLEAR GETS
  ENDIF

  @ nLin + 3, nCol + 2 SAY "Nome.....:" GET FUN_NOM PICT "@!" VALID !EMPTY(FUN_NOM)
  @ nLin + 4, nCol + 2 SAY "Endereco.:" GET FUN_END PICT "@!"
  @ nLin + 4, col()+ 2 SAY "No.:"       GET FUN_NUM PICT "9999"
  @ nLin + 5, nCol + 2 SAY "Bairro...:" GET FUN_BAI PICT "@!"
  @ nLin + 6, nCol + 2 SAY "Telefone.:" GET FUN_FON PICT "(!999) !99-9999"
  @ nLin + 7, nCol + 2 SAY "Cidade...:" GET FUN_CID PICT "@!"
  @ nLin + 7, col()+ 2 SAY "UF.:"       GET FUN_EST PICT "!!" VALID VER_EST( FUN_EST )

RETURN .T.

FUNCTION FDVERFUN
  PARAM sCod

  IF empty( sCod )
    RETURN .F.
  ENDIF

  SELECT ArqFun
  GO TOP
  SEEK sCod

  IF FOUND()
    message( "Codigo de funcionario ja cadastrado!!!", 12 )
    RETURN .F.
  ENDIF

RETURN .T.

FUNCTION VER_EST
  PARAM sEst

  IF sEst $ "SP*RJ*SC*MT*MS*GO*MG*TO*RO*RR*MA*SE*AC*AM*AP*PA*PB*RN*RS*PR*ES*PI*CE*DF*PE*BA*AL*FN"
     RETURN .T.
  ENDIF

  MESSAGE( "Estado invalido!!!", 12 )

RETURN .F.
