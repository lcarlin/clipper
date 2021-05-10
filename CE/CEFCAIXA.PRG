#include "common.ch"
#include "inkey.ch"
********************************
SELE 1
USE CEBLANCA

SELE 2
USE CeBLMC

sele 3
use CEbcusto

BEGIN SEQUENCE
      SELE 1
      SUM ALL Valor TO nDebito  FOR Tipo = "D"
      SUM ALL Valor TO nCredito FOR Tipo = "C"
      nTotal := if (nCredito>nDebito, nCredito-nDebito, nDebito-nCredito)
      cTipo  := if (nCredito>nDebito, "Credito", "Debito ")
      SELE 2
      SUM ALL Valor TO nDebito2  FOR Tipo = "D"
      SUM ALL Valor TO nCredito2 FOR Tipo = "C"
      IF cTipo = "Debito "
         nDebito2+=nTotal
      ELSE
         nCredito2+=nTotal
      ENDIF
      nTotal2 := if (nCredito2>nDebito2, nCredito2-nDebito2, nDebito2-nCredito2)
      cTipo2  := if (nCredito2>nDebito2, "Credito", "Debito")
      aMatMens := {"              Fechamento  DIARIO  do Caixa           ",;
                   "                                                     ",;
                   "         Diario :                     Mensal:        " ,;
                   "   Credito...:"+str(nCredito,10,2)+" | Credito...:"+str(nCredito2,10,2),;
                   "   Debito....:"+str(nDebito ,10,2)+" | Debito....:"+str(nDebito2 ,10,2),;
                   "   Total.....:"+str(nTotal  ,10,2)+" | Total.....:"+str(nTotal2  ,10,2),;
                   "   Situa‡ao..:"+cTipo+"    | Situa‡ao..:"+cTipo2}
      mensagem(aMatMens)
      IF confirma ("Deseja Realizar o fechamento DIARIO do Caixa")
         SELE 3
         APPEND FROM CABLANCA
         SELE 1
         ZAP
         SELE 2
         APPEND BLANK
         REPLACE Descricao WITH "Fechamento DIARIO do caixa ("+dtoc(data_sis)+")"
         REPLACE Data      WITH DATA_SIS
         REPLACE Tipo      WITH cTipo
         REPLACE Valor     WITH nTotal
      ELSE
         BREAK
      ENDIF
END SEQUENCE
CLOSE ALL
RELEASE ALL
RETURN

* eop cafcDIA.prg