restore screen
do while .t.
   mre = 1
   do sinal with 'RELATORIO', ' '
   @ 3, 1 say space (78) 
   @ 5, 1 say space (78) 
   do limpa
   set message to 5 center
   @ 3, 2 prompt 'PRODUTO' message 'Relatorio de Produtos'
   @ 3, col () + 3 prompt 'FORNEC.' message 'Relatorio de Fornecedores'
   @ 3, col () + 3 prompt 'GOND.' message 'Relatorio de Etiqueta para gondola'
   @ 3, col () + 3 prompt 'OPER.' message 'Relatorio de Operadores'
   @ 3, col () + 3 prompt 'DEPTO' message 'Relatorio de departamento'
   @ 3, col () + 3 prompt 'GRUPO' message 'Relatorio de descricao dos grupos'
   @ 3, col () + 3 prompt 'MOVIM.' message 'Relatorio de movimento'
   @ 3, col () + 3 prompt 'VENDA' message 'Relatorio de Vendas(Diaria/mensal)'
   @ 3, col () + 3 prompt 'Retorna' message 'Retorno ao Menu Anterior'
   menu to mre
   do case
      case mre = 1
         do g91prodr
      case mre = 2
         do g91fornr

      case mre = 3
         do g91gond

      case mre = 4
         do g91operr

      case mre = 5
         do g91deptr

      case mre = 6
         do g91grur

      case mre = 7
         do g91vmovi

      case mre = 8
         do g91vendr

      case mre = 9
         exit
   endcase
enddo
return






procedure g91prodr      
do sinal with 'RELATORIO', 'PRODUTO'
do limpa
v_ind = ' '
v_est = ' '
v_grupo = '  '
v_alt = ' '
@ 10, 3 say 'Qual indice ->' get v_ind picture '9' valid (v_ind$"123") 
@ 10, col () + 5 say '1-Codigo(12) 2-Codigo(4)  3-Descricao' 
@ 11, 3 say 'Abaixo estoque minimo:' get v_est picture '@!' valid (v_est$"SN") 
@ 11, col () + 2 say '[S/N]' 
@ 12, 3 say 'Grupo especifico?....:' get v_grupo picture '99'
@ 13, 3 say 'So prod. c/ alt.preco:' get v_alt picture '@!' valid (v_alt$"SN ") 
@ 13, col () + 2 say '[S/N]' 
read
select prod
if v_ind = '1'
   set order to 1
elseif v_ind = '2'
   set order to 2
elseif v_ind = '3'
   set order to 3
endif

do limpa

do imprime with 'Relatorio de Produtos'
if tk != 13
   return
endif
pg = 0
i = 0

v_fil = ''
if v_grupo != '  '
   v_fil = 'GRUPO=v_grupo'
endif
if v_est = 'S'
   if v_fil = ''
      v_fil = 'ESTOQUE<EST_MIN'
   else 
      v_fil = v_fil + ' .AND. ESTOQUE<EST_MIN'
   endif
endif
if v_alt = 'S'
   if v_fil = ''
      v_fil = "ETIQN='1'"
   else 
      v_fil = v_fil + ' .AND. ETIQN="1"'
   endif
endif


select prod












do aviso with 24, 'Aguarde.....'

set filter to &v_fil
goto top

@ 24, 0 say space (80) 

set device to printer
do while ! eof ()
   do caber with 'Relatorio de Produtos', ' '

   @ prow () + 1, 0 say chr (mem_cond) + ' CODIGO 12    DC COD4 DC DESCRICAO                                GR PRECO UN  DEP ALIQ. ESTOQUE   EST.MIN. MARGEM COMUN ETIQ. BAL.' 
   @ prow () + 1, 0 say ' ============ == ==== == ======================================== == ========= === ===== ========= ======== ====== ===== ===== ====' 


   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set order to 1
         set device to screen
         return
      endif

      @ prow () + 1, 1 say codigo12 + '  ' + dig_con1 + ' ' + codigo4 + '  ' + dig_con2 + ' ' + descricao + ' ' + grupo + ' ' + str (preco_u, 9, 2) + '  ' + depto_c + ' ' + str (icms, 5, 2) + ' ' + str (estoque, 9, 2) + ' ' + str (est_min, 8, 2) + ;
         ' ' + str (margem, 6, 2) 
      @ prow (), pcol () say '    ' + comunica + '     ' + etiqueta + '    ' + balanca 
      skip 1
   enddo
enddo
eject
set device to screen
set filter to 
if v_alt = 'S'
   do limpa
   do aviso with 15, 'Desmarcar todos os precos alterados ?'
   hlpcmd = 4
   do confirme
   hlpcmd = 1
   if confirme != 'S'
      set order to 1
      return
   endif
   do aviso with 24, 'Aguarde.....'
   select prod
   replace all etiqn with ' '

   @ 24, 0 say space (80) 
endif
set order to 1
return






procedure g91fornr      
do sinal with 'RELATORIO', 'FORN/CLIEN'
do limpa
v_ind = ' '
@ 10, 3 say 'Qual indice ->' get v_ind picture '9' valid (v_ind$"12") 
@ 10, col () + 5 say '1-Codigo  2-Nome' 
read
select clie
if v_ind = '1'
   set order to 1
else 
   set order to 2
endif

var1 = space (1)

goto top
do limpa

do imprime with 'Relatorio dos Fornecedor/Cliente'
if tk != 13
   set order to 1
   return
endif
pg = 0
i = 0

set device to printer
do while ! eof ()
   do caber with 'Relatorio dos Fornecedor/Cliente', ' '
   @ prow () + 1, 0 say chr (mem_cond) + 'CODIGO  NOME                                     C.G.C.                    INSCRICAO ESTADUAL       CONTATO             TELEFONE' 
   @ prow () + 1, 0 say '        ENDERECO                                 BAIRRO                    CIDADE                   CEP       ES        FAX' 

   @ prow () + 1, 0 say '=======================================================================================================================================' 


   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set order to 1
         set device to screen
         return
      endif

      @ prow () + 1, 0 say codc + ' ' + rzso + ' ' + cgcm + '        ' + inse + '     ' + cont + tel1 
      @ prow () + 1, 8 say trim (ruad) + ' ' + alltrim (str (nume)) 
      @ prow (), 49 say bair 
      @ prow (), 75 say cida 
      @ prow (), 100 say cepo 
      @ prow (), 110 say esta 
      @ prow (), 120 say telfax 






      @ prow () + 1, 0 say replicate ('-', 135) 
      skip 1
   enddo
enddo
eject
set device to screen
set order to 1
set filter to 
return






procedure g91gond       
do sinal with 'RELATORIO', 'GONDOLA'
do limpa
select prod
do limpa
v_opc = ' '
@ 10, 3 say '1-Todos do banco de dados' 
@ 11, 3 say '2-Intervalo de codigos' 
@ 12, 3 say '3-Escolha de codigos' 
@ 13, 3 say '4-Por grupo' 
@ 14, 3 say '5-Todos com alteracao de preco' 
@ 15, 3 say 'Sua escolha?' get v_opc picture '9' valid (v_opc$'12345') 
read
if lastkey () = 27
   return
endif
do aviso with 24, 'Aguarde.....'

select prod
set order to 1
replace all etiq with '0'

@ 24, 0 say space (80) 

if v_opc = '3'
   do limpa
   lin = 7
   do while .t.
      n_codigo12 = 0
      @ lin, 3 say 'Cod. produto:' get n_codigo12 picture '9999999999999' valid marca(n_codigo12) 
      read
      if lastkey () = 27 .or. n_codigo12 = 0
         exit
      endif
      lin = lin + 1
      if lin > 21
         do limpa
         lin = 7
      endif
   enddo
elseif v_opc = '2'
   do limpa
   n_codigo1 = 0
   n_codigo2 = 0
   @ 15, 3 say 'Primeiro codigo:' get n_codigo1 picture '9999999999999' valid dc_ean(n_codigo1) 
   @ 16, 3 say 'Ultimo codigo..:' get n_codigo2 picture '9999999999999' valid dc_ean(n_codigo2) 
   read
   if lastkey () = 27
      return
   endif

   v_codigo12 = substr (strzero (n_codigo1, 13, 0), 1, 12)
   v_codigo2 = substr (strzero (n_codigo2, 13, 0), 1, 12)

   do aviso with 24, 'Aguarde.....'

   set filter to codigo12>=v_codigo12 .and.codigo12<=v_codigo2 .and.preco_u#0
   goto top
   replace all etiq with '1'
   set filter to 

   @ 24, 0 say space (80) 

elseif v_opc = '1'

   do aviso with 24, 'Aguarde.....'

   set filter to etiqueta='s' .and.preco_u#0
   goto top
   replace all etiq with '1'
   set filter to 

   @ 24, 0 say space (80) 

elseif v_opc = '4'
   do limpa
   n_grupo = '  '
   @ 15, 3 say 'Digite o grupo.:' get n_grupo picture '99'
   read
   if lastkey () = 27
      return
   endif
   do aviso with 24, 'Aguarde.....'
   set filter to grupo=n_grupo .and.preco_u#0
   goto top
   replace all etiq with '1'
   set filter to 
   @ 24, 0 say space (80) 
elseif v_opc = '5'
   do aviso with 24, 'Aguarde.....'
   set filter to etiqueta='s' .and.etiqn='1'
   goto top
   replace all etiq with '1'
   set filter to 
   @ 24, 0 say space (80) 
endif
do limpa
do aviso with 24, 'Aguarde.....'
set filter to etiq='1'
goto top
@ 24, 0 say space (80) 

do imprime with 'Relatorio de Etiqueta para Gondola'
if tk != 13
   set filter to 
   return
endif
pg = 0
i = 0

goto top
set device to printer
do while ! eof ()
   do escprint
   if fim
      exit
   endif

   v_preco_u = preco_u
   do gpreco with v_preco_u
   e_lin11 = stuff (e_lin1, 39, 15, chr (mem_norm) + codigo12 + '-' + dig_con1)
   e_lin12 = stuff (e_lin2, 39, 7, chr (mem_norm) + codigo4 + '-' + dig_con2)
   e_lin13 = stuff (e_lin3, 39, 13, chr (mem_norm) + 'R$ ' + str (v_preco_u, 9, 2))
   e_lin14 = stuff (e_lin4, 39, 16, chr (mem_norm) + desc_et1)
   e_lin15 = stuff (e_lin5, 39, 16, chr (mem_norm) + desc_et2)
   if mem_col = '1'
      @ prow () + 2, 0 say e_lin11 
      @ prow () + 1, 0 say e_lin12 
      @ prow () + 1, 0 say e_lin13 
      @ prow () + 1, 0 say e_lin14 
      @ prow () + 1, 0 say e_lin15 
   else 

      skip 1
      v_preco_u = preco_u
      do gpreco with v_preco_u
      e_lin1 = stuff (e_lin1, 39, 15, chr (mem_norm) + codigo12 + '-' + dig_con1)
      e_lin2 = stuff (e_lin2, 39, 7, chr (mem_norm) + codigo4 + '-' + dig_con2)
      e_lin3 = stuff (e_lin3, 39, 13, chr (mem_norm) + 'R$ ' + str (v_preco_u, 9, 2))
      e_lin4 = stuff (e_lin4, 39, 16, chr (mem_norm) + desc_et1)
      e_lin5 = stuff (e_lin5, 39, 16, chr (mem_norm) + desc_et2)
      @ prow () + 2, 0 say e_lin11 
      @ prow (), 40 say alltrim (e_lin1) 
      @ prow () + 1, 0 say e_lin12 
      @ prow (), 40 say alltrim (e_lin2) 
      @ prow () + 1, 0 say e_lin13 
      @ prow (), 40 say alltrim (e_lin3) 
      @ prow () + 1, 0 say e_lin14 
      @ prow (), 40 say alltrim (e_lin4) 
      @ prow () + 1, 0 say e_lin15 
      @ prow (), 40 say alltrim (e_lin5) 
   endif
   skip 1

enddo
eject
set filter to 
set device to screen
if v_opc = '5'
   do limpa
   do aviso with 15, 'Desmarcar todos os precos alterados ?'
   hlpcmd = 4
   do confirme
   hlpcmd = 1
   if confirme != 'S'
      return
   endif

   do aviso with 24, 'Aguarde.....'

   select prod
   replace all etiqn with ' '

   @ 24, 0 say space (80) 
endif
return


procedure g91operr      
do sinal with 'RELATORIO', 'OPERADORES'
do limpa
do imprime with 'Relatorio de Operadores'
if tk != 13
   return
endif
pg = 0
i = 0

select oper
goto top
set device to printer
do while ! eof ()
   do caber with 'Relatorio de operadores', ' '
   @ prow () + 1, 1 say 'COD NOME DO OPERADOR                         NA MAQUINA' 
   @ prow () + 1, 1 say '=== ======================================== ==========' 
   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set device to screen
         return
      endif

      @ prow () + 1, 1 say codigo + '  ' + nome_c + ' ' + nome 
      skip 1
   enddo
enddo
eject
set device to screen
return






procedure g91deptr      
do sinal with 'RELATORIO', 'DEPARTAMENTO'
do limpa
do imprime with 'Relatorio de Departamento'
if tk != 13
   return
endif
pg = 0
i = 0

select dept
goto top
set device to printer
do while ! eof ()
   do caber with 'Relatorio de progr. do departamento', ' '
   @ prow () + 1, 1 say 'COD DESCRICAO          ALIQUOTA TIPO' 
   @ prow () + 1, 1 say '=== ================== ======== ====' 
   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set device to screen
         return
      endif

      @ prow () + 1, 1 say codigo + '  ' + descricao + ' ' + str (aliquota) + '    ' + tipo_icms 
      skip 1
   enddo
enddo
eject
set device to screen
return

procedure g91grur       
do sinal with 'RELATORIO', 'GRUPOS'
do limpa
do imprime with 'Relatorio de Descricao dos grupos'
if tk != 13
   return
endif
pg = 0
i = 0

select grup
goto top
set device to printer
do while ! eof ()
   do caber with 'Relatorio de Descricao dos grupos', ' '
   @ prow () + 1, 1 say 'COD NOME DO GRUPO                           ' 
   @ prow () + 1, 1 say '=== ========================================' 
   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set device to screen
         return
      endif

      @ prow () + 1, 1 say codgrupo + '  ' + nome 
      skip 1
   enddo
enddo
eject
set device to screen
return






procedure g91vmovi      
do sinal with 'RELATORIO', 'MOVIMENTO'
do limpa
v_tipo = ' '
v_grupo = '  '
n_codigo = 0
@ 8, 3 say 'Vend/Comp/Entr/Said/Maq:' get v_tipo picture '@!' valid (v_tipo$" VCESM") 
@ 10, 3 say 'Codigo especifico......:' get n_codigo picture '9999999999999' valid dig_con5(n_codigo) 
@ 12, 3 say 'Grupo especifico.......:' get v_grupo picture '99'
read
if lastkey () = 27
   return
endif
v_codigo = substr (strzero (n_codigo, 13, 0), 1, 12)

select movi

do limpa

do imprime with 'Relatorio de movimento'
if tk != 13
   return
endif
pg = 0
i = 0
v_fil = ''
if n_codigo != 0
   v_codigo = substr (strzero (n_codigo, 13, 0), 1, 12)
   v_fil = 'CODIGO12=v_codigo'
endif
if v_tipo != ' '
   if v_fil = ''
      v_fil = 'MOVIM=v_tipo'
   else 
      v_fil = v_fil + ' .AND. MOVIM=v_tipo'
   endif
endif
do aviso with 24, 'Aguarde.....'

set filter to &v_fil
goto top

