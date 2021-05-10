******************************************************
*                                                    *
* PROGRAMA: PROG2.PRG                                *
* FINALIDADE: MENU PRINCIPAL - SISTEMA LOCADORA      *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 22/04/92                                     *
*                                                    *
******************************************************
clear
@ 12,30 say 'A G U A R D E  ! ! !'
set procedure to PROCED
set delimiter on
set delimiter to '[]'
public EXTENSO,MCONF,MCON,MMES,PAG,SAI,Q1,Q2,Q3,Q4,Q5
do QUADRO

select 1
use FILMES
index on CODFIL to INDFIL
index on NOMEFIL to INDNOMEF
set index to INDFIL,INDNOMEF
select 2
use CLIENTES
index on CODCLI to INDCLI
index on NOMECLI to INDNOME
set index to INDCLI,INDNOME
select 3
use MOVIM_A
index on NOMEF to IND_A
select 4
use MOVIM_B
index on NOMEF to IND_B

if day(date()) = 1
   do COPIA
endif
clear
@ 01,01 to 03,79
set color to I
@ 02,02 say space(26)
@ 02,28 say 'LOCADORA MIL FILMES LTDA'
@ 02,52 say space(27)
set color to
@ 05,01,22,79 box Q2
@ 07,27 say 'M E N U   P R I N C I P A L' 
MENSA = '<Esc> - Finaliza'
MOSTRA(MENSA)
OPCAO=1
@ 09,28,19,50 box Q3
do while .t.
   @ 10,29 prompt 'CADASTRO DE CLIENTES'
   @ 12,29 prompt 'CADASTRO DE FILMES'
   @ 14,29 prompt 'EMPRESTIMOS'
   @ 16,29 prompt 'DEVOLUCAO'
   @ 18,29 prompt 'RELATORIOS DO SISTEMA'
   menu to OPCAO
   save screen to TELAMENU
   do case
      case OPCAO=1 
           do CLIENTES
      case OPCAO=2 
           do FILMES
      case OPCAO=3
           do EMPRES
      case OPCAO=4
           do DEVOL
      case OPCAO=5
           do RELATORIOS
      case OPCAO=0 .or. OPCAO>5
         exit
   endcase         
enddo
clear
@ 01,01 say '*** Fim de execucao - Sistema Locadora'
@ 02,01 say ' '
close all
return
    