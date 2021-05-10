parameters sen
! 'SET CLIPPER=F50,R128'
set exclusive on
set fixed on
set date british
set cursor off
set console off
set deleted off
set wrap on

padrao = 'GR+/B,GR+/G'
set color to &padrao
















public emp1, emp2, emp3, codpag, przent
public frame1, frame2, frame3, frame4, limpa, confirme, fim
public pg, ncol, prog, lin, var, tk, ok
public inter, sai, sair, hlp, ia5, id5, i10, i12, i20
public mem_tempo
public mem_plu
public mem_codigo
public mem_etiq, mem_empr, mem_col, mem_cond, mem_norm, mem_exp, mem_fant, mem_senha, mem_port
public e_lin1, e_lin2, e_lin3, e_lin4, e_lin5, padrao
public hlpcmd

public adata, fdata, v_dolar, v_vendor1, v_vendor2, v_vendor3, v_vendor4, v_vendor5

adata = date ()

sair = .f.

store 0 to item, qtde, codigo, valunit, hlp, qtde_ent, num_conh, ipi

ncol = 80








frame1 = chr (218) + chr (196) + chr (191) + chr (179) + chr (217) + chr (196) + chr (192) + chr (179)


frame2 = chr (201) + chr (205) + chr (187) + chr (186) + chr (188) + chr (205) + chr (200) + chr (186)


frame3 = frame1 + chr (176)


frame4 = frame2 + chr (176)

confirme = space (1)

if ! file ('G910.MEM')
   emp1 = 'F.G.L. DA AMAZONIA ELETRONICA IND. E COM. LTDA'
   emp2 = 'FGL DA AM EL IND E COM LTDA'
   emp3 = 'FGL - AM'
else 
   restore from g910 additive
   emp1 = mem_empr
   emp2 = mem_empr
   emp3 = mem_fant
endif

clear
set color to n/w

@ 1, 0 say space (12) + '|' + space (12) + '|' + space (28) + '|' + space (11) + '|' + space (11) 
dd = dtoc (date ())
@ 1, 70 say dd + '  ' 
@ 1, 57 say time () 
do sinal with 'S E N H A', 'ACESSO'

@ 1, 27 say ' ' + emp3 + ' Sist.Serie 900 ' 
set color to &padrao


do aviso with 3, '    ' + emp1 + '    '

@ 2, 0, 4, 79 box frame1
@ 6, 0, 21, 79 box frame2

if ! file ('G910.MEM')
   do g91var with 'S'
endif

do limpa

set color to ('G/B ')
@ 7, 3 say '  °°°°°°°  °°°°°°°  °°°°°°   °°  °°°°°°°       °°°°°°°°  °°°°°°°  °°°°°°°' 
@ 8, 3 say ' ÛÛÛÛÛÛÛ° ÛÛÛÛÛÛÛ  ÛÛÛÛÛÛ°° ÛÛ° ÛÛÛÛÛÛÛ       ÛÛÛÛÛÛÛÛ° ÛÛÛÛÛÛÛ° ÛÛÛÛÛÛÛ°' 
@ 9, 3 say ' ÛÛ°      ÛÛ°      ÛÛ°  ÛÛ° ÛÛ° ÛÛ°           ÛÛ°   ÛÛ° ÛÛ°  ÛÛ° ÛÛ°  ÛÛ°' 
@ 10, 3 say ' ÛÛ°°°°°° ÛÛ°°°°°° ÛÛ°°°ÛÛ  ÛÛ° ÛÛ°°°°°°  °°° ÛÛ°°°°ÛÛ° ÛÛ°  ÛÛ° ÛÛ°  ÛÛ°' 
@ 11, 3 say ' ÛÛÛÛÛÛÛ° ÛÛÛÛÛÛÛ  ÛÛÛÛÛÛ   ÛÛ° ÛÛÛÛÛÛÛ  ÛÛÛ  ÛÛÛÛÛÛÛÛ° ÛÛ°  ÛÛ° ÛÛ°  ÛÛ°' 
@ 12, 3 say '      ÛÛ° ÛÛ°      ÛÛ°ÛÛ°°  ÛÛ° ÛÛ°                 ÛÛ° ÛÛ°  ÛÛ° ÛÛ°  ÛÛ°' 
@ 13, 3 say '  °°°°ÛÛ° ÛÛ°°°°°° ÛÛ° ÛÛ°° ÛÛ° ÛÛ°°°°°°            ÛÛ° ÛÛ°°°ÛÛ° ÛÛ°  ÛÛ°' 
@ 14, 3 say ' ÛÛÛÛÛÛÛ  ÛÛÛÛÛÛÛ  ÛÛ   ÛÛ  ÛÛ  ÛÛÛÛÛÛÛ             ÛÛ  ÛÛÛÛÛÛÛ  ÛÛÛÛÛÛÛ' 

