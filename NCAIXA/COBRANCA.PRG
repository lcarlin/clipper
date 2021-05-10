** Procedure Recovered By [O Cors rio(TM)] **
 
   STATIC Static1:= 0, Static2:= {{""}, {""}}
   SET DATE BRITISH
   SET SCOREBOARD OFF
   SET CONFIRM OFF
   SET DELETED ON
   SET EXACT OFF
   tEcla:= 0
   wSist:= "SISTEMA DE ENTRADA DE DADOS DA COBRANCA "
   tela()
   mensagem("PARA VER AS INSTRUCOES (MANUAL) SOBRE O SISTEMA - TECLE F1 ", ;
      " ")
   SAVE SCREEN TO wT1
   pcria()
   wConfig:= .T.
   wConsiste:= .T.
   wOp1:= 0
   mEns:= " "
   wOpa:= 0
   wFiltra:= .F.
   wNomemod:= " "
   wAltexc:= "SS"
   PUBLIC wMod
   SELECT 1
   USE EMPRESA
   GOTO BOTTOM
   IF ( nR_Conta = Space(5) )
      pgera1()
   ENDIF
   GOTO 1
   zeraemp()
   leemp()
   CLOSE
   SELECT 5
   USE ALOTE
   PUBLIC wNr_Lote, wNr_Lotec
   wNr_Lote:= nR_Lote + 1
   wNr_Lotec:= nR_Lotec + 1
   DO WHILE ( .T. )
      RESTORE SCREEN FROM wT1
      SET MESSAGE TO 23 CENTER
      @ 23,  0
      mensagem(" M E N U   P R I N C I P A L  ", "T")
      wMold:= "ÚÄ¿³ÙÄÀ³ "
      @  8,  5, 10, 38 BOX wMold
      @ 12,  5, 14, 38 BOX wMold
      @ 16,  5, 18, 38 BOX wMold
      @  8, 41, 10, 74 BOX wMold
      @ 12, 41, 14, 74 BOX wMold
      @ 16, 41, 18, 74 BOX wMold
      @  9,  8 PROMPT "      C A D A S T R O       " MESSAGE ;
         "CADASTRO DE EMPRESAS, FATURAS E CHEQUES "
      @ 13,  8 PROMPT " PREPARA ARQUIVO DE RETORNO " MESSAGE ;
         "PEGA ARQUIVO DE RETORNO (TXT) E TRANSFORMA EM DBF - PARA EMISSAO RELATORIOS"
      @ 17,  8 PROMPT "  GERA ARQUIVO PARA NC-NB   " MESSAGE ;
         "GERA ARQUIVO (TXT) NO PADRAO CNAB A SER ENVIADO PARA NC-NB"
      @  9, 44 PROMPT "    M A N U T E N C A O     " MESSAGE ;
         "FAZ BACKUP E IMPORTA ARQUIVO TXT PARA GERAR ARQUIVO NO PADRAO CNAB"
      @ 13, 44 PROMPT "    R E L A T O R I O S     " MESSAGE ;
         "IMPRIME RELATORIOS PARA CONFERENCIA DAS ENTRADAS E DO RETORNO"
      @ 17, 44 PROMPT " VOLTA SISTEMA OPERACIONAL  "
      SET WRAP ON
      MENU TO wOpa
      DO CASE
      CASE wOpa = 1
         menucad()
      CASE wOpa = 2
         importa()
      CASE wOpa = 3
         exporta()
      CASE wOpa = 4
         manuten()
      CASE wOpa = 5
         relat()
      CASE wOpa = 6 .OR. wOpa = 0
         CLOSE DATABASES
         USE FATURA
         PACK
         USE CHEQUE
         PACK
         CLOSE DATABASES
         CLEAR SCREEN
         CLEAR GETS
         QUIT
      ENDCASE
   ENDDO
   RETURN
