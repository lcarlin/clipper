/*********************
* BOP CCMTUSU.PRG
DATA 01/07/1996
sistema cONTROLE DE CHEQUES
FUNCAO  CADASTRAR USUARIOS DO SISTEMA
linguagem clipper 5.2e
autor  eu
*******************************/
 
PROCEDURE USUARIOS ()
USE CCBUSU INDEX CCIUSU NEW
cCor := setcolor(cCorInc)
nCursor := setcursor(1)
sombra(10,15,13,55)
@ 10,15 SAY "Usuarios"
@ 11,16 SAY "Codigo:"
@ 12,16 SAY "Nome..:"
@ 13,16 SAY "Senha.:"
sTelausu := saveScreen(10,15,13,55)
aOpcoes := {{13,41,"Altera"},;
            {13,49,"Exclui"},;
            {13,56,"Cancela"}}
lCont := .T.
DO WHILE lCont
   RestScreen(10,15,13,55,sTelaUsu)
   cCodigo := "   "
   lInclui := .F.
   nAlter := 0
   @ 11,24 GET cCodigo PICT "999"
   READ
   IF lastkey() = 27
      EXIT
   ENDIF
   SEEK cCodigo
   IF .NOT. found()
      cNome := space(30)
      cSenha := space(10)
      liNCLUI := confirma("Usuario nao cadastrado ! Deseja Cadastrar ?",cCorBox)
   ELSE
      @ 12,24 SAY nome
      inkey(3)
      sTela1 := savescreen(12,39,15,66)
      cCorAnt := setcolor(cCorBox)
      sombra(12,39,14,64)
      @ 12,40 SAY "Usuario ja cadastrado"
      nAlter := Botao(aOpcoes,,cCorBin,cCorBat)
      setcolor(cCorAnt)
      restscreen(12,39,15,66,sTela1)
      IF nAlter = 3 .OR. nAlter = 0
         LOOP
      ELSEIF nAlter = 2
         IF confirma("Exclui o Usuario ?",cCorBox)
            Delete
         ENDIF
      ELSE
         cNome := NOME
         cSenha := space(10)
      ENDIF
   ENDIF
   IF nAlter = 1 .OR. lInclui
      @ 12,24 get cNome
      READ
      cSenha := senha(13,24)
      IF confirma("Os dados Estao corretos ?", cCorBox)
         IF lInclui
            DbAppend()
         ENDIF
         REPLACE coDusu WITH cCodigo
         REPLACE NOME   WITH cNome
         REPLACE senha  WITH cripto(cSenha)
      ENDIF
   ENDIF
   lCont := Confirma("Deseja Continuar ?",cCorBox)
ENDDO
CLOSE ALL
SetCursor(nCursor)
setcolor(cCor)
* EOP CCMTUSU.PRG
