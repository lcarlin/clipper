/* 
BOP CEAPMV.PRG
PROGRAMA CEAPMV.PRG
DATA    16/06/95
AUTOR   LUIZ ANTONIO CARLIN
FUNCAO  EXCLUIR REGISTROS DO MES ANTERIOR
SISTEMA CONTROLE DE ESTOQUE
LINGUAGEM CLIPPER 5.01
*/
IF .not. CONFIRMA("Todos os relatorios referenetes as movimenta‡™es j  foram impressos ?")
   MENSAGEM("Imprima todos os relat¢rios e repita esta opera‡„o")
   RETURN
ENDIF
IF CONFIRMA ("Deseja REALMENTE realizar esta opera‡„o ?")
   SOMBRA(11,30,13,43)
   @ 12,31 SAY "Aguarde !!!" COLOR "r*/n"
   USE cebmest INDEX ceimest
   ZAP
   REINDEX
ENDIF
CLOSE ALL
RETURN

* eop ceapmv