#include "common.ch"
#include "inkey.ch"

********************************
PARAMETERS nArq
IF nArq = 1
   cMensagem := " as Movimenta‡oes "
   cCamp     := "DATA_NEG"
   USE CEBMEST INDEX CEIMEST
ELSE
   cMensagem := " aos Custos "
   cCamp     := "DATA"
   USE CEBCUS INDEX CEICUS
ENDIF
   if ;
         (!confirma("Todos os relatorios referentes &cMensagem impressos ?"))
      mensagem("Imprima todos os relat¢rios e repita esta opera‡„o")
   else
      if (confirma("Deseja REALMENTE realizar esta opera‡„o ?"))
         sombra(11, 30, 13, 43)
         @ 12, 31 say "Aguarde !!!" color "r*/n"
         DELETE FOR if(nArq=1,DATA_NEG,DATA) <= (DATA_SIS-105)
         COMMIT
      endif

   endif
   close databases
   select 1
   close format
   return

* EOF
