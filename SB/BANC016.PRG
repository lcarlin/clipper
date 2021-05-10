LOCAL total1,total2,Total3,total4,total5,total6,total7,total8
LOCAL total9,total10,total11,total12,total13,total14,total15,total16
LOCAL total17
 
nApre := setcursor(1)
cCor := setcolor(cCorPadra)
SAVE SCREEN TO REA
Vbanco := "  "
Vate   := date()
SOMBRA(03,03,08,55)
centracl(03,03,55,"Saldo Banc rio")
@ 04,05 SAY 'Digite o Banco Desejado :     At‚ o Dia :         '
@ 06,05 SAY 'Saldo Banc rio do  >                              '
@ 07,05 SAY 'Conta corrente n§  >                              '
@ 10,02 SAY 'ÚÄSaldosÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄRealÄÄÄÄÄÄÄÄÄÄÄBanc rioÄÄ¿'
SOMBRA(11,02,20,61)
@ 12,04 SAY 'Saldo Anterior   >                                       '
@ 13,04 SAY 'Cr‚ditos         >                                       '
@ 14,04 SAY 'Dep¢sito         >                                       '
@ 15,04 SAY 'Cheques Emitidos >                                       '
@ 16,04 SAY 'D‚bitos          >                                       '
@ 17,04 SAY '                  __________________  __________________ '
@ 18,04 SAY 'Saldo            >                                       '
@ 19,04 SAY 'Conf./Aplicacao  >                                       '
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCorAnt)
   restore screen from REA
   CLOSE ALL
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCorAnt)
   restore screen from REA
   close all
   return
endif
 
 
SELECT 3
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   QUEMTRAVA("BANCO")
   setcolor(cCorAnt)
   restore screen from REA
   close all
   return
endif
 
SELECT 4
IF NETUSE("credito",.F.,10)
   SET INDEX TO FLYcr_d,FLYcr_F
ELSE
   quemtrava("CREDITO")
   setcolor(cCorAnt)
   restore screen from REA
   close all
   return
endif
 
SELECT 5
IF NETUSE("CHEQUE",.F.,10)
   SET INDEX TO flych_d,FLYch_f
ELSE
   QUEMTRAVA("CHEQUE")
   setcolor(cCorAnt)
   restore screen from REA
   close all
   return
endif
 
SELECT 6
IF NETUSE("debito",.F.,10)
   SET INDEX TO flyde_d,FLYde_f
ELSE
   quemtrava("DEBITO")
   setcolor(cCorAnt)
   restore screen from REA
   close all
   return
endif
 
SELECT 7
IF NETUSE("deposit",.F.,10)
   SET INDEX TO flydt_d,FLYdt_f
ELSE
   quemtrava("DEPOSIT")
   setcolor(cCorAnt)
   restore screen from REA
   close all
   return
endif
 
 
@ 04,31 GET vbanco
@ 04,47 GET vate
READ
setcursor(nApre)
select banco
set order to 1
seek vbanco
if .not. found()
   mensagem( "Banco n„o Cadastrado. Conferir",cCorCaixa)
   close ALL
   restore screen from REA
   setcolor(cCor)
   return
else
   @ 06,26 SAY banco
   @ 07,26 SAY conta
   @ 12,24 SAY saldo PICT '99,999,999,999.99'
   @ 19,44 SAY total PICT '99,999,999,999.99'
   VSALDO = SALDO
endif
 
CENTRA(24,'Aguarde...! Processando Arqu¡vo...',"r*/n")
total1 := total2 :=total3 :=total4 :=total5 :=total6 :=total7 :=total8 :=0
total9 := total10:=total11:=total12:=total13:=total14:=total15:=total16:=0
total17 :=0
***********************************************************
SELECT credito
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAl1 for BANCO = VBANCO .AND. DATVEN <= VATE
@ 13,24 SAY TOTAL1 PICT '99,999,999,999.99'
 
************************************************************
SELECT deposit
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAl15 for BANCO = VBANCO .AND. DATVEN <= VATE
@ 14,24 SAY TOTAL15 PICT '99,999,999,999.99'
************************************************************
SELECT cheque
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAl2 for BANCO = VBANCO .AND. DATVEN <= VATE
@ 15,24 SAY TOTAL2 PICT '99,999,999,999.99'
*************************************************************
SELECT debito
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAl3 for BANCO = VBANCO .AND. DATVEN <= VATE
@ 16,24 SAY TOTAL3 PICT '99,999,999,999.99'
***********************************************************
total4 = vsaldo + total1 + total15 - total2 - total3
@ 18,24 SAY TOTAL4 PICT '99,999,999,999.99'
***********************************************************
 
SELECT credito
SET ORDER TO 2
GO TOP
SUM VALOR TO TOTAL5 FOR BANCO = VBANCO .AND. DATbaix <= VATE .AND. CANCELADA = 'C'
@ 13,44 SAY TOTAL5 PICT '99,999,999,999.99'
 
*************************************************************
SELECT deposit
SET ORDER TO 2
GO TOP
SUM VALOR TO TOTAL16 FOR BANCO = VBANCO .AND. DATbaix <= VATE .AND. CANCELADA = 'C'
@ 14,44 SAY TOTAL16 PICT '99,999,999,999.99'
 
*************************************************************
SELECT cheque
SET ORDER TO 2
GO TOP
SUM VALOR TO TOTAL6 FOR BANCO = VBANCO .AND. DATbaix <= VATE .AND. CANCELADA = 'C'
@ 15,44 SAY TOTAL6 PICT '99,999,999,999.99'
 
***************************************************************
SELECT debito
SET ORDER TO 2
GO TOP
SUM VALOR TO TOTAL7 FOR BANCO = VBANCO .AND. DATbaix <= VATE .AND. CANCELADA = 'C'
@ 16,44 SAY TOTAL7 PICT '99,999,999,999.99'
SKIP
*****************************************************
total8 = vsaldo + total5 + total16 - total6 - total7
@ 18,44 SAY TOTAL8 PICT '99,999,999,999.99'
****************************************************
SELECT credito
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAL9 FOR BANCO = VBANCO .AND. DATVEN <= VATE .AND. CANCELADA = ' '
*****************************************************
SELECT deposit
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAL9 FOR BANCO = VBANCO .AND. DATVEN <= VATE .AND. CANCELADA = ' '
***************************
SELECT cheque
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAL10 FOR BANCO = VBANCO .AND. DATVEN <= VATE .AND. CANCELADA = ' '
*****************************************************
SELECT debito
SET ORDER TO 1
GO TOP
SUM VALOR TO TOTAL11 FOR BANCO = VBANCO .AND. DATVEN <= VATE .AND. CANCELADA = ' '
total12 = vsaldo + total9 + total17 - total10 - total11
total13 = total4 - total12
@ 19,24 SAY TOTAL13 PICT '99,999,999,999.99'
CENTRA(24,'Fim de Opera‡„o! Pressione Qualque Tecla...')
inkey(0)
SETCOLOR(CcOR)
SETCURSOR(nApre)
CLOSE ALL
SETCURSOR(nApre)
restore screen from REA
RETURN
