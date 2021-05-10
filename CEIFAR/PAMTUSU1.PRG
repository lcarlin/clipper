/* bop pamtusu1.prg
  data 11/03/96
  funcao manutencao de usuarias (inclusao/alteracao /excusao/consulta)
  sistema ceifar
  autor  luiz
  linguagem clipper5.2
*/
 
 
#include "INKEY.CH"
   local Local1
   LOCAL nNumUsu := 0
   aFuncoes := {{|| Func001()},;
                {|| Func002()},;
                {|| Func003()},;
                {|| Func004()},;
                {|| Func005()},;
                {|| Func006()},;
                {|| Func007()},;
                {|| Func008()},;
                {|| Func009()},;
                {|| Func010()},;
                {|| Func011()},;
                {|| Func012()},;
                {|| Func013()},;
                {|| Func014()},;
                {|| Func015()},;
                {|| Func016()},;
                {|| Func017()},;
                {|| Func018()},;
                {|| Func019()},;
                {|| Func020()},;
                {|| Func021()},;
                {|| Func022()},;
                {|| Func023()},;
                {|| Func024()},;
                {|| Func025()},;
                {|| Func026()},;
                {|| Func027()},;
                {|| Func028()},;
                {|| Func029()},;
                {|| Func030()}}
   Local1:= .T.
   PUBLIC mopcao:= array(3, 3)
   PUBLIC nSITCONJU    := 1
   PUBLIC nSITCONJ     := 1
   PUBLIC nGRINSTRU    := 1
   PUBLIC cNOMECOMP    := space(40)
   PUBLIC cENDCOMP     := space(40)
   PUBLIC cFONERESCMP  := space(15)
   PUBLIC cFONTRABCMP  := space(15)
   PUBLIC nGRINSTRUCP  := 1
   PUBLIC nNRFILHOS    := 1
   PUBLIC nID_ULT_FIL  := 1
   PUBLIC nINDICACAO   := 1
   PUBLIC dULTMENST    := ctod("  /  /  ")
   PUBLIC nPLANFAMI    := 1
   PUBLIC nPLANFAMIPO  := 1
   PUBLIC nAMAMENTA    := 1
   PUBLIC nP_PART_AMA  := 1
   PUBLIC nABORTO_RES  := 1
   PUBLIC nMENOPAUSA   := 1
   PUBLIC nOVULACAO    := 1
   PUBLIC nCICLOS      := 1
   PUBLIC nPILULAS     := 1
   PUBLIC cNOME_PILU   := space(20)
   PUBLIC cULT_PIL_D   := space(10)
   PUBLIC cMOTIVO_PIL  := space(40)
   PUBLIC cEFEITO_P    := space(40)
   PUBLIC nDIU         := 1
   PUBLIC cMOTIVO_DIU  := space(40)
   PUBLIC cEFEITO_DIU  := space(40)
   PUBLIC cTempo_diu   := space(15)
   PUBLIC nENGR_PIL    := 1
   PUBLIC nENGR_DIU    := 1
   PUBLIC nMART_ANTP   := 1
   PUBLIC nMART_ANTD   := 1
   PUBLIC nMART_ANTC   := 1
   PUBLIC nMART_ANTE   := 1
   PUBLIC nENGR_MART   := 1
   PUBLIC cENG_MARTN   := space(20)
   PUBLIC cENG_MARTT   := space(20)
   PUBLIC cMot_Ovul1   := " "
   PUBLIC cMot_Ovul2   := " "
   PUBLIC cMot_Ovul3   := " "
   PUBLIC nSITUACAO    := 1
   PUBLIC nSITUA_1     := 1
 
   PUBLIC aSimNao  := {{21,30," Sim "},{21,38," N„o "}}
 
   PUBLIC aSitConj :={{21,02,"1-Casada"},{21,12,"2-Solteira"},{21,24,"3-Noiva"} , ;
               {21,33,"4-Divorciada"},{21,47,"5-Viuva"}}
 
   PUBLIC aGrauInst:={{21,02,"1 - Nenhum"},{21,14,"2 - 1§ Grau"}, {21,27,"3 - 2§ Grau"},{21,40,"4 - Superior"}}
 
   PUBLIC aIndica  :={{21,02,"1-Pe. Roberto"},{21,17,"2-Palestra"},{21,29,"3-Curso de Noivos"},;
               {21,48,"4-Medico"},{21,58,"5-Outros"}}
 
   PUBLIC aMetodo  :={{21,02,"1 - Ritmo"},{21,13,"2 - Temperatura"},{21,30,"3 - Metodo da Ovula‡„o"}}
 
   PUBLIC aCiclos  :={{21,01,"1-Normal(25 a 35 dias)"},{21,25,"2-Curtos(Menos de 26 dias)"},;
               {21,53,"3-Longos(Mais de 35 dias)"}}
 
   PUBLIC aSituacao :={{21,02,"1 - Ativa"},{21,14,"2 - Inativa"}}
 
   PUBLIC aSit1 := {{21,02,"1-EV"}, {21,08,"2 - PE"}, {21,16,"3-AM"}, {21,22,"4-NA"},;
                  {21,28,"5-UR"}, {21,34,"6-TE"}, {21,40,"7-CF"}, {21,46,"8-NA/EV"},;
                  {21,56,"9-AM/EV"}}
 
   PUBLIC aSit2 := {{21,02,"1 - GP"}, {21,10,"2 - GNP"}, {21,19,"3 - PA"}, {21,27,"4 - TS"},;
                  {21,35,"5 - AV"}, {21,43,"6 - S"}}
   PUBLIC aVetAlte := {"Situa‡„o Conjugal","Grau de Instru‡„o","Dados do Companheiro", ;
                "N§ de Filhos","Idade do Ultimo Filho","Indica‡„o","Data da Ultima Menst." ,;
                "J  usou o Planejamento Familiar","Metodo Utilizado","Esta Amamamentando", ;
                "Amamentou depois do Parto","Abortou recentemente","Esta em Periodo Pr‚ menopausico", ;
                "Deseja Usar o Metodo da Ovula‡„o","Dura‡„o dos Ciclos","Utilizou Pilulas","Dados da Pilula", ;
                "Utilizou D.I.U.","Dados do D.I.U.","Engravidou durante Uso de Pilulas", ;
                "Engravidou durante Uso de D.I.U.","Utilizou Preservativos","Utilizou Diafragma", ;
                "Utilizou Coito Interrompido","Utilizou Metodo da Espuma","Engravidou durante Eles " ,;
                "Dados do Metodo ineficiente","Motivos p/ aprender a Ovula‡„o","Situa‡„o","Grupo"}
 
   USE pabinst  INDEX paiinst1, paiinst2 NEW
   USE pabusua1 INDEX paiusu1, paiusu2 NEW
   @  8,  8 SAY "Codigo............:"
   @  9,  8 SAY "Nome..............:"
   @ 10,  8 SAY "Data de Nascimento:"
   @ 11,  8 SAY "Data de Inscri‡„o.:"
   @ 12,  8 SAY "Procedencia.......:"
   @ 13,  8 SAY "Cidade onde Mora..:"
   @ 14,  8 SAY "Endere‡o..........:"
   @ 15,  8 SAY "Fone do Trabalho..:"
   @ 16,  8 SAY "Fone da Residencia:"
   @ 17,  8 SAY "Instrutora........:"
   @ 18,  8 SAY "Numero de Usuarias:"
   save screen to stela1
   corcli:= SetColor()
 
   mopcao:= {{12, 20, "Alterar"}, {12, 29, "Excluir"}, {12, 38, ;
      "Voltar"}}
 
   nNumUsu := LastRec()
   do while (Local1)
      sele pabusua1
      restore screen from stela1
      setcolor(corcli)
      cCod:= Space(5)
      lInclui := lDados := .F.
      alter:= 0
      @ 18, 28 SAY nNumUsu PICT "9999"
      @  8, 28 GET cCod PICTURE "@!"
      read
      if (Empty(ccod) .AND. LastKey() = K_ENTER)
         set order to 2
         nproc:= tabela()
         ccod:= codigo
         if (Empty(nproc)) .OR. (empty(cCod))
            loop
         endif
         @ 08,28 GET cCod PICTURE "@!"
         clear GETs
      elseif (Empty(ccod) .AND. LastKey() = K_ESC)
         exit
      endif
      set order to 1
      set color to (corcli)
      seek ccod
      if (!Found())
         linclui:= confirma("Usu ria n„o cadastrada! Deseja Cadastrar ?",cCorDialog)
         IF lInclui
            cNome   := Space(40)
            dDataNasc := dDataIni := ctod("  /  /  ")
            cEnde  := Space(40)
            cFoneRes := cFoneTrab := Space(16)
            cCodInst := space(05)
            cprocede := cCidade := space(35)
         ENDIF
      else
         @  9, 28 SAY nome       PICTURE "@!"
         @ 10, 28 SAY DatNasc    Picture "99/99/99"
         @ 11, 28 SAY DatInsc    PICTURE "99/99/99"
         @ 12, 28 SAY procede     PICTURE "@!"
         @ 13, 28 SAY CidRes     PICTURE "@!"
         @ 14, 28 SAY Endereco   PICTURE "@!"
         @ 15, 28 SAY FoneTrab   PICTURE "@!"
         @ 16, 28 SAY Foneres    PICTURE "@!"
         @ 17, 28 SAY instrutora PICTURE "@!"
         InKey(5)
         save screen to stela_ant
         setcolor(cCorDialog)
         sombra(10, 18, 14, 46)
         @ 11, 20 SAY "Codigo Existente:"
         alter:= botao(mopcao,,cCorbin,cCorBat)
         set color to (corcli)
         restore screen from stela_ant
         if (alter == 2)
            if (confirma("Deseja REALMENTE Excluir o Registro ?",cCorDialog))
               delete
               nNUmUsu--
               COMMIT
            endif
         elseif (alter = 3 .OR. alter = 0)
            loop
         ELSE
           cnome     := nome
           dDAtaNasc := datnasc
           dDataIni  := datinsc
           cEnde     := endereco
           cFoneTrab := fonetrab
           cFoneRes  := foneres
           cprocede   := procede
           cCidade   := Cidres
           cCodInst  := instrutora
         endif
      endif
 
      if (linclui) .OR. (alter = 1)
         @  9, 28 GET cNome       PICTURE "@!"
         @ 10, 28 GET dDataNasc   Picture "99/99/99"
         @ 11, 28 GET dDataIni    PICTURE "99/99/99"
         @ 12, 28 GET cprocede    PICTURE "@!"
         @ 13, 28 GET cCidade     PICTURE "@!"
         @ 14, 28 GET cEnde       PICTURE "@!"
         @ 15, 28 GET cFoneTrab   PICTURE "@!"
         @ 16, 28 GET cFoneres    PICTURE "@!"
         READ
         @ 17, 28 GET cCodinst    PICTURE "@!"
         read
         nSITCONJU    := if(lInclui,1,SITCONJU)
         nGRINSTRU    := if(lInclui,1,GRINSTRU)
         cNOMECOMP    := if(lInclui,space(40),NOMECOMP)
         cENDCOMP     := if(lInclui,space(40),ENDCOMP)
         cFONERESCMP  := if(lInclui,space(15),FONERESCMP)
         cFONTRABCMP  := if(lInclui,space(15),FONTRABCMP)
         nGRINSTRUCP  := if(lInclui,1,GRINSTRUCP)
         nNRFILHOS    := if(lInclui,1,NRFILHOS)
         nID_ULT_FIL  := if(lInclui,1,ID_ULT_FIL)
         nINDICACAO   := if(lInclui,1,INDICACAO)
         dULTMENST    := if(lInclui,ctod("  /  /  "),ULTMENST)
         nPLANFAMI    := if(lInclui,1,PLANFAMI)
         nPLANFAMIPO  := if(lInclui,1,PLANFAMIPO)
         nAMAMENTA    := if(lInclui,1,AMAMENTA)
         nP_PART_AMA  := if(lInclui,1,P_PART_AMA)
         nABORTO_RES  := if(lInclui,1,ABORTO_RES)
         nMENOPAUSA   := if(lInclui,1,MENOPAUSA)
         nOVULACAO    := if(lInclui,1,OVULACAO)
         nCICLOS      := if(lInclui,1,CICLOS)
         nPILULAS     := if(lInclui,1,PILULAS)
         cNOME_PILU   := if(lInclui,space(20),NOME_PILU)
         cULT_PIL_D   := if(lInclui,space(10),ULT_PIL_D)
         cMOTIVO_PIL  := if(lInclui,space(40),MOTIVO_PIL)
         cEFEITO_P    := if(lInclui,space(40),EFEITO_P)
         nDIU         := if(lInclui,1,DIU)
         cMOTIVO_DIU  := if(lInclui,space(40),MOTIVO_DIU)
         cEFEITO_DIU  := if(lInclui,space(40),EFEITO_DIU)
         cTempo_diu   := if(lInclui,space(15),TEMPO_DIU)
         nENGR_PIL    := if(lInclui,1,ENGR_PIL)
         nENGR_DIU    := if(lInclui,1,ENGR_DIU)
         nMART_ANTP   := if(lInclui,1,MART_ANT_P)
         nMART_ANTD   := if(lInclui,1,MART_ANT_D)
         nMART_ANTC   := if(lInclui,1,MART_ANT_C)
         nMART_ANTE   := if(lInclui,1,MART_ANT_E)
         nENGR_MART   := if(lInclui,1,ENGR_MART)
         cENG_MARTN   := if(lInclui,space(20),ENG_MART_N)
         cENG_MARTT   := if(lInclui,space(20),ENG_MART_T)
         cMot_Ovul1  := if(lInclui," ",MOT_OVOLU1)
         cMot_Ovul2  := if(lInclui," ",MOT_OVOLU2)
         cMot_Ovul3  := if(lInclui," ",MOT_OVOLU3)
         nSITUACAO   := 1
         nSITUA_1    := 1
         SELE PABINST
         if (Empty(ccodiNST) .AND. LastKey() = K_ENTER)
            set order to 2
            nproc:= tabela()
            ccodInst := codigo
            if (Empty(nproc)) .OR. (empty(cCodInst))
               loop
            endif
            @ 17,28 GET cCodInst PICTURE "@!"
            clear GETs
         elseif (Empty(ccodInst) .AND. LastKey() = K_ESC)
            exit
         endif
         SET ORDER TO 1
         IF .NOT. dbseek(cCodInst)
            mensagem("Instrutora N„o cadastrada !!!",cCorDialog)
            LOOP
         ENDIF
         @ 17,33 SAY NOME
         inkey(5)
 
         SELE PABUSUA1
         lDados := confirma("Deseja preencher os dados complementares ?",cCorDialog)
         IF lDados .AND. lInclui
            @ 05,01 CLEAR TO 22,78
            @ 05,26 SAY "Dados complementares da Usu ria"
 
 
            @ 06,02 SAY "Situacao Conjugal:" + aSitConj[nSitConju][3]+"        "
            nSitConj := escolhe(aSitConj)
            IF nSitConj = 0
               LOOP
            ENDIF
            @ 06,02 SAY "Situacao Conjugal:" +aSitConj[nSitConj][3]+"        "
 
            @ 07,02 SAY "Grau de Instrucao:"+aGrauInst[nGrInstru][3]+"        "
            nGrInstru := escolhe(aGrauInst)
            IF nGrinstru = 0
               LOOP
            ENDIF
            @ 07,02 SAY "Grau de Instrucao:"+aGrauInst[nGrInstru][3]+"        "
 
            @ 08,02 SAY "Nome do Companheiro:" GET cNomecomp   PICT "@!"
            @ 09,02 SAY "Endereco...........:" GET cEndComp    PICT "@!"
            @ 10,02 SAY "Fone da Residencia.:" GET cFoneresCmp PICT "@!"
            @ 11,02 SAY "Fone do Trabalho...:" GET cFonTrabCmp PICT "@!"
            READ
 
            @ 12,02 SAY "Grau de Instrucao..:"+aGrauInst[nGrInstruCp][3]+"        "
            nGrInstruCp := escolhe(aGrauInst)
            IF nGrinstruCp = 0
               LOOP
            ENDIF
            @ 12,02 SAY "Grau de Instrucao:"+aGrauInst[nGrInstruCp][3]+"        "
 
            @ 13,02 SAY "Numero de Filhos:" GET nNrFilhos PICT "99"
            @ 13,col()+2 SAY "Idade do Ultimo Filho:" GET nId_Ult_Fil PICT "99"
            READ
 
            @ 14,02 SAY "Indicada Por:" +aIndica[nIndicacao][3]+"        "
            nIndicacao := escolhe(aIndica)
            IF nIndicacao = 0
               LOOP
            ENDIF
            @ 14,02 SAY "Indicado Por:"+aIndica[nIndicacao][3]+"        "
 
            @ 15,02 SAY "Data da Ultima Menstrua‡„o:" GET dUltMenst  PICT "99/99/99"
            READ
 
            @ 16,02 SAY "Ja usou o metodo de planejamento familiar?"+aSimNao[nPlanFami][3]+"        "
            nPlanFami := escolhe(aSimNao)
            IF nPlanFami = 0
               LOOP
            ENDIF
            @ 16,02 SAY "Ja usou o metodo de planejamento familiar?"+aSimNao[nPlanFami][3]+"        "
 
            IF nPlanFami = 1
               @ 17,02 SAY "Qual o Metodo Utilizado?"+aMetodo[nPlanFamipo][3]+"        "
               nPlanFamipo := escolhe(aMetodo)
               IF nPlanfamiPo = 0
                  LOOP
               ENDIF
               @ 17,02 SAY "Qual o Metodo Utilizado?"+aMetodo[nPlanFamipo][3]+"        "
            ENDIF
 
            @ 18,02 SAY "Esta Amamanetando ?"+aSimNao[nAmamenta][3]+"        "
            nAmamenta := escolhe(aSimNao)
            IF nAmamenta = 0
               LOOP
            ENDIF
            @ 18,02 SAY "Esta Amamanetando ?"+aSimNao[nAmamenta][3]+"        "
 
            @ 19,02 SAY "Amamentou depois do Parto?"+aSimNao[nP_Part_ama][3]+"        "
            nP_Part_ama := escolhe(aSimNao)
            IF nP_Part_ama  = 0
               LOOP
            ENDIF
            @ 19,02 SAY "Amamentou depois do Parto?"+aSimNao[nP_Part_ama][3]+"        "
 
 
            @ 20,02 SAY "Abortou recentemente ?"+aSimNao[nAborto_res][3]+"        "
            nAborto_Res := escolhe(aSimNao)
            IF nAborto_res = 0
               LOOP
            ENDIF
            @ 20,02 SAY "Abortou recentemente ?"+aSimNao[nAborto_res][3]+"        "
            inkey(3)
 
            @  06,01 CLEAR TO 22,78
 
            @ 06,02 SAY "Esta em periodo Pre menopausico ?"+aSimNao[nMenoPausa][3]+"        "
            nMenopausa := escolhe(aSimNao)
            IF nMenoPausa = 0
               LOOP
            ENDIF
            @ 06,02 SAY "Esta em periodo Pre menopausico ?"+aSimNao[nMenoPausa][3]+"        "
 
            @ 07,02 SAY "Deseja usar o metodo da Ovula‡„o ?"+aSimNao[nOvulacao][3]+"        "
            nOvulacao := escolhe(aSimNao)
            IF nOvulacao  = 0
               LOOP
            ENDIF
            @ 07,02 SAY "Deseja usar o metodo da Ovula‡„o ?"+aSimNao[nOvulacao][3]+"        "
 
            @ 08,02 SAY "Dura‡ao dos Ciclos :"+aCiclos[nCiclos][3]+"        "
            nCiclos := escolhe(aCiclos)
            IF nCiclos = 0
               LOOP
            ENDIF
            @ 08,02 SAY "Dura‡ao dos Ciclos :"+aCiclos[nCiclos][3]+"        "
 
            @ 09,02 SAY "Metodos Artificiais Utilizados :"
 
            @ 10,02 SAY "Pilulas Anti-Concepcionais?"+aSimNao[nPilulas][3]+"        "
            nPilulas := escolhe(aSimNao)
            IF nPilulas = 0
               LOOP
            ENDIF
            @ 10,02 SAY "Pilulas Anti-Concepcionais?"+aSimNao[nPilulas][3]+"        "
            IF nPilulas = 1
               @ 11,02 SAY "Nomes e Tipos Usados:"  GET cNome_Pilu PICT "@!"
               @ 12,02 SAY "Quando deixou de Usar:" GET cUlt_Pil_D PICT "@!"
               @ 13,02 SAY "Motivo para interrormper a pilula:" GET cMotivo_PiL PICT "@!"
               @ 14,02 SAY "Descreva os efeitos Colaterais:" GET cEfeito_P PICT "@!"
               READ
            ENDIF
            @ 15,02 SAY "Dispositivos Intra-Uterinos?"+aSimNao[nDIU][3]+"        "
            nDiu  := escolhe(aSimNao)
            IF nDiu = 0
               LOOP
            ENDIF
            @ 15,02 SAY "Dispositivos Intra-Uterinos?"+aSimNao[nDIU][3]+"        "
            IF nDiu = 1
               @ 16,02 SAY "Tempo que utilizou " GET cTempo_diu PICT "@!"
               @ 17,02 SAY "Motivo pelo qual deixou o DIU:" GET cMotivo_DIU PICT "@!"
               @ 18,02 SAY "Descreva os efeitos Colaterais:" GET cEfeito_DIU PICT "@!"
               READ
            ENDIF
            @ 19,02 SAY "Engravidou durante o use de:"
            nCol := col()
            @ 19,nCol SAY "Pilulas:"+aSimNao[nEngr_Pil][3]+"        "
            nEngr_Pil := escolhe(aSimNao)
            IF nEngr_Pil = 0
               LOOP
            ENDIF
            @ 19,nCOl SAY "Pilulas:"+aSimNao[nEngr_PIL][3]+"        "
 
            @ 20,nCol SAY "DIU....:"+aSimNao[nEngr_Diu][3]+"        "
            nEngr_diu := escolhe(aSimNao)
            IF nEngr_diu = 0
               LOOP
            ENDIF
            @ 20,nCOl SAY "DIU....:"+aSimNao[nEngr_DIU][3]+"        "
 
            inkey(2)
 
            @ 06,01 CLEAR TO 22,78
 
            @ 07,02 SAY "Utilizou outros Metodos Artificiais:"
            nCol := col()+2
            @ 07,nCol SAY "Preservativos:"+aSimNao[nMart_antp][3]+"        "
            nMart_antp := escolhe(aSimNao)
            IF nMart_AntP = 0
               LOOP
            ENDIF
            @ 07,nCOl SAY "Preservativos:"+aSimNao[nMart_AntP][3]+"        "
 
            @ 08,nCol SAY "Diafragma....:"+aSimNao[nMart_antd][3]+"        "
            nMart_antd := escolhe(aSimNao)
            IF nMart_Antd = 0
               LOOP
            ENDIF
            @ 08,nCOl SAY "Diafragma....:"+aSimNao[nMart_antd][3]+"        "
 
            @ 09,nCol SAY "Coito Inter. :"+aSimNao[nMart_antc][3]+"        "
            nMart_antc := escolhe(aSimNao)
            IF nMart_Antc = 0
               LOOP
            ENDIF
            @ 09,nCOl SAY "Coito Inter. :"+aSimNao[nMart_antc][3]+"        "
 
            @ 10,nCol SAY "Espuma...... :"+aSimNao[nMart_ante][3]+"        "
            nMart_ante := escolhe(aSimNao)
            IF nMart_Ante = 0
               LOOP
            ENDIF
            @ 10,nCOl SAY "Espuma...... :"+aSimNao[nMart_ante][3]+"        "
 
            @ 11,02 SAY "Engravidou enquanto utilizava algum metodo:"+aSimNao[nEngr_Mart][3]+"        "
            nEngr_Mart:= escolhe(aSimNao)
            IF nEngr_Mart = 0
               LOOP
            ENDIF
            @ 11,02 SAY "Engravidou enquanto utilizava algum metodo:"+aSimNao[nEngr_Mart][3]+"        "
 
            IF nEngr_mart = 1
               @ 12,02 SAY "Nome do Metodo.:" GET cEng_MartN PICT "@!"
               @ 13,02 SAY "Tempo Utilizado:" GET cEng_MartT PICT "@!"
               READ
            ENDIF
            @ 14,02 SAY "Motivo para aprender o metodo da ovulacao:"
            @ 15,02 SAY "Adquirir conhecimento das funcoes do corpo:" ;
             GET cMot_Ovul1 PICT "!"  VALID cMot_Ovul1 $"SN"
            @ 16,02 SAY "Evitar uma Gravidez:" ;
             GET cMot_Ovul2 PICT "!"  VALID cMot_Ovul2 $ "SN"
            @ 17,02 SAY "Conseguir uma Gravidez:" ;
             GET cMot_Ovul3 PICT "!"  VALID cMot_Ovul3 $ "SN"
            READ
 
            @ 18,02 SAY "Situacao da Usuaria:"+aSituacao[nSituacao][3]+"        "
            nSituacao := escolhe( aSituacao )
            IF nSituacao = 0
               LOOP
            ENDIF
            @ 18,02 SAY "Situacao da Usuaria:"+aSituacao[nSituacao][3]+"        "
 
            IF nSituacao = 1
               IF nsitua_1 > Len(aSit1)
                  nSitua_1 := 1
               endif
               @ 19,02 SAY "Situacao :"+aSit1[nSitua_1][3]+"        "
               nSitua_1:= escolhe(aSit1)
               IF nSitua_1 = 0
                  LOOP
               ENDIF
               @ 19,02 SAY "Situacao :"+aSit1[nSitua_1][3]+"        "
            ELSE
               IF nsitua_1 > Len(aSit2)
                  nSitua_1 := 1
               endif
               @ 19,02 SAY "Situacao :"+aSit2[nSitua_1][3]+"        "
               nSitua_1:= escolhe(aSit2)
               IF nSitua_1 = 0
                  LOOP
               ENDIF
               @ 19,02 SAY "Situacao :"+aSit2[nSitua_1][3]+"        "
            ENDIF
         ELSEIF lDados .AND. (.NOT. lInclui)
            @ 06,01 CLEAR TO 22,78
            nInicio := 1
            DO WHILE Lastkey() <> 27
               sTelaTmp := savescreen(00,00,MaxRow(),MaxCol())
               nEscolha := Achoice(07,02,18,35,aVetAlte,,"Func000",nInicio)
               nInicio := nEscolha
               IF nEscolha <> 0
                  eval(aFuncoes[nEscolha] )
               ENDIF
               RestScreen(00,00,maxRow(),MaxCol(),sTelaTmp)
            ENDDO
         ENDIF
         if (confirma("Os Dados Estao Corretos",cCorDialog))
            if (linclui)
               dbappend()
               nNumUsu++
            endif
            REPLACE codigo     WITH ccod
            REPLACE nome       WITH cnome
            REPLACE datinsc    WITH dDataIni
            REPLACE datnasc    WITH dDataNasc
            REPLACE foneres    WITH cFoneres
            REPLACE endereco   WITH cende
            REPLACE fonetrab   WITH cFoneTrab
            REPLACE instrutora WITH cCodInst
            REPLACE CIDRES     WITH cCidade
            REPLACE procede    WITH cprocede
          *  IF lDados
               REPLACE   SITCONJU      WITH  if(nSITCONJU=0,1,nSitConju)
               REPLACE   GRINSTRU      WITH  if(nGRINSTRU=0,1,nGrinstru)
               REPLACE   NOMECOMP      WITH  cNOMECOMP
               REPLACE   ENDCOMP       WITH  cENDCOMP
               REPLACE   FONERESCMP    WITH  cFONERESCMP
               REPLACE   FONTRABCMP    WITH  cFONTRABCMP
               REPLACE   GRINSTRUCP    WITH  if(nGRINSTRUCP=0,1,nGrInstruCp)
               REPLACE   NRFILHOS      WITH  if(nNRFILHOS=0,1,nNrFilhos)
               REPLACE   ID_ULT_FIL    WITH  if(nID_ULT_FIL=0,1,nId_Ult_fil)
               REPLACE   INDICACAO     WITH  if(nINDICACAO=0,1,nIndicacao)
               REPLACE   ULTMENST      WITH  dULTMENST
               REPLACE   PLANFAMI      WITH  if(nPLANFAMI=0,1,nPlanFami)
               REPLACE   PLANFAMIPO    WITH  if(nPLANFAMIPO=0,1,nPlanFamipo)
               REPLACE   AMAMENTA      WITH  if(nAMAMENTA=0,1,nAmamenta)
               REPLACE   P_PART_AMA    WITH  if(nP_PART_AMA=0,1,nP_Part_ama)
               REPLACE   ABORTO_RES    WITH  if(nABORTO_RES=0,1,nAborto_res)
               REPLACE   MENOPAUSA     WITH  if(nMENOPAUSA=0,1,nMenopausa)
               REPLACE   OVULACAO      WITH  if(nOVULACAO=0,1,nOvulacao)
               REPLACE   CICLOS        WITH  if(nCICLOS=0,1,nCiclos)
               REPLACE   PILULAS       WITH  if(nPILULAS=0,1,nPilulas)
               REPLACE   NOME_PILU     WITH  cNOME_PILU
               REPLACE   ULT_PIL_D     WITH  cULT_PIL_D
               REPLACE   MOTIVO_PIL    WITH  cMOTIVO_PIL
               REPLACE   EFEITO_P      WITH  cEFEITO_P
               REPLACE   DIU           WITH  if(nDIU=0,1,nDiu)
               REPLACE   MOTIVO_DIU    WITH  MOTIVO_DIU
               REPLACE   EFEITO_DIU    WITH  cEFEITO_DIU
               REPLACE   TEMPO_DIU     WITH  cTempo_diu
               REPLACE   ENGR_PIL      WITH  if(nENGR_PIL=0,1,nEngr_pil)
               REPLACE   ENGR_DIU      WITH  if(nENGR_DIU=0,1,nEngr_diu)
               REPLACE   MART_ANT_P    WITH  if(nMART_ANTP=0,1,nMart_antp)
               REPLACE   MART_ANT_D    WITH  if(nMART_ANTD=0,1,nMart_antd)
               REPLACE   MART_ANT_C    WITH  if(nMART_ANTC=0,1,nMart_antc)
               REPLACE   MART_ANT_E    WITH  if(nMART_ANTE=0,1,nMart_ante)
               REPLACE   ENGR_MART     WITH  if(nENGR_MART=0,1,nEngr_mart)
               REPLACE   ENG_MART_N    WITH  cENG_MARTN
               REPLACE   ENG_MART_T    WITH  cENG_MARTT
               REPLACE   MOT_OVOLU1    WITH  cMOT_ovul1
               REPLACE   MOT_OVOLU2    WITH  cMOT_ovul2
               REPLACE   MOT_OVOLU3    WITH  cMOT_ovul3
               REPLACE   SITUACAO      WITH  if(nSITUACAO=0,1,nSituacao)
               REPLACE   SITUA_1       WITH  if(nSITUA_1=0,1,nSitua_1)
        *    ENDIF
            COMMIT
         endif
      endif
      Local1:= confirma("Deseja Continuar na Manuten‡„o de Usu rias?",cCorDialog)
      RESTORE SCREEN FROM sTela1
   enddo
   release all
   PACK
   close databases
   select 1
   close format
 
   return
 
