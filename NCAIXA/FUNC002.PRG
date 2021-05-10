** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE HELP
 
   PARAMETERS pRog, lI, vAri
   SAVE SCREEN TO wTh
   mensagem("Voce esta na tela de Ajuda - Leia com atencao", " ")
   SET COLOR TO W+/R
   @  9,  6 CLEAR TO 21, 79
   @  9,  6 TO 21, 79 DOUBLE
   SET COLOR TO
   @ 22,  0
   mensagem("    ESC ->  Retorna   --   SETAS e PGDN/PGUP ->  Rolam a tela", ;
      " ")
   SELECT 3
   USE EMIH
   INDEX ON PROGRAMA TO EMIHI
   IF ( LastRec() == 0 )
      SET COLOR TO
      mensagem("O ARQUIVO CONTENDO O HELP ESTA VAZIO - TECLE ENTER", ;
         "P")
      SET COLOR TO W+/R
   ENDIF
   lI:= Str(lI, 3)
   vAr:= pRog + vAri
   SEEK vAr
   IF ( EOF() )
      mensagem("AJUDA NAO DISPONIVEL PARA ESTE ITEM - TECLE ENTER", ;
         "P")
   ELSE
      memoedit(cHelp, 10, 8, 20, 77, .F.)
   ENDIF
   InKey(1)
   IF ( LastKey() == K_F9 )
      setcursor(1)
      mensagem("CRIANDO OU ALTERANDO HELP - CONTROL + W GRAVA ALTERACOES", ;
         " ")
      IF ( EOF() )
         APPEND BLANK
         REPLACE pRograma WITH vAr
      ENDIF
      REPLACE cHelp WITH memoedit(cHelp, 10, 8, 20, 77, .T.)
      mensagem(" ", " ")
   ENDIF
   RESTORE SCREEN FROM wTh
   CLOSE
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE IMPBLOQ
 
   RESTORE SCREEN FROM wT1
   CLOSE DATABASES
   USE EMPRESA
   wNome:= nOme
   wCod_Age:= cOd_Age
   wModalid:= mOdalidade
   wNr_Conta:= nR_Conta
   wFlag:= .T.
   CLOSE
   SELECT A
   USE FATURA
   mensagem("IMPRESSAO DE BLOQUETES", "T")
   filtrabloq()
   SELECT B
   USE INSTBLOQ
   IF ( EOF() )
      APPEND BLANK
   ELSE
      GOTO 1
   ENDIF
   wInst1:= iNst1
   wInst2:= iNst2
   wInst3:= iNst3
   wInst4:= iNst4
   wInst5:= iNst5
   @ 14, 10 SAY "INSTRUCAO 1: " GET WINST1
   @ 15, 10 SAY "INSTRUCAO 2: " GET WINST2
   @ 16, 10 SAY "INSTRUCAO 3: " GET WINST3
   @ 17, 10 SAY "INSTRUCAO 4: " GET WINST4
   @ 18, 10 SAY "INSTRUCAO 5: " GET WINST5
   CLEAR GETS
   IF ( alert("Altera instrucoes?", {"Nao", "Sim"}, "/BG") == 2 )
      DO WHILE ( .T. )
         @ 14, 10 SAY "INSTRUCAO 1: " GET WINST1
         @ 15, 10 SAY "INSTRUCAO 2: " GET WINST2
         @ 16, 10 SAY "INSTRUCAO 3: " GET WINST3
         @ 17, 10 SAY "INSTRUCAO 4: " GET WINST4
         @ 18, 10 SAY "INSTRUCAO 5: " GET WINST5
         READ
         IF ( alert("Confirma Instrucoes", {"Sim", "Nao"}, "/BG") == ;
               1 )
            REPLACE iNst1 WITH wInst1
            REPLACE iNst2 WITH wInst2
            REPLACE iNst3 WITH wInst3
            REPLACE iNst4 WITH wInst4
            REPLACE iNst5 WITH wInst5
            EXIT
         ENDIF
      ENDDO
   ENDIF
   CLOSE
   SELECT A
   GOTO TOP
   mensagem("COLOQUE O FORMULARIO PROPRIO E ATIVE A IMPRESSORA", " ")
   wConf:= ;
      alert("Imprime HIFEN de controle sobre picote do Formulario?", ;
      {"Imprime", "Nao Imprime", "Cancela"}, "/BG")
   IF ( wConf == 1 )
      wHifen:= .T.
   ELSEIF ( wConf == 2 )
      wHifen:= .F.
   ELSE
      CLOSE DATABASES
      RETURN
   ENDIF
   DO WHILE ( .NOT.isprinter() )
      alert("Impressora NAO esta pronta - Verifique !", Nil, "/W")
   ENDDO
   mensagem("TECLE <ESC> PARA ABORTAR A IMPRESSAO", " ")
   SET DEVICE TO PRINTER
   setprc(0, 0)
   @  0,  0 SAY ""
   @  0,  0 SAY "0"
   @  0,  0 SAY " "
   IF ( wHifen )
      wConf:= 2
      DO WHILE ( wConf = 2 )
         SET DEVICE TO PRINTER
         IF ( wTbloq = 1 .OR. wTbloq = 2 )
            @  0,  0 SAY " "
            @  0, 65 SAY "=___|"
            @ PRow(),  0 SAY "|___= "
         ELSEIF ( wTbloq == 3 )
            @  0,  0 SAY " "
            @  0, 18 SAY "__|___"
            @ PRow(),  0 SAY " |___ "
            @ PRow(), 100 SAY "_|___= "
            @ PRow(), 121 SAY "_|___= "
         ENDIF
         SET DEVICE TO SCREEN
         wConf:= ;
            alert("O HIFEN esta sobre o picote nos dois lados do formulario?", ;
            {"Sim", "Nao"}, "/BG")
      ENDDO
   ENDIF
   wCont:= 1
   InKey(0.01)
   DO WHILE ( .NOT.EOF() )
      IF ( LastKey() == K_ESC )
         SET DEVICE TO SCREEN
         wConf:= alert("Confirma a Interrupcao da impressao? ", ;
            {"Sim", "Nao"}, "/BG")
         IF ( wConf == 1 )
            RETURN
         ENDIF
      ENDIF
      IF ( ( cOd_Cart != "4" .OR. cApa_Lote = "S" ) .AND. ( cOd_Cart ;
            != "5" .OR. cApa_Lote = "S" ) )
         dbSkip()
         LOOP
      ENDIF
      SET DEVICE TO PRINTER
      wVv:= " "
      wV1:= Transform(vAl_Titulo, "@E 9,999,999,999.99")
      IF ( wTbloq == 1 )
         IF ( wFlag )
            @ PRow() + 5,  0 SAY " "
            wFlag:= .F.
         ELSE
            @ PRow() + 1,  0 SAY " "
         ENDIF
         @ PRow() + 1,  0 SAY " "
         @ PRow(), 60 SAY dT_Venc
         @ PRow() + 4,  2 SAY Date()
         @ PRow(), 12 SAY nR_Doc
         @ PRow(), 31 SAY eSp_Doc
         @ PRow(), 43 SAY aCeite
         @ PRow() + 2, 23 SAY wVv
         @ PRow(), 60 SAY wV1
         IF ( cOd_Mora == 0 )
            wVmora:= mOra
         ELSE
            wVmora:= vAl_Titulo * mOra * 0.01 / 30
         ENDIF
         @ PRow() + 2,  2 SAY "Mora Diaria: " + Transform(wVmora, ;
            "@E 9,999,999,999.99")
         @ PRow() + 1,  2 SAY "Desconto: " + Transform(vAl_Desc, ;
            "@E 9,999,999,999.99")
         @ PRow(), PCol() + 2 SAY "Ate: " + DToC(dT_Desc)
         @ PRow() + 1,  3 SAY ;
            "*****   VALORES EXPRESSOS EM REAL   ***** "
         @ PRow() + 2,  3 SAY wInst1
         @ PRow() + 1,  3 SAY wInst2
         @ PRow() + 1,  3 SAY wInst3
         @ PRow() + 1,  3 SAY wInst4
         @ PRow() + 1,  3 SAY wInst5
         @ PRow() + 1, 10 SAY nOme_Sac
         @ PRow() + 1, 10 SAY eNd_Sac
         @ PRow() + 1, 10 SAY cEp + "-" + sUp_Cep + " " + cIdade + ;
            "/" + eStado + Space(10)
         IF ( nR_Cic != "0000000" )
            IF ( SubStr(nR_Cic, 1, 3) = "000" )
               @ PRow(), PCol() SAY SubStr(nR_Cic, 4, 11) PICTURE ;
                  "@R 999.999.999-99"
            ELSE
               @ PRow(), PCol() SAY nR_Cic PICTURE ;
                  "@R 99.999.999/9999-99"
            ENDIF
         ENDIF
         @ PRow() + 1, 10 SAY nO_Sacador
         @ PRow() + 10,  1 SAY " "
      ELSEIF ( wTbloq == 2 )
         IF ( wHifen )
            @ PRow() + 5,  0 SAY " "
         ELSE
            @ PRow() + 1,  0 SAY " "
         ENDIF
         @ PRow() + 2, 11 SAY wVv
         @ PRow(), 29 SAY DToC(dT_Venc)
         @ PRow(), 53 SAY wVv
         @ PRow(), 70 SAY DToC(dT_Venc)
         @ PRow() + 2,  2 SAY wV1
         @ PRow(), 42 SAY wV1
         @ PRow() + 6, 22 SAY nR_Doc
         @ PRow(), 61 SAY nR_Doc
         @ PRow() + 11, 60 SAY dT_Venc
         @ PRow() + 4,  2 SAY Date()
         @ PRow(), 12 SAY nR_Doc
         @ PRow(), 31 SAY eSp_Doc
         @ PRow(), 43 SAY aCeite
         @ PRow() + 2, 23 SAY wVv
         @ PRow(), 60 SAY wV1
         IF ( cOd_Mora == 0 )
            wVmora:= mOra
         ELSE
            wVmora:= vAl_Titulo * mOra * 0.01 / 30
         ENDIF
         @ PRow() + 2,  2 SAY "Mora Diaria: " + Transform(wVmora, ;
            "@E 9,999,999,999.99")
         @ PRow() + 1,  2 SAY "Desconto: " + Transform(vAl_Desc, ;
            "@E 9,999,999,999.99")
         @ PRow(), PCol() + 2 SAY "Ate: " + DToC(dT_Desc)
         @ PRow() + 1,  3 SAY ;
            "*****   VALORES EXPRESSOS EM REAL   ***** "
         @ PRow() + 2,  3 SAY wInst1
         @ PRow() + 1,  3 SAY wInst2
         @ PRow() + 1,  3 SAY wInst3
         @ PRow() + 1,  3 SAY wInst4
         @ PRow() + 1,  3 SAY wInst5
         @ PRow() + 1, 10 SAY nOme_Sac
         @ PRow() + 1, 10 SAY eNd_Sac
         @ PRow() + 1, 10 SAY cEp + "-" + sUp_Cep + " " + cIdade + ;
            "/" + eStado + Space(10)
         IF ( nR_Cic != "0000000" )
            IF ( SubStr(nR_Cic, 1, 3) = "000" )
               @ PRow(), PCol() SAY SubStr(nR_Cic, 4, 11) PICTURE ;
                  "@R 999.999.999-99"
            ELSE
               @ PRow(), PCol() SAY nR_Cic PICTURE ;
                  "@R 99.999.999/9999-99"
            ENDIF
         ENDIF
         @ PRow() + 1, 10 SAY nO_Sacador
         IF ( wHifen )
            @ PRow() + 6,  1 SAY " "
         ELSE
            @ PRow() + 10,  1 SAY " "
         ENDIF
      ELSEIF ( wTbloq == 3 )
         IF ( wHifen )
            @ PRow() + 6,  9 SAY DToC(dT_Venc)
            @ PRow(), 82 SAY DToC(dT_Venc)
            @ PRow(), 111 SAY DToC(dT_Venc)
            @ PRow(), 128 SAY DToC(dT_Venc)
         ELSE
            @ PRow() + 3,  9 SAY DToC(dT_Venc)
            @ PRow(), 82 SAY DToC(dT_Venc)
            @ PRow(), 111 SAY DToC(dT_Venc)
            @ PRow(), 128 SAY DToC(dT_Venc)
         ENDIF
         @ PRow() + 4,  4 SAY wVv
         @ PRow(), 22 SAY dT_Emis
         @ PRow(), 33 SAY nR_Doc
         @ PRow(), 51 SAY eSp_Doc
         @ PRow(), 63 SAY aCeite
         @ PRow(), 81 SAY nOsso_Nr PICTURE "@R 9999999-9"
         @ PRow(), 104 SAY wVv
         @ PRow() + 2,  1 SAY wV1
         @ PRow(), 47 SAY wVv
         @ PRow(), 81 SAY wV1
         @ PRow(), 102 SAY wV1
         @ PRow(), 119 SAY wV1
         IF ( cOd_Mora == 0 )
            wVmora:= mOra
         ELSE
            wVmora:= vAl_Titulo * mOra * 0.01 / 30
         ENDIF
         @ PRow() + 2, 27 SAY "Mora Diaria: " + Transform(wVmora, ;
            "@E 9,999,999,999.99")
         @ PRow() + 1, 27 SAY "Desconto: " + Transform(vAl_Desc, ;
            "@E 9,999,999,999.99")
         @ PRow(), PCol() + 2 SAY "Ate: " + DToC(dT_Desc)
         @ PRow() + 1, 23 SAY ;
            "*****   VALORES EXPRESSOS EM REAL   ***** "
         @ PRow() + 1, PCol() SAY " "
         @ PRow() + 1, 23 SAY wInst1
         @ PRow() + 1, 23 SAY wInst2
         @ PRow() + 1, 23 SAY wInst3
         @ PRow() + 1, 23 SAY wInst4
         @ PRow() + 1, 23 SAY wInst5
         @ PRow() + 1, 28 SAY nOme_Sac
         @ PRow() + 1, 28 SAY eNd_Sac
         @ PRow() + 1, 28 SAY cEp + "-" + sUp_Cep + " " + cIdade + ;
            "/" + eStado + Space(10)
         IF ( nR_Cic != "0000000" )
            IF ( SubStr(nR_Cic, 1, 3) = "000" )
               @ PRow(), PCol() SAY SubStr(nR_Cic, 4, 11) PICTURE ;
                  "@R 999.999.999-99"
            ELSE
               @ PRow(), PCol() SAY nR_Cic PICTURE ;
                  "@R 99.999.999/9999-99"
            ENDIF
         ENDIF
         @ PRow() + 1,  3 SAY nR_Doc
         @ PRow(), 28 SAY nO_Sacador
         @ PRow(), 102 SAY nR_Doc
         @ PRow(), 123 SAY nR_Doc
         IF ( wHifen )
            @ PRow() + 6,  1 SAY "__ "
            @ PRow(), 120 SAY "__ "
         ELSE
            @ PRow() + 9,  1 SAY "__ "
            @ PRow(), 120 SAY "__ "
         ENDIF
      ENDIF
      SKIP
      IF ( EOF() )
         @ PRow(),  1 SAY "2"
         EXIT
      ENDIF
      IF ( wCont == 1 )
         SET DEVICE TO SCREEN
         mensagem("IMPRESSAO ESTA CORRETA (S/N)? ", "S")
         IF ( wConf = "S" )
            wCont:= 2
         ELSE
            mensagem("VOCE QUER CONTINUAR A IMPRESSAO (S/N)? ", "S")
            IF ( wConf = "N" )
               EXIT
            ENDIF
         ENDIF
      ENDIF
      InKey(0.7)
   ENDDO
   SET FILTER TO
   CLOSE DATABASES
   SET DEVICE TO SCREEN
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE IMPORTA
 
   CLOSE DATABASES
   SELECT 3
   USE CHEQUER
   ZAP
   SELECT 2
   USE FATURAR
   ZAP
   SELECT 1
   USE REG
   ZAP
   RESTORE SCREEN FROM wT1
   mensagem("PREPARA ARQUIVO DE RETORNO", "T")
   precarq("ENTRE COM O ARQUIVO A SER RESTAURADO", "TXT")
   IF ( wArq = Space(8) )
   ELSE
      mensagem("IMPORTANDO O ARQUIVO DE RETORNO!", " ")
      APPEND FROM (wArq) SDF ALL
      GOTO TOP
      IF ( SubStr(cAmpo1, 2, 1) != "2" )
         mensagem("NAO E ARQUIVO DE RETORNO - TECLE ALGO", "P")
      ENDIF
      wNoemp:= SubStr(cAmpo1, 47, 30)
      wDtgrav:= SubStr(cAmpo1, 95, 2) + "/" + SubStr(cAmpo1, 97, 2) ;
         + "/" + SubStr(cAmpo1, 99, 2)
      mensagem("EMPRESA  " + wNoemp + " - RETORNO DE " + wDtgrav, " ")
      DO WHILE ( .NOT.EOF() )
         SELECT 1
         IF ( SubStr(cAmpo1, 1, 1) = "0" .OR. SubStr(cAmpo1, 1, 1) = ;
               "9" )
            SKIP
         ENDIF
         wCampo1:= cAmpo1 + cAmpo2
         wEsp_Doc:= SubStr(cAmpo1, 174, 2)
         IF ( wEsp_Doc = "29" )
            SELECT 3
         ELSE
            SELECT 2
         ENDIF
         APPEND BLANK
         REPLACE sAcado WITH SubStr(wCampo1, 81, 27)
         REPLACE dT_Pag WITH CToD(SubStr(wCampo1, 111, 2) + "/" + ;
            SubStr(wCampo1, 113, 2) + "/" + SubStr(wCampo1, 115, 2))
         REPLACE tIpo_Cic WITH Val(SubStr(wCampo1, 2, 2))
         REPLACE nR_Cic WITH SubStr(wCampo1, 4, 14)
         REPLACE nOsso_Nr WITH SubStr(wCampo1, 63, 8)
         REPLACE cOd_Cart WITH SubStr(wCampo1, 108, 1)
         REPLACE iDent_Ser WITH SubStr(wCampo1, 109, 2)
         REPLACE dT_Ocor WITH CToD(SubStr(wCampo1, 111, 2) + "/" + ;
            SubStr(wCampo1, 113, 2) + "/" + SubStr(wCampo1, 115, 2))
         REPLACE nR_Doc WITH SubStr(wCampo1, 117, 10)
         IF ( SubStr(wCampo1, 147, 6) = "000001" )
            REPLACE dT_Venc WITH "A VISTA"
         ELSEIF ( SubStr(wCampo1, 147, 6) = "000002" )
            REPLACE dT_Venc WITH "C/APRES."
         ELSE
            REPLACE dT_Venc WITH SubStr(wCampo1, 147, 2) + "/" + ;
               SubStr(wCampo1, 149, 2) + "/" + SubStr(wCampo1, 151, 2)
         ENDIF
         REPLACE vAl_Titulo WITH Val(SubStr(wCampo1, 153, 13)) / 100
         REPLACE bAnco_Cob WITH SubStr(wCampo1, 166, 7)
         REPLACE eSp_Doc WITH SubStr(wCampo1, 174, 2)
         REPLACE vAlor_Tar WITH Val(SubStr(wCampo1, 176, 13)) / 100
         REPLACE vAlor_Jur WITH Val(SubStr(wCampo1, 202, 13)) / 100
         REPLACE vAl_Ioc WITH Val(SubStr(wCampo1, 215, 13)) / 100
         REPLACE aBat_Con WITH Val(SubStr(wCampo1, 228, 13)) / 100
         REPLACE dEsc_Con WITH Val(SubStr(wCampo1, 241, 13)) / 100
         REPLACE vAl_Pago WITH Val(SubStr(wCampo1, 254, 13)) / 100
         REPLACE mOra_Pg WITH Val(SubStr(wCampo1, 267, 13)) / 100
         IF ( SubStr(wCampo1, 280, 2) = "00" )
            REPLACE cOd_Mora WITH Val(SubStr(wCampo1, 302, 1))
            REPLACE mOra WITH Val(SubStr(wCampo1, 303, 12)) / 100
            REPLACE vAl_Desc WITH Val(SubStr(wCampo1, 321, 13)) / 100
            REPLACE iNst_Cob WITH Val(SubStr(wCampo1, 334, 4))
            REPLACE nR_Sacador WITH SubStr(wCampo1, 338, 10)
            REPLACE nO_Sacador WITH SubStr(wCampo1, 348, 30)
            REPLACE tIpo_Moeda WITH SubStr(wCampo1, 394, 1)
         ELSE
            REPLACE eRro WITH SubStr(wCampo1, 280, 40)
         ENDIF
         SELECT 1
         SKIP
      ENDDO
      SELECT 2
      GOTO BOTTOM
      IF ( cOd_Cart = " " .AND. nR_Doc = " " .AND. vAl_Titulo = 0 )
         DELETE
         PACK
      ENDIF
      mensagem(" ", " ")
      CLOSE DATABASES
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE IMPTXT
 
   RESTORE SCREEN FROM wT1
   wNo_Arq:= Space(8)
   wPos_Ini:= 0
   wPos_Fin:= 0
   wDec:= 0
   wInfo:= Space(37)
   wCpo1:= Space(400)
   mensagem("I M P O R T A N D O  A R Q U I V O  T E X T O", "T")
   mensagem("INFORMACAO QUE NAO CONSTE NO ARQUIVO DEIXE EM BRANCO", ;
      " ")
   precarq("ENTRE COM O NOME DO ARQUIVO? ", "TXT")
   IF ( wArq = Space(8) )
   ELSE
      mensagem("VOCE JA ENTROU COM O LAY-OUT DO SEU ARQUIVO PARA IMPORTACAO (S/N)?", ;
         "N")
      IF ( wConf = "N" )
         USE LAYOUT
         GOTO 1
         FOR i:= 1 TO 31
            wPos_Ini:= pOs_Ini
            wPos_Fin:= pOs_Fin
            wDec:= dEc_Cam
            wInfo:= cOnt_Campo
            @ 14,  3 SAY "CONTEUDO"
            @ 14, 46 SAY "POSICAO INICIAL"
            @ 14, 61 SAY "/FINAL"
            @ 14, 68 SAY "QT.DECIMAIS"
            @ 16,  3 SAY iNformacao
            @ 16, 53 GET WPOS_INI PICTURE "999"
            @ 16, 62 GET WPOS_FIN PICTURE "999"
            @ 16, 71 GET WDEC PICTURE "9"
            READ
            IF ( wPos_Ini = 0 .AND. wPos_Fin = 0 )
               @ 18,  3 SAY "DIGITE A INFORMACAO SE EXISTIR? " GET ;
                  WINFO
               READ
               @ 18,  3 CLEAR TO 14, 78
            ENDIF
            REPLACE cOnt_Campo WITH wInfo
            REPLACE pOs_Ini WITH wPos_Ini
            REPLACE pOs_Fin WITH wPos_Fin
            REPLACE dEc_Cam WITH wDec
            SKIP
         NEXT
      ENDIF
      CLOSE
      SELECT A
      USE REG
      ZAP
      mensagem("CONFIRMA IMPORTACAO DO ARQUIVO", "S")
      IF ( wConf = "N" )
      ELSE
         mensagem("AGUARDE PROCESSANDO A IMPORTACAO DO ARQUIVO!!!", ;
            " ")
         APPEND FROM (wArq) SDF ALL
         PRIVATE wTi_Cam[33], wTam_Cam[33], wPini[33], wPfin[33], ;
            wConte[33], wCampol[33]
         PRIVATE wDeci[33]
         SELECT C
         USE LAYOUT
         FOR i:= 1 TO 31
            wTi_Cam[ i ]:= tIpo_Cam
            wTam_Cam[ i ]:= tAm_Cam
            wPini[ i ]:= pOs_Ini
            wPfin[ i ]:= pOs_Fin
            wConte[ i ]:= cOnt_Campo
            wDeci[ i ]:= dEc_Cam
            SKIP
         NEXT
         SELECT A
         USE REG
         SELECT C
         USE FATURA
         GOTO BOTTOM
         COPY STRUCTURE TO IMPORTA
         USE IMPORTA
         SELECT A
         DO WHILE ( .NOT.EOF() )
            FOR i:= 1 TO 31
               SELECT A
               wCpo1:= cAmpo1 + cAmpo2
               IF ( wTi_Cam[ i ] = "C" )
                  IF ( wPfin[ i ] = 0 .AND. wPini[ i ] = 0 )
                     wCampol[ i ]:= SubStr(wConte[ i ], 1, ;
                        wTam_Cam[ i ])
                  ELSE
                     wCampol[ i ]:= SubStr(wCpo1, wPini[ i ], ;
                        wPfin[ i ] - wPini[ i ] + 1)
                  ENDIF
               ELSEIF ( wTi_Cam[ i ] = "N" )
                  IF ( wPfin[ i ] = 0 .AND. wPini[ i ] = 0 )
                     wCampol[ i ]:= Val(SubStr(wConte[ i ], 1, ;
                        wTam_Cam[ i ]))
                  ELSE
                     wCampol[ i ]:= Val(SubStr(wCpo1, wPini[ i ], ;
                        wPfin[ i ] - wPini[ i ] + 1))
                     wDec:= 10 ^ wDeci[ i ]
                     wCampol[ i ]:= wCampol[ i ] / wDec
                  ENDIF
               ELSEIF ( wTi_Cam[ i ] = "D" )
                  IF ( wPfin[ i ] = 0 .AND. wPini[ i ] = 0 )
                     wCampol[ i ]:= CToD(SubStr(wConte[ i ], 1, ;
                        wTam_Cam[ i ]))
                  ELSE
                     wCampol[ i ]:= CToD(SubStr(wCpo1, wPini[ i ], ;
                        2) + "/" + SubStr(wCpo1, wPini[ i ] + 2, 2) ;
                        + "/" + SubStr(wCpo1, wPini[ i ] + 4, 2))
                  ENDIF
               ENDIF
            NEXT
            SELECT C
            APPEND BLANK
            REPLACE iMporta->nOsso_Nr WITH wCampol[ 1 ]
            REPLACE iMporta->cOd_Tarifa WITH wCampol[ 2 ]
            REPLACE iMporta->cOd_Reapr WITH wCampol[ 3 ]
            REPLACE iMporta->cOd_Cart WITH wCampol[ 4 ]
            REPLACE iMporta->iDent_Ser WITH wCampol[ 5 ]
            REPLACE iMporta->nR_Doc WITH wCampol[ 6 ]
            REPLACE iMporta->dT_Venc WITH wCampol[ 7 ]
            REPLACE iMporta->vAl_Titulo WITH wCampol[ 8 ]
            REPLACE iMporta->bAnco_Cob WITH wCampol[ 9 ]
            REPLACE iMporta->eSp_Doc WITH wCampol[ 10 ]
            REPLACE iMporta->aCeite WITH wCampol[ 11 ]
            REPLACE iMporta->dT_Emis WITH wCampol[ 12 ]
            REPLACE iMporta->iNst_Cob WITH wCampol[ 13 ]
            REPLACE iMporta->cOd_Mora WITH wCampol[ 14 ]
            REPLACE iMporta->mOra WITH wCampol[ 15 ]
            REPLACE iMporta->dT_Desc WITH wCampol[ 16 ]
            REPLACE iMporta->vAl_Desc WITH wCampol[ 17 ]
            REPLACE iMporta->vAl_Ioc WITH wCampol[ 18 ]
            REPLACE iMporta->aBatimento WITH wCampol[ 19 ]
            REPLACE iMporta->tIpo_Cic WITH wCampol[ 20 ]
            REPLACE iMporta->nR_Cic WITH strzero(Val(wCampol[ 21 ]), ;
               14)
            vV:= nR_Cic
            REPLACE iMporta->nOme_Sac WITH wCampol[ 22 ]
            REPLACE iMporta->sUp_Cep WITH wCampol[ 23 ]
            REPLACE iMporta->eNd_Sac WITH wCampol[ 24 ]
            REPLACE iMporta->cEp WITH wCampol[ 25 ]
            REPLACE iMporta->cIdade WITH wCampol[ 26 ]
            REPLACE iMporta->eStado WITH wCampol[ 27 ]
            REPLACE iMporta->nR_Sacador WITH wCampol[ 28 ]
            REPLACE iMporta->nO_Sacador WITH wCampol[ 29 ]
            REPLACE iMporta->pRazo_Prot WITH wCampol[ 30 ]
            REPLACE iMporta->tIpo_Moeda WITH wCampol[ 31 ]
            SELECT A
            SKIP
         ENDDO
         CLOSE DATABASES
         SELECT 1
         USE IMPORTA
         SELECT 2
         USE FATURA
         ZAP
         wNr_Lote:= 900
         SELECT 1
         GOTO TOP
         wEsp_Doc:= eSp_Doc
         wIdent_Ser:= iDent_Ser
         wCod_Cart:= cOd_Cart
         wTipo_Moed:= tIpo_Moeda
         wCod_Tar:= cOd_Tarifa
         SELECT 2
         APPEND BLANK
         REPLACE eSp_Doc WITH wEsp_Doc
         REPLACE iDent_Ser WITH wIdent_Ser
         REPLACE cOd_Cart WITH wCod_Cart
         REPLACE tIpo_Moeda WITH wTipo_Moed
         REPLACE cOd_Tarifa WITH wCod_Tar
         REPLACE nR_Lote WITH wNr_Lote
         REPLACE cApa_Lote WITH "S"
         SELECT 1
         PRIVATE wCampo[35]
         DO WHILE ( .NOT.EOF() )
            IF ( wEsp_Doc = eSp_Doc .AND. wIdent_Ser = iDent_Ser ;
                  .AND. wCod_Cart = cOd_Cart .AND. wTipo_Moed = ;
                  tIpo_Moeda .AND. wCod_Tar = cOd_Tarifa )
               wCampo[ 1 ]:= iMporta->nOsso_Nr
               wCampo[ 2 ]:= iMporta->cOd_Tarifa
               wCampo[ 3 ]:= iMporta->cOd_Reapr
               wCampo[ 4 ]:= iMporta->cOd_Cart
               wCampo[ 5 ]:= iMporta->iDent_Ser
               wCampo[ 6 ]:= iMporta->nR_Doc
               wCampo[ 7 ]:= iMporta->dT_Venc
               wCampo[ 8 ]:= iMporta->vAl_Titulo
               wCampo[ 9 ]:= iMporta->bAnco_Cob
               wCampo[ 10 ]:= iMporta->eSp_Doc
               wCampo[ 11 ]:= iMporta->aCeite
               wCampo[ 12 ]:= iMporta->dT_Emis
               wCampo[ 13 ]:= iMporta->iNst_Cob
               wCampo[ 14 ]:= iMporta->cOd_Mora
               wCampo[ 15 ]:= iMporta->mOra
               wCampo[ 16 ]:= iMporta->dT_Desc
               wCampo[ 17 ]:= iMporta->vAl_Desc
               wCampo[ 18 ]:= iMporta->vAl_Ioc
               wCampo[ 19 ]:= iMporta->aBatimento
               wCampo[ 20 ]:= iMporta->tIpo_Cic
               wCampo[ 21 ]:= iMporta->nR_Cic
               wCampo[ 22 ]:= iMporta->nOme_Sac
               wCampo[ 23 ]:= iMporta->sUp_Cep
               wCampo[ 24 ]:= iMporta->eNd_Sac
               wCampo[ 25 ]:= iMporta->cEp
               wCampo[ 26 ]:= iMporta->cIdade
               wCampo[ 27 ]:= iMporta->eStado
               wCampo[ 28 ]:= iMporta->nR_Sacador
               wCampo[ 29 ]:= iMporta->nO_Sacador
               wCampo[ 30 ]:= iMporta->pRazo_Prot
               SELECT 2
               APPEND BLANK
               REPLACE fAtura->nOsso_Nr WITH wCampo[ 1 ]
               REPLACE fAtura->cOd_Tarifa WITH wCampo[ 2 ]
               REPLACE fAtura->cOd_Reapr WITH wCampo[ 3 ]
               REPLACE fAtura->cOd_Cart WITH wCampo[ 4 ]
               REPLACE fAtura->iDent_Ser WITH wCampo[ 5 ]
               REPLACE fAtura->nR_Doc WITH wCampo[ 6 ]
               REPLACE fAtura->dT_Venc WITH wCampo[ 7 ]
               REPLACE fAtura->vAl_Titulo WITH wCampo[ 8 ]
               REPLACE fAtura->bAnco_Cob WITH wCampo[ 9 ]
               REPLACE fAtura->eSp_Doc WITH wCampo[ 10 ]
               REPLACE fAtura->aCeite WITH wCampo[ 11 ]
               REPLACE fAtura->dT_Emis WITH wCampo[ 12 ]
               REPLACE fAtura->iNst_Cob WITH wCampo[ 13 ]
               REPLACE fAtura->cOd_Mora WITH wCampo[ 14 ]
               REPLACE fAtura->mOra WITH wCampo[ 15 ]
               REPLACE fAtura->dT_Desc WITH wCampo[ 16 ]
               REPLACE fAtura->vAl_Desc WITH wCampo[ 17 ]
               REPLACE fAtura->vAl_Ioc WITH wCampo[ 18 ]
               REPLACE fAtura->aBatimento WITH wCampo[ 19 ]
               REPLACE fAtura->tIpo_Cic WITH wCampo[ 20 ]
               REPLACE fAtura->nR_Cic WITH wCampo[ 21 ]
               REPLACE fAtura->nOme_Sac WITH wCampo[ 22 ]
               REPLACE fAtura->sUp_Cep WITH wCampo[ 23 ]
               REPLACE fAtura->eNd_Sac WITH wCampo[ 24 ]
               REPLACE fAtura->cEp WITH wCampo[ 25 ]
               REPLACE fAtura->cIdade WITH wCampo[ 26 ]
               REPLACE fAtura->eStado WITH wCampo[ 27 ]
               REPLACE fAtura->nR_Sacador WITH wCampo[ 28 ]
               REPLACE fAtura->nO_Sacador WITH wCampo[ 29 ]
               REPLACE fAtura->pRazo_Prot WITH wCampo[ 30 ]
               REPLACE fAtura->nR_Lote WITH wNr_Lote
               REPLACE fAtura->tIpo_Moeda WITH wTipo_Moed
               REPLACE fAtura->cApa_Lote WITH "N"
            ELSE
               wNr_Lote:= nR_Lote + 1
               SELECT 1
               wEsp_Doc:= eSp_Doc
               wIdent_Ser:= iDent_Ser
               wCod_Cart:= cOd_Cart
               wTipo_Moed:= tIpo_Moeda
               wCod_Tar:= cOd_Tarifa
               SELECT 2
               APPEND BLANK
               REPLACE eSp_Doc WITH wEsp_Doc
               REPLACE iDent_Ser WITH wIdent_Ser
               REPLACE cOd_Cart WITH wCod_Cart
               REPLACE tIpo_Moeda WITH wTipo_Moed
               REPLACE cOd_Tarifa WITH wCod_Tar
               REPLACE nR_Lote WITH wNr_Lote
               REPLACE cApa_Lote WITH "S"
               SELECT 1
               LOOP
            ENDIF
            SELECT 1
            SKIP
         ENDDO
         mensagem(" ", " ")
         CLOSE DATABASES
      ENDIF
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE INSERTDISK
 
   alerta(15, 30, "Coloque o disco # " + LTrim(Str(wDiskno)) + ;
      " no drive " + wDrive + ".", {" OK "})
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE LECHQ
 
   SELECT 1
   wFone:= SubStr(nOme_Sac, 30, 8)
   wNbanco:= SubStr(eNd_Sac, 1, 20)
   wCodages:= SubStr(eNd_Sac, 21, 4)
   wNage:= SubStr(eNd_Sac, 25, 16)
   wNome_Sac:= SubStr(nOme_Sac, 1, 28)
   wCod_Reapr:= cOd_Reapr
   wNr_Doc:= nR_Doc
   wDt_Venc:= dT_Venc
   wVal_Tit:= vAl_Titulo
   wDt_Emis:= dT_Emis
   wNra_Lote:= nR_Lote
   wCapa_Lote:= cApa_Lote
   IF ( wCapa_Lote = "S" )
      wSoma:= wVal_Tit
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE LEEMP
 
   SELECT 1
   wNome:= nOme
   wCod_Age:= cOd_Age
   wModalid:= mOdalidade
   wNr_Conta:= SubStr(nR_Conta, 2, 7)
   wUlt_Mov:= dT_Ult_Mov
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE LEFAT
 
   SELECT 1
   wNosso_Nr:= nOsso_Nr
   wCod_Tarif:= cOd_Tarifa
   wCod_Reapr:= cOd_Reapr
   wCod_Cart:= cOd_Cart
   wIdent_Ser:= iDent_Ser
   wNr_Doc:= nR_Doc
   wDt_Venc:= dT_Venc
   wVal_Tit:= vAl_Titulo
   wBanco_Cob:= bAnco_Cob
   wEsp_Doc:= eSp_Doc
   wAceite:= aCeite
   wDt_Emis:= dT_Emis
   wInst_Cob:= iNst_Cob
   wCod_Mora:= cOd_Mora
   wMora:= mOra
   wDt_Desc:= dT_Desc
   wVal_Desc:= vAl_Desc
   wVal_Ioc:= vAl_Ioc
   wTipo_Cic:= tIpo_Cic
   IF ( tIpo_Cic == 1 )
      wNr_Cic:= SubStr(nR_Cic, 4, 9) + "0000" + SubStr(nR_Cic, 13, 2)
   ELSE
      wNr_Cic:= "0" + nR_Cic
   ENDIF
   wNome_Sac:= nOme_Sac
   wSup_Cep:= sUp_Cep
   wEnd_Sac:= eNd_Sac
   wCep:= cEp
   wCidade:= cIdade
   wEstado:= eStado
   wNo_Sacado:= nO_Sacador
   wPrazo_Pro:= pRazo_Prot
   wTipo_Moed:= tIpo_Moeda
   wNra_Lote:= nR_Lote
   wCapa_Lote:= cApa_Lote
   IF ( wCapa_Lote = "S" )
      wSoma:= wVal_Tit
   ENDIF
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MANUTEN
 
   LOCAL Local1, Local2
   Local1:= wMode:= 1
   Local2:= {}
   wOpa:= 1
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem(" M E N U   D E   M A N U T E N C A O", "T")
      @  8,  5, 10, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @ 12, 23, 14, 56 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "   FAZ COPIA DE SEGURANCA    "
      @ 17,  8 PROMPT "  RESTAURA COPIA SEGURANCA   "
      @ 13, 26 PROMPT "    IMPORTA ARQUIVO TEXTO     "
      @  9, 44 PROMPT "  CHECAGEM DO PADRAO CNAB    "
      @ 17, 44 PROMPT "    VOLTA MENU ANTERIOR      "
      MENU TO wOpa
      DO CASE
      CASE wOpa = 1
         RESTORE SCREEN FROM wT1
         mensagem("C O P I A   D E   S E G U R A N C A", "T")
         asize(Local2, 5)
         Local2[ 1 ]:= "FATURA.DBF"
         Local2[ 2 ]:= "CHEQUE.DBF"
         Local2[ 3 ]:= "FATURAR.DBF"
         Local2[ 4 ]:= "CHEQUER.DBF"
         Local2[ 5 ]:= "EMPRESA.DBF"
         Local1:= syssave1(1, Local2)
         IF ( Local1 != 0 .AND. Local1 != 99 )
            mensagem("OPERACAO DE BACKUP COM ERRO " + ;
               LTrim(Str(Local1)), "P")
            RETURN
         ELSEIF ( Local1 != 99 )
            mensagem("BACKUP COM SUCESSO!! - REINICIA ARQUIVO DE COBRANCA (S/N)?", ;
               "S")
            IF ( wConf = "S" )
               USE FATURA
               ZAP
               USE CHEQUE
               ZAP
            ENDIF
         ENDIF
      CASE wOpa = 2
         RESTORE SCREEN FROM wT1
         mensagem("R E S T A U R A   C O P I A  D E  S E G U R A N C A", ;
            "T")
         Local1:= syssave(2, Local2)
         IF ( Local1 != 0 .AND. Local1 != 99 )
            mensagem("OPERACAO DE BACKUP COM ERRO " + ;
               LTrim(Str(Local1)), "P")
         ENDIF
      CASE wOpa = 3
         imptxt()
      CASE wOpa = 4
         vercnab()
      CASE wOpa = 5 .OR. wOpa = 0
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MENSAGEM( Arg1, Arg2 )
 
   PUBLIC wConf
   IF ( ISNIL( Arg2 ) )
      wConf:= " "
   ELSE
      wConf:= Arg2
   ENDIF
   Arg1:= "  " + alltrim(Arg1) + "  "
   wTam:= Len(Arg1) / 2
   SET COLOR TO W+
   IF ( wConf = "T" )
      SET COLOR TO BG
      @  6,  1 TO  6, 78 DOUBLE
      SET COLOR TO
      @  6, 40 - wTam SAY Arg1
      SET COLOR TO
   ELSE
      SET COLOR TO W+/RB
      @ 23,  0
      @ 23, 40 - wTam SAY Arg1
      SET COLOR TO
      DO CASE
      CASE wConf = " "
         SET COLOR TO
         RETURN
      CASE wConf $ "SNB"
         SET COLOR TO RB+
         IF ( wConf = "B" )
            wConf:= " "
         ENDIF
         @ 23, 42 + wTam GET WCONF PICTURE "@!" VALID wConf $ "SN"
         READ
         SET COLOR TO
      CASE wConf $ "F"
         SET COLOR TO RB+
         wConf:= " "
         @ 23, 42 + wTam GET WCONF PICTURE "@!" VALID wConf $ "SNE"
         READ
         SET COLOR TO
      CASE wConf $ "PE"
         InKey(0)
      ENDCASE
      @ 23,  0 CLEAR TO 23, 79
      SET COLOR TO
      RETURN
   ENDIF
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MENUCAD
 
   wOpa:= 1
   CLOSE DATABASES
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      mensagem(" M E N U   D E   C A D A S T R O ", "T")
      @  8,  5, 10, 38 BOX wMold
      @ 12,  5, 14, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 12, 41, 14, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "     DADOS DA EMPRESA        "
      @ 13,  8 PROMPT "    F  A  T  U  R  A  S      "
      @ 17,  8 PROMPT "    C  H  E  Q  U  E  S      "
      @  9, 44 PROMPT "  ALTERA VALOR E DATA GLOBAL "
      @ 13, 44 PROMPT "    PREENCHE NOSSO NUMERO    "
      @ 17, 44 PROMPT "    VOLTA MENU ANTERIOR      "
      MENU TO wOpa
      PUBLIC wMod, wAltexc, wAcao
      DO CASE
      CASE wOpa = 1
         SELECT 1
         USE EMPRESA
         pgera1()
      CASE wOpa = 2
         SELECT 1
         USE FATURA
         wMod:= "FAT"
         wNomemod:= "CADASTRO DE FATURAS "
         wAltexc:= "SS"
         pcaplote()
      CASE wOpa = 3
         SELECT 1
         USE CHEQUE
         wMod:= "CHQ"
         wNomemod:= "CADASTRO DE CHEQUES "
         pcaplote()
      CASE wOpa = 4
         altvalor()
      CASE wOpa = 5
         preenchenr()
      CASE wOpa = 6 .OR. wOpa = 0
         RETURN
      ENDCASE
   ENDDO
   RETURN
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE MOVIMENTO
 
   DO WHILE ( .T. )
      mensagem("Para ver mais instrucoes sobre o sistema - Tecle F1 ", ;
         " ")
      mEns:= " "
      tone(300, 1)
      setcursor(0)
      tEcla:= InKey(0)
      tEcla:= IIF( tEcla > 256, tEcla - 256, tEcla )
      setcursor(1)
      IF ( LastRec() = 0 .AND. tEcla != -1 .AND. tEcla != -30 .AND. ;
            tEcla != -9 .AND. tEcla != 27 .AND. tEcla != 28 )
         mensagem("ARQUIVO VAZIO... SO PERMITE INCLUSAO!! ", "P")
         RETURN
      ENDIF
      DO CASE
      CASE tEcla = 27
         IF ( used() )
            SET FILTER TO
         ENDIF
         wFiltra:= .F.
         RETURN
      CASE tEcla = 1
         GOTO TOP
      CASE tEcla = 6
         GOTO BOTTOM
      CASE tEcla = 3
         SKIP
         IF ( EOF() )
            mensagem("VOCE ESTA NO FIM DO ARQUIVO", " ")
            tone(2000, 3)
            InKey(1)
            SKIP -1
         ENDIF
      CASE tEcla = 18
         IF ( .NOT.BOF() )
            SKIP -1
         ELSE
            mensagem("VOCE ESTA NO INICIO DO ARQUIVO", " ")
            tone(2000, 3)
            InKey(1)
         ENDIF
      CASE tEcla = -1
         mEns:= "INCLUSAO - "
         RETURN
      CASE tEcla = -2
         mEns:= "ALTERACAO - "
         RETURN
      CASE tEcla = -8
         mEns:= "EXCLUSAO - "
         RETURN
      CASE tEcla = -9
         wConfig:= .NOT.wConfig
         regua()
         LOOP
      CASE tEcla = 28
         help("PROC001", 188, "TECLA")
         LOOP
      OTHERWISE
         LOOP
      ENDCASE
      ZERA&WMOD()
      LE&WMOD()
      IF ( wMod = "FAT" .OR. wMod = "CHQ" )
         IF ( wCapa_Lote = "S" )
            GET&WMOD()
         ELSE
            GETC&WMOD()
         ENDIF
      ELSE
         GET&WMOD()
      ENDIF
      CLEAR GETS
      LOOP
   ENDDO
 
