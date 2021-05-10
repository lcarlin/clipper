restore screen
do while .t.
   mre = 1
   do sinal with 'CADASTRO', ' '
   @ 3, 1 say space (78) 
   @ 5, 1 say space (78) 
   do limpa
   set message to 5 center
   @ 3, 1 prompt 'PRODUTO' message 'Cadastro de Produtos'
   @ 3, col () + 3 prompt 'OPERADOR' message 'Cadastro de Operadores'
   @ 3, col () + 3 prompt 'FORNECEDOR' message 'Cadastro de Fornecedores'
   @ 3, col () + 3 prompt 'VARIAVEIS' message 'Cadastro de Variaveis do programa'
   @ 3, col () + 3 prompt 'DEPTO' message 'Cadastro de departamento'
   @ 3, col () + 3 prompt 'GRUPO' message 'Cadastro de grupos'
   @ 3, col () + 3 prompt 'INDEXA' message 'Gerar os arquivos de indice'
   @ 3, col () + 3 prompt 'Retorna' message 'Retorno ao Menu Principal'
   menu to mre
   do case
      case mre = 1
         do g91prod
      case mre = 2
         do g91oper

      case mre = 3
         do g91forn

      case mre = 4
         do g91vari

      case mre = 5
         do g91dept

      case mre = 6
         do g91grup

      case mre = 7
         do g91ind

      case mre = 8
         exit
   endcase
enddo
return