***********************************
FUNCTION escolhe ( aVetor )
sTelaUsua := savescreen(20,00,24,79)
nRet := Botao( aVetor,, cCorbin, cCorBat)
RestScreen(20,00,24,79,sTelaUsua)
RETURN nRet
 
***********************
FUNCTION func000 ( nModo, nElto, nPos )
DO CASE
   CASE nModo = 3
        IF Lastkey() = 27
           Return 0
        ELSEIF Lastkey() = 13
           RETURN 1
        ENDIF
        RETURN 2
   CASE nModo = 2
        Tone(250,1)
        RETURN 2
   CASE nModo = 1
        Tone(150,1)
        RETURN 2
   OTHERWISE
         RETURN 2
ENDCASE
***********************
function func001 ()
@ 20,02 SAY "Situacao Conjugal:" + aSitConj[nSitConju][3]+"        "
xTemp := nSitConju
nSitConju := escolhe(aSitConj)
IF nSitConju = 0
   nSitConju := xTemp
ENDIF
@ 20,02 SAY "Situacao Conjugal:" +aSitConj[nSitConju][3]+"        "
 
*******************************
FUNCTION func002()
@ 20,02 SAY "Grau de Instrucao:"+aGrauInst[nGrInstru][3]+"        "
xTemp := nGrInstru
nGrInstru := escolhe(aGrauInst)
IF nGrinstru = 0
   nGrInstru := xTemp
