/*
bop calanca.prg

Programa   calanca.prg
Autor      Luiz Antonio Carlin
data       07/07/95
funcao     Registro de lancamento diarios
Sistema    Controle de acougues
Linguagem  Clipper 5.01

*/
aOpcoes_c := Array(3,3)
aOpcoes_c := {{14,25,"Debito"},{14,33,"Credito"},{14,42,"Cancelar"}}

SOMBRA(07,07,16,66)
@ 07,25 SAY "Lan‡amento Diarios Do Caixa"
@ 08,08 say "Lan‡amento....:"
@ 10,08 say "Valor.........:"
@ 12,08 say "Data..........:"
@ 14,08 say "Tipo..........:"
n:=botao(aOpcoes_c,.F.)

USE cablanca
CONF := .T.
SAVE SCREEN TO sTela1
corcli := setcolor()
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   SETCOLOR(corcli)
   cDesc  := space(40)
   nValor := 0
   nTipo  := 0
   cTipo  := " "
   @ 08,24 GET cDesc  PICT "@!" VALID(cDesc<>" ")
   @ 10,24 GET nValor PICT "999,999.99" VALID(nValor<>0)
   read
   IF lastkey()=27
      EXIT
   ENDIF
   @ 12,24 GET DATA_SIS
   CLEAR GETS
   centra(24,"<ENTER> - Seleciona; <F1> - Help; <ESC> - Sair","gr+/bg")
   nTipo := botao(aOpcoes_c)
   IF nTipo = 3 .OR. nTipo = 0
      LOOP
   ENDIF
   cTipo := if(nTipo=1,"D","C")
   IF confirma ("Os Dados referentes ao lancamento estao corretos?")
      APPEND BLANK
      REPLACE Descricao WITH cDesc
      REPLACE Valor     WITH nValor
      REPLACE Tipo      WITH cTipo
      Replace Data      WITH DATA_SIS
   ENDIF
   CONF := confirma("Deseja Continuar no Caixa ?")
ENDDO
CLOSE ALL
RELEASE ALL
RETURN

* Eop calanca.prg