procedure g91prod       
do sinal with 'CADASTRO', 'PRODUTO'
@ 5, 1 say space (78) 
select prod
set cursor on
do while .t.
   do limpa
   n_codigo12 = 0
   n_codigo4 = 0
   v_codigo12 = space (12)
   v_codigo4 = space (4)
   v_dig_con1 = space (1)
   v_dig_con2 = space (1)
   v_desc_maq = space (18)
   v_descrica = space (40)
   v_desc_et1 = space (15)
   v_desc_et2 = space (15)
   v_preco_u = 0
   v_icms = 18.00
   v_depto_c = space (2)
   v_etiqueta = 'S'
   v_balanca = 'N'
   v_comunica = 'S'

   v_est_min = 0
   v_margem = 0
   v_data_en = date ()
   v_unidade = unidade
   v_grupo = '  '
   v_tipo = ' '
   do while .t.
      @ 7, 3 say 'Codigo Barras/Numerico..: ' get v_tipo picture '@!' valid (v_tipo$'BN') 
      read
      if v_tipo = 'N'
         if ! file ('CODIGO.MEM')
            mem_codigo = 1
         else 
            restore from codigo additive
         endif
         do while .t.
            v_codigo = strzero (mem_codigo, 12, 0)
            find (v_codigo)
            if ! found ()
               exit
            endif
            mem_codigo = mem_codigo + 1
         enddo
         save to codigo.mem all like mem_codigo
         n_codigo12 = mem_codigo
         @ 8, 3 say 'Codigo do produto.......: ' get n_codigo12 picture '999999999999' valid dig_con(n_codigo12) 
         read
         v_codigo12 = strzero (n_codigo12, 12, 0)
      else 
         @ 8, 3 say 'Codigo do produto.......: ' get n_codigo12 picture '9999999999999' valid dc_ean(n_codigo12) 
         read
         v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
      endif

      find (v_codigo12)
      if lastkey () = 27
         return
      endif
      if n_codigo12 = 0
         loop
      endif
      if found ()
         v_comunica = comunica
      endif
      @ 8, 50 say 'Comunica c/micro:' get v_comunica picture '@!' valid (v_comunica$"SN") 
      read
      if lastkey () = 27
         return
      endif
      if ! found ()
         if v_comunica = 'S'






            n_codigo4 = val (acha ())
         else 
            n_codigo4 = 0
         endif
         do mensagem with 'Produto nao esta cadastrado !!!', mem_tempo
         fv = .t.
      else 
         if v_comunica = comunica
            v_codigo4 = codigo4
            v_dig_con2 = dig_con2
         else 
            if v_comunica = 'S'
               v_codigo4 = acha ()
            else 
               v_codigo4 = '0'
               v_dig_con2 = '0'
            endif
         endif
         find (v_codigo12)
         v_codigo12 = codigo12

         v_dig_con1 = dig_con1

         v_desc_maq = desc_maq
         v_descrica = descricao
         v_desc_et1 = desc_et1
         v_desc_et2 = desc_et2
         v_preco_u = preco_u
         v_icms = icms
         v_depto_c = depto_c
         v_etiqueta = etiqueta
         v_balanca = balanca


         v_est_min = est_min
         v_margem = margem
         v_data_en = data_en
         v_unidade = unidade

         n_codigo4 = val (v_codigo4)
         v_grupo = grupo
         fv = .f.
      endif
      exit
   enddo
   do while .t.

      if v_tipo = 'N'
         @ 8, 3 say 'Codigo do produto.......: ' 
         set color to gr+/g
         @ 8, col () + 1 say str (n_codigo12, 12, 0) 
         set color to &padrao
      else 
         @ 8, 3 say 'Codigo do produto.......: ' 
         set color to gr+/g
         @ 8, col () + 1 say str (n_codigo12, 13, 0) 
         set color to &padrao
      endif
      @ 8, 50 say 'Comunica c/micro:' 
      set color to gr+/g
      @ 8, col () + 1 say v_comunica 
      set color to &padrao
      @ 9, 3 say 'Codigo do produto 4 dig.: ' 
      set color to gr+/g
      @ 9, col () + 1 say str (n_codigo4, 4, 0) 
      set color to &padrao
      @ 10, 3 say 'Descricao do produto....: ' get v_descrica picture '@!'
      @ 11, 3 say 'Descricao para maquina..: ' get v_desc_maq picture '@!'
      @ 12, 3 say 'Descricao para etiqueta.: ' get v_desc_et1 picture '@!'
      @ 13, 3 say '                 Linha 2: ' get v_desc_et2 picture '@!'
      @ 14, 3 say 'Codigo do grupo.........: ' get v_grupo picture '99' valid codgr(v_grupo) 

      @ 15, 3 say 'Depto a ser conectado...: ' get v_depto_c picture '99' valid depc(v_depto_c) 
      @ 16, 3 say 'ICMS....................: ' get v_icms picture '99.99'
      @ 17, 3 say 'Imprime etiqueta........: ' get v_etiqueta picture '@!' valid (v_etiqueta$"SN") 

      @ 17, 50 say 'Balanca:' get v_balanca picture '@!' valid (v_balanca$"SN") 


      @ 18, 3 say 'Margem..................: ' get v_margem picture '999.99'
      @ 18, 50 say 'P.Venda:' get v_preco_u picture '999999.99'
      @ 19, 3 say 'Unidade de medida.......: ' get v_unidade picture '@!'

      @ 20, 3 say 'Estoque minimo..........: ' get v_est_min picture '99999.99'
      @ 21, 3 say 'Data da ultima alteracao: ' get v_data_en

      read
      do confirme
      if lastkey () = 27
         exit
      elseif confirme != 'S'
         loop
      endif
      select prod
      v_codigo4 = strzero (n_codigo4, 4, 0)
      if v_tipo = 'N'
         v_codigo12 = strzero (n_codigo12, 12, 0)
         v_dig_con1 = dig_con1 (n_codigo12)
      else 
         v_codigo12 = substr (strzero (n_codigo12, 13, 0), 1, 12)
         v_dig_con1 = substr (strzero (n_codigo12, 13, 0), 13, 1)
      endif

      v_dig_con2 = dig_con1 (n_codigo4)
      if fv = .t.
         append blank 
         replace codigo12 with v_codigo12
         replace codigo4 with v_codigo4
         replace dig_con1 with v_dig_con1
         replace dig_con2 with v_dig_con2
         replace desc_maq with v_desc_maq
         replace descricao with v_descrica
         replace desc_et1 with v_desc_et1
         replace desc_et2 with v_desc_et2
         if preco_u != v_preco_u
            replace preco_a with preco_u
            replace data_a with date ()
            replace etiqn with '1'
            replace preco_u with v_preco_u
         endif
         replace icms with v_icms
         replace depto_c with v_depto_c
         replace etiqueta with v_etiqueta
         replace balanca with v_balanca
         replace comunica with v_comunica


         replace est_min with v_est_min
         replace margem with v_margem
         replace data_en with v_data_en
         replace unidade with v_unidade
         replace grupo with v_grupo

         exit
      endif
      do aviso with 24, '[Pg Up]=Volta um registro [Pg Dn]=Avanca um registro [D]=Deleta [ESC]=Volta'
      op = inkey (0)
      replace codigo12 with v_codigo12
      replace codigo4 with v_codigo4
      replace dig_con1 with v_dig_con1
      replace dig_con2 with v_dig_con2
      replace desc_maq with v_desc_maq
      replace descricao with v_descrica
      replace desc_et1 with v_desc_et1
      replace desc_et2 with v_desc_et2
      if preco_u != v_preco_u
         replace preco_a with preco_u
         replace data_a with date ()
         replace etiqn with '1'
         replace preco_u with v_preco_u
      endif
      replace icms with v_icms
      replace depto_c with v_depto_c
      replace etiqueta with v_etiqueta
      replace balanca with v_balanca
      replace comunica with v_comunica

      replace est_min with v_est_min
      replace margem with v_margem
      replace data_en with v_data_en
      replace unidade with v_unidade
      replace grupo with v_grupo
      commit
      do case
         case op = 3
            skip 1
         case op = 18
            skip -1
         case op = 68 .or. op = 100
            @ 24, 1 say space (79) 
            do confirme
            if confirme = 'S'
               delete
               pack
            endif
      endcase
      @ 8, 42 say space (20) 
      @ 9, 34 say space (20) 
      @ 14, 32 say space (40) 
      @ 15, 32 say space (40) 
      if v_tipo = 'N'
         v_codigo12 = codigo12
      else 
         v_codigo12 = codigo12 + dig_con1
      endif
      n_codigo12 = val (v_codigo12)
      v_codigo4 = codigo4
      n_codigo4 = val (codigo4)
      v_dig_con1 = dig_con1
      v_dig_con2 = dig_con2
      v_desc_maq = desc_maq
      v_descrica = descricao
      v_desc_et1 = desc_et1
      v_desc_et2 = desc_et2
      v_preco_u = preco_u
      v_icms = icms
      v_depto_c = depto_c
      v_etiqueta = etiqueta
      v_balanca = balanca
      v_comunica = comunica
      v_estoque = estoque
      v_est_min = est_min
      v_margem = margem
      v_data_en = data_en
      v_unidade = unidade
      v_grupo = grupo


      @ 24, 1 say space (79) 
      if op = 27
         exit
      endif
   enddo
   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
