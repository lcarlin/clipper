
FUNCTION existCATe ()
BEGIN SEQUENCE
      s_TEla1 := savescreen(08,17,18,48)
      sombra(09,18,17,46)
      @ 09,25 SAY "Categorias:"
      nCat:= achoice(10,19,16,45,aCatego,.T.,"CONTROLE")
      restscreen(08,17,18,48,s_Tela1)
      IF lastkey() = 27
         cCatego := " "
         BREAK
      ENDIF
      cCatego := substr(aCatego[nCat],1,2)
END
RETURN cCatego
