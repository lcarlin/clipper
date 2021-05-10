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
                   IF empty(aMatMat[l][2]
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
               @ nLp+1,60 SAY "Total:"
               @ nLp+1,pcol() SAY nSubtot Pict "9,999,999.99"
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