/*
BOP CAMTCLI.PRG

PROGRAMA : CAMTCLI.PRG
DATA     : 07/06/95
AUTOR    : LUIZ ANTONIO CARLIN
FUNCAO   : MANUTENCAO DE CLIENTES
SISTEMA  : CONTROLE DE ACOUGUES
LINGUAGEM: CLIPPER 5.01
*/

LOCAL CONF := .T.

USE CABCLI INDEX CAICLI

SOMBRA(07,07,14,66)
@ 07,25 SAY "Manuten‡„o de Clientes"
@ 08,08 say "Codigo........:"
@ 09,08 say "Nome..........:"
@ 10,08 say "Endere‡o......:"
@ 11,08 say "Cidade........:"
@ 12,08 say "Telefone......:"
@ 13,08 say "Obs...........:"
SAVE SCREEN TO sTela1
corcli := setcolor()
DO WHILE CONF
   RESTORE SCREEN FROM sTela1
   setcolor(corcli)
   cCod    := space(6)
   lInclui := .f.
   ALTER   := 0
   @ 08,24 GET cCod PICT "@!"
   READ
   IF empty(cCod) .and. lastkey()=13
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
   SEEK cCod
   IF .NOT. FOUND()
      IF confirma("Codigo nao cadastrado! Deseja Cadastrar ?")
         cNome:= space(40)
         cEnde:= space(40)
         cCid := space(30)
         cTel := space(15)
         mObs := Space(10)
         lInclui := .T.
      ENDIF
   ELSE
      @ 09,24 SAY Nome      PICT "@!"
      @ 10,24 SAY Endereco  PICT "@!"
      @ 11,24 SAY Cidade    PICT "@!"
      @ 12,24 SAY Telefone  PICT "@!"
      inkey(5)
      SAVE SCREEN TO sTela_ant
      mOpcao := array(3,3)
      mOpcao := {{12,20,"Alterar"},{12,29,"Excluir"},{12,38,"Voltar"}}
      set color to gr+/b
      sombra(10,18,14,46)
      @ 11,20  SAY "Codigo Existente:" Color "w+/n"
      setcolor(corcli)
      alter:=botao(mOpcao)
      RESTORE SCREEN FROM sTela_ant
      IF ALTER = 2
         IF confirma("Deseja REALMENTE Excluir o Registro ?")
	    DELE
	 ENDIF
      ELSEIF ALTER = 1
         cNome:= Nome
         cEnde:= Endereco
         cCid := Cidade
         cTel := Telefone
         mObs := Obs
     ENDIF
  ENDIF
  IF ALTER = 1 .OR. lInclui
     @ 09,24 GET cNome PICT "@!"
     @ 10,24 GET cEnde PICT "@!"
     @ 11,24 GET cCid  PICT "@!"
     @ 12,24 GET cTel  PICT "@!"
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
	REPLACE Endereco WITH cEnde
	REPLACE Cidade   WITH cCid
	REPLACE Telefone WITH ctel
	REPLACE Obs      WITH mObs
      ENDIF
   ENDIF
   CONF=confirma("Deseja Continuar na Manutencao de Clientes?")
ENDDO
RELEASE ALL
CLOSE ALL
RETURN
* eop CAmtcli.prg