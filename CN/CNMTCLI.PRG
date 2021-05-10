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
   use CNBcli   index CNICLI1, CNICLI2
   @  8,  5 say "Codigo...........:"
   @  9,  5 say "Nome.............:"
   @ 10,  5 say "Endere‡o.........:"
   @ 11,  5 say "Telefone.........:"
   @ 12,  5 say "Municipio........:"
   @ 13,  5 say "U.F..............:"
   @ 14,  5 SAY "Insc. Municipal..:"
   @ 15,  5 say "Insc. Estadual...:"
   @ 16,  5 say "C.G.C. ..........:"

   centra(24,"<ESC> - Sai ; <ENTER> - Tabela",cCorTt)
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}

   do while (lCont)
      restore screen from stela1
      set color to (corcli)
      cCodigo := Space(06)
      linclui:= .F.
      alter:= 0
      @  8, 24 get cCodigo picture "@!"
      read
      if (Empty(cCodigo) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         if (Empty(nproc))
            loop
         endif
         cCodigo:= Codigo
         @  8, 24 get cCodigo picture "@!"
         clear gets
      elseif (Empty(cCodigo) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek cCodigo
      if (!Found())
         cNOme   := space(40)
         cEnder  := space(40)
         cMunici := space(35)
         cTelefo := space(20)
         cUf     := space(02)
         cInscMn := space(05)
         cInscEs := space(20)
         cCgc    := space(20)
         linclui  := ;
            confirma("Codigo n„o cadastrado! Deseja Cadastrar ?")
      else
         @  9, 24 say nome
         @ 10, 24 say Ender
         @ 11, 24 say Telefone
         @ 12, 24 say Munici
         @ 13, 24 say Uf
         @ 14, 24 say InscMn
         @ 15, 24 say InscEs
         @ 16, 24 say CgC
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
            cCodigo := codigo
            cNOme   := nome
            cEnder  := Ender
            cTelefo := telefone
            cMunici := Munici
            cUf     := uf
            cInscMn := inscMn
            cInscEs := InscEs
            cCgc    := Cgc
         endif
      endif
      if (linclui .OR. alter = 1)
         @  9, 24 get cNome    picture "@!"
         @ 10, 24 get cEnder   picture "@!"
         @ 11, 24 GET cTelefo  PICTURE "@!"
         @ 12, 24 get cMunici  picture "@!"
         @ 13, 24 get cUf      picture "@!" valid Estados(cUf)
         @ 14, 24 GET cInscMn  PICTURE "@!"
         @ 15, 24 get cInscEs  picture "@!"
         @ 16, 24 get cCgC     picture "@!"
         read
         if (confirma("Os Dados Est„o Corretos"))
            if (linclui)
               append blank
            endif
            replace Codigo    with cCodigo
            replace nome      with cnome
            replace Ender     with cEnder
            REPLACE TELEFONE  WITH cTelefo
            replace Munici    With cMunici
            replace uf        WITH cUf
            replace InscMn    with cInscMn
            replace InscEs    with cInscEs
            replace CGC       with cCgc
         endif
      endif
      lCont:= confirma("Deseja Continuar na Manuten‡„o de Clientes?")
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOF
