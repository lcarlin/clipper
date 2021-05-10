restore screen
do sinal with 'IMPORTAR', ' '
do limpa
esc_maq = ' '
@ 7, 5 say 'Deseja comunicar com maquinas especificas:' get esc_maq picture '@!' valid (esc_maq$'SN') 
read
if lastkey () = 27
   return
endif
if esc_maq = 'S'
   if ! file ('MAQ.CFG')
      num_maq = 'S'
   else 
      num_maq = ' '
      @ 8, 5 say 'Deseja alterar o numero das m quinas.....:' get num_maq picture '@!' valid (num_maq$'SN') 
      read
      if lastkey () = 27
         return
      endif
      do limpa
   endif
   if num_maq = 'S'
      private mach [32], num [32]
      for i = 1 to 32
         mach [i] = space (2)
      next
      for i = 1 to 32
         @ 10, 5 say 'Numero das m quinas para a comunicacao...:' get mach [i] picture '99'
         read
         if lastkey () = 27 .or. mach [i] = space (2)
            exit
         endif
         if i > 25
            f = i - 25
            g = 1
         else 
            f = i
            g = 0
         endif
         @ 12 + g, 3 * f say mach [i] 
      next
      for i = 1 to 32
         if mach [i] = space (2)
            num [i] = space (2)
         else 
            num [i] = strzero (val (mach [i]), 2, 0)
         endif
      next
      select (10)
      use g91maq

      replace maq1 with num [1], maq2 with num [2], maq3 with num [3], maq4 with num [4], maq5 with num [5], maq6 with num [6], maq7 with num [7], maq8 with num [8], maq9 with num [9], maq10 with num [10]
      replace maq11 with num [11], maq12 with num [12], maq13 with num [13], maq14 with num [14], maq15 with num [15], maq16 with num [16], maq17 with num [17], maq18 with num [18], maq19 with num [19], maq20 with num [20]
      replace maq21 with num [21], maq22 with num [22], maq23 with num [23], maq24 with num [24], maq25 with num [25], maq26 with num [26], maq27 with num [27], maq28 with num [28], maq29 with num [29], maq30 with num [30]
      replace maq31 with num [31], maq32 with num [32]
      copy to maq.cfg sdf
      do limpa
   endif
else 
   do limpa
endif

select (11)

do aviso with 8, 'Certifique-se que as maquinas estao ligadas'
do aviso with 10, 'e com a chave de controle na posicao OFF'

v_date = date ()
@ 14, 14 say 'Entre com a data a que se refere a venda:' get v_date
read
if lastkey () = 27
   return
endif
do confirme
if confirme != 'S'
   return
endif

save screen
clear
if esc_maq = 'S'
   if mem_port = '1'
      ! 'G910 RPLU MAQ'
   else 
      ! 'G910 RPLU2 MAQ'
   endif
else 
   if mem_port = '1'
      ! 'G910 RPLU'
   else 
      ! 'G910 RPLU2'
   endif
endif
do aviso with 24, 'Digite uma tecla para continuar'
inkey (0)
restore screen

aux1 = databco (v_date)
if ! file (aux1)
   do aviso with 24, 'Criando banco de dados de pedido'
   do criabco with aux1
   @ 24, 0 clear 
endif
use &aux1
zap

append from g91rplu.txt sdf

do aviso with 16, 'Atualizar o banco de dados com os valores de venda ?'

hlpcmd = 2
do confirme
hlpcmd = 1
if confirme != 'S'
   return
endif

select (11)
goto top
do while ! eof ()
   v_codigo12 = codigo12
   v_codigo4 = codigo4
   v_desc_maq = desc_maq
   v_preco_u = preco_u
   v_depto_c = depto_c
   v_venda = venda
   v_qtde = qtde
   select prod
   find (v_codigo12)
   if ! found ()
      do mensagem with 'Codigo nao esta cadastrado ou foi apagado!!', mem_tempo
      select (11)
      skip 1
      loop
   endif
   replace estoque with estoque - v_qtde
   replace venda with venda + v_venda
   v_bal = balanca
   if balanca = 'S' .and. v_preco_u != 0
      replace qtde with qtde + v_venda / v_preco_u
   else 
      replace qtde with qtde + v_qtde
   endif
   commit
   select movi
   append blank 
   replace codigo12 with v_codigo12
   replace codigo4 with v_codigo4
   replace movim with 'M'
   replace data with v_date
   replace data_n with v_date

   if v_bal = 'S' .and. v_preco_u != 0
      replace qtde_t with v_venda / v_preco_u
   else 
      replace qtde_t with v_qtde
   endif

   replace valor with v_venda
   replace ent_sai with 'S'
   replace rzso with 'CLIENTE FINAL'

   select (11)
   skip 1

enddo
select (11)
close
aux1 = databco (v_date)
aux1 = stuff (aux1, 1, 1, 'D')
if ! file (aux1)
   do aviso with 24, 'Criando banco de dados de Departamento'
   do criabco1 with aux1
   @ 24, 0 clear 
endif
use &aux1
zap

append from g91rdept.txt sdf
goto top
do while ! eof ()
   v_codigo = codigo
   v_total_1 = total_1
   v_qtde_1 = qtde_1
   v_total_2 = total_2
   v_qtde_2 = qtde_2
   select dept
   find (v_codigo)
   if ! found ()
      do mensagem with 'Codigo nao esta cadastrado ou foi apagado!!', mem_tempo
      select (11)
      skip 1
      loop
   endif
   replace total_1 with total_1 + v_total_1
   replace qtde_1 with qtde_1 + v_qtde_1
   replace total_2 with total_2 + v_total_2
   replace qtde_2 with qtde_2 + v_qtde_2
   commit

   select (11)
   skip 1

enddo
select (11)
close
aux1 = databco (v_date)
aux1 = stuff (aux1, 1, 1, 'O')
if ! file (aux1)
   do aviso with 24, 'Criando banco de dados de Departamento'
   do criabco2 with aux1
   @ 24, 0 clear 
endif
use &aux1
zap

append from g91roper.txt sdf

goto top
do while ! eof ()
   v_codigo = codigo
   v_total1 = total1
   v_qtde1 = qtde1
   v_total2 = total2
   v_qtde2 = qtde2
   v_rftotal1 = rftotal1
   v_rfqtde1 = rfqtde1
   v_rftotal2 = rftotal2
   v_rfqtde2 = rfqtde2
   v_vdtotal1 = vdtotal1
   v_vdqtde1 = vdqtde1
   v_vdtotal2 = vdtotal2
   v_vdqtde2 = vdqtde2
   select oper
   find (v_codigo)
   if ! found ()
      do mensagem with 'Codigo nao esta cadastrado ou foi apagado!!', mem_tempo
      select (11)
      skip 1
      loop
   endif
   replace total1 with total1 + v_total1
   replace qtde1 with qtde1 + v_qtde1
   replace total2 with total2 + v_total2
   replace qtde2 with qtde2 + v_qtde2
   replace rftotal1 with rftotal1 + v_rftotal1
   replace rfqtde1 with rfqtde1 + v_rfqtde1
   replace rftotal2 with rftotal2 + v_rftotal2
   replace rfqtde2 with rfqtde2 + v_rfqtde2
   replace vdtotal1 with vdtotal1 + v_vdtotal1
   replace vdqtde1 with vdqtde1 + v_vdqtde1
   replace vdtotal2 with vdtotal2 + v_vdtotal2
   replace vdqtde2 with vdqtde2 + v_vdqtde2
   commit

   select (11)
   skip 1

enddo

return
