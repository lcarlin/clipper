   IF lGrava .or. Alter = 1
      @ 11,20 GET cDesc     PICT "@!"
      @ 12,20 GET cUn       PICT "@!"
      @ 13,20 GET nPreco    PICT "9,999,999.99"
      READ
      IF .NOT. confirma("Os dados Estao Coretos ?")
         LOOP
      ENDIF
      IF lGrava
         dbappend()
         REPLACE CODIGO WITH cCodigo
      ENDIF
      REPLACE DESCRICAO WITH cDesc
      REPLACE PRECO     WITH nPreco
      REPLACE UN        WITH cUn
   ENDIF
   lCont := confirma("Deseja Continuar ?")
ENDDO
SET KEY -2 TO
PACK
CLOSE ALL