set color to &padrao

@ 16, 6, 19, 73 box frame4
set color to r+/b

do aviso with 17, ' Sistema SERIE-900  - CONTROLE DE PRODUTOS - ' + emp3 + ' '
do aviso with 18, ' Versao 1.03 - Outubro/1996 '

set color to &padrao

set cursor off

do senha with mem_senha
if ok = .f.
   return
endif
set cursor on
@ 24, 0 say space (80) 

do aviso with 24, 'Aguarde indexando Banco de dados.....'


use cadaprod
index on codigo12 to g91prod1
index on codigo4 to g91prod2
index on descricao to g91desc


use g91forn
index on codc to g91cod1

use g91oper
index on codigo to g91cod2

use g91movi
index on codigo12+dtoc(data_n) to g91mov1

use g91dept
index on codigo to g91dept

use g91prod
index on codigo12 to g91prod

use g91grup
index on codgrupo to g91grup

close databases


@ 24, 0 say space (80) 

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







do limpa

set cursor on
adata = date ()
fdata = date ()





do while .t.
   hlpcmd = 1
   do sinal with 'M E N U', 'PRINCIPAL'
   do suja



   select prod
   @ 9, 2, 13, 34 box frame1 + ' '

   @ 10, 10 say 'Arquivo de Produtos' 

   @ 11, 4 say 'Ultima Atualizacao_: ' + dtoc (lupdate ()) 
   @ 12, 4 say 'Numero de Registros:' 
   @ 12, 26 say lastrec () picture '@E 999,999' 

   select clie
   @ 9, 45, 13, 77 box frame1 + ' '

   @ 10, 52 say 'Arquivo de Fornecedores' 

   @ 11, 47 say 'Ultima Atualizacao_: ' + dtoc (lupdate ()) 
   @ 12, 47 say 'Numero de Registros:' 
   @ 12, 69 say lastrec () picture '@E 999,999' 

   @ 16, 45, 20, 77 box frame1 + ' '


   @ 17, 58 say 'Disco' 

   @ 18, 47 say 'Espaco Disponivel' 
   @ 19, 47 say 'em bytes_______:' 
   @ 19, 66 say diskspace () picture '@E 99,999,999' 
   @ 3, 1 say space (78) 
   @ 5, 1 say space (78) 
   mp = 1
   do sinal with 'M E N U', 'PRINCIPAL'
   set message to 5 center
   @ 3, 3 prompt 'CADASTRO' message 'Cadastramento geral'
   @ 3, col () + 4 prompt 'MOVIMENTO' message 'Movimentacao de materiais'
   @ 3, col () + 4 prompt 'EXPORTAR' message 'Enviar dados para a(s) Caixa(s) Registradora(s)'
   @ 3, col () + 4 prompt 'IMPORTAR' message 'Receber dados da(s) Caixa(s) Registradora(s)'
   @ 3, col () + 4 prompt 'RELAT.' message 'Emissao de Relatorios'
   @ 3, col () + 4 prompt 'CONS.' message 'Consulta de produtos'
   @ 3, col () + 4 prompt 'FIM' message 'Fim das Operacoes'
   menu to mp
   @ 24, 0 clear 
   save screen
   do case
      case mp = 1
         do g91cada

      case mp = 2
         do g91movi

      case mp = 3
         do g91expo

      case mp = 4
         do g91impo

      case mp = 5
         do g91rela

      case mp = 6
         do g91cons

      case mp = 7 .or. mp = 0
         do suja
         beep (2)
         set color to w+/rb
         do aviso with 7, ' Atencao !'

         do aviso with 9, ' Nao se esqueca de fazer COPIAS DE SEGURANCA em Disquetes ! '
         @ 11, 6 say 'A cada dia ao fazer o processo de importacao sera criado os seguintes' 
         @ 12, 6 say 'Arquivos: VDDMMMAA.DBF, ODDMMMAA.DBF, DDDMMMAA.DBF                   ' 
         @ 13, 6 say '          DD->DIA       MMM->MES      AA-ANO                         ' 
         @ 14, 6 say 'A cada fechamento do mes sera criado os seguintes arquivos:          ' 
         @ 15, 6 say '          PLUMMMAA.DBF, OPEMMMAA.DBF, DEPMMMAA.DBF                   ' 
         @ 16, 6 say '          MMM->MES      AA-ANO                                       ' 
         @ 18, 6 say 'No uso normal estes arquivos, nao sao utilizados. A menos que queira ' 
         @ 19, 6 say 'relatorios desta data/mes. Portanto podera ser feito um BACKUP destes' 
         @ 20, 6 say 'arquivos e deleta-los do disco rigido, para nao ocupar o espaco do   ' 
         @ 21, 6 say 'disco rigido desnecessariamente.                                     ' 

         set color to &padrao
         do confirme
         if confirme != 'S'
            loop
         endif
         exit
   endcase
