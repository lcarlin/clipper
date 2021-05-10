PROCEDURE FDMR02
  PRIVATE nOpc, sTela

  SAVE SCREEN TO sTela

  DO WHILE .T.
    nLin = 9
    nCol = 33

    window( nLin, nCol, nLin + 7, nCol + 28, "[ Controle de Contas ]" )
    @ nLin + 1, nCol + 1 PROMPT " 1 -  Inclusao de Produtos "
    @ nLin + 2, nCol + 1 PROMPT " 2 - Alteracao de Produtos "
    @ nLin + 3, nCol + 1 PROMPT " 3 -  Consulta de Produtos "
    @ nLin + 4, nCol + 1 PROMPT " 4 -  Fechamento de Contas "
    @ nLin + 5, nCol + 0 SAY   "쳐컴컴컴컴컴컴컴컴컴컴컴컴컴�"
    @ nLin + 6, nCol + 1 PROMPT " 5 -         Menu anterior "
    MENU TO nOpc

    DO CASE
      CASE nOpc = 5 .or. nOpc = 0
        EXIT
    ENDCASE
  ENDDO

  RESTORE SCREEN FROM sTela

RETURN
