* BOP CEFUNC.PRG
 
#include "common.ch"
#include "inkey.ch"
 
********************************
function ACHA(Arg1)
 
   save screen to stela_ant
   set filter to Produto = alltrim(cDescmat)
   goto top
   nlinprod:= Row()
   if (EOF())
      mensagem("Nao Ha nenhum produto com esse nome")
      lret:= .F.
   else
      sombra(9, 9, 17, 51)
      private avetcamp[1]
      avetcamp[1]:= "PRODUTO"
      dbedit(10, 10, 16, 50, avetcamp, "USer_Func", "@!", "Material")
      lret:= .T.
   endif
   restore screen from stela_ant
   return lret
 
********************************
procedure CONFIG
 
   public nporicms, nporcom
   if (file("PORCENT.MEM"))
      restore from PORCENT additive
   else
      nporicms:= nporcom:= 0
   endif
   sombra(9, 15, 14, 65)
   @ 10, 25 say "Configuracoes do Sistema" color "R+/N"
   @ 11, 17 say "Porcentagem do ICMS :" get nPorICMS picture "99" ;
      valid nporicms > 0
   @ 11, Col() say " %"
   @ 12, 17 say "Porcentagem da Comissao p/ funcionarios :" get ;
      nPorCom picture "99" valid nporcom > 0
   @ 12, Col() say " %"
   read
   if (confirma("As porcentagens estao corretas ?"))
      erase porcent.mem
      save all like nPor* to PORCENT
   endif
   return
 
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
function CONTROLE
 
   save screen to tela_te
   parameters modo, elto, pos
   do case
   case modo = 4
      ret:= 3
   case modo = 3
      do case
      case LastKey() == K_ESC
         ret:= 0
      case LastKey() == K_ENTER
         ret:= 1
      case LastKey() == K_F1
         ret:= 0
      case LastKey() == K_RIGHT
         ret:= 0
      case LastKey() == K_LEFT
         ret:= 0
      case LastKey() == K_F10
         ret:= 0
      otherwise
         ret:= 2
      endcase
   case modo = 2
      keyboard Chr(31)
      ret:= 2
   case modo = 1
      keyboard Chr(30)
      ret:= 2
   case modo = 0
      ret:= 2
   endcase
   restore screen from tela_te
   return ret

********************************
procedure GERA_AGD(nValor_tot, Arg2, Arg3, Arg4, nMOvim)
* gera_agd(nVal_tot, cmostra6, ccod_pes, cpessoa,n_mov)
 
   save screen to stela_ant
   sombra(8, 10, 21, 65)
   @  8, 15 say "Inclusao na Agenda de " + iif(Arg2 = "C", ;
      "Recebimento", "Pagamento")
   nnpar:= nacpar:= 0
   @  9, 11 say "Numero de Parcelas:"
   @ 10, 11 say "Valor Total.......:"
   @ 11, 11 say "Data do " + iif(Arg2 = "C", "Receb.", "Pagto ")
   @ 11, 30 say "Porcentagem"
   @ 11, 43 say "Valor da Parcela:"
   @  9, 31 get nNpar picture "99" valid nnpar > 0
   @ 10, 31 get nValor_tot picture "9,999,999.99" valid nValor_tot > 0
   read
   amatpar:= array(nnpar, 3)
   nl1:= 11
   for ia:= 1 to nnpar
      amatpar[ia][1]:= CToD("  /  /  ")
      amatpar[ia][2]:= 0
      @ nl1 + ia, 11 get aMatPar[ia][1] picture "99/99/99" valid ;
         dia_util(amatpar[ia][1])
      @ nl1 + ia, 38 get aMatPar[ia][2] picture iif(nnpar = 1, ;
         "999", "99") valid amatpar[ia][2] > 0 .AND. amatpar[ia][2] ;
         + nacpar <= 100
      read
      nacpar:= nacpar + amatpar[ia][2]
      amatpar[ia][3]:= amatpar[ia][2] * nValor_tot / 100
      @ nl1 + ia, 43 say amatpar[ia][3]
      if (ia >= 9)
         Scroll(12, 11, 20, 64, 1, 0)
         nl1--
      endif
   next
   for ib:= 1 to Len(amatpar)
      append blank
      replace valor with amatpar[ib][3]
      replace data_pg with amatpar[ib][1]
      replace tipo with Arg2
      replace codigo with Arg3
      replace nome_for with Arg4
      REPLACE NMOV WITH if(nMOvim<>NIL,nMovim,"0")
   next
   restore screen from stela_ant
   return
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
   cor_memo:= SetColor()
   set color to bg/n
   sombra(9, 23, 22, 62, .F.)
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
 
      use cebcli index ceicli, CEICLI2
      IF lupdate()=DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use cebfor index ceifor, ceifor2
      IF lupdate() =DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use cebfun index ceifun, CEIFUN2
      IF lupdate()= DATA_SIS
         PACK
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      CLOSE ALL
      select 1
      close format
 
      use cebest index ceiest, CEIEST2
      IF lupdate()= DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use CEBMEST index CEIMEST
      IF lupdate()= DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use CEBAGEN index CEIAGEN
      IF lupdate()= DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use cebped index ceiped
      IF lupdate()= DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use ceborc index ceiorc
      IF lupdate()= DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use cebpre index ceipre, CEIPRE2
      IF lupdate()= DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use cebcus index ceicus
      IF lupdate()= DATA_SIS
         PACK
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      select 1
      close format
 
      use ceblanca
      IF lupdate()= DATA_SIS
         pack
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      close databases
      sele 1
      close format
 
      use cebcat index ceicat
      IF lupdate()=DATA_SIS
         PACK
         REINDEX EVAL { || NtxProgress() } EVERY 1
      ENDIF
      CLOSE ALL
 
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
procedure SOBRE
   restore from ce additive
   aMensLIn := {"          Controle de Estoque v1.0        ",;
                "            Desenvolvido Por:",;
                "      Luiz Antonio Carlin, 1995",;
                "  Este Programa esta licenciado para",;
                l_nome ,;
                l_empresa ,;
                "  C:\" + curdir("C:") + " | " + os() ,;
                "  Espaco :" + Str(diskspace()) + " Bytes  Livres" ,;
                "  Memoria:" + Str(memory()) + " Kbytes livres" }
   mensagem(aMensLin)
   return
 

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
 
****************************************
* funcao que valida as categorias
FUNCTION existeCATe ()
 
s_TEla1 := savescreen(08,17,18,48)
n_Cat := 0
sombra(09,18,17,46)
@ 09,25 SAY "Categorias:"
DO WHILE n_Cat = 0
   n_Cat := achoice(10,19,16,45,aCatego,.T.,"CONTROLE")
ENDDO
restscreen(08,17,18,48,s_Tela1)
RETURN n_Cat
 
 
* eop cefunc.prg
