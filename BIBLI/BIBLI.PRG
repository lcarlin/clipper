****************************************************
* PROGRAMA        : BIBLI.PRG                      *
* AUTOR           : LUIZ A. CARLIN "O CORSARIO"    *
* DATA            : 10/15/93                       *
* DATA DA ATUAL.  :   /  /                         *
* FUNCAO          : MENU PRINCIPAL DO SISTEMA DE   *
*                 : BIBILOTECA                     *
****************************************************
SET DATE BRITISH
SET PROCEDURE TO BIBLI
SET TALK OFF
SET STATUS OFF
SET SCOREBOARD OFF
SET ECHO OFF
SET WRAP ON
CLEAR
ENCE="N"
DO WHILE ENCE="N"
    SET MESSAGE TO 16 CENTER
    @ 00,00 TO 24,79 DOUBLE
    @ 01,01,23,78 BOX "°°°°²"
    @ 03,28 TO 05,45
    SET COLOR TO N/W
    @ 04,29 SAY " MENU PRINCIPAL "
    SET COLOR TO W/N
    @ 7,25 CLEAR TO 14,47
    @ 07,26 TO 14,46
    SET COLOR TO N/W
    @ 08,46 say CHR(24)
    SET COLOR TO W/N
    @ 09,46 SAY CHR(219)
    @ 10,46 SAY CHR(219)
    @ 11,46 SAY CHR(219)     
    @ 12,46 SAY CHR(219)
    SET COLOR TO N/W
    @ 13,46 SAY CHR(25)
    SET COLOR TO W/N
    @ 08,27 PROMPT "1..LIVRO.........1" MESSAGE " Cadastramento  e  pesquisa de livros "
    @ 09,27 PROMPT "2..USUARIOS......2" MESSAGE " Cadastramento e pesquisa de clientes "
    @ 10,27 PROMPT "3..MOVIMENTACAO..3" MESSAGE " Movimentac„o  de  contas de clientes "
    @ 11,27 PROMPT "4..ORGANIZAR.....4" MESSAGE " Ordena  e  indexa  arquivos de dados "
    @ 12,27 PROMPT "5..RELATORIOS....5" MESSAGE " Emite  relatorios de tela/impressora "
    @ 13,27 PROMPT "6..FINALIZAR.....6" MESSAGE " Encerra   a   execuc„o  do  programa "
    MENU TO OPC
    READ
    DO CASE
          CASE OPC=1
	       DO MLIV
          CASE OPC=2
               DO MUSU
	  CASE OPC=3
               DO MOVLIV
          CASE OPC=4
	       ??chr(07)
	       USE CADLI
	       INDEX ON CODL TO COD1
	       USE USUARIO
	       INDEX ON CODC TO COD2
	       USE MOV-LIV
	       INDEX ON CODC+CODL TO COD3
	       CLOSE DATABASES
	       @ 21,00 CLEAR  TO 24,79
	  CASE OPC=5
	       CLEAR
	       DO MIMP
	  CASE OPC=6
	       @ 19,22 CLEAR TO 21,53
	       @ 19,22 TO 21,53
	       ENCE="N"
	       @ 20,23 SAY "Quer Mesmo Encerrar <S/N> ? " GET ENCE PICTURE "!"
	       READ
	       @ 20,13 CLEAR TO 23,60
	       IF ENCE="S"
	           CLEAR ALL
	           CLEAR
	           CLOSE DATABASES
                   @ 00,00 SAY "***> BIBLI; Programa de Controle de Bibliotecas e Livrarias, V 1.0 <***"
                   @ 01,00 SAY ""
                   CANCEL
               ENDIF
    ENDCASE
