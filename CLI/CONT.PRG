*************************************************************************
* Bop cont.prg
* Programa  : cont.prg
* Autor     : Luiz A. Carlin 3§ A;   N§ 14
* Data      : 31/03/94
* Objetivo  : menu Principal do sistema contabil
*************************************************************************
set procedure to geral
set delete on
set score off
SET CONFIRM ON
set date british
set wrap on
set message to 23 center
set procedure to cont
op=0
quadro =chr(223)
quadro2=replicate(chr(176),9)
arquivo()
use clientes index ind_cli
PUBLIC MCOD, MNOME, MEND, MCID, MCP, MEST, MTEL, MOBS, MOBS2
do while .t.
   set color to b/w
   @ 00,00,24,79 box quadro
   set color to w+/b
   @ 01,01,23,78 box quadro2
   set color to w/n+
   set color to n/w
   @ 01,21 say "Sistema de Controle de Clientes û 1.0"
   @ 02,21 say "          Corsa-Soft  # 1994         "
   set color to w/n
   @ 08,32,15,52 box quadro2
   @ 07,30 to 14,50
   @ 07,31 SAY    "º Menu Principal º"
   @ 08,31 prompt "    1-Inclus„o     " message " Inclus„o  de  clientes "
   @ 09,31 prompt "    2-Exclus„o     " message " Exclus„o  de  clientes "
   @ 10,31 prompt "    3-Altera‡„o    " message " Altera‡„o de  clientes "
   @ 11,31 prompt "    4-Consulta     " message " Consulta  de  clientes "
   @ 12,31 prompt "    5-Relat¢rio    " message " Relat¢rio de  clientes "
   @ 13,31 prompt "    6-  Sair       " message " Encerrar  o  programa  "
   menu to op
   do case
      case op=1
           do inclui
      case op=2
           do exclui
      case op=3
           do alterar
      case op=4
           do consulta
      case op=5
           do relat
      case op=6
           sai()
   endcase

enddo

* eop cont.prg