ENDIF
@ 20,02 SAY "Grau de Instrucao:"+aGrauInst[nGrInstru][3]+"        "
 
***********************************
FUNCTION func003()
@ 08,35 SAY "Nome do Companheiro:"
@ 09,35 GET cNomecomp   PICT "@!"
@ 10,35 SAY "Endereco...........:"
@ 11,35 GET cEndComp    PICT "@!"
@ 12,35 SAY "Fone da Residencia.:"
@ 13,35 GET cFoneresCmp PICT "@!"
@ 14,35 SAY "Fone do Trabalho...:"
@ 15,35 GET cFonTrabCmp PICT "@!"
 
READ
@ 20,02 SAY "Grau de Instrucao..:"+aGrauInst[nGrInstruCp][3]+"        "
xTemp := nGrInstruCp
nGrInstruCp := escolhe(aGrauInst)
IF nGrinstruCp = 0
   nGrInstruCp := xTemp
ENDIF
@ 20,02 SAY "Grau de Instrucao:"+aGrauInst[nGrInstruCp][3]+"        "
 
**************************************
FUNCTION func004()
@ 20,02 SAY "Numero de Filhos:" GET nNrFilhos PICT "99"
READ
 
***************************************
FUNCTION func005()
@ 20,02 SAY "Idade do Ultimo Filho:" GET nId_Ult_Fil PICT "99"
READ
 
