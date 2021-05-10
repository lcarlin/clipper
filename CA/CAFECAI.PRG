/*
bop cafcaixa.prg

Programa   cafcaixa.prg
Autor      Luiz Antonio Carlin
data       07/07/95
funcao     Fechamento do caixa (diario e mensal)
Sistema    Contrle de acougues
Linguagem  Clipper 5.01

*/
PARAMETERS TIPO_F


TEXTO_FEC := IF(TIPO_F=1," DIARIO "," MENSAL ")

SELE 1
USE caBLANCA

SELE 2
USE caBLMC

sele 3
use cabcusto


BEGIN SEQUENCE
      SELE &TIPO_F
      SUM ALL Valor TO nDebito  FOR Tipo = "D"
      SUM ALL Valor TO nCredito FOR Tipo = "C"
      nTotal := if (nCredito>nDebito, nCredito-nDebito, nDebito-nCredito)
      cTipo  := if (nCredito>nDebito, "C", "D")
      sombra(07,20,16,43)
      aMatMens := {"
      @ 07,21 say "Fechamento"+texto_fec
      @ 08,21 say "Credito..." GET nCredito PICT "999,999.99"
      @ 10,21 SAY "Debito...." GET nDebito  PICT "999,999.99"
      @ 12,21 SAY "Total....." GET nTotal   PICT "999,999.99"
      @ 14,21 SAY "Situa‡ao.." GET cTipo
      CLEAR GETS
      INKEY(6)
      IF confirma ("Deseja Realizar o fechamento"+TEXTO_FEC+"do Caixa")
         IF tipo_f = 1
            SELE 3
            APPEND FROM CABLANCA
            SELE 2
         ENDIF
         ZAP
         SELE 2
         APPEND BLANK
         REPLACE Descricao WITH "Fechamento"+texto_fec+"do caixa ("+dtoc(data_sis)+")"
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

* eop cafcaixa.prg