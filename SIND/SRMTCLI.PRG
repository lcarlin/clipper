#include "common.ch"
#include "inkey.ch"
 
********************************
 
   local Local1
   Local1:= .T.
   use SRBCLI index SRICLI, SRICLI2
   sombra(4,1, 21, 76)
   @ 04, 25 say "Manuten‡„o de Clientes"
   @ 05,  2 say "Matricula N§..:"
   @ 06,  2 say "Nome..........:"
   @ 07,  2 say "Nome do Pai...:"
   @ 08,  2 say "Nome da M„e...:"
   @ 09,  2 say "Estado Civil:"
   @ 09,col()+16 say "Nacionalidade:"
   @ 10,  2 say "Naturalidade:"
   @ 10,col()+31 say "Data de Nasc:"
   @ 11,  2 say "Residencia....:"
   @ 12,  2 say "Endereco......:"
   @ 13,  2 say "Firma.........:"
   @ 14,  2 SAY "Endereco da Fazenda:"
   @ 15,  2 SAY "Telefone da Fazenda:"
   @ 16,  2 SAY "Cargo Ocupado.:"
   @ 17,  2 SAY "Carteira Profissional:"
   @ 17,col()+32 SAY "Serie:"
   @ 18,  2 SAY "Endereco de Cobran‡a:"
   @ 19,  2 SAY "Titulo de Eleitor:"
   @ 20,  2 SAY "Carteira de Reservista:"
   @ 20,col()+22 SAY "Data da admissao:"
   save screen to stela1
   corcli:= SetColor()
   mopcao:= array(3, 3)
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
   do while (Local1)
      restore screen from stela1
      set color to (corcli)
      cCod:= Space(6)
      linclui:= .F.
      alter:= 0
      @  5, 18 get cCod picture "@!"
      read
      if (Empty(ccod) .AND. LastKey() = K_ENTER)
         set order to 2
         setcolor("gr+/bg+")
         nproc:= tabela()
         setcolor(corcli)
         if (Empty(nproc)) .or. empty(matricula)
            loop
         endif
         ccod:= matricula
         @  5, 18 get cCod picture "@!"
         clear gets
      elseif (Empty(ccod) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek ccod
      if (!Found())
         cNome      := Space(40)
         cPai       := space(40)
         cMae       := space(40)
         cEstCivil  := space(15)
         cnacional  := space(20)
         cNatural   := space(30)
         dNasc      := ctod("  /  /  ")
         cReside    := space(20)
         cEndereco  := space(40)
         cFirma     := space(30)
         cEnd_faz   := space(45)
         cTel_faz   := space(15)
         cCargo     := space(20)
         cCart_pro  := space(30)
         cCart_ser  := space(10)
         cEnd_cobra := space(40)
         cEleitor   := space(25)
         cReserva   := space(20)
         cAdmicao  := data_sis
         mObs       := space(10)
         linclui:= ;
            confirma("Numero de maticula n„o cadastrado! Deseja Cadastrar ?")
      else
         @ 06, 18 SAY Nome
         @ 07, 18 SAY Pai
         @ 08, 18 SAY Mae
         @ 09, 15 SAY EstCivil
         @ 09,col()+16 say Nacionali
         @ 10, 15 SAY  Natural
         @ 10,col()+14 say Nasc
         @ 11, 18 SAY Resid
         @ 12, 18 SAY Endereco
         @ 13, 18 SAY Firma
         @ 14, 23 SAY End_faz
         @ 15, 23 SAY Telefone
         @ 16, 18 SAY Cargo
         @ 17, 25 SAY Cart_pro
         @ 17,col()+7 SAY Cart_ser
         @ 18, 24 SAY End_cobra
         @ 19, 21 SAY Eleitor
         @ 20, 26 SAY Reserva
         @ 20,col()+18 SAY Admicao
         InKey(5)
         save screen to stela_ant
         setcolor("gr+/r")
         sombra(10, 18, 14, 46)
         @ 11, 20 say "Codigo Existente:"
         alter:= botao(mopcao)
         set color to (corcli)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?"))
               delete
               COMMIT
            endif
         elseif (alter = 3 .OR. alter = 0)
            loop
         ELSEIF ALTER = 1
            cNome      := NOME
            cPai       := PAI
            cMae       := MAE
            cEstCivil  := ESTCIVIL
            cnacional  := NACIONALI
            cNatural   := NATURAL
            dNasc      := NASC
            cReside    := RESID
            cEndereco  := ENDERECO
            cFirma     := FIRMA
            cEnd_faz   := END_FAZ
            cTel_faz   := TELEFONE
            cCargo     := CARGO
            cCart_pro  := CART_PRO
            cCart_ser  := CART_SER
            cEnd_cobra := END_COBRA
            cEleitor   := ELEITOR
            cReserva   := RESERVA
            cAdmicao   := ADMICAO
            mObs       := OBS
         endif
      endif
      if (linclui .OR. alter = 1)
         @ 06, 18 GET cNome
         @ 07, 18 GET cPai
         @ 08, 18 GET cMae
         @ 09, 15 GET cEstCivil
         @ 09,col()+16 GET cNacional
         @ 10, 15 GET  cNatural
         @ 10,col()+14 GET dNasc
         @ 11, 18 GET cReside
         @ 12, 18 GET cEndereco
         @ 13, 18 GET cFirma
         @ 14, 23 GET cEnd_faz
         @ 15, 23 GET cTel_faz
         @ 16, 18 GET cCargo
         @ 17, 25 GET cCart_pro
         @ 17,col()+7 GET cCart_ser
         @ 18, 24 GET cEnd_cobra
         @ 19, 21 GET cEleitor
         @ 20, 26 GET cReserva
         @ 20,col()+18 GET cAdmicao
         read
         if (confirma("Deseja anotar Observa‡oes ?"))
            mobs := obser(.T., mobs)
         endif
         if (confirma("Os Dados Estao Corretos"))
            if (linclui)
               append blank
            endif
            REPLACE matricula  WITH  cCod  ,;
                    NOME       WITH  cNome        ,;
                    PAI        WITH  cPai         ,;
                    MAE        WITH  cMae         ,;
                    ESTCIVIL   WITH  cEstCivil    ,;
                    NACIONALI  WITH  cnacional    ,;
                    NATURAL    WITH  cNatural     ,;
                    NASC       WITH  dNasc        ,;
                    RESID      WITH  cReside      ,;
                    ENDERECO   WITH  cEndereco    ,;
                    FIRMA      WITH  cFirma       ,;
                    END_FAZ    WITH  cEnd_faz     ,;
                    TELEFONE   WITH  cTel_faz     ,;
                    CARGO      WITH  cCargo       ,;
                    CART_PRO   WITH  cCart_pro    ,;
                    CART_SER   WITH  cCart_ser    ,;
                    END_COBRA  WITH  cEnd_cobra   ,;
                    ELEITOR    WITH  cEleitor     ,;
                    RESERVA    WITH  cReserva     ,;
                    ADMICAO    WITH  cAdmicao    ,;
                    OBS        WITH  mObs
            COMMIT
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manuten‡„o de Clientes?")
   enddo
   release all
   close databases
   select 1
   close format
   return
* Eop srmtcli.prg