************************************
FUNCTION func006()
@ 20,02 SAY "Indicada Por:" +aIndica[nIndicacao][3]+"        "
xTemp := nIndicacao
nIndicacao := escolhe(aIndica)
IF nIndicacao = 0
   nIndicacao := xTemp
ENDIF
@ 20,02 SAY "Indicado Por:"+aIndica[nIndicacao][3]+"        "
 
****************************************
FUNCTION func007()
@ 20,02 SAY "Data da Ultima Menstrua‡„o:" GET dUltMenst  PICT "99/99/99"
READ
 
****************************
FUNCTION func008()
@ 20,02 SAY "Ja usou o metodo de planejamento familiar?"+aSimNao[nPlanFami][3]+"        "
xTemp := nPlanFami
nPlanFami := escolhe(aSimNao)
IF nPlanFami = 0
   nPlanFami := xTemp
ENDIF
@ 20,02 SAY "Ja usou o metodo de planejamento familiar?"+aSimNao[nPlanFami][3]+"        "
 
***************************
FUNCTION func009()
IF nPlanFami = 1
   @ 20,02 SAY "Qual o Metodo Utilizado?"+aMetodo[nPlanFamipo][3]+"        "
   xTemp := nPlanfamiPo
   nPlanFamipo := escolhe(aMetodo)
   IF nPlanfamiPo = 0
      nPlanFamipo := xTemp
   ENDIF
   @ 20,02 SAY "Qual o Metodo Utilizado?"+aMetodo[nPlanFamipo][3]+"        "