ENDDO
CLOSE DATABASES
******************************************************************************
PROCEDURE MLIV
USE CADLI INDEX COD1
CLEAR
CONT="S"
DO WHILE UPPER(CONT)="S"
   @ 01,01,23,78 BOX "°°°°"
   STORE SPACE(4) TO MCODL
   set color to n/w
   @ 01,25 SAY "Inclus„o/Manutencao de Livros"
   SET COLOR TO W/N
   @ 03,04 TO 11,70
   @ 04,05 SAY "CODIGO: "
   @ 04,30 SAY "TITULO: "+SPACE(30)
   @ 06,05 SAY "AUTOR : "+SPACE(30)
   @ 06,48 SAY "GRUPO : "+SPACE(04)
   @ 08,05 SAY "QUANTIDADE : "+SPACE(05)
   @ 08,40 SAY "PRECO UNIT.: "+SPACE(15)
   @ 10,05 SAY "DATA ENT.  : "+SPACE(08)
   @ 10,40 SAY "TIPO : "+SPACE(11)
   ??CHR(7)
   @ 21,15 SAY "Digite o codigo ou <ENTER> p/ sair"
   @ 04,13 GET MCODL PICTURE "@!"
   READ
   IF MCODL ="    "
      CLOSE DATABASES
      CLEAR
      RETURN
   ENDIF
   ALTER="R"
   SEEK MCODL
   IF FOUND()
      MTITULO = TITULO
      MAUTOR  = AUTOR
      MPUNIT  = PUNIT
      MQTD    = QTDE
      MGRUPO  = GRUPO
      MCODL   = CODL
      MDATAENT= DATAENT
      MTIPOL  = TIPOL
      @ 04,38 GET MTITULO PICTURE "@!"
      @ 06,13 GET MAUTOR PICTURE "@!"
      @ 06,56 GET MGRUPO PICTURE "@!"
      @ 08,18 GET MQTD PICTURE "9,999"      
      @ 08,53 GET MPUNIT PICTURE "999999999999.99"
      @ 10,18 GET MDATAENT PICTURE "99/99/99"
      @ 10,48 GET MTIPOL PICTURE "@!"
      CLEAR GETS
      ??CHR(7)
      @ 21,10 SAY "Codigo existente, <R>retorna; <A>altera; <E>exclui ?" GET ALTER PICTURE "!A"
      READ
      @ 21,10 SAY "                                                                 "
      IF ALTER<>"E" .AND. ALTER<>"A"
         LOOP
      ENDIF
      IF ALTER="E"
         CERT="N"
	 ??chr(07)
	 @ 21,15 SAY "ESTE REGISTRO SERA EXCLUIDO!! TEM CERTEZA <S/N> " GET CERT PICTURE "!A"
	 READ
	 @ 21,15 SAY "                                                        "
	 IF CERT="S"
	    DELETE
	    PACK
         ENDIF
      ENDIF
   ELSE
      CERT="S"
      @ 21,15 SAY "Codigo novo; deseja cadastrar <S/N> " GET CERT PICTURE "!A"
      READ
      @ 21,15 SAY "                                          "
      IF CERT="N"
         LOOP
      ENDIF
      MTITULO = SPACE(30)
      MAUTOR  = SPACE(30)
      MGRUPO  = SPACE(03)
      MTIPOL  = SPACE(11)
      MDATAENT= CTOD("  /  /  ")
      MPUNIT  = 0
      MQTD    = 0
   ENDIF
   RESPI="N"
   DO WHILE UPPER(RESPI)="N" .AND. ALTER<>"E"
      @ 04,38 GET MTITULO PICTURE "@!"
      @ 06,13 GET MAUTOR PICTURE "@!"
      @ 06,56 GET MGRUPO PICTURE "@!"
      @ 08,18 GET MQTD PICTURE "9,999"      
      @ 08,53 GET MPUNIT PICTURE "999999999999.99"
      @ 10,18 GET MDATAENT PICTURE "99/99/99"
      @ 10,48 GET MTIPOL PICTURE "@!"
      READ
      ??chr(07)
      @ 21,15 SAY "Os dados estao corretos<S/N> ? " GET RESPI PICTURE "!"
      READ
      @ 21,15 SAY "                                      "
   ENDDO
   IF ALTER<>"E"
      IF ALTER<>"A"
         APPEND BLANK
      ENDIF
      REPLACE TITULO WITH MTITULO
      REPLACE AUTOR WITH MAUTOR
      REPLACE PUNIT WITH MPUNIT
      REPLACE QTDE WITH MQTD
      REPLACE GRUPO WITH MGRUPO
      REPLACE DATAENT WITH MDATAENT
      REPLACE CODL WITH MCODL
      REPLACE TIPOL WITH MTIPOL
   ENDIF
   @ 21,15 SAY "Quer continuar <S/N> ? " GET CONT  PICTURE "!"
   READ
