#include "common.ch"
#include "inkey.ch"

********************************

   parameters tipo_r
   public nvl_total:= nsbtot:= nvldeb:= nvlcre:= nlucro:= 0
   public nlucro1:= nlucro2:= nlucrotot:= naclucro:= nvalunitv:= ;
      nvalorest:= 0
   if (tipo_r == 8)
   endif
   do case
   case tipo_r = 1 .OR. tipo_r = 2
      __MRestore("porcent", .T.)
      dbSelectArea("3")
      dbUseArea(.F., Nil, "CEBMEST", Nil, Nil, .F.)
      dbSetIndex("CEIMEST")
      dbSelectArea("2")
      if (tipo_r == 1)
         dbUseArea(.F., Nil, "CEBFOR", Nil, Nil, .F.)
         dbSetIndex("CEIFOR")
      else
         dbUseArea(.F., Nil, "CEBCLI", Nil, Nil, .F.)
         dbSetIndex("CEICLI")
      endif
      dbSelectArea("3")
      dbSetFilter({|| iif(tipo_r = 1, tipo = "C", tipo = "V")}, ;
         [IF(tipo_R = 1,TIPO = "C" ,TIPO = "V")])
      dbGoTop()
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
      DevPos(11, 20)
      DevOut("Escolha a opcao para o relatorio de " + ctiporel + ":")
      nopc:= botao(amatopc)
      if (nopc = 0 .OR. nopc = 4)
         dbCloseAll()
         dbSelectArea("1")
         __SetFormat(Nil)
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
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         if (nopc2 == 1)
            ddata1:= ddata2:= CToD("  /  /  ")
            sombra(11, 12, 14, 60)
            DevPos(12, 13)
            DevOut("Entre com a Data de Inicio  :")
            SetPos(Row(), Col() + 1)
            AAdd(getlist, __Get(Nil, "dData1", "99/99/99", Nil, ;
               Nil):display())
            DevPos(13, 13)
            DevOut("Entre com a data de Termino :")
            SetPos(Row(), Col() + 1)
            AAdd(getlist, __Get(Nil, "dData2", "99/99/99", Nil, ;
               Nil):display())
            ReadModal(getlist)
            getlist:= {}
            if (LastKey() = K_ESC .OR. Empty(ddata1) .OR. ;
                  Empty(ddata2))
               dbCloseAll()
               dbSelectArea("1")
               __SetFormat(Nil)
               return
            endif
            dbSetFilter({|| iif(tipo_r = 1, tipo = "C", tipo = "V") ;
               .AND. data_neg >= ddata1 .AND. data_neg <= ddata2}, ;
               [IF(tipo_R=1,TIPO="C",TIPO="V") .AND. DATA_NEG >= dData1 .AND. DATA_NEG <= dData2])
            dbGoTop()
            cabec_t:= "Relatorio de " + ctiporel + ;
               " de Estoque(Determinado Periodo)"
         elseif (nopc2 == 2)
            stela_ant:= SaveScreen(0, 0, MaxRow(), MaxCol())
            dano:= "  "
            dmes:= "  "
            apre:= setcursor(1)
            sombra(12, 19, 14, 51)
            DevPos(13, 20)
            DevOut("Entre com a data (MM/AA)", "BG/N")
            SetPos(13, 45)
            AAdd(getlist, __Get(Nil, "dMes", "99", {|| Val(dmes) > 0 ;
               .AND. Val(dmes) <= 12}, Nil):display())
            DevPos(13, 47)
            DevOut("/", "W/R")
            SetPos(13, 48)
            AAdd(getlist, __Get(Nil, "dAno", "99", Nil, ;
               Nil):display())
            ReadModal(getlist)
            getlist:= {}
            setcursor(apre)
            if (LastKey() = K_ESC .OR. Empty(dmes) .OR. Empty(dano))
               dbCloseAll()
               dbSelectArea("1")
               __SetFormat(Nil)
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
               dbCloseAll()
               dbSelectArea("1")
               __SetFormat(Nil)
               return
            endif
            RestScreen(0, 0, MaxRow(), MaxCol(), stela_ant)
            if (nopc2 == 1)
               dbSetFilter({|| tipo = iif(tipo_r = 1, "C", "V") ;
                  .AND. SubStr(DToC(data_neg), 4, 8) = dat_fil}, ;
                  [tipo = IF(tipo_R=1,"C","V") .AND. substr(dtoc(data_Neg),4,8) = dat_fil])
               dbGoTop()
               cabec_t:= "Relatorio de " + ctiporel + ;
                  " de Estoque(Todo o Mes)"
            elseif (nopc2 = 2 .OR. nopc2 = 3)
               cdia:= iif(nopc2 = 2, "01", "16")
               ctemp:= iif(nopc2 = 2, "15/" + dmes + "/" + dano, ;
                  "31/" + dmes + "/" + dano)
               ddata2:= CToD(ctemp)
               dat_fil:= CToD(cdia + "/" + dmes + "/" + dano)
               dbSetFilter({|| data_neg >= dat_fil .AND. ;
                  DToC(data_neg) <= ctemp .AND. tipo = iif(tipo_r = ;
                  1, "C", "V")}, ;
                  [(data_neg>= dat_fil  .AND. dtoc(data_neg) <= ctemp) .AND. tipo= if(tipo_R=1,"C","V")])
               dbGoTop()
               cabec_t:= "Relatorio de " + ctiporel + ;
                  " de Estoque(Data Determinada- " + iif(nopc2 = 2, ;
                  "1§ ", "2§ ") + "Quinzena"
            endif
         elseif (nopc2 == 3)
            dbSetFilter({|| iif(tipo_r = 1, tipo = "C", tipo = "V") ;
               .AND. data_neg >= data_sis - 7 .AND. data_neg <= ;
               data_sis}, ;
               [IF(tipo_R=1,TIPO="C",TIPO="V") .AND. (data_NEG>=data_sis-7 .AND. data_NEG<=data_sis)])
            dbGoTop()
            cabec_t:= "Relatorio de " + ctiporel + ;
               " de Estoque(Semana Anterior)"
         endif
      elseif (nopc == 3)
         sombra(11, 20, 13, 65)
         ccodcli:= Space(6)
         dbSelectArea("2")
         DevPos(12, 21)
         DevOut("Entre com o Codigo do" + cpesrel + ":")
         SetPos(Row(), Col() + 1)
         AAdd(getlist, __Get(Nil, "cCodCli", "@!", Nil, ;
            Nil):display())
         ReadModal(getlist)
         getlist:= {}
         corcli:= SetColor()
         if (Empty(ccodcli) .AND. LastKey() = K_ENTER)
            nproc:= tabela()
            if (Empty(nproc))
               dbCloseAll()
               dbSelectArea("1")
               __SetFormat(Nil)
               return
            endif
            ccodcli:= codigo
            DevPos(12, 21)
            DevOut("Entre com o Codigo do" + cpesrel + ":")
            SetPos(Row(), Col() + 1)
            AAdd(getlist, __Get(Nil, "cCodCli", "@!", Nil, ;
               Nil):display())
            __KillRead()
            getlist:= {}
         elseif (Empty(ccodcli) .AND. LastKey() = K_ESC)
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         SetColor(corcli)
         dbGoTop()
         dbSelectArea("3")
         __dbLocate({|| cod_pes = ccodcli}, Nil, Nil, Nil, .F.)
         if (!Found())
            mensagem("Codigo nao cadastrado! ")
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         amatopc:= array(3, 3)
         amatopc:= {{15, 20, "Geral"}, {15, 28, ;
            "Determidado Periodo"}, {15, 49, "Cancelar"}}
         sombra(14, 19, 17, 59)
         DevPos(14, 30)
         DevOut("Tipo de Relatorio :")
         nopc2:= botao(amatopc)
         if (nopc2 = 3 .OR. nopc2 = 0)
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         dbSelectArea("3")
         if (nopc2 == 2)
            cmes:= "  "
            cano:= "  "
            sombra(15, 25, 18, 47)
            DevPos(16, 26)
            DevOut("Entre com o Periodo:")
            SetPos(17, 35)
            AAdd(getlist, __Get(Nil, "cMes", "99", Nil, ;
               Nil):display())
            DevPos(17, Col())
            DevOut("/", "W/R")
            SetPos(17, Col())
            AAdd(getlist, __Get(Nil, "cAno", "99", Nil, ;
               Nil):display())
            ReadModal(getlist)
            getlist:= {}
            if (LastKey() == K_ESC)
               dbCloseAll()
               dbSelectArea("1")
               __SetFormat(Nil)
               return
            endif
            cfiltro:= cmes + "/" + cano
            dbSetFilter({|| tipo = ctipor2 .AND. cod_pes = ccodcli ;
               .AND. SubStr(DToC(data_neg), 4, 5) = cfiltro}, ;
               "tipo = cTipor2 .AND. cod_pes = cCodCli .AND. substr(dtoc(DATA_NEG),4,5)= cFiltro")
         else
            dbSetFilter({|| tipo = ctipor2 .AND. cod_pes = ccodcli}, ;
               "tipo = cTipor2 .AND. cod_pes = cCodCli")
         endif
         dbGoTop()
         cabec_t:= "Relatorio de " + ctiporel + " de Estoque(" + ;
            LTrim(cpesrel) + "Determinado)"
      endif
   case tipo_r = 2
   case tipo_r = 3
      dbUseArea(.F., Nil, "cebcli", Nil, Nil, .F.)
      dbSetIndex("ceicli")
      cabec_t:= "Relatorio de Clientes"
      var_tit:= "|Codigo| Nome" + Space(35) + "| Tel. Fax" + ;
         Space(6) + "| Cidade" + Space(23) + "|UF| Cep     |"
   case tipo_r = 4
      dbUseArea(.F., Nil, "cebfor", Nil, Nil, .F.)
      dbSetIndex("ceifor")
      cabec_t:= "Relatorio de Fornecedores"
      var_tit:= "|Codigo| Nome" + Space(35) + "| Tel. Fax" + ;
         Space(6) + "| Cidade" + Space(23) + "| Empresa" + Space(22) ;
         + "|"
   case tipo_r = 5
      dbSelectArea("2")
      dbUseArea(.F., Nil, "CEBFOR", Nil, Nil, .F.)
      dbSetIndex("CEIFOR")
      dbUseArea(.T., Nil, "cebest", Nil, Nil, .F.)
      dbSetIndex("ceiest")
      cabec_t:= "Relatorio de Materiais em Estoque"
      var_tit:= "|Codigo| Produto" + Space(32) + "| Embalagem" + ;
         Space(15) + ;
         "| (COMPRA) |   (VENDA)|   (LUCRO)|  (TOTAL) |Qtd Min| Quant  |"
      amatopc:= array(3, 3)
      amatopc:= {{12, 14, "Todos os Materiais"}, {12, 35, ;
         "Por Fornecedor"}, {12, 51, "Cancelar"}}
      sombra(10, 13, 14, 72)
      DevPos(11, 16)
      DevOut("Escolha a opcao para o relatorio de Materais em Estoque")
      nopc:= botao(amatopc)
      if (nopc = 0 .OR. nopc = 3)
         dbCloseAll()
         dbSelectArea("1")
         __SetFormat(Nil)
         return
      elseif (nopc == 2)
         sombra(11, 20, 13, 65)
         ccodcli:= Space(6)
         dbSelectArea("2")
         DevPos(12, 21)
         DevOut("Entre com o Codigo do fornecedor:")
         SetPos(Row(), Col() + 1)
         AAdd(getlist, __Get(Nil, "cCodCli", "@!", Nil, ;
            Nil):display())
         ReadModal(getlist)
         getlist:= {}
         corcli:= SetColor()
         if (Empty(ccodcli) .AND. LastKey() = K_ENTER)
            nproc:= tabela()
            if (Empty(nproc))
               dbCloseAll()
               dbSelectArea("1")
               __SetFormat(Nil)
               return
            endif
            ccodcli:= codigo
            cnome:= nome
            DevPos(12, 21)
            DevOut("Entre com o Codigo do fornecedor:")
            SetPos(Row(), Col() + 1)
            AAdd(getlist, __Get(Nil, "cCodCli", "@!", Nil, ;
               Nil):display())
            __KillRead()
            getlist:= {}
         elseif (Empty(ccodcli) .AND. LastKey() = K_ESC)
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         SetColor(corcli)
         dbSeek(ccodcli, Nil)
         if (!Found())
            mensagem("Codigo nao cadastrado! ")
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         cnome:= nome
         (2)->(dbCloseArea())
         dbSelectArea("CEBEST")
         dbSetFilter({|| cod_pes = ccodcli}, "cod_pes = cCodCli")
         dbGoTop()
         private cabec_t[2]
         cabec_t[1]:= ;
            "Relatorio de Materiais em Estoque(Fornecedor Determinado)"
         cabec_t[2]:= "Codigo do Fornecedor:" + ccodcli + "  Nome:" ;
            + cnome
      endif
   case tipo_r = 6
      dbUseArea(.F., Nil, "ceblanca", Nil, Nil, .F.)
      cabec_t:= "Relatorio de Lancamentos Diarios do Caixa"
      var_tit:= "| Descricao" + Space(30) + "| Valor    |  Data  |T|"
   case tipo_r = 7
      dbUseArea(.F., Nil, "ceblmc", Nil, Nil, .F.)
      cabec_t:= "Relatorio de Lancamentos Mensais do Caixa"
      var_tit:= "| Descricao" + Space(30) + "| Valor    |  Data  |T|"
   case tipo_r = 8 .OR. tipo_r = 9
      dbUseArea(.F., Nil, "cebagen", Nil, Nil, .F.)
      dbSetIndex("ceiagen")
      cdesrel:= iif(tipo_r = 8, "D", "C")
      ctiporel:= iif(tipo_r = 8, " Pagamentos ", " Recebimentos ")
      cpessoa:= iif(tipo_r = 8, " Fornecedor ", " Clientes   ")
      a_matop:= amatop2:= array(3, 3)
      a_matop:= {{11, 15, "Toda a Agenda"}, {11, 29, ;
         "Determinada Data"}, {11, 47, "Semana anterior"}, {11, 64, ;
         "Cancelar"}}
      amatop2:= {{11, 19, "Todo o Mes"}, {11, 31, "1§ Quinzana"}, ;
         {11, 44, "2§ Quinzena"}, {11, 57, "Cancelar"}}
      sombra(9, 14, 14, 74)
      DevPos(10, 19)
      DevOut("Opcoes de Relatorios da Agenda :")
      opc:= botao(a_matop)
      if (opc = 0 .OR. opc = 4)
         dbCloseAll()
         dbSelectArea("1")
         __SetFormat(Nil)
         return
      endif
      cabec_t:= "Relatorio" + ctiporel + "Agendados"
      dbSetFilter({|| tipo = cdesrel}, "tipo = cDesRel")
      dbGoTop()
      if (opc == 2)
         stela_ant:= SaveScreen(0, 0, MaxRow(), MaxCol())
         dano:= "  "
         dmes:= "  "
         apre:= setcursor(1)
         DevPos(13, 20)
         DevOut("Entre com a data (MM/AA)", "BG/N")
         SetPos(13, 45)
         AAdd(getlist, __Get(Nil, "dMes", "99", {|| Val(dmes) > 0 ;
            .AND. Val(dmes) <= 12}, Nil):display())
         DevPos(13, 47)
         DevOut("/", "W/R")
         SetPos(13, 48)
         AAdd(getlist, __Get(Nil, "dAno", "99", Nil, Nil):display())
         ReadModal(getlist)
         getlist:= {}
         RestScreen(0, 0, MaxRow(), MaxCol(), stela_ant)
         setcursor(apre)
         if (LastKey() = K_ESC .OR. Empty(dmes) .OR. Empty(dano))
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         sombra(10, 18, 13, 66)
         DevPos(10, 20)
         DevOut("Escolha o Periodo:")
         nopc2:= botao(amatop2)
         if (nopc2 = 0 .OR. nopc2 = 4)
            dbCloseAll()
            dbSelectArea("1")
            __SetFormat(Nil)
            return
         endif
         if (nopc2 == 1)
            dat_fil:= dmes + "/" + dano
            dbSetFilter({|| SubStr(DToC(data_pg), 4, 8) = dat_fil ;
               .AND. tipo = cdesrel}, ;
               "substr(dtoc(data_pg),4,8) = dat_fil .AND. tipo = cDesRel")
            dbGoTop()
         elseif (nopc2 = 2 .OR. nopc2 = 3)
            cdia:= iif(nopc2 = 2, "01", "16")
            ddata2:= iif(nopc2 = 2, CToD("15/" + dmes + "/" + dano), ;
               CToD("31/" + dmes + "/" + dano))
            dat_fil:= CToD(cdia + "/" + dmes + "/" + dano)
            dbSetFilter({|| data_pg >= dat_fil .AND. data_pg <= ;
               ddata2 .AND. tipo = cdesrel}, ;
               "data_pg >= dat_fil  .AND. data_pg <= dData2 .AND. tipo=cDesRel")
            dbGoTop()
         endif
         cabec_t:= "Relatorio" + ctiporel + "Agendados(Determ. Data)"
      elseif (opc == 3)
         cabec_t:= "Relatorio" + ctiporel + ;
            "Agendados(Semana Anterior)"
         dbSetFilter({|| tipo = cdesrel .AND. data_pg >= data_sis - ;
            7 .AND. data_pg <= data_sis}, ;
            "tipo = cDesRel .AND. (data_pg>=data_sis-7 .AND. data_pg<=data_sis)")
         dbGoTop()
      endif
      var_tit:= "|  Data  |Codigo|" + cpessoa + Space(28) + ;
         "|   Valor  |"
   case tipo_r = 10
      dbUseArea(.F., Nil, "cebCUS", Nil, Nil, .F.)
      dbSetIndex("ceicus")
      cabec_t:= "Relatorio de Custos mensais"
      var_tit:= "|  Data  | Descricao" + Space(30) + ;
         "| Valor    | Tipo  |"
   endcase
   mensagem("Verifique a impressora")
   if (!isprinter())
      mensagem("Impressora Nao prerapada")
      dbCloseAll()
      dbSelectArea("1")
      __SetFormat(Nil)
   else
      sombra(11, 19, 13, 53)
      DevPos(12, 20)
      DevOut("Aguarde!!! Imprimindo Relatorios")
      if (EOF())
         mensagem("Nao ha dados para serem impressos!!")
         dbCloseAll()
         dbSelectArea("1")
         __SetFormat(Nil)
      else
         Set(17, "OFF")
         Set(20, "PRINTER")
         p:= 1
         cabecalho(p, cabec_t, tipo_r, var_tit)
         nl:= l:= PRow() + 1
         while (!EOF())
            imprime(l, tipo_r)
            if (tipo_r < 3)
               nvl_total:= nvl_total + iif(tipo_r = 8, valor, val_tot)
            elseif (tipo_r == 5)
               nlucro:= nlucro + qtd * (valunitv - valunit)
               nvalorest:= nvalorest + qtd * valunit
            elseif (tipo_r >= 8)
               teste:= iif(tipo = "D", nvldeb+=valor, nvlcre+=valor)
            endif
            if (tipo_r == 2)
               naclucro:= naclucro + lucro * quant
            endif
            dbSkip(1)
            l++
            if (l > 55)
               __Eject()
               p++
               cabecalho(p, cabec_t, tipo_r, var_tit)
               l:= PRow() + 1
            endif
         end
         do case
         case tipo_r <= 2
            DevPos(l, 0)
            DevOut("Total----------" + Replicate("-", 83) + "> ")
            DevPos(l, PCol())
            DevOutPict(nvl_total, "9,999,999.99")
         case tipo_r == 5
            DevPos(l, 0)
            DevOut("Valor Total em Materiais Estocados...:")
            DevPos(l, PCol())
            DevOutPict(nvalorest, "999,999,999.99")
            l++
            DevPos(l, 0)
            DevOut("Lucro Total..........................:")
            DevPos(l, PCol() + 2)
            DevOutPict(nlucro, "9,999,999.99")
         case tipo_r = 8 .OR. tipo_r = 9
            DevPos(PRow() + 1, 0)
            DevOut("TOTAL" + iif(nvlcre > nvldeb, "(Credito)", ;
               "(Debito )") + Replicate("-", 40) + ">")
            DevPos(PRow(), PCol() + 1)
            DevOutPict(iif(nvlcre > nvldeb, nvlcre - nvldeb, nvldeb ;
               - nvlcre), "9,999,999.99")
         case tipo_r == 10
            DevPos(PRow() + 1, 0)
            DevOut("(DEBITO )" + Replicate("-", 46) + ">")
            DevPos(PRow(), PCol() + 1)
            DevOutPict(nvldeb, "9,999,999.99")
            DevPos(PRow() + 1, 0)
            DevOut("(CREDITO)" + Replicate("-", 46) + ">")
            DevPos(PRow(), PCol() + 1)
            DevOutPict(nvlcre, "9,999,999.99")
            DevPos(PRow() + 1, 0)
            DevOut("TOTAL" + iif(nvlcre > nvldeb, "(Credito)", ;
               "(Debito )") + Replicate("-", 41) + ">")
            DevPos(PRow(), PCol() + 1)
            DevOutPict(iif(nvlcre > nvldeb, nvlcre - nvldeb, nvldeb ;
               - nvlcre), "9,999,999.99")
         endcase
         if (tipo_r == 2)
            DevPos(l + 1, 0)
            DevOut("(LUCRO-ICMS(" + Str(nporicms, 2, 0) + "%)---" + ;
               Replicate("-", 79) + "> ")
            DevPos(l + 1, PCol())
            DevOutPict(naclucro - nvl_total * (nporicms / 100), ;
               "9,999,999.99")
            DevPos(l + 2, 0)
            DevOut("Comissoes para os Funcionarios :" + Str(nporcom, ;
               2, 0) + "% do Lucro(=Valor da Venda-" + Str(nporicms, ;
               2, 0) + " % do ICMS-Valor da compra)")
            DevPos(l + 3, 0)
            DevOut("|Funcionario" + Space(29) + "| Total      |")
            dbUseArea(.T., Nil, "CEBFUN", Nil, Nil, .F.)
            dbSetIndex("CEIFUN")
            nfunc:= LastRec()
            for i:= 1 to nfunc
               dbSelectArea("CEBFUN")
               ccod:= codigo
               cnome:= nome
               dbSkip(1)
               dbSelectArea("3")
               ntot1:= 0
               DBEval({|| ntot1:= ntot1 + quant * lucro}, {|| ;
                  codfunc = ccod}, Nil, Nil, Nil, .F.)
               ntot2:= ntot1 - ntot1 * (nporicms / 100)
               ntot3:= ntot2 * (nporcom / 100)
               DevPos(PRow() + 1, 0)
               DevOut("|" + cnome + "|")
               DevPos(PRow(), PCol())
               DevOutPict(ntot3, "9,999,999.99")
               DevPos(PRow(), PCol())
               DevOut("|")
            next
         endif
         DevPos(PRow() + 1, 0)
         DevOut("Final da Listagem.")
         __Eject()
         dbCloseAll()
         dbSelectArea("1")
         __SetFormat(Nil)
         Set(20, "SCREEN")
         Set(17, "OFF")
         return
      endif
   endif

* EOF