enddo
return






procedure g91oper       
do sinal with 'CADASTRO', 'OPERADOR'
@ 5, 1 say space (78) 
select oper
goto bottom
if val (codigo) >= 15
   v_codoper = '01'
else 
   v_codoper = strzero (val (codigo) + 1, 2, 0)
endif
set cursor on
do while .t.
   do limpa
   v_nome = space (9)
   v_nome_c = space (40)
   do while .t.
      @ 8, 10 say 'Codigo do operador......: ' get v_codoper picture '99' valid codop(v_codoper) 
      read
      if lastkey () = 27
         return
      endif
      if v_codoper = space (2)
         loop
      endif
      find (v_codoper)
      if ! found ()
         do mensagem with 'Vendedor nao esta cadastrado !!!', mem_tempo
         fv = .t.
      else 
         v_nome = nome
         v_nome_c = nome_c
         fv = .f.
      endif
      exit
   enddo
   do while .t.
      @ 8, 10 say 'Codigo do operador......:  ' + v_codoper 
      @ 10, 10 say 'Nome do operador na maq.: ' get v_nome picture '@!'
      @ 12, 10 say 'Nome completo do operad.: ' get v_nome_c picture '@!'
      read
      do confirme
      if lastkey () = 27
         exit
      elseif confirme != 'S'
         loop
      endif
      if fv = .t.
         append blank 
         replace codigo with v_codoper, nome with v_nome, nome_c with v_nome_c
         commit
         exit
      endif
      do aviso with 24, '[Pg Up]=Volta um registro [Pg Dn]=Avanca um registro [D]=Deleta [ESC]=Volta'
      op = inkey (0)
      replace codigo with v_codoper, nome with v_nome, nome_c with v_nome_c
      commit
      do case
         case op = 3
            skip 1
            if eof ()
               exit
            endif
         case op = 18
            skip -1
            if bof ()
               exit
            endif
         case op = 68 .or. op = 100
            @ 24, 1 say space (79) 
            do confirme
            if confirme = 'S'
               delete
               pack
            endif
      endcase
      v_codoper = codigo
      v_nome = nome
      v_nome_c = nome_c
      @ 24, 1 say space (79) 
      if op = 27
         exit
      endif
   enddo
   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