@ 24, 0 say space (80) 
set device to printer
t_venda = 0
t_qtde = 0
t_compra = 0
t_qtde_c = 0
do while ! eof ()
   do caber with 'Relatorio de movimento', ' '

   @ prow () + 1, 0 say chr (mem_cond) + ' CODIGO 12    DC COD4 DC DESCRICAO                                ENTRADAS              SAIDAS                SALDO' 
   @ prow () + 1, 1 say 'DATA         NF.No.  SR CLIENTE/FORNECEDOR                       QTDE      VALOR       QTDE      VALOR       QTDE ' 
   @ prow () + 1, 1 say '============ ======= == ======================================== ========= =========== ========= =========== =========' 


   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set filter to 
         set device to screen
         return
      endif
      v_codigo12 = codigo12
      select prod
      find (v_codigo12)
      if v_grupo != space (2)
         if v_grupo != grupo
            select movi
            skip 1
            loop
         endif
      endif
      v_dig_con1 = dig_con1
      v_codigo4 = codigo4
      v_dig_con2 = dig_con2
      v_descrica = descricao
      v_est_ini = est_ini

      t_venda = 0
      t_qtde = 0
      t_compra = 0
      t_qtde_c = 0

      @ prow () + 1, 1 say v_codigo12 + '  ' + v_dig_con1 + ' ' + v_codigo4 + '  ' + v_dig_con2 + ' ' + v_descrica 
      @ prow () + 1, 110 say str (v_est_ini, 9, 2) 
      select movi
      do while codigo12 = v_codigo12

         if ent_sai = 'S'
            e_qtde = 0
            e_valor = 0
            s_qtde = qtde_t
            s_valor = valor
         else 
            s_qtde = 0
            s_valor = 0
            e_qtde = qtde_t
            e_valor = valor
         endif
         v_est_ini = v_est_ini + e_qtde - s_qtde

         @ prow () + 1, 1 say dtoc (data_n) + '     ' + nota + serie + ' ' + rzso + ' ' + str (e_qtde, 9, 2) + ' ' + str (e_valor, 11, 2) + ' ' + str (s_qtde, 9, 2) + ' ' + str (s_valor, 11, 2) 
         skip 1
         t_venda = t_venda + s_valor
         t_qtde = t_qtde + s_qtde
         t_compra = t_compra + e_valor
         t_qtde_c = t_qtde_c + e_qtde
         if prow () >= 55
            do caber with 'Relatorio de movimento', ' '

            @ prow () + 1, 0 say chr (mem_cond) + ' CODIGO 12    DC COD4 DC DESCRICAO                                ENTRADAS              SAIDAS                SALDO' 
            @ prow () + 1, 1 say 'DATA         NF.No.  SR CLIENTE/FORNECEDOR                       QTDE      VALOR       QTDE      VALOR       QTDE ' 
            @ prow () + 1, 1 say '============ ======= == ======================================== ========= =========== ========= =========== =========' 
         endif
      enddo
      @ prow () + 1, 56 say 'Totais--> ' + str (t_qtde_c, 9, 2) + ' ' + str (t_compra, 11, 2) + ' ' + str (t_qtde, 9, 2) + ' ' + str (t_venda, 11, 2) 

   enddo
enddo
set filter to 
eject
set device to screen
return
procedure g91vendr      
do while .t.
   mre = 1
   do sinal with 'RELATORIO', 'VENDA'
   @ 3, 1 say space (78) 
   @ 5, 1 say space (78) 
   do limpa
   set message to 5 center
   @ 3, 2 prompt 'DIARIO' message 'Relatorio de venda de Produtos diario'
   @ 3, col () + 5 prompt 'ACUMULADO' message 'Relatorio de venda acumulado do mes'
   @ 3, col () + 5 prompt 'DEPTO' message 'Relatorio de Venda de departamento'
   @ 3, col () + 5 prompt 'OPER.' message 'Relatorio de Venda de Operadores'
   @ 3, col () + 5 prompt 'DETALH.' message 'Relatorio de entrada/saida detalhado'
   @ 3, col () + 5 prompt 'FECHAM.' message 'Fechamento do mes'
   @ 3, col () + 5 prompt 'Ret.' message 'Retorno ao Menu Anterior'
   menu to mre
   do case
      case mre = 1
         do g91vdiar
      case mre = 2
         do g91vacu

      case mre = 3
         do g91depr

      case mre = 4
         do g91vope

      case mre = 5
         do g91vdet

      case mre = 6
         do g91fech

      case mre = 7
         exit
   endcase
enddo
return






function marca          
parameters cod
v_cod = substr (strzero (cod, 13, 0), 1, 12)
if cod = 0
   return .t.
endif
if dc_ean (cod) = .f.
   return .f.
endif
find (v_cod)
if ! found ()
   do mensagem with 'Codigo nao existe !!!', mem_tempo
   return .f.
else 
   @ row (), col () + 2 say descricao 
   replace etiq with '1'
   return .t.
endif





procedure gpreco        
parameters preco

lin1 = ' ллл лл  ллл ллл л   ллл л   ллл ллл ллл     '
lin2 = ' л л  л    л   л л л л   л     л л л л л     '
lin3 = ' л л  л  ллл ллл ллл ллл ллл   л ллл ллл     '
lin4 = ' л л  л  л     л   л   л л л   л л л   л  лл '
lin5 = ' ллл ллл ллл ллл   л ллл ллл   л ллл   л   л '

