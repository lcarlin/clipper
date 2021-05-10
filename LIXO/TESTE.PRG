announce clipper501
setcolor("w/b+")
* @ 00,00,maxrow(),maxcol() BOX replicate(chr(176),9)
clear
lCont := .f.
aVet1 := {"Voce esta no Programa de Teste de Mouse !!!", ;
        "      Clique em Mim se voce for Macho   !"}
mensagem(aVet1 ,"g+/w","gr+/n")
aTeste :=  {{05,05,"1 - Manuten‡„o de Clientes                 "},;
  {07,05,"2 - Manuten‡„o de Descri‡„o de Servi‡os    "},;
  {09,05,"3 - Cadastro/Impress„o de Notas de Servi‡os"},;
  {11,05,"4 - Reajuste de Pre‡os            "},;
  {13,05,"5 - Relat¢rio de Clientes         "},;
  {15,05,"6 - Agenda de Recebimentos        "},;
  {17,05,"7 - Sair      "} }
DO WHILE .NOT. lCont
*  nTesteOp := botao(aTeste,,"w+/g","gr+/bg")
   lCont := confirma("Deseja Realmente Sair do Programa !!! ")
   mensagem(aVet1,"w+/g","gr+/bg")
ENDDO
sombra(01,02,06,10,1)
inkey(0)
@0,0 CLEAR TO MAXROW(),MAXCOL()
shadow(01,02,06,10)
inkey(0)
setcolor("")
clear
quit