enddo
return






procedure g91forn       
do sinal with 'CADASTRO', 'FORNECED'
@ 5, 1 say space (78) 
select clie
goto bottom
n_codc = val (codc) + 1
set cursor on
do while .t.
   do limpa
   v_codc = space (7)
   v_rzso = space (40)
   v_cgcm = space (18)
   v_inse = space (20)
   v_ruad = space (30)
   v_nume = 0
   v_comp = space (10)
   v_bair = space (25)
   v_cida = space (25)
   v_esta = space (2)
   v_cepo = space (9)
   v_tel1 = space (15)
   v_tel2 = space (15)
   v_telfax = space (15)
   v_telex = space (15)
   v_cont = space (20)
   v_grur = space (2)
   set cursor on
   do while .t.
      @ 7, 3 say 'Cod.Fornec..:' get n_codc picture '9999999'
      read
      v_codc = strzero (n_codc, 7, 0)
      find (v_codc)
      if lastkey () = 27
         return
      endif
      if v_codc = space (7)
         loop
      endif
      if ! found ()
         do mensagem with 'Fornec. nao esta cadastrado !!!', mem_tempo
         do aviso with 24, 'Cadastrar novo Fornec. ?'
         do confirme
         @ 24, 0 say space (79) 
         if confirme != 'S'
            loop
         endif
         select clie

         goto bottom

         v_codc = strzero (val (codc) + 1, 7, 0)



         @ 7, 3 say 'Cod.Fornec..:' get v_codc picture '@!'
         fv = .t.
      else 
         v_codc = codc
         v_rzso = rzso
         v_cgcm = cgcm
         v_inse = inse
         v_ruad = ruad
         v_nume = nume
         v_comp = comp
         v_bair = bair
         v_cida = cida
         v_esta = esta
         v_cepo = cepo
         v_tel1 = tel1
         v_tel2 = tel2
         v_telfax = telfax
         v_telex = telex
         v_cont = cont


         v_grur = grur



         fv = .f.
      endif
      exit
   enddo
   do while .t.
      @ 7, 3 say 'Cod.Fornec..:' get n_codc picture '9999999'
      @ 7, 25 say 'Razao Social:' get v_rzso picture '@!'
      @ 9, 3 say 'Endereco....:' get v_ruad picture '@!'
      @ 9, col () + 1 say 'Num...:' get v_nume picture '99999'
      @ 9, col () + 1 say 'Compl:' get v_comp picture '@!'
      @ 11, 3 say 'Bairro......:' get v_bair picture '@!'
      @ 11, col () say '    Cidade:' get v_cida picture '@!'
      @ 13, 3 say 'Estado......:' get v_esta picture '@!'
      @ 13, col () say ' CEP:' get v_cepo picture '99999-999'
      @ 13, col () say '   Grupo:' get v_grur picture '@!'
      @ 13, col () say ' Contato:' get v_cont picture '@!'
      @ 15, 3 say 'Telefone....:' get v_tel1 picture '(####)####-####'
      @ 15, col () say '            Telefone...:' get v_tel2 picture '(####)####-####'
      @ 17, 3 say 'FAX.........:' get v_telfax picture '(####)####-####'
      @ 17, col () say '            Telex......:' get v_telex picture '(####)####-####'
      @ 19, 3 say 'C.G.C.......:' get v_cgcm picture '99.999.999/9999-99'
      @ 19, col () say '         Insc. Est.:' get v_inse picture '@!'





      read
      do confirme
      if lastkey () = 27
         exit
      elseif confirme != 'S'
         loop
      endif
      v_codc = strzero (n_codc, 7, 0)
      if fv = .t.
         locate all for CGCM=v_cgcm
         if found ()
            do mensagem with 'Fornec. ja esta cadastrado !! codigo:' + codc, mem_tempo
            v_codc = codc
            exit
         endif
         append blank 
         replace codc with v_codc, rzso with v_rzso, cgcm with v_cgcm, inse with v_inse
         replace ruad with v_ruad, nume with v_nume, comp with v_comp, bair with v_bair, cida with v_cida
         replace esta with v_esta, cepo with v_cepo, tel1 with v_tel1, tel2 with v_tel2, telfax with v_telfax
         replace telex with v_telex, cont with v_cont, grur with v_grur

         commit
         exit
      endif
      do aviso with 24, '[Pg Up]=Volta um registro [Pg Dn]=Avanca um registro [D]=Deleta [ESC]=Volta'
      replace codc with v_codc, rzso with v_rzso, cgcm with v_cgcm, inse with v_inse
      replace ruad with v_ruad, nume with v_nume, comp with v_comp, bair with v_bair, cida with v_cida
      replace esta with v_esta, cepo with v_cepo, tel1 with v_tel1, tel2 with v_tel2, telfax with v_telfax
      replace telex with v_telex, cont with v_cont, grur with v_grur

      commit
      op = inkey (0)
      do case
         case op = 3
            skip 1
         case op = 18
            skip -1
         case op = 68 .or. op = 100
            @ 24, 1 say space (79) 
            do confirme
            if confirme = 'S'
               delete
               pack
            endif
      endcase
      v_codc = codc
      n_codc = val (codc)
      v_rzso = rzso
      v_cgcm = cgcm
      v_inse = inse
      v_ruad = ruad
      v_nume = nume
      v_comp = comp
      v_bair = bair
      v_cida = cida
      v_esta = esta
      v_cepo = cepo
      v_tel1 = tel1
      v_tel2 = tel2
      v_telfax = telfax
      v_telex = telex
      v_cont = cont


      v_grur = grur




      @ 24, 1 say space (79) 
      if op = 27
         exit
      endif
   enddo
   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