cpreco = strzero (preco, 9, 2)
aux1 = space (4)
aux2 = space (4)
aux3 = space (4)
aux4 = space (4)
aux5 = space (4)
e_lin1 = chr (mem_cond) + space (60)
e_lin2 = chr (mem_cond) + space (60)
e_lin3 = chr (mem_cond) + space (60)
e_lin4 = chr (mem_cond) + space (60)
e_lin5 = chr (mem_cond) + space (60)
v_num = .f.
for i = 1 to 9
   if i >= 6
      v_num = .t.
   endif
   c_car = substr (cpreco, i, 1)
   v_car = val (substr (cpreco, i, 1))
   if c_car = '.'
      v_car = 10
   endif
   if v_car = 0 .and. v_num = .f.
      aux1 = space (4)
      aux2 = space (4)
      aux3 = space (4)
      aux4 = space (4)
      aux5 = space (4)
   else 
      aux1 = substr (lin1, v_car * 4 + 1, 4)
      aux2 = substr (lin2, v_car * 4 + 1, 4)
      aux3 = substr (lin3, v_car * 4 + 1, 4)
      aux4 = substr (lin4, v_car * 4 + 1, 4)
      aux5 = substr (lin5, v_car * 4 + 1, 4)
      v_num = .t.
   endif
   e_lin1 = stuff (e_lin1, (i - 1) * 4 + 2, 4, aux1)
   e_lin2 = stuff (e_lin2, (i - 1) * 4 + 2, 4, aux2)
   e_lin3 = stuff (e_lin3, (i - 1) * 4 + 2, 4, aux3)
   e_lin4 = stuff (e_lin4, (i - 1) * 4 + 2, 4, aux4)
   e_lin5 = stuff (e_lin5, (i - 1) * 4 + 2, 4, aux5)
next
if mem_etiq != 219
   for i = 1 to 61
      aux1 = substr (e_lin1, i, 1)
      if aux1 = chr (219)
         e_lin1 = stuff (e_lin1, i, 1, chr (mem_etiq))
      endif
      aux2 = substr (e_lin2, i, 1)
      if aux2 = chr (219)
         e_lin2 = stuff (e_lin2, i, 1, chr (mem_etiq))
      endif
      aux3 = substr (e_lin3, i, 1)
      if aux3 = chr (219)
         e_lin3 = stuff (e_lin3, i, 1, chr (mem_etiq))
      endif
      aux4 = substr (e_lin4, i, 1)
      if aux4 = chr (219)
         e_lin4 = stuff (e_lin4, i, 1, chr (mem_etiq))
      endif
      aux5 = substr (e_lin5, i, 1)
      if aux5 = chr (219)
         e_lin5 = stuff (e_lin5, i, 1, chr (mem_etiq))
      endif
   next
endif
return






procedure g91vdiar      
do sinal with 'VENDA', 'DIARIO'
do limpa
v_data = date ()
v_grupo = '  '
@ 10, 3 say 'Venda de qual data..:' get v_data
@ 12, 3 say 'Selecionar por grupo:' get v_grupo picture '99'
read
arq1 = databco (v_data)
if ! file (arq1)
   do mensagem with 'Nao foi efetuado nenhuma venda nesta data', mem_tempo
   return
endif

select (11)
use &arq1
index on codigo12 to g91temp

do limpa

do imprime with 'Relatorio de Venda diaria'
if tk != 13
   return
endif
pg = 0
i = 0

goto top
set device to printer
t_venda = 0
t_qtde = 0
do while ! eof ()
   do caber with 'Relatorio de Venda diario', 'Data: ' + dtoc (v_data) + ' Grupo: ' + v_grupo

   @ prow () + 1, 1 say 'CODIGO 12    COD4 DESCRICAO          PRECO UN  DEP QTDE VENDA VALOR VENDA' 
   @ prow () + 1, 1 say '============ ==== ================== ========= === ========== ============' 


   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set device to screen
         return
      endif
      v_codigo12 = codigo12
      if v_grupo != space (2)
         select prod
         find (v_codigo12)
         if v_grupo != grupo
            select (11)
            skip 1
            loop
         endif
      endif
      @ prow () + 1, 1 say codigo12 + ' ' + codigo4 + ' ' + desc_maq + ' ' + str (preco_u, 9, 2) + '  ' + depto_c + '    ' + str (qtde, 7, 2) + '  ' + str (venda, 11, 2) 
      t_venda = t_venda + venda
      t_qtde = t_qtde + qtde
      skip 1
   enddo
enddo
@ prow () + 1, 0 say replicate ('=', 80) 
@ prow () + 1, 1 say 'Quantidade total: ' + str (t_qtde, 9, 2) 
@ prow () + 1, 1 say 'Valor total.....: ' + str (t_venda, 13, 2) 
eject
set device to screen
return






procedure g91vacu       
do sinal with 'VENDA', 'ACUMULADO'
do limpa
v_dia = ' '
v_grupo = '  '
@ 10, 3 say 'Mensal ou corrente ->' get v_dia picture '@!' valid (v_dia$"MC") 
@ 10, col () + 5 say 'M-Mensal  C-Mes corrente' 
@ 12, 3 say 'Grupo especifico---->' get v_grupo picture '99'
read

if v_dia = 'M'
   v_data = space (5)
   @ 14, 3 say 'Digite o mes/ano-->' get v_data picture '99/99'
   read
   mes = val (substr (v_data, 1, 2))
   ano = val (substr (v_data, 4, 2))
   if mes > 12 .or. mes < 1
      do mensagem with 'Numero de mes invalido !!', mem_tempo
      return
   endif
   aux1 = dtbco (mes, ano)
   aux1 = stuff (aux1, 1, 3, 'PLU')
   if ! file (aux1)
      do mensagem with 'Nao foi efetuado nenhuma venda nesta data', mem_tempo
      return
   endif
   select (11)
   use &aux1
   v_mens = 'Do mes: ' + v_data + ' Grupo: ' + v_grupo
else 
   select prod
   v_mens = 'Do mes corrente,' + ' Grupo: ' + v_grupo
endif



do limpa

do imprime with 'Relatorio de Venda Acumulado'
if tk != 13
   return
endif
pg = 0
i = 0
if v_grupo != space (2)
   set filter to grupo=v_grupo
