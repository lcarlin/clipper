/* bop pamtusu1.prg
  data 11/03/96
  funcao manutencao de usuarias (inclusao/alteracao /excusao/consulta)
  sistema ceifar
  autor  luiz
  linguagem clipper5.2
  */


#include "INKEY.CH"

   local Local1
   Local1:= .T.
   USE pabinst  INDEX paiinst1, paiinst2 NEW
   USE pabusua1 INDEX paiusu1, paiusu2 NEW
   @  8,  8 SAY "Codigo............:"
   @  9,  8 SAY "Nome..............:"
   @ 10,  8 SAY "Data de Nascimento:"
   @ 11,  8 SAY "Data de Inscri��o.:"
   @ 12,  8 SAY "Procedencia.......:"
   @ 13,  8 SAY "Cidade onde Mora..:"
   @ 14,  8 SAY "Endere�o..........:"
   @ 15,  8 SAY "Fone do Trabalho..:"
   @ 16,  8 SAY "Fone da Residencia:"
   @ 17,  8 SAY "Instrutora........:"
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   aSimNao := {{22,30," Sim "},{22,38," N�o "}}
   do while (Local1)
      sele pabusua1
      restore screen from stela1
      setcolor(corcli)
      cCod:= Space(5)
      lInclui := lDados := .F.
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
         linclui:= confirma("Usu�ria n�o cadastrada! Deseja Cadastrar ?",cCorDialog)
         IF lInclui
            cNome   := Space(40)
            dDataNasc := dDataIni := ctod("  /  /  ")
            cEnde  := Space(40)
            cFoneRes := cFoneTrab := Space(16)
            cCodInst := space(05)
            cprocede := cCidade := space(35)
         ENDIF
      else
         @  9, 28 SAY nome       PICTURE "@!"
         @ 10, 28 SAY DatNasc    Picture "99/99/99"
         @ 11, 28 SAY DatInsc    PICTURE "99/99/99"
         @ 12, 28 SAY procede     PICTURE "@!"
         @ 13, 28 SAY CidRes     PICTURE "@!"
         @ 14, 28 SAY Endereco   PICTURE "@!"
         @ 15, 28 SAY FoneTrab   PICTURE "@!"
         @ 16, 28 SAY Foneres    PICTURE "@!"
         @ 17, 28 SAY instrutora PICTURE "@!"
         InKey(5)
         save screen to stela_ant
         setcolor(cCorDialog)
         sombra(10, 18, 14, 46)
         @ 11, 20 SAY "Codigo Existente:"
         alter:= botao(mopcao)
         set color to (corcli)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?",cCorDialog))
               delete
               COMMIT
            endif
         elseif (alter = 3 .OR. alter = 0)
            loop
         ELSE
           cnome     := nome
           dDAtaNasc := datnasc
           dDataIni  := datinsc
           cEnde     := endereco
           cFoneTrab := fonetrab
           cFoneRes  := foneres
           cprocede   := procede
           cCidade   := Cidres
           cCodInst  := instrutora
         endif
      endif
      if (linclui .OR. alter = 1)
         @  9, 28 GET cNome       PICTURE "@!"
         @ 10, 28 GET dDataNasc   Picture "99/99/99"
         @ 11, 28 GET dDataIni    PICTURE "99/99/99"
         @ 12, 28 GET cprocede    PICTURE "@!"
         @ 13, 28 GET cCidade     PICTURE "@!"
         @ 14, 28 GET cEnde       PICTURE "@!"
         @ 15, 28 GET cFoneTrab   PICTURE "@!"
         @ 16, 28 GET cFoneres    PICTURE "@!"
         READ
         @ 17, 28 GET cCodinst    PICTURE "@!"
         read
         
         SELE PABINST
         if (Empty(ccodiNST) .AND. LastKey() = K_ENTER)
            set order to 2
            nproc:= tabela()
            ccodInst := codigo
            if (Empty(nproc)) .OR. (empty(cCodInst))
               loop
            endif
            @ 17,28 GET cCodInst PICTURE "@!"
            clear GETs
         elseif (Empty(ccodInst) .AND. LastKey() = K_ESC)
            exit
         endif                 
         SET ORDER TO 1
         IF .NOT. dbseek(cCodInst)
            mensagem("Instrutora N�o cadastrada !!!",cCorDialog)
            LOOP
         ENDIF
         @ 17,33 SAY NOME
         inkey(5)         
         lDados := confirma("Deseja preencher os dados complementares ?")
         IF lDados
            @ 05,01 CLEAR TO 22,78
            @ 05,26 SAY "Dados complementares da Usu�ria"
            @ 06,02 SAY "Situacao Conjugal: 99 01-Casada; 02-Solteira; 03-Noiva; 04-Divorciada; 04-Viuva"
            @ 07,02 SAY "Grau de Instrucao: 99 01-Nenhum; 02-1� Grau ; 03-1�Grau; 04-Superior"
            @ 08,02 SAY "Nome do Companheiro:"
            @ 09,02 SAY "Endereco...........:"
            @ 10,02 SAY "Fone da Residencia.:"
            @ 11,02 SAY "Fone do Trabalho...:"
            @ 12,02 SAY "Grau de Instrucao:   01-Nenhum; 02-1� Grau ; 03-1�Grau; 04-Superior"
            @ 13,02 SAY "Numero de Filhos: 99 Idade do Ultimo Filho: 99"
            @ 14,02 SAY "Indicada Por: 99"
            @ 15,02 SAY "01-Pe. Roberto; 02-Palestra; 03-Curso de Noivos; 04-Medico; 05-Amigos; 06-Outros"
            @ 16,02 SAY "Data da Ultiima Menstrua��o:"
            @ 17,02 SAY "Anota��es:"
            @ 18,08 SAY "Usou Alguma vez o metodo de planejamento familiar?"
            @ 19,08 SAY ""

         SELE PABUSUA1
         if (confirma("Os Dados Estao Corretos",cCorDialog))
            if (linclui)
               dbappend()           
            endif
            REPLACE codigo     WITH ccod
            REPLACE nome       WITH cnome
            REPLACE datinsc    WITH dDataIni
            REPLACE datnasc    WITH dDataNasc
            REPLACE foneres    WITH cFoneres
            REPLACE endereco   WITH cende
            REPLACE fonetrab   WITH cFoneTrab
            REPLACE instrutora WITH cCodInst
            REPLACE CIDRES     WITH cCidade
            REPLACE procede    WITH cprocede
            COMMIT
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manuten��o de Usu�rias?",cCorDialog)
   enddo
   release all
   close databases
   select 1
   close format
   return

* eop pamtusu1.prg