enddo
return






procedure g91vari       
do sinal with 'CADASTRO', 'VARIAVEIS'
@ 5, 1 say space (78) 
do g91var with 'N'
return





procedure g91dept       
do sinal with 'CADASTRO', 'DEPARTAMENTO'
@ 5, 1 say space (78) 
select dept
goto bottom
if val (codigo) >= 50
   v_codigo = '01'
else 
   v_codigo = strzero (val (codigo) + 1, 2, 0)
endif
set cursor on
do while .t.
   do limpa
   v_descrica = space (18)
   v_aliquota = 0
   v_tipo_icm = ' '
   do while .t.
      @ 8, 10 say 'Codigo do departamento..: ' get v_codigo picture '99' valid codep(v_codigo) 
      read
      if lastkey () = 27
         return
      endif
      if v_codigo = space (2)
         loop
      endif
      find (v_codigo)
      if ! found ()
         do mensagem with 'Departamento nao esta cadastrado !!!', mem_tempo
         fv = .t.
      else 
         v_descrica = descricao
         v_aliquota = v_aliquota
         v_tipo_icm = tipo_icms
         fv = .f.
      endif
      exit
   enddo
   do while .t.
      @ 8, 10 say 'Codigo do departamento..:  ' + v_codigo 
      @ 10, 10 say 'Descricao do departament: ' get v_descrica picture '@!'
      @ 12, 10 say 'Aliquota do departemento: ' get v_aliquota picture '99.99'
      @ 14, 10 say 'Tipo de aliquota do dept: ' get v_tipo_icm picture '@!' valid (v_tipo_icms$"ITF") 
      @ 14, 40 say '[I]-Mercadoria isenta' 
      @ 15, 40 say '[F]-Mercadoria com substit.tributaria' 
      @ 16, 40 say '[T]-Mercadoria tributada' 
      read
      do confirme
      if lastkey () = 27
         exit
      elseif confirme != 'S'
         loop
      endif
      if fv = .t.
         append blank 
         replace codigo with v_codigo, descricao with v_descrica, aliquota with v_aliquota, tipo_icms with v_tipo_icm
         commit
         exit
      endif
      do aviso with 24, '[Pg Up]=Volta um registro [Pg Dn]=Avanca um registro [D]=Deleta [ESC]=Volta'
      op = inkey (0)
      replace codigo with v_codigo, descricao with v_descrica, aliquota with v_aliquota, tipo_icms with v_tipo_icm
      commit
      do case
         case op = 3
            skip 1
            if eof ()
               exit
            endif
         case op = 18
            skip -1
            if bof ()
               exit
            endif
         case op = 68 .or. op = 100
            @ 24, 1 say space (79) 
            do confirme
            if confirme = 'S'
               delete
               pack
            endif
      endcase
      v_codigo = codigo
      v_descrica = descricao
      v_aliquota = v_aliquota
      v_tipo_icm = tipo_icms
      @ 24, 1 say space (79) 
      if op = 27
         exit
      endif
   enddo
   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
