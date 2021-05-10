PROCEDURE FDMDUP01
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 10
    nCol = 26

    window( nLin, nCol, nLin + 5, nCol + 26, "Duplicatas" )
    @ nLin + 1, nCol + 1 PROMPT " 1 -          Duplicatas "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Baixa de Duplicatas "
    @ nLin + 3, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    @ nLin + 4, nCol + 1 PROMPT " 3 -       Menu anterior "
    MENU TO nOpc

    DO CASE
      CASE nOpc = 1
        DO FDMDUP03
      CASE nOpc = 3 .or. nOpc = 0
        EXIT
    ENDCASE
  ENDDO
  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMDUP03
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela
  DO WHILE .T.
    nLin = 12
    nCol = 47

    window( nLin, nCol, nLin + 6, nCol + 16, "Opcoes" )
    @ nLin + 1, nCol + 1 PROMPT " 1 - Cadastrar "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Consultar "
    @ nLin + 3, nCol + 1 PROMPT " 3 -   Alterar "
    @ nLin + 4, nCol + 0 SAY   "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
    @ nLin + 5, nCol + 1 PROMPT " 4 -  Retornar "
    MENU TO nOpc

    SELECT 1
    GO TOP
    DO CASE
      CASE nOpc = 1
        DO FDMDUPCAD
      CASE nOpc = 2
        DO FDMDUPCON
      CASE nOpc = 3
        DO FDMDUPEXC
      CASE nOpc = 4 .or. nOpc = 0
        EXIT
    ENDCASE
  ENDDO
  RESTORE SCREEN FROM sTela

RETURN

PROCEDURE FDMDUPCAD           && CADASTRO DE DUPLICATAS
  PRIVATE sTela

  SAVE SCREEN TO sTela

  SELECT 1

  DO WHILE .T.
    DO FD_DDUP
    FD_TDUP( .T. )
    READ

    IF lastkey() = 27
      EXIT
    ENDIF

    IF lastkey() <> 27 .and. InputSN( "Confirma cadastro de Duplicatas (S/N)?", 20 ) = "S" .and. lastkey() <> 27
      APPEND BLANK
      DO FD_SDUP
      COMMIT
    ENDIF

    IF InputSN( "Deseja continuar cadastro (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF
  ENDDO

  RESTORE SCREEN FROM sTela
RETURN

PROCEDURE FDMDUPCON
  PARAM nLin, nCol
  PRIVATE sTela, sTotal
  DECLARE vDados[2], vNome[2], vPict[2]

  SAVE SCREEN TO sTotal

  vDados[1] = "BCODFOR"
  vDados[2] = "BNUMDUP"

  vNome[1] = "Fornecedor"
  vNome[2] = "No. da Duplicata"

  vPict[1] = "9999"
  vPict[2] = "99999999"

  SELECT 1

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Consulta" )
    @ nLin + 10, nCol + 1 SAY "´ESCOLHA O DUPCIONARIO E TECLE <ENTER>Ã"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DDUP
      DO FD_LDUP
      FD_TDUP( .F. )
      CLEAR GETS
    ENDIF

    IF InputSN( "Deseja continuar consulta (S/N)?", 20 ) = "N" .or. lastkey() = 27
      EXIT
    ENDIF

    RESTORE SCREEN FROM sTela

  ENDDO

  RESTORE SCREEN FROM sTotal

RETURN

PROCEDURE FDMDUPALT
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

  SELECT 1

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Alteracao" )
    @ nLin + 10, nCol + 1 SAY "´ESCOLHA O DUPCIONARIO E TECLE <ENTER>Ã"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DDUP
      DO FD_LDUP
      FD_TDUP( .F. )
      READ
    ENDIF

    IF lastkey() <> 27
      IF InputSN( "Confirma alteracao (S/N)?", 20 ) = "S" .AND. lastkey() <> 27
        DO FD_SDUP
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

PROCEDURE FDMDUPEXC
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

  SELECT 1

  DO WHILE .T.
    nLin = 12
    nCol = 3

    SAVE SCREEN TO sTela

    window( nLin, nCol, nLin + 10, nCol + 60, "Exclusao" )
    @ nLin + 10, nCol + 1 SAY "´ESCOLHA O DUPCIONARIO E TECLE <ENTER>Ã"

    GO TOP
    DBEDIT( nLin + 1, nCol + 1, nLin + 9, nCol + 59, vDados, "", vPict, vNome )

    RESTORE SCREEN FROM sTela

    IF lastkey() <> 27
      DO FD_DDUP
      DO FD_LDUP
      FD_TDUP( .F. )
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

PROCEDURE FD_DDUP        && DEFINE VARIAVEIS DO DUPCIONARIO
  PUBLIC FOR_COD, FOR_NOM, DUP_NUM
  PUBLIC DUP_VAL, DUP_DTV

  FOR_COD = 0
  FOR_NOM = space( 30 )
  DUP_NUM = 0
  DUP_VAL = 0
  DUP_DTV = ctod("  /  /  ")
RETURN

PROCEDURE FD_LDUP           && LE VARIAVEIS DO ARQUIVO
  FOR_COD = BCODFOR
  FOR_NOM = BNOMFOR
  DUP_NUM = BNUMDUP
  DUP_VAL = BVALDUP
  DUP_DTV = BDTVENC
RETURN

PROCEDURE FD_SDUP
  SELECT 1
  REPLACE BCODFOR WITH FOR_COD
  REPLACE BNOMFOR WITH FOR_NOM
  REPLACE BNUMDUP WITH DUP_NUM
  REPLACE BVALDUP WITH DUP_VAL
  REPLACE BDTVENC WITH DUP_DTV
RETURN

FUNCTION FD_TDUP        && TELA DUPLICATAS
  PARAM lCad
  PRIVATE nLin, nCol

  nLin = 12
  nCol = 30

  Window( nLin + 1, nCol - 12, nLin + 9, nCol + 41, "Manutencao de Duplicatas" )

  @ nLin + 3, nCol - 10  SAY "Fornecedor....:" GET FOR_COD PICT "9999" VALID FDVERFOR2( FOR_COD )
  IF !lCad
     CLEAR GETS
  ENDIF

  @ nLin + 5, nCol - 10 SAY "No. Duplicata.:" GET DUP_NUM PICT "99999999"
  @ nLin + 6, nCol - 10 SAY "Valor.........:" GET DUP_VAL PICT "@E 999,999,999.99"
  @ nLin + 7, nCol - 10 SAY "Vencimento....:" GET DUP_DTV PICT "99/99/99"

RETURN .T.

FUNCTION FDVERFOR2
  PARAM sCod

  IF empty( sCod )
    RETURN .F.
  ENDIF

  SELECT ArqFor
  GO TOP
  SEEK sCod

  IF FOUND()
    message( "Fornecedor nao cadastrado!! - Tecle <ENTER>", 12 )
    RETURN .F.
  ENDIF

  nLin = 12
  nCol = 30

  @ nLin + 4, nCol - 10 SAY "Nome..........: " + BNOMFOR

RETURN .T.


