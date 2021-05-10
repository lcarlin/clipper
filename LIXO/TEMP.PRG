********************************
function TABELA
 
   private vcamp[2]
   vcamp[1]:= FieldName(1)
   vcamp[2]:= FieldName(2)
   private vmasc[2]
   vmasc[1]:= "@!"
   vmasc[2]:= "@!"
   private vcab[2]
   vcab[1]:= "CODIGO"
   vcab[2]:= "NOME"
   save screen to telant
   goto top
   sombra(7, 10, 20, 73)
   cor_db:= SetColor()
   dbedit(8, 11, 19, 71, vcamp, "FUNDB", vmasc, vcab, .T., .T., .T.)
   restore screen from telant
   set color to (cor_db)
   if (LastKey() == K_ENTER)
      return 1
   else
      return 0
   endif
********************************
function FUNDB
 
   parameters modo, num_elt
   set color to "&COR_DB"
   if (modo == 4)
      if (LastKey() == K_ENTER)
         vara:= "M" + FieldName(1)
         varb:= FieldName(1)
         &vara:= &varb
         return 0
      elseif (LastKey() == K_ESC)
         return 0
      endif
   else
      return 1
   endif