endif
goto top
set device to printer
t_venda = 0
t_qtde = 0
t_compra = 0
t_qtde_c = 0
do while ! eof ()
   do caber with 'Relatorio de Venda acumulado', v_mens

   @ prow () + 1, 1 say chr (mem_cond) + 'CODIGO 12    COD4 DESCRICAO          CUSTO     PRECO UN  MARG. DEP EST INIC. QTDE ENTR  VALOR ENTR   QTDE VENDA VALOR VENDA  SALDO' 
   @ prow () + 1, 1 say '============ ==== ================== ========= ========= ===== === ========= ========== ============ ========== ============ =========' 


   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set filter to 
         set device to screen
         return
      endif
      if venda + qtde + compra + qtde_c != 0
         @ prow () + 1, 1 say codigo12 + ' ' + codigo4 + ' ' + desc_maq + ' ' + str (custo, 9, 2) + ' ' + str (preco_u, 9, 2) + ' ' + str (margem, 5, 2) + '  ' + depto_c + ' ' + str (est_ini, 9, 2) + '    ' + str (qtde_c, 7, 2) + '  ' + str (compra, ;
            11, 2) + '    ' + str (qtde, 7, 2) + '  ' + str (venda, 11, 2) + ' ' + str (estoque, 9, 2) 
         t_venda = t_venda + venda
         t_qtde = t_qtde + qtde
         t_compra = t_compra + compra
         t_qtde_c = t_qtde_c + qtde_c
      endif
      skip 1
   enddo
enddo
@ prow () + 1, 1 say replicate ('=', 136) 
@ prow () + 1, 1 say 'Quantidade total venda.: ' + str (t_qtde, 9, 2) 
@ prow () + 1, 1 say 'Valor total venda......: ' + str (t_venda, 13, 2) 
@ prow () + 1, 1 say 'Quantidade total compra: ' + str (t_qtde_c, 9, 2) 
@ prow () + 1, 1 say 'Valor total compra.....: ' + str (t_compra, 13, 2) 
eject
set filter to 
set device to screen
return





procedure g91depr       
do sinal with 'RELATORIO', 'DEPARTAM.'
do limpa
v_dia = ' '
@ 10, 3 say 'Diario ou Mensal ->' get v_dia picture '@!' valid (v_dia$"DMC") 
@ 10, col () + 5 say 'D-diario  M-Mensal  C-Mes corrente' 
read

if v_dia = 'D'
   v_data = ctod ('  /  /  ')
   @ 12, 3 say 'Digite a data ---->' get v_data
   read
   aux1 = databco (v_data)
   aux1 = stuff (aux1, 1, 1, 'D')
   if ! file (aux1)
      do mensagem with 'Nao foi efetuado nenhuma venda nesta data', mem_tempo
      return
   endif
   select (11)
   use &aux1
   v_mens = 'Relatorio do dia: ' + dtoc (v_data)
elseif v_dia = 'M'
   v_data = space (5)
   @ 12, 3 say 'Digite o mes/ano-->' get v_data picture '99/99'
   read
   mes = val (substr (v_data, 1, 2))
   ano = val (substr (v_data, 4, 2))
   if mes > 12 .or. mes < 1
      do mensagem with 'Numero de mes invalido !!', mem_tempo
      return
   endif
   aux1 = dtbco (mes, ano)
   aux1 = stuff (aux1, 1, 3, 'DEP')
   if ! file (aux1)
      do mensagem with 'Nao foi efetuado nenhuma venda nesta data', mem_tempo
      return
   endif
   select (11)
   use &aux1
   v_mens = 'Relatorio do mes: ' + v_data
else 
   select dept
   v_mens = 'Relatorio do mes corrente'
endif

goto top
do limpa

do imprime with 'Relatorio de Venda de Departamento'
if tk != 13
   return
endif
pg = 0
i = 0
t_qtde1 = 0
t_total1 = 0
t_qtde2 = 0
t_total2 = 0

set device to printer
do while ! eof ()
   do caber with 'Relatorio de Venda de Departamento', v_mens

   @ prow () + 1, 1 say 'COD DESCRICAO          QTDE VEN VALOR VENDA QTDE ACU VALOR ACUMUL.' 
   @ prow () + 1, 1 say '=== ================== ======== =========== ======== =============' 
   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set device to screen
         return
      endif
      if qtde_1 + total_1 + qtde_2 + total_2 != 0
         @ prow () + 1, 1 say codigo + '  ' + descricao + '  ' + str (qtde_1, 7, 2) + ' ' + str (total_1, 11, 2) + '  ' + str (qtde_2, 7, 2) + ' ' + str (total_2, 13, 2) 
         t_qtde1 = t_qtde1 + qtde_1
         t_total1 = t_total1 + total_1
         t_qtde2 = t_qtde2 + qtde_2
         t_total2 = t_total2 + total_2
      endif
      skip 1
   enddo
enddo
@ prow () + 1, 0 say replicate ('=', 80) 
@ prow () + 1, 24 say str (t_qtde1, 8, 2) + str (t_total1, 12, 2) + ' ' + str (t_qtde2, 8, 2) + str (t_total2, 14, 2) 
eject
set device to screen
set filter to 
return






procedure g91vope       
do sinal with 'RELATORIO', 'OPERADOR'
do limpa
v_dia = ' '
@ 10, 3 say 'Diario ou Mensal ->' get v_dia picture '@!' valid (v_dia$"DMC") 
@ 10, col () + 5 say 'D-diario  M-Mensal  C-Mes corrente' 
read

