/*
  bop palcatv.prg
  funcao  lancamentos das atividades
  sistema  ceifar
  data 09/03/96
  autor  luiz
  linguagem clipper 5.2
*/

#include "INKEY.CH"

   local Local1
   Local1:= .T.
   USE pablatv NEW
   USE pabatv  INDEX paiatv1, paiatv2 NEW
   @ 10, 10 SAY "Codigo da Atividade:"
   @ 11, 10 SAY "Descricao..........:"
   @ 12, 10 SAY "DATA...............:"
   save screen to stela1
   corcli:= SetColor()
   do while (Local1)
      restore screen from stela1
      setcolor(corcli)
      nCod:= 0
      linclui:= .F.
      SELECT PABATV
      @  10, 31 GET nCod PICTURE "99"
      read
      if (Empty(nCod) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         nCod:= cod_ati
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
         cDesc_Ati  := desc_ati
         dDat_ativ  := date()
         @ 11, 31 SAY cDesc_Ati    PICTURE "@!"
         @ 12, 31 GET dDat_Ativ    PICT "99/99/99"
         READ
         IF confirma("Os dados do lan‡amento est„o corretos ?",cCorDialog)
            SELE pablatv
            APPEND BLANK
            REPLACE COD_ATIV  WITH nCod
            REPLACE desc_ativ WITH cDesc_Ati
            REPLACE DAT_ATIV  WITH dDat_ativ
            COMMIT
         endif
      endif
      Local1:= confirma("Deseja Continuar nos Lan‡amentos de Atividades?",cCorDialog)
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOP PALCATV.PRG