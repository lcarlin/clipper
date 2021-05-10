/*
bop cemtped.prg
programa     cemtped
funcao       manutencao e impressao de pedidos
autor        Luiz Antonio Carlin
Data         30/06/95
sistema      Controle de Estoque
Linguagem    Clipper 5.01
*/
LOCAL CONF := .T.


SELE 1
USE CEBPED  INDEX CEIPED

SELE 2
USE CEBCLI  INDEX CEICLI, CEICLI2

SELE 3
USE CEBpre INDEX CEIpre2

SELE 4
USE CEBORC  INDEX CEIORC


SOMBRA(04,02,20,71)
@ 04,29 SAY "Manuten‡„o de Pedidos"
@ 05,03 SAY "Pedido.........:"
@ 06,03 SAY "Data...........:"
@ 07,03 SAY "Codigo Cliente.:"
@ 08,03 SAY "Nome...........:"
@ 09,03 SAY "Condicoes.Pagto:"
@ 10,03 SAY "Fazenda........:"
@ 11,03 SAY "Cidade(Fazenda):"
@ 12,03 SAY "Estado(Fazenda):"
@ 13,03 SAY "Programa Entre.:"
@ 14,03 SAY "Frete(SACO)....:"
@ 15,03 SAY "Desconto(venda):        %"
@ 16,03 SAY "Obsevacoes.....:"
@ 17,03 SAY "Roteiro fazenda:"


