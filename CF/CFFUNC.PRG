* bop cffunc.prg

***********************************************************
function CONSULTA(Arg1, Arg2)

   local Local1
   ccampo:= avet_camp[Arg2]
   do case
   case Arg1 == 4
      if (LastKey() == 27)
         return 0
         return 1
      ELSEIF (lastkey() = -1)
         REPLACE MARCADO WITH if(marcado = "S"," ","S")
         RETURN 1
      ELSEIF (lastkey() = -2)
         nMarcado := 0
         COUNT TO nMarcado FOR MARCADO = "S"
         IF nMarcado = 0
            mensagem("N„o h  registros Marcados !!")
            RETURN 1
         ENDIF
         SET FILTER TO MARCADO = "S"
         GO TOP
         DO WHILE .NOT. eof()
            REPLACE MARCADO WITH " "
            SKIP
         ENDDO
         mensagem("Sele‡„o Anulada !! ")
         SET FILTER TO
         GO TOP
         RETURN 2
      ELSEIF (lastkey() = -3)
         aVetMens := {" Titulo N§........: "+TITULO+SPACE(25),;
                      " Nome.............: "+NOME,;
                      " Se‡„o............: "+SECAO,;
                      " Data da Filia‡„o.: "+DTOC(FILIACAO),;
                      " N§ de Inscric„o..: "+INSCRICAO,;
                      " Partido..........: "+Partido,;
                      " Endere‡o.........: "+ENDERECO,;
                      " Bairro ..........: "+BAIRRO,;
                      " Cidade...........: "+CIDADE,;
                      " U.F..............: "+UF,;
                      " C.E.P............: "+CEP}
         menSagem(aVetMens)
         RETURN 1
      endif
   case Arg1 == 3
      mensagem("Nao ha dados nesse arquivo!!")
      return 0
   case Arg1 == 2
      return 1
   case Arg1 == 1
      return 1
   otherwise
      return 1
   endcase
* eop cffunc.prg                                           