if v_dia = 'D'
   v_data = ctod ('  /  /  ')
   @ 12, 3 say 'Digite a data ---->' get v_data
   read
   aux1 = databco (v_data)
   aux1 = stuff (aux1, 1, 1, 'O')
   if ! file (aux1)
      do mensagem with 'Nao foi efetuado nenhuma venda nesta data', mem_tempo
      return
   endif
   select (11)
   use &aux1
   v_mens = 'Relatorio do dia: ' + dtoc (v_data)
elseif v_dia = 'M'
   v_data = space (5)
   @ 12, 3 say 'Digite o mes/ano-->' get v_data picture '99/99'
   read
   mes = val (substr (v_data, 1, 2))
   ano = val (substr (v_data, 4, 2))
   if mes > 12 .or. mes < 1
      do mensagem with 'Numero de mes invalido !!', mem_tempo
      return
   endif
   aux1 = dtbco (mes, ano)
   aux1 = stuff (aux1, 1, 3, 'OPE')
   if ! file (aux1)
      do mensagem with 'Nao foi efetuado nenhuma venda nesta data', mem_tempo
      return
   endif
   select (11)
   use &aux1
   v_mens = 'Relatorio do mes: ' + v_data
else 
   select oper
   v_mens = 'Relatorio do mes corrente'
endif

goto top
do limpa

do imprime with 'Relatorio de Venda de Operadores'
if tk != 13
   return
endif
pg = 0
i = 0
t_qtde1 = 0
t_total1 = 0
t_qtde2 = 0
t_total2 = 0
t_qtde3 = 0
t_total3 = 0
t_qtde4 = 0
t_total4 = 0

set device to printer
do while ! eof ()
   do caber with 'Relatorio de Venda de Operadores', v_mens
   @ prow () + 1, 0 say chr (mem_cond) + '               VALORES DE VENDA                      VALORES CANCELADOS' 
   @ prow () + 1, 1 say 'COD NOME OPER CUP. VALOR VENDA CUP.AC VALOR ACUMUL. CANC VALOR CANC. IT CAN VALOR CAN.AC.' 
   @ prow () + 1, 1 say '=== ========= ==== =========== ====== ============= ==== =========== ====== =============' 
   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set device to screen
         return
      endif

      @ prow () + 1, 1 say codigo + '  ' + nome + ' ' + str (qtde1, 4, 0) + ' ' + str (total1, 11, 2) + ' ' + str (qtde2, 6, 0) + ' ' + str (total2, 13, 2) + ' ' + str (vdqtde1, 4, 0) + ' ' + str (vdtotal1, 11, 2) + ' ' + str (vdqtde2, 6, 0) + ' ' + ;
         str (vdtotal2, 13, 2) 
      t_qtde1 = t_qtde1 + qtde1
      t_total1 = t_total1 + total1
      t_qtde2 = t_qtde2 + qtde2
      t_total2 = t_total2 + total2
      t_qtde3 = t_qtde3 + vdqtde1
      t_total3 = t_total3 + vdtotal1
      t_qtde4 = t_qtde4 + vdqtde2
      t_total4 = t_total4 + vdtotal2
      skip 1
   enddo
enddo
@ prow () + 1, 0 say replicate ('=', 132) 
@ prow () + 1, 14 say str (t_qtde1, 5, 0) + str (t_total1, 12, 2) + str (t_qtde2, 7, 0) + str (t_total2, 14, 2) + str (t_qtde3, 5, 0) + str (t_total3, 12, 2) + str (t_qtde4, 7, 0) + str (t_total4, 14, 2) 
eject
set device to screen
set filter to 
return
procedure g91vdet       
do sinal with 'VENDA', 'DETALHADO'
do limpa
v_grupo = '  '
n_codigo = 0
@ 10, 3 say 'Codigo especifico--->' get n_codigo picture '9999999999999' valid dig_con5(n_codigo) 
@ 12, 3 say 'Grupo especifico---->' get v_grupo picture '99'
read

if lastkey () = 27
   return
endif
v_codigo = substr (strzero (n_codigo, 13, 0), 1, 12)

select movi

do limpa

do imprime with 'Relatorio de Venda Detalhado'
if tk != 13
   return
endif
pg = 0
i = 0
if n_codigo != 0
   v_codigo = substr (strzero (n_codigo, 13, 0), 1, 12)
   set filter to codigo12=v_codigo
