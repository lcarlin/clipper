/*
 bop tpmtorc.prg
 data 11/01/96
 funcao : gerar e imprimir orcamentos
 sistema : tabela de precos
 autor : luiz antonio carlin
 linguagem : clipper 5.2
*/
#Include "winclas.ch"
local i, l, k, m

USE TPBORC INDEX TPIORC NEW
GO BOTTOM
IF eof()
   cNumero3 := "0000-"+substr(str(year(date()),4,0),3,2)
ELSE
   cNumero3 := NUMERO
ENDIF
IF val(substr(str(year(date()),4,0),3,2)) > val(subst(cNumero3,6,2))
   cNumero3 := "0000-"+substr(str(year(date()),4,0),3,2)
ENDIF

USE TPBORC2  index TPIORC2 NEW

USE TABELA INDEX iTab1 NEW

GO TOP
@ 05,04 SAY "Orcamento N§:"
@ 05,23 SAY "-" COLOR (subst(cCorPad,5,3))
@ 06,04 SAY "Cliente.....:"
@ 07,04 SAY "Mao de Obra.:"
@ 08,04 SAY "Objetivo....:"
sTelaS := savescreen(00,00,maxrow(),maxcol())
mOpcao := {{12,19,"Imprime"},{12,28,"Altera"},{12,36,"Exclui"},{12,44,"Cancela"}}
aMatOpc := {{12,28," Sim "},{12,37," N„o "},{12,47," Sair "}}
aMatOpc2:= {{12,26," Sim "},{12,33," N„o "},{12,40," Sair "},{12,48,"Excluir"}}
oJanOrc := WindowNew(10,24,14,56)
.oJanOrc:color :=cCorJane
lCont := .t.

DO WHILE lCont
   SELE TPBORC
   restscreen(0,0,maxrow(),maxcol(),sTelaS)
   cNumero1 :=  substr(str(10001+val( substr(cNumero3,1,4)),5,0),2,4)
   cNumero2 := substr(str(year(date()),4,0),3,2)
   lGrava   := lImprime := lSai := lCGrava := .F.
   ALTER    := 0
   nMaoObra := 0
   cNumeroAx:= cNumero1+"-"+cNumero2
   nApaga   := 0
   @ 05,18 GET cNumeroAx
   READ
   IF lastkey() = 27
      EXIT
   ENDIF
   IF empty(cNumeroAX) .and. lastkey() = 13
      nProc := tabela()
      IF empty(nProc)
        LOOP
      ENDIF
      cNumeroaX:= NUMERO
      @ 05,18 GET cNumeroAx
      CLEAR GETS
      cNumero1:= str(val(substr(cNumero3,1,4))+1,4,0)
      cNumero2:= substr(str(year(date()),4,0),3,2)
   ELSEIF empty(cNumero1) .and. lastkey()=27
      exit
   ENDIF
   SEEK cNumeroAx
   IF found()
      @ 06,18 SAY CLIENTE
      @ 07,18 SAY MaoObra PICTURE "9,999,999.99"
      @ 08,18 SAY OBJETIVO1
      @ 09,18 SAY OBJETIVO2
      @ 10,18 SAY OBJETIVO3
      inkey(5)
      save screen to stela1
      corcli := setcolor(cCorJane)
      sombra(10, 17, 14, 52)
      @ 11, 20 say "Or‡amento Existente:" color "R/n"
      set color to (corcli)
      alter:= botao(mopcao,,cCorBin,cCorBAt)
      restore screen from stela1
      IF ALTER = 4 .OR. ALTER = 0
         LOOP
      ELSEIF ALTER = 3
         IF confirma("Deseja realmente Excluir o Orcamento?")
            DELETE 
            SELE TPBORC2
            DELETE ALL FOR NUMERO = cNumeroAx
         ENDIF
      ELSEIF Alter = 2 .or. ALTER = 1
         cCliente   := CLIENTE
         cObjetivo1 := OBJETIVO1
         cObjetivo2 := OBJETIVO2
         cObjetivo3 := OBJETIVO3
         nMaoObra   := MaoObra
         SELE TPBORC2
         SET FILTER TO NUMERO = cNumeroAx
         GO TOP
         aMatMat := Array(1,5)
         aMatMat[1][1] := cod_mat
         aMatMat[1][2] := material
         aMatMat[1][3] := unidade
         aMatMat[1][4] := qtd_mat
         aMatMat[1][5] := val_unit
         DO WHILE .not. EOF()
            if(alter=2,dbdelete(),.f.)
            SKIP
            aadd(aMatMat,{cod_mat,material,unidade,qtd_mat,val_unit})
         ENDDO
         SET FILTER TO
         GO TOP
      ENDIF
   ELSE
      IF confirma("Orcamento Nao encontrado! Deseja Incluir ?")
         lGrava := .t.
         cCliente   := space(40)
         cObjetivo1 := space(50)
         cObjetivo2 := space(50)
         cObjetivo3 := space(50)
         nMaoObra   := 0
         aMatMat    := array(1,5)