enddo
clear
@ 8, 0, 14, 79 box frame4

@ 14, 69 say emp3 

do aviso with 10, ' Fim das Operacoes ! '

do aviso with 12, ' Obrigado ! '
set color to 
close databases
do tempo with 5
clear
set cursor on
return
procedure g91proc       
procedure limpa         
@ 6, 0 clear 
@ 6, 0, 23, 79 box frame2
set color to n/w,w/n
@ 23, 2 say ' F1 - HELP ' 
@ 23, 33 say ' ESC-DESISTIR ' 
@ 23, 69 say emp3 
set color to &padrao
return

procedure confirme      
@ 24, 62 say ' Confirme (S/N) ?' 
tone (1100, 3)
confirme = space (1)
keyboard ''
@ 24, 79 get confirme picture '!' valid (confirme$"SN") 
read
if confirme = 'S'
   @ 24, 62 say '    Confirmado !   ' 
else 
   @ 24, 62 say ' Nao confirmado ! ' 
endif
do tempo with 1
@ 24, 62 clear 
return

procedure sinal         
parameters s1, s2
s1 = space ((12 - len (substr (s1, 1, 12))) / 2) + s1
s1 = s1 + space (12 - len (s1))
s2 = space ((12 - len (substr (s2, 1, 12))) / 2) + s2
s2 = s2 + space (12 - len (s2))
set color to n/w
@ 1, 0 say s1 
@ 1, 13 say s2 

set color to &padrao
return

procedure aviso         
parameters linha, aviso
private vtab
vtab = (80 - len (aviso)) / 2
@ linha, vtab say aviso 
return

procedure g91var        
parameters novo
do limpa
if ! file ('G910.MEM')
   mem_tempo = 0

   mem_cond = 15
   mem_norm = 18
   mem_exp = 14
   mem_etiq = 219
   mem_empr = space (30)
   mem_col = ' '
   mem_fant = space (8)
   mem_port = '1'
else 
   restore from g910 additive
endif
set cursor on
@ 7, 3 say 'Canal de comunicacao/micro.: ' get mem_port valid (mem_port$'12') 
@ 8, 3 say 'Tempo de espera da mensagem: ' get mem_tempo picture '999'


@ 9, 3 say 'Caracter para condensacao..: ' get mem_cond picture '99'
@ 10, 3 say 'Caracter para impr.normal..: ' get mem_norm picture '99'
@ 11, 3 say 'Caract. p/ expansao 1 linha: ' get mem_exp picture '99'
@ 12, 3 say 'Caracter de impressao etiq.: ' get mem_etiq picture '999'
@ 13, 3 say 'Quant. de colunas de etiq..: ' get mem_col picture '9' valid (mem_col$'12') 
@ 14, 3 say 'Nome da sua empresa........: ' get mem_empr picture '@!'
@ 15, 3 say 'Nome abreviado/fantasia....: ' get mem_fant picture '@!'
read
if novo != 'S'
   do aviso with 16, 'Deseja mudar a senha ?'
   hlpcmd = 3
   do confirme
   hlpcmd = 1
   if confirme != 'S'
      save to g910.mem all like mem_*
      return
   endif


   set console off
   vezes = 0
   letra = 0
   ok = .t.
   sn = ' '
   do while vezes != 3
      @ 17, 3 say 'Digite a SENHA ATUAL------->' + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + '<--' 
      passa = ''
      do while letra != 6
         wait to sn
         passa = passa + sn
         @ 17, 31 + letra say '.' 
         letra = letra + 1
      enddo
      if mem_senha = passa
         exit
      endif
      letra = 0
      vezes = vezes + 1
   enddo
   if mem_senha != passa
      do mensagem with 'Desculpe, Usu rio n„o Autorizado, Acesso Negado !', mem_tempo, 1
      set cursor on
      return
   endif
endif
letra = 0
@ 18, 3 say 'Digite a NOVA SENHA ------->' + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + '<--' 
passa = ''
sn = ' '
do while letra != 6
   wait to sn
   passa = passa + sn
   @ 18, 31 + letra say '.' 
   letra = letra + 1
enddo
mem_senha = passa
letra = 0
sn = ' '
@ 19, 3 say 'Confirme SENHA ATUAL------->' + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + '<--' 
passa = ''
do while letra != 6
   wait to sn
   passa = passa + sn
   @ 19, 31 + letra say '.' 
   letra = letra + 1
