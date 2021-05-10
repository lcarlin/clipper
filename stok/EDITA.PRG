SAVE SCREEN TO TELA_DOS
clear typeahead
ARQ=DBF()
set deleted off
LIN=ROW()
COLU=COL()
clear
PUBLIC CMAT, INDICE, procura
use movime
GOTO TOP
DECLARE MCAMP[10]
 MCAMP[1]  =  "CODESCO"
 MCAMP[2]  =  "ESCOLA"
 MCAMP[3]  =  "CODMAT"
 MCAMP[4]  =  "MATERIAL"
 MCAMP[5]  =  "DATA"
 MCAMP[6]  =  "NTDOC"
 MCAMP[7]  =  "QTDENDTR"
 MCAMP[8]  =  "QTDSAL"
 MCAMP[9]  =  "VALENTR"
 MCAMP[10] =  "VALSAL2"

DECLARE MMASC[10]
 MMASC[1]  =  "@!"
 MMASC[2]  =  "@!"
 MMASC[3]  =  "@!"
 MMASC[4]  =  "@!"
 MMASC[5]  =  "99/99/99"
 MMASC[6]  =  "@!"
 MMASC[7]  =  "99999"
 MMASC[8]  =  "99999"
 MMASC[9]  =  "999999,999.99"
 MMASC[10] =  "999999,999.99"

DECLARE MCAB[10]
 MCAB[1]  =  "COD.ESC"
 MCAB[2]  =  "ESCOLA"
 MCAB[3]  =  "COD.MAT"
 MCAB[4]  =  "MATERIAL"
 MCAB[5]  =  "DATA"
 MCAB[6]  =  "NOTA"
 MCAB[7]  =  "QT.ENT"
 MCAB[8]  =  "QT.SAL"
 MCAB[9]  =  "VL.ENT"
 MCAB[10]  = "VL.SAL"


CLOSE ALL

USE MOVIME
@ 00,00,24,79 BOX CHR(127)+CHR(176)+CHR(127)+chr(176)+chr(127)+chr(176)+chr(127)+chr(176)
set color to n/w
@ 00,25 SAY "Consula Geral"
set color to w/n
@ 3,5 SAY "<DEL>Exclui; <ESC>Sai  Arquivo : "+DBF()
SET COLOR TO BW+/W
@ 22,1 SAY CHR(17)
@ 22,76 SAY CHR(16)
@ 5,77 SAY CHR(30)
@ 21,77 SAY CHR(31)
SET COLOR TO
@ 22,3 say "<F5>                     º <F6>                       º <F10>"
@ 23,3 say "Filtra Codigos De Escolasº Filtra Codigos De Materiaisº Filtra Materiais"
DBEDIT(5,5,20,73,MCAMP,"EDITAR",MMASC,MCAB,.t.,.t.,.t.)
*DBEDIT(5,5,20,73,MCAMP,"EDITAR",MMASC,MCAB,CHR(196),CHR(179),chr(196))
CLOSE ALL
IF .NOT. EMPTY(ARQ)
   USE &ARQ
ENDIF
set cursor on
set deleted on
RESTORE SCREEN FROM TELA_DOS
@ LIN,COLU SAY""

*********************************************
FUNCTION EDITAR
PARAMETER STATUS
INDICE=1
TECLA=LASTKEY()
CMAT=SPACE(1)
PRIVATE TECLA,
@ 4,5 SAY ALLTRIM(STR(RECNO(),6,0))+"/"+ALLTRIM(STR(RECCOUNT(),6,0))+"  Pos. Relat.   "
*@ 6,5 TO 20,73
IF .NOT. DELETED()
   @ 4,60 SAY "        "
ELSE
   @ 4,60 SAY "DELETADO"
ENDIF
IF STATUS=4
  IF TECLA=7
      IF .NOT. DELETED()
         DELE
         @ 4,60 SAY "DELETADO"
         RETURN 1
      ELSE
         RECALL
         @ 4,60 say "        "
         RETURN 1
      ENDIF
   ELSEIF TECLA=-4
      TELADB=SAVESCREEN(10,10,18,30)
      PROCURA=SPACE(8)
      SET CURSOR ON
      @ 21,18 SAY "Codigo Da Escola : " get PROCURA PICT "@!"
      READ
      SET CURSOR OFF
      @ 21,18 SAY "                             "
      IF EMPTY(PROCURA)
         RETURN 1
      ENDIF
      set filter to codesco=procura
      GOTO TOP
      @ 21,52 SAY "<F9>-Limpa O Filtro"
      return 2
   ELSEIF TECLA=-5
      PROCURA = SPACE(15)
      SET CURSOR ON
      @ 21,18 SAY "Codigo Do Material : " get procura picture "@!"
      read
      set cursor off
      @ 21,18 say "                                  "
      if empty (procura)
         return 1
      endif
      set filter to codmat=procura
      GOTO TOP
      @ 21,52 SAY "<F9>-Limpa O Filtro"
      RETURN 2
   ELSEIF TECLA=-9
      SET CURSOR ON
      @ 21,18 SAY "3 Letras Do Material : " get CMAT PICT "!"
      READ
      @ 21,18 SAY "                                 "
      IF EMPTY(CMAT)
         SET CURSOR OFF
         RETURN 1
      ENDIF
      SET FILTER TO MATERIAL=CMAT
      GOTO TOP
      @ 21,52 SAY "<F9>-Limpa O Filtro"
      SET CURSOR OFF
      return 2
   elseif TECLA=-8
      SET FILTER TO
      @ 21,52 SAY "                    "
      RETURN 2
   ELSEIF TECLA=27
      RETURN 0
   ENDIF
ELSEIF STATUS=3
   @ 4,30 SAY "Arquivo Vazio"
   inkey (.9)
   @ 4,30 SAY "             "
   return 1
ELSEIF STATUS=2
  @ 4,30 SAY "Final Do Arquivo"
  inkey(.9)
  @ 4,30 SAY "                "
  return 1
ELSEIF STATUS=1
  @ 4,30 SAY "Inicio Do Arquivo"
  inkey (.9)
  @ 4,30 SAY "                 "
  return 1
ELSEIF STATUS=0
  RETURN 1
ENDIF






