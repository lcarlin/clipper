LOCAL TOTCHQ,CONTADOR3,LI,geral,TOTBAI1,TOTBAI2,SALDO1,SALDO2
save screen to B
nApre := setcursor(1)
cCor := setcolor(cCorPadra)
Vpula := 1
Vbanco  := "  "
DE   = DATE()
DE   = INIMES(DE)
ATE  = CTOD(SPACE(8))
SOMBRA(08,03,13,55)
CENTRACL(08,03,55,"Relat¢rio de cheques")
@ 09,05 SAY 'Do dia  :             At‚ :                       '
@ 10,05 SAY 'Banco   :                                         '
@ 12,05 SAY 'Pula    :       (Quantidade de Linhas)            '
@ 09,15 GET DE
@ 09,33 GET ATE
@ 10,15 GET VBANCO pict '99'
@ 12,15 GET VPULA PICT '9' VALID VPULA > 0
READ
var1 = 1
SOMBRA(16,05,20,26)
CENTRACL(16,05,26,"Menu")
aOpcRl := {{17,06," Cheque Emitido "},;
           {19,06," Cheque a Pagar "}}
@ 16,06 say "Op‡”es de Impress„o"
var1 := botao(aOpcRl,,cCorBin,cCorbat)
IF .NOT. confirma("Confirma a Impress„o ?",cCorCaixa)
   restore screen from b
   setCURSOR(nApre)
   setcolor(cCor)
   CLOSE ALL
   RETURN
ENDIF
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCorAnt)
   restore screen from B
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCorAnt)
   restore screen from B
   close all
   return
endif
 
SELECT 3
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   QUEMTRAVA("BANCO")
   setcolor(cCorAnt)
   restore screen from B
   close all
   return
endif
 
SELECT 4
IF NETUSE("CHEQUE",.F.,10)
   SET INDEX TO FLYch_C,FLYch_D
ELSE
   QUEMTRAVA("CHEQUE")
   setcolor(cCorAnt)
   restore screen from B
   close all
   return
endif
 
SELECT BANCO
seek vbanco
if .not. found()
   mensagemT("Banco n„o Cadastrado. Conferir...")
   close ALL
   setcolor(cCor)
   setcursor(nApre)
   restore screen from b
   return
ENDIF
@ 10,19 SAY banco
@ 11,19 SAY "C/C : "+conta
va1 = banco
va2 = conta
mensagem("Verifique a Impressora !!",cCorcaixa)
IF .NOT. isprinter()
   mensagemt("A impressora N„o pode estar pronta")
   close all
   setCURSOR(nApre)
   setcolor(cCor)
   RETURN
endif
CENTRA(24,'Aguarde...! Imprimindo Arqu¡vo Solicitado',"r*/n")
SET DEVICE TO PRINTER
SET CONSOLE OFF
set print on
?? chr(27)+chr(80)+chr(15)
set print off
if var1 = 1
   SELECT cheque
   set order to 1
   SET FILTER TO DATA >= DE .AND. DATA <= ATE .AND. BANCO = VBANCO
   GO TOP
   VEMP  = vdados1
   VEMP1 = 'Copia de Cheque do Banco > '+va1+'  c/c n§ '+va2
   VEMP3 = 'Movimenta‡„o do dia : '+DTOC(DE)+'                               At‚ : '+DTOC(ATE)
   TRACO =  REPLICATE('-',131)
   TRACO1=  REPLICATE('=',131)
   CAB1  = 'N£mero      Hist¢rico                                       Valor    Emiss„o     Venc.                     Saldo'
   TOTCHQ   := 0
   CONTADOR3:= 0
   geral    := 0
   TOTBAI1  := 0
   TOTBAI2  := 0
   SALDO1   := 0
   SALDO2   := 0
   OPC      := space(8)
   CONTADOR3 = CONTADOR3 + 1
   LI = PROW() + 0
   DO WHILE data <= ate .and. .NOT. EOF()
      go top
      IF LI > 58
         LI = LI + 3
         @ LI,00 SAY "P gina n. "+STR(contador3,3)
         @ LI,00 SAY "P gina n. "+STR(contador3,3)
         @ LI,00 SAY "P gina n. "+STR(contador3,3)
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
 
         IF banco <> vbanco
            SKIP
            LOOP
         ENDIF
 
 
         if data <> de
            skip
            loop
         endif
 
         IF cancelada = "C"
                 A  = "Pado dia"
            TOTBAI1 = TOTBAI1 + VALOR
            TOTBAI2 = TOTBAI2 + VALOR
         ELSE
            A = "        "
         ENDIF
 
         TOTCHQ = TOTCHQ + VALOR
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
 
         @ LI,00 SAY STRPIC(NUMERO,8)+'    '+FORNECEDOR+'    '+STRPIC(VALOR,19,2)+'    '+DTOC(DATA)+'    '+DTOC(DATVEN)+' '+A+' '+DTOC(DATBAIX)+'     '+STRPIC(TOTCHQ,19,2)
         LI = LI+1
         SKIP
      enddo
 
      if totchq > 0
         SALDO1 = TOTCHQ - TOTBAI1
         LI = LI + 1
         @ li,00 say vdia+' - TOTAL R$ '+strpic(totchq,15,2)+' - T.pago CR$'+STRPIC(TOTBAI1,15,2)+' - Saldo CR$'+STRPIC(SALDO1,15,2)
         @ li,00 say vdia+' - TOTAL R$ '+strpic(totchq,15,2)+' - T.pago CR$'+STRPIC(TOTBAI1,15,2)+' - Saldo CR$'+STRPIC(SALDO1,15,2)
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
   @ LI,00  SAY 'Total geral de cheques emitidos'
   @ LI,00  SAY 'Total geral de cheques emitidos'
   @ LI,108 SAY 'R$  '+STRPIC(geral,19,2)
   @ LI,108 SAY 'R$  '+STRPIC(geral,19,2)
   LI = LI + 1
   @ LI,00  SAY 'Total geral de cheques pagos'
   @ LI,00  SAY 'Total geral de cheques pagos'
   @ LI,108 SAY 'R$  '+STRPIC(TOTBAI2,19,2)
   @ LI,108 SAY 'R$  '+STRPIC(TOTBAI2,19,2)
   LI = LI + 1
   @ LI,108 SAY '_______________________'
   LI = LI + 1
   @ LI,00  SAY 'Saldo'
   @ LI,00  SAY 'Saldo'
   @ LI,108 SAY 'R$  '+STRPIC(SALDO2,19,2)
   @ LI,108 SAY 'R$  '+STRPIC(SALDO2,19,2)
   LI = 58
   LI = LI + 3
   @ LI,00 SAY "P gina n. "+STR(contador3,3)
   @ LI,00 SAY "P gina n. "+STR(contador3,3)
   @ LI,00 SAY "P gina n. "+STR(contador3,3)