ENDDO
CLOSE DATABASES
CLEAR
RETURN
*****************************************************************************
PROCEDURE MUSU
USE USUARIO INDEX COD2
CLEAR
CONT="S"
DO WHILE UPPER(CONT)="S"
   @ 01,01,23,78 BOX "°°°°"
   STORE SPACE(4) TO MCODC
   @ 03,04 TO 11,76
   SET COLOR TO N/W   
   @ 1,25 SAY "Inclus„o/Manutencao de Clientes"
   SET COLOR TO W/N
   @ 04,05 SAY "CODIGO: "
   @ 04,32 SAY "NOME: "+SPACE(30)
   @ 06,05 SAY "ENDER.: "+SPACE(40)
   @ 08,05 SAY "CIDADE: "+SPACE(15)
   @ 08,30 SAY "UF: "+SPACE(02)
   @ 08,50 SAY "CEP: "+SPACE(10)
   @ 10,05 SAY "FONE : "+SPACE(15)
   @ 10,45 SAY "TIPO :" + SPACE(01)
   @ 15,09 to 18,53     
   @ 16,10 SAY "Tipos:<C>omprador;<L>ocatario;<V>endedor;"
   @ 17,10 say "      <E>mprestimo"
   ??CHR(7)
   @ 21,15 SAY "Digite o codigo ou <ENTER> p/ sair"
   @ 04,13 GET MCODC PICTURE "@!"
   READ
   IF MCODC ="    "
      CLOSE DATABASES
      CLEAR
      RETURN
   ENDIF
   ALTER="R"
   SEEK MCODC
   IF FOUND()
      MNOME = NOME
      MENDER = END
      MCID  = CID
      MUF   = UF
      MCEP  = CEP
      MFONE   = FONE
      MTIPO = TIPO
      @ 15,09 to 18,53     
      @ 16,10 SAY "Tipos:<C>omprador;<L>ocatario;<V>endedor;"
      @ 17,10 say "      <E>mprestimo"
      @ 04,38 GET MNOME PICTURE "@!"
      @ 06,13 GET MENDER PICTURE "@!"
      @ 08,13 GET MCID PICTURE "@!"
      @ 08,34 GET MUF PICTURE "@!"    
      @ 08,55 GET MCEP PICTURE "@!"
      @ 10,12 GET MFONE PICTURE "@!"      
      @ 10,51 GET MTIPO PICTURE "@!"      
      CLEAR GETS
      ??CHR(7)
      @ 21,10 SAY "Codigo existente, <R>retorna; <A>altera; <E>exclui ?" GET ALTER PICTURE "!A"
      READ
      @ 21,10 SAY "                                                                 "
      IF ALTER<>"E" .AND. ALTER<>"A"
         LOOP
      ENDIF
      IF ALTER="E"
         CERT="N"
	 ??chr(07)
	 @ 21,15 SAY "ESTE REGISTRO SERA EXCLUIDO!! TEM CERTEZA <S/N> " GET CERT PICTURE "!A"
	 READ
	 @ 21,15 SAY "                                                        "
	 IF CERT="S"
	    @ 15,09 CLEAR TO 18,61
	    DELETE
	    PACK
        ENDIF
      ENDIF
   ELSE
      CERT="S"
      @ 21,15 SAY "Codigo novo; deseja cadastrar <S/N> " GET CERT PICTURE "!A"
      READ
      @ 21,15 SAY "                                               "
      IF CERT="N"
         LOOP
      ENDIF
      MNOME   = SPACE(30)
      MENDER  = SPACE(40)
      MCID    = SPACE(15)
      MUF     = SPACE(02)
      MCEP    = SPACE(10)
      MFONE   = SPACE(15)
      MTIPO   = SPACE(01)
      @ 04,38 GET MNOME PICTURE "@!"
      @ 06,13 GET MENDER PICTURE "@!"
      @ 08,13 GET MCID PICTURE "@!"
      @ 08,34 GET MUF PICTURE "@!"    
      @ 08,55 GET MCEP PICTURE "@!"
      @ 10,12 GET MFONE PICTURE "@!"  
      @ 10,51 GET MTIPO PICTURE "@!"  
      READ
      CLEAR GETS
      ??CHR(7)
   ENDIF
   RESPI="N"
   DO WHILE UPPER(RESPI)="N" .AND. ALTER<>"E"
      @ 15,09 to 18,53     
      @ 16,10 SAY "Tipos:<C>omprador;<L>ocatario;<V>endedor;"
      @ 17,10 say "      <E>mprestimo"
      @ 04,38 GET MNOME PICTURE "@!"
      @ 06,13 GET MENDER PICTURE "@!"
      @ 08,13 GET MCID PICTURE "@!"
      @ 08,34 GET MUF PICTURE "@!"    
      @ 08,55 GET MCEP PICTURE "@!"
      @ 10,12 GET MFONE PICTURE "@!"      
      @ 10,51 GET MTIPO PICTURE "@!"       
      READ
      CLEAR GETS
      ??CHR(7)
      @ 21,15 SAY "Os dados estao corretos<S/N> ? " GET RESPI PICT "!"
      READ
      @ 21,15 SAY "                                      "
   ENDDO
   IF ALTER<>"E"
      IF ALTER<>"A"
         APPEND BLANK
      ENDIF
      REPLACE CODC WITH MCODC
      REPLACE NOME WITH MNOME
      REPLACE END WITH MENDER
      REPLACE CID WITH MCID
      REPLACE UF WITH MUF
      REPLACE CEP WITH MCEP
      REPLACE FONE WITH MFONE
      REPLACE TIPO WITH MTIPO
   ENDIF
   @ 21,15 SAY "Quer continuar <S/N> ? " GET CONT  PICT "!"
   READ
