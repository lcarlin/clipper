restore screen
do sinal with 'EXPORTAR', ' '
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
do aviso with 8, 'Tomar muito cuidado ao executar esta opcao !!'
do aviso with 10, 'Ao executar esta opcao todos os dados de venda dos produtos serao zerados.'
do aviso with 12, 'Se estiver fazendo o controle de estoque, digite <N>'
do aviso with 14, 'e efetue primeiro a opcao <IMPORTAR>, caso ainda nao o tenha feito'
do aviso with 16, 'Certifique-se que as maquinas estao ligadas'
do aviso with 18, 'e com a chave de controle na posicao OFF'
do aviso with 20, 'Caso estiver usando a interface RS-485 verificar se o conversor esta ligado'

do confirme
if confirme != 'S'
   return
endif

do aviso with 22, 'Fazendo a exportacao dos dados, aguarde ...'

select prmq
zap



select prod
set order to 1
set filter to comunica='s' .and.preco_u#0 .and.val(depto_c)#0 .and.val(codigo4)#0
goto top

do while ! eof ()

   v_codigo12 = codigo12
   v_codigo4 = codigo4
   v_desc_maq = desc_maq
   v_preco_u = preco_u
   v_depto_c = depto_c
   select prmq
   append blank 
   replace codigo12 with v_codigo12
   replace codigo4 with v_codigo4
   replace desc_maq with v_desc_maq
   replace preco_u with v_preco_u
   replace depto_c with v_depto_c
   replace flag_1 with '0100'
   replace flag_2 with '00'
   replace venda with 0
   replace qtde with 0
   select prod
   skip 1
enddo
set filter to 
select prmq
copy to g91plu.txt sdf
save screen
clear
if esc_maq = 'S'
   if mem_port = '1'
      ! 'G910 PLU MAQ'
   else 
      ! 'G910 PLU2 MAQ'
   endif
else 
   if mem_port = '1'
      ! 'G910 PLU'
   else 
      ! 'G910 PLU2'
   endif
endif
do aviso with 24, 'Digite uma tecla para continuar'
inkey (0)
restore screen
return
