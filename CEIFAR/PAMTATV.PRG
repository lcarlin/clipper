/* bop pamtatv.prg
  data 09/03/96
  funcao manutencao de atividades (inclusao/alteracao /excusao/consulta)
  sistema ceifar
  autor  luiz
  linguagem clipper5.2
  */


#include "INKEY.CH"

   local Local1
   Local1:= .T.
   USE pabatv  INDEX paiatv1, paiatv2
   @ 10,  7 SAY "Codigo da Atividade:"
   @ 11,  7 SAY "Descricao..........:"
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   do while (Local1)
      restore screen from stela1
      set color to (corcli)
      nCod:= 0
      linclui:= .F.
      alter:= 0
      @  10, 28 GET nCod PICTURE "99"
      read
      if (Empty(nCod) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         nCod:= cod_ati
         if (Empty(nproc)) .OR. (empty(nCod))
            loop
         endif
         @ 10,28 GET nCod PICTURE "@!"
         clear GETs
      elseif (Empty(nCod) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek nCod
      if (!Found())
         cDesc_Ati:= Space(30)
         lInclui :=  confirma("Atividade n„o cadastrada! Deseja Cadastrar ?",cCorDialog)
      else
         cDesc_Ati     := desc_ati
         @ 11, 28 SAY cDesc_Ati    PICTURE "@!"
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
         @  11, 28 GET cDesc_Ati     PICTURE "@!"
         read
         if ( confirma("Os Dados Estao Corretos",cCorDialog) )            
            if (linclui)
               append blank
            endif
            REPLACE cod_ati   WITH nCod
            REPLACE desc_ati  WITH cDesc_Ati
            COMMIT
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manuten‡„o de Atividades?",cCorDialog)
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOP PAMTATV.PRG