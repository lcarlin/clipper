/* 
bop cfmtfili.prg
data   24-01-96
funcao cadastro de filiados
autor  luiz a. c.
sistema controle de filiados
linguagem clipper 5.2
*/
#include "INKEY.CH"
   local lCont
   lCont:= .T.
   use CFBFILIA index CFIFILI1, CFIFILI2
   @  8,  5 say "Titulo N§........:"
   @  9,  5 say "Nome.............:"
   @ 10,  5 say "Se‡„o............:"
   @ 11,  5 say "Data da Filia‡„o.:"
   @ 12,  5 say "N§ de Inscric„o..:"
   @ 13,  5 SAY "Partido..........:"
   @ 14,  5 say "Endere‡o.........:"
   @ 15,  5 say "Bairro ..........:"
   @ 16,  5 say "Cidade...........:"
   @ 17,  5 say "U.F..............:"
   @ 18,  5 say "C.E.P............:"
   centra(24,"<ESC> - Sai ; <ENTER> - Tabela",cCorTt)
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   
   do while (lCont)
      restore screen from stela1
      set color to (corcli)
      cTitulo := Space(15)
      linclui:= .F.
      alter:= 0
      @  8, 24 get cTitulo picture "@!"
      read
      if (Empty(cTitulo) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         if (Empty(nproc))
            loop
         endif
         cTitulo:= titulo
         @  8, 24 get cTitulo picture "@!"
         clear gets
      elseif (Empty(cTitulo) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek cTitulo
      if (!Found())
         cnome    := Space(40)
         cSecao   := Space(04)
         dDatFili := DATA_SIS
         cInscr   := space(05)
         cPartido := space(06)
         cende    := Space(40)
         cCidade  := Space(30)
         cUf      := Space(2)
         ccep     := Space(9)
         cBairro  := Space(25)
         linclui  := ;
            confirma("Titulo n„o cadastrado! Deseja Cadastrar ?")
      else
         cnome    := nome
         cSecao   := Secao
         dDatFili := Filiacao
         cInscr   := Inscricao
         cPartido := Partido
         cende    := endereco
         cCidade  := cidade
         cUf      := Uf
         ccep     := cep
         cBairro  := bairro
         @  9, 24 say cnome    picture "@!"
         @ 10, 24 say cSecao   picture "@!"
         @ 11, 24 say dDatFili picture "@!"
         @ 12, 24 say cInscr   picture "@!"
         @ 13, 24 say cPartido PICTURE "@!"
         @ 14, 24 say cende    picture "@!"
         @ 15, 24 say cBairro  picture "@!"
         @ 16, 24 say cCidade  picture "@!"
         @ 17, 24 say cUf      picture "@!"
         @ 18, 24 say cCep     picture "@!"
         InKey(5)
         save screen to stela_ant
         set color to gr+/b
         sombra(10, 18, 14, 46)
         @ 11, 20 say "Titulo Existente:" color "R/n"
         set color to (corcli)
         alter:= botao(mopcao,,cCorBin,cCorBat)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?"))
               delete
            endif
         elseif (alter = 3 .OR. alter = 0)
            loop
         endif
      endif
      if (linclui .OR. alter = 1)
         @  9, 24 get cNome    picture "@!"
         @ 10, 24 get cSecao   picture "@!"
         @ 11, 24 get dDatFili picture "@!"
         @ 12, 24 get cInscr   picture "@!"
         @ 13, 24 GET cPartido PICTURE "@!"
         @ 14, 24 get cEnde    picture "@!"
         @ 15, 24 get cBairro  picture "@!"
         @ 16, 24 get cCidade  picture "@!" 
         @ 17, 24 get cUf      picture "@!" valid Estados(cUf)
         @ 18, 24 get cCep     picture "@!"
         read
         if (confirma("Os Dados Est„o Corretos"))
            if (linclui)
               append blank
            endif
            replace titulo    with cTitulo
            replace nome      with cnome
            replace Secao     with cSecao
            replace Filiacao  With dDatFili
            replace Partido   WITH cPartido
            replace Inscricao with cInscr
            replace endereco  with cende
            replace cidade    with cCidade
            replace Uf        with cUf
            replace cep       with ccep
            replace bairro    with cBairro
         endif
      endif
      lCont:= confirma("Deseja Continuar na Manuten‡„o de Filiados?")
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOF
