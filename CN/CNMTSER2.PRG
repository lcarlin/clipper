/*
 bop cnmtser2.prg
 data 26/01/96
 funcao : gerar e imprimir orcamentos
 sistema : tabela de controle de notas
 autor : luiz antonio carlin
 linguagem : clipper 5.2
*/
 
#Include "winclas.ch"
local i, l, k, m
USE CNBSERV INDEX CNISER1 NEW
USE CNBCLI  INDEX CNICLI1, CNICLI2 NEW
USE CNBSER1 INDEX CNISER3 NEW
USE CNBSER2 INDEX CNISER4 NEW
 
@ 05,04 SAY "Nota Fiscal N§...:"
@ 06,04 SAY "Codigo do Cliente:"
@ 07,04 SAY "Cliente..........:"
sTelaS := savescreen(00,00,maxrow(),maxcol())
mOpcao := {{12,19,"Imprime"},{12,28,"Altera"},{12,36,"Exclui"},{12,44,"Cancela"}}
aMatOpc := {{12,28," Sim "},{12,37," N„o "},{12,47," Sair "}}
aMatOpc2:= {{12,26," Sim "},{12,33," N„o "},{12,40," Sair "},{12,48,"Excluir"}}
oJanOrc := WindowNew(10,24,14,56)
.oJanOrc:color :=cCorJane
lCont := .t.
 
DO WHILE lCont
   SELE CNBSER1
   restscreen(0,0,maxrow(),maxcol(),sTelaS)
   lGrava := lImprime := lSai := lCGrava := .F.
   ALTER  := 0
   nApaga := 0
   nNota  := 0
   @ 05,23 GET nNOta PICTURE "999999"
   READ
   IF lastkey() = 27
      EXIT
   ENDIF
   IF empty(nNota) .and. lastkey() = 13
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      nNota := Nota
      @ 05,23 GET nNota PICTURE "999999"
      CLEAR GETS
   ELSEIF empty(nNota) .and. lastkey()=27
      exit
   ENDIF
   SEEK nNota
   IF found()
      @ 06,23 SAY cod_cli
      @ 07,23 SAY nome_cli
      inkey(5)
      save screen to stela1
      corcli := setcolor(cCorJane)
      sombra(10, 17, 14, 52)
      @ 11, 20 say "Nota J  cadstrada:" color "R/n"
      set color to (corcli)
      alter:= botao(mopcao,,cCorBin,cCorBAt)
      restore screen from stela1
      IF ALTER = 4 .OR. ALTER = 0
         LOOP
      ELSEIF ALTER = 3
         IF confirma("Deseja realmente Excluir a Nota?")
            DELETE
            SELE cnbser2
            DELETE ALL FOR _NOTA = nNota
         ENDIF
      ELSEIF Alter = 2 .or. ALTER = 1
         cCliente   := NOME_CLI
         cCodCli    := cod_cli
         SELE cnbcli
         LOCATE FOR codigo=cCodCli
         IF .NOT. found()
            mensagem({"O Cliente: "+cCliente+" Foi Excluido!!", ;
                           "    N„o posso Obter seus dados!!"})
            LOOP
         ENDIF
         cMunicipio := munici
         cInscMn    := InscMn
         cEndereco  := Ender
         cInscEs    := InscEs
         cUf        := Uf
         cCgc       := Cgc
         SELE cnbser2
         SET FILTER TO _nota  = nNOta
         GO TOP
         aMatMat := Array(1,5)
         aMatMat[1][1] := _cod_serv
         aMatMat[1][2] := _des_serv
         aMatMat[1][3] := unidade
         aMatMat[1][4] := _quant
         aMatMat[1][5] := val_unit
         DO WHILE .not. EOF()
            if(alter=2,dbdelete(),.f.)
            SKIP
            aadd(aMatMat,{_cod_SERv,_des_serv,unidade,_quant,val_unit})
         ENDDO
         SET FILTER TO
         GO TOP
      ENDIF
   ELSE
      IF confirma("Nota N„o cadastrada! Deseja Cadastrar ?")
         lGrava   := .t.
         cCliente := space(40)
         cCodCli  := space(06)
         aMatMat  := array(1,5)
         aMatMat  := {{space(02),space(40),space(03),0,0}}
      ENDIF
   ENDIF
   IF lGrava .or. Alter = 2
      lCGrava := .T.
      SELE CNBCLI
      @ 06,23 GET cCodCli PICT "@!"
      READ
      IF lastkey() = 27
         EXIT
      ENDIF
      IF empty(ccODcLI) .and. lastkey() = 13
         SET ORDER TO 2
         nProc := tabela()
         IF empty(nProc)
            LOOP
         ENDIF
         cCodCli := Codigo
         @ 06,23 GET cCodCli PICTURE "@!"
         CLEAR GETS
         SET ORDER TO 1
      ELSEIF empty(cCodCli) .and. lastkey()=27
         exit
      ENDIF
      SEEK cCodCli
      IF .NOT. FOUND()
         mensagem("Cliente N„o Cadastrado !!!")
         LOOP
      ENDIF
      cCliente   := nome
      cEndereco  := ender
      cMunicipio := munici
      cInscMn    := InscMn
      cInscEs    := InscEs
      cUf        := Uf
      cCgc       := Cgc
      @ 07,23 SAY cCliente
 