enddo
if mem_senha != passa
   do mensagem with 'Desculpe, A senha nao bate com a senha digitada !', mem_tempo, 1
   set cursor on
   return
endif

save to g910.mem all like mem_*
return
procedure senha         
parameters senha
set console off
vezes = 0
letra = 0
ok = .t.
sn = ' '
do while vezes != 3
   @ 24, 25 say 'Digite a SENHA -->' + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + chr (219) + '<--' 
   passa = ''
   do while letra != 6
      wait to sn
      passa = passa + sn
      @ 24, 43 + letra say '.' 
      letra = letra + 1
   enddo
   if passa = senha
      exit
   endif
   letra = 0
   vezes = vezes + 1
enddo
if passa != senha
   do mensagem with 'Desculpe, Usu rio n„o Autorizado, Acesso Negado !', mem_tempo, 1
   set cursor on
   ok = .f.
   return
endif






procedure suja          
@ 6, 0 clear 
@ 6, 0, 23, 79 box frame4
set color to n/w,w/n
@ 23, 2 say ' F1 - Help ' 
@ 23, 33 say ' ESC-DESISTIR ' 
@ 23, 69 say emp3 
set color to &padrao
return

procedure g91cons       
do sinal with 'CONSULTA', ' '
@ 5, 1 say space (78) 
select prod
n_codigo12 = 0
n_descrica = space (40)
do while .t.
   select prod
   do limpa
   set cursor on
   @ 7, 3 say 'Codigo do produto...:' get n_codigo12 picture '9999999999999' valid dig_con5(n_codigo12) 
   read
   if lastkey () = 27
      exit
   endif
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
   do while .t.

      v_dig_con1 = dig_con1
      v_codigo4 = codigo4
      v_dig_con2 = dig_con2
      v_desc_maq = desc_maq
      v_descrica = descricao
      v_desc_et1 = desc_et1
      v_desc_et2 = desc_et2
      v_icms = icms
      v_etiqueta = etiqueta
      v_balanca = balanca
      v_comunica = comunica
      v_venda = venda
      v_qtde = qtde
      v_unidade = unidade
      v_est_ini = est_ini
      v_compra = compra
      v_qtde_c = qtde_c
      v_estoque = estoque
      v_est_min = est_min
      v_margem = margem
      v_depto_c = depto_c
      v_custo = custo
      v_preco_u = preco_u
      v_grupo = grupo

      select dept
      find (v_depto_c)
      v_desc_dep = descricao
      v_aliquota = aliquota
      select grup
      find (v_grupo)
      v_nome = nome
      select prod

      read
      if lastkey () = 27
         exit
      endif
      @ 7, 3 say 'Codigo do produto...: ' 
      @ 8, 3 say 'Codigo 4 digitos....: ' 
      @ 8, 40 say 'Descr. na m q.: ' 
      @ 9, 3 say 'Descr. na etiq......: ' 
      @ 9, 40 say 'Linha 2.......: ' 
      @ 10, 3 say 'Com. com micro......: ' 
      @ 10, 40 say 'Etiqueta......: ' 
      @ 10, 60 say 'Balanca.......: ' 
      @ 11, 3 say 'Depto conectado.....:' 
      @ 12, 3 say 'Grupo...............: ' 

      set color to gr+/g

      @ 7, 25 say v_codigo12 + v_dig_con1 
      @ 7, col () + 1 say v_descrica 
      @ 8, 25 say v_codigo4 + '-' + v_dig_con2 
      @ 8, 55 say v_desc_maq 
      @ 9, 25 say v_desc_et1 
      @ 9, 55 say v_desc_et2 
      @ 10, 25 say v_comunica 
      @ 10, 55 say v_etiqueta 
      @ 10, 75 say v_balanca 
      @ 11, 25 say v_depto_c 
      @ 11, col () + 1 say str (v_aliquota, 5, 2) 
      @ 11, col () + 1 say v_desc_dep 
      @ 12, 25 say v_grupo 
      @ 12, col () + 1 say v_nome 

      set color to &padrao

      do aviso with 13, 'Posicao de estoque'

      @ 15, 2 say 'DESCR.' 
      @ 15, 16 say 'INICIAL' 
      @ 15, 31 say 'ENTRADAS' 
      @ 15, 46 say 'SAIDAS' 
      @ 15, 61 say 'FINAL' 

      @ 14, 1, 14, 78 box frame1
      @ 16, 1, 16, 78 box frame1
      @ 15, 15, 22, 15 box frame1
      @ 15, 30, 22, 30 box frame1
      @ 15, 45, 22, 45 box frame1
      @ 15, 60, 22, 60 box frame1

      @ 17, 2 say 'E.MIN.:' 
      @ 18, 2 say 'QTDE..:' 
      @ 19, 2 say 'VALOR.:' 
      @ 20, 2 say 'CUSTO.:' 
      @ 21, 2 say 'MARGEM:' 
      @ 22, 2 say 'VENDA.:' 

      set color to gr+/g

      @ 17, 16 say str (v_est_min, 12, 2) 
      @ 18, 16 say str (v_est_ini, 12, 2) 

      @ 18, 31 say str (v_qtde_c, 12, 2) 
      @ 19, 31 say str (v_compra, 12, 2) 

      @ 18, 46 say str (v_qtde, 12, 2) 
      @ 19, 46 say str (v_venda, 12, 2) 

      @ 18, 61 say str (v_est_ini + v_qtde_c - v_qtde, 12, 2) 
      @ 19, 61 say str (v_venda - v_compra, 12, 2) 
      @ 20, 61 say str (v_custo, 12, 2) 
      @ 21, 61 say str (v_margem, 12, 2) 
      @ 22, 61 say str (v_preco_u, 12, 2) 

      set color to &padrao

      set cursor off
      do aviso with 24, '[PgDn]-Avanca um registro  [PgUp]-Volta um registro  [ESC]-Desiste'
      v_key = inkey (0)
      do case
         case v_key = 27
            exit
         case v_key = 3
            set order to 3
            skip 1
            v_codigo12 = codigo12
            set order to 1
            loop
         case v_key = 18
            set order to 3
            skip -1
            v_codigo12 = codigo12
            set order to 1
            loop


      endcase
      set cursor on
      @ 24, 0 say space (80) 
      if lastkey () = 27
         exit
      endif
   enddo

   do limpa
   do aviso with 15, 'Continua ?'
   do confirme
   if confirme != 'S'
      exit
   endif
   n_codigo12 = 0
   n_descrica = space (40)