enddo
return






procedure g91grup       
do sinal with 'CADASTRO', 'GRUPO'
@ 5, 1 say space (78) 
select grup
goto bottom
v_codgrupo = strzero (val (codgrupo) + 1, 2, 0)
set cursor on
do while .t.
   do limpa
   v_nome = space (40)

   do while .t.
      @ 8, 10 say 'Codigo do grupo.........: ' get v_codgrupo picture '99'
      read
      if lastkey () = 27
         return
      endif
      if v_codgrupo = space (2)
         loop
      endif
      find (v_codgrupo)
      if ! found ()
         do mensagem with 'Grupo nao esta cadastrado !!!', mem_tempo
         fv = .t.
      else 
         v_nome = nome
         fv = .f.
      endif
      exit
   enddo
   do while .t.
      @ 8, 10 say 'Codigo do grupo.........:  ' + v_codgrupo 
      @ 10, 10 say 'Nome do grupo...........: ' get v_nome picture '@!'
      read
      do confirme
      if lastkey () = 27
         exit
      elseif confirme != 'S'
         loop
      endif
      if fv = .t.
         append blank 
         replace codgrupo with v_codgrupo, nome with v_nome
         commit
         exit
      endif
      do aviso with 24, '[Pg Up]=Volta um registro [Pg Dn]=Avanca um registro [D]=Deleta [ESC]=Volta'
      op = inkey (0)
      replace codgrupo with v_codgrupo, nome with v_nome
      commit
      do case
         case op = 3
            skip 1
            if eof ()
               exit
            endif
         case op = 18
            skip -1
            if bof ()
               exit
            endif
         case op = 68 .or. op = 100
            @ 24, 1 say space (79) 
            do confirme
            if confirme = 'S'
               delete
               pack
            endif
      endcase
      v_codgrupo = codgrupo
      v_nome = nome

      @ 24, 1 say space (79) 
      if op = 27
         exit
      endif
   enddo
   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
enddo
return







procedure g91ind        
do sinal with 'CADASTRO', 'INDEXA'
@ 5, 1 say space (78) 
do limpa
v_opc = ' '
@ 8, 10 say 'Deseja reindexar...:' get v_opc picture '@!' valid (v_opc$'SN') 
@ 8, col () + 2 say '[S/N]' 
read
if lastkey () = 27
   return
endif
if v_opc != 'S'
   return
endif
@ 9, 10 say 'Indexando..........: ' 
close databases

use cadaprod
@ 9, 31 say 'CADAPROD -> G91PROD1' 
index on codigo12 to g91prod1
@ 10, 31 say 'CADAPROD -> G91PROD2' 
index on codigo4 to g91prod2
@ 11, 31 say 'CADAPROD -> G91DESC' 
index on descricao to g91desc

use g91forn
@ 12, 31 say 'G91FORN  -> G91COD1' 
index on codc to g91cod1

use g91oper
@ 13, 31 say 'G91OPER  -> G91COD2' 
index on codigo to g91cod2

use g91movi
@ 14, 31 say 'G91MOVI  -> G91MOV1' 
index on codigo12+dtoc(data_n) to g91mov1

use g91dept
@ 15, 31 say 'G91DEPT  -> G91DEPT' 
index on codigo to g91dept

use g91prod
@ 16, 31 say 'G91PROD  -> G91PROD' 
index on codigo12 to g91prod

use g91grup
@ 17, 31 say 'G91GRUP  -> G91GRUP' 
index on codgrupo to g91grup

close databases

select (1)
use cadaprod index g91prod1, g91prod2, g91desc alias prod

select (2)
use g91forn index g91cod1 alias clie

select (3)
use g91oper index g91cod2 alias oper

select (4)
use g91movi index g91mov1 alias movi

