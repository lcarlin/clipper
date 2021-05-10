**********************************************
*
*
*
*
*

SELE 1
 USE MATERIAL INDEX INX1
SELE 2
 USE MOVIME INDEX INX3
SELE 3
 USE MOVIME INDEX INX4
GOTO TOP
DO WHILE .T.
   clear
   SELE 2
   goto top
   @ 0,0,24,79 BOX "°°°°"
   SET COLOR TO N/W
   centra(00,"EMISSŽO DE RELATORIOS")
   SET COLOR TO W/N
   MCODMAT=SPACE(15)
   @ 04,12 to 08,67 DOUBLE
   @ 11,19 clear to 17,40
   centra(05,"Entre c/ o Codigo do Material, <ENTER> p/  a tabela ou")
   centra(06, "<ESC> p/ sair")
   do while empty(mcodmat)
      @ 07,25 GET MCODMAT PICTURE "@!"
      READ
      IF MCODMAT=SPACE(15) .and. lastkey()=13
         select 1
         tabela(1)
         @ 07,25 GET MCODMAT PICTURE "@!"
      elseif lastkeY()=27
         CLOSE DATABASES
         CLEAR
         RETURN
      endif
   enddo
   select 2
   SEEK MCODMAT
   IF .NOT. FOUND()
      centra(10,"Material n„o cadastrado")
      centra(11,"Ou sem baixas; tecle <ENTER>")
      INKEY (0)
      @ 10,09 CLEAR TO 12,60
      LOOP
   ENDIF
   IMP="S"
   @ 09,10 SAY "Material : " + material
   @ 11,10 SAY "Imprime Relatorio <S/N> " GET IMP PICT "!"
   READ
   IF IMP="S"
       IF ISPRINTER()
         set color to w*/n
          centra(15,"Imprimindo...")
          set color to
          SET CONS OFF
          SET DEVICE TO PRINTER
          MTOT=0
          @ 00,49 SAY "Relatorio de Baixas"
          PAG=1
          LIN=2
          SELE 1
          locate for CODMAT=MCODMAT
          SEEK MCODMAT
          @ 02,03 SAY "PAG. "+STR(PAG,3,0)
          @ LIN + 1,05 SAY "Material: " + RTRIM(MATERIAL)
          @ LIN + 1,70 SAY "Classificacao : "+class
          @ LIN + 1,100 SAY "Uni: " + RTRIM(UNIDADE)
          @ LIN + 2,05 SAY "Qtd. Entreg: "+ALLTRIM(STR(QTDRECEB,5,0))
          @ LIN + 2,30 SAY "Val. Receb: "
          @ LIN + 2,43 SAY VALENT PICT "999999,999.99"
          @ LIN + 2,75 SAY "Val. Unit.: "
          @ LIN + 2,88 SAY VALUNIT PICT "999999,999.99"
          @ LIN + 3,05 SAY "Datas:"+ DTOC(DATAEN)+ "  "+DTOC(DATAEN2)
          @ LIN + 3,35 SAY "Procedencia: "+ PROCED
          @ LIN + 3,80 SAY "Notas de entrega: "+ NDOC
          @ LIN + 5,01 SAY "DATA"+"     NOTA "+  "         DESTINO              "+ space(18)+"QT/SAI "+"  QT/SAL"+"         VL/SAI "+SPACE(10)+"       VL/SAL"
          SELE 3
          LIN=LIN+3
          LOCATE FOR CODMAT=MCODMAT
          DO WHILE  .NOT. EOF()
             @ LIN + 3,00 SAY DATA
             @ LIN + 3,09 SAY NTDOC
             @ LIN + 3,22 SAY ESCOLA
             @ LIN + 3,64 SAY QTDENDTR
             @ LIN + 3,72 SAY QTDSAL
             @ LIN + 3,79 SAY VALENTR  PICT "999999,999.99"
             @ LIN + 3,103 SAY VALSAL2  PICT "999999,999.99"
             LIN=LIN+1
             CONTINUE
             DO WHILE LIN >= 63
                 LIN=3
                 PAG=PAG+1
                 EJECT
                 @ 02,03 SAY "PAG.:"+STR(PAG,3,0)
             ENDDO
          ENDDO
          EJECT
          SET DEVICE TO SCREEN
          SET INTEN ON
          SET CONS ON
          GOTO TOP
          LOOP
       ELSE
          TONE (250,2)
          SET CONS ON
          centra(15,"A impressora n„o pode estar pronta; tecle <ENTER>")
          INKEY(0)
          @ 11,15 CLEAR TO 16,70
          LOOP
       ENDIF
       LOOP
   ENDIF
   LOOP
   CLEAR
ENDDO
CLOSE DATABASES
CLEAR