endif
goto top
set device to printer
t_venda = 0
t_qtde = 0
t_compra = 0
t_qtde_c = 0
do while ! eof ()
   do caber with 'Relatorio de Venda Detalhado', ' '

   @ prow () + 1, 0 say chr (mem_cond) + ' CODIGO 12    DC COD4 DC DESCRICAO                                ENTRADAS              SAIDAS                SALDO' 
   @ prow () + 1, 1 say 'DATA         NF.No.  SR CLIENTE/FORNECEDOR                       QTDE      VALOR       QTDE      VALOR       QTDE ' 
   @ prow () + 1, 1 say '============ ======= == ======================================== ========= =========== ========= =========== =========' 


   do while prow () <= 55 .and. ! eof ()
      do escprint
      if fim
         set filter to 
         set device to screen
         return
      endif
      v_codigo12 = codigo12
      select prod
      find (v_codigo12)
      if v_grupo != space (2)
         if v_grupo != grupo
            select movi
            skip 1
            loop
         endif
      endif
      v_dig_con1 = dig_con1
      v_codigo4 = codigo4
      v_dig_con2 = dig_con2
      v_descrica = descricao
      v_est_ini = est_ini

      t_venda = 0
      t_qtde = 0
      t_compra = 0
      t_qtde_c = 0

      @ prow () + 1, 1 say v_codigo12 + '  ' + v_dig_con1 + ' ' + v_codigo4 + '  ' + v_dig_con2 + ' ' + v_descrica 
      @ prow () + 1, 110 say str (v_est_ini, 9, 2) 
      select movi
      do while codigo12 = v_codigo12

         if ent_sai = 'S'
            e_qtde = 0
            e_valor = 0
            s_qtde = qtde_t
            s_valor = valor
         else 
            s_qtde = 0
            s_valor = 0
            e_qtde = qtde_t
            e_valor = valor
         endif
         v_est_ini = v_est_ini + e_qtde - s_qtde

         @ prow () + 1, 1 say dtoc (data_n) + '     ' + nota + serie + ' ' + rzso + ' ' + str (e_qtde, 9, 2) + ' ' + str (e_valor, 11, 2) + ' ' + str (s_qtde, 9, 2) + ' ' + str (s_valor, 11, 2) + ' ' + str (v_est_ini, 9, 2) 
         skip 1
         t_venda = t_venda + s_valor
         t_qtde = t_qtde + s_qtde
         t_compra = t_compra + e_valor
         t_qtde_c = t_qtde_c + e_qtde
      enddo
      @ prow () + 1, 56 say 'Totais--> ' + str (t_qtde_c, 9, 2) + ' ' + str (t_compra, 11, 2) + ' ' + str (t_qtde, 9, 2) + ' ' + str (t_venda, 11, 2) + ' ' + str (v_est_ini, 9, 2) 

   enddo
enddo
set filter to 
eject
set device to screen
return






procedure g91fech       
do sinal with 'FECHAMENTO', ' '
do limpa
mesano = space (5)
do aviso with 8, 'SOMENTE DEVERA SER FEITO O FECHAMENTO UMA UNICA VEZ NO MES'
do aviso with 9, 'APOS O FECHAMENTO OS ARQUIVOS DE MOVIMENTO SERA ZERADO'

@ 15, 10 say 'Digite o mes/ano do fechamento:' get mesano picture '99/99'

read
mes = val (substr (mesano, 1, 2))
ano = val (substr (mesano, 4, 2))
if mes > 12 .or. mes < 1
   do mensagem with 'Mes invalido !!!', mem_tempo
   return
endif
if lastkey () = 27
   return
endif
select prod


v_resp = 'N'
do aviso with 24, 'Aguarde.....'

arq1 = dtbco (mes, ano)
arq1 = stuff (arq1, 1, 3, 'PLU')
if ! file (arq1)

   copy to &arq1
   @ 18, 10 say 'Gerando--> ' + arq1 
else 
   do mensagem with 'ARQUIVO COM BANCO DE DADOS MES/ANO JA EXISTE !!!', mem_tempo
   @ 17, 10 say 'Sobrepor o arquivo existente..:' get v_resp picture '@!' valid (v_resp$'SN') 
   read
   if lastkey () = 27
      return
   endif
   if v_resp = 'N'
      return
   endif
   copy to &arq1
   @ 18, 10 say 'Gerando--> ' + arq1 
endif

goto top
do while ! eof ()
   replace est_ini with estoque
   replace venda with 0
   replace qtde with 0
   replace compra with 0
   replace qtde_c with 0
   skip 1
enddo
select movi

arq1 = dtbco (mes, ano)
if ! file (arq1)

   copy to &arq1
   @ 19, 10 say 'Gerando--> ' + arq1 
else 
   do mensagem with 'ARQUIVO COM BANCO DE DADOS MES/ANO JA EXISTE !!!', mem_tempo
   if v_resp = 'N'
      return
   endif
   copy to &arq1
   @ 19, 10 say 'Gerando--> ' + arq1 
endif
zap

select dept

arq1 = dtbco (mes, ano)
arq1 = stuff (arq1, 1, 3, 'DEP')
if ! file (arq1)

   copy to &arq1
   @ 20, 10 say 'Gerando--> ' + arq1 
else 
   do mensagem with 'ARQUIVO COM BANCO DE DADOS MES/ANO JA EXISTE !!!', mem_tempo
   if v_resp = 'N'
      return
   endif
   copy to &arq1
   @ 20, 10 say 'Gerando--> ' + arq1 
endif
replace all total_1 with 0
replace all qtde_1 with 0
replace all total_2 with 0
replace all qtde_2 with 0

select oper

arq1 = dtbco (mes, ano)
arq1 = stuff (arq1, 1, 3, 'OPE')
if ! file (arq1)

   copy to &arq1
   @ 21, 10 say 'Gerando--> ' + arq1 
else 
   do mensagem with 'ARQUIVO COM BANCO DE DADOS MES/ANO JA EXISTE !!!', mem_tempo
   if v_resp = 'N'
      return
   endif
   copy to &arq1
   @ 21, 10 say 'Gerando--> ' + arq1 
endif
replace all total1 with 0
replace all qtde1 with 0
replace all total2 with 0
replace all qtde2 with 0
replace all rftotal1 with 0
replace all rfqtde1 with 0
replace all rftotal2 with 0
replace all rfqtde2 with 0
replace all vdtotal1 with 0
replace all vdqtde1 with 0
replace all vdtotal2 with 0
replace all vdqtde2 with 0

@ 24, 0 say space (80) 

do aviso with 22, 'Digite uma tecla para continuar'
inkey (0)

return