ENDIF
 
********************************
FUNCTION func010()
@ 20,02 SAY "Esta Amamanetando ?"+aSimNao[nAmamenta][3]+"        "
xTemp := nAmamenta
nAmamenta := escolhe(aSimNao)
IF nAmamenta = 0
   nAmamenta := xTemp
ENDIF
@ 20,02 SAY "Esta Amamanetando ?"+aSimNao[nAmamenta][3]+"        "
 
***********************************
FUNCTION func011()
@ 20,02 SAY "Amamentou depois do Parto?"+aSimNao[nP_Part_ama][3]+"        "
xTemp := nP_Part_ama
nP_Part_ama := escolhe(aSimNao)
IF nP_Part_ama  = 0
   nP_Part_ama := xTemp
ENDIF
@ 20,02 SAY "Amamentou depois do Parto?"+aSimNao[nP_Part_ama][3]+"        "
 
*****************************
FUNCTION func012()
@ 20,02 SAY "Abortou recentemente ?"+aSimNao[nAborto_res][3]+"        "
xTemp := nAborto_res
nAborto_Res := escolhe(aSimNao)
IF nAborto_res = 0
   nAborto_res := xTemp
ENDIF
@ 20,02 SAY "Abortou recentemente ?"+aSimNao[nAborto_res][3]+"        "
 