*         aMatMat    := aMatMat  := {{space(07),space(40),space(02),0,0}}
      ENDIF
   ENDIF
   IF lGrava .or. Alter = 2
      lCGrava := .T.
      @ 06,18 GET cCliente
      @ 07,18 GET nMaoObra PICTURE "9,999,999.99"
      @ 08,18 GET cObjetivo1
      @ 09,18 GET cObjetivo2
      @ 10,18 GET cObjetivo3
      READ
      SELECT TABELA
      IF aMatMat[1][1] = NIL
         aMatMat  := {{space(07),space(40),space(02),0,0}}
      ENDIF
      @ 12,04 SAY "Codigo |Material"+space(32)+"|Un.|Quant.  |Pre‡o Unit."
      i := 1
      M := 13
      nAcDiv := 0
      DO WHILE .t.
         l_Sai1 := .t.
         DO WHILE l_Sai1
            @ m,4 get aMatMat[i][1] picture "@!" valid acha(aMatMat[i][1])
            READ
            IF lastkey() = 27
                lSai := .T.
                L_SAI := .F.
                EXIT
            ENDIF
            IF empty(aMatMat[i][1]) .AND. lastkey() = 13
               IF confirma("Deseja Incluir Material nao Listado ?")
                  cTEMP  := space(40)
                  cTemp2 := "  "
                  nTemp3 := 0
                  @ m,12 GET cTEMP
                  @ M,col() SAY "|"
                  @ m,Col() GET cTEMP2
                  @ m,64    SAY "|"
                  @ m,col() GET nTEMP3 PICT "9999,999.99"
                  READ
               ELSE
                  LOOP
               ENDIF
            ELSE
               @ m,11    say "|"
               @ m,col() say descricao
               inkey(2)
            ENDIF
            .oJanOrc:OpenWin()
            @ 11,27 SAY "Confirma o Material ?" color cCorMens
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
         aMatMat[i][2] := if(empty(aMatMat[i][1]),cTEMP,descricao)
         aMatMat[i][3] := if(empty(aMatMat[i][1]),cTEMP2,un)
         aMatMat[i][4] := if(lGrava,0,aMatMat[i][4])
         aMatMat[i][5] := if(empty(aMatMat[i][1]),nTEMP3,preco)
         @ m,11    say "|"
         @ m,col() say aMatMat[i][2]
         @ m,col() say "|"
         @ m,col() say aMatMat[i][3]
         @ m,col() say " |"
         @ m,col() say "       "
         @ m,col() say "|"
         @ m,col() say aMatMat[i][5]  PICTURE "9999,999.99"
         @ m, 57 get aMatmat[i][4] picture "9999.99" valid amatmat[i][4] != 0
         read
         nAcDiv+= (aMatMat[i][4]*aMatMat[i][5])
         @ 23,  8 say "Valor do Orcamento:"
         @ 23, Col() say nacdiv picture "99,999,999.99"
         if (LastKey() == 27)
            exit
         endif
         i++
         m++
         IF M >= 22
            scroll (13,04,22,76,1)
            M = 21
         ENDIF
         IF i > len(aMatMat)
            aadd(aMatMat,{space(07),space(40),space(02),0,0})
         ENDIF
      ENDDO
      IF .not. lGrava
         aMatMat2 := {}
         aMatMat2 := aClone(aMatMat)
         nI1 := 1
         nI2 := 1
         aMatMat := {}
         FOR nI1 := 1 TO len(aMatMat2)-nApaga
             IF aMatmat2[nI1][1] <> NIL
                aadd(aMatMat,{space(07),space(40),space(02),0,0})
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
      lCGrava := confirma("Os Dados do Orcamento est„o corretos ?")
      IF lCGrava
         SELE TPBORC
         IF lGrava
            dbappend()
            cNumero3 := cNumeroAx
         ENDIF
         REPLACE NUMERO    WITH cNumeroAx
         REPLACE CLIENTE   WITH cCliente
         REPLACE OBJETIVO1 WITH cObjetivo1
         REPLACE OBJETIVO2 WITH cObjetivo2
         REPLACE OBJETIVO3 WITH cObjetivo3
         REPLACE MAOOBRA   WITH nMaoObra
         SELE TPBORC2
         FOR K := 1 TO len(aMatMat)
             IF .NOT. empty(aMatMat[k][2])
                dbappend()
                REPLACE numeRo   WITH cNumeroAx
                REPLACE cod_mat  WITH aMatMat[k][1]
                REPLACE material WITH aMatMat[k][2]
                REPLACE unidade  WITH aMatMat[k][3]
                REPLACE qtd_mat  WITH aMatMat[k][4]
                REPLACE val_unit WITH aMaTMat[k][5]
             ENDIF
         NEXT
      ELSE
         SELE TPBORC2 
         SET DELETE OFF
         SET FILTER TO
         RECALL ALL  
         SET DELETE ON
      ENDIF
   ENDIF
   IF ALTER = 1  .OR. (ALTER = 2 .AND. lCGrava) .OR. (lGrava .AND. lCGrava)
      IF confirma("Deseja Imprimir o Orcamento ?")
         mensagem("Verifique a Impressora ! ")
         IF isprinter()
            sombra(11,09,13,44)
            @ 12,10 SAY "Aguarde !! Imprimindo Or‡amento..." Color "W*/N"
            SET CONSOLE OFF
            SET DEVICE TO PRINTER
            nP := 1
            nLp:= 12
            @ 00,00 SAY replicate("=",80)
            @ 01,00 SAY "Pagina No:"+str(np,3,0)
            @ 01,65 SAY "Data:"+dtoc(date())
            cent_imp(02,"*=*=* M E T A    E N G E N H A R I A *=*=*")
            cent_imp(03,"==============================")
            cent_imp(05,"Or‡amento No : "+cNumeroAx)
            @ 07,02 SAY "Cliente : "+cCliente
            @ 08,02 SAY "Objetivo: "+cObjetivo1
            @ 09,12 SAY cObjetivo2
            @ 10,12 SAY cObjetivo3
            SET PRINT ON
            ??chr(14)+chr(15)
            SET PRINT OFF
            @ 11,00 SAY "|Item No    |Descri‡„o"+space(31)+"|Unidade|Quantidade |Valor Unitario |    SubTotal|"
            nSubTot := 0
            FOR l := 1 TO len(aMatMat)
                IF empty(aMatMat[l][2])
                   LOOP
                ENDIF
                @ nLp,0 say "|"+str(l,4,0)+"       |"
                @ nLp,pcol() say aMatMat[l][2]+"|"+aMatMat[l][3]+"     |"
                @ nLp,pcol() say aMatmat[l][4]
                @ nLp,pcol() SAY "    |"
                @ nLp,pcol() SAY aMatMat[l][5] PICT "9,999,999.99"
                @ nLp,pcol() SAY "   |"
                nSubTot+=(aMatMat[l][4]*aMatMat[l][5])
                @ nLp,pcol() SAY aMatMat[l][4]*aMatMat[l][5] PICT "9,999,999.99"
                @ nLp,pcol() SAY "|"
                nLp++
                IF nLp = 60
                   EJECT
                   nLp := 12
                   nP++
                   SET PRINT ON
                   ??CHR(18)+CHR(20)
                   SET PRINT OFF
                   @ 00,00 SAY replicate("=",80)
                   @ 01,00 SAY "Pagina No:"+str(np,3,0)
                   @ 01,65 SAY "Data:"+dtoc(date())
                   cent_imp(02,"*=*=* M E T A    E N G E N H A R I A *=*=*")
                   cent_imp(03,"==============================")
                   cent_imp(05,"Or‡amento:"+cNumeroAx)
                   @ 07,02 SAY "Cliente : "+cCliente
                   @ 08,02 SAY "Objetivo: "+cObjetivo1
                   @ 09,12 SAY cObjetivo2
                   @ 10,12 SAY cObjetivo3
                   SET PRINT ON
                   ??chr(14)+chr(15)
                   SET PRINT OFF
                   @ 11,00 SAY "|Item No    |Descri‡„o"+space(31)+"|Unidade|Quantidade |Valor Unitario |    SubTotal|"
                   nSubTot := 0
                ENDIF
            NEXT
            @ prow()+1,76 SAY "Mao de Obra :"
            @ prow(),pcol() SAY nMaoObra
            @ prow()+1,76 SAY "Materiais...:"
            @ prow(),pcol() SAY nSubtot Pict "9,999,999.99"
            @ prow()+1,84 SAY "Total:"
            @ prow(),pcol() SAY nSubtot+nMaoObra Pict "9,999,999.99"
            SET PRINT ON
            ??CHR(18)+CHR(20)
            SET PRINT OFF
            EJECT
            SET CONSOLE ON
            SET DEVICE TO SCREEN
         ELSE
            Mensagem("Impressora Nao Preparada !!")
         ENDIF
      ENDIF
   ENDIF
   lCont := confirma("Deseja Continuar Fazendo or‡amentos ?")
ENDDO

SELE TPBORC 
PACK

SELE TPBORC2
PACK

CLOSE ALL


* eop tpmtorc