#include "common.ch"
#include "inkey.ch"

********************************

   parameters tipo_r
   do case
   case tipo_r = 1
   case tipo_r = 2
      use SRblanca
      cabec_t:= "Relatorio de Lancamentos Diarios do Caixa"
      var_tit:= "|  Data  | Descricao" + Space(30) +"| Valor    | Tipo  |"
   case tipo_r = 3
      use srblmc
      cabec_t:= "Relatorio de Lancamentos Mensais do Caixa"
      var_tit:= "|  Data  | Descricao" + Space(30) +"| Valor    | Tipo  |"
   case tipo_r = 4
      use srbCUS index sricus
      cabec_t:= "Relatorio de Custos mensais"
      var_tit:= "|  Data  | Descricao" + Space(30) +"| Valor    | Tipo  |"
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
         nVlDeb := nVlCre := 0
         do while (!EOF())
            imprime(l, tipo_r)
            if (tipo_r >= 2)
               teste:= iif(tipo = "D", nvldeb+=valor, nvlcre+=valor)
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
         IF tipo_r >= 2
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
         ENDIF
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

********************************
procedure IMPRIME(Arg1, Arg2)

   do case
   case Arg2 = 1
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
   case Arg2 >=2
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