**************************************
FUNCTION func013()
@ 20,02 SAY "Esta em periodo Pre menopausico ?"+aSimNao[nMenoPausa][3]+"        "
xTemp := nMenopausa
nMenopausa := escolhe(aSimNao)
IF nMenoPausa = 0
   nMenopausa := xTemp
ENDIF
@ 20,02 SAY "Esta em periodo Pre menopausico ?"+aSimNao[nMenoPausa][3]+"        "
 
***************************
FUNCTION func014()
@ 20,02 SAY "Deseja usar o metodo da Ovula‡„o ?"+aSimNao[nOvulacao][3]+"        "
xTemp  := nOvulacao
nOvulacao := escolhe(aSimNao)
IF nOvulacao  = 0
   nOvulacao := xTemp
ENDIF
@ 20,02 SAY "Deseja usar o metodo da Ovula‡„o ?"+aSimNao[nOvulacao][3]+"        "
 
**********************************
FUNCTION func015()
@ 20,02 SAY "Dura‡ao dos Ciclos :"+aCiclos[nCiclos][3]+"        "
xTemp  := nCiclos
nCiclos := escolhe(aCiclos)
IF nCiclos = 0
   nCiclos := xTemp
ENDIF
@ 20,02 SAY "Dura‡ao dos Ciclos :"+aCiclos[nCiclos][3]+"        "
 
