**********************************************************************
* Programa : CLIENTES.PRG                                            *
* Objetivo : Menu do cadastro de clientes                            *
* Data : 12.07.92                                                    *
**********************************************************************
sele 2
@ 06,02 clear to 21,78
@ 07,21 say 'C A D A S T R O   D E   C L I E N T E S'
MENSA = '<Esc> - Retorna ao menu principal'
MOSTRA(MENSA)
OPCAO=1
@ 10,29 to 18,51
do while .t.
   @ 11,30 prompt 'INCLUSAO DE CLIENTES'
   @ 13,30 prompt 'ALTERACAO DE CLIENTES'
   @ 15,30 prompt 'EXCLUSAO DE CLIENTES'
   @ 17,30 prompt 'CONSULTA DE CLIENTES'
   menu to OPCAO
   save screen to TELACLI 
   do case
      case OPCAO=1 
           do INCCLI
      case OPCAO=2
           do ALTCLI 
      case OPCAO=3
           do EXCCLI
      case OPCAO=4
           do CMENU
      case OPCAO=0 .or. OPCAO>4
           exit
      endcase         
enddo
restore screen from TELAMENU
OPCAO=1
return
