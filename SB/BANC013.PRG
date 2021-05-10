LOCAL li,contador
LOCAL soma1,soma2,soma3,soma4
LOCAL tota1,total2,total,total4
LOCAL geral1,geral2,geral3,geral4
 
save screen to B
vPula := 1
Pg := 0
vFab := vGrp := "   "
vEmp := Ord := " "
vBanco := vGond := "  "
dat   = date()
VDE   = DATE()
VDE   = INIMES(vDE)
VATE  = CTOD(SPACE(8))
cCor := setcolor(cCorPadra)
nApre := setcursor(1)
cop := 0
SOMBRA(08,03,13,55)
centracl(08,03,55,"Livro caixa")
@ 09,05 SAY 'Do dia  :             At‚ :                       '
@ 10,05 SAY 'Dias    :                                         '
@ 11,05 SAY 'Conta n§:                                         '
@ 12,05 SAY 'Saldo Anterior :                                  '
@ 09,15 GET VDE
@ 09,33 GET VATE
read
IF LASTKEY() = 27
   close ALL
   setcolor(cCor)
   setcursor(nApre)
   restore screen from b
   return
endif
cop = Vate - Vde
@ 10,15 say cop pict '999'
@ 11,15 get vbanco pict '99'
read
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCor)
   restore screen from b
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCor)
   restore screen from b
   close all
   return
endif
 
SELECT 3
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   quemtrava("BANCO")
   setcolor(cCor)
   restore screen from b
   close all
   return
endif
 
SELECT 4
IF NETUSE("CHEQUE",.F.,10)
   SET INDEX TO FLYch_D
ELSE
   QUEMTRAVA("CHEQUE")
   setcolor(cCor)
   restore screen from b
   close all
   return
endif
 
SELECT 5
IF NETUSE("credito",.F.,10)
   SET INDEX TO FLYcr_D
ELSE
   QUEMTRAVA("CREDITO")
   setcolor(cCor)
   restore screen from b
   close all
   return
endif
 
SELECT 6
IF NETUSE("debito",.F.,10)
   SET INDEX TO FLYde_D
ELSE
   QUEMTRAVA("DEBITO")
   setcolor(cCor)
   restore screen from b
   close all
   return
endif
 
SELECT 7
IF .not. NETUSE("MANUTE",.F.,10)
   QUEMTRAVA("MANUTE")
   setcolor(cCor)
   restore screen from b
   close all
   return
endif
 
SELECT BANCO
seek vbanco
if .not. found()
   mensagem("Banco n„o cadastrado ! favor Conferir...",cCorCaixa)
   close ALL
   setcolor(cCor)
   setcursor(nApre)
   restore screen from b
   return
endif
@ 10,25 SAY banco
@ 11,25 SAY "c/c : "+conta
VSALDO = 0
VSALDO = SALDO
@ 12,22 get Vsaldo Pict "9,999,999.99"
READ
va1 = banco
va2 = conta
va3 = VSaldo
IF .not. confirma("Confirma a Impress„o ?",cCorCaixa)
   close ALL
   setcolor(cCor)
   setcursor(nApre)
   restore screen from b
   return
ENDIF
 
*********************************************************************
SELECT CHEQUE
SET FILTER TO DATVEN >= VDE .AND. DATVEN <= VATE .AND. BANCO = VBANCO
GO TOP
 
*********************************************************************
SELECT CREDITO
SET FILTER TO DATVEN >= VDE .AND. DATVEN <= VATE .AND. BANCO = VBANCO
GO TOP
 
*********************************************************************
SELECT DEBITO
SET FILTER TO DATVEN >= VDE .AND. DATVEN <= VATE .AND. BANCO = VBANCO
GO TOP
 
*********************************************************************
SELECT  MANUTE
 
***************************************************************
 
mensagem("Verifique a Impressora!",cCorCaixa)
IF .NOT. isprinter()
   mensagem("A impressora nao pode estar pronta",cCorCaixa)
   restore screen from b
   setcursor(nApre)
   CLOSE ALL
   setcolor(cCor)
   RETURN