ENDDO
CLOSE DATABASES
CLEAR
RETURN
*****************************************************************************
PROCEDURE MOVLIV
SELECT 1
 USE CADLI INDEX COD1
SELECT 2
 USE USUARIO INDEX COD2
SELECT 3
 USE MOV-LIV INDEX COD3
SELECT 2
CLEAR
CONT="S"
REZA="S"
MQUANT=0
DO WHILE UPPER(CONT)="S"
   @ 01,01,23,78 BOX "°°°°"
   @ 02,04 TO 12,76
   STORE SPACE(4) TO MCODL
   STORE SPACE(4) TO MCODC
   SET COLOR TO N/W
   @ 01,29 SAY "Movimentacoes de livros"
   SET COLOR TO W/N
   @ 03,05 SAY "CODIGO : "
   @ 03,31 SAY "NOME : "+SPACE(30)
   @ 05,05 SAY "CODIGO-LIVRO : "+SPACE(04)
   @ 05,31 SAY "TITULO : "+SPACE(30)
   @ 07,05 SAY "PRECO : "+SPACE(15)
   @ 07,42 SAY "DATA-COMPRA : " +SPACE(08)
   @ 09,05 SAY "OPCAO : "+SPACE(01)
   @ 09,20 SAY "QUANTIDADE : "+SPACE(05)
   @ 09,42 SAY "TIPO DE MOVIMENTACAO : "+SPACE(01)
   @ 11,05 SAY "TOTAL A PAGAR : "+SPACE(15)
   ??CHR(7)
   @ 21,15 SAY "Digite o codigo do cliente ou <ENTER> p/ sair"
   @ 03,14 GET MCODC PICTURE "@!"
   READ
   @ 21,15 SAY "                                                             "
   IF MCODC="    "
      CLOSE DATABASES
      CLEAR
      RETURN
   ENDIF
   SEEK MCODC
   IF .NOT. FOUND()
      ??chr(07)
      @ 21,15 SAY "Codigo n„o existente; tecle <ENTER>"
      INKEY(0)
      @ 21,15 SAY "                                                      "
      LOOP
   ELSE
      @ 03,38 GET NOME
      MNOME=NOME
      CLEAR GETS
      REZA="N"
      DO WHILE UPPER(REZA)="N"
         MCODL="    "
         SELECT 1
         ??chr(07)
         @ 21,15 SAY "Digite o codigo do livro ou <ENTER> p/ sair"
         @ 05,31 SAY "TITULO : "+SPACE(30)
         @ 07,05 SAY "PRECO : "+SPACE(15)
         @ 07,42 SAY "DATA-COMPRA : " +SPACE(08)
         @ 09,05 SAY "OPCAO : "+SPACE(01)
         @ 09,20 SAY "QUANTIDADE : "+SPACE(05)
	 @ 09,42 SAY "TIPO DE MOVIMENTACAO : "+SPACE(01)
         @ 11,05 SAY "TOTAL A PAGAR : "+SPACE(15)
         @ 05,20 GET MCODL  PICTURE "@!"
         READ
         @ 21,15 SAY "                                                   "
         IF MCODL="    "
            CLOSE DATABASES
            CLEAR
            RETURN
         ENDIF
         SEEK MCODL
         IF .NOT. FOUND()
            ??chr(07)
            @ 21,15 SAY "Codigo n„o existente; tecle <ENTER>"
            INKEY (0)
            @ 21,15 SAY "                                               "
            LOOP
	 ENDIF
         @ 05,40 GET TITULO
	 @ 07,13 GET PUNIT
         MTITULO=TITULO
	 MQTDE=QTDE
	 MPUNIT=PUNIT
         CLEAR GETS
	 SELECT 3
	 MOPCAO=" "
         MQUANT=0
	 MDEC  =CTOD("  /  /  ")
	 MTM=" "
	 @ 07,56 GET MDEC PICTURE "99/99/99"
         @ 09,13 GET MOPCAO PICTURE "@!"
         @ 09,33 GET MQUANT PICTURE "9,999"
         @ 15,09 to 18,53     
         @ 16,10 SAY "Tipos:<C>omprador;<L>ocatario;<V>endedor;"
         @ 17,10 say "      <E>mprestimo"	
	 @ 09,65 GET MTM PICTURE "@!"
         READ
	 @ 15,09 clear to 18,55
	 IF MQUANT>MQTDE
	    ??chr(07)
	    @ 21,15 SAY "O estoque e de apenas "+ STR(MQTDE,4)+ " Tecle <ENTER>"
	    READ
	    INKEY(0)
	    @ 21,15 SAY "                                                              "
	    LOOP
	 ENDIF
	 MTOTO=MQUANT*MPUNIT
	 @ 11,22 GET MTOTO
	 CLEAR GETS
	 ??chr(07)
	 @ 21,15 SAY "Os dados estao corretos <S/N>?" GET REZA PICTURE "!"
	 READ
	 @ 21,15 SAY "                                                "
         IF UPPER(REZA)="N"
             @ 05,05 SAY "CODIGO-LIVRO : "
             @ 05,31 SAY "TITULO : "+SPACE(30)
             @ 07,13 SAY "PRECO : "+SPACE(15)
             @ 07,42 SAY "DATA-COMPRA : " +SPACE(08)
             @ 09,05 SAY "OPCAO : "+SPACE(01)
             @ 09,20 SAY "QUANTIDADE : "+SPACE(05)
	     @ 09,42 SAY "TIPO DE MOVIMENTACAO"+SPACE(01)
             @ 11,05 SAY "TOTAL A PAGAR : "+SPACE(15) 
	     LOOP
	 ENDIF
         SELECT 1
         MQDE=MQTDE-MQUANT
         REPLACE QTDE WITH MQDE  
         SELECT 3
         APPEND BLANK
         REPLACE CODC WITH MCODC
         REPLACE NOME WITH MNOME
         REPLACE CODL WITH MCODL
         REPLACE TITULO WITH MTITULO
         REPLACE TOTU WITH MTOTO 
         REPLACE OPCAO WITH MOPCAO
         REPLACE QTDC WITH MQUANT
         REPLACE DEC WITH MDEC
         REPLACE TM WITH MTM
         ??chr(07)
         @ 21,15 SAY "Deseja mais moventacoes <S/N>?" GET CONT PICTURE "!" 
         READ
         @ 21,15 SAY "                                            "
     ENDDO
  ENDIF
