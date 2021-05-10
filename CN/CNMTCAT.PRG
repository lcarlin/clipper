/* 
   bop tpmtcat
   funcao manutencao de categorias
   sistema tabela de precos
   data 05-01-96
   autor luiz antonio carlin
   linguagem clipper 5.2
*/
public cCatego
USE catego INDEX iCat1
@ 10,25 SAY "Categoria.:"
@ 11,25 SAY "Descricao.:"
centra(24,"<ESC> - Sai; <ENTER> Tabela de Categorias",cCorTT)
SAVE SCREEN TO sTelaS
lCont := .t.
mopcao:= array(3, 3)
mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
   "Voltar"}}
dO WHILE lCont
   corcli := setcolor()
   RESTORE SCREEN FROM sTelaS
   cCatego := space(02)
   lGrava  := .f.
   ALTER   := 0
   @ 10,37 GET cCatego PICT "!!"
   READ
   IF lastkey() = 27
      EXIT
   ENDIF
   IF empty(cCatego) .and. lastkey() = 13
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCatego = Categoria
      @ 10,37 GET cCatego PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCatego) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   centra(24,"<ESC> - Sai",cCorTT)
   LOCATE FOR CATEGORIA=cCatego
   IF found()
      cDesc   := CAT_DES
      @ 11,37 SAY CAT_DES
      inkey(5)
      save screen to stela1
      corcli := setcolor(cCorJane)
      sombra(10, 18, 14, 46)
      @ 11, 20 say "Categoria Existente:" color "R/n"
      set color to (corcli)
      alter:= botao(mopcao,,cCorBin,cCorBat)
      restore screen from stela1
      IF ALTER = 3 .OR. ALTER = 0
         LOOP
      ELSEIF ALTER = 2
         IF confirma("Deseja realmente Excluir a Categoria ?")
            DELETE
         ENDIF
      ENDIF
   ELSE
      cDesc   := space(20)
      IF confirma("Categoria nao Encontrada ! Deseja Incluir ?")
         lGrava := .t.
      ENDIF
   ENDIF
   IF lGrava .or. Alter = 1
      @ 11,37 GET cDesc     PICT "@!"
      READ
      IF .NOT. confirma("Os dados Estao Coretos ?")
         LOOP
      ENDIF
      IF lGrava
         dbappend()
         REPLACE Categoria WITH cCatego
      ENDIF
      REPLACE cat_des WITH cDesc
   ENDIF
   lCont := confirma("Deseja Continuar ?")
ENDDO
PACK
acatego := {}
DO WHILE .NOT. eof()
   aadd(aCatego,categoria+" - "+cat_des)
   SKIP
ENDDO
CLOSE ALL
* eop tpmtcat.prg