ENDIF
 
CENTRA(24,'Aguarde...! Imprimindo Arqu¡vo Solicitado')
 
VEMP1 = 'Tec Maq                                                     Livro Caixa                                               Data : '+DTOC(dat)
VEMP2 = 'Informnatica                                             Controle Bancario'
VEMP3 = ''
VEMP4 = 'Movimenta‡ao Anal¡tica da Conta Corrente n§ '+va2+'- '+va1
VEMP5 = 'Do dia : '+dtoc(vde)+' At‚ : '+dtoc(vate)
        *|    00   |    10   |    20   |    30   |   40    |    50   |    60   |    70   |    80   |    90   |    100  |    110  |    120  |
        *01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
        *00000000     000000000000000000000000000000     00000000     000     00000000000000000000     0000000000     0000000000     0000000000
VEMP6 = '--------------------------------------------------------------------------------------------------------------------------------------'
VEMP7 = 'DATA         HIST¢RICO                            N£MERO                                        CRDITOS        DBITOS          SALDO'
VEMP8 = '--------------------------------------------------------------------------------------------------------------------------------------'
 
SET DEVICE TO PRINT
 
set print on
?? chr(27)+chr(80)+CHR(15)
set print off
 
 
contador := 0
soma1    := soma2  := soma3  := soma4  := 0
tota1    := total2 := total  := total4 := 0
geral1   := geral2 := geral3 := geral4 := 0
 
LI = PROW() + 0
 
