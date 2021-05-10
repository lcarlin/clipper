      sTela := savescreen(11,05,14,72)
      SOMBRA(11,05,13,69)
      cCusto := space(40)
      nCusto := 0
      cSit   := space(8)
      nCcusto := 0
      nDcusto := 0
      nTam   := 0
      nCursor := setcursor(1)
      @ 12,06 SAY "Entre com a Descricao:" GET cCusto PICT "@!"
      READ
      setcursor(nCursor)
      restscreen(11,05,14,72,sTela)
      IF lastkey() = 27 .OR. empty(cCusto)
         RETURN 1
      ENDIF
      nTam := len(alltrim(cCusto))
      SUM VALOR TO nDcusto FOR UPPER(substr(DESCRICAO,1,nTam))= alltrim(cCusto) .AND. TIPO="D" 
      SUM VALOR TO nCcusto FOR UPPER(substr(DESCRICAO,1,nTam))= alltrim(cCusto) .AND. TIPO="C" 
      nCusto := if(nCCusto>nDcusto,nCCusto-nDcusto,nDcusto-nCusto)
      cSit   := if(nCCusto>nDcusto,"Credito","Debito ")
*      dbsetfilter({|| DESCRICAO = alltrim(cCusto) }, "DESCRICAO = alltrim(cCusto)")
      go top
      SET FILTeR TO UPPER(substr(DESCRICAO,1,nTam)) = alltrim(cCusto)
      dbGOTOP()
      @ 23,08 SAY cCusto
      @ 23,COL()+2 SAY nCusto PICT "999,999,999.99"
      @ 23,col()+2 SAY cSit
      RETURN 2
   ELSEIF LASTKEY() = -8
      SET FILTER TO
      GO TOP
      @ 23,05 TO 23,75
      RETURN 2