*     SELECT CNBSERV
      IF aMatMat[1][1] = NIL
         aMatMat  := {{space(2),space(40),space(03),0,0}}
      ENDIF
      @ 12,04 SAY "Codigo |Servico"+space(33)+"|Un.|Quant.|Pre‡o Unit."
      i := 1
      M := 13
      nAcDiv := 0
      FOR I := 1 TO 15  //DO WHILE .t.
         l_Sai1 := .t.
         IF i > len(aMatMat)
            aadd(aMatMat,{space(02),space(40),space(03),0,0})
 
         ENDIF
         DO WHILE l_Sai1
            nIserv := catego()
            IF lastkey() = 27
                lSai  := .T.
                L_SAI := .F.
                EXIT
            ENDIF
            aMatMat[i][1] := substr(aServico[nIserv],1,2)
            aMatMat[i][2] := substr(aServico[nIserv],6,40)
            @ m,09    SAY amatMat[i][2]
            @ m,11    say "|"
            @ m,col() say aMatMat[i][2]
            inkey(2)
            .oJanOrc:OpenWin()
            @ 11,27 SAY "Confirma o Servi‡o ?" color cCorMens
            nConf := Botao(if(lGrava .or. empty(aMatMat[i][2]),aMatOpc,aMatOpc2),,cCorBin,cCorBat)
            .oJanOrc:CloseWin()
            IF nConf = 2 .OR. nConf = 0
               LOOP
            ELSEIF nConf = 3
               lSai := .T.
               EXIT
            ELSEIF nConf = 4
               adel(aMatMat,i)
               nApaga++
               LOOP
            ELSE
               l_Sai1 := .f.
            ENDIF
         ENDDO
         IF lSai
            EXIT
         ENDIF
         aMatMat[i][2] := substr(aServico[nIserv],6,40)       // servico
         aMatMat[i][3] := substr(aServico[nIserv],46,3)       // unidade
         aMatMat[i][4] := if(lGrava,0,aMatMat[i][4])          // quantidade
         aMatMat[i][5] := val(substr(aServico[nIserv],52,11))  // preco
         @ m,09    SAY aMatMat[i][1]
         @ m,11    say "|"
         @ m,col() say aMatMat[i][2]
         @ m,col() say "|"
         @ m,col() say aMatMat[i][3]
         @ m,col() Say "|"
         @ m,col() get aMatMat[i][4] PICT "999" valid amatmat[i][5] != 0
         @ m,col() say "   |"
         @ m,col() get aMatmat[i][5] picture "999,999.99" valid amatmat[i][4] != 0
         read
         nAcDiv+= (aMatMat[i][4]*aMatMat[i][5])
         @ 23,  8 say "Valor TOTAL do Servico:"
         @ 23, Col() say nacdiv picture "99,999,999.99"
         if (LastKey() == 27)
            exit
         endif
         //  i++
         m++
         IF M >= 22
            scroll (13,04,22,76,1)
            M = 21
         ENDIF
      NEXT
      IF .not. lGrava
         aMatMat2 := {}
         aMatMat2 := aClone(aMatMat)
         nI1 := 1
         nI2 := 1
         aMatMat := {}
         FOR nI1 := 1 TO len(aMatMat2)-nApaga
             IF aMatmat2[nI1][1] <> NIL
                aadd(aMatMat,{space(02),space(40),space(03),0,0})
                aMatMat[nI2][1] := aMatMat2[nI1][1]
                aMatMat[nI2][2] := aMatMat2[nI1][2]
                aMatMat[nI2][3] := aMatMat2[nI1][3]
                aMatMat[nI2][4] := aMatMat2[nI1][4]
                aMatMat[nI2][5] := aMatMat2[nI1][5]
                nI2++
             ENDIF
         NEXT
         RELEASE AMATMAT2
      ENDIF
      lCGrava := confirma("Os Dados do Servico est„o corretos ?")
      IF lCGrava
         SELE CNBSER1
         IF lGrava
            dbappend()
         ENDIF
         REPLACE Nota      WITH nNota
         REPLACE NOME_CLI  WITH cCliente
         REPLACE COD_CLI   WITH cCodCli
         SELE CNBSER2
         FOR K := 1 TO len(aMatMat)
             IF .NOT. empty(aMatMat[k][2])
                dbappend()
                REPLACE _NOTA     WITH nNota
                REPLACE _COD_CLI  WITH cCodCli
                REPLACE _Nome_Cli WITH cCliente
                REPLACE _cod_Serv WITH aMatMat[k][1]
                REPLACE _Des_serv WITH aMatMat[k][2]
                REPLACE unidade   WITH aMatMat[k][3]
                REPLACE _quant    WITH aMatMat[k][4]
                REPLACE val_unit  WITH aMaTMat[k][5]
             ENDIF
         NEXT
      ELSE
         SELE CNBSER2
         SET DELETE OFF
         SET FILTER TO
         RECALL ALL
         SET DELETE ON
      ENDIF
   ENDIF
   IF ALTER = 1  .OR. (ALTER = 2 .AND. lCGrava) .OR. (lGrava .AND. lCGrava)
      IF confirma("Deseja Imprimir a Nota Fiscal?")
         mensagem("Verifique a Impressora ! ")
         IF isprinter()
            sombra(11,09,13,44)
            @ 12,10 SAY "Aguarde !! Imprimindo a Nota....." Color "W*/N"
            SET CONSOLE OFF
            SET DEVICE TO PRINTER
            SET PRINT ON
            @ 18,00 SAY chr(27)+chr(15)
            SET PRINT OFF
            @ 19,24 SAY date()
            @ 20,15 SAY cCliente
            @ 22,15 SAY cEndereco
            @ 23,15 SAY cMunicipio
            @ 23,66 SAY cUf
            @ 25,15 SAY cInscMn
            @ 25,37 SAY cInscEs
            @ 25,74 SAY cCgc
            nL  := nSub := nAcDiv := 0
            FOR nL := 1 TO len(aMatmat)
                IF aMatMat[nL][4] = 0
                   EXIT
                ENDIF
                @ 28+nL,05 SAY aMatMat[nL][3]
                @ 28+nL,13 SAY aMatMat[nL][4]
                @ 28+nL,18 SAY aMatMat[nL][2]
                @ 28+nL,69 SAY aMatMat[nL][5] PICT "999,999.99"
                nSub := (amatMat[nL][4]*aMatMat[nL][5])
                @ 28+nL,91 SAY nSub PICT "999,999.99"
                nAcDiv+=nSub
            NEXT
            @ 47,91 SAY nAcDiv PICT "999,999.99"
            @ 48,91 SAY nAcDiv PICT "999,999.99"
            @ prow(),pcol() SAY CHR(27)+Chr(18)
            EJECT
            SET CONSOLE ON
            SET DEVICE TO SCREEN
         ELSE
            Mensagem("Impressora N„o Preparada !!")
         ENDIF
      ENDIF
   ENDIF
   lCont := confirma("Deseja Continuar Fazendo Notas ?")
ENDDO
 
SELE CNBSERV
PACK
 
SELE CNBSER2
PACK
 
CLOSE ALL
 
 
* eop  CNMTSER2.PRG
