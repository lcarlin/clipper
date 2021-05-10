/*
BOP CFCONS.PRG
AUTOR : LUIZ ANTONIO C.
DATA  : 24-01-96
FUNCAO : CONSULTA E MARCACAO DE REGISTROS
LINGUAGEM : CLIPPER 5.2
SISTEMA : CONTROLE DE ELEITORES
*/
#include "inkey.ch"

public avet_camp, aVet_masc
avet_camp:= {"MARCADO","TITULO","NOME","SECAO","FILIACAO","PARTIDO","INSCRICAO","ENDERECO",;
             "BAIRRO","CIDADE","UF","CEP"}


avet_masc:= {"!","@!","@!","@!","99/99/99","@!","@!","@!","@!","@!","@!","@!"}
avet_cab := {"Sel.","N§ Titulo","Filiado","Se‡„o","Data Filia‡„o","N§ Inscri‡„o",;
             "Partido","Endere‡o","Bairro","Cidade","U.F.","C.E.P"}
use CFBFILIA index CFIFILI2

@ 22,04 SAY "<F2> - Marca/Desmarca; <F3> - Anula a Sele‡„o; <F4> - Visualiza Registro"
dbedit(4, 4, 21, 76, avet_camp, "CONSULTA", avet_masc, avet_cab, ;
     "Ä", "³")
close databases
select 1
close format
release all
 return

* EOF
