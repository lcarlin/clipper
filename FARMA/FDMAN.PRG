SET PROCEDURE TO FDMAN01

PRIVATE nOpc

SAVE SCREEN TO FD_MAN

DO WHILE .T.
  nLin = 5
  nCol = 18

  window( nLin, nCol, nLin + 9 , nCol + 20, "Manutencao" )
  @ nLin + 1, nCol + 1 PROMPT " 1 -      Clientes "
  @ nLin + 2, nCol + 1 PROMPT " 2 -  Fornecedores "
  @ nLin + 3, nCol + 1 PROMPT " 3 -  Funcionarios "
  @ nLin + 4, nCol + 1 PROMPT " 4 -      Produtos "
  @ nLin + 5, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
  @ nLin + 6, nCol + 1 PROMPT " 5 -    Relatorios "
  @ nLin + 7, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
  @ nLin + 8, nCol + 1 PROMPT " 6 - Menu anterior "
  MENU TO nOpc

  DO CASE
    CASE nOpc = 1
      DO FDMCLI
    CASE nOpc = 2
      DO FDMFOR
    CASE nOpc = 3
      DO FDMFUN
    CASE nOpc = 4
      DO FDMPRO
    CASE nOpc = 5
      DO FDMREL
    CASE nOpc = 6 .or. nOpc = 0
      EXIT
  ENDCASE
ENDDO
RESTORE SCREEN FROM FD_MAN

