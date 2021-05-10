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
USE CEBEST INDEX CEIEST2

SELE 4
USE CEBORC  INDEX CEIORC

SELE 5
USE CEBMEST INDEX CEIMEST

SELE 6
USE CEBLANCA

SELE 7
USE CEBAGEN INDEX CEIAGEN




SOMBRA(04,02,18,71)
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
@ 14,03 SAY "Obsevacoes.....:"
@ 15,03 SAY "Roteiro fazenda:"

SAVE SCREEN TO sTela1
corcli := setcolor()
DO WHILE CONF
   SELE 1
   RESTORE SCREEN FROM sTela1
   setcolor(Corcli)
   nPedido   := 0
   dData     := DATA_SIS
   cCondi    := space(40)
   cFazenda  := space(40)
   cMunfaz   := space(30)
   cEstfaz   := space(02)
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
      IF .NOT. CONFIRMA("Pedido nao Encontrado! Incluir Pedido ?")
         LOOP
      ENDIF
      @ 06,20 GET dData PICT "99/99/99" VALId(DIA_UTIL(DDATA))
      READ
      SELE 2
      @ 07,20 GET cCodigo PICT "@!"
      READ
      IF empty(cCodIGO) .and. lastkey()=13
         SET ORDER TO 2
         nProc := tabela()
         IF empty(nProc)
            LOOP
         ENDIF
         cCodIGO = Codigo
         @ 7,20 GET cCodIGO PICT "@!"
         CLEAR GETS
      ELSEIF empty(cCodIGO) .and. lastkey()=27
         exit
      ENDIF
      setcolor(corcli)
      SET ORDER TO 1
      SEEK cCodigo
      IF .NOT. FOUND()
         mensagem("Cliente Nao Cadastrado!")
         LOOP
      ENDIF
      // dados do cliente
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
      @ 08,20 GET Nome
      CLEAR GETS
      @ 09,20 GET cCondi     PICT "@!"
      @ 10,20 GET cFazenda   PICT "@!"
      @ 11,20 GET cMunFaz    PICT "@!"
      @ 12,20 GET cEstFaz    PICT "@!" VALID(ESTADOs(CeSTfAZ))
      @ 13,20 GET dProg_ent  PICT "99/99/99" VALId(DIA_UTIL(DProg_ent))
      @ 14,20 GET cObs       PICT "@!" 
      @ 15,20 GET cRot_faz1 PICT "@!" 
      @ 16,20 GET cRot_faz2 PICT "@!" 
      @ 17,20 GET cRot_faz3 PICT "@!"
      READ 
      centra(24,"<ESC> - Volta ; <F1> - Help;","gr+/bg")
      SOMBRA(07,07,20,75)
      @ 07,30 SAY "Materiais Vendidos:"
      @ 08,08 SAY "Quantidade|Material"+space(32)+"|Valor Total   "
      aMatMat := array(10,3)
      FOR N := 9 TO 18
          @ n,18 SAY "|"
          @ N,59 SAY "|"
          aMatmat[n-8][1] = 0
          aMatmat[n-8][2] = space(40)
          aMatmat[n-8][3] = 0
      NEXT
      SELE 3
      FOR M := 9 TO 18
          @ M,8  GET aMatmat[M-8][1] PICT "9999" VALID(aMatMat[M-8][1]<>0)
          @ M,19 GET aMatmat[M-8][2] PICT "@!"  VALID(acha(aMatMat[M-8][2]))
          READ
          aMatmat[M-8][3] := VALUNITV
          aMatmat[M-8][2] := PRODUTO
          @ M,19 GET aMatmat[M-8][2]
          @ M,59 SAY (aMatmat[M-8][3]*aMatmat[M-8][1]) PICT "99,999,999.99"
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
         LOOP 
      ENDIF
      SELE 1 
      APPEND BLANK 
      REPLACE Pedido    WITH nPedido 
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
          REPLACE REALIZADO WITH "N"
      NEXT
      lInclui := .t.
   ELSE
      dData     := data 
      cCondi    := condicao 
      cFazenda  := fazenda
      cMunfaz   := municipio 
      cEstfaz   := estado 
      dProg_ent := Prog 
      cObs      := obs 
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
      aMatMat := array(1,3)
      i := 1
      DO WHILE nPEDIDO1 = nPedido
         aadd(aMatmat,{0,space(40),0})
         aMatMat[i][1] := NQTDMAT
         aMatMat[i][2] := CMAT
         aMatMat[i][3] := NVALUNIT
         I++
         SKIP
      ENDDO
      SELE 1 
      @ 06,20 GET dData PICT "99/99/99" 
      @ 07,20 GET cCodigo    PICT "@!" 
      @ 08,20 GET cNome      PICT "@!" 
      @ 09,20 GET cCondi     PICT "@!" 
      @ 10,20 GET cFazenda   PICT "@!" 
      @ 11,20 GET cMunFaz    PICT "@!" 
      @ 12,20 GET cEstFaz    PICT "@!" 
      @ 13,20 GET dProg_ent  PICT "99/99/99" VALId(DIA_UTIL(DProg_ent))
      @ 14,20 GET cObs       PICT "@!" 
      @ 15,20 GET cRot_faz1 PICT "@!" 
      @ 16,20 GET cRot_faz2 PICT "@!" 
      @ 17,20 GET cRot_faz3 PICT "@!"
      CLEAR GETS 
      SAVE SCREEN TO TELA_ANT 
      COR := SETCOLOR("GR+/B") 
      a_MatOpc := array (4,3) 
      a_matOpc := {{12,20,"Imprime"},{12,29,"Altera"},{12,37,"Exclui"},{12,45,"Volta"}}
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
      ELSEIF OPC = 2 
         @ 06,20 GET dData      PICT "99/99/99" VALId(DIA_UTIL(DDATA))
         READ 
         @ 07,20 GET cCodigo    PICT "@!" 
         READ
         SELE 2 
         setcolor(corclI)
         IF  empty(cCodIGO) .and. lastkey()=13 
             nProc := tabela()
             IF empty(nProc) 
                LOOP 
             ENDIF
             cCodIGO = Codigo 
             @ 7,20 GET cCodIGO PICT "@!" 
             CLEAR GETS
         ELSEIF empty(cCodIGO) .and. lastkey()=27 
             exit 
          ENDIF 
         setcolor(corcli)
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
         @ 14,20 GET  cObs       PICT "@!" 
         @ 15,20 GET  cRot_faz1  PICT "@!" 
         @ 16,20 GET  cRot_faz2  PICT "@!" 
         @ 17,20 GET  cRot_faz3  PICT "@!"
         READ 
         centra(24,"<ESC> - Volta ; <F1> - Help;","gr+/bg")
         SOMBRA(07,07,20,75)
         @ 07,30 SAY "Materiais Vendidos:"
         @ 08,08 SAY "Quantidade|Material"+space(32)+"|Valor Total   "
         aMatMat := array(10,3)
         SELE 4
         SEEK Npedido
         FOR N := 9 TO 18
             @ n,18 SAY "|"
             @ N,59 SAY "|"
             aMatmat[n-8][1] = if(npedido1=npedido,NQTDMAT,0)
             aMatmat[n-8][2] = if(npedido1=npedido,CMAT,space(40))
             aMatmat[n-8][3] = if(npedido1=npedido,NVALUNIT,0)
             DELE
             SKIP
         NEXT
         SELE 3
         FOR M := 9 TO 18
             @ M,8  GET aMatmat[M-8][1] PICT "9999" VALID(aMatMat[M-8][1]<>0)
             @ M,19 GET aMatmat[M-8][2] PICT "@!"  VALID(acha(aMatMat[M-8][2]))
             READ
             aMatmat[M-8][3] := VALUNITV
             aMatmat[M-8][2] := PRODUTO
             @ M,19 GET aMatmat[M-8][2]
             @ M,59 SAY (aMatmat[M-8][3]*aMatmat[M-8][1]) PICT "99,999,999.99"
             CLEAR GETS
             nAcDiv+=(aMatmat[M-8][3]*aMatmat[M-8][1])
             @ 19,08 SAY "Valor do Orcamento:"
             @ 19,col() SAY nAcDiv PICT "99,999,999.99"
             IF lastkey()= 27
                M := 9
                EXIT
             ENDIF
         NEXT
         IF .NOT. CONFIRMA("Os dados Estao Corretos ?") 
            RECALL
            LOOP 
         ENDIF
         SELE 1 
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
      ELSEIF OPC = 1 
      ENDIF
      lInclui := .f.
   ENDIF 
   IF OPC < 3 .OR. (.NOT. empty(nPedido))
      IF Confirma("Deseja Imprimir Nota de Pedido ?") 
         SELE 1 
         cCodigo  := Cod_cli // dados do cliente
         SELE 2 
         SEEK cCodigo 
         IF .NOT. FOUND() 
            mensagem("O Cliente "+cCodigo+" foi exluido!! Nao posso obter seus dados!!") 
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
         // fim dos dados do cliente e inicio dos materiais

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
         @ 12,00 say "+"
         @ 12,01 say REPLICATE("-",78) 
         @ 12,79 SAY "+" 
         @ 13,00 SAY "|Quantidade|Material"+space(32)+"| Valor Total |"
         nSomaTotal := 0
         FOR I := 1 TO len(aMatmat)
             @ 13+i,0 say "|"
             @ 13+I,01 SAY amatMat[i][1] PICT "9999"
             @ 13+I,PCOL()+6 SAY "|"
             @ 13+I,PCOL() SAY aMatmat[i][2]
             @ 13+I,pcol() SAY "|"
             @ 13+I,PCOL() SAY (aMatmat[i][1]*aMatMat[i][3]) PICT "99,999,999.99"
             @ 13+i,pcol() say "|"
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
   IF .NOT. empty(nPedido)
      SELE 4
      SEEK nPedido
      IF realizado <> "S"
         IF confirma("Deseja Realizar as Baixas dos Produtos?")
            nAcTot := 0
            FOR K := 1 TO len(aMatMat)
                IF empty(aMatMat[k][2])
                   EXIT
                ENDIF
                SELE 3
                SEEK aMatmat[k][2]
                IF .NOT. found()
                   mensagem("O Produto "+aMatmat[k][2]+" nao existe no estoque !")
                   LOOP
                ENDIF
                IF (QTD-QTDMIN) < aMatMat[k][1]
                   Mensagem("Quantidade insuficiente do produto"+aMatmat[k][2]+" !")
                   LOOP
                ENDIF
                REPLACE QTD WITH (QTD-aMatmat[k][1])
                nLucro := VALUNITV-VALUNIT
                SELE 5
                REPLACE COD_PES   WITH cCodigo
                REPLACE PESSOA    WITH cNome
                REPLACE COD_ITEM  WITH "      "
                REPLACE ITEM      WITH aMatMat[k][2]
                REPLACE QUANT     WITH aMatMat[k][1]
                REPLACE VAL_UNI   WITH aMatMat[k][3]
                REPLACE VAL_TOT   WITH aMatMat[k][1]*aMatMat[k][3]
                REPLACE DATA_NEG  WITH data_sis
                REPLACE LUCRO     WITH nLucro
                REPLACE TIPO      WITH "V"
                nAcTot+=aMatMat[k][1]*aMatMat[k][3]
            NEXT
            SELE 4
            FOR L := 1 TO LEN(aMatMat)
                REPLACE REALIZADO WITH "S"
                SKIP
            NEXT
            IF confirma("Deseja registrar o recebimento na agenda ?")
               SELE 7
               gera_agd(nAcTot, "C", cCodigo, cNome)
            ELSE
               SELE 6
               APPEND BLANK
               REPLACE descricao WITH "Recebimento de Pedido "
               REPLACE VALOR     WITH nActot
               REPLACE TIPO      WITH "C"
               REPLACE DATA      WITH DATA_SIS
           ENDIF
         ENDIF
      ENDIF
   ENDIF
   CONF:= Confirma("Deseja Continuar na Manutencao de Pedidos?")
ENDDO 
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