SAVE SCREEN TO sTela1
corcli := setcolor()
a_MatOpc := array (4,3) 
a_matOpc := {{12,20,"Imprime"},{12,29,"Altera"},{12,37,"Exclui"},{12,45,"Volta"}}
DO WHILE CONF
   SELE 1
   RESTORE SCREEN FROM sTela1
   setcolor(Corcli)
   nPedido   := 0
   lInclui   := .f.
   @ 05,20 GET nPedido PICT "999999"
   READ
   SELE 1
   IF empty(nPedido) .and. lastkey()=13
      nProc := tabela()
      IF empty(nProc)
         LOOP
      ENDIF
      nPedido = Pedido
      @ 5,20 GET nPedido PICT "@!"
      CLEAR GETS
   ELSEIF empty(nPedido) .and. lastkey()=27
      exit
   ENDIF
   setcolor(corcli)
   SEEK nPedido
   IF .NOT. FOUND()
      lInclui := CONFIRMA("Pedido nao Encontrado! Incluir Pedido ?")
      dData     := DATA_SIS
      cCondi    := space(40)
      cFazenda  := space(40)
      cMunfaz   := space(30)
      cEstfaz   := space(02)
      nFrete    := 0
      nDesc     := 0
      nAcDiv    := 0
      dProg_ent := ctod("  /  /  ")
      cObs      := space(50)
      cRot_faz1 := space(50)
      cRot_faz2 := space(50)
      cRot_faz3 := space(50)
      // Dados do Cliente
      cCodigo   := space(06)
      cNome     := space(40)
      cRg       := space(15)
      cCpf      := space(15)
      cInce     := space(15)
      cEnde     := space(40)
      cCid      := space(30)
      cEst      := space(2)
      cCep      := space(9)
      cTel      := space(15)
      Opc       := 4
      // Fim dos dados do Cliente
      aMatMat := array(10,3)
      FOR I = 1 TO 10
          aMatMat[i][1] := 0
          aMatMat[i][2] := space(40)
          aMatMat[i][3] := 0
      NEXT
   ELSE
      dData     := data 
      cCondi    := condicao 
      cFazenda  := fazenda
      cMunfaz   := municipio 
      cEstfaz   := estado 
      dProg_ent := Prog 
      cObs      := obs 
      nFrete    := frete
      nDesc     := desc
      cRot_faz1 := Rot_faz1
      cRot_faz2 := Rot_faz2 
      cRot_faz3 := Rot_faz3 
      cCodigo   := Cod_cli
      // dados do cliente 
      SELE 2 
      SEEK cCodigo 
      IF .NOT. FOUND()
         mensagem("O Cliente "+cCodigo+"foi exluido!! Nao posso obter seus dados!!") 
         LOOP 
      ENDIF
      cNome:= Nome 
      cRg  := Rg 
      cCpf := Cpf 
      cInce:= Insc 
      cEnde:= Endereco 
      cCid := Cidade 
      cEst := Estado 
      cCep := Cep 
      cTel := Telefone 
      // fim dos dados do cliente 
      SELE 4
      SEEK nPedido
      IF FOUND()
         i := 1
         SET DELETE OFF
         aMatmat:=array(1,3)
         DO WHILE nPEDIDO1 = nPedido
            aadd(aMatMat,{0,space(40),0})
            aMatMat[i][1] := NQTDMAT
            aMatMat[i][2] := CMAT
            aMatMat[i][3] := NVALUNIT
            I++
            DELE
            SKIP
         ENDDO
         SET DELETE ON
      ELSE
         aMatMat := array(10,3)
         for i := 1 to 10
             aMatMat[i][1] := 0
             aMatMat[i][2] := space(40)
             aMatMat[i][3] := 0
         NEXT
      ENDIF
      SELE 1 
      @ 06,20 SAY dData      PICT "99/99/99" 
      @ 07,20 SAY cCodigo    PICT "@!" 
      @ 08,20 SAY cNome      PICT "@!" 
      @ 09,20 SAY cCondi     PICT "@!" 
      @ 10,20 SAY cFazenda   PICT "@!" 
      @ 11,20 SAY cMunFaz    PICT "@!" 
      @ 12,20 SAY cEstFaz    PICT "@!" 
      @ 13,20 SAY dProg_ent  PICT "99/99/99"
      @ 14,20 SAY nFrete     PICT "999.99"
      @ 15,20 SAY nDesc      PICT "999.99"
      @ 16,20 SAY cObs       PICT "@!" 
      @ 17,20 SAY cRot_faz1  PICT "@!" 
      @ 18,20 SAY cRot_faz2  PICT "@!" 
      @ 19,20 SAY cRot_faz3  PICT "@!"
      SAVE SCREEN TO TELA_ANT 
      COR := SETCOLOR("GR+/B") 
      inkey(5) 
      SOMBRA(10,19,14,52)       
      SET COLOR TO R/N
      @ 11, 30 SAY "Pedido Existente:"
      Opc := botao(a_matopc) 
      SETCOLOR(COR)
      RESTORE SCREEN FROM TELA_ANT 
      IF OPC = 0 .OR. OPC = 4
         LOOP 
      ENDIF 
      IF OPC = 3 
         IF confirma("Excluir Pedido ?")
            DELE 
            SELE 4
            DELE FOR NPEDIDO1 = nPedido
            nPedido := 0
            OPC := 4
         ENDIF 
      ENDIF
   ENDIF
   IF OPC = 2  .OR. lInclui
      LAC := 1
      LAc2 := 1
      FOR LAC := 1 TO LEN(AMATMAT)
          SETPOS(LAC,01)
          FOR LAC2 = 1 TO 3
              @lac,1+col() say aMatMat[lac][lac2]
          NEXT
      NEXT
      @ 06,20 GET dData      PICT "99/99/99" VALId(DIA_UTIL(DDATA))
      READ 
      @ 07,20 GET cCodigo    PICT "@!" 
      READ
      SELE 2 
      SET ORDER TO 2
      setcolor(corclI)
      IF empty(cCodIGO) .and. lastkey()=13 
         nProc := tabela()
         IF empty(nProc) 
            LOOP 
         ENDIF
         cCodIGO = Codigo 
         @ 7,20 GET cCodIGO PICT "@!" 
         CLEAR GETS
      ELSEIF empty(cCodIGO) .and. lastkey()=27 
         LOOP
      ENDIF 
      setcolor(corcli)
      SET ORDER TO 1
      SEEK cCodigo 
      IF .NOT. FOUND() 
         mensagem("Cliente Nao Cadastrado!") 
         LOOP 
      ENDIF 
      //dados do cliente 
      cNome:= Nome
      cRg  := Rg 
      cCpf := Cpf 
      cInce:= Insc 
      cEnde:= Endereco 
      cCid := Cidade 
      cEst := Estado 
      cCep :=Cep 
      cTel := Telefone 
      // fim dos dados do cliente 
      @ 08,20 GET  Nome 
      CLEAR GETS 
      @ 09,20 GET  cCondi     PICT "@!" 
      @ 10,20 GET  cFazenda   PICT "@!" 
      @ 11,20 GET  cMunFaz    PICT "@!" 
      @ 12,20 GET  cEstFaz    PICT "@!" 
      @ 13,20 GET  dProg_ent  PICT "99/99/99" VALId(DIA_UTIL(DProg_ent))
      @ 14,20 GET  nFrete     PICT "999.99"
      @ 15,20 GET  nDesc      PICT "999.99"
      @ 16,20 GET  cObs       PICT "@!" 
      @ 17,20 GET  cRot_faz1  PICT "@!" 
      @ 18,20 GET  cRot_faz2  PICT "@!" 
      @ 19,20 GET  cRot_faz3  PICT "@!"
      READ 
      centra(24,"<ESC> - Volta ; <F1> - Help;","gr+/bg")
      SOMBRA(07,00,20,77)
      @ 07,30 SAY "Produtos Encomendados:"
      @ 08,01 SAY "Sacos|Produto "+space(32)+"|Valor Total"
      FOR N := 9 TO 18
          @ n,06 SAY "|"
          @ N,47 SAY "|"
      NEXT
      SELE 3
      nAcdiv := 0
      FOR M := 9 TO 18
          @ M,2  GET aMatmat[M-8][1] PICT "9999" VALID(aMatMat[M-8][1]<>0)
          @ M,07 GET aMatmat[M-8][2] PICT "@!"  VALID(acha(aMatMat[M-8][2]))
          READ
          aMatmat[M-8][3] := VALUNITV
          aMatmat[M-8][2] := PRODUTO
          @ M,07 GET aMatmat[M-8][2]
          @ M,48 SAY (aMatmat[M-8][3]*aMatmat[M-8][1]) PICT "99,999,999.99"
          CLEAR GETS
          nAcDiv+=(aMatmat[M-8][3]*aMatmat[M-8][1])
          @ 19,08 SAY "Valor do Orcamento:"
          @ 19,col() SAY nAcDiv PICT "99,999,999.99"
          IF lastkey()= 27
             M := 9
             EXIT
          ENDIF
      NEXT
      IF .NOT. confirma("Os dados Estao corretos ?")
         IF .NOT. lInclui
             SET DELETE OFF
             SELE 4
             RECALL all FOR npedido1=nPedido
             SET DELETE ON
         ENDIF
         LOOP 
      ENDIF
      SELE 1 
      IF lInclui
         DBAPPEND()
      ENDIF
      REPLACE Data      WITH dData 
      REPLACE Cod_cli   WITH cCodigo 
      REPLACE Fazenda   WITH cFazenda 
      REPLACE Municipio WITH cMunfaz 
      REPLACE Estado    WITH cEstFaz 
      REPLACE Condicao  WITH cCondi 
      REPLACE Prog      WITH dProg_ent 
      REPLACE Obs       WITH cObs 
      REPLACE Rot_faz1  WITH cRot_faz1 
      REPLACE Rot_faz2  WITH cRot_faz2 
      REPLACE Rot_faz3  WITH cRot_faz3 
      REPLACE frete     WITH nFrete
      REPLACE DESC      WITH nDesc
      SELE 4
      FOR O := 1 TO 10
          IF  EMPTY(aMatMat[O][1])
              EXIT
          ENDIF
          APPEND BLANK
          REPLACE NPEDIDO1  WITH nPedido
          REPLACE CCOD_CLI  WITH cCodigo
          REPLACE CMAT      WITH aMatmat[o][2]
          REPLACE NQTDMAT   WITH aMatmat[o][1]
          REPLACE NVALUNIT  WITH aMatmat[o][3]
      NEXT
   ENDIF
   IF OPC = 2  .OR. lInclui .OR. OPC = 1
      IF Confirma("Deseja Imprimir Nota de Pedido ?") 
         SELE 1
         MENSAGEM("Verifique a Impressora") 
         IF .NOT. ISPRINTER() 
             mensagem("A Impressora nao esta pronta!")
             LOOP 
         ENDIF 
         SET CONSOLE OFF 
         SET DEVICE TO PRINTER 
         @ 00,00 SAY REPLICATE("=",80) 
         @ 01,20 SAY "Nota de Pedido" 
         @ 02,00 say REPLICATE("=",80) 
         @ 03,02 say "Pedido No: "+str(pedido,6,0) 
         @ 03,65 say "Data: "+dtoc(data) 
         @ 05,00 say "+" 
         @ 05,01 say REPLICATE("-",78) 
         @ 05,79 SAY "+" 
         @ 06,02 SAY "Codigo do Cliente.: "+cCodigo 
         @ 07,02 SAY "Nome do Cliente...: "+cNome 
         @ 08,02 SAY "Endereco..........: "+cEnde 
         @ 09,02 SAY "Cidade............: "+cCid 
         @ 09,pcol()+2 SAY "Estado: "+cEst
         @ 10,02 say "C.E.P.: "+cCep 
         @ 10,pcol()+2 SAY "Fone/Fax.: "+ctel 
         @ 11,02 SAY "R.G.:"+cRg 
         @ 11,pcol()+1 SAY "C.P.F.:"+cCpf 
         @ 11,pcol()+1 say "Insc. Estadual:"+cInce 
         @ 12,02 SAY "Valor do Frete(por Saco)..:"+str(nFrete,6,2)
         @ 12,pcol()+2 SAY "|   Desconto..:"+str(nDesc,6,2)+"%"
         @ 13,00 say "+"
         @ 13,01 say REPLICATE("-",78) 
         @ 14,79 SAY "+" 
         @ 14,00 SAY "|Quantidade|Material"+space(32)+"| Valor Total |"
         nSomaTotal := 0
         FOR I := 1 TO len(aMatmat)
             @ 14+i,0 say "|"
             @ 14+I,01 SAY amatMat[i][1] PICT "9999"
             @ 14+I,PCOL()+6 SAY "|"
             @ 14+I,PCOL() SAY aMatmat[i][2]
             @ 14+I,pcol() SAY "|"
             @ 14+I,PCOL() SAY (aMatmat[i][1]*aMatMat[i][3]) PICT "99,999,999.99"
             @ 14+i,pcol() say "|"
             nSomaTotal+=(aMatmat[i][1]*aMatMat[i][3])
         NEXT
         @ prow()+1,0 SAY "Total"+replicate("-",54)
         @ prow(),pcol() SAY nSomaTotal PICT "99,999,999.99"
         n:= prow()+1
         @ n,00 say "+"
         @ n,01 say REPLICATE("-",78) 
         @ n,79 SAY "+" 
         @ prow()+1,02 SAY "Fazenda.....................: "+fazenda 
         @ prow()+1,02 SAY "Municipio...................: "+Municipio 
         @ prow(),pcol() SAY "Estado: "+Estado 
         @ prow()+1,02 say "Condicao....................: "+Condicao 
         @ prow()+1,02 say "Data Programada Para Entrega: "+dtoc(prog) 
         @ prow()+1,02 say "Observacao: "+Obs 
         @ prow()+1,02 say "Roteiro da Fazenda :" 
         @ prow(),23 say Rot_faz1 
         @ prow()+1,23 say Rot_faz2 
         @ prow()+1,23 say Rot_faz3 
         @ prow()+1,00 say replicate("_",80)
         eject 
         SET DEVICE TO SCREEN 
         SET CONSOLE ON 
      ENDIF 
   ENDIF
   CONF:= Confirma("Deseja Continuar na Manutencao de Pedidos?")
ENDDO 
SET DELETE ON
CLOSE ALL 
RELEASE ALL
RETURN

**************************************
function  acha( cDescmat )
SAVE SCREEN TO sTela_ant
SET FILTER TO Produto = alltrim(cDescmat)
GO TOP
nLinProd := row()
IF eof()
   mensagem("Nao Ha nenhum produto com esse nome")
   lRet := .f.
ELSE
   Sombra(09,09,17,51)
   DECLARE aVetcamp[1]
   aVetCamp[1] := "PRODUTO"
   dbedit(10,10,16,50,aVetcamp,"USer_Func","@!","Material")
   lRet := .t.
ENDIF
RESTORE SCREEN FROM sTela_ant
RETURN lRet

*************************************
function USER_FUNC (nModo,nIndice)
IF nModo = 4
   IF lastkey() = 13
      return 0
   ELSE
      RETURN 1
   ENDIF
ELSe
   RETURN 1
ENDIF

* EOP CEMTPED.PRG