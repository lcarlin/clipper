   IF lastkey() = 27
      EXIT
   ENDIF

   IF empty(cCatego) .and. lastkey() = 13
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCod = Codigo
      @ 10,20 GET cCod PICT "@!"
      CLEAR GETS
      cCatego :=substr(cCod,1,2)
      cCOdAx := substr(cCod,4,4)
   ELSEIF empty(cCatego) .and. lastkey()=27
      exit
   ENDIF