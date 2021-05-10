#include "common.ch"
#include "inkey.ch"

********************************

   parameters tipo_r
   public nvl_total:= nsbtot:= nvldeb:= nvlcre:= nlucro:= 0
   public nlucro1:= nlucro2:= nlucrotot:= naclucro:= nvalunitv:= ;
      nvalorest:= 0
   do case
   case tipo_r = 1 .OR. tipo_r = 2
      IF .not. file("PORCENT.MEM")
         config()
      ENDIF
      restore from porcent additive
      select 3
      use CEBMEST index CEIMEST
      select 2
      if (tipo_r == 1)
         use CEBFOR index CEIFOR
      else
         use CEBCLI index CEICLI
      endif
      select 3
      set filter to IF(tipo_R = 1,TIPO = "C" ,TIPO = "V")
      goto top
      ctipor2:= iif(tipo_r = 1, "C", "V")
      ctiporel:= iif(tipo_r = 1, "Entrada", "Saida")
      cpesrel:= iif(tipo_r = 1, " Fornecedor ", " Cliente ")
      cabec_t:= "Relatorio de " + ctiporel + " de Estoque"
      var_tit:= "| Produto" + Space(32) + "|" + iif(tipo_r = 1, ;
         "Fornecedor", " Cliente  ") + Space(30) + ;
         "|Qtd |Val. Total| Data   |" + iif(tipo_r = 2, "ICMS " + ;
         Str(nporicms, 2, 0) + "%   |LUCRO-ICMS|", "")
      amatopc:= array(4, 3)
      amatopc:= {{12, 5, "Todos os Materiais"}, {12, 25, ;
         "Determinada data(MM/AA)"}, {12, 50, "Por" + cpesrel}, {12, ;
         66, "Cancelar"}}
      sombra(11, 4, 14, 75)
      @ 11, 20 say "Escolha a opcao para o relatorio de " + ctiporel ;
         + ":"
      nopc:= botao(amatopc)
      if (nopc = 0 .OR. nopc = 4)
         close databases
         select 1
         close format
         return
      endif
      if (nopc == 2)
         amatopc:= array(4, 3)
         amatopc:= {{12, 4, "Determinado Periodo"}, {12, 25, ;
            "Determinada data"}, {12, 43, "Semana Anterior"}, {12, ;
            60, "Cancelar"}}
         sombra(11, 3, 14, 70)
         nopc2:= 0
         nopc2:= botao(amatopc)
         if (nopc2 = 0 .OR. nopc2 = 4)
            close databases
            select 1
            close format
            return
         endif
         if (nopc2 == 1)
            ddata1:= ddata2:= CToD("  /  /  ")
            sombra(11, 12, 14, 60)
            @ 12, 13 say "Entre com a Data de Inicio  :" get dData1 ;
               picture "99/99/99"
            @ 13, 13 say "Entre com a data de Termino :" get dData2 ;
               picture "99/99/99"
            read
            if (LastKey() = K_ESC .OR. Empty(ddata1) .OR. ;
                  Empty(ddata2))
               close databases
               select 1
               close format
               return
            endif
            set filter to IF(tipo_R=1,TIPO="C",TIPO="V") .AND. ;
               DATA_NEG >= dData1 .AND. DATA_NEG <= dData2
            goto top
            cabec_t:= "Relatorio de " + ctiporel + ;
               " de Estoque(Determinado Periodo)"
         elseif (nopc2 == 2)
            save screen to stela_ant
            dano:= "  "
            dmes:= "  "
            apre:= setcursor(1)
            sombra(12, 19, 14, 51)
            @ 13, 20 say "Entre com a data (MM/AA)" color "BG/N"
            @ 13, 45 get dMes picture "99" valid Val(dmes) > 0 .AND. ;
               Val(dmes) <= 12
            @ 13, 47 say "/" color "W/R"
            @ 13, 48 get dAno picture "99"
            read
            setcursor(apre)
            if (LastKey() = K_ESC .OR. Empty(dmes) .OR. Empty(dano))
               close databases
               select 1
               close format
               return
            endif
            dat_fil:= dmes + "/" + dano
            amatop2:= array(4, 3)
            amatop2:= {{11, 19, "Todo o Mes"}, {11, 31, ;
               "1§ Quinzana"}, {11, 44, "2§ Quinzena"}, {11, 57, ;
               "Cancelar"}}
            sombra(10, 18, 13, 66)
            nopc2:= botao(amatop2)
            if (nopc2 = 0 .OR. nopc2 = 4)
               close databases
               select 1
               close format
               return
            endif
            restore screen from stela_ant
            if (nopc2 == 1)
               set filter to tipo = IF(tipo_R=1,"C","V") .AND. ;
                  substr(dtoc(data_Neg),4,8) = dat_fil
               goto top
               cabec_t:= "Relatorio de " + ctiporel + ;
                  " de Estoque(Todo o Mes)"
            elseif (nopc2 = 2 .OR. nopc2 = 3)
               cdia:= iif(nopc2 = 2, "01", "16")
               ctemp:= iif(nopc2 = 2, "15/" + dmes + "/" + dano, ;
                  "31/" + dmes + "/" + dano)
               ddata2:= CToD(ctemp)
               dat_fil:= CToD(cdia + "/" + dmes + "/" + dano)
               set filter to (data_neg>= dat_fil  .AND. ;
                  dtoc(data_neg) <= ctemp) .AND. tipo= if(tipo_R=1, ;
                  "C","V")
               goto top
               cabec_t:= "Relatorio de " + ctiporel + ;
                  " de Estoque(Data Determinada- " + iif(nopc2 = 2, ;
                  "1§ ", "2§ ") + "Quinzena"
            endif
         elseif (nopc2 == 3)
            set filter to IF(tipo_R=1,TIPO="C",TIPO="V") .AND. ;
               (data_NEG>=data_sis-7 .AND. data_NEG<=data_sis)
            goto top
            cabec_t:= "Relatorio de " + ctiporel + ;
               " de Estoque(Semana Anterior)"
         endif
      elseif (nopc == 3)
         sombra(11, 20, 13, 65)
         ccodcli:= Space(6)
         select 2
         @ 12, 21 say "Entre com o Codigo do" + cpesrel + ":" get ;
            cCodCli picture "@!"
         read
         corcli:= SetColor()
         if (Empty(ccodcli) .AND. LastKey() = K_ENTER)
            nproc:= tabela()
            if (Empty(nproc))
               close databases
               select 1
               close format
               return
            endif
            ccodcli:= codigo
            @ 12, 21 say "Entre com o Codigo do" + cpesrel + ":" get ;
               cCodCli picture "@!"
            clear gets
         elseif (Empty(ccodcli) .AND. LastKey() = K_ESC)
            close databases
            select 1
            close format
            return
         endif
         set color to (corcli)
         goto top
         select 3
         locate for cod_pes = ccodcli
         if (!Found())
            mensagem("Codigo nao cadastrado! ")
            close databases
            select 1
            close format
            return
         endif
         amatopc:= array(3, 3)
         amatopc:= {{15, 20, "Geral"}, {15, 28, ;
            "Determidado Periodo"}, {15, 49, "Cancelar"}}
         sombra(14, 19, 17, 59)
         @ 14, 30 say "Tipo de Relatorio :"
         nopc2:= botao(amatopc)
         if (nopc2 = 3 .OR. nopc2 = 0)
            close databases
            select 1
            close format
            return
         endif
         select 3
         if (nopc2 == 2)
            cmes:= "  "
            cano:= "  "
            sombra(15, 25, 18, 47)
            @ 16, 26 say "Entre com o Periodo:"
            @ 17, 35 get cMes picture "99"
            @ 17, Col() say "/" color "W/R"
            @ 17, Col() get cAno picture "99"
            read
            if (LastKey() == K_ESC)
               close databases
               select 1
               close format
               return
            endif
            cfiltro:= cmes + "/" + cano
            set filter to tipo = cTipor2 .AND. cod_pes = cCodCli ;
               .AND. substr(dtoc(DATA_NEG),4,5)= cFiltro
         else
            set filter to tipo = cTipor2 .AND. cod_pes = cCodCli
         endif
         goto top
         cabec_t:= "Relatorio de " + ctiporel + " de Estoque(" + ;
            LTrim(cpesrel) + "Determinado)"
      endif
   case tipo_r = 3
      USE CEBFOR INDEX CEIFOR, CEIFOR2 NEW
      USE CEBEST INDEX CEIEST2 NEW
      cabec_t := "Tabela de Pre‡os"
      // |Embalagem"+space(16)
      var_tit := "| Codigo |  Produto"+space(32)+" |  Vl Unitario |"
      aMatRel := {{12,07,"Todos os Materiais"},{12,27,"Por Categoria"},{12,42,"Por Fornecedor"},{12,58,"Cancelar"}}
      sombra(11,06,14,68)
      nOpcRela := botao(aMatRel)
      IF nOpcRela = 0 .OR. nOpcRela = 4
         close all
         RETURN
      ENDIF
      IF nOpcRela = 1
      ELSEIF nOpcRela = 2
         nProcura := ExisteCate()
         cCatego1 := substr(aCatego[nProcura],1,2)
         cCatego2 := substr(aCatego[nProcura],6,25)
         SET FILTER TO CATEGORIA = cCatego1
         GO TOP
         cTemp := cabec_t
         cabec_t := {}
         cabec_t := {cTemp,"Por Categoria:"+aCatego[nProcura]}
      ELSEIF nOpcRela = 3
         sombra(11, 20, 13, 65)
         ccodcli:= Space(6)
         SELE CEBFOR
         @ 12, 21 say "Entre com o Codigo do Fornecedor:" get ;
             cCodCli picture "@!"
         read
         corcli:= SetColor()
         if (Empty(ccodcli) .AND. LastKey() = 13)
            nproc:= tabela()
            if (Empty(nproc))
               close databases
               select 1
               close format
               return
            endif
            ccodcli:= codigo
            @ 12, 21 say "Entre com o Codigo do Fornecedor:" get ;
               cCodCli picture "@!"
            clear gets
         ELSEIF (empty(cCodCli) .AND. lastkey() = 27)
            CLOSE ALL
            RETURN
         ENDIF
         cNome := nome
         SELE CEBEST
         SET FILTER TO COD_PES = cCodCli
         GO TOP
         cTemp := cabec_t
         cabec_t := {}
         cabec_t := {cTemp,"Fornecedor Especifico: "+cNome}
      ENDIF
   case tipo_r = 4
      use cebcli index ceicli
      cabec_t:= "Relatorio de Clientes"
      var_tit:= "|Codigo| Nome" + Space(35) + "| Tel. Fax" + ;
         Space(6) + "| Cidade" + Space(23) + "|UF| Cep     |"
   case tipo_r = 5
      use cebfor index ceifor
      cabec_t:= "Relatorio de Fornecedores"
      var_tit:= "|Codigo| Nome" + Space(35) + "| Tel. Fax" + ;
         Space(6) + "| Cidade" + Space(23) + "| Empresa" + Space(22) ;
         + "|"
   case tipo_r = 6
      select 2
      use CEBFOR index CEIFOR
      use cebest new index ceiest
      cabec_t:= "Relatorio de Materiais em Estoque"
      var_tit:= "|Codigo| Produto" + Space(32) + "| Embalagem" + ;
         Space(15) + ;
         "| (COMPRA) |   (VENDA)|   (LUCRO)|  (TOTAL) |Qtd Min| Quant  |"
      amatopc:= array(3, 3)
      amatopc:= {{12, 14, "Todos os Materiais"}, {12, 35, ;
         "Por Fornecedor"}, {12, 51, "Cancelar"}}
      sombra(10, 13, 14, 72)
      @ 11, 16 say ;
         "Escolha a opcao para o relatorio de Materais em Estoque"
      nopc:= botao(amatopc)
      if (nopc = 0 .OR. nopc = 3)
         close databases
         select 1
         close format
         return
      elseif (nopc == 2)
         sombra(12, 20, 13, 65)
         ccodcli:= Space(6)
         select 2
         @ 12, 21 say "Entre com o Codigo do fornecedor:" get ;
            cCodCli picture "@!"
         read
         corcli:= SetColor()
         if (Empty(ccodcli) .AND. LastKey() = K_ENTER)
            nproc:= tabela()
            if (Empty(nproc))
               close databases
               select 1
               close format
               return
            endif
            ccodcli:= codigo
            cnome:= nome
            @ 12, 21 say "Entre com o Codigo do fornecedor:" get ;
               cCodCli picture "@!"
            clear gets
         elseif (Empty(ccodcli) .AND. LastKey() = K_ESC)
            close databases
            select 1
            close format
            return
         endif
         set color to (corcli)
         seek ccodcli
         if (!Found())
            mensagem("Codigo nao cadastrado! ")
            close databases
            select 1
            close format
            return
         endif
         cnome:= nome
         (2)->(dbCloseArea())
         select CEBEST
         set filter to cod_pes = cCodCli
         goto top
         private cabec_t[2]
         cabec_t[1]:= ;
            "Relatorio de Materiais em Estoque(Fornecedor Determinado)"
         cabec_t[2]:= "Codigo do Fornecedor:" + ccodcli + "  Nome:" ;
            + cnome
      endif
   case tipo_r = 7
      use ceblanca
      cabec_t:= "Relatorio de Lancamentos Diarios do Caixa"
      var_tit:= "| Descricao" + Space(30) + "| Valor    |  Data  |T|"
   case tipo_r = 8
      use ceblmc
      cabec_t:= "Relatorio de Lancamentos Mensais do Caixa"
      var_tit:= "| Descricao" + Space(30) + "| Valor    |  Data  |T|"
   case tipo_r = 9 .OR. tipo_r = 10
      use cebagen index ceiagen
      cdesrel:= iif(tipo_r = 9, "D", "C")
      ctiporel:= iif(tipo_r = 9, " Pagamentos ", " Recebimentos ")
      cpessoa:= iif(tipo_r = 9, " Fornecedor ", " Clientes   ")
      a_matop:= amatop2:= array(3, 3)
      a_matop:= {{11, 14, "Toda a Agenda"}, {11, 29, ;
         "Determinada Data"}, {11, 47, "Semana anterior"}, {11, 64, ;
         "Cancelar"}}
      amatop2:= {{11, 19, "Todo o Mes"}, {11, 31, "1§ Quinzana"}, ;
         {11, 44, "2§ Quinzena"}, {11, 57, "Cancelar"}}
      sombra(9, 13, 14, 74)
      @ 10, 19 say "Opcoes de Relatorios da Agenda :"
      opc:= botao(a_matop)
      if (opc = 0 .OR. opc = 4)
         close databases
         select 1
         close format
         return
      endif
      cabec_t:= "Relatorio" + ctiporel + "Agendados"
      set filter to tipo = cDesRel
      goto top
      if (opc == 2)
         save screen to stela_ant
         dano:= "  "
         dmes:= "  "
         apre:= setcursor(1)
         @ 13, 20 say "Entre com a data (MM/AA)" color "BG/N"
         @ 13, 45 get dMes picture "99" valid Val(dmes) > 0 .AND. ;
            Val(dmes) <= 12
         @ 13, 47 say "/" color "W/R"
         @ 13, 48 get dAno picture "99"
         read
         restore screen from stela_ant
         setcursor(apre)
         if (LastKey() = K_ESC .OR. Empty(dmes) .OR. Empty(dano))
            close databases
            select 1
            close format
            return
         endif
         sombra(10, 17, 13, 66)
         @ 10, 20 say "Escolha o Periodo:"
         nopc2:= botao(amatop2)
         if (nopc2 = 0 .OR. nopc2 = 4)
            close databases
            select 1
            close format
            return
         endif
         if (nopc2 == 1)
            dat_fil:= dmes + "/" + dano
            set filter to substr(dtoc(data_pg),4,8) = dat_fil .AND. ;
               tipo = cDesRel
            goto top
         elseif (nopc2 = 2 .OR. nopc2 = 3)
            cdia:= iif(nopc2 = 2, "01", "16")
            ddata2:= iif(nopc2 = 2, CToD("15/" + dmes + "/" + dano), ;
               CToD("31/" + dmes + "/" + dano))
            dat_fil:= CToD(cdia + "/" + dmes + "/" + dano)
            set filter to data_pg >= dat_fil  .AND. data_pg <= ;
               dData2 .AND. tipo=cDesRel
            goto top
         endif
         cabec_t:= "Relatorio" + ctiporel + "Agendados(Determ. Data)"
      elseif (opc == 3)
         cabec_t:= "Relatorio" + ctiporel + ;
            "Agendados(Semana Anterior)"
         set filter to tipo = cDesRel .AND. (data_pg>=data_sis-7 ;
            .AND. data_pg<=data_sis)
         goto top
      endif
      var_tit:= "|  Data  |Codigo|" + cpessoa + Space(28) + ;
         "|   Valor  |"
   case tipo_r = 11
      use cebCUS index ceicus
      cabec_t:= "Relatorio de Custos mensais"
      var_tit:= "|  Data  | Descricao" + Space(30) + ;
         "| Valor    | Tipo  |"
   endcase
   mensagem("Verifique a impressora")
   if (!isprinter())
      mensagem("Impressora Nao prerapada")
      close databases
      select 1
      close format
   else
      sombra(11, 19, 13, 53)
      @ 12, 20 say "Aguarde!!! Imprimindo Relatorios"
      if (EOF())
         mensagem("Nao ha dados para serem impressos!!")
         close databases
         select 1
         close format
      else
         set console off
         set device to printer
         p:= 1
         cabecalho(p, cabec_t, tipo_r, var_tit)
         nl:= l:= PRow() + 1
         do while (!EOF())
            imprime(l, tipo_r)
            if (tipo_r < 3)
               nvl_total:= nvl_total + iif(tipo_r = 8, valor, val_tot)
            elseif (tipo_r == 6)
               nlucro:= nlucro + qtd * (valunitv - valunit)
               nvalorest:= nvalorest + qtd * valunit
            elseif (tipo_r >= 9)
               teste:= iif(tipo = "D", nvldeb+=valor, nvlcre+=valor)
            endif
            if (tipo_r == 2)
               naclucro:= naclucro + lucro * quant
            endif
            skip 
            l++
            if (l > 55)
               eject
               p++
               cabecalho(p, cabec_t, tipo_r, var_tit)
               l:= PRow() + 1
            endif
         enddo
         do case
         case tipo_r <= 2
            @ l,  0 say "Total----------" + Replicate("-", 83) + "> "
            @ l, PCol() say nvl_total picture "9,999,999.99"
         case tipo_r == 6
            @ l,  0 say "Valor Total em Materiais Estocados...:"
            @ l, PCol() say nvalorest picture "999,999,999.99"
            l++
            @ l,  0 say "Lucro Total..........................:"
            @ l, PCol() + 2 say nlucro picture "9,999,999.99"
         case tipo_r = 9 .OR. tipo_r = 10
            @ PRow() + 1,  0 say "TOTAL" + iif(nvlcre > nvldeb, ;
               "(Credito)", "(Debito )") + Replicate("-", 40) + ">"
            @ PRow(), PCol() + 1 say iif(nvlcre > nvldeb, nvlcre - ;
               nvldeb, nvldeb - nvlcre) picture "9,999,999.99"
         case tipo_r == 11
            @ PRow() + 1,  0 say "(DEBITO )" + Replicate("-", 46) + ;
               ">"
            @ PRow(), PCol() + 1 say nvldeb picture "9,999,999.99"
            @ PRow() + 1,  0 say "(CREDITO)" + Replicate("-", 46) + ;
               ">"
            @ PRow(), PCol() + 1 say nvlcre picture "9,999,999.99"
            @ PRow() + 1,  0 say "TOTAL" + iif(nvlcre > nvldeb, ;
               "(Credito)", "(Debito )") + Replicate("-", 41) + ">"
            @ PRow(), PCol() + 1 say iif(nvlcre > nvldeb, nvlcre - ;
               nvldeb, nvldeb - nvlcre) picture "9,999,999.99"
         endcase
         if (tipo_r == 2)
            @ l + 1,  0 say "(LUCRO-ICMS(" + Str(nporicms, 2, 0) + ;
               "%)---" + Replicate("-", 79) + "> "
            @ l + 1, PCol() say naclucro - nvl_total * (nporicms / ;
               100) picture "9,999,999.99"
            @ l + 2,  0 say "Comissoes para os Funcionarios :" + ;
               Str(nporcom, 2, 0) + "% do Lucro(=Valor da Venda-" + ;
               Str(nporicms, 2, 0) + " % do ICMS-Valor da compra)"
            @ l + 3,  0 say "|Funcionario" + Space(29) + ;
               "| Total      |"
            use CEBFUN new index CEIFUN
            nfunc:= LastRec()
            for i:= 1 to nfunc
               select CEBFUN
               ccod:= codigo
               cnome:= nome
               skip 
               select 3
               ntot1:= 0
               DBEval({|| ntot1:= ntot1 + quant * lucro}, {|| ;
                  codfunc = ccod}, Nil, Nil, Nil, .F.)
               ntot2:= ntot1 - ntot1 * (nporicms / 100)
               ntot3:= ntot2 * (nporcom / 100)
               @ PRow() + 1,  0 say "|" + cnome + "|"
               @ PRow(), PCol() say ntot3 picture "9,999,999.99"
               @ PRow(), PCol() say "|"
            next
         endif
         @ PRow() + 1,  0 say "Final da Listagem."
         eject
         close databases
         select 1
         close format
         set device to screen
         set console off
         return
      endif
   endif