ENDDO
CLOSE DATABASE
CLEAR
RETURN
*****************************************************************************
PROCEDURE MIMP
GOTO TOP
clear
USE MOV-LIV INDEX COD3
DO WHILE .NOT. EOF()
   @ 01,01,23,78 BOX "°°°°"
   MCODC=SPACE(04)
   @ 04,09 to 08,53 DOUBLE
   @ 11,09 clear to 17,60

   @ 05,10 SAY "Entre c/ o Codigo do Cliente "
   @ 06,10 SAY "ou <ENTER> para sair : "
   @ 07,15 GET MCODC PICTURE "@!"
   READ
   SEEK MCODC
   IF MCODC=SPACE(04)
      CLOSE DATABASES
      CLEAR
      RETURN
   ENDIF
   IF .NOT. FOUND() 
      @ 09,15 SAY "Cliente n„o cadastrado"
      @ 10,15 say "Ou sem movimentacoes; tecle <ENTER>"
      INKEY (0)
      @ 09,15 SAY "                                              "
      LOOP
   ENDIF
   IMP="S"
   @ 11,10 SAY "Imprime na Impressora <S/N> " GET IMP PICT "!"
   READ
   IF IMP="S"
       IF ISPRINTER()
        * CLEAR
	  @ 15,29 SAY "Imprimindo..."
	  SET CONS OFF
          SET DEVICE TO PRINTER
          MTOT=0
          @ 01,25 SAY "Relatorio de compras;"
          PAG=1
          LIN=4
          @ 03,03 SAY "PAG. "+STR(PAG,3,0)
          @ LIN+1,5 SAY "Cliente : "+NOME
          @ LIN+2,4 SAY "COD. LI"+ "    TITULO"+ "           QTDE"+ "     DATA"+"         OPCAO"+"     SUB. TOTAL"
          TOTAL=0
          DO WHILE  MCODC=CODC
             @ LIN + 3,05 SAY CODL
             @ LIN + 3,14 SAY TITULO
             @ LIN + 3,30 SAY QTDC
             @ LIN + 3,40 SAY DEC
             @ LIN + 3,56 SAY OPCAO
             @ LIN + 3,59 SAY TOTU
             LIN=LIN+1
             MTOT=MTOT+TOTU
             SKIP
             DO WHILE LIN = 60                
	        LIN=4
		PAG=PAG+1
		EJECT
                @ 03,03 SAY "PAG. "+STR(PAG,3,0)
             ENDDO
          ENDDO
          MTOTU=MTOT
          @ LIN + 4,03 SAY " TOTAL DESTA NOTA -------------------------------------->" GET MTOTU
          @ LIN+5,04 SAY REPLICATE ("#",70)
	  EJECT
	  SET DEVICE TO SCREEN
	  SET CONS ON
	  clear
	  LOOP
       ELSE
	  SET CONS ON
          @ 12,15 SAY "A impressora n„o pode estar pronta; tecle <ENTER>"
	  INKEY(0)
	  @ 11,10 CLEAR TO 13,70
	  LOOP
       ENDIF
   ENDIF
   MTOT=0
   CLEAR
   @ 1,0,24,79 BOX "°°°°"
   SET COLOR TO N/W
   @ 01,25 SAY "Relatorio de compras"
   SET COLOR TO W/N
   @ 02,02 TO 23,76 DOUBLE
   PAG=1
   LIN=4
   @ 03,03 SAY "PAG. "+STR(PAG,3,0)
   @ LIN+1,5 SAY "Cliente : "+NOME
   @ LIN+2,4 SAY "COD. LI"+ "    TITULO"+ "           QTDE"+ "     DATA"+"         OPCAO"+"     SUB. TOTAL"
   TOTAL=0
   DO WHILE MCODC=CODC
      @ LIN + 3,05 SAY CODL
      @ LIN + 3,14 SAY TITULO
      @ LIN + 3,30 SAY QTDC
      @ LIN + 3,40 SAY DEC
      @ LIN + 3,56 SAY OPCAO
      @ LIN + 3,59 SAY TOTU
      LIN=LIN+1
      MTOT=MTOT+TOTU
      SKIP
      DO WHILE LIN >= 20
         LIN=4
         @ 23,20 SAY "Pressione algo p/ continuar"
	 inkey (0)
	 @ 07,04 clear to 22,75
	 PAG=PAG+1
         @ 03,03 SAY "PAG. "+STR(PAG,3,0)
      ENDDO
   ENDDO
   MTOTU=MTOT
   SET INTENSITY OFF
   @ LIN + 4,03 SAY " TOTAL DESTA NOTA -¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯-¯>" GET MTOTU
   CLEAR GETS
   SET INTENSITY ON
   @ LIN+5,04 SAY REPLICATE ("#",70)
   @ 23,20 SAY "Pressione algo p/ continuar"
   INKEY(0)
   clear
ENDDO
CLOSE ALL
CLEAR
