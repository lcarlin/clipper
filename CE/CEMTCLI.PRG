#include "common.ch"
#include "inkey.ch"

********************************

   local Local1
   Local1:= .T.
   use CEBCLI index CEICLI, CEICLI2
   sombra(7, 7, 19, 66)
   @  7, 25 say "Manuten‡„o de Clientes"
   @  8,  8 say "Codigo........:"
   @  9,  8 say "Nome..........:"
   @ 10,  8 say "R.G...........:"
   @ 11,  8 say "C.P.F.........:"
   @ 12,  8 say "Insc. Estadual:"
   @ 13,  8 say "Endere‡o......:"
   @ 14,  8 say "Cidade........:"
   @ 15,  8 say "Estado........:"
   @ 16,  8 say "C.E.P.........:"
   @ 17,  8 say "Tel. Fax......:"
   @ 18,  8 say "Obs...........:"
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   do while (Local1)
      restore screen from stela1
      set color to (corcli)
      ccod:= Space(6)
      linclui:= .F.
      alter:= 0
      @  8, 24 get cCod picture "@!"
      read
      if (Empty(ccod) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         if (Empty(nproc))
            loop
         endif
         ccod:= codigo
         @  8, 24 get cCod picture "@!"
         clear gets
      elseif (Empty(ccod) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek ccod
      if (!Found())
         cnome:= Space(40)
         crg:= Space(20)
         ccpf:= Space(20)
         cince:= Space(20)
         cende:= Space(40)
         ccid:= Space(30)
         cest:= Space(2)
         ccep:= Space(9)
         ctel:= Space(15)
         mobs:= Space(10)
         linclui:= ;
            confirma("Codigo nao cadastrado! Deseja Cadastrar ?")
      else
         cnome:= nome
         crg:= rg
         ccpf:= cpf
         cince:= insc
         cende:= endereco
         ccid:= cidade
         cest:= estado
         ccep:= cep
         ctel:= telefone
         mobs:= obs
         @  9, 24 say cnome picture "@!"
         @ 10, 24 say crg picture "@!"
         @ 11, 24 say ccpf picture "@!"
         @ 12, 24 say cince picture "@!"
         @ 13, 24 say cende picture "@!"
         @ 14, 24 say ccid picture "@!"
         @ 15, 24 say cest picture "@!"
         @ 16, 24 say ccep picture "@!"
         @ 17, 24 say ctel picture "@!"
         InKey(5)
         save screen to stela_ant
         set color to gr+/b
         sombra(10, 18, 14, 46)
         @ 11, 20 say "Codigo Existente:" color "R/n"
         set color to (corcli)
         alter:= botao(mopcao)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?"))
               delete
               COMMIT
            endif
         elseif (alter = 3 .OR. alter = 0)
            loop
         endif
      endif
      if (linclui .OR. alter = 1)
         @  9, 24 get cNome picture "@!"
         @ 10, 24 get cRG picture "@!"
         @ 11, 24 get cCpf picture "@!"
         @ 12, 24 get cInce picture "@!"
         @ 13, 24 get cEnde picture "@!"
         @ 14, 24 get cCid picture "@!"
         @ 15, 24 get cEst picture "@!" valid estados(cest)
         @ 16, 24 get cCep picture "@!"
         @ 17, 24 get cTel picture "@!"
         read
         if (confirma("Deseja anotar Observacoes ?"))
            mobs:= obser(.T., mobs)
         endif
         if (confirma("Os Dados Estao Corretos"))
            if (linclui)
               append blank
            endif
            replace codigo with ccod
            replace nome with cnome
            replace rg with crg
            replace cpf with ccpf
            replace insc with cince
            replace endereco with cende
            replace cidade with ccid
            replace estado with cest
            replace cep with ccep
            replace telefone with ctel
            replace obs with mobs
            COMMIT
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manutencao de Clientes?")
   enddo
   release all
   close databases
   select 1
   close format
   return

* EOF
