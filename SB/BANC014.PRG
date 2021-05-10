LOCAL GERAL,TOTDUP,TOTCPD,LI,CONTADOR,TOTCHQ
LOCAL TOTAL,TOTAL1,TOTAL2,TOTAL3,TOTAL4,TOTAL5,TOTAL6
LOCAL SOMA,SOMA1,SOMA2,SOMA3,SOMA4,SOMA5
 
SAVE SCREEN TO A
cop  := 0
VPULA := 1
Vde   := vDe1 := date()
cCor := setcolor(cCorPadra)
nApre := setcursor(1)
SOMBRA(15,13,19,66)
centracl(15,13,66,"Previs„o de Movimento")
@ 16,15 SAY 'Do dia  :                 qto. dias :             '
@ 17,15 SAY 'At‚     :                                         '
@ 18,15 SAY 'Pula    :       (Quantidade de Linhas)            '
@ 16,24 GET VDE
@ 16,53 GET cop pict '99' valid cop > 0
READ
VATE = VDE + COP
VDE1 = VDE
@ 17,24 SAY VATE
@ 18,25 GET VPULA PICT '9' VALID VPULA > 0
READ
IF LASTKEY() = 27
   restore screen from a
   setcursor(nApre)
   CLOSE ALL
   setcolor(cCor)
   RETURN
ENDIF
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCor)
   restore screen from A
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCor)
   restore screen from A
   close all
   return
endif
 
SELECT 3
IF NETUSE("CHEQUE",.F.,10)
   SET INDEX TO FLYch_D
ELSE
   QUEMTRAVA("CHEQUE")
   setcolor(cCor)
   restore screen from A
   close all
   return
endif
 
SELECT 4
IF NETUSE("duplicat",.F.,10)
   SET INDEX TO FLYdu_D
ELSE
   QUEMTRAVA("DUPLICAT")
   setcolor(cCor)
   restore screen from A
   close all
   return
endif
 
SELECT 5
IF NETUSE("predatad",.F.,10)
   SET INDEX TO FLYpr_D
ELSE
   QUEMTRAVA("PREDATAD")
   setcolor(cCor)
   restore screen from A
   close all
   return
endif
 
SELECT 6
IF .NOT. NETUSE("MANUTE",.F.,10)
   QUEMTRAVA("MANUTE")
   setcolor(cCor)
   restore screen from A
   close all
   return
endif
 
 
IF .not. confirma("Confirma a Impress„o ?",cCorCaixa)
   restore screen from a
   setcursor(nApre)
   CLOSE ALL
   setcolor(cCor)
   RETURN
ENDIF
mensagem("verifique a Impressora !",cCorcaixa)
IF .NOT. isprinter()
   mensagem("A impressora nao pode estar pronta",cCorCaixa)
   restore screen from A
   setcursor(nApre)
   CLOSE ALL
   setcolor(cCor)
   RETURN
ENDIF
**************************************
SELECT cheque
SET FILTER TO DATVEN >= VDE .AND. DATVEN <= VATE .AND. CANCELADA = ' '
GO TOP
 
**************************************
SELECT duplicat
SET FILTER TO DATVEN >= VDE .AND. DATVEN <= VATE .AND. CANCELADA = ' '
GO TOP
 
**************************************
SELECT predatad
SET FILTER TO DATVEN >= VDE .AND. DATVEN <= VATE .AND. CANCELADA = ' '
GO TOP
 
CENTRA(24,'Aguarde...! Imprimindo Arqu¡vo Solicitado')
VEMP1 = vdados1
VEMP2 = 'Relat¢rio balancete do dia : '+DTOC(VDE)
VEMP3 = 'DATA     DIA          CHEQ.P/RECEBER        CHEQ.EMITIDO           DUPLICATA               TOTAL               SALDO'
        *00000000        000000000000000 000000000000000 00000000000000 000000000000000 0000000000000000
        *|    00   |    10   |    20   |    30   |   40    |    50   |    60   |    70   |    80   |   90
        *012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
TRACO = REPLICATE('-',116)
TRACO1= REPLICATE('=',116)
SET DEVICE TO PRINT
SET CONSOLE OFF
set print on
?? chr(27)+chr(77)+CHR(15)
set print off
******************************DEFINICOES DAS VARIAVES
GERAL := TOTDUP := TOTDUP := TOTCPD := CONTADOR := TOTCHQ := 0
TOTAL := TOTAL1 := TOTAL2 := TOTAL3 := TOTAL4 := TOTAL5 := TOTAL6 := 0
SOMA  := SOMA1 := SOMA2 := SOMA3 := SOMA4 := SOMA5 := 0
 
LI = PROW() + 0
 
