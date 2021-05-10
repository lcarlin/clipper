
******************************************************
*                                                    *
* PROGRAMA: RCLIENTES.PRG                            *
* FINALIDADE: LISTAGEM DE CLIENTES SISTEMA LOCADORA  *
* AUTOR: CLAUDIO/LUCIANA/VANESSA                     *
* DATA: 17/06/92                                     *
*                                                    *
******************************************************

set date brit
save screen to TELALI
@ 07,02 clear to 19,78
select 2
go top
@ 08,21 say 'L I S T A G E M   DE   C L I E N T E S'
@ 15,23 say 'VERIFIQUE SE A IMPRESSORA ESTA ATIVA'
CONFIRMA()
if lastkey() = 27
   restore screen from TELALI
   return
endif   
if MCONF = 'N'
   do finaliza
else
   @ 19,23 say ' A G U A R D E   I M P R E S S A O '
   set device to print   
   PAG = 0
   do while .NOT. eof()
      CABECALHO()
      @ 08,22 say 'R E L A C A O   D E   C L I E N T E S' 
      @ prow()+3,02     say chr(15)+' '
      @ prow(),pcol()+1 say 'CODIGO  NOME                            ENDERECO'
      @ prow(),pcol()+1 say '                       BAIRRO           TELEFONE'
      @ prow(),pcol()+1 say ' CIDADE           UF  CEP'+chr(18)  
      LINHA=0
      @ prow()+1,1 say " "
      do while .NOT. eof() .AND. LINHA <=50
         LINHA = LINHA + 1
         @ prow()+1,02     say chr(15)+' '
         @ prow(),pcol()+1 say CODCLI
         @ prow(),pcol()+3 say NOMECLI
         @ prow(),pcol()+2 say ENDERECO
         @ prow(),pcol()+2 say BAIRRO
         @ prow(),pcol()+2 say TELEF
         @ prow(),pcol()+3 say CIDADE
         @ prow(),pcol()+2 say ESTADO
         @ prow(),pcol()+2 say CEP
         @ prow(),pcol()+1 say ' '+chr(18) 
         skip
      enddo
   eject
   enddo
endif
do FINALIZA
