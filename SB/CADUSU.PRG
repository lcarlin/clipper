select 1
IF ! NETUSE("CONSEN",.F.,10)
   Mensagem ("O Arquivo de Senha N„o se Encontra dispon¡vel !",cCorCaixa)
   RETURN
ENDIF
SET INDEX TO OPER_A
 
select 2
IF ! NetUse("Semafaro",.F.,10)
   mensagem("O arquivo de Controle nao se encontra Disponivel!",cCorcaixa)
   return
ENDIF
SET INDEX TO SEMAFARO
 
cCor := setcolor(cCorPadra)
sombra(10,09,15,50)
nCursor := setcursor(1)
@ 11,10 SAY "Operador..:"
@ 12,10 SAY "Nome......:"
@ 13,10 SAY "Senha.....:"
@ 14,10 SAY "Nivel.....:"
for xx := 1 to 4
    @ 10+xx,37 SAY aNivel[xx]
NEXT
SAVE SCREEN TO Tela_Sen
lCont := .T.
 
DO WHILE  lCont
   SELECT consen
   RESTORE SCREEN FROM Tela_sen
   Identifica := space(3)
   lInclui    := .F.
   @ 11,22 GET Identifica PICT "@!"
   READ
   IF lastkey() = 27 .OR. empty(Identifica)
      EXIT
   ENDIF
   SEEK Identifica
   IF found()
      vQuem  := quem
      cNivel := decripto(NIVEL)
      cSenha  := space(12)
   ELSE
      vquem      := space(10)
      cSenha     := space(12)
      cNivel     := space(1)
      lInclui    := .t.
   ENDIF
   @ 12,22 GET vQuem PICT "@!"
   READ
   cSenha = senha(13,23)
   @ 14,22 GET cNivel PICT "!" VALID cNivel$"1234"
   READ
   IF lastkey() = 27
      EXIT
   ENDIF
   IF confirma("Os dados do usuario estao corretos ?",cCorCaixa)
      SELECT consen
      IF lInclui
         addRec(0)
      ELSE
         RECLOCK(10)
      ENDIF
      REPLACE CODOP  WITH IDENTIFICA
      REPLACE QUEM   WITH vQuem
      REPLACE NIVEL  WITH cripto(cNivel)
      REPLACE CODSEN WITH esconde(cSenha)
      COMMIT
      destrava()
   ENDIF
   lCont := confirma("Deseja Continuar ?",cCorcaixa)
ENDDO
setcursor(nCursor)
setcolor(cCor)
CLOSE ALL
RETURN
