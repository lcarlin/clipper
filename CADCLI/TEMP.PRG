        ELSEIF LASTKEY() = -5 
           SAVE SCREEN TO TELA_ANT
           APRES:=SETCURSOR(1)
           sombra(05,08,07,67)
           mnome := space(40) 
           @ 06,26 SAY " " 
           @ 06,09 say "Entre com o nome:" GET MNOME PICT "@!" 
           READ
           mNOME := ALLTRIM(MNOME)
           RESTORE SCREEN FROM TELA_ANT
           SETCURSOR(APRES)
           IF EMPTY(MNOME)
              SET FILTER TO 
              go top 
              RETURN 2
          ENDIF 
          SET FILTER tO NOME = MNOME
          go top 
          RETURN 2