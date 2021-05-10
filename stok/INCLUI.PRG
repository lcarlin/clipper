******************************************************************************
USE MATERIAL INDEX INX1
CLEAR
CONT="S"
DO WHILE UPPER(CONT)="S"
   @ 0,0,24,79 BOX CHR(127)+CHR(176)+chr(127)+CHR(176)+CHR(127)+CHR(176)+CHR(127)+CHR(176)
   SET COLOR TO N/W
   centra(00,"INCLUSAO/MANUTENCAO DE MATERIAIS")
   centra(24,"<F2>-Imprime Codigos De Materiais")
   SET COLOR TO W/N
   STORE SPACE(15) TO MCODMAT
   @ 02,02 SAY "CODIGO.................:"
   @ 04,02 SAY "MATERIAL...............:"+SPACE(52)
   @ 06,02 SAY "QTDE. RECEBIDA.........:"+SPACE(08)
   @ 06,44 SAY "CLASSIFICA€ŽO.:"+SPACE(12)
   @ 08,02 SAY "FORMA DE ENTREGA.......:"+SPACE(23)
   @ 10,02 SAY "VALOR UNITARIO.........:"+SPACE(19)
   @ 12,02 SAY "NOTA DE ENTREGA No.....:"+SPACE(35)
   @ 14,02 SAY "DATA DE ENTREGA........:"+SPACE(12)
   @ 14,44 SAY "DATA REPOSI...:"+SPACE(10)
   @ 16,02 SAY "PROCEDENCIA............:"+SPACE(42)
   @ 18,02 SAY "QUANTIDADE ATUAL.......:"+SPACE(12)
   @ 18,44 SAY "VALOR ENTREGUE.:"+ SPACE(19)
   @ 20,02 SAY "VALOR DO ESTOQUE ATUAL.:"+SPACE(19)
   centra(23,"Digite o codigo do material; <ENTER> p/ a tabela ou <ESC> P/ Sair")
   do WHILE EMPTY(MCODMAT)
      @ 02,28 get mcodmat pict "@!"
      read
      IF LASTKEY()=27
         CLOSE DATABASES
         CLEAR
         RETURN
      ELSEIF LASTKEY()=13 .AND. EMPTY(MCODMAT)
         TABELA(1)
         @02,28 GET MCODMAT PICTURE "@!"
         CLEAR GETS
      ENDIF
   ENDDO
   @ 22,02 clear to 23,78
   ALTER="R"
   SEEK MCODMAT
   IF FOUND()
      MMATERIAL = MATERIAL
      MQTDRECEB = QTDRECEB
      MCLASS    = CLASS
      MVALENT   = VALENT
      MVALSAL   = VALSAL
      MNDOC     = NDOC
      MQTDESAIDA= QTDESAIDA
      MPROCED   = PROCED
      MDATAEN   = DATAEN
      MDATAEN2  = DATAEN2
      MVALUNIT  = VALUNIT
      MUNIDADE  = UNIDADE
      @ 04,28 GET MMATERIAL PICT "@!"
      @ 06,28 GET MQTDRECEB PICTURE "99999"
      @ 06,61 GET MCLASS PICTURE "@!"
      @ 08,28 GET MUNIDADE PICTURE "@!"
      @ 10,28 GET MVALUNIT PICTURE "999999,999.99"
      @ 12,28 GET MNDOC PICTURE "@!"
      @ 14,28 GET MDATAEN PICTURE "99/99/99"
      @ 14,61 GET MDATAEN2 PICTURE "99/99/99"
      @ 16,28 GET MPROCED PICTURE "@!"
      @ 18,28 GET MQTDESAIDA PICTURE "99999"
      @ 18,62 GET MVALENT PICTURE  "999999,999.99"
      @ 20,28 GET MVALSAL  PICTURE "999999,999.99"
      CLEAR GETS
      @ 22,10 SAY "Codigo existente, <R>retorna; <A>altera; <E>exclui ?" GET ALTER PICTURE "!A"
      READ
      @ 22,10 SAY "                                                                 "
      IF ALTER<>"E" .AND. ALTER<>"A"
         LOOP
      ENDIF
      IF ALTER="E"
         CERT="N"
         @ 22,15 SAY "ESTE REGISTRO SERA EXCLUIDO!! TEM CERTEZA <S/N> " GET CERT PICTURE "!A"
         READ
         @ 22,15 SAY "                                                        "
         IF CERT="S"
            DELETE
            PACK
            LOOP
         ENDIF
      ENDIF
   ELSE
      CERT="S"
      @ 22,15 SAY "Codigo novo; deseja cadastrar <S/N> " GET CERT PICTURE "!A"
      READ
      @ 22,15 SAY "                                                  "
      IF CERT="N"
         LOOP
      ENDIF
      MMATERIAL = SPACE(50)
      MUNIDADE  = SPACE(20)
      MPROCED   = SPACE(30)
      MNDOC     = SPACE(12)
      MQTDRECEB = 0
      MCLASS    = SPACE(8)
      MDATAEN   = CTOD("  /  /  ")
      MVALENT   = 0
      MVALSAL   = 0
      MVALUNIT  = 0
      MQTDESAIDA= 0
      @ 04,28 GET MMATERIAL PICT "@!"
      @ 06,28 GET MQTDRECEB PICTURE "99999"
      @ 06,61 GET MCLASS PICTURE "@!"
      @ 08,28 GET MUNIDADE PICTURE "@!"
      @ 10,28 GET MVALUNIT PICTURE "999999,999.99"
      @ 12,28 GET MNDOC PICTURE "@!"
      @ 14,28 GET MDATAEN PICTURE "99/99/99"
      @ 16,28 GET MPROCED PICTURE "@!"
      READ
      CLEAR GETS
   ENDIF
   RESPI="N"
   @ 22,15 SAY "Os dados estao corretos<S/N> ? " GET RESPI PICTURE "!"
   READ
   @ 22,12 SAY "                                             "
   DO WHILE UPPER(RESPI)="N" .AND. ALTER<>"E"
      @ 04,28 GET MMATERIAL PICT "@!"
      @ 06,28 GET MQTDRECEB PICTURE "99999"
      @ 06,61 GET MCLASS PICTURE "@!"
      @ 08,28 GET MUNIDADE PICTURE "@!"
      @ 10,28 GET MVALUNIT PICTURE "999999,999,99"
      @ 12,28 GET MNDOC PICTURE "@!"
      @ 14,28 GET MDATAEN PICTURE "99/99/99"
      @ 16,28 GET MPROCED PICTURE "@!"
      READ
      IF ALTER="A"
         @ 14,61 GET MDATAEN2 PICT "99/99/99"
         @ 18,28 GET MQTDESAIDA
         @ 18,61 GET MVALENT PICTURE "999999,999.99"
         @ 20,28 GET MVALSAL
         READ
      ENDIF
      CLEAR GETS
      @ 22,15 SAY "Os dados estao corretos<S/N> ? " GET RESPI PICTURE "!"
      READ
      @ 22,12 SAY "                                             "
   ENDDO
   IF ALTER<>"A"
      MVALENT=MVALUNIT*MQTDRECEB
      MQTDESAIDA=MQTDRECEB
      MVALSAL=MVALENT
      @ 18,28 GET MQTDESAIDA
      @ 18,61 GET MVALENT PICTURE "999999,999.99"
      @ 20,28 GET MVALSAL PICTURE "999999,999.99"
      CLEAR GETS
   ENDIF
   IF ALTER<>"E"
      IF ALTER<>"A"
         APPEND BLANK
      ENDIF
      USE MATERIAL INDEX INX1
      REPLACE CODMAT   WITH MCODMAT
      REPLACE MATERIAL WITH MMATERIAL
      REPLACE QTDRECEB WITH MQTDRECEB
      REPLACE CLASS WITH MCLASS
      REPLACE VALENT WITH MVALENT
      REPLACE VALSAL WITH MVALSAL
      REPLACE NDOC WITH MNDOC
      REPLACE QTDESAIDA WITH MQTDESAIDA
      REPLACE PROCED WITH MPROCED
      REPLACE DATAEN WITH MDATAEN
      REPLACE VALUNIT WITH MVALUNIT
      REPLACE UNIDADE WITH MUNIDADE
      IF ALTER="A"
         REPLACE DATAEN2 WITH MDATAEN2
      ENDIF
   ENDIF
   @ 22,15 SAY "Quer continuar <S/N> ? " GET CONT  PICTURE "!"
   READ
ENDDO
CLOSE DATABASES
CLEAR
RETURN
******************************
