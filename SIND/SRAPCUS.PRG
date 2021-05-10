#include "common.ch"
#include "inkey.ch"

********************************

   if ;
         (!confirma("Todos os relatorios referenetes aos custos j  foram impressos ?"))
      mensagem("Imprima todos os relat¢rios e repita esta opera‡„o")
   else
      if (confirma("Deseja REALMENTE Apagar os custos do mes?"))
         sombra(11, 30, 13, 43)
         @ 12, 31 say "Aguarde !!!" color "r*/n"
         use SRBCUS index SRICUS
         DELETE ALL FOR DATA=(DATA_SIS-105)
         zap
         reindex
      endif
      close databases
      select 1
      close format
      return
   endif

* EOF