enddo
set cursor on
return
function beep           
parameters som
if som = 1
   tone (87, 3, 2)
   tone (40, 7)
elseif som = 2
   tone (261, 7, 2)
   tone (392, 7)
elseif som = 3
   tone (300, 4)
   tone (300, 4)
   tone (300, 4)
   tone (300, 7)
endif
return .t.


procedure tempo         
parameters tempo
private i, tt
tt = 0
for i = 0 to tempo * 50
   tt = tempo + i
next
return

function vdata          
parameters dd
dia = substr (dd, 1, 2)
mes = substr (dd, 4, 2)
return dia = space (2) .and. mes = space (2) .or. dia >= '01' .and. dia <= '31' .and. mes >= '01' .and. mes <= '12'

function acha           
select prod
do aviso with 24, 'Aguarde.....'
set order to 2
goto top
do while ! eof ()
   if val (codigo4) = 0
      skip 1
      loop
   endif
   exit
enddo
if eof ()
   return '0001'
endif
if val (codigo4) > 1
   return '0001'
endif
do while ! eof ()
   v_cod = val (codigo4) + 1
   skip 1
   if v_cod != val (codigo4)
      exit
   endif
enddo
if eof ()
   goto bottom
   v_cod = val (codigo4) + 1
endif
set order to 1
@ 24, 0 say space (80) 
return strzero (v_cod, 4, 0)
function idata          
parameters dd
dia = substr (dd, 1, 2)
mes = substr (dd, 4, 2)
dd = mes + '/' + dia
return dd
function dpc            
parameters dd
private aux
aux = 3 * month (dd) - 2
dc = substr ('JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ', aux, 3) + substr (dtoc (dd), 7, 2)
return dc
function meslab         
parameters dd
if dd > 12
   dd = dd - 12
endif
private aux
aux = 9 * dd - 8
dc = substr ('JANEIRO  FEVEREIROMARCO    ABRIL    MAIO     JUNHO    JULHO    AGOSTO   SETEMBRO OUTUBRO  NOVEMBRO DEZEMBRO ', aux, 9)
return dc
function dtbco          
parameters mes, ano
aux = 3 * mes - 2
dc = substr ('JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ', aux, 3) + str (ano, 2, 0)
aux1 = 'MOVMMMAA.DBF'
aux1 = stuff (aux1, 4, 5, dc)
return aux1
function prbco          
parameters mes, ano
aux = 3 * mes - 2
dc = substr ('JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ', aux, 3) + str (ano, 2, 0)
aux1 = 'PRVMMMAA.DBF'
aux1 = stuff (aux1, 4, 5, dc)
return aux1
function pdbco          
parameters mes, ano
aux = 3 * mes - 2
dc = substr ('JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ', aux, 3) + str (ano, 2, 0)
aux1 = 'PRDMMMAA.DBF'
aux1 = stuff (aux1, 4, 5, dc)
return aux1
function rcbco          
parameters mes, ano
aux = 3 * mes - 2
dc = substr ('JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ', aux, 3) + substr (str (ano, 4, 0), 3, 2)
aux1 = 'RCTMMMAA.DBF'
aux1 = stuff (aux1, 4, 5, dc)
return aux1
function mfunc          
parameters modo, lin, col
ret_val = 0
if modo = 0
   @ 24, 0 say 'Linha:' + str (lin, 3) 
   @ 24, 10 say 'Coluna:' + str (col, 3) 