PROCEDURE FDMCLI
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 7
    nCol = 33

    window( nLin, nCol, nLin + 7, nCol + 16, "Opcoes" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Consultar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 1 PROMPT " 4 -   Excluir "
    @ nLin + 5, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
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

    IF lastkey() <> 27
      IF InputSN( "Confirma cadastro do cliente (S/N)?", 20 ) = "S" .and. lastkey() <> 27
        APPEND BLANK
        DO FD_SCLI
        COMMIT
      ENDIF
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

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqCli

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Consulta" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O CLIENTE E TECLE <ENTER> Æ"

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

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqCli

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Alteracao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O CLIENTE E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DCLI
      DO FD_LCLI
      FD_TCLI( .F. )
      READ

      IF lastkey() <> 27
        IF InputSN( "Confirma alteracao (S/N)?", 20 ) = "S" .AND. lastkey() <> 27
          DO FD_SCLI
          COMMIT
        ENDIF
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

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqCli

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Exclusao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O CLIENTE E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DCLI
      DO FD_LCLI
      FD_TCLI( .F. )
      CLEAR GETS
      IF InputSN( "Confirma exclusao (S/N)?", 20 ) = "S" .and. lastkey() <> 27
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

  CLI_COD = 0
  CLI_NOM = space( 30 )
  CLI_END = space( 25 )
  CLI_NUM = 0
  CLI_BAI = space( 25 )
  CLI_FON = space( 16 )
  CLI_CID = space( 25 )
  CLI_EST = space(  2 )
RETURN

PROCEDURE FD_LCLI        && LE VARIAVEIS DO ARQUIVO
  CLI_COD = ArqCli->BCODCLI
  CLI_NOM = ArqCli->BNOMCLI
  CLI_END = ArqCli->BENDCLI
  CLI_NUM = ArqCli->BNUMCLI
  CLI_BAI = ArqCli->BBAICLI
  CLI_FON = ArqCli->BFONCLI
  CLI_CID = ArqCli->BCIDCLI
  CLI_EST = ArqCli->BESTCLI
RETURN

PROCEDURE FD_SCLI
  REPLACE ArqCli->BCODCLI WITH CLI_COD
  REPLACE ArqCli->BNOMCLI WITH CLI_NOM
  REPLACE ArqCli->BENDCLI WITH CLI_END
  REPLACE ArqCli->BNUMCLI WITH CLI_NUM
  REPLACE ArqCli->BBAICLI WITH CLI_BAI
  REPLACE ArqCli->BFONCLI WITH CLI_FON
  REPLACE ArqCli->BCIDCLI WITH CLI_CID
  REPLACE ArqCli->BESTCLI WITH CLI_EST
RETURN

FUNCTION FD_TCLI        && TELA CLIENTE
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 10
  nCol = 18

  Window( nLin, nCol, nLin + 8, nCol + 50, "Manutencao de Clientes" )

  @ nLin + 1, nCol + 2 SAY "Codigo...:" GET CLI_COD PICT "99999" VALID FDVERCLI( CLI_COD )
  IF !lCad
    CLEAR GETS
  ENDIF
  @ nLin + 2, nCol SAY "Ç" + replicate( "Ä", 49 ) + "¶"

  @ nLin + 3, nCol + 2 SAY "Nome.....:" GET CLI_NOM PICT "@!" VALID (lastkey() = 5) .OR. !EMPTY(CLI_NOM)
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

PROCEDURE FDMFUN
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 9
    nCol = 33

    window( nLin, nCol, nLin + 7, nCol + 16, "Opcoes" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Consultar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 1 PROMPT " 4 -   Excluir "
    @ nLin + 5, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
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

    IF lastkey() <> 27
      IF InputSN( "Confirma cadastro do funcionario (S/N)?", 20 ) = "S" .and. lastkey() <> 27
        APPEND BLANK
        DO FD_SFUN
        COMMIT
      ENDIF
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

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqFun

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Consulta" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O FUNCIONARIO E TECLE <ENTER> Æ"

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

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqFun

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Alteracao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O FUNCIONARIO E TECLE <ENTER> Æ"

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

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqFun

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Exclusao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O FUNCIONARIO E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFUN
      DO FD_LFUN
      FD_TFUN( .F. )
      CLEAR GETS
      IF InputSN( "Confirma exclusao (S/N)?", 20 ) = "S" .and. lastkey() <> 27
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
  PUBLIC FUN_SAL

  FUN_COD = 0
  FUN_NOM = space( 30 )
  FUN_END = space( 25 )
  FUN_NUM = 0
  FUN_BAI = space( 25 )
  FUN_FON = space( 16 )
  FUN_CID = space( 25 )
  FUN_EST = space(  2 )
  FUN_SAL = 0
RETURN

PROCEDURE FD_LFUN        && LE VARIAVEIS DO ARQUIVO
  FUN_COD = ArqFun->BCODFUN
  FUN_NOM = ArqFun->BNOMFUN
  FUN_END = ArqFun->BENDFUN
  FUN_NUM = ArqFun->BNUMFUN
  FUN_BAI = ArqFun->BBAIFUN
  FUN_FON = ArqFun->BFONFUN
  FUN_CID = ArqFun->BCIDFUN
  FUN_EST = ArqFun->BESTFUN
  FUN_SAL = ArqFun->BSALFUN
RETURN

PROCEDURE FD_SFUN
  REPLACE ArqFun->BCODFUN WITH FUN_COD
  REPLACE ArqFun->BNOMFUN WITH FUN_NOM
  REPLACE ArqFun->BENDFUN WITH FUN_END
  REPLACE ArqFun->BNUMFUN WITH FUN_NUM
  REPLACE ArqFun->BBAIFUN WITH FUN_BAI
  REPLACE ArqFun->BFONFUN WITH FUN_FON
  REPLACE ArqFun->BCIDFUN WITH FUN_CID
  REPLACE ArqFun->BESTFUN WITH FUN_EST
  REPLACE ArqFun->BSALFUN WITH FUN_SAL
RETURN

FUNCTION FD_TFUN        && TELA FUNCIONARIO
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 09
  nCol = 18

  Window( nLin, nCol, nLin + 10, nCol + 50, "Manutencao de Funcionarios" )

  @ nLin + 1, nCol + 2 SAY "Codigo...:" GET FUN_COD PICT "99999" VALID FDVERFUN( FUN_COD )
  IF !lCad
    CLEAR GETS
  ENDIF
  @ nLin + 2, nCol SAY "Ç" + replicate( "Ä" , 49 ) + "¶"

  @ nLin + 3, nCol + 2 SAY "Nome.....:" GET FUN_NOM PICT "@!" VALID !EMPTY(FUN_NOM)
  @ nLin + 4, nCol + 2 SAY "Endereco.:" GET FUN_END PICT "@!"
  @ nLin + 4, col()+ 2 SAY "No.:"       GET FUN_NUM PICT "9999"
  @ nLin + 5, nCol + 2 SAY "Bairro...:" GET FUN_BAI PICT "@!"
  @ nLin + 6, nCol + 2 SAY "Telefone.:" GET FUN_FON PICT "(!999) !99-9999"
  @ nLin + 7, nCol + 2 SAY "Cidade...:" GET FUN_CID PICT "@!"
  @ nLin + 7, col()+ 2 SAY "UF.:"       GET FUN_EST PICT "!!" VALID VER_EST( FUN_EST )
  @ nLin + 8, nCol SAY "Ç" + replicate( "Ä" , 49 ) + "¶"
  @ nLin + 9, nCol + 2 SAY "Salario..:" GET FUN_SAL PICT "@E 999,999,999.99"

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

PROCEDURE FDMPRO
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 10
    nCol = 33

    window( nLin, nCol, nLin + 7, nCol + 16, "Opcoes" )

    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Pesquisar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 1 PROMPT " 4 -   Excluir "
    @ nLin + 5, nCol + 0 SAY "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    @ nLin + 6, nCol + 1 PROMPT " 5 -  Retornar "

    MENU TO nOpc

    DO CASE
      CASE nOpc = 1
        DO FDMECAD
      CASE nOpc = 2
        DO FDMECON
      CASE nOpc = 3
        DO FDMEALT
      CASE nOpc = 4
        DO FDMEEXC
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE

  ENDDO

  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMECAD           && CADASTRO DE CLIENTES
  PRIVATE sTela

  SAVE SCREEN TO sTela

  SELECT ArqPro

  DO WHILE .T.
    DO FD_DPRO
    FD_TPRO( .T. )
    READ

    IF lastkey() <> 27
      IF InputSN( "Confirma cadastro do produto (S/N)?", 20 ) = "S" .and. lastkey() <> 27
        APPEND BLANK
        DO FD_SPRO
        COMMIT
      ENDIF
    ENDIF

    IF InputSN( "Deseja continuar cadastro (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF
  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDMECON
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[4], vNome[4], vPict[4]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODPRO"
  vDados[2] = "BDESPRO"
  vDados[3] = "BVALPRO"
  vDados[4] = "BTIPPRO"

  vNome[1] = "Codigo"
  vNome[2] = "Descricao"
  vNome[3] = "Valor"
  vNome[4] = "Tipo"

  vPict[1] = "99999"
  vPict[2] = "@!"
  vPict[3] = "@E 999,999,999.99"
  vPict[4] = "@!"

  SELECT ArqPro

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Consulta" )
    @ nLin + 10, nCol + 1 SAY "µ Escolha o produto e Tecle <Enter> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DPRO
      DO FD_LPRO
      FD_TPRO( .T. )
      CLEAR GETS
    ENDIF

    IF InputSN( "Deseja continuar consulta (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FDMEALT
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[4], vNome[4], vPict[4]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODPRO"
  vDados[2] = "BDESPRO"
  vDados[3] = "BVALPRO"
  vDados[4] = "BTIPPRO"

  vNome[1] = "Codigo"
  vNome[2] = "Descricao"
  vNome[3] = "Valor"
  vNome[4] = "Tipo"

  vPict[1] = "99999"
  vPict[2] = "@!"
  vPict[3] = "@E 999,999,999.99"
  vPict[4] = "@!"

  SELECT ArqPro

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Alteracao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O PRODUTO E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DPRO
      DO FD_LPRO
      FD_TPRO( .F. )
      READ

      IF lastkey() <> 27 .AND. InputSN( "Confirma alteracao (S/N)?", 20 ) = "S" .AND. lastkey() <> 27
        DO FD_SPRO
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

PROCEDURE FDMEEXC
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[4], vNome[4], vPict[4]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODPRO"
  vDados[2] = "BDESPRO"
  vDados[3] = "BVALPRO"
  vDados[4] = "BTIPPRO"

  vNome[1] = "Codigo"
  vNome[2] = "Descricao"
  vNome[3] = "Valor"
  vNome[4] = "Tipo"

  vPict[1] = "99999"
  vPict[2] = "@!"
  vPict[3] = "@E 999,999,999.99"
  vPict[4] = "@!"

  SELECT ArqPRO

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Exclusao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O PRODUTO E TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DPRO
      DO FD_LPRO
      FD_TPRO( .T. )
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

PROCEDURE FD_DPRO
  PUBLIC PRO_COD, PRO_DES, PRO_QTE
  PUBLIC PRO_VAL, PRO_TIP

  PRO_COD = 0
  PRO_DES = space( 30 )
  PRO_VAL = 0
  PRO_TIP = space( 15 )
  PRO_QTE = 0
RETURN

PROCEDURE FD_LPRO
  PRO_COD = ArqPro->BCODPRO
  PRO_DES = ArqPro->BDESPRO
  PRO_VAL = ArqPro->BVALPRO
  PRO_TIP = ArqPro->BTIPPRO
  PRO_QTE = ArqPro->BQTEPRO
RETURN

PROCEDURE FD_SPRO
  REPLACE ArqPro->BCODPRO WITH PRO_COD
  REPLACE ArqPro->BDESPRO WITH PRO_DES
  REPLACE ArqPro->BVALPRO WITH PRO_VAL
  REPLACE ArqPro->BTIPPRO WITH PRO_TIP
  REPLACE ArqPro->BQTEPRO WITH PRO_QTE
RETURN

FUNCTION FD_TPRO           && TELA DE PRODUTO
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 12
  nCol = 18

  window( nLin, nCol, nLin + 6, nCol + 50, "Manutencao de Produtos" )

  @ nLin + 1, nCol + 2 SAY "Codigo....:" GET PRO_COD PICT "99999" VALID !empty( PRO_COD ) .and. FDVERPRO( PRO_COD )
  IF !lCad
    CLEAR GETS
  ENDIF
  @ nLin + 2, nCol SAY "Ç" + replicate( "Ä", 49 ) + "¶"

  @ nLin + 3, nCol + 2 SAY "Descricao.:" GET PRO_DES PICT "@!"
  @ nLin + 4, nCol + 2 SAY "Tipo......:" GET PRO_TIP PICT "@!"
  @ nLin + 5, nCol + 2 SAY "Valor.....:" GET PRO_VAL PICT "@E 999,999,999.99"

RETURN .T.

FUNCTION FDVERPRO
  PARAM sCod

  IF empty( sCod )
    RETURN .F.
  ENDIF

  SELECT ArqPro
  GO TOP
  SEEK sCod

  IF FOUND()
    message( "Produto ja cadastrado!!!", 12 )
    RETURN .F.
  ENDIF

RETURN .T.

PROCEDURE FDMFOR
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 8
    nCol = 33

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
        DO FDMFCAD
      CASE nOpc = 2
        DO FDMFCON
      CASE nOpc = 3
        DO FDMFALT
      CASE nOpc = 4
        DO FDMFEXC
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE
    SET ORDER TO 1
  ENDDO
  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMFCAD           && CADASTRO DE FORNECEDORES
  PRIVATE sTela

  SAVE SCREEN TO sTela

  SELECT ArqFor

  DO WHILE .T.
    DO FD_DFOR
    FD_TFOR( .T. )
    READ

    IF lastkey() <> 27
      IF InputSN( "Confirma cadastro do Fornecedor(S/N)?", 20 ) = "S" .and. lastkey() <> 27
        APPEND BLANK
        DO FD_SFOR
        COMMIT
      ENDIF
    ENDIF

    IF InputSN( "Deseja continuar cadastro (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF
    FOR_EST = SPACE(2)
  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDMFCON
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFOR"
  vDados[2] = "BNOMFOR"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqFor

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Consulta" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O FORNECEDOR TECLE <ENTER> Æ"

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

PROCEDURE FDMFALT
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFOR"
  vDados[2] = "BNOMFOR"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqFor

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Alteracao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O FORNECEDOR TECLE <ENTER> Æ"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DFOR
      DO FD_LFOR
      FD_TFOR( .F. )
      READ

      IF lastkey() <> 27
        IF InputSN( "Confirma alteracao (S/N)?", 20 ) = "S" .AND. lastkey() <> 27
          DO FD_SFOR
          COMMIT
        ENDIF
      ENDIF
    ENDIF

    IF InputSN( "Deseja continuar alteracao (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FDMFEXC
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFOR"
  vDados[2] = "BNOMFOR"

  vNome[1] = "Codigo"
  vNome[2] = "Nome"

  vPict[1] = "99999"
  vPict[2] = "@!"

  SELECT ArqFor

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Exclusao" )
    @ nLin + 10, nCol + 1 SAY "µ ESCOLHA O FORNECEDOR TECLE <ENTER> Æ"

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

PROCEDURE FD_DFOR        && DEFINE VARIAVEIS DO FORNECEDORE
  PUBLIC FOR_COD, FOR_NOM, FOR_END, FOR_NUM
  PUBLIC FOR_BAI, FOR_FON, FOR_CID, FOR_EST

  FOR_COD = 0
  FOR_NOM = space( 30 )
  FOR_END = space( 25 )
  FOR_NUM = 0
  FOR_BAI = space( 25 )
  FOR_FON = space( 16 )
  FOR_CID = space( 25 )
  FOR_EST = space(  2 )
RETURN

PROCEDURE FD_LFOR        && LE VARIAVEIS DO ARQUIVO
  FOR_COD = ArqFor->BCODFOR
  FOR_NOM = ArqFor->BNOMFOR
  FOR_END = ArqFor->BENDFOR
  FOR_NUM = ArqFor->BNUMFOR
  FOR_BAI = ArqFor->BBAIFOR
  FOR_FON = ArqFor->BFONFOR
  FOR_CID = ArqFor->BCIDFOR
  FOR_EST = ArqFor->BESTFOR
RETURN

PROCEDURE FD_SFOR
  REPLACE BCODFOR WITH FOR_COD
  REPLACE BNOMFOR WITH FOR_NOM
  REPLACE BENDFOR WITH FOR_END
  REPLACE BNUMFOR WITH FOR_NUM
  REPLACE BBAIFOR WITH FOR_BAI
  REPLACE BFONFOR WITH FOR_FON
  REPLACE BCIDFOR WITH FOR_CID
  REPLACE BESTFOR WITH FOR_EST
RETURN

FUNCTION FD_TFOR        && TELA FORNECEDORE
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 10
  nCol = 18

  Window( nLin, nCol, nLin + 8, nCol + 50, "Manutencao de Fornecedores" )

  @ nLin + 1, nCol + 2 SAY "Codigo...:" GET FOR_COD PICT "99999" VALID FDVERFOR( FOR_COD )
  IF !lCad
    CLEAR GETS
  ENDIF
  @ nLin + 2, nCol SAY "Ç" + replicate( "Ä", 49 ) + "¶"

  @ nLin + 3, nCol + 2 SAY "Nome.....:" GET FOR_NOM PICT "@!" VALID (lastkey() = 5) .OR. !EMPTY(FOR_NOM)
  @ nLin + 4, nCol + 2 SAY "Endereco.:" GET FOR_END PICT "@!"
  @ nLin + 4, col()+ 2 SAY "No.:"       GET FOR_NUM PICT "9999"
  @ nLin + 5, nCol + 2 SAY "Bairro...:" GET FOR_BAI PICT "@!"
  @ nLin + 6, nCol + 2 SAY "Telefone.:" GET FOR_FON PICT "(!999) !99-9999"
  @ nLin + 7, nCol + 2 SAY "Cidade...:" GET FOR_CID PICT "@!"
  @ nLin + 7, col()+ 2 SAY "UF.:"       GET FOR_EST PICT "!!" VALID VER_EST( FOR_EST )

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
    message( "Codigo de fornecedor ja cadastrado!!!", 12 )
    RETURN .F.
  ENDIF

RETURN .T.
