restore screen
do while .t.
   mre = 1
   do sinal with 'MOVIMENTO', ' '
   @ 3, 1 say space (78) 
   @ 5, 1 say space (78) 
   do limpa
   set message to 5 center
   @ 3, 2 prompt 'ENTRADA' message 'Entrada de Produtos'
   @ 3, col () + 8 prompt 'CORR.ENTR' message 'Correcao dos dados de entrada'
   @ 3, col () + 8 prompt 'SAIDA' message 'Saida manual de Produtos'
   @ 3, col () + 8 prompt 'CORR.SAIDA' message 'Correcao dos dados de saida'
   @ 3, col () + 8 prompt 'Retorna' message 'Retorno ao Menu Principal'
   menu to mre
   do case
      case mre = 1
         do g91entr

      case mre = 2
         do g91entrc

      case mre = 3
         do g91said

      case mre = 4
         do g91saidc

      case mre = 5
         exit
   endcase
enddo
return






procedure g91entr       
do sinal with 'MOVIMENTO', 'ENTRADA'
@ 5, 1 say space (78) 
select prod
set cursor on
n_codigo12 = 0
n_descrica = space (40)
do while .t.
   select prod
   do limpa
   @ 7, 3 say 'Codigo do produto...:' get n_codigo12 picture '9999999999999' valid dig_con5(n_codigo12) 
   read
   if n_codigo12 != 0
      v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
      select prod
      find (v_codigo12)
      if ! found ()
         do mensagem with 'Produto nao esta cadastrado, cadastre primeiro !!!', mem_tempo
         loop
      endif
      n_descrica = descricao


   endif
   @ 7, 38 say '' get n_descrica picture '@!'
   read
   if lastkey () = 27
      return
   endif
   if n_codigo12 = 0 .and. n_descrica = space (40)
      loop
   endif
   if n_codigo12 = 0
      v_compr = len (alltrim (n_descrica))
      locate all for SUBSTR(DESCRICAO,1,v_compr)=ALLTRIM(n_descricao)
      if found ()
         set cursor off
         do aviso with 24, '[PgDn]-Avanca um registro [PgUp]-Volta um registro [RET]-Confirma  [ESC]-Desiste'
         do while .t.
            n_descrica = descricao
            n_codigo12 = val (codigo12 + dig_con1)
            set color to gr+/g
            @ 7, 25 say str (n_codigo12, 13, 0) 
            @ 7, col () + 1 say n_descrica 
            set color to &padrao
            v_key = inkey (0)
            do case
               case v_key = 27
                  exit
               case v_key = 3
                  set order to 3
                  skip 1
                  set order to 1
                  loop
               case v_key = 18
                  set order to 3
                  skip -1
                  set order to 1
                  loop
               case v_key = 13
                  exit
            endcase
         enddo
         set cursor on
         @ 24, 0 say space (80) 
         if lastkey () = 27
            return
         endif
      endif

   endif
   v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
   find (v_codigo12)
   if n_codigo12 = 0
      loop
   endif
   if ! found ()
      select prod
      do mensagem with 'Produto nao esta cadastrado !!!', mem_tempo
      loop
   endif
   v_dig_con1 = dig_con1
   v_codigo4 = codigo4
   v_dig_con2 = dig_con2
   v_estoque = estoque
   v_est_min = est_min
   v_margem = margem
   v_depto_c = depto_c
   v_custo = custo
   v_preco_u = preco_u
   v_movim = ' '
   v_data = date ()
   v_forn = space (7)
   n_forn = 0
   v_nota = space (8)
   v_serie = space (3)
   v_data_n = date ()
   v_qtde_v = 0
   v_volume = 1
   v_valor = 0
   select dept
   find (v_depto_c)
   v_descrica = descricao
   v_aliquota = aliquota
   select prod
   @ 8, 3 say 'Codigo de movimento.:' get v_movim picture '@!' valid v_movim$"CE" 
   @ 8, 30 say '[C]-Compra    [E]-Entrada para acerto' 

   @ 9, 3 say 'Data do movimento...:' get v_data
   @ 10, 3 say 'Depto conectado.....: ' + v_depto_c + ' Aliq.: ' + str (v_aliquota, 5, 2) + ' Descr.: ' + v_descrica 
   @ 11, 3 say 'Cod. do Fornecedor..:' get n_forn picture '9999999' valid proforn(n_forn) 
   @ 12, 3 say 'Nota fiscal/Doc. No.:' get v_nota picture '@!'
   @ 12, col () + 1 say 'Serie:' get v_serie picture '@!'
   @ 12, col () + 1 say 'Data.:' get v_data_n
   @ 13, 3 say 'Vol. X Qtde cada Vol:' get v_volume picture '99999' valid (v_volume#0) 
   @ 13, col () + 1 say '[X]' get v_qtde_v picture '99999.99' valid CALTOT(v_volume,v_qtde_v) 
   @ 14, 3 say 'Valor total nota/doc:' get v_valor picture '99999999.99'
   read




   if lastkey () = 27
      exit
   endif
   if v_qtde_v * v_volume = 0
      do mensagem with 'A Quantidade total nao pode ser igual a zero !!!', mem_tempo
      loop
   endif
   v_forn = strzero (n_forn, 7, 0)
   select clie
   find (v_forn)
   v_rzso = rzso
   select prod

   @ 16, 2 say 'ESTOQUE ANTERIOR        ESTOQUE ATUAL            PRECO VENDA' 
   @ 15, 1, 15, 78 box frame1
   @ 17, 1, 17, 78 box frame1

   @ 16, 25, 22, 25 box frame1
   @ 16, 50, 22, 50 box frame1






   @ 18, 2 say 'ESTOQUE.:' + str (v_estoque, 9, 2) 
   @ 19, 2 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 2 say 'PC CUSTO:' + str (v_custo, 9, 2) 
   @ 21, 2 say 'PC VENDA:' + str (v_preco_u, 9, 2) 
   @ 22, 2 say 'MARGEM..:' + str (v_margem, 9, 2) 

   @ 18, 26 say 'ESTOQUE.:' + str (v_estoque + v_volume * v_qtde_v, 9, 2) 
   @ 19, 26 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 26 say 'PC CUSTO:' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 
   v_venda = v_valor / (v_volume * v_qtde_v) * (1 + v_margem / 100)
   @ 21, 26 say 'PC VENDA:' + str (v_venda, 9, 2) 
   @ 22, 26 say 'MARGEM..:' + str (v_margem, 9, 2) 

   @ 18, 51 say 'PC CUSTO: ' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 
   if v_custo != 0
      @ 19, 51 say 'REAJ.FOR: ' + str ((v_valor / (v_volume * v_qtde_v) / v_custo - 1) * 100, 9, 2) + ' %' 
   endif
   @ 20, 51 say 'PC ANTER: ' + str (v_preco_u, 9, 2) 
   @ 21, 51 say 'PC VENDA:' get v_venda picture '999999.99'
   if v_preco_u != 0
      @ 22, 51 say 'REAJUSTE: ' + str ((v_venda / v_preco_u - 1) * 100, 9, 2) + ' %' 
   endif
   read
   if v_preco_u != 0
      @ 22, 51 say 'REAJUSTE: ' + str ((v_venda / v_preco_u - 1) * 100, 9, 2) + ' %' 
   endif
   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   do aviso with 24, 'Atualiza o estoque com estes dados ?'

   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   select prod
   replace estoque with v_estoque + v_volume * v_qtde_v
   replace margem with (v_venda / v_valor / (v_volume * v_qtde_v) - 1) * 100
   if preco_u != v_venda
      replace preco_a with preco_u
      replace data_a with v_data
      replace etiqn with '1'
      replace preco_u with v_venda
   endif


   replace custo with v_valor / (v_volume * v_qtde_v)
   replace compra with compra + v_valor
   replace qtde_c with qtde_c + v_volume * v_qtde_v
   commit
   select movi
   append blank 
   replace codigo12 with v_codigo12
   replace dig_con1 with v_dig_con1
   replace codigo4 with v_codigo4
   replace dig_con2 with v_dig_con2
   replace movim with v_movim
   replace data with v_data
   replace forn with v_forn
   replace nota with v_nota
   replace serie with v_serie
   replace data_n with v_data_n
   replace qtde with v_qtde_v
   replace volume with v_volume
   replace qtde_t with v_qtde_v * v_volume
   replace valor with v_valor
   replace ent_sai with 'E'
   replace rzso with v_rzso
   commit


   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
   n_codigo12 = 0
   n_descrica = space (40)
enddo
return






procedure g91entrc      
do sinal with 'MOVIMENTO', 'CORRECAO'
@ 5, 1 say space (78) 
select movi
set cursor on
do while .t.
   select movi
   do limpa
   n_codigo12 = 0
   n_forn = 0
   v_nota = space (7)
   @ 7, 3 say 'Codigo do produto...:' get n_codigo12 picture '9999999999999'
   @ 8, 3 say 'Codigo do fornecedor:' get n_forn picture '9999999'
   @ 9, 3 say 'Numero da nota/docum:' get v_nota picture '@!'
   read
   v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
   v_forn = strzero (n_forn, 7, 0)
   locate all for FORN=v_forn .AND.NOTA=v_nota .AND.CODIGO12=v_codigo12
   if lastkey () = 27
      exit
   endif
   if ! found ()
      do mensagem with 'Lancamento nao foi encontado !!!', mem_tempo
      loop
   endif
   v_dig_con1 = dig_con1
   v_codigo4 = codigo4
   v_dig_con2 = dig_con2
   v_movim = movim
   v_data = data
   v_data_n = data_n
   v_qtde_v = qtde
   v_volume = volume
   v_qtde_t = qtde_t
   v_valor = valor
   v_rzso = rzso
   select prod
   find (v_codigo12)
   if ! found ()
      do mensagem with 'Produto nao esta cadastrado !!!', mem_tempo
      loop
   endif
   v_descrica = descricao
   v_est_min = est_min
   v_estoque = estoque
   v_compra = compra
   v_qtde_c = qtde_c
   v_custo = custo
   v_margem = margem
   v_preco_u = preco_u
   select movi
   @ 7, 39 say v_descrica 
   @ 8, 39 say v_rzso 
   @ 10, 3 say 'Codigo de movimento.:' get v_movim picture '@!' valid v_movim$"CE" 
   @ 10, 30 say '[C]-Compra    [E]-Entrada para acerto' 
   @ 11, 3 say 'Data do movimento...:' get v_data
   @ 12, 3 say 'Data da nota/doc....:' get v_data_n
   @ 13, 3 say 'Vol. X Qtde cada Vol:' get v_volume picture '99999'
   @ 13, col () + 1 say '[X]' get v_qtde_v picture '99999.99'
   @ 14, 3 say 'Valor total nota/doc:' get v_valor picture '99999999.99'
   read
   @ 13, 44 say 'Qtde total:' + str (v_volume * v_qtde_v, 12, 2) 

   if lastkey () = 27
      exit
   endif
   v_qtde_t = v_volume * v_qtde_v

   dif_qtde = v_qtde_t - qtde_t
   dif_valor = v_valor - valor

   v_forn = strzero (n_forn, 7, 0)

   @ 16, 2 say 'ESTOQUE ANTERIOR        ESTOQUE ATUAL            PRECO VENDA' 
   @ 15, 1, 15, 78 box frame1
   @ 17, 1, 17, 78 box frame1

   @ 16, 25, 22, 25 box frame1
   @ 16, 50, 22, 50 box frame1






   @ 18, 2 say 'ESTOQUE.:' + str (v_estoque, 9, 2) 
   @ 19, 2 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 2 say 'PC CUSTO:' + str (v_custo, 9, 2) 
   @ 21, 2 say 'PC VENDA:' + str (v_preco_u, 9, 2) 
   @ 22, 2 say 'MARGEM..:' + str (v_margem, 9, 2) 

   @ 18, 26 say 'ESTOQUE.:' + str (v_estoque + dif_qtde, 9, 2) 
   @ 19, 26 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 26 say 'PC CUSTO:' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 
   v_venda = v_valor / (v_volume * v_qtde_v) * (1 + v_margem / 100)
   @ 21, 26 say 'PC VENDA:' + str (v_venda, 9, 2) 
   @ 22, 26 say 'MARGEM..:' + str (v_margem, 9, 2) 

   @ 18, 51 say 'PC CUSTO: ' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 
   @ 19, 51 say 'REAJ.FOR: ' + str ((v_valor / (v_volume * v_qtde_v) / v_custo - 1) * 100, 9, 2) + ' %' 
   @ 20, 51 say 'PC ANTER: ' + str (v_preco_u, 9, 2) 
   @ 21, 51 say 'PC VENDA:' get v_venda picture '999999.99'
   @ 22, 51 say 'REAJUSTE: ' + str ((v_venda / v_preco_u - 1) * 100, 9, 2) + ' %' 
   read
   @ 22, 51 say 'REAJUSTE: ' + str ((v_venda / v_preco_u - 1) * 100, 9, 2) + ' %' 

   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   do aviso with 24, 'Atualiza o estoque com estes dados ?'

   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   select prod
   replace estoque with v_estoque + dif_qtde
   replace margem with (v_venda / v_valor / (v_volume * v_qtde_v) - 1) * 100
   if preco_u != v_venda
      replace preco_a with preco_u
      replace data_a with v_data
      replace etiqn with '1'
      replace preco_u with v_venda
   endif


   replace custo with v_valor / (v_volume * v_qtde_v)
   replace compra with compra + dif_valor
   replace qtde_c with qtde_c + dif_qtde
   commit
   select movi

   replace codigo12 with v_codigo12
   replace dig_con1 with v_dig_con1
   replace codigo4 with v_codigo4
   replace dig_con2 with v_dig_con2
   replace movim with v_movim
   replace data with v_data
   replace forn with v_forn
   replace nota with v_nota

   replace data_n with v_data_n
   replace qtde with v_qtde_v
   replace volume with v_volume
   replace qtde_t with v_qtde_v * v_volume
   replace valor with v_valor
   replace ent_sai with 'E'
   commit


   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
enddo
return






procedure g91said       
do sinal with 'MOVIMENTO', 'SAIDA'
@ 5, 1 say space (78) 
select prod
set cursor on
n_codigo12 = 0
n_descrica = space (40)
do while .t.
   select prod
   do limpa
   @ 7, 3 say 'Codigo do produto...:' get n_codigo12 picture '9999999999999' valid dig_con5(n_codigo12) 
   read
   if n_codigo12 != 0
      v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
      select prod
      find (v_codigo12)
      if ! found ()
         do mensagem with 'Produto nao esta cadastrado, cadastre primeiro !!!', mem_tempo
         loop
      endif
      n_descrica = descricao


   endif
   @ 7, 38 say '' get n_descrica picture '@!'
   read
   if lastkey () = 27
      return
   endif
   if n_codigo12 = 0 .and. n_descrica = space (40)
      loop
   endif
   if n_codigo12 = 0
      v_compr = len (alltrim (n_descrica))
      locate all for SUBSTR(DESCRICAO,1,v_compr)=ALLTRIM(n_descricao)
      if found ()
         set cursor off
         do aviso with 24, '[PgDn]-Avanca um registro [PgUp]-Volta um registro [RET]-Confirma  [ESC]-Desiste'
         do while .t.
            n_descrica = descricao
            n_codigo12 = val (codigo12 + dig_con1)
            set color to gr+/g
            @ 7, 25 say str (n_codigo12, 13, 0) 
            @ 7, col () + 1 say n_descrica 
            set color to &padrao
            v_key = inkey (0)
            do case
               case v_key = 27
                  exit
               case v_key = 3
                  set order to 3
                  skip 1
                  set order to 1
                  loop
               case v_key = 18
                  set order to 3
                  skip -1
                  set order to 1
                  loop
               case v_key = 13
                  exit
            endcase
         enddo
         set cursor on
         @ 24, 0 say space (80) 
         if lastkey () = 27
            return
         endif
      endif

   endif
   v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
   find (v_codigo12)
   if lastkey () = 27
      return
   endif
   if n_codigo12 = 0
      loop
   endif
   if ! found ()
      select prod
      do mensagem with 'Produto nao esta cadastrado !!!', mem_tempo
      loop
   endif
   v_dig_con1 = dig_con1
   v_codigo4 = codigo4
   v_dig_con2 = dig_con2
   v_estoque = estoque
   v_est_min = est_min
   v_margem = margem
   v_depto_c = depto_c
   v_preco_u = preco_u
   v_custo = custo
   v_movim = ' '
   v_data = date ()
   v_forn = space (7)
   n_forn = 0
   v_nota = space (8)
   v_serie = space (3)
   v_data_n = date ()
   v_qtde_v = 0
   v_volume = 1
   v_valor = 0
   v_rzso = space (40)
   select dept
   find (v_depto_c)
   v_descrica = descricao
   v_aliquota = aliquota
   select prod
   @ 8, 3 say 'Codigo de movimento.:' get v_movim picture '@!' valid v_movim$"VS" 
   @ 8, 30 say '[V]-Venda    [S]-Saida para acerto' 

   @ 9, 3 say 'Data do movimento...:' get v_data
   @ 10, 3 say 'Depto conectado.....: ' + v_depto_c + ' Aliq.: ' + str (v_aliquota, 5, 2) + ' Descr.: ' + v_descrica 
   @ 11, 3 say 'Cod. do Clien/Forn..:' get n_forn picture '9999999' valid profor(n_forn) 

   @ 12, 3 say 'Nota fiscal/Doc. No.:' get v_nota picture '@!'
   @ 12, col () + 1 say 'Serie:' get v_serie picture '@!'
   @ 12, col () + 1 say 'Data.:' get v_data_n
   @ 13, 3 say 'Vol. X Qtde cada Vol:' get v_volume picture '99999' valid (v_volume#0) 
   @ 13, col () + 1 say '[X]' get v_qtde_v picture '99999.99' valid CALTOT(v_volume,v_qtde_v) 
   @ 14, 3 say 'Valor total nota/doc:' get v_valor picture '99999999.99'
   read
   v_forn = strzero (n_forn, 7, 0)
   if lastkey () = 27
      exit
   endif
   if v_qtde_v * v_volume = 0
      do mensagem with 'A Quantidade total nao pode ser igual a zero !!!', mem_tempo
      loop
   endif

   select clie
   find (v_forn)
   if ! found ()
      @ 11, 31 say 'Nome cliente:' get v_rzso picture '@!'
      read
   else 
      v_rzso = rzso
   endif


   @ 16, 2 say 'ESTOQUE ANTERIOR        ESTOQUE ATUAL            PRECO VENDA' 
   @ 15, 1, 15, 78 box frame1
   @ 17, 1, 17, 78 box frame1
   @ 16, 25, 22, 25 box frame1
   @ 16, 50, 22, 50 box frame1

   @ 18, 2 say 'ESTOQUE.:' + str (v_estoque, 9, 2) 
   @ 19, 2 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 2 say 'PC CUSTO:' + str (v_custo, 9, 2) 
   @ 21, 2 say 'PC VENDA:' + str (v_preco_u, 9, 2) 
   @ 22, 2 say 'MARGEM..:' + str (v_margem, 9, 2) 

   @ 18, 26 say 'ESTOQUE.:' + str (v_estoque - v_volume * v_qtde_v, 9, 2) 
   @ 19, 26 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 26 say 'MARGEM..:' + str (v_margem, 9, 2) 
   v_venda = v_preco_u
   @ 21, 26 say 'PC VENDA:' + str (v_venda, 9, 2) 
   @ 22, 26 say 'PC NOTA.:' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 

   @ 18, 51 say 'PC CUSTO:' + str (v_custo, 9, 2) 
   @ 19, 51 say 'PC VENDA:' + str (v_venda, 9, 2) 
   @ 20, 51 say 'PC NOTA.:' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 
   if v_custo != 0
      @ 21, 51 say 'LUCR CUS:' + str ((v_valor / (v_volume * v_qtde_v) / v_custo - 1) * 100, 9, 2) + ' %' 
   endif
   if v_venda != 0
      @ 22, 51 say 'LUCR VEN:' + str ((v_valor / (v_volume * v_qtde_v) / v_venda - 1) * 100, 9, 2) + ' %' 
   endif

   read


   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   do aviso with 24, 'Atualiza o estoque com estes dados ?'

   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   select prod
   replace estoque with v_estoque - v_volume * v_qtde_v
   replace venda with venda + v_valor
   replace qtde with qtde + v_volume * v_qtde_v


   commit
   select movi
   append blank 
   replace codigo12 with v_codigo12
   replace dig_con1 with v_dig_con1
   replace codigo4 with v_codigo4
   replace dig_con2 with v_dig_con2
   replace movim with v_movim
   replace data with v_data
   replace forn with v_forn
   replace rzso with v_rzso
   replace nota with v_nota
   replace serie with v_serie
   replace data_n with v_data_n
   replace qtde with v_qtde_v
   replace volume with v_volume
   replace qtde_t with v_qtde_v * v_volume
   replace valor with v_valor
   replace ent_sai with 'S'
   commit


   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
   n_codigo12 = 0
   n_descrica = space (40)
enddo
return






procedure g91saidc      
do sinal with 'MOVIMENTO', 'CORRECAO'
@ 5, 1 say space (78) 
select movi
set cursor on
do while .t.
   select movi
   do limpa
   n_codigo12 = 0
   n_forn = 0
   v_nota = space (7)
   @ 7, 3 say 'Codigo do produto...:' get n_codigo12 picture '9999999999999'
   @ 8, 3 say 'Codigo do Clien/Forn:' get n_forn picture '9999999'
   @ 9, 3 say 'Numero da nota/docum:' get v_nota picture '@!'
   read
   v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
   v_forn = strzero (n_forn, 7, 0)
   locate all for FORN=v_forn .AND.NOTA=v_nota .AND.CODIGO12=v_codigo12
   if lastkey () = 27
      exit
   endif
   if ! found ()
      do mensagem with 'Lancamento nao foi encontado !!!', mem_tempo
      loop
   endif
   v_dig_con1 = dig_con1
   v_codigo4 = codigo4
   v_dig_con2 = dig_con2
   v_movim = movim
   v_data = data
   v_data_n = data_n
   v_qtde_v = qtde
   v_volume = volume
   v_qtde_t = qtde_t
   v_valor = valor
   v_rzso = rzso
   select prod
   find (v_codigo12)
   if ! found ()
      do mensagem with 'Produto nao esta cadastrado !!!', mem_tempo
      loop
   endif
   v_descrica = descricao
   v_est_min = est_min
   v_estoque = estoque
   v_compra = compra
   v_qtde_c = qtde_c
   v_custo = custo
   v_margem = margem
   v_preco_u = preco_u
   select movi
   @ 7, 39 say v_descrica 
   @ 8, 39 say v_rzso 
   @ 10, 3 say 'Codigo de movimento.:' get v_movim picture '@!' valid v_movim$"VS" 
   @ 10, 30 say '[V]-Venda    [S]-Saida para acerto' 
   @ 11, 3 say 'Data do movimento...:' get v_data
   @ 12, 3 say 'Data da nota/doc....:' get v_data_n
   @ 13, 3 say 'Vol. X Qtde cada Vol:' get v_volume picture '99999'
   @ 13, col () + 1 say '[X]' get v_qtde_v picture '99999.99'
   @ 14, 3 say 'Valor total nota/doc:' get v_valor picture '99999999.99'
   read
   @ 13, 44 say 'Qtde total:' + str (v_volume * v_qtde_v, 12, 2) 

   if lastkey () = 27
      exit
   endif
   v_qtde_t = v_volume * v_qtde_v

   dif_qtde = v_qtde_t - qtde_t
   dif_valor = v_valor - valor

   v_forn = strzero (n_forn, 7, 0)

   @ 16, 2 say 'ESTOQUE ANTERIOR        ESTOQUE ATUAL            PRECO VENDA' 
   @ 15, 1, 15, 78 box frame1
   @ 17, 1, 17, 78 box frame1

   @ 16, 25, 22, 25 box frame1
   @ 16, 50, 22, 50 box frame1






   @ 18, 2 say 'ESTOQUE.:' + str (v_estoque, 9, 2) 
   @ 19, 2 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 2 say 'PC CUSTO:' + str (v_custo, 9, 2) 
   @ 21, 2 say 'PC VENDA:' + str (v_preco_u, 9, 2) 
   @ 22, 2 say 'MARGEM..:' + str (v_margem, 9, 2) 

   @ 18, 26 say 'ESTOQUE.:' + str (v_estoque - dif_qtde, 9, 2) 
   @ 19, 26 say 'EST.MIN.:' + str (v_est_min, 9, 2) 
   @ 20, 26 say 'MARGEM..:' + str (v_margem, 9, 2) 
   v_venda = v_preco_u
   @ 21, 26 say 'PC VENDA:' + str (v_venda, 9, 2) 
   @ 22, 26 say 'PC NOTA.:' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 

   @ 18, 51 say 'PC CUSTO:' + str (v_custo, 9, 2) 
   @ 19, 51 say 'PC VENDA:' + str (v_venda, 9, 2) 
   @ 20, 51 say 'PC NOTA.:' + str (v_valor / (v_volume * v_qtde_v), 9, 2) 
   if v_custo != 0
      @ 21, 51 say 'LUCR CUS:' + str ((v_valor / (v_volume * v_qtde_v) / v_custo - 1) * 100, 9, 2) + ' %' 
   endif
   if v_venda != 0
      @ 22, 51 say 'LUCR VEN:' + str ((v_valor / (v_volume * v_qtde_v) / v_venda - 1) * 100, 9, 2) + ' %' 
   endif

   read

   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   do aviso with 24, 'Atualiza o estoque com estes dados ?'

   do confirme
   if lastkey () = 27
      exit
   endif
   if confirme != 'S'
      loop
   endif
   select prod
   replace estoque with v_estoque - dif_qtde



   replace venda with venda + dif_valor
   replace qtde with qtde + dif_qtde
   commit
   select movi

   replace codigo12 with v_codigo12
   replace dig_con1 with v_dig_con1
   replace codigo4 with v_codigo4
   replace dig_con2 with v_dig_con2
   replace movim with v_movim
   replace data with v_data
   replace forn with v_forn
   replace rzso with v_rzso
   replace nota with v_nota
   replace serie with v_serie
   replace data_n with v_data_n
   replace qtde with v_qtde_v
   replace volume with v_volume
   replace qtde_t with v_qtde_v * v_volume
   replace valor with v_valor
   replace ent_sai with 'S'
   commit


   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
enddo
return

function proforn        
parameters n_forn
v_forn = strzero (n_forn, 7, 0)
select clie
find (v_forn)
if ! found ()
   return .f.
else 
   @ row (), col () + 1 say rzso 
   return .t.
endif
function caltot         
parameters vol, qtde
@ row (), col () + 2 say 'Qtde total: ' + str (vol * qtde, 12, 2) 
if vol * qtde != 0
   return .t.
else 
   return .f.
endif
function profor         
parameters n_forn
v_forn = strzero (n_forn, 7, 0)
select clie
find (v_forn)
if ! found ()
   do mensagem with 'Cliente nao foi encontrado !!!', mem_tempo
   @ row (), col () + 1 say space (40) 
   return .t.
else 
   @ row (), col () + 1 say rzso 
   return .t.
endif
