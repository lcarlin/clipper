/* 
   bop tpmtmat
   funcao manutencao de materiais
   sistema tabela de precos
   data 05-01-96
   autor luiz antonio carlin
   linguagem clipper 5.2
*/
public cCatego
USE TABELA INDEX ITAB1
@ 10,08 SAY "Codigo....:"
@ 10,22 SAY "-" COLOR "n/r"
@ 11,08 SAY "Descricao.:"
@ 12,08 SAY "Unidade...:"
@ 13,08 SAY "Preco.....:"
centra(24,"<ESC> - Sai; <F2> - Tabela de Categorias;<ENTER> Tabela de Codigos",cCorTT)
SAVE SCREEN TO sTelaS
lCont := .t.
mopcao:= array(3, 3)
mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, "Voltar"}}
SET KEY -1 TO CATEGO
dO WHILE lCont
   corcli := setcolor()
   RESTORE SCREEN FROM sTelaS
   cCodigo := space(07)
   cCodAx  := space(04)
   cCatego := space(02)
   cCatego2 := space(20)
   nCatego := 0
   lGrava  := .f.
   ALTER   := 0
   @ 10,20 GET cCatego PICT "!!"
   READ
   IF lastkey() = 27
      EXIT
   ENDIF

   IF empty(cCatego) .and. lastkey() = 13
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCod = Codigo
      @ 10,20 GET cCod PICT "@!"
      CLEAR GETS
      cCatego :=substr(cCod,1,2)
      cCOdAx := substr(cCod,4,4)
   ELSEIF empty(cCatego) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   nCatego := ascan(aCatego,cCatego)
   IF nCatego = 0
      mensagem("Categoria de Material nao cadastradada !")
      LOOP
   ENDIF
   ccatego2 := substr(aCatego[nCatego],6,20)
   @ 10,28 SAY cCatego2
   @ 10,23 GET cCodAx PICT "@!" valid cCodAx<> " "
   read

   IF lastkey() = 27
      EXIT
   ENDIF
   centra(24,"<ESC> - Sai",cCorTT)
   cCodigo := cCatego+"-"+cCodAx
   SEEK cCodigo
   IF found()
      cDesc   := DESCRICAO
      cUn     := UN
      nPreco  := PRECO
      @ 11,20 SAY DESCRICAO
      @ 12,20 SAY UN
      @ 13,20 SAY PRECO
      inkey(5)
      save screen to stela1
      corcli := setcolor(cCorJane)
      sombra(10, 18, 14, 46)
      @ 11, 20 say "Codigo Existente:" color "R/n"
      set color to (corcli)
      alter:= botao(mopcao,,cCorBin,cCorBat)
      restore screen from stela1
      IF ALTER = 3 .OR. ALTER = 0
         LOOP
      ELSEIF ALTER = 2
         IF confirma("Deseja realmente Excluir o Registro ?")
            DELETE
         ENDIF
      ENDIF
   ELSE
      cDesc   := space(40)
      cUn     := space(02)
      nPreco  := 0
      IF confirma("Codigo Nao Encontrado ! Deseja Incluir ?")
         lGrava := .t.

      ENDIF
   ENDIF
   IF lGrava .or. Alter = 1
      @ 11,20 GET cDesc
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
SET KEY -1 TO
CLOSE ALL
* eop tpmtmat