endif
return ret_val

function databco        
parameters data
aux_data = dtoc (data)
dia = substr (aux_data, 1, 2)
mes = val (substr (aux_data, 4, 2))
ano = substr (aux_data, 7, 2)
aux = 3 * mes - 2
dc = dia + substr ('JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ', aux, 3) + ano
aux1 = 'VDDMMMAA.DBF'
aux1 = stuff (aux1, 2, 7, dc)
return aux1
procedure opcao         
parameters x, y, z, w, vop
z = x + z + 1
w = y + w + 2
rtela = savescreen (x, y, z, w)
@ x, y, z, w box frame1 + ' '
vop = 0
do aviso with 24, 'Escolha sua Opcao, <ESC> Cancela'
vop = achoice (x + 1, y + 1, z - 1, w - 1, op, xop)
@ 24, 0 clear 
restscreen (x, y, z, w, rtela)
return
function dc_ean         
parameters cod
if cod = 0
   return .f.
endif
v_plu = strzero (cod, 13, 0)
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
m = substr (v_plu, 13, 1)
dig_con = 0
dig_con = 10 - mod ((val (b) + val (d) + val (f) + val (h) + val (j) + val (l)) * 3 + val (a) + val (c) + val (e) + val (g) + val (i) + val (k), 10)
if dig_con >= 10
   dig_con = 0
endif
if dig_con != val (m)
   do mensagem with 'Digito de controle do codigo da plu nao bate !!!', mem_tempo
   return .f.
endif
return .t.

procedure mensagem      
parameters mensagem, tempo, som
if pcount () < 3
   som = 2
endif
private vtab
vtab = (80 - len (mensagem)) / 2

@ 24, 0 say space (80) 

beep (som)
@ 24, 0 say space (80) 
@ 24, vtab say mensagem 

do tempo with tempo

@ 24, 0 clear 
return

function dig_con5       
parameters cod
if cod = 0
   return .t.
endif
v_plu = strzero (cod, 13, 0)
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
m = substr (v_plu, 13, 1)
dig_con = 0
dig_con = 10 - mod ((val (b) + val (d) + val (f) + val (h) + val (j) + val (l)) * 3 + val (a) + val (c) + val (e) + val (g) + val (i) + val (k), 10)
if dig_con >= 10
   dig_con = 0
endif
if dig_con = val (m)








   return .t.
else 
   do mensagem with 'Digito de controle do codigo da plu nao bate !!!', mem_tempo
   return .f.
endif


procedure exclui        
@ 24, 62 say '   Exclui (S/N) ?  ' 
tone (1100, 3)
ex = space (1)
@ 24, 79 get ex picture '!' valid (ex$"SN") 
read
if ex = 'S'
   @ 24, 62 say '    Excluido    !    ' 
else 
   @ 24, 62 say '    Mantido    !    ' 
endif
do tempo with 2
@ 24, 62 clear 
return

procedure cabe          
parameters titulo1, titulo2
empresa = alltrim (mem_empr)
sistema = 'S i s t e m a   d e   C o n t r o l e  S e r i e  9 0 0'
titulo1 = substr (titulo1, 1, 66)
titulo2 = substr (titulo2, 1, 66)
emp = space ((66 - len (empresa)) / 2) + empresa
sist = space ((66 - len (sistema)) / 2) + sistema
tit1 = space ((66 - len (titulo1)) / 2) + titulo1
tit2 = space ((66 - len (titulo2)) / 2) + titulo2

pg = pg + 1

set print on
?? chr (mem_norm)
set print off
@ 1, 3 say 'Emissao:' 
@ 1, 11 say date () 
@ 1, 115 say 'Pagina No.:' + str (pg, 3) 

@ 2, 0 say replicate ('=', 132) 

@ 3, 1 say chr (mem_exp) + emp 
@ 4, 1 say chr (mem_exp) + sist 
@ 5, 1 say chr (mem_exp) + tit1 
@ 6, 1 say chr (mem_exp) + tit2 
@ 7, 0 say replicate ('=', 132) 
ncol = 132

