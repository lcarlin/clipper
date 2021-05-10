**********************************************************************
* Programa : CMENU.PRG                                               *
* Objetivo : Menu de consulta de clientes                            *
* Data : 12.07.92                                                    *
**********************************************************************
MENSA='<Esc> - Retorna ao menu de opcoes'
MOSTRA(MENSA)
OPCAO=1
@ 16,45,20,56 box Q3
do while .t.
   @ 17,46 prompt 'CODIGO'
   @ 18,46 prompt 'NOME'
   @ 19,46 prompt 'GERAL'
   menu to OPCAO
   save screen to TMENU1
   do case
      case OPCAO=1
           do CCODIGO
      case OPCAO=2
           do CNOME
      case OPCAO=3
           do CGERAL     
      case OPCAO=0 .or. OPCAO>3
           exit
   endcase
enddo  
OPCAO=4                     
restore screen from TELACLI
return