elseif var1 = 2
   SELECT cheque
   set order to 2
   SET FILTER TO DATVEN >= DE .AND. DATVEN <= ATE .AND. BANCO = VBANCO
   GO TOP
   VEMP  = vdados1
   VEMP1 = 'Relat¢rio de Cheques Emitidos Pr‚-datados do banco > '+va1+'  c/c n§ '+va2
   VEMP3 = 'Movimenta‡„o do dia : '+DTOC(DE)+'                               At‚ : '+DTOC(ATE)
   TRACO =  REPLICATE('-',131)
   TRACO1=  REPLICATE('=',131)
   CAB1  = 'N£mero      Hist¢rico                                       Valor    Emiss„o     Venc.                     Saldo'
 
   TOTCHQ   := 0
   CONTADOR3:= 0
   geral    := 0
   TOTBAI1  := 0
   TOTBAI2  := 0
   SALDO1   := 0
   SALDO2   := 0
   OPC      := space(8)
   CONTADOR3 = CONTADOR3 + 1
   LI = PROW() + 0
 
   DO WHILE datven <= ate .and. .NOT. EOF()
      go top
      IF LI > 58
         LI = LI + 3
         @ LI,00 SAY "P gina n. "+STR(contador3,3)
         @ LI,00 SAY "P gina n. "+STR(contador3,3)
         @ LI,00 SAY "P gina n. "+STR(contador3,3)
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
 
         IF banco <> vbanco
            SKIP
            LOOP
         ENDIF
 
 
         if datven <> de
            skip
            loop
         endif
 
         IF cancelada = "C"
                 A  = "Pado dia"
            TOTBAI1 = TOTBAI1 + VALOR
            TOTBAI2 = TOTBAI2 + VALOR
         ELSE
            A = "        "
         ENDIF
 
         TOTCHQ = TOTCHQ + VALOR
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
 
         @ LI,00 SAY STRPIC(NUMERO,8)+'    '+FORNECEDOR+'    '+STRPIC(VALOR,19,2)+'    '+DTOC(DATA)+'    '+DTOC(DATVEN)+' '+A+' '+DTOC(DATBAIX)+'     '+STRPIC(TOTCHQ,19,2)
         LI = LI+1
         SKIP
      enddo
 
      if totchq > 0
         SALDO1 = TOTCHQ - TOTBAI1
         LI = LI + 1
         @ li,00 say vdia+' - TOTAL R$ '+strpic(totchq,15,2)+' - T.pago CR$'+STRPIC(TOTBAI1,15,2)+' - Saldo CR$'+STRPIC(SALDO1,15,2)
         @ li,00 say vdia+' - TOTAL R$ '+strpic(totchq,15,2)+' - T.pago CR$'+STRPIC(TOTBAI1,15,2)+' - Saldo CR$'+STRPIC(SALDO1,15,2)
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
   @ LI,00  SAY 'Total geral de cheques emitidos'
   @ LI,00  SAY 'Total geral de cheques emitidos'
   @ LI,108 SAY 'R$  '+STRPIC(geral,19,2)
   @ LI,108 SAY 'R$  '+STRPIC(geral,19,2)
   LI = LI + 1
   @ LI,00  SAY 'Total geral de cheques pagos'
   @ LI,00  SAY 'Total geral de cheques pagos'
   @ LI,108 SAY 'R$  '+STRPIC(TOTBAI2,19,2)
   @ LI,108 SAY 'R$  '+STRPIC(TOTBAI2,19,2)
   LI = LI + 1
   @ LI,108 SAY '_______________________'
   LI = LI + 1
   @ LI,00  SAY 'Saldo'
   @ LI,00  SAY 'Saldo'
   @ LI,108 SAY 'R$  '+STRPIC(SALDO2,19,2)
   @ LI,108 SAY 'R$  '+STRPIC(SALDO2,19,2)
   LI = 58
   LI = LI + 3
   @ LI,00 SAY "P gina n. "+STR(contador3,3)
   @ LI,00 SAY "P gina n. "+STR(contador3,3)
   @ LI,00 SAY "P gina n. "+STR(contador3,3)
endif
set print on
?? chr(27)+chr(18)+chr(80)
set print off
EJECT
SET DEVICE TO SCREEN
SETCURSOR(nApre)
setcolor(cCor)
CLOSE ALL
RESTORE SCREEN FROM b
RETURN
