#include "common.ch"
#include "inkey.ch"

********************************

   local Local1
   Local1:= .T.
   select 1
   use CEBPED index CEIPED
   select 2
   use CEBCLI index CEICLI, CEICLI2
   select 3
   use CEBpre index CEIpre2
   select 4
   use CEBORC index CEIORC
   sombra(4, 2, 20, 71)
   @  4, 29 say "Manuten‡„o de Pedidos"
   @  5,  3 say "Pedido.........:"
   @  6,  3 say "Data...........:"
   @  7,  3 say "Codigo Cliente.:"
   @  8,  3 say "Nome...........:"
   @  9,  3 say "Condicoes.Pagto:"
   @ 10,  3 say "Fazenda........:"
   @ 11,  3 say "Cidade(Fazenda):"
   @ 12,  3 say "Estado(Fazenda):"
   @ 13,  3 say "Programa Entre.:"
   @ 14,  3 say "Frete(SACO)....:"
   @ 15,  3 say "Desconto(venda):        %"
   @ 16,  3 say "Obsevacoes.....:"
   @ 17,  3 say "Roteiro fazenda:"
   save screen to stela1
   corcli:= SetColor()
   a_matopc:= array(4, 3)
   a_matopc:= {{12, 20, "Imprime"}, {12, 29, "Altera"}, {12, 37, ;
      "Exclui"}, {12, 45, "Volta"}}
   do while (Local1)
      select 1
      restore screen from stela1
      set color to (corcli)
      npedido:= 0
      linclui:= .F.
      @  5, 20 get nPedido picture "999999"
      read
      select 1
      if (Empty(npedido) .AND. LastKey() = K_ENTER)
         nproc:= tabela()
         if (Empty(nproc))
            loop
         endif
         npedido:= pedido
         @  5, 20 get nPedido picture "@!"
         clear gets
      elseif (Empty(npedido) .AND. LastKey() = K_ESC)
         exit
      endif
      set color to (corcli)
      seek npedido
      if (!Found())
         ctexto:= "Pedido nao encontrado ! Incluir Pedido?"
         linclui:= confirma(ctexto)
         ddata:= data_sis
         ccondi:= Space(40)
         cfazenda:= Space(40)
         cmunfaz:= Space(30)
         cestfaz:= Space(2)
         nfrete:= 0
         ndesc:= 0
         nacdiv:= 0
         dprog_ent:= CToD("  /  /  ")
         cobs:= Space(50)
         crot_faz1:= Space(50)
         crot_faz2:= Space(50)
         crot_faz3:= Space(50)
         crealizado:= " "
         ccodigo:= Space(6)
         cnome:= Space(40)
         crg:= Space(15)
         ccpf:= Space(15)
         cince:= Space(15)
         cende:= Space(40)
         ccid:= Space(30)
         cest:= Space(2)
         ccep:= Space(9)
         ctel:= Space(15)
         opc:= 4
         amatmat:= array(10, 3)
         for i:= 1 to 10
            amatmat[i][1]:= 0
            amatmat[i][2]:= Space(40)
            amatmat[i][3]:= 0
         next
      else
         linclui:= .F.
         ddata:= data
         ccondi:= condicao
         cfazenda:= fazenda
         cmunfaz:= municipio
         cestfaz:= estado
         dprog_ent:= prog
         cobs:= obs
         nfrete:= frete
         ndesc:= desc
         crot_faz1:= rot_faz1
         crot_faz2:= rot_faz2
         crot_faz3:= rot_faz3
         ccodigo:= cod_cli
         crealizado:= realizado
         select 2
         seek ccodigo
         if (!Found())
            mensagem("O Cliente " + ccodigo + ;
               "foi exluido!! Nao posso obter seus dados!!")
            loop
         endif
         cnome:= nome
         crg:= rg
         ccpf:= cpf
         cince:= insc
         cende:= endereco
         ccid:= cidade
         cest:= estado
         ccep:= cep
         ctel:= telefone
         select 4
         seek npedido
         if (Found())
            i:= 1
            amatmat:= array(1, 3)
            do while (npedido1 = npedido)
               AAdd(amatmat, {0, Space(40), 0})
               amatmat[i][1]:= nqtdmat
               amatmat[i][2]:= cmat
               amatmat[i][3]:= nvalunit
               i++
               skip 
            enddo
         else
            amatmat:= array(10, 3)
            for i:= 1 to 10
               amatmat[i][1]:= 0
               amatmat[i][2]:= Space(40)
               amatmat[i][3]:= 0
            next
         endif
         select 1
         @  6, 20 say ddata picture "99/99/99"
         @  7, 20 say ccodigo picture "@!"
         @  8, 20 say cnome picture "@!"
         @  9, 20 say ccondi picture "@!"
         @ 10, 20 say cfazenda picture "@!"
         @ 11, 20 say cmunfaz picture "@!"
         @ 12, 20 say cestfaz picture "@!"
         @ 13, 20 say dprog_ent picture "99/99/99"
         @ 14, 20 say nfrete picture "999.99"
         @ 15, 20 say ndesc picture "999.99"
         @ 16, 20 say cobs picture "@!"
         @ 17, 20 say crot_faz1 picture "@!"
         @ 18, 20 say crot_faz2 picture "@!"
         @ 19, 20 say crot_faz3 picture "@!"
         save screen to tela_ant
         cor:= SetColor("GR+/B")
         InKey(5)
         sombra(10, 19, 14, 52)
         set color to R/N
         @ 11, 30 say "Pedido Existente:"
         opc:= botao(a_matopc)
         set color to (cor)
         restore screen from tela_ant
         if (opc = 0 .OR. opc = 4)
            loop
         endif
         if (opc == 3)
            if (confirma("Excluir Pedido ?"))
               delete
               select 4
               npedido:= 0
               opc:= 4
            endif
         endif
      endif
      if (opc = 2 .OR. linclui)
         @  6, 20 get dData picture "99/99/99" valid dia_util(ddata)
         read
         @  7, 20 get cCodigo picture "@!"
         read
         select 2
         set order to 2
         set color to (corcli)
         if (Empty(ccodigo) .AND. LastKey() = K_ENTER)
            nproc:= tabela()
            if (Empty(nproc))
               loop
            endif
            ccodigo:= codigo
            @  7, 20 get cCodIGO picture "@!"
            clear gets
         elseif (Empty(ccodigo) .AND. LastKey() = K_ESC)
            loop
         endif
         set color to (corcli)
         set order to 1
         seek ccodigo
         if (!Found())
            mensagem("Cliente Nao Cadastrado!")
            loop
         endif
         cnome:= nome
         crg:= rg
         ccpf:= cpf
         cince:= insc
         cende:= endereco
         ccid:= cidade
         cest:= estado
         ccep:= cep
         ctel:= telefone
         @  8, 20 get Nome
         clear gets
         @  9, 20 get cCondi picture "@!"
         @ 10, 20 get cFazenda picture "@!"
         @ 11, 20 get cMunFaz picture "@!"
         @ 12, 20 get cEstFaz picture "@!"
         @ 13, 20 get dProg_ent picture "99/99/99" valid ;
            dia_util(dprog_ent)
         @ 14, 20 get nFrete picture "999.99"
         @ 15, 20 get nDesc picture "999.99"
         @ 16, 20 get cObs picture "@!"
         @ 17, 20 get cRot_faz1 picture "@!"
         @ 18, 20 get cRot_faz2 picture "@!"
         @ 19, 20 get cRot_faz3 picture "@!"
         read
         centra(24, "<ESC> - Volta ; <F1> - Help;", "gr+/bg")
         sombra(7, 0, 20, 77)
         @  7, 30 say "Produtos Encomendados:"
         @  8,  1 say "Sacos|Produto " + Space(32) + "|Valor Total"
         for n:= 9 to 18
            @ n,  6 say "|"
            @ n, 47 say "|"
         next
         select 4
         nacdiv:= 0
         DBEval({|| dbDelete()}, {|| npedido1 = npedido}, Nil, Nil, ;
            Nil, .F.)
         select 3
         for m:= 9 to 18
            @ m,  2 get aMatmat[m - 8][1] picture "9999" valid ;
               amatmat[m - 8][1] != 0
            @ m,  7 get aMatmat[m - 8][2] picture "@!" valid ;
               acha(amatmat[m - 8][2])
            read
            amatmat[m - 8][3]:= valunitv
            amatmat[m - 8][2]:= produto
            @ m,  7 get aMatmat[m - 8][2]
            @ m, 48 say amatmat[m - 8][3] * amatmat[m - 8][1] ;
               picture "99,999,999.99"
            clear gets
            nacdiv:= nacdiv + amatmat[m - 8][3] * amatmat[m - 8][1]
            @ 19,  8 say "Valor do Orcamento:"
            @ 19, Col() say nacdiv picture "99,999,999.99"
            if (LastKey() == K_ESC)
               m:= 9
               exit
            endif
         next
         lrealiza:= .F.
         if (!confirma("Os dados Estao corretos ?"))
            if (!linclui)
               set deleted off
               select 4
               DBEval({|| dbRecall()}, {|| npedido1 = npedido}, Nil, ;
                  Nil, Nil, .F.)
               set deleted on
            endif
            loop
         endif
         select 1
         if (linclui)
            append blank
         endif
         replace pedido with npedido
         replace data with ddata
         replace cod_cli with ccodigo
         replace fazenda with cfazenda
         replace municipio with cmunfaz
         replace estado with cestfaz
         replace condicao with ccondi
         replace prog with dprog_ent
         replace obs with cobs
         replace rot_faz1 with crot_faz1
         replace rot_faz2 with crot_faz2
         replace rot_faz3 with crot_faz3
         replace frete with nfrete
         replace desc with ndesc
         replace realizado with iif(realizado != "S" .AND. lrealiza, ;
            "S", "N")
         select 4
         for o:= 1 to 10
            if (Empty(amatmat[o][1]))
               exit
            endif
            append blank
            replace npedido1 with npedido
            replace ccod_cli with ccodigo
            replace cmat with amatmat[o][2]
            replace nqtdmat with amatmat[o][1]
            replace nvalunit with amatmat[o][3]
         next
      endif
      if (opc = 2 .OR. linclui .OR. opc = 1)
         if (confirma("Deseja Imprimir Nota de Pedido ?"))
            select 1
            mensagem("Verifique a Impressora")
            if (!isprinter())
               mensagem("A Impressora nao esta pronta!")
               loop
            endif
            set console off
            set device to printer
            @  0,  0 say Replicate("=", 80)
            @  1, 20 say "Nota de Pedido"
            @  2,  0 say Replicate("=", 80)
            @  3,  2 say "Pedido No: " + Str(pedido, 6, 0)
            @  3, 65 say "Data: " + DToC(data)
            @  5,  0 say "+"
            @  5,  1 say Replicate("-", 78)
            @  5, 79 say "+"
            @  6,  2 say "Codigo do Cliente.: " + ccodigo
            @  7,  2 say "Nome do Cliente...: " + cnome
            @  8,  2 say "Endereco..........: " + cende
            @  9,  2 say "Cidade............: " + ccid
            @  9, PCol() + 2 say "Estado: " + cest
            @ 10,  2 say "C.E.P.: " + ccep
            @ 10, PCol() + 2 say "Fone/Fax.: " + ctel
            @ 11,  2 say "R.G.:" + crg
            @ 11, PCol() + 1 say "C.P.F.:" + ccpf
            @ 12,  2 say "Insc. Estadual:" + cince
            @ 13,  2 say "Valor do Frete(por Saco)..:" + Str(nfrete, ;
               6, 2)
            @ 13, PCol() + 2 say "|   Desconto..:" + Str(ndesc, 6, ;
               2) + "%"
            @ 14,  0 say "+"
            @ 14,  1 say Replicate("-", 78)
            @ 15, 79 say "+"
            @ 15,  0 say "|Quantidade|Material" + Space(32) + ;
               "| Valor Total |"
            nsomatotal:= 0
            for i:= 1 to Len(amatmat)
               if (Empty(amatmat[i][1]))
                  exit
               endif
               @ 15 + i,  0 say "|"
               @ 15 + i,  1 say amatmat[i][1] picture "9999"
               @ 15 + i, PCol() + 6 say "|"
               @ 15 + i, PCol() say amatmat[i][2]
               @ 15 + i, PCol() say "|"
               @ 15 + i, PCol() say amatmat[i][1] * amatmat[i][3] ;
                  picture "99,999,999.99"
               @ 15 + i, PCol() say "|"
               nsomatotal:= nsomatotal + amatmat[i][1] * amatmat[i][3]
            next
            @ PRow() + 1,  0 say "Total" + Replicate("-", 48)
            @ PRow(), PCol() say nsomatotal picture "99,999,999.99"
            @ PRow() + 1,  0 say "Total(Com Desconto)" + ;
               Replicate("-", 34)
            @ PRow(), PCol() say nsomatotal - nsomatotal * ndesc / ;
               100 picture "99,999,999.99"
            n:= PRow() + 1
            @ n,  0 say "+"
            @ n,  1 say Replicate("-", 78)
            @ n, 79 say "+"
            @ PRow() + 1,  2 say "Fazenda.....................: " + ;
               fazenda
            @ PRow() + 1,  2 say "Municipio...................: " + ;
               municipio
            @ PRow(), PCol() say "Estado: " + estado
            @ PRow() + 1,  2 say "Condicao....................: " + ;
               condicao
            @ PRow() + 1,  2 say "Data Programada Para Entrega: " + ;
               DToC(prog)
            @ PRow() + 1,  2 say "Observacao: " + obs
            @ PRow() + 1,  2 say "Roteiro da Fazenda :"
            @ PRow(), 23 say rot_faz1
            @ PRow() + 1, 23 say rot_faz2
            @ PRow() + 1, 23 say rot_faz3
            @ PRow() + 1,  0 say Replicate("_", 80)
            eject
            set device to screen
            set console on
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manutencao de Pedidos?")
   enddo
   set deleted on
   close databases
   select 1
   close format
   release all
   return

* EOF
