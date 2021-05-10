/* 
bop cnmtcli.prg
data   27-01-96
funcao cadastro de clientes
autor  luiz a. c.
sistema controle de notas
linguagem clipper 5.2
*/
#include "INKEY.CH"
   local lCont
   lCont:= .T.
   use CNBSERV  index CNISER1 , CNISER2
   @  8,  5 say "Codigo do Servi‡o:"
   @  9,  5 say "Descri‡„o........:"
   @ 10,  5 say "Valor Unitario...:"
   @ 11,  5 say "Unidade..........:"
   centra(24,"<ESC> - Sai ; <ENTER> - Tabela",cCorTt)
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   
   do while (lCont)
      restore screen from stela1
      setcolor(corcli)
      cCodSer := Space(02)
      linclui := .F.
      alter   := 0
      @  8, 24 get cCodSer picture "@!"
      read
      if (Empty(cCodSer) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         if (Empty(nproc))
            loop
         endif
         cCodSer:= CodServ
         @  8, 24 get cCodSer picture "@!"
         clear gets
      elseif (Empty(cCodSer) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek cCodSer
      if (!Found())
         cDescricao := space(40)
         nValor_uni := 0
         cUnidade   := space(03)
         linclui  := ;
            confirma("Servi‡o n„o cadastrado! Deseja Cadastrar ?")
      else
         @  9, 24 say Descricao
         @ 10, 24 say Valor_uni  PICT "999,999.99"
         @ 11, 24 say Unidade
         InKey(5)
         save screen to stela_ant
         set color to gr+/b
         sombra(10, 18, 14, 46)
         @ 11, 20 say "Codigo Existente:" color "R/n"
         set color to (corcli)
         alter:= botao(mopcao,,cCorBin,cCorBat)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?"))
               delete
            endif
         elseif (alter = 3 .OR. alter = 0)
            loop
         ELSE
            cCodSer    := CodServ
            cDescricao := Descricao
            nValor_uni := Valor_uni
            cUnidade   := Unidade
         endif
      endif
      if (linclui .OR. alter = 1)
         @  9, 24 get cDescricao  picture "@!"
         @ 10, 24 get nValor_uni  picture "999,999.99"
         @ 11, 24 get cUnidade    picture "@!"
         read
         if (confirma("Os Dados Est„o Corretos"))
            if (linclui)
               append blank
            endif
            replace CodServ   with cCodSer
            replace Descricao with cDescricao
            replace Valor_uni with nValor_uni
            replace Unidade    With cUnidade
         endif
      endif
      lCont:= confirma("Deseja Continuar na Manuten‡„o de Servi‡os?")
   enddo
   RELEASE ALL
   CLOSE ALL
   select 1
   close format
   return

* EOF
