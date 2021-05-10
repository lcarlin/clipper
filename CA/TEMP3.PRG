/*
bop cafcaixa.prg

Programa   cafcaixa.prg
Autor      Luiz Antonio Carlin
data       07/07/95
funcao     Fechamento do caixa (diario e mensal)
Sistema    Contrle de acougues
Linguagem  Clipper 5.01

*/

USE caBLMC NEW

BEGIN SEQUENCE
      SUM ALL Valor TO nDebito  FOR Tipo = "D"
      SUM ALL Valor TO nCredito FOR Tipo = "C"
      nTotal := if (nCredito>nDebito, nCredito-nDebito, nDebito-nCredito)
      cTipo  := if (nCredito>nDebito, "Credito", "Debito ")
      aMatMens := {"Fechamento MENSAL do Caixa    ",;
                   "Credito...:"+str(nCredito,10,2),;
                   "Debito....:"+str(nDebito,10,2),;
                   "Total.....:"+str(nTotal,10,2),;      
                   "Situa‡ao..:"+cTipo}
      mensagem(aMatMens)
      IF confirma ("Deseja Realizar o fechamento MENSAL do Caixa")
         ZAP
         dbAppend()
         REPLACE Descricao WITH "Fechamento MENSAL do caixa ("+dtoc(data_sis)+")"
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