************************************
FUNCTION func016()
@ 20,02 SAY "Utilizou Pilulas Anti-Concepcionais?"+aSimNao[nPilulas][3]+"        "
xTemp := nPilulas
nPilulas := escolhe(aSimNao)
IF nPilulas = 0
   nPilulas := xTemp
ENDIF
@ 20,02 SAY "Utilizou Pilulas Anti-Concepcionais?"+aSimNao[nPilulas][3]+"        "
 
**********************************
FUNCTION func017()
IF nPilulas = 1
   @ 11,35 SAY "Nomes e Tipos Usados:"
   @ 12,35 GET cNome_Pilu PICT "@!"
   @ 13,35 SAY "Quando deixou de Usar:"
   @ 14,35 GET cUlt_Pil_D PICT "@!"
   @ 15,35 SAY "Motivo para interrormper a pilula:"
   @ 16,35 GET cMotivo_PiL PICT "@!"
   @ 17,35 SAY "Descreva os efeitos Colaterais:"
   @ 18,35 GET cEfeito_P PICT "@!"
   READ
ENDIF
 
************************************
FUNCTION func018()
@ 20,02 SAY "Utilizou Dispositivos Intra-Uterinos?"+aSimNao[nDIU][3]+"        "
xTemp := nDiu
nDiu  := escolhe(aSimNao)
IF nDiu = 0
   nDiu := xTemp
ENDIF
@ 20,02 SAY "Utilizou Dispositivos Intra-Uterinos?"+aSimNao[nDIU][3]+"        "
 
