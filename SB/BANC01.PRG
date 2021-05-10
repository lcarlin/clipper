SAVE SCREEN to CHEQUE
 
set inte off
declare CAMPOS[11],CABEC[11],TITULO,CHAVE[11],ORDEM
 
ordem      = 1
 
SELECT 1
IF NETUSE("credito",.F.,10)
   SET INDEX TO FLYCR_A,FLYcr_B,FLYcr_C,FLYcr_D,FLYcr_E,FLYCR_F
ELSE
   DO Mensagem WITH "O arqu¡vo de cr‚ditos n„o se encontra dispon¡vel !"
   INKEY(0)
   set inte on
   restore screen from cheque
   return
endif
 
 
SELECT 2
IF NETUSE("FORNECED",.F.,10)
   SET INDEX TO FORN_A
ELSE
   DO Mensagem WITH "O arqu¡vo de fornecedor n„o se encontra dispon¡vel !"
   INKEY(0)
   set inte on
   restore screen from cheque
   return
endif
 
SELECT 3
IF NETUSE("banco",.F.,10)
   SET INDEX TO FLAYGR_A
ELSE
   DO Mensagem WITH "O arqu¡vo banc rio n„o se encontra dispon¡vel !"
   INKEY(0)
   set inte on
   restore screen from cheque
   return
endif
 
select 6
if netuse("semafaro",.f.,10)
   set index to semafaro
else
   DO Mensagem WITH "O arquivo de dados n„o se encontra dispon¡vel !"
   inkey(0)
   set inte on
   restore screen from cheque
   return
endif
 
SOMBRA2(10,10,14,53)
QUADRO(10,10,14,53,7,opcaofrente+"/"+opcaofundo,"Dados do arqu¡vo",.T.)
v_banco = space(2)
setcolor(opcaofrente+"/"+opcaofundo)
@ 11,12 say    "C¢digo..> " get v_banco pict "@!"
setcolor("")
read
set cursor off
select BANCO
set order to 1
seek v_banco
if .not. found()
   DO LMEN
   setcolor(mesafrente+"/"+mesafundo)
   @ 23,01 SAY "Banco n„o Cadastrado. Favor Conferir..."
   setcolor("")
   set inte on
   inkey(0)
   close database
   restore screen from cheque
   return
else
   setcolor(opcaofrente+"/"+opcaofundo)
   @ 12,12 say "Banco...> "+banco
   @ 13,12 SAY "C/C.....> "+conta
   vbanco = banco
   vconta = conta
   do lmen
   setcolor("")
   DO mensagem WITH "Pressione Qualquer Tecla p/ Continuar."
   inkey(0)
endif
SELECT credito
SET ORDER TO 2
SET FILTER TO banco = v_banco
GO TOP
 
CAMPOS[ 1]  = "NUMERO"
CAMPOS[ 2]  = "VALOR"
CAMPOS[ 3]  = "FORNECEDOR"
CAMPOS[ 4]  = "DATA"
CAMPOS[ 5]  = "DATVEN"
CAMPOS[ 6]  = "CANCELADA"
 
CABEC[ 1] = "N£mero"
CABEC[ 2] = "Valor"
CABEC[ 3] = "Hist¢rico"
CABEC[ 4] = "Data"
CABEC[ 5] = "Vencimento"
CABEC[ 6] = "Baixa"
 
CHAVE[1] = "Ordem"
CHAVE[2] = "Hist¢rico"
CHAVE[3] = "Data"
CHAVE[4] = "Vencimento"
CHAVE[5] = "N£mero"
CHAVE[6] = "Baixa"
 
GOTO TOP
 
L1 =  2
C1 =  0
L2 = 21
C2 = 79
 
TITULO1 = "Dados"
TITULO2 = "Mensagens"
TITULO3 = "CRDITOS EMITIDOS DO BANCO.> "+vBANCO+" C/C N§.> "+vCONTA
 
setcolor("")
centrav(00,titulo3)
JANELA(L1,C1,L2,C2,TITULO1,,telafrente+"/"+telafundo,.F.)
setcolor(telafrente+"/"+telafundo)
MOLDURA(22,00,24,79,titulo2,.t.,.t.)
setcolor(telafrente+"/"+telafundo)
DBEDIT(L1+1,C1+1,L2-1,C2-1,CAMPOS,"MTcre_EDIT","",CABEC,"ÍÑÍ"," ³ ")
FUNCTION MTcre_EDIT(MODO,ELEMENTO)
Tecla = LASTKEY()
CAMPO = CAMPOS[elemento]
retorna = 1
 
