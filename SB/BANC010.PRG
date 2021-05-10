LOCAL TOTCHQ,LI,geral,TOTBAI1,TOTBAI2,SALDO1,SALDO2,AA
LOCAL opc,CONTADOR3
 
save screen to B
 
VPULA  := 0
VEMP   := ORD := " "
VGRP   := "   "
VGOND  := "  "
Vbanco := "  "
VFAB   := "   "
DE   := DATE()
DE   := INIMES(DE)
ATE  := CTOD("  /  /  ")
cCor := setcolor(cCorPadra)
nApre:= setcursor(1)
SOMBRA(08,03,13,55)
centracl(08,03,55,"Relat¢rio de duplicatas")
@ 09,05 SAY 'Do dia  :             At‚ :                       '
@ 12,05 SAY 'Pula    :       (Quantidade de Linhas)            '
@ 09,15 GET DE
@ 09,33 GET ATE
@ 12,15 GET VPULA PICT '9' VALID VPULA > 0
READ
 
IF lastkey() = 27
   restore screen from b
   setcursor(nApre)
   setCOLOR(cCor)
   CLOSE ALL
   RETURN
ENDIF
 
IF .NOT. confirma("Confirma a Impress„o dos dados ?",cCorCaixa)
   restore screen from b
   setcursor(nApre)
   setCOLOR(cCor)
   CLOSE ALL
   RETURN
ENDIF
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCor)
   restore screen from B
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCor)
   restore screen from B
   close all
   return
endif
 
SELECT 3
IF NETUSE("duplicat",.F.,10)
   SET INDEX TO FLYdu_D
ELSE
   QUEMTRAVA("DUPLICAT")
   setcolor(cCor)
   restore screen from B
   close all
   return
endif
 
SELECT DUPLICAT
SET ORDER TO 1
SET FILTER TO DATVEN >= DE .AND. DATVEN <= ATE
GO TOP
mensagem("Verifique a Impressora !",cCorCaixa)
IF .NOT. isprinter()
   mensagem("A impressora nao pode estar pronta !",cCorCaixa)
   restore screen from b
   setcursor(nApre)
   CLOSE ALL
   setCOLOR(cCor)
   RETURN
ENDIF
 
CENTRA(23,'Aguarde... Imprimindo dados solicitado',"r*/n")
VEMP  = vdados1
VEMP1 = 'Relatorio de duplicatas'
VEMP3 = 'Movimenta‡„o do dia : '+DTOC(DE)+'                               At‚ : '+DTOC(ATE)
TRACO =  REPLICATE('-',131)
TRACO1=  REPLICATE('=',131)
CAB1  = 'N£mero      Fornecedor                                      Valor    Emiss„o     Vencim.                   SALDO'
SET DEVICE TO PRINT
SET CONSOLE OFF
set print on
?? chr(27)+chr(80)+chr(15)
set print off
 
TOTCHQ    := 0
CONTADOR3 := 0
geral     := 0
TOTBAI1   := 0
TOTBAI2   := 0
SALDO1    := 0
SALDO2    := 0
AA        := 0
OPC       := space(8)
 
CONTADOR3 = CONTADOR3 + 1
 
LI = PROW() + 0
 
 
DO WHILE datven <= ate .and. .NOT. EOF()
 
   SELECT DUPLICAT
   go top
   IF LI > 58
      LI = LI + 3
      @ LI,00 SAY "Pagina n. "+STR(contador3,3)
      @ LI,00 SAY "Pagina n. "+STR(contador3,3)
      @ LI,00 SAY "Pagina n. "+STR(contador3,3)
      CONTADOR3 = CONTADOR3 + 1
      LI = 0
   ENDIF
 
   IF LI = 0
      @ LI,00 SAY CHR(14)+VEMP+CHR(20)
      LI = LI+1
      @ LI,00 SAY TRACO1
      LI = LI+1
      @ LI,00 SAY VEMP1
      LI = LI+1
      @ LI,00 SAY VEMP3
      LI = LI+1
      @ LI,00 SAY TRACO
      LI = LI+1
      @ LI,00 SAY CAB1
      LI = LI+1
      @ LI,00 SAY TRACO
      LI = LI+1
   ENDIF
 
   do while .not. eof()
 
      if datven <> de
         skip
         loop
      endif
 
      IF cancelada = "C"
              A  = "Pago dia"
         TOTBAI1 = TOTBAI1 + VALOR
         TOTBAI2 = TOTBAI2 + VALOR
      ELSE
         A = "        "
      ENDIF
 
      TOTCHQ = TOTCHQ + VALOR
      AA     = AA     + VALOR
      geral   = geral  + VALOR
      vdia = cdow(de)
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
 
 
      @ LI,00 SAY NUMERO+'    '+FORNECEDOR+'    '+STRPIC(VALOR,19,2)+'    '+DTOC(DATA)+'    '+DTOC(DATVEN)+' '+A+' '+DTOC(DATBAIX)+'     '+STRPIC(AA,19,2)
      LI = LI+1
      SKIP
   enddo
 
   if totchq > 0
      SALDO1 = TOTCHQ - TOTBAI1
      LI = LI + 1
      @ li,00 say vdia+' - Total CR$'+strpic(totchq,15,2)+' - T.Pago CR$'+STRPIC(TOTBAI1,15,2)+' - Saldo CR$'+STRPIC(SALDO1,15,2)
      @ li,00 say vdia+' - Total CR$'+strpic(totchq,15,2)+' - T.Pago CR$'+STRPIC(TOTBAI1,15,2)+' - Saldo CR$'+STRPIC(SALDO1,15,2)
      li = li + 2
   else
      @ li,00 say space(116)
   endif
   store 0 to totchq,TOTBAI1,SALDO1
   skip
   de = de + 1
   go top
 
ENDDO
 
LI = LI + 2
 
SALDO2 = GERAL - TOTBAI2
@ LI,00  SAY 'Total geral de duplicatas'
@ LI,00  SAY 'Total geral de duplicatas'
@ LI,108 SAY 'Cr$ '+STRPIC(geral,19,2)
@ LI,108 SAY 'Cr$ '+STRPIC(geral,19,2)
LI = LI + 1
@ LI,00  SAY 'Total geral de duplicatas pagas'
@ LI,00  SAY 'Total geral de duplicatas pagas'
@ LI,108 SAY 'Cr$ '+STRPIC(TOTBAI2,19,2)
@ LI,108 SAY 'Cr$ '+STRPIC(TOTBAI2,19,2)
LI = LI + 1
@ LI,108 SAY '_______________________'
LI = LI + 1
@ LI,00  SAY 'Saldo'
@ LI,00  SAY 'Saldo'
@ LI,108 SAY 'Cr$ '+STRPIC(SALDO2,19,2)
@ LI,108 SAY 'Cr$ '+STRPIC(SALDO2,19,2)
LI = 58
LI = LI + 3
@ LI,00 SAY "Pagina n. "+STR(contador3,3)
@ LI,00 SAY "Pagina n. "+STR(contador3,3)
@ LI,00 SAY "Pagina n. "+STR(contador3,3)
set print on
?? chr(27)+chr(18)+chr(80)
set print off
EJECT
SET DEVICE TO SCREEN
setcursor(nApre)
setcolor(cCor)
SET CONSOLE OFF
CLOSE ALL
RESTORE SCREEN FROM b
RETURN