********************************
procedure CABECALHO(Arg1, Arg2, Arg3, Arg4)

   set printer on
   ?? ""
   set printer off
   @  0,  0 say Replicate("=", 80)
   if (ValType(Arg2) = "A")
      for i:= 1 to Len(Arg2)
         _col_tit:= Int(80 - Len(alltrim(Arg2[i]))) / 2
         @ i, iif(Arg3 <= 2, _col_tit + 2, _col_tit) say Arg2[i]
      next
      @ PRow()+1,  0 say "Data: " + DToC(data_sis)
      @ PRow(), 70 say "Pag.: " + Str(p, 3, 0)
      @ PRow() + 1,  0 say Replicate("=", 80)
   else
      _col_tit:= Int(80 - Len(alltrim(Arg2))) / 2
      @  1, iif(Arg3 <= 2, _col_tit + 2, _col_tit) say Arg2
      @  2,  0 say "Data: " + DToC(data_sis)
      @  2, 70 say "Pag.: " + Str(p, 3, 0)
      @  3,  0 say Replicate("=", 80)
   endif
   traco:= Len(Arg4)
   if (traco > 80)
      set printer on
      ?? ""
      set printer off
   endif
   @ PRow() + 1,  0 say Replicate("-", traco)
   @ PRow() + 1,  0 say Arg4
   @ PRow() + 1,  0 say Replicate("-", traco)
   return