do case
 
case modo = 0 // nenhuma tecla pressionada
 
     IF .NOT. EMPTY(CHAVE[1])
         setcolor(opcaofrente+"/"+opcaofundo)
         @ 01,00 clear to 01,79
         centrav(01,"Classificados por " + CHAVE[INDEXORD()])
         setcolor("")
     ENDIF
     do lmen
     setcolor(mesafrente+"/"+mesafundo)
     centrav(23,"Pressione [ALT+H] Para Ajuda")
     IF CANCELADA = "C"
        setcolor(mesafrente+"/"+mesafundo)
        @ 23,72 say 'Baixado'
        setcolor("")
     else
        setcolor(mesafrente+"/"+mesafundo)
        @ 23,72 say '       '
        setcolor("")
     endif
 
case modo == 1 // rola uma tela para cima
 
     do lmen
     setcolor(mesafrente+"/"+mesafundo)
     tone( 100,3 )
     @ 23,01 say "In¡cio do Arquivo!"
     setcolor("")
 
case modo == 2 // rola uma tela para baixo
 
     do lmen
     setcolor(mesafrente+"/"+mesafundo)
     tone( 100,3 )
     @ 23,01 say "Fim de Arquivo!"
     setcolor("")
 
case tecla == 27  // retorna ao menu
 
     restore screen from CHEQUE
     tone( 100,3 )
     close databases
     set key 28 to
     set inte on
     retorna = 0
 
case tecla == 98  // baixa cheque
 
     IF RECLOCK(5)
        SAVE SCREEN TO WER
        SET CURSOR ON
        V_VALOR = 0
        V_DATVEN= DATE()
 
        A       = 0
        B       = DATE()
 
        V_VALOR = VALOR
        V_DATVEN= DATVEN
 
        V_NUMERO     = 0
        V_FORNECEDOR = SPACE(30)
        V_DATA       = DATE()
 
        V_ORDEM      = ORDEM
        V_NUMERO     = NUMERO
        V_FORNECEDOR = FORNECEDOR
        V_DATA       = DATA
        V_BANCO      = BANCO
        v_cancelada  = cancelada
 
        if v_cancelada = "C"
           do lmen
           do biip
           DO Mensagem WITH "Cr‚dito j  Baixado! Verifique."
           INKEY(0)
        endif
        set inte off
        QUADRO(10,04,13,20,7,opcaofrente+"/"+opcaofundo,"Dados",.T.)
        setcolor(opcaofrente+"/"+opcaofundo)
        @ 11,05 GET A PICT '9999,999,999.99' VALID A > 0
        @ 12,12 GET B
        setcolor("")
        READ
        set inte on
        QUADRO(15,04,20,56,7,opcaofrente+"/"+opcaofundo,"Dados",.T.)
        IF V_VALOR = A
           setcolor(mesafrente+"/"+mesafundo)
           @ 16,05 say 'Valor Correto...                            '
           SETCOLOR("")
        ELSE
           setcolor(mesafrente+"/"+mesafundo)
           DO BIIP
           @ 16,05 say 'Valor incorreto! Deseja retificar o valor. (S/N)'
           INKEY(0)
           SETCOLOR("")
           IF LASTKEY() = 83 .OR. LASTKEY() = 115
              REPLACE VALOR WITH A
              setcolor(mesafrente+"/"+mesafundo)
              @ 17,05 say "ok... Valor retificado! Pressione uma tecla."
              setcolor("")
              INKEY(0)
           ELSE
              setcolor(mesafrente+"/"+mesafundo)
              @ 17,05 say "ok... Valor n„o retificado! Pressione uma tecla."
              setcolor("")
              INKEY(0)
           ENDIF
        ENDIF
 
        IF B >= V_DATVEN
           SET COLOR TO GR+/3
           setcolor(mesafrente+"/"+mesafundo)
           @ 18,05 SAY 'Data Correta...                             '
           SETCOLOR("")
        ELSE
           DO BIIP
           setcolor(mesafrente+"/"+mesafundo)
           @ 18,05 say 'Data Incorreta...                           '
           SETCOLOR("")
        ENDIF
        DO BAIXA
        IF EX = "S"
          DO LMEN
          REPLACE CANCELADA WITH "C"
          REPLACE DATBAIX   WITH B
          COMMIT
          destrava()
        ENDIF
     ELSE
        MENSAGEM("** Registro n„o dispon¡vel p/ Altera‡”es **")
        INKEY(3)
        QUENTRAVA()
     ENDIF
        RESTORE SCREEN FROM WER
        SET CURSOR OFF
        DO LMEN
 
