* BOP CEFUNC.PRG
 
#include "common.ch"
#include "inkey.ch"
 
 
********************************
function CONSULTA(Arg1, Arg2)
 
   local Local1
   ccampo:= avet_camp[Arg2]
   do case
   case Arg1 == 4
      if (LastKey() == K_ESC)
         return 0
      elseif (LastKey() == K_ENTER)
         if (ValType(&ccampo) = "M")
            obser(.F., &ccampo)
            return 1
         endif
         return 1
      endif
   case Arg1 == 3
      mensagem("Nao ha dados nesse arquivo!!")
      return 0
   case Arg1 == 2
      return 1
   case Arg1 == 1
      return 1
   otherwise
      return 1
   endcase
********************************
function CONS003(Arg1, Arg2)
 
   do case
   case Arg1 == 4
      do case
      case LastKey() == K_ESC
         return 0
      case LastKey() == K_F2
         save screen to stela_ant
         dano:= "  "
         dmes:= "  "
         apre:= setcursor(1)
         @ 21, 15 say "Entre com a data (MM/AA)"
         @ 21, 40 get dMes picture "99" valid Val(dmes) <= 12
         @ 21, 42 say "/" color "W/R"
         @ 21, 43 get dAno picture "99"
         read
         restore screen from stela_ant
         setcursor(apre)
         if (LastKey() == K_ESC)
            return 1
         endif
         if (Empty(dmes) .OR. Empty(dano))
            set filter to TIPO = cTipo3
            goto top
            return 2
         else
            dat_fil:= dmes + "/" + dano
            set filter to (TIPO=cTipo3) .AND. (SUBST(dtoc(data_pg), ;
               4,8)=DAT_FIL)
            goto top
            return 2
         endif
      case LastKey() == K_F4
         if (confirma("Realizar o " + ctitulo2 + ;
               " das dividas Marcadas ?"))
            pagar:= 0
            DBEval({|| pagar:= pagar + 1}, {|| selec = "S"}, Nil, ;
               Nil, Nil, .F.)
            if (pagar < 1)
               mensagem("Nao ha registros marcados!")
               return 1
            endif
            locate for selec = "S"
            for i:= 1 to pagar
               nvalor:= valor
               cdesc:= iif(tipo = "D", "Pagamento", "Recebimento") + ;
                  " de Divida Agendada-" + DToC(data_pg)
               ctipo:= tipo
               delete
               select 2
               append blank
               replace descricao with cdesc
               replace valor with nvalor
               replace tipo with ctipo
               replace data with data_sis
               select 1
               continue
            next
            mensagem("Pagamentos efetuados!!")
            return 0
         endif
      case LastKey() == K_F3
         replace selec with iif(selec = "S", " ", "S")
         return 1
     case LastKey() == 13
         n_Curs   := setcursor(1)
         cCampo   := VETOR_CAMP[ARG2]
         cMascara := VETOR_MASC[ARG2]
         @ row(),col() GET &cCampo PICTURE cMascara WHEN(upper(cCampo)<>"SELEC")
         READ
         setcursor(n_curs)
         RETURN 1
      otherwise
         return 1
      endcase
   case Arg1 == 3
      mensagem("Nao ha dados nesse arquivo!!")
      return 0
   case Arg1 == 2
      return 1
   case Arg1 == 1
      return 1
   otherwise
      return 1
   endcase

********************************
procedure help (prog, lin, var)
 
