/*
  bop palcatv.prg
  funcao    lancamentos das atendimentos
  sistema   ceifar
  data      09/03/96
  autor     luiz
  linguagem clipper 5.2
*/

#include "INKEY.CH"

   local Local1
   Local1:= .T.
   USE pablatd NEW
   USE pabatd   INDEX paiatd1, paiatd2 NEW
   USE pabusua1 INDEX paiusu1, paiusu2 NEW

   @ 10, 08 SAY "Codigo do Atendimento:"
   @ 11, 08 SAY "Descricao............:"
   @ 12, 08 SAY "Codigo da Usu ria....:"
   @ 13, 08 SAY "Nome.................:"
   @ 14, 08 SAY "Data do atendimento..:"

   save screen to stela1
   corcli:= SetColor()
   do while (Local1)
      restore screen from stela1
      setcolor(corcli)
      nCod:= 0
      linclui:= .F.
      cCodUsu := space(05)
      dDataAtd := date()
      SELECT pabatd
      @  10, 31 GET nCod PICTURE "99"
      read
      if (Empty(nCod) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         nCod:= COD_ATD
         if (Empty(nproc)) .OR. (empty(nCod))
            loop
         endif
         @ 10,31 GET nCod PICTURE "@!"
         clear GETs
      elseif (Empty(nCod) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek nCod
      if (!Found())
         mensagem("Atividade n„o cadastrada!",cCorDialog)
      else
         cDESC_ATD  := DESC_ATD
         dDat_ativ  := date()
         @ 11, 31 SAY cDESC_ATD    PICTURE "@!"
         @ 12, 31 GET cCodUsu    PICT "@!"
         READ
         SELECT PABUSUA1
         if (Empty(cCodusu) .AND. LastKey() = K_ENTER)
            set order to 2
            nproc:= tabela()
            cCodusu:= CODigo
            if (Empty(nproc)) .OR. (empty(cCodusu))
               loop
            endif
            @ 12,31 GET cCodusu PICTURE "@!"
            clear GETs
         elseif (Empty(cCodUsu) .AND. LastKey() = K_ESC)
            exit
         endif
         set order to 1
         set color to (corcli)
         seek cCodUsu
         if (!Found())
            mensagem("Usu ria n„o cadastrada!",cCorDialog)
            LOOP
         ENDIF
         cNome := Nome
         @ 13,31 SAY cNome
         @ 14,31 GET dDataAtd PICT "99/99/99"
         READ
         IF confirma("Os dados do atendimento est„o corretos ?",cCorDialog)
            SELE PABLATD
            APPEND BLANK
            REPLACE COD_ATD   WITH nCod
            REPLACE DESC_ATD  WITH cDESC_ATD
            REPLACE DAT_ATEND WITH dDataAtd
            REPLACE NOME      WITH cNOme
            REPLACE COD_USU   WITH cCodUsu
            COMMIT
         endif
      ENDIF
      Local1:= confirma("Deseja Continuar nos Lan‡amentos de Atividades?",cCorDialog)
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOP PALCATV.PRG