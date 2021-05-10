/*
BOP CEMTCLI.PRG

PROGRAMA : CEMTCLI.PRG
DATA     : 07/06/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : MANUTENCAO DE CLIENTES
SISTEMA  : CONTROLE DE ESTOQUE
LINGUAGEM: CLIPPER 5.01
*/

LOCAL CONF := .T.

USE CEBCLI INDEX CEICLI, CEICLI2

SOMBRA(07,07,19,66)
@ 07,25 SAY "Manuten‡„o de Clientes"
@ 08,08 say "Codigo........:"
@ 09,08 say "Nome..........:"
@ 10,08 say "R.G...........:"
@ 11,08 say "C.P.F.........:"
@ 12,08 say "Insc. Estadual:"
@ 13,08 say "Endere‡o......:"
@ 14,08 say "Cidade........:"
@ 15,08 say "Estado........:"
@ 16,08 say "C.E.P.........:"
@ 17,08 say "Tel. Fax......:"
@ 18,08 say "Obs...........:"
SAVE SCREEN TO sTela1
corcli := setcolor()
mOpcao := array(3,3)
mOpcao := {{12,20,"Alterar"},{12,29,"Excluir"},{12,38,"Voltar"}}
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   setcolor(corcli)
   cCod = space(6)
   lInclui := .f.
   ALTER = 0
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
   SET ORDER TO 1
   setcolor(corcli)
   SEEK cCod
   IF .NOT. FOUND()
      cNome:= space(40)
      cRg  := space(20)
      cCpf := space(20)
      cInce:= space(20)
      cEnde:= space(40)
      cCid := space(30)
      cEst := space(2)
      cCep := space(9)
      cTel := space(15)
      mObs := Space(10)
      lInclui :=  confirma("Codigo nao cadastrado! Deseja Cadastrar ?")
   ELSE
      cNome:= Nome
      cRg  := Rg
      cCpf := Cpf
      cInce:= Insc
      cEnde:= Endereco
      cCid := Cidade
      cEst := Estado
      cCep := Cep
      cTel := Telefone
      mObs := Obs
      @ 09,24 SAY cNome PICT "@!"
      @ 10,24 SAY cRG   PICT "@!"
      @ 11,24 SAY cCpf  PICT "@!"
      @ 12,24 SAY cInce PICT "@!"
      @ 13,24 SAY cEnde PICT "@!"
      @ 14,24 SAY cCid  PICT "@!"
      @ 15,24 SAY cEst  PICT "@!"
      @ 16,24 SAY cCep  PICT "@!"
      @ 17,24 SAY cTel  PICT "@!"
      inkey(5)
      SAVE SCREEN TO sTela_ant
      set color to gr+/b
      sombra(10,18,14,46)
      @ 11,20  SAY "Codigo Existente:" Color "R/n"
      setcolor(Corcli)
      alter:=botao(mOpcao)
      RESTORE SCREEN FROM sTela_ant
      IF ALTER = 2
         IF confirma("Deseja REALMENTE Excluir o Registro ?")
	    DELE
	 ENDIF
      ELSEIF ALTER = 3 .OR. ALTER = 0
         LOOP
      ENDIF
   ENDIF
   IF lInclui .OR.  ALTER = 1
      @ 09,24 GET cNome PICT "@!"
      @ 10,24 GET cRG   PICT "@!"
      @ 11,24 GET cCpf  PICT "@!"
      @ 12,24 GET cInce PICT "@!"
      @ 13,24 GET cEnde PICT "@!"
      @ 14,24 GET cCid  PICT "@!"
      @ 15,24 GET cEst  PICT "@!" valid (estados(cEst))
      @ 16,24 GET cCep  PICT "@!"
      @ 17,24 GET cTel  PICT "@!"
      READ
      IF confirma("Deseja anotar Observacoes ?")
         mObs := obser(.t.,mObs)
      endif
      IF confirma("Os Dados Estao Corretos")
         IF lInclui
            dbappend()
         ENDIF
         REPLACE Codigo   WITH cCod
         REPLACE Nome     WITH cNome
	 REPLACE Rg       WITH cRg
	 REPLACE Cpf      WITH cCpf
	 REPLACE Insc     WITH cInce
	 REPLACE Endereco WITH cEnde
	 REPLACE Cidade   WITH cCid
	 REPLACE Estado   WITH cEst
	 REPLACE Cep      WITH cCep
	 REPLACE Telefone WITH ctel
	 REPLACE Obs      WITH mObs
      ENDIF
   ENDIF
   CONF=confirma("Deseja Continuar na Manutencao de Clientes?")
ENDDO
RELEASE ALL
CLOSE ALL
RETURN

* eop cemtcli.prg