return

procedure caber         
parameters titulo1, titulo2
titulo1 = trim (substr (titulo1, 1, 40))
titulo2 = trim (substr (titulo2, 1, 40))
empresa = alltrim (mem_empr)
sistema = 'Sistema  de  Controle Serie 900'
emp = space ((40 - len (empresa)) / 2) + empresa
sist = space ((40 - len (sistema)) / 2) + sistema
tit1 = space ((40 - len (titulo1)) / 2) + titulo1
tit2 = space ((40 - len (titulo2)) / 2) + titulo2
pg = pg + 1
set print on
?? chr (mem_norm)
set print off
@ 1, 1 say 'Emissao:' 
@ 1, 11 say date () 
@ 1, 66 say 'Pagina No.' + str (pg, 3) 
@ 2, 0 say replicate ('=', 80) 
@ 3, 1 say chr (mem_exp) + emp 
@ 4, 1 say chr (mem_exp) + sist 
@ 5, 1 say chr (mem_exp) + tit1 
@ 6, 1 say chr (mem_exp) + tit2 
@ 7, 0 say replicate ('=', 80) 
ncol = 80
return

procedure imprime       
parameters vtit
vtit = trim (vtit)
set console off
do aviso with 9, 'Relatorio do Sistema'
do aviso with 11, vtit
do aviso with 13, 'Ajuste a Impressora e Tecle <Enter> quando PRONTO ou <Esc> para CANCELAR !'
do while .t.
   tk = inkey (0)
   if tk != 13
      do mensagem with 'Impressao Cancelada !', mem_tempo
      return
   endif
   if ! isprinter ()

      do mensagem with 'A Impressora Nao Esta Ativa, Verifique por favor !', mem_tempo, 1
      loop
   endif
   exit
enddo
@ 13, 1 say space (78) 

@ 13, 35 say 'Aguarde ...' 

do aviso with 16, 'Tecle <ESC> durante a impressao caso queira interrompe-la'
pg = 0

return

procedure escprint      
private esc
fim = .f.
esc = 1
do while esc != 0 .and. esc != 27
   esc = inkey ()
enddo
if esc = 27
   beep (2)
   set device to screen
   do aviso with 24, 'Deseja Interromper a Impressao ? '

   do confirme

   @ 24, 0 clear 
   set device to printer
   if confirme = 'N'

      return
   endif
   fim = .t.

   set print on
   ?? chr (mem_norm)
   set print off


   @ prow () + 2, 0 say replicate ('-', ncol) 
   if ncol >= 132
      @ prow () + 2, 25 say chr (mem_exp) + '* * * IMPRESSA' + chr (8) + '~' + 'O INTERROMPIDA * * *' 
   else 
      @ prow () + 2, 4 say chr (mem_exp) + '* * * IMPRESSA' + chr (8) + '~' + 'O INTERROMPIDA * * *' 
   endif
   @ prow () + 2, 0 say replicate ('-', ncol) 
   eject
   @ prow (), pcol () say chr (27) + '@' 

   set device to screen
   do mensagem with 'Impressao Interrompida !', mem_tempo

   return
endif
return

procedure escpro        
private tecla
tecla = 1
inter = .f.
tecla = lastkey ()
if tecla = 27
   inter = .t.
endif
procedure criabco       
parameters nome
create temp_arq
use temp_arq
append blank 
replace field_name with 'CODIGO12'
replace field_type with 'c'
replace field_len with 12
replace field_dec with 0
append blank 
replace field_name with 'DUMMY1'
replace field_type with 'c'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'CODIGO4'
replace field_type with 'C'
replace field_len with 4
replace field_dec with 0

append blank 
replace field_name with 'DUMMY2'
replace field_type with 'c'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DESC_MAQ'
replace field_type with 'c'
replace field_len with 18
replace field_dec with 0

append blank 
replace field_name with 'DUMMY3'
replace field_type with 'c'
replace field_len with 1
replace field_dec with 0

append blank 
replace field_name with 'PRECO_U'
replace field_type with 'N'
replace field_len with 9
replace field_dec with 2

append blank 
replace field_name with 'DUMMY4'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DEPTO_C'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY5'
replace field_type with 'C'
replace field_len with 1
replace field_dec with 0

append blank 
replace field_name with 'FLAG_1'
replace field_type with 'C'
replace field_len with 4
replace field_dec with 0

append blank 
replace field_name with 'DUMMY6'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'FLAG_2'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY7'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'VENDA'
replace field_type with 'N'
replace field_len with 11
replace field_dec with 2

append blank 
replace field_name with 'DUMMY8'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'QTDE'
replace field_type with 'N'
replace field_len with 7
replace field_dec with 2

