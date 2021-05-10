
/* bop pacapgr.prg
  data 09/03/96
  funcao cadastro de participantes de grupos
  sistema ceifar
  autor  luiz
  linguagem clipper5.2
*/
#include "INKEY.CH"

   local Local1
   Local1:= .T.
   USE pabpatg  NEW
   USE pabgru   INDEX paigru1,  paigru2  NEW
   USE pabusua1 INDEX paiusu1,  paiusu2 NEW

   @ 10, 10 SAY "Codigo do Grupo....:"
   @ 11, 10 SAY "Descricao..........:"
   @ 12, 10 SAY "Codigo da Usu ria..:"
   @ 13, 10 SAY "Nome da Usu ria....:"
   @ 14, 10 SAY "Data de Nascimento.:"
   @ 15, 10 SAY "Endere‡o...........:"
   @ 16, 10 SAY "Fone do Trabalho...:"
   @ 17, 10 SAY "Fone da Residencia.:"

   save screen to stela1
   corcli:= SetColor()
   do while (Local1)
      restore screen from stela1
      setcolor(corcli)
      nCodGru:= 0
      cCodUsu := space(05)

      SELECT PABgru
      @  10, 31 GET nCodGru PICTURE "99"
      read
      if (Empty(nCodGru) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         nCodGru:= cod_GRU
         if (Empty(nproc)) .OR. (empty(nCodGru))
            loop
         endif
         @ 10,31 GET nCodGru PICTURE "@!"
         clear GETs
      elseif (Empty(nCodGru) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek nCodGru
      if (!Found())
         mensagem("Grupo n„o cadastrado!",cCorDialog)
         LOOP
      ENDIF         
      cDesc_Gru  := Desc_Gru

      @ 11, 31 SAY cDesc_Gru    PICTURE "@!"
      @ 12, 31 GET cCodUsu      PICT "99999"
      READ
      SELECT PABUSUA1
      if (Empty(cCodUsu) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         cCodUsu:= codigo
         if (Empty(nproc)) .OR. (empty(cCodUsu))
            loop
         endif
         @ 12,31 GET cCodUsu PICTURE "@!"
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
      cNome     := nome
      cEndereco := endereco
      cFoneRes  := foneres
      cFoneTrab := foneTrab
      dDataNasc := datnasc
      SELECT PABPATG
      LOCATE FOR (COD_GR=nCodgru .AND. COD_USUA=cCodUsu)
      IF found()
         @ 13,31 SAY Nome_usua
         @ 14,31 SAY Datnasc
         @ 15,31 SAY Endereco
         @ 16,31 SAY FoneTrab
         @ 17,31 SAY FoneRes
         inkey(5)
         IF confirma({"Usu ria j  cadastrada neste Grupo ! ","   Deseja Excluir? "},cCorDialog)
            DELETE
            COMMIT
         ENDIF
         LOOP
      ENDIF
      @ 13,31 SAY cNome
      @ 14,31 SAY dDatanasc
      @ 15,31 SAY cEndereco
      @ 16,31 SAY cFoneTrab
      @ 17,31 SAY cFoneRes
      inkey(5)
      IF confirma("Os Dados da Participante do Grupo Est„o Corretos?",cCorDialog)
         SELE pabpatg
         APPEND BLANK
         REPLACE COD_gr    WITH nCodGru
         REPLACE NOME      WITH cDesc_Gru
         REPLACE COD_USUA  WITH cCodUsu
         REPLACE NOME_USUA WITH cNome
         REPLACE DATNASC   WITH dDataNasc
         REPLACE ENDERECO  WITH cEndereco
         REPLACE FONERES   WITH cFoneres
         REPLACE FONETRAB  WITH cFoneTrab
         COMMIT
      endif
      Local1:= confirma({"Deseja Continuar nos Cadastro de "," Participantes de Grupos?"},cCorDialog)
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOP PALCATV.PRG