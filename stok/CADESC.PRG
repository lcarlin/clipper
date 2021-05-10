***************************************
USE ESCOLA INDEX INX2
CLEAR
CONT="S"
DO WHILE UPPER(CONT)="S"
   @ 0,0,24,79 BOX CHR(127)+CHR(176)+chr(127)+CHR(176)+CHR(127)+CHR(176)+CHR(127)+CHR(176)
   SET COLOR TO  N/W
   centra(00,"CADASTRO/MANUTENCAO DE ESCOLAS")
   centra(24,"<F3>-Imprime Codigos De Escolas")
   SET COLOR TO W/N
   STORE SPACE(8) TO MCODE
   @ 04,02 SAY "CODIGO.......:"
   @ 06,02 SAY "ESCOLA.......:"+SPACE(38)
   @ 08,02 SAY "LOCALIDADE...:"+SPACE(42)
   centra(23,"Digite o codigo, <ENTER> p/ a tabela ou <ESC> p/ sair")
   USE ESCOLA INDEX INX2
   DO WHILE EMPTY(MCODE)
      @ 04,17 GET MCODE PICTURE "@!"
      READ
      IF LASTKEY()=27
         CLOSE DATABASES
         CLEAR
         RETURN
      ELSEIF Lastkey()=13
         TABELA(2)
         @ 04,17 GET MCODE PICTURE "@!"
         CLEAR GETS
      ENDIF
   ENDDO
   @ 22,02 clear to 23,78
   ALTER="R"
   SEEK MCODE
   IF FOUND()
      MESCOLA = ESCOLA
      MLOCAL = LOCAL
      @ 06,17 GET MESCOLA PICTURE "@!"
      @ 08,17 GET MLOCAL PICTURE "@!"
      CLEAR GETS
      @ 21,10 SAY "Codigo existente, <R>retorna; <A>altera; <E>exclui ?" GET ALTER PICTURE "!A"
      READ
      @ 21,10 SAY "                                                                 "
      IF ALTER<>"E" .AND. ALTER<>"A"
         LOOP
      ENDIF
      IF ALTER="E"
         CERT="N"
         @ 21,15 SAY "ESTE REGISTRO SERA EXCLUIDO!! TEM CERTEZA <S/N> " GET CERT PICTURE "!A"
         READ
         @ 21,15 SAY "                                                        "
         IF CERT="S"
            DELETE
            PACK
            LOOP
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
      MESCOLA   = SPACE(35)
      MLOCAL  = SPACE(40)
      @ 06,17 GET MESCOLA PICTURE "@!"
      @ 08,17 GET MLOCAL PICTURE "@!"
      READ
      CLEAR GETS
   ENDIF
   RESPI="N"
   @ 21,15 SAY "Os Dados Estao Corretos <S/N> ? " GET RESPI PICT "!"
   READ
   @ 21,15 SAY "                                           "
   DO WHILE UPPER(RESPI)="N" .AND. ALTER<>"E"
      @ 06,17 GET MESCOLA PICTURE "@!"
      @ 08,17 GET MLOCAL PICTURE "@!"
      READ
      CLEAR GETS
      @ 21,15 SAY "Os dados estao corretos<S/N> ? " GET RESPI PICTURE "!"
      READ
      @ 21,15 SAY "                                      "
   ENDDO
   IF ALTER<>"E"
      IF ALTER<>"A"
         APPEND BLANK
      ENDIF
      USE ESCOLA INDEX INX2
      REPLACE ESCOLA WITH MESCOLA
      REPLACE LOCAL WITH MLOCAL
      REPLACE CODESCO WITH MCODE
   ENDIF
   @ 21,15 SAY "Quer continuar <S/N> ? " GET CONT  PICTURE "!"
   READ
ENDDO
CLOSE DATABASES
CLEAR
RETURN
