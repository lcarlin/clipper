/*
BOP CEMTfor.PRG

PROGRAMA : CEMTfor.PRG
DATA     : 08/06/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : MANUTENCAO DE fornecedores
SISTEMA  : CONTROLE DE ESTOQUE
LINGUAGEM: CLIPPER 5.01
*/

LOCAL CONF := .T.

USE CEBFOR INDEX CEIFOR, CEIFOR2

SOMBRA(07,07,19,66)
@ 07,24 SAY "Manuten‡„o de Fornecedor"
@ 08,08 say "Codigo........:"
@ 09,08 say "Nome..........:"
@ 10,08 say "Empresa.......:"
@ 11,08 say "R.G...........:"
@ 12,08 say "C.P.F.........:"
@ 13,08 say "Insc. Estadual:"
@ 14,08 say "Endere‡o......:"
@ 15,08 say "Cidade........:"
@ 16,08 say "Estado........:"
@ 17,08 say "C.E.P.........:"
@ 18,08 say "Tel. Fax......:"
SAVE SCREEN TO sTela1
corcli := setcolor()
mOpcao := array(3,3)
mOpcao := {{12,20,"Alterar"},{12,29,"Excluir"},{12,38,"Voltar"}}
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   setcolor(corcli)
   cCod   := space(6)
   lInclui := .f.
   ALTER   := 0
   @ 08,24 GET cCod PICT "@!"
   READ
   IF empty(cCod) .and. lastkey()=13
      SET ORDER TO 2
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cCod = Codigo
      @ 8,24 GET cCod PICT "@!"
      CLEAR GETS
   ELSEIF empty(cCod) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   SET ORDER TO 1
   SEEK cCod
   IF .NOT. FOUND()
      lInclui := confirma("Codigo nao cadastrado! Deseja Cadastrar ?")
      cNome  := space(40)
      cEmpre := space(30)
      cRg    := space(20)
      cCpf   := space(20)
      cInce  := space(20)
      cEnde  := space(40)
      cCid   := space(30)
      cEst   := space(2)
      cCep   := space(9)
      cTel   := space(15)
      mItem  := Space(10)
   ELSE
      cNome  := Nome
      cCod   := COdigo
      cEmpre := Empresa
      cRg    := Rg
      cCpf   := Cpf
      cInce  := Insc
      cEnde  := Endereco
      cCid   := Cidade
      cEst   := Estado
      cCep   := Cep
      cTel   := Telefone
      mItem  := Item
      @ 09,24 SAY cNome  PICT "@!"
      @ 10,24 SAY cEmpre PICT "@!"
      @ 11,24 SAY cRG    PICT "@!"
      @ 12,24 SAY cCpf   PICT "@!"
      @ 13,24 SAY cInce  PICT "@!"
      @ 14,24 SAY cEnde  PICT "@!"
      @ 15,24 SAY cCid   PICT "@!"
      @ 16,24 SAY cEst   PICT "@!"
      @ 17,24 SAY cCep   PICT "@!"
      @ 18,24 SAY cTel   PICT "@!"
      inkey(5)
      SAVE SCREEN TO sTela_ant
      set color to gr+/b
      sombra(10,18,14,46)
      @ 11,20  SAY "Codigo Existente:" Color "R/n"
      setcolor(corcli)
      alter:=botao(mOpcao)
      RESTORE SCREEN FROM sTela_ant
      IF ALTER = 2
         IF confirma("Deseja REALMENTE Excluir o Registro ?")
	    DELE
	 ENDIF
      ENDIF
   ENDIF
   IF ALTER = 1 .OR. lInclui
      @ 09,24 GET cNome  PICT "@!"
      @ 10,24 GET cEmpre PICT "@!"
      @ 11,24 GET cRG    PICT "@!"
      @ 12,24 GET cCpf   PICT "@!"
      @ 13,24 GET cInce  PICT "@!"
      @ 14,24 GET cEnde  PICT "@!"
      @ 15,24 GET cCid   PICT "@!" 
      @ 16,24 GET cEst   PICT "@!" valid (estados(cEst))
      @ 17,24 GET cCep   PICT "@!"
      @ 18,24 GET cTel   PICT "@!"
      READ
      IF confirma("Deseja Descrever os ITENS Fornecidos ?")
         mItem  := obser(.t.,mItem)
      ENDIF
      IF confirma("Os Dados Estao Corretos")
         IF Linclui
            dbappend()
         ENDIF
         REPLACE Codigo   WITH cCod
    	 REPLACE Nome     WITH cNome
         REPLACE Empresa  WITH cEmpre
	 REPLACE Rg       WITH cRg
	 REPLACE Cpf      WITH cCpf
	 REPLACE Insc     WITH cInce
	 REPLACE Endereco WITH cEnde
	 REPLACE Cidade   WITH cCid
	 REPLACE Estado   WITH cEst
	 REPLACE Cep      WITH cCep
	 REPLACE Telefone WITH ctel
	 REPLACE Item     WITH mItem
      ELSE
         LOOP
      ENDIF
   ENDIF
   CONF=confirma("Deseja Continuar na Manutencao de Fornecedores?")
ENDDO
RELEASE ALL
CLOSE ALL
RETURN

* eop cemtcli.prg