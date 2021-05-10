/*
   BOP TOPFUNC.PRG
   FUNCAO  FUNCOES DO SIST. TABELA DE PRECOS
   DATA    06/01/96
   AUTOR   LUIZ ANTONIO CARLIN
   LINGUAGEM  CLIPPER5.2
*/

*******************************
FUNCTION CATEGO ()
BEGIN SEQUENCE
      s_TEla1 := savescreen(08,17,18,48)
      sombra(09,18,17,46)
      @ 09,25 SAY "Categorias:"
      nCat:= achoice(10,19,16,45,aCatego,.T.,"CONTROLE")
      restscreen(08,17,18,48,s_Tela1)
      IF lastkey() = 27
         cCatego := "  "
         BREAK
      ENDIF
      cCatego := substr(aCatego[nCat],1,2)
END
RETURN cCatego

*********************************
function controle
save screen to tela_te
parameters modo, elto, pos
do case
   case modo=4
	ret=3
   case modo=3
	if lastkey()=27
	    ret=0
	elseif lastkey()=13
	    ret=1
	else
	    ret=2
	endif
   case modo=2
	ret=2
   case modo=1
	ret=2
   case modo=0
	ret=2
endcase
restore screen from tela_te
return(ret)

***************************************************

function ACHA (Arg1)
   IF empty(Arg1)
      RETURN .T.
   ENDIF
   lAcha := dbseek(arg1)

   IF .not. lAcha
      mensagem("Codigo Nao Existente !")
      return(.f.)
   endif
   return .t.

* eop tpfunc.prg