save screen to tela_hlp
COR_HLP := SETCOLOR("gr+/b")
CURSOR := SETCURSOR(0)
prog:=lower(prog)
prg:=substr(prog,1,2)
BEGIN SEQUENCE
      if prg<>"ce"
         arquivo :="cehelp.hlp"
      else
         arquivo=""+prog+".hlp"
      endif
      arquivo := upper(arquivo)
      if .not. file(arquivo)
         mensagem("Ajuda Nao esta Disponivel")
         BREAK
      endif
      var_hlp1 := memoread(arquivo)
      var_hlp := {}
      sombra(11,07,13,35)
      @ 12,08 say "Aguarde! Pesquisando Ajuda." COLOR "r*/w"
      FOR in_hlp :=1 to mlcount(var_hlp1,39)
          aadd(var_hlp,memoline(var_hlp1,39,in_hlp))
      next
      var := "# "+prog+" "+lower(var)
      posicao := 0
      acha := .t.
      nPosicao1 := 0
      nPosicao2 := 0
      nPosicao1 := ascan(var_hlp,var)
      IF nPosicao1 = 0
         mensagem("Ajuda nao esta disponivel")
         break
      endif
      nPOsicao2 := aScan(var_hlp,"# fim",nPosicao1)
      IF nPosicao2 = 0
         mensagem("Ajuda nao esta disponivel")
         break
      endif
      socorro :=""
      FOR ind2 := nPosicao1+1 TO nPosicao2 -1
          socorro+=var_hlp[ind2]
      next
      sombra(10,03,20,44)
      @ 10,16 say " Ajuda "
      @ 20,10 say "<ESC> - Retorna"
      set key 28 to
      set color to w/n
      ajuda := memoedit(socorro,11,04,19,43,.f.,,39,0)
END
 
SETCURSOR(CURSOR)
setcolor(cor_hlp)
restore screen from tela_hlp
set key 28 to help
RETURN
 
********************************
function OBSER
 
   parameters mdo, nota
   save screen to tobs
   cor_memo:= SetColor("bg/n")
   sombra(9, 23, 22, 62 )
   @  9, 30 say "º Observa‡”es º"
   if (mdo)
      @ 21, 24 say "^W Grava; ^Y Apaga Linha; <ESC> Sai"
      @ 21, 59 say Space(3)
      set color to w/n
      mobs:= memoedit(nota, 10, 24, 20, 61, .T.)
      restore screen from tobs
   else
      @ 21, 25 say " <ESC> Sai"
      _cursor_ap:= setcursor(0)
      tel_:= SaveScreen(9, 23, 21, 62)
      mobs:= memoedit(nota, 10, 24, 20, 61, .F.)
      setcursor(_cursor_ap)
      RestScreen(10, 24, 20, 61, tel_)
   endif
   restore screen from tobs
   set color to (cor_memo)
   return mobs
 
********************************
procedure SAI
 
   tone(250, 1)
   if (confirma("Deseja realmente Sair"))
      set color to r+/w*
      @ 23, 10 say "Aguarde... "
 
      use srbcli index sricli, srICLI2
      IF lupdate()=DATA_SIS
         pack
         REINDEX //EVAL { || NtxProgress() } EVERY 2
      ENDIF
      close databases
      select 1
      close format

      use srbcus index sricus
      IF lupdate()= DATA_SIS
         PACK
         REINDEX //EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use srblanca
      IF lupdate()= DATA_SIS
         pack
         REINDEX //EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      sele 1
      close format
 
      @ 23, 10 say "Retorno ao Sistema Operacional...."
      InKey(0.7)
      set color to
/*
      for i:= 0 to 40
         @  0, i clear to 24, i
         @  0, 79 - i clear to 24, 79 - i
         InKey(0.01)
      next
*/
      restore screen from tela_dos
      @ linha, coluna
      close databases
      select 1
      close format
      clear memory
      quit
   endif
   return
   restore screen from tela

********************************
function USER_FUNC(Arg1, Arg2)
 
   if (Arg1 == 4)
      if (LastKey() == 13)
         return 0
      else
         return 1
      endif
   else
      return 1
   end
