/* bop pamtinst.prg
  data 09/03/96
  funcao manutencao de instrutoras (inclusao/alteracao /excusao/consulta)
  sistema ceifar
  autor  luiz
  linguagem clipper5.2
  */


#include "INKEY.CH"

   local Local1
   Local1:= .T.
   USE pabinst INDEX paiinst1, paiinst2
   @  8,  8 SAY "Codigo............:"
   @  9,  8 SAY "Nome..............:"
   @ 10,  8 SAY "Data de Inicio....:"
   @ 11,  8 SAY "Data de Nascimento:"
   @ 12,  8 SAY "Endereco..........:"
   @ 13,  8 SAY "Fone da Residencia:"
   @ 14,  8 SAY "Fone do Trabalho..:"
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   do while (Local1)
      restore screen from stela1
      set color to (corcli)
      ccod:= Space(5)
      linclui:= .F.
      alter:= 0
      @  8, 28 GET cCod PICTURE "@!"
      read
      if (Empty(ccod) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         ccod:= codigo
         if (Empty(nproc)) .OR. (empty(cCod))
            loop
         endif
         @ 08,28 GET cCod PICTURE "@!"
         clear GETs
      elseif (Empty(ccod) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek ccod
      if (!Found())
         cNome:= Space(40)
         dDataNasc := dDataIni := ctod("  /  /  ")
         cende:= Space(40)
         cFoneRes := cFoneTrab := Space(16)
         linclui:= ;
            confirma("Instrutora n„o cadastrada! Deseja Cadastrar ?",cCorDialog)
      else
         cnome     := nome
         dDAtaNasc := datnasc
         dDataIni  := datinic
         cEnde     := endereco
         cFoneTrab := fonetrab
         cFoneRes  := foneres
         @  9, 28 SAY cnome     PICTURE "@!"
         @ 10, 28 SAY dDataIni  Picture "99/99/99"
         @ 11, 28 SAY dDataNasc PICTURE "99/99/99"
         @ 12, 28 SAY cEnde     PICTURE "@!"
         @ 13, 28 SAY cFoneTrab PICTURE "@!"
         @ 14, 28 SAY cFoneRes  PICTURE "@!"
         InKey(5)
         save screen to stela_ant
         setcolor(cCorDialog)
         sombra(10, 18, 14, 46)
         @ 11, 20 SAY "Codigo Existente:"
         alter:= botao(mopcao,,cCorBin,cCorBat)
         set color to (corcli)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?",cCorDialog))
               delete
               COMMIT
            endif
         elseif (alter = 3 .OR. alter = 0)
            loop
         endif
      endif
      if (linclui .OR. alter = 1)
         @  9, 28 GET cnome     PICTURE "@!"
         @ 10, 28 GET dDataIni  Picture "99/99/99"
         @ 11, 28 GET dDataNasc PICTURE "99/99/99"
         @ 12, 28 GET cEnde     PICTURE "@!"
         @ 13, 28 GET cFoneTrab PICTURE "@!"
         @ 14, 28 GET cFoneRes  PICTURE "@!"
         read
         if (confirma("Os Dados Estao Corretos",cCorDialog))
            if (linclui)
               append blank
            endif
            REPLACE codigo   WITH ccod
            REPLACE nome     WITH cnome
            REPLACE datinic  WITH dDataIni
            REPLACE datnasc  WITH dDataNasc
            REPLACE foneres  WITH cFoneres
            REPLACE endereco WITH cende
            REPLACE fonetrab WITH cFoneTrab
            COMMIT
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manuten‡„o de Instrutoras?",cCorDialog)
   enddo
   release all
   close databases
   select 1
   close format
   return

* eop pamtinst.prg