** Procedure Recovered By [O Cors rio(TM)] **
PROCEDURE NEWDISK
 
   LOCAL Local1:= wDelcnt:= wErrorcode:= 0, Local2:= {}
   setint24(.T.)
   DO WHILE ( .T. )
      fclose(fcreate(wBackfile))
      wErrorcode:= getint24()
      IF ( wErrorcode = 1 .OR. wErrorcode = 3 )
         IF ( wErrorcode == 1 )
            alert("Disco esta protegido !!! - Verifique...", Nil, ;
               "/BG")
         ELSE
            alert("Disco nao esta pronto - Verifique!!!", Nil, "/BG")
         ENDIF
         IF ( InKey(0) != K_ESC )
            LOOP
         ELSE
            wRet_Value:= 12
            EXIT
         ENDIF
      ENDIF
      IF ( wErrorcode == 13 )
         wConf:= alert("Disco nao formatado, Formata? ", {"Sim", ;
            "Nao"}, "/BG")
         IF ( wConf == 1 )
            IF ( file("FORMAT.COM") .OR. file("FORMAT.EXE") .OR. ;
                  file("FORMAT.BAT") .AND. .NOT.Empty(wDrive) )
               SAVE SCREEN
               CLEAR SCREEN
               CLEAR GETS
               alert("EXECUTANDO A FORMATACAO DO DISCO ", Nil, "/BG")
               RUN "FORMAT &WDRIVE"
               RESTORE SCREEN
            ELSE
               alert("Programa Format nao encontrado ", Nil, "/BG")
               KEYBOARD Chr(27)
               wRet_Value:= 11
               EXIT
            ENDIF
         ELSE
            LOOP
         ENDIF
      ELSEIF ( wErrorcode > 0 )
         alert("ERRO FATAL! - PRESSIONE UMA TECLA PARA ABORTAR.", ;
            Nil, "/BG")
         wRet_Value:= 12
      ELSE
         wDelcnt:= adir(wDrive + "*.*")
         IF ( wDelcnt > 1 )
            IF ( alerta(15, 30, ;
                  "Apaga os Arquivos do DISQUETE no drive " + ;
                  wDrive, {"Apaga", "Nao"}) == 1 )
               asize(Local2, wDelcnt)
               adir(wDrive + "*.*", Local2)
               FOR Local1:= 1 TO wDelcnt
                  IF ( Local2[ Local1 ] != "COMMAND.COM" )
                     ERASE (wDrive + Local2[ Local1 ])
                  ENDIF
               NEXT
            ENDIF
         ENDIF
         EXIT
      ENDIF
   ENDDO
   setint24(.F.)
   RETURN
 
** Function Recovered By [O Cors rio(TM)] **
FUNCTION OPENSOURCE
 
   wSourcedt:= filedate(wSource)
   wSourceti:= filetime(wSource)
   IF ( Empty(wSourcedt) .OR. Empty(wSourceti) )
      alert("ERRO VERIFICADO " + wSource + "Arquivo ", Nil, "/BG")
      wRet_Value:= 3
      RETURN .F.
   ENDIF
   wShandle:= fopen(wSource)
   IF ( ferror() > 0 )
      alert("ERRO Fatal! Nao pode abrir o arquivo  " + wSource, Nil, ;
         "/BG")
      wRet_Value:= 2
      RETURN .F.
   ENDIF
   wTotal:= fseek(wShandle, 0, 2)
   wRemaining:= wTotal
   fseek(wShandle, 0)
   RETURN .T.
 
** Function Recovered By [O Cors rio(TM)] **
STATIC FUNCTION OPENTARGET
 
   wThandle:= fcreate(wTarget)
   IF ( ferror() > 0 )
      alert("ERRO Fatal! Nao criou o arquivo " + wTarget, Nil, "/BG")
      wRet_Value:= 4
      RETURN .F.
   ENDIF
   RETURN .T.
 