append blank 
replace field_name with 'DUMMY9'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

create &nome from temp_arq
close
erase ('TEMP_ARQ.DBF')

return

procedure criabco1      
parameters nome
create temp_arq
use temp_arq
append blank 
replace field_name with 'CODIGO'
replace field_type with 'c'
replace field_len with 2
replace field_dec with 0
append blank 
replace field_name with 'DUMMY1'
replace field_type with 'c'
replace field_len with 1
replace field_dec with 0

append blank 
replace field_name with 'DESCRICAO'
replace field_type with 'C'
replace field_len with 18
replace field_dec with 0

append blank 
replace field_name with 'DUMMY2'
replace field_type with 'c'
replace field_len with 1
replace field_dec with 0

append blank 
replace field_name with 'PRECO_PRE'
replace field_type with 'N'
replace field_len with 9
replace field_dec with 2

append blank 
replace field_name with 'DUMMY3'
replace field_type with 'c'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'HALO'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY4'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'FLAG_1'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY5'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'FLAG_2'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY6'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'FLAG_3'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY7'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'TOTAL_1'
replace field_type with 'N'
replace field_len with 11
replace field_dec with 2

append blank 
replace field_name with 'DUMMY8'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'QTDE_1'
replace field_type with 'N'
replace field_len with 7
replace field_dec with 2

append blank 
replace field_name with 'DUMMY9'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'TOTAL_2'
replace field_type with 'N'
replace field_len with 13
replace field_dec with 2

append blank 
replace field_name with 'DUMMY10'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'QTDE_2'
replace field_type with 'N'
replace field_len with 7
replace field_dec with 2

append blank 
replace field_name with 'DUMMY11'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

create &nome from temp_arq
close
erase ('TEMP_ARQ.DBF')

return

procedure criabco2      
parameters nome
create temp_arq
use temp_arq
append blank 
replace field_name with 'CODIGO'
replace field_type with 'c'
replace field_len with 2
replace field_dec with 0
append blank 
replace field_name with 'DUMMY1'
replace field_type with 'c'
replace field_len with 1
replace field_dec with 0

append blank 
replace field_name with 'NOME'
replace field_type with 'C'
replace field_len with 9
replace field_dec with 0

append blank 
replace field_name with 'DUMMY2'
replace field_type with 'c'
replace field_len with 1
replace field_dec with 0

append blank 
replace field_name with 'FLAG1'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY3'
replace field_type with 'c'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'FLAG2'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY4'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'FLAG3'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'DUMMY5'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'TOTAL1'
replace field_type with 'N'
replace field_len with 11
replace field_dec with 2

append blank 
replace field_name with 'DUMMY6'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'QTDE1'
replace field_type with 'N'
replace field_len with 4
replace field_dec with 0

append blank 
replace field_name with 'DUMMY7'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'TOTAL2'
replace field_type with 'N'
replace field_len with 13
replace field_dec with 2

append blank 
replace field_name with 'DUMMY8'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'QTDE2'
replace field_type with 'N'
replace field_len with 6
replace field_dec with 0

append blank 
replace field_name with 'DUMMY9'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'RFTOTAL1'
replace field_type with 'N'
replace field_len with 11
replace field_dec with 2

append blank 
replace field_name with 'DUMMY10'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'RFQTDE1'
replace field_type with 'N'
replace field_len with 4
replace field_dec with 0

append blank 
replace field_name with 'DUMMY11'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'RFTOTAL2'
replace field_type with 'N'
replace field_len with 13
replace field_dec with 2

append blank 
replace field_name with 'DUMMY12'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'RFQTDE2'
replace field_type with 'N'
replace field_len with 6
replace field_dec with 0

append blank 
replace field_name with 'DUMMY13'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'VDTOTAL1'
replace field_type with 'N'
replace field_len with 11
replace field_dec with 2

append blank 
replace field_name with 'DUMMY14'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'VDQTDE1'
replace field_type with 'N'
replace field_len with 4
replace field_dec with 0

append blank 
replace field_name with 'DUMMY15'
replace field_type with 'C'
replace field_len with 3
replace field_dec with 0

append blank 
replace field_name with 'VDTOTAL2'
replace field_type with 'N'
replace field_len with 13
replace field_dec with 2

append blank 
replace field_name with 'DUMMY16'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

append blank 
replace field_name with 'VDQTDE2'
replace field_type with 'N'
replace field_len with 6
replace field_dec with 0

append blank 
replace field_name with 'DUMMY17'
replace field_type with 'C'
replace field_len with 2
replace field_dec with 0

create &nome from temp_arq
close
erase ('TEMP_ARQ.DBF')

return