********************************
function CONS001(Arg1, Arg2)
 
   local Local1, GETLIST := {}
   do case
   case Arg1 == 4
      if (LastKey() == K_ESC)
         return 0
      elseif (LastKey() == K_ENTER)
         ccampo:= fieldName(Arg2)
         if (ValType(ccampo) = "M")
            obser(.F., ccampo)
         ELSE
            IF arg2 = 8
               RETURN 1
            ENDIF
            cCamp := aVet_camp[arg2]
            cMasc := aVet_masc[arg2]
            n_Cursor := setcursor(1)
            @ row(),col() GET &cCamp PICTURE cMasc WHEN (upper(cCamp)<>"MARCADO")
            READ
            setcursor(n_cursor)
         endif
         return 1
      ELSEIF lastkey() = -1
         REPLACE marcado WITH (if(marcado="S"," ","S"))
         RETURN 1
      ELSEIF lastkey() = 7
         IF Confirma("Deseja Realmente Excluir Os Registros Marcados ?")
            nConta := 0
            COUNT TO nConta FOR Marcado = "S"
            IF nConta = 0
               mensagem("N„o Ha Registros marcados para a exclusao !")
               RETURN 1
            ENDIF
            SET FILTER TO marcado = "S"
            GO TOP
            aVetRecs := {}
            DO WHILE .NOT. eof()
               aadd(aVetRecs,{NMOV,quant,cod_item})
               SKIP
            ENDDO
            DELE ALL FOR MARCADO = "S"
            FOR _I := 1 TO len(aVetRecs)
                SELE cebagen
                DELE ALL FOR nMov = aVetRecs[_I][1]
                SELE ceblanca
                DELE ALL FOR nMov = aVetRecs[_I][1]
                SELE cebcus
                DELE ALL FOR nMov = aVetRecs[_I][1]
            NEXT
            SELE CEBEST
            GO TOP
            FOR _K := 1 TO len(aVetRecs)
                SEEK aVetRecs[_k][3] // LOCATE FOR cod_item = aVetRecs[_k][3]
                IF FOUND()
                   nTemp := if(tipo_con = 3,QTD-aVetRecs[_k][2],QTD+aVetRecs[_k][2])
                   REPLACE QTD WITH nTemp
                ENDIF
            NEXT
            mensagem("Exclus”es Realizadas !")
            RETURN 0
         ENDIF
         RETURN 1
      endif
   case Arg1 == 3
      mensagem("Nao ha dados nesse arquivo!!")
      return 0
   case Arg1 == 2
      return 1
   case Arg1 == 1
      return 1
   otherwise
      return 1
   endcase
 
********************************************
* funcao de consulta de lancamentos / custos
function CONS002(_modo, _Indice)
 
   local Local1
   do case
   case _modo == 4
      if (LastKey() == K_ESC)
         return 0
      elseif (LastKey() == K_ENTER)
         ccampo   := aVet_campo[_indice]
         cMascara := aVet_Masc[_indice]
         n_Cursor := setcursor(1)
         @ row(),col() GET &cCampo PICTURE cMascara WHEN  ;
               (upper(alltrim(cCampo))<>"TIPO")
         READ
         setcursor(n_cursor)
         return 1
      ELSEIF (lastkey() == -7)
         sTela := savescreen(11,05,14,72)
         SOMBRA(11,05,13,69)
         cPesquisa := space(40)
         nPesquisa := 0
         cSit   := space(8)
         nCcusto := 0
         nDcusto := 0
         nTam    := 0
         nCursor := setcursor(1)
         @ 12,06 SAY "Entre com a Descricao:" GET cPesquisa PICT "@!"
         READ
         setcursor(0)
         restscreen(11,05,14,72,sTela)
         IF lastkey() = 27 .OR. empty(cPesquisa)
            RETURN 1
         ENDIF
         nTam := len(alltrim(cPesquisa))
         SUM VALOR TO nDcusto FOR UPPER(substr(DESCRICAO,1,nTam))= alltrim(cPesquisa) .AND. TIPO="D"
         SUM VALOR TO nCcusto FOR UPPER(substr(DESCRICAO,1,nTam))= alltrim(cPesquisa) .AND. TIPO="C"
         nPesquisa := if(nCCusto>nDcusto,nCCusto-nDcusto,nDcusto-nCCusto)
         cSit      := if(nCCusto>nDcusto,"Credito","Debito ")
         go top
         SET FILTeR TO UPPER(substr(DESCRICAO,1,nTam)) = alltrim(cPesquisa)
         dbGOTOP()
         @ 23,08 SAY cPesquisa
         @ 23,COL()+2 SAY nPesquisa PICT "999,999,999.99"
         @ 23,col()+2 SAY cSit
         RETURN 2
      ELSEIF LASTKEY() = -8
         SET FILTER TO
         GO TOP
         @ 23,05 TO 23,75
         RETURN 2
      endif
   case _modo == 3
      mensagem("Nao ha dados nesse arquivo!!")
      return 0
   case _modo == 2
      return 1
   case _modo == 1
      return 1
   otherwise
      return 1
   endcase
* eop cefunc.prg
