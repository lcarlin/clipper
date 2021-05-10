USE CNBSERV INDEX CNISER2
aServico := {}
DO WHILE .NOT. eof()
   aadd(aServico,CodServ+" - "+Descricao+Unidade+str(valor_uni,11,2))
   SKIP
ENDDO
CLOSE ALL