@ LI,00 SAY CHR(14)+VEMP1+CHR(20)
LI = LI+1
@ LI,00 SAY VEMP2
LI = LI+1
@ LI,00 SAY TRACO1
LI = LI + 1
@ LI,00 SAY VEMP3
@ LI,00 SAY VEMP3
LI = LI+1
@ LI,00 SAY TRACO
LI = LI+1
SELECT MANUTE
GO TOP
do while contador < cop .and. .not. eof()
   contador = contador + 1
   ****************************CHEQUE A RECEBER
   SELECT PREDATAD
   SET ORDER TO 1
   GO TOP
   DO WHILE .NOT. EOF()
      IF DATVEN <> VDE
         SKIP
         LOOP
      ENDIF
      TOTAL5 = TOTAL5 + VALOR
      TOTCPD = TOTCPD + VALOR
      SKIP
    ENDDO
   ***************************DUPLICATAS
   SELECT CHEQUE
   SET ORDER TO 1
   GO TOP
   DO WHILE .NOT. EOF()
      IF DATVEN <> VDE
         SKIP
         LOOP
      ENDIF
      TOTAL1 = TOTAL1 + VALOR
      TOTCHQ = TOTCHQ + VALOR
      SKIP
    ENDDO
   ****************************CHEQUE EMITIDOS
   SELECT DUPLICAT
   SET ORDER TO 1
   GO TOP
   DO WHILE .NOT. EOF()
      IF DATVEN <> VDE
         SKIP
         LOOP
      ENDIF
      TOTAL2 = TOTAL2 + VALOR
      TOTDUP = TOTDUP + VALOR
      SKIP
    ENDDO
 
   total = totcpd - totdup - totchq
   GERAL = GERAL + TOTAL
   vdia = cdow(vde1)
   if vdia    = 'Sunday'
       vdia = 'Domingo'
   elseif vdia = 'Monday'
       vdia = 'Segunda'
   elseif vdia = 'Tuesday'
       vdia = 'Ter‡a  '
   elseif vdia = 'Wednesday'
       vdia = 'Quarta '
   elseif vdia = 'Thursday'
       vdia = 'Quinta '
   elseif vdia = 'Friday'
       vdia = 'Sexta  '
   elseif vdia = 'Saturday'
       vdia = 'S bado '
   endif
 
   if vdia = 'Sabado'
      soma1 = soma1 + totcpd
      soma2 = soma2 + totchq
      soma3 = soma3 + totdup
      soma4 = soma4 + total
   endif
 
   if vdia = 'Domingo'
      soma1 = soma1 + totcpd
      soma2 = soma2 + totchq
      soma3 = soma3 + totdup
      soma4 = soma4 + total
   endif
 
   if vdia = 'Segunda'
      soma1 = soma1 + totcpd
      soma2 = soma2 + totchq
      soma3 = soma3 + totdup
      soma4 = soma4 + total
      vdia = 'Segunda'
      @ li,00 say dtoc(vde   )       +'|'+;
                  vdia               +'|'+;
                  strpic(soma1 ,19,2)+'|'+;
                  strpic(soma2 ,19,2)+'|'+;
                  strpic(soma3 ,19,2)+'|'+;
                  strpic(soma4 ,19,2)+'|'+;
                  strpic(GERAL ,19,2)
      @ li,00 say dtoc(vde   )       +'|'+;
                  vdia               +'|'+;
                  strpic(soma1 ,19,2)+'|'+;
                  strpic(soma2 ,19,2)+'|'+;
                  strpic(soma3 ,19,2)+'|'+;
                  strpic(soma4 ,19,2)+'|'+;
                  strpic(GERAL ,19,2)
      @ li,00 say dtoc(vde   )       +'|'+;
                  vdia               +'|'+;
                  strpic(soma1 ,19,2)+'|'+;
                  strpic(soma2 ,19,2)+'|'+;
                  strpic(soma3 ,19,2)+'|'+;
                  strpic(soma4 ,19,2)+'|'+;
                  strpic(GERAL ,19,2)
      LI = LI + 1
      STORE 0 TO soma1,soma2,soma3,soma4
   endif
 
   if vdia <> 'Sabado ' .and. vdia <> 'Domingo' .and. vdia <> 'Segunda'
      @ li,00 say dtoc(vde   )        +'|'+;
                  vdia                +'|'+;
                  strpic(totcpd ,19,2)+'|'+;
                  strpic(totchq ,19,2)+'|'+;
                  strpic(totdup ,19,2)+'|'+;
                  strpic(total  ,19,2)+'|'+;
                  strpic(geral  ,19,2)
      LI = LI + 1
   endif
   STORE 0 TO TOTchq
   STORE 0 TO TOTdup
   STORE 0 TO TOTcpd
   STORE 0 TO TOTal
   vde  = vde  + 1
   vde1 = vde1 + 1
   SELECT MANUTE
   SKIP
enddo
LI = LI + 1
TOTAL6 = TOTAL5 - TOTAL2 - TOTAL1
@ LI,00 SAY '                 ------------------- ------------------- ------------------- ------------------- -------------------'
LI = LI + 1
@ LI,00 SAY 'TOTAL ¯>         '+STRPIC(TOTAL5,19,2)+' '+STRPIC(TOTAL1,19,2)+' '+STRPIC(TOTAL2,19,2)+' '+STRPIC(TOTAL6,19,2)+' '+STRPIC(geral,19,2)
@ LI,00 SAY 'TOTAL ¯>         '+STRPIC(TOTAL5,19,2)+' '+STRPIC(TOTAL1,19,2)+' '+STRPIC(TOTAL2,19,2)+' '+STRPIC(TOTAL6,19,2)+' '+STRPIC(geral,19,2)
 
IF LI > 0
   EJECT
ENDIF
store 0 to contador
set print on
?? chr(27)+chr(80)+CHR(18)
set print off
SET DEVICE TO SCREEN
SET COnSOLE ON
setcolor(cCor)
setcursor(nApre)
CLOSE ALL
RESTORE SCREEN FROM A
RETURN