SELECT MANUTE
GO TOP
VDE1 = VDE
PG++
@ LI,00 SAY VEMP1
LI = LI + 1
@ LI,00 SAY VEMP2
@ LI,118 SAY "Pg.  : "+str(PG,3)
LI = LI + 1
@ LI,00 SAY VEMP3
LI = LI + 1
@ LI,00 SAY VEMP4
LI = LI + 1
@ LI,00 SAY VEMP5
LI = LI + 1
@ LI,00 SAY VEMP6
LI = LI + 1
@ LI,00 SAY VEMP7
LI = LI + 1
@ LI,00 SAY VEMP8
LI = LI + 1
@ li,00 say "SALDO ANTERIOR"
@ li,00 say "SALDO ANTERIOR"
@ LI,124 SAY STRPIC(VA3,10,2)
@ LI,124 SAY STRPIC(VA3,10,2)
LI = LI + 1
GERAL4 = VA3
do while contador < cop .and. .not. eof()
      IF LI > 59
         LI = 0
         PG = PG + 1
         @ LI,00 SAY VEMP1
         LI = LI + 1
         @ LI,00 SAY VEMP2
         @ LI,118 SAY "Pg.  : "+str(PG,3)
         LI = LI + 1
         @ LI,00 SAY VEMP3
         LI = LI + 1
         @ LI,00 SAY VEMP4
         LI = LI + 1
         @ LI,00 SAY VEMP5
         LI = LI + 1
         @ LI,00 SAY VEMP6
         LI = LI + 1
         @ LI,00 SAY VEMP7
         LI = LI + 1
         @ LI,00 SAY VEMP8
         LI = LI + 1
         @ li,00 say "SALDO ANTERIOR"
         @ li,00 say "SALDO ANTERIOR"
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         LI = LI + 1
      ENDIF
   contador = contador + 1
   ****************************CHEQUE EMITIDO
   SELECT CHEQUE
   SET ORDER TO 1
   GO TOP
   DO WHILE .NOT. EOF()
      IF LI > 59
         LI = 0
         PG = PG + 1
         @ LI,00 SAY VEMP1
         LI = LI + 1
         @ LI,00 SAY VEMP2
         @ LI,118 SAY "Pg.  : "+str(PG,3)
         LI = LI + 1
         @ LI,00 SAY VEMP3
         LI = LI + 1
         @ LI,00 SAY VEMP4
         LI = LI + 1
         @ LI,00 SAY VEMP5
         LI = LI + 1
         @ LI,00 SAY VEMP6
         LI = LI + 1
         @ LI,00 SAY VEMP7
         LI = LI + 1
         @ LI,00 SAY VEMP8
         LI = LI + 1
         @ li,00 say "SALDO ANTERIOR"
         @ li,00 say "SALDO ANTERIOR"
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         LI = LI + 1
      ENDIF
      IF DATVEN <> VDE
         SKIP
         LOOP
      ENDIF
      soma1 = soma1 + VALOR
      geral4 = geral4 - valor
 
      IF FOUND()
         VN = NOME
      ELSE
         VN = SPACE(20)
      ENDIF
 
      SELECT CHEQUE
      @ LI,00 SAY dtoc(datven)
      @ LI,13 SAY FORNECEDOR
      @ LI,48 SAY STR(NUMERO,8)
      @ LI,109 SAY STRPIC(VALOR,10,2)
      @ LI,124 SAY STRPIC(geral4,10,2)
      LI = LI+1
      SKIP
    ENDDO
 
 
   ****************************CREDITO
   SELECT CREDITO
   SET ORDER TO 1
   GO TOP
   DO WHILE .NOT. EOF()
      IF LI > 59
         LI = 0
         PG = PG + 1
         @ LI,00 SAY VEMP1
         LI = LI + 1
         @ LI,00 SAY VEMP2
         @ LI,118 SAY "Pg.  : "+str(PG,3)
         LI = LI + 1
         @ LI,00 SAY VEMP3
         LI = LI + 1
         @ LI,00 SAY VEMP4
         LI = LI + 1
         @ LI,00 SAY VEMP5
         LI = LI + 1
         @ LI,00 SAY VEMP6
         LI = LI + 1
         @ LI,00 SAY VEMP7
         LI = LI + 1
         @ LI,00 SAY VEMP8
         LI = LI + 1
         @ li,00 say "SALDO ANTERIOR"
         @ li,00 say "SALDO ANTERIOR"
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         LI = LI + 1
      ENDIF
      IF DATVEN <> VDE
         SKIP
         LOOP
      ENDIF
      soma2 = soma2 + VALOR
      geral4 = geral4 + valor
 
      @ LI,00 SAY dtoc(datven)
      @ LI,13 SAY FORNECEDOR
      @ LI,48 SAY STR(NUMERO,8)
      @ LI,94 SAY STRPIC(VALOR,10,2)
      @ LI,124 SAY STRPIC(geral4,10,2)
      LI = LI+1
      SKIP
    ENDDO
 
 
   ****************************DEBITO
   SELECT DEBITO
   SET ORDER TO 1
   GO TOP
   DO WHILE .NOT. EOF()
      IF LI > 59
         LI = 0
         PG = PG + 1
         @ LI,00 SAY VEMP1
         LI = LI + 1
         @ LI,00 SAY VEMP2
         @ LI,118 SAY "Pg.  : "+str(PG,3)
         LI = LI + 1
         @ LI,00 SAY VEMP3
         LI = LI + 1
         @ LI,00 SAY VEMP4
         LI = LI + 1
         @ LI,00 SAY VEMP5
         LI = LI + 1
         @ LI,00 SAY VEMP6
         LI = LI + 1
         @ LI,00 SAY VEMP7
         LI = LI + 1
         @ LI,00 SAY VEMP8
         LI = LI + 1
         @ li,00 say "SALDO ANTERIOR"
         @ li,00 say "SALDO ANTERIOR"
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         @ LI,124 SAY STRPIC(GERAL4,10,2)
         LI = LI + 1
      ENDIF
      IF DATVEN <> VDE
         SKIP
         LOOP
      ENDIF
      soma3 = soma3 + VALOR
      geral4 = geral4 - valor
      *|    00   |    10   |    20   |    30   |   40    |    50   |    60   |    70   |    80   |    90   |
      *012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
      *00000000  000000000000000000000000000000    00000000             0000000000 0000000000 0000000000        0000000000
      VN = 'DEBITO BANCARIO'
 
      @ LI,00 SAY dtoc(datven)
      @ LI,13 SAY FORNECEDOR
      @ LI,48 SAY STR(NUMERO,8)
      @ LI,69 SAY VN
      @ LI,109 SAY STRPIC(VALOR,10,2)
      @ LI,124 SAY STRPIC(geral4,10,2)
      LI = LI+1
      SKIP
    ENDDO
 
    vdia = cdow(vde1)
    if vdia    = 'Sunday'
        vdia = 'Domingo'
    elseif vdia = 'Monday'
        vdia = 'Segunda'
    elseif vdia = 'Tuesday'
        vdia = 'Terca  '
    elseif vdia = 'Wednesday'
        vdia = 'Quarta '
    elseif vdia = 'Thursday'
        vdia = 'Quinta '
    elseif vdia = 'Friday'
        vdia = 'Sexta  '
    elseif vdia = 'Saturday'
        vdia = 'Sabado '
    endif
    *|    00   |    10   |    20   |    30   |   40    |    50   |    60   |    70   |    80   |    90
    *0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
    *saldo do dia ¯¯> 00.00.00   - quarta                             0000000000 0000000000 0000000000
 
 
    soma4  = soma1 + soma3
    total1 = soma2 - soma4
 
    geral1 = geral1 + total1
    geral2 = geral2 + soma2
    geral3 = geral3 + soma4
    @ li,94  say "----------"
    @ li,109 say "----------"
    @ li,124 say "----------"
    li = li + 1
    @ li,00 say "Saldo do dia --> "+dtoc(vde1)+"  -  "+vdia
    @ li,00 say "Saldo do dia --> "+dtoc(vde1)+"  -  "+vdia
    @ li,00 say "Saldo do dia --> "+dtoc(vde1)+"  -  "+vdia
    @ li,94 say strpic(soma2,10,2)
    @ li,94 say strpic(soma2,10,2)
    @ li,109 say strpic(soma4,10,2)
    @ li,109 say strpic(soma4,10,2)
    @ LI,124 SAY STRPIC(geral4,10,2)
    @ LI,124 SAY STRPIC(geral4,10,2)
    li = li + 2
    store 0 to soma1,soma2,soma3,soma4,total1,total2,total3,total4
    vde  = vde  + 1
    vde1 = vde1 + 1
    SELECT MANUTE
    SKIP