***************************
FUNCTION func019()
IF nDiu = 1
   @ 14,35 SAY "Tempo que utilizou "
   @ 15,35 GET cTempo_diu PICT "@!"
   @ 16,35 SAY "Motivo pelo qual deixou o DIU:"
   @ 17,35 GET cMotivo_DIU PICT "@!"
   @ 18,35 SAY "Descreva os efeitos Colaterais:"
   @ 19,35 GET cEfeito_DIU PICT "@!"
   READ
ENDIF
 
***************************
FUNCTION func020()
@ 20,02 SAY "Engravidou durante o use de Pilulas:"+aSimNao[nEngr_Pil][3]+"        "
xTemp := nEngr_pil
nEngr_Pil := escolhe(aSimNao)
IF nEngr_Pil = 0
   nEngr_Pil := xTemp
ENDIF
@ 20,02 SAY "Engravidou durante o use de Pilulas:"+aSimNao[nEngr_Pil][3]+"        "
 
*****************************************
FUNCTION func021()
@ 20,02 SAY "Engravidou durante o use de D.I.U.:"+aSimNao[nEngr_DIU][3]+"        "
xTemp := nEngr_Diu
nEngr_diu := escolhe(aSimNao)
IF nEngr_diu = 0
   nEngr_diu := xTemp
ENDIF
@ 20,02 SAY "Engravidou durante o use de D.I.U.:"+aSimNao[nEngr_DIU][3]+"        "
 
***********************************
FUNCTION func022()
@ 20,02 SAY "Utilizou Preservativos:"+aSimNao[nMart_antp][3]+"        "
xTemp := nMart_antp
nMart_antp := escolhe(aSimNao)
IF nMart_AntP = 0
   nMart_antp := xTemp
ENDIF
@ 20,02 SAY "Utilizou Preservativos:"+aSimNao[nMart_AntP][3]+"        "
 
************************************
FUNCTION func023()
@ 20,02 SAY "Utilizou Diafragma:"+aSimNao[nMart_antd][3]+"        "
xTemp := nMart_antd
nMart_antd := escolhe(aSimNao)
IF nMart_Antd = 0
   nMart_antd := xTemp
ENDIF
@ 20,02 SAY "Utilizou Diafragma:"+aSimNao[nMart_antd][3]+"        "
 
*********************************************
FUNCTION func024()
@ 20,02 SAY "Coito Interrompido:"+aSimNao[nMart_antc][3]+"        "
xTemp := nMart_antc
nMart_antc := escolhe(aSimNao)
IF nMart_Antc = 0
   nMart_antc := xTemp
ENDIF
@ 20,02 SAY "Coito Interrompido:"+aSimNao[nMart_antc][3]+"        "
 
**********************************************
FUNCTION func025()
@ 20,02 SAY "Espuma...... :"+aSimNao[nMart_ante][3]+"        "
xTemp := nMart_ante
nMart_ante := escolhe(aSimNao)
IF nMart_Ante = 0
   nMart_ante := xTemp
ENDIF
@ 20,02 SAY "Espuma...... :"+aSimNao[nMart_ante][3]+"        "
 
*********************************************
FUNCTION func026()
@ 20,02 SAY "Engravidou enquanto utilizava algum metodo:"+aSimNao[nEngr_Mart][3]+"        "
xTemp := nEngr_mart
nEngr_Mart:= escolhe(aSimNao)
IF nEngr_Mart = 0
   nEngr_Mart := xTemp
ENDIF
@ 20,02 SAY "Engravidou enquanto utilizava algum metodo:"+aSimNao[nEngr_Mart][3]+"        "
 
********************************
FUNCTION func027()
IF nEngr_mart = 1
   @ 12,35 SAY "Nome do Metodo.:" GET cEng_MartN PICT "@!"
   @ 13,35 SAY "Tempo Utilizado:" GET cEng_MartT PICT "@!"
   READ
ENDIF
 
**********************************
FUNCTION  func028()
@ 14,33 SAY "Motivo para aprender o metodo da ovulacao:"
@ 15,33 SAY "Adquirir conhecimento das funcoes do corpo:" ;
 GET cMot_Ovul1 PICT "!"  VALID cMot_Ovul1 $"SN"
@ 16,33 SAY "Evitar uma Gravidez:" ;
 GET cMot_Ovul2 PICT "!"  VALID cMot_Ovul2 $ "SN"
@ 17,35 SAY "Conseguir uma Gravidez:" ;
 GET cMot_Ovul3 PICT "!"  VALID cMot_Ovul3 $ "SN"
READ
 
***************************************
FUNCTION func029()
@ 20,02 SAY "Situacao da Usuaria:"+aSituacao[nSituacao][3]+"        "
xTemp := nSituacao
nSituacao := escolhe( aSituacao )
IF nSituacao = 0
   nSituacao := xTemp
ENDIF
@ 20,02 SAY "Situacao da Usuaria:"+aSituacao[nSituacao][3]+"        "
 
*************************************
FUNCTION func030()
IF nSituacao = 1
   IF nsitua_1 > Len(aSit1)
      nSitua_1 := 1
   endif
   @ 19,02 SAY "Situacao :"+aSit1[nSitua_1][3]+"        "
   xTemp := nSitua_1
   nSitua_1:= escolhe(aSit1)
   IF nSitua_1 = 0
      nSitua_1 := xTemp
   ENDIF
   @ 19,02 SAY "Situacao :"+aSit1[nSitua_1][3]+"        "
ELSE
   IF nsitua_1 > Len(aSit2)
      nSitua_1 := 1
   endif
   @ 19,02 SAY "Situacao :"+aSit2[nSitua_1][3]+"        "
   xTemp := nSitua_1
   nSitua_1:= escolhe(aSit2)
   IF nSitua_1 = 0
      nSitua_1 := xTemp
   ENDIF
   @ 19,02 SAY "Situacao :"+aSit2[nSitua_1][3]+"        "
ENDIF
 
* eop pamtusu1.prg