case tecla == 99 // retorna arquivo baixado
 
     IF RECLOCK(5)
        DO RETORNO
        IF EX = "S"
          DO LMEN
          REPLACE CANCELADA WITH " "
          REPLACE DATBAIX   WITH DATE()
          COMMIT
          destrava()
        ENDIF
      ELSE
         MENSAGEM("** Registro n„o dispon¡vel p/ altera‡”es **")
         INKEY(3)
         QUENTRAVA()
      ENDIF
        DO LMEN
 
 
case tecla == -5 // pesquisa por numero
 
     SAVE SCREEN TO telacod
     XTEMP = 0
     QUADRO(15,15,17,41,7,consfrente+"/"+consfundo,"Consulta por n£mero",.T.)
     setcolor(consfrente+"/"+consfundo)
     @ 16,19 SAY "N£mero..> " GET XTEMP PICT "99999999"
     setcolor("")
     READ
     SET ORDER TO 5 // numero
     SET SOFTSEEK ON
     SEEK XTEMP
     SET SOFTSEEK OFF
     RESTORE SCREEN FROM telacod
 
case tecla == -6 // pesquisa por data
 
     SAVE SCREEN TO telacod
     XTEMP = date()
     QUADRO(15,15,17,41,7,mesafrente+"/"+mesafundo,"Consulta por Data",.T.)
     setcolor(consfrente+"/"+consfundo)
     @ 16,19 SAY "data....> " GET XTEMP
     setcolor("")
     READ
     SET ORDER TO 3 // numero
     SET SOFTSEEK ON
     SEEK XTEMP
     SET SOFTSEEK OFF
     RESTORE SCREEN FROM telacod
 
case tecla == -7 // pesquisa por Historico
 
     SAVE SCREEN TO telacod
     XTEMP = space(45)
     QUADRO(15,15,17,76,7,consfrente+"/"+consfundo,"Consulta Hist¢rico",.T.)
     setcolor(consfrente+"/"+consfundo)
     @ 16,19 SAY "Dados...> " GET XTEMP PICT "@!KX"
     setcolor("")
     READ
     SET ORDER TO 2 // historico
     SET SOFTSEEK ON
     SEEK ALLTRIM(XTEMP)
     SET SOFTSEEK OFF
     RESTORE SCREEN FROM telacod
 
case tecla == -8 // pesquisa por vencimento
 
     SAVE SCREEN TO telacod
     XTEMP = date()
     QUADRO(15,15,17,40,7,consfrente+"/"+consfundo,"Consulta Vencimento",.T.)
     setcolor(consfrente+"/"+consfundo)
     @ 16,19 SAY "Data....> " GET XTEMP
     setcolor("")
     READ
     SET ORDER TO 4 // historico
     SET SOFTSEEK ON
     SEEK XTEMP
     SET SOFTSEEK OFF
     RESTORE SCREEN FROM telacod
 
case tecla == -3  // cadastra
 
     SAVE SCREEN TO PROD
     SELECT credito
     SET ORDER TO 1
     SET CURSOR ON
     SET INTE OFF
     GO BOTTOM
     VCOD = VAL(ORDEM) + 1
     SKIP
     VORDEM  = STRZERO(VCOD,5)
     SEGUE   = ' '
     VNUMERO     = 0
     VVALOR      = 0
     VFORNECEDOR = SPACE(45)
     VDATA       = DATE()
     VDATVEN     = DATE()
     VCODIGO     = 0
     OK      = ' '
     DO WHILE SEGUE <> 'N'
        select credito
        IF OK = 'S'
           GO BOTTOM
           VCOD = VAL(ORDEM) + 1
           SKIP
           VORDEM      = STRZERO(VCOD,5)
           VNUMERO     = 0
           VVALOR      = 0
           VFORNECEDOR = space(45)
           VDATA       = date()
           VDATVEN     = date()
           VCODIGO     = 0
        ENDIF
        SET ORDER TO 5
        GO TOP
        QUADRO(12,04,18,70,7,opcaofrente+"/"+opcaofundo,"Cadastro de Cr‚dito",.T.)
        setcolor(opcaofrente+"/"+opcaofundo)
        @ 13,06 say "    N£mero..> " GET  VNUMERO
        setcolor("")
        READ
        SEEK VNUMERO
        IF FOUND()
           DO MENSAGEM WITH "Cr‚dito j  lan‡ado. OK! <ENTER>"
           INKEY(0)
           DO LMEN
           LOOP
        ENDIF
        SET ORDER TO 2
        setcolor(opcaofrente+"/"+opcaofundo)
        @ 14,06 say "     Valor..> " GET  VVALOR  PICT '9999,999,999.99'
        @ 15,06 say "fornecedor..> " GET  VCODIGO  PICT "99999999"
        READ
        SELECT forneced
        SEEKREC(VCODIGO)
        IF FOUND()
          @ 15,20 SAY nome
          VFORNECEDOR = nome
        ELSE
            SELECT credito
            @ 15,20 GET VFORNECEDOR PICT "@!"
         ENDIF
        SELECT credito
        @ 16,06 say "      Data..> " GET VDATA
        @ 17,06 say "Vencimento..> " GET VDATVEN
        setcolor("")
        READ
        IF VDATVEN < VDATA
           DO MENSAGEM WITH "Data de vencimento inv lida. OK! <ENTER>"
           INKEY(0)
           DO LMEN
           LOOP
        ENDIF
        MOK()
        REC=RECNO()
        IF LASTKEY() = 83 .OR. LASTKEY() = 115 .OR. LASTKEY() = 13
           OK = 'S'
           if addrec(5)
              REPLACE      ORDEM WITH VORDEM,;
                          NUMERO WITH VNUMERO,;
                           VALOR WITH VVALOR,;
                      FORNECEDOR WITH VFORNECEDOR,;
                            DATA WITH VDATA,;
                          DATVEN WITH VDATVEN,;
                           COD   WITH VCODIGO,;
                           banco WITH V_banco
                           commit
                           destrava()
           ELSE
              MENSAGEM("** Registro n„o dispon¡vel p/ inclus”es **")
              INKEY(3)
              DO LMEN
              QUENTRAVA()
           ENDIF
           DO LMEN
           setcolor(mesafrente+"/"+mesafundo)
           @ 23,01 SAY "OK... Dados confirmado! Pressione qualquer tecla."
           setcolor("")
           inkey(0)
        ELSE
           OK = 'N'
           DO LMEN
           setcolor(mesafrente+"/"+mesafundo)
           @ 23,01 SAY "OK... Dados n„o confirmado! Pressione qualquer tecla."
           setcolor("")
           INKEY(0)
        ENDIF
        SEGUE = 'N'
        SET INTE ON
        SET CURSOR OFF
     ENDDO
     RESTORE SCREEN FROM PROD
     go rec
     SELECT credito
     SET ORDER TO 2
 
case tecla = 291 // chama o help
 
     save screen to help
     QUADRO(05,08,18,57,7,opcaofrente+"/"+opcaofundo,"Teclas de Fun‡”es",.T.)
     setcolor(opcaofrente+"/"+opcaofundo)
     @ 06,10 say "   [ b ] - Baixa Cr‚dito."
     @ 07,10 say "   [ c ] - Cancela baixa do Cr‚dito."
     @ 08,10 say "      F4 - Cadastra Cr‚dito."
     @ 09,10 say "      F6 - Consulta pelo n£mero do Cr‚dito."
     @ 10,10 say "      F7 - Consulta pela data de Emiss„o."
     @ 11,10 say "      F8 - Consulta pelo Hist¢rico."
     @ 12,10 say "      F9 - Consulta pelo vencimento."
     @ 13,10 say "  INSERT - Altera a C‚lula Posicionada."
     @ 14,10 say "  DELETE - Deleta a Linha Posicionada."
     @ 15,10 say "  PAGEup - Rola uma tela p/ cima."
     @ 16,10 say "PAGEdown - Rola uma tela p/ baixo."
     @ 17,10 say CHR(24)+" "+CHR(25)+" "+CHR(26)+" "+CHR(27)+"  - Teclas de Direcionamento da C‚lula."
     MENSAGEM("** Pressione Qualquer Tecla Para Abandonar **")
     inkey(0)
     restore screen from help
 
case tecla == 22 // altera a celula
 
     SET CURSOR ON
     IF RECLOCK(5)
        @ row(),col() get &campo
        read
        COMMIT
        UNLOCK
     ELSE
        QUENTRAVA()
     ENDIF
     SET CURSOR OFF
 
Case TECLA = 7   //deleta linha
 
     IF RECLOCK(5)
       DO Exclui
       IF ex = "S"
         DO lmen
         DELETE
         COMMIT
         DESTRAVA()
       ENDIF
       SKIP
       DO lmen
     ELSE
        MENSAGEM("** Registro N„o Dispon¡vel p/ Exclus„o **")
        INKEY(3)
        DO LMEN
        QUENTRAVA()
     ENDIF
 
ENDCASE
RETURN retorna