***8*****************************
procedure IMPRIME(Arg1, Arg2)

   do case
   case Arg2 = 1 .OR. Arg2 = 2
      @ l,  0 say "|"
      @ l, PCol() say item
      @ l, PCol() say "|"
      @ l, PCol() say pessoa
      @ l, PCol() say "|"
      @ l, PCol() say quant
      @ l, PCol() say "|"
      @ l, PCol() say val_tot picture "999,999.99"
      @ l, PCol() say "|"
      @ l, PCol() say data_neg
      @ l, PCol() say "|"
      if (Arg2 == 2)
         @ l, PCol() say val_tot * (nporicms / 100) picture ;
            "999,999.99"
         @ l, PCol() say "|"
         @ l, PCol() say quant * lucro - val_tot * (nporicms / 100) ;
            picture "999,999.99"
         @ l, PCol() say "|"
      endif
   CASE arg2 = 3
      @ l, 0 SAY "| "+CODIGO+" | "+PRODUTO+" | "
      @ L, pcol() SAY VALUNITV PICT "9,999,999.99"
      @ L, pcol() SAY " |"
   case Arg2 = 4
      @ l,  0 say "|"
      @ l, PCol() say codigo
      @ l, PCol() say "|"
      @ l, PCol() say nome
      @ l, PCol() say "|"
      @ l, PCol() say telefone
      @ l, PCol() say "|"
      @ l, PCol() say cidade
      @ l, PCol() say "|"
      @ l, PCol() say estado
      @ l, PCol() say "|"
      @ l, PCol() say cep
      @ l, PCol() say "|"
   case Arg2 = 5
      @ l,  0 say "|"
      @ l, PCol() say codigo
      @ l, PCol() say "|"
      @ l, PCol() say nome
      @ l, PCol() say "|"
      @ l, PCol() say telefone
      @ l, PCol() say "|"
      @ l, PCol() say cidade
      @ l, PCol() say "|"
      @ l, PCol() say empresa
      @ l, PCol() say "|"
   case Arg2 = 6
      @ l,  0 say "|"
      @ l, PCol() say codigo
      @ l, PCol() say "|"
      @ l, PCol() say produto
      @ l, PCol() say "|"
      @ l, PCol() say embalagem
      @ l, PCol() say "|"
      @ l, PCol() say valunit picture "999,999.99"
      @ l, PCol() say "|"
      @ l, PCol() say valunitv picture "999,999.99"
      @ l, PCol() say "|"
      @ l, PCol() say valunitv - valunit picture "999,999.99"
      @ l, PCol() say "|"
      @ l, PCol() say qtd * (valunitv - valunit) picture "999,999.99"
      @ l, PCol() say "|"
      @ l, PCol() + 4 say qtdmin
      @ l, PCol() say "|"
      @ l, PCol() + 4 say qtd
      @ l, PCol() say "|"
   case Arg2 = 7 .OR. Arg2 = 8
      @ l,  0 say "|"
      @ l, PCol() say descricao
      @ l, PCol() say "|"
      @ l, PCol() say valor picture "999,999.99"
      @ l, PCol() say "|"
      @ l, PCol() say data
      @ l, PCol() say "|"
      @ l, PCol() say tipo
      @ l, PCol() say "|"
   case Arg2 = 9 .OR. Arg2 = 10
      @ l,  0 say "|"
      @ l, PCol() say data_pg
      @ l, PCol() say "|"
      @ l, PCol() say codigo
      @ l, PCol() say "|"
      @ l, PCol() say nome_for
      @ l, PCol() say "|"
      @ l, PCol() say valor picture "999,999.99"
      @ l, PCol() say "|"
   case Arg2 = 11
      @ l,  0 say "|"
      @ l, PCol() say data
      @ l, PCol() say "|"
      @ l, PCol() say descricao
      @ l, PCol() say "|"
      @ l, PCol() say valor picture "999,999.99"
      @ l, PCol() say "|"
      @ l, PCol() say iif(tipo = "C", "Credito", "Debito ")
      @ l, PCol() say "|"
   endcase
   return

* EOP cerelat.prg