/* 
   BOP MSGCLASS.CH
   HEADER DA CLASSE DE MENSAGEM
   MS 137
*/
#include "PSCLASS.CH"

* ATRIBUTIOS DA CLASSE

#translate .<obj>:stack   =>  <obj>\[1]
#translate .<obj>:color   =>  <obj>\[2]
#translate .<obj>:block   =>  <obj>\[3]
#translate .<obj>:nRow    =>  <obj>\[4]
#translate .<obj>:nCol    =>  <obj>\[5]

* definicao dos metodos

#translate .<obj>:msgdisplay(<exp>) => msgdisplay(@<obj>,<exp>)
#translate .<obj>:msgclear()        => msgclear(@<obj>)
#translate .<obj>:msgrecall()       => msgrecall(@<obj>)
