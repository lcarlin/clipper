*********************************************************************
* BOP CVREST.PRG                                                    *
* PROGRAMA  : CVRCLI.PRG                                            *
* OBJETIVO  : RELATORIOS DE CLIENTES E CONSORCIADOS                 *
* AUTORES   : OSWALDO\WILSON                                        *
* DATA      : 30/05/94                                              *
*********************************************************************

SAVE SCREEN TO TELA_RCLI
BORDA(05,54,09,67)
USE CVBCLIEN INDEX CVICLI1
OPR=0
@ 06,55 PROMPT "   Pecas    "
@ 07,55 PROMPT "Amoxarifado "
@ 08,55 PROMPT "   Frota    "
MENU TO OPR
IF OPR=1
   DO CVRPECAS
ELSEIF OPR=2
   DO CVRALM
ELSEIF OPR=3
   DO CVRFROTA
ELSE
  CLOSE DATABASES
  RESTORE SCREEN FROM TELA_RCLI
  RETURN
ENDIF