enddo
IF LI > 59
   LI = 0
   PG = PG + 1
   @ LI,00 SAY VEMP1
   LI = LI + 1
   @ LI,00 SAY VEMP2
   @ LI,118 SAY "Pg.  : "+str(PG,3)
   LI = LI + 1
   @ LI,00 SAY VEMP3
   LI = LI + 1
   @ LI,00 SAY VEMP4
   LI = LI + 1
   @ LI,00 SAY VEMP5
   LI = LI + 1
   @ LI,00 SAY VEMP6
   LI = LI + 1
   @ LI,00 SAY VEMP7
   LI = LI + 1
   @ LI,00 SAY VEMP8
   LI = LI + 1
   @ li,00 say "SALDO ANTERIOR"
   @ li,00 say "SALDO ANTERIOR"
   @ LI,124 SAY STRPIC(GERAL4,10,2)
   @ LI,124 SAY STRPIC(GERAL4,10,2)
   LI = LI + 1
ENDIF
li = li + 1
@ li,00 say "PREVISŽO"
LI = LI + 1
@ li,00 say "ßßßßßßßß"
LI = LI + 1
@ LI,00 say "total de Cr‚ditos.........> "+strpic(geral2,15,2)
LI = LI + 1
@ LI,00 say "total de D‚bitos..........> "+strpic(geral3,15,2)
LI = LI + 1
@ LI,00 say "                            _______________"
LI = LI + 1
@ LI,00 say "total de Saldo............> "+strpic(geral4,15,2)
LI = LI + 3
set print on
?? chr(27)+chr(80)
set print off
EJECT
SET DEVICE TO SCREEN
setcolor(cCor)
setcursor(nApre)
restore screen from b
RETURN
