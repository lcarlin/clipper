function ACHA(Arg1)

   save screen to stela_ant
   set filter to Produto = alltrim(cDescmat)
   goto top
   nlinprod:= Row()
   if (EOF())
      mensagem("Nao Ha nenhum produto com esse nome")
      lret:= .F.
   else
      sombra(9, 9, 17, 51)
      private avetcamp[1]
      avetcamp[1]:= "PRODUTO"
      dbedit(10, 10, 16, 50, avetcamp, "USer_Func", "@!", "Material")
      lret:= .T.
   endif
   restore screen from stela_ant
   return lret