select (5)
use g91dept index g91dept alias dept

select (6)
use g91prod index g91prod alias prmq

select (7)
use g91grup index g91grup alias grup

do aviso with 20, 'Digite uma tecla para continuar'
inkey (0)

return


function dig_con        
parameters cod
if cod = 0
   return .f.
endif
v_plu = strzero (cod, 12, 0)
a = substr (v_plu, 1, 1)
b = substr (v_plu, 2, 1)
c = substr (v_plu, 3, 1)
d = substr (v_plu, 4, 1)
e = substr (v_plu, 5, 1)
f = substr (v_plu, 6, 1)
g = substr (v_plu, 7, 1)
h = substr (v_plu, 8, 1)
i = substr (v_plu, 9, 1)
j = substr (v_plu, 10, 1)
k = substr (v_plu, 11, 1)
l = substr (v_plu, 12, 1)
dig_con = 0
dig_con = 10 - mod ((val (b) + val (d) + val (f) + val (h) + val (j) + val (l)) * 3 + val (a) + val (c) + val (e) + val (g) + val (i) + val (k), 10)
if dig_con >= 10
   dig_con = 0
endif
@ row (), col () + 1 say '- ' + str (dig_con, 1, 0) 
return .t.

function dig_con2       
parameters cod, fg
if fg = .t.
   if cod = 0
      return .f.
   endif
   v_plu = strzero (cod, 4, 0)
   select prod
   set order to 2
   find (v_plu)
   set order to 1
   if found ()
      do mensagem with 'Produto ja esta cadastrado !!!', mem_tempo
      return .f.
   endif
endif
v_plu = strzero (cod, 12, 0)
a = substr (v_plu, 1, 1)
b = substr (v_plu, 2, 1)
c = substr (v_plu, 3, 1)
d = substr (v_plu, 4, 1)
e = substr (v_plu, 5, 1)
f = substr (v_plu, 6, 1)
g = substr (v_plu, 7, 1)
h = substr (v_plu, 8, 1)
i = substr (v_plu, 9, 1)
j = substr (v_plu, 10, 1)
k = substr (v_plu, 11, 1)
l = substr (v_plu, 12, 1)
dig_con = 0
dig_con = 10 - mod ((val (b) + val (d) + val (f) + val (h) + val (j) + val (l)) * 3 + val (a) + val (c) + val (e) + val (g) + val (i) + val (k), 10)
if dig_con >= 10
   dig_con = 0
endif
@ row (), col () + 1 say '- ' + str (dig_con, 1, 0) 
return .t.

function dig_con1       
parameters cod
if cod = 0
   return '0'
endif
v_plu = strzero (cod, 12, 0)
a = substr (v_plu, 1, 1)
b = substr (v_plu, 2, 1)
c = substr (v_plu, 3, 1)
d = substr (v_plu, 4, 1)
e = substr (v_plu, 5, 1)
f = substr (v_plu, 6, 1)
g = substr (v_plu, 7, 1)
h = substr (v_plu, 8, 1)
i = substr (v_plu, 9, 1)
j = substr (v_plu, 10, 1)
k = substr (v_plu, 11, 1)
l = substr (v_plu, 12, 1)
dig_con = 0
dig_con = 10 - mod ((val (b) + val (d) + val (f) + val (h) + val (j) + val (l)) * 3 + val (a) + val (c) + val (e) + val (g) + val (i) + val (k), 10)
if dig_con >= 10
   dig_con = 0
endif
return str (dig_con, 1, 0)

function codgr          
parameters v_cod
select grup
find (v_cod)
if ! found ()
   do mensagem with 'Grupo nao esta cadastrado, cadastre primeiro !!!', mem_tempo
   return .f.
endif
@ row (), col () + 1 say nome 
return .t.
function depc           
parameters v_dep
select dept
find (v_dep)
if ! found ()
   do mensagem with 'Departamento nao esta cadastrado, cadastre primeiro !!!', mem_tempo
   return .f.
endif
@ row (), col () + 1 say str (aliquota, 5, 2) + ' ' + descricao 
return .t.

function codop          
parameters cod
if val (cod) > 15
   return .f.
endif
return .t.
function codep          
parameters cod
if val (cod) > 50
   return .f.
endif
return .t.
