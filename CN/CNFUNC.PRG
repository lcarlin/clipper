
*******************************
FUNCTION CATEGO ()
BEGIN SEQUENCE
      s_TEla1 := savescreen(08,17,18,48)
      sombra(09,18,17,46)
      @ 09,25 SAY "Servicos :"
      nCat:= achoice(10,19,16,45,aServico,.T.,"CONTROLE")
      restscreen(08,17,18,48,s_Tela1)
      IF lastkey() = 27
         cCatego := "  "
         BREAK
      ENDIF
      cCatego := substr(aServico[nCat],1,2)
END
RETURN nCat

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

   lAcha := dbseek(arg1)

   IF .not. lAcha
      mensagem("Codigo Nao Existente !")
      return(.f.)
   endif
   return .t.

***********************************************
FUNCTION criarraY()

USE CNBSERV INDEX CNISER2 new
aServico := {}
DO WHILE .NOT. eof()
   aadd(aServico,CodServ+" - "+Descricao+unidade+str(valor_uni,11,2))
   SKIP
ENDDO
CLOSE ALL


* eop tpfunc.prg