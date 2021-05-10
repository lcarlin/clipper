* bop gene04.prg
********************************
function OPCOESCAMP(g_074xenon, nLinCamp , Arg3)

   local Local1:= SetColor(), Local2:= Row()
   set color to (g_cormenu)
   if (nLinCamp - (Local2 - 4) > 0)
      @ 22, 52 say ""
   else
      @ 22, 52 say "Ä"
   endif
   if ( nLinCamp + (21 - Local2) < Len(g_074xenon))
      @ 22, 53 say ""
   else
      @ 22, 53 say "Ä"
   endif
   set color to (Local1)
   if (LastKey() == K_ESC)
      return 0
   elseif (LastKey() == K_ENTER)
      return 1
   elseif (LastKey() >= 65 .AND. LastKey() <= 122)
      if (Static1)
         keyboard Chr(254)
      endif
      Static1:= !Static1
      set color to (Local1)
      return 3
   endif
   return 2

********************************
function OPCOESFORM(tTeste, nLinForm , Arg3)

   local Local1:= SetColor(), Local2:= Row(), Local3:= alias(), ;
      Local4, Local5, Local6:= {}
   limparodap()
   if (Len(g_049xuxa) > 0 .AND. file(g_218ao_am + "\" + ;
         g_049xuxa[nLinForm]))
      use (g_218ao_am + "\" + g_049xuxa[nLinForm]) alias Formatto new ;
         readonly
      if (neterr())
         set color to (g_cormenu)
         @ 24,  0 say padc("*****  Acesso bloqueado *****", 70)
      else
         if (formatto->tip = "D ")
            Local5:= Day(lupdate())
            set color to (g_cormenu)
            @ 24,  0 say Left(padc(descript(Trim(formatto->cam), ;
               Local5), 70), 70)
         endif
         close
         if (!Empty(Local3))
            select (Local3)
         endif
      endif
   endif
   set color to (g_cormenu)
   if (nLinForm - (Local2 - 5) > 0)
      @ 19, 38 say ""
   else
      @ 19, 38 say "Ä"
   endif
   if (nLinForm + (18 - Local2) < Len(g_049xuxa))
      @ 19, 39 say ""
   else
      @ 19, 39 say "Ä"
   endif
   set color to (Local1)
   do case
   case LastKey() == K_ESC
      return 0
   case LastKey() == K_TAB
      Local4:= Left(g_049xuxa[nLinForm] + Space(13), 13)
      SetPos(Local2, 28)
      AAdd(Local6, __Get({|_1| iif(ISNIL(_1), Local4, Local4:= _1)}, ;
         "G_135Sagan", Nil, Nil, Nil):display())
      __KillRead()
      Local6:= {}
      botaoforma(nLinForm)
      set color to (g_corcaixa)
      @ Local2, 28 say Local4
   case LastKey() == K_ENTER
      Local4:= Left(g_049xuxa[nLinForm] + Space(13), 13)
      SetPos(Local2, 28)
      AAdd(Local6, __Get({|_1| iif(ISNIL(_1), Local4, Local4:= _1)}, ;
         "G_135Sagan", Nil, Nil, Nil):display())
      __KillRead()
      Local6:= {}
      selecmidia(nLInForm)
      set color to (g_corcaixa)
      @ Local2, 28 say Local4
   case LastKey() >= 65 .AND. LastKey() <= 122
      set color to (Local1)
      if (Static2)
         keyboard Chr(254)
      endif
      Static2:= !Static2
      return 3
   endcase
   set color to (Local1)
   return 2

********************************
static function OPENWINDOW(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, ;
   Arg8, Arg9, Arg10)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10, Local11, Local12, Local13, Local14
   Local9:= SetColor()
   if (Arg5 = Nil)
      Arg5:= ""
   endif
   if (Arg6 = Nil)
      Arg6:= SetColor()
   endif
   if (Arg7 = Nil)
      Arg7:= .T.
      Arg8:= .F.
   endif
   if (Arg8 = Nil)
      Arg8:= .F.
   endif
   if (Arg9 = Nil)
      Arg9:= .F.
   endif
   if (Arg10)
      Arg7:= .T.
      Arg8:= .T.
      Arg9:= .T.
   endif
   if (Empty(Arg6))
      Arg6:= SetColor()
   endif
   g_229janel:= g_229janel + 1
   g_238jam[g_229janel]:= SaveScreen(Arg1, Arg2, Arg3 + 1, Arg4 + 2)
   g_225taxma[g_229janel]:= Arg1
   g_226warlu[g_229janel]:= Arg2
   g_227yeste[g_229janel]:= Arg3 + 1
   g_228letit[g_229janel]:= Arg4 + 2
   set color to (Arg6)
   if (Arg9)
      Local12:= SaveScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2)
      Local14:= 1
      Local13:= ""
      do while (Local14 <= Len(Local12))
         Local13:= Local13 + (SubStr(Local12, Local14, 1) + "")
         Local14:= Local14 + 2
      enddo
      RestScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2, Local13)
      for Local14:= Arg1 + 1 to Arg3
         Local12:= SaveScreen(Local14, Arg4 + 1, Local14, Arg4 + 2)
         Local13:= SubStr(Local12, 1, 1) + "" + SubStr(Local12, 3, ;
            1) + ""
         RestScreen(Local14, Arg4 + 1, Local14, Arg4 + 2, Local13)
      next
   endif
   set color to (iif(Arg5 = "MENSAGEM", "gr+/r", Arg6))
   @ Arg1, Arg2 clear to Arg3, Arg4
   if (Arg7)
      if (Arg8)
         @ Arg1, Arg2 to Arg3, Arg4 double
      else
         @ Arg1, Arg2 to Arg3, Arg4
      endif
   endif
   if (!Empty(Arg5) .AND. Arg5 != "MENSAGEM")
      Local10:= At("/", SetColor())
      Local11:= At(",", SetColor())
      set color to (SubStr(SetColor(), Local10 + 1, Local11 - ;
         Local10 - 1) + "/" + Left(SetColor(), Local10 - 1))
      @ Arg1, (Arg4 - Arg2 - Len(Arg5)) / 2 + Arg2 say Arg5
   endif
   set color to (Local9)
   return ""

********************************
static function PEDESENHA( cSenha )

   local Local1:= SetColor(), Local2[10], Local3, Local4:= .F., Local5
   afill(Local2, " ")
   set color to (g_cormenu)
   openwindow(10, 30, 14, 50, Nil, Nil, .T., .F., .T., .F.)
   @ 12, 32 say "Senha: "
   for Local3:= 1 to 10
      Local5:= InKey(0)
      if (LastKey() = K_ESC .OR. LastKey() = K_ENTER)
         Local3:= 10
         loop
      endif
      if (LastKey() == K_BS)
         if (Local3 < 2)
            Local3:= 2
         endif
         @ 12, 38 + Local3 - 1 say " "
         Local2[Local3 - 1]:= " "
         Local3:= Local3 - 2
         loop
      endif
      Local2[Local3]:= Chr(Local5)
      @ 12, 38 + Local3 say "þ"
   next
   if (LastKey() != K_ESC)
      if (Upper(Local2[1] + Local2[2] + Local2[3] + Local2[4] + ;
            Local2[5] + Local2[6] + Local2[7] + Local2[8] + ;
            Local2[9] + Local2[10]) = Left(Upper( cSenha ) + Space(10), ;
            10))
         Local4:= .T.
      else
         bip(600, 1)
         bip(500, 1)
         alert("Senha incorreta !!")
      endif
   endif
   closewindo()
   set color to (Local1)
   return Local4

********************************
static function PROCESSACO

   local Local1, Local2, Local3, Local4:= 0, Local5:= .T., Local6:= ;
      g_campo[g_098bhor], Local7
   do case
   case Upper(Left(Local6, 5)) == "#GOTO"
      Local1:= alltrim(SubStr(Local6, 6))
      Local3:= At("#CASE", Upper(Local1))
      if (Local3 != 0)
         Local7:= alltrim(SubStr(Local1, Local3 + 5))
         Local5:= &Local7
         Local1:= alltrim(Upper(Left(Local1, Local3 - 1)))
      else
         Local1:= alltrim(Upper(Local1))
         Local5:= .T.
      endif
      if (Local5)
         for Local2:= 1 to Len(g_tipo)
            if (Local1 == alltrim(Upper(SubStr(g_campo[Local2], 7))) ;
                  .AND. alltrim(Upper(Left(g_campo[Local2], 6))) == ;
                  "#LABEL")
               g_098bhor:= Local2 + 1
               Local4:= 1
            endif
         next
      endif
   case Left(Upper(Local6), 5) == "#SKIP"
      if (Upper(alltrim(SubStr(Local6, 6))) == "OFF")
         g_110lavoc:= .F.
      else
         g_110lavoc:= .T.
      endif
   case Left(Upper(Local6), 3) == "#IF"
      g_111salam++
      Local7:= alltrim(SubStr(Local6, 4))
      g_112intru[g_111salam]:= &Local7 .AND. condsuperi()
   case Left(Upper(Local6), 5) == "#ELSE"
      g_112intru[g_111salam]:= !g_112intru[g_111salam] .AND. ;
         condsuperi()
   case Left(Upper(Local6), 6) == "#ENDIF"
      g_111salam--
   endcase
   return Local4

********************************
static function PROGRAMATE

   local Local1:= {}, Local2:= SetColor()
   set color to (g_cormenu)
   openwindow(7, 18, 17, 62, "Programa Teclas", Nil, .F., .F., .F., ;
      .T.)
   @  8, 19 clear to 16, 61
   @  8, 19 say "³SHIFT³ ³F1³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_032plank, g_032plank:= ;
      _1)}, "G_032Plank", Nil, Nil, Nil):display())
   @  9, 19 say "³SHIFT³ ³F2³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_033einst, g_033einst:= ;
      _1)}, "G_033Einsten", Nil, Nil, Nil):display())
   @ 10, 19 say "³SHIFT³ ³F3³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_034jesus, g_034jesus:= ;
      _1)}, "G_034Jesus", Nil, Nil, Nil):display())
   @ 11, 19 say "³SHIFT³ ³F4³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_035crist, g_035crist:= ;
      _1)}, "G_035Cristo", Nil, Nil, Nil):display())
   @ 12, 19 say "³SHIFT³ ³F5³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_036krisn, g_036krisn:= ;
      _1)}, "G_036Krisna", Nil, Nil, Nil):display())
   @ 13, 19 say "³SHIFT³ ³F6³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_037hare, g_037hare:= ;
      _1)}, "G_037Hare", Nil, Nil, Nil):display())
   @ 14, 19 say "³SHIFT³ ³F7³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_038rama, g_038rama:= ;
      _1)}, "G_038Rama", Nil, Nil, Nil):display())
   @ 15, 19 say "³SHIFT³ ³F8³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_039buda, g_039buda:= ;
      _1)}, "G_039Buda", Nil, Nil, Nil):display())
   @ 16, 19 say "³SHIFT³ ³F9³"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_040black, g_040black:= ;
      _1)}, "G_040Black", Nil, Nil, Nil):display())
   teclasform(.F.)
   readexit(.F.)
   ReadModal(Local1)
   Local1:= {}
   teclasform(.T.)
   readexit(.T.)
   set function 11 to Trim(g_032plank)
   set function 12 to Trim(g_033einst)
   set function 13 to Trim(g_034jesus)
   set function 14 to Trim(g_035crist)
   set function 15 to Trim(g_036krisn)
   set function 16 to Trim(g_037hare)
   set function 17 to Trim(g_038rama)
   set function 18 to Trim(g_039buda)
   set function 19 to Trim(g_040black)
   closewindo()
   set color to (Local2)
   return ""

********************************
static function QUALARQUIV(g_021yang)

   local Local1
   Local1:= SetColor()
   set color to (g_cormenu)
   openwindow(4, 25, 20, 55, "Arquivos", Nil, .F., .F., .F., .T.)
   botao(16, 42, "Seleciona")
   botao(18, 42, "Cancela")
   @  5, 27 to 19, 41
   set color to (g_corcaixa + SubStr(g_cormenu, 8))
   keyboard Chr(5)
   set key K_TAB to botaoarqui
   g_029quack:= achoice(6, 28, 18, 40, g_021yang, .T., ;
      "OpcoesArquivos")
   SetKey(K_TAB, Nil)
   limparodap()
   set color to (Local1)
   closewindo()
   return ""

********************************
static function QUALFORMAT( g_049xuxa1 )

   local Local1, Local2
   Local1:= SetColor()
   if (Len(g_049xuxa) = 0 .AND. g_019oxoss != 5)
      bip(600, 1)
      bip(500, 1)
      alert("Nenhum formato encontrado !!")
      set color to (Local1)
      return ""
   endif
   set color to (g_cormenu)
   openwindow(4, 25, 20, 55, "Formatos", Nil, .F., .F., .F., .T.)
   if (g_019oxoss == 5)
      botao(10, 42, "Seleciona")
      botao(12, 42, "Apaga")
      botao(14, 42, "Duplica")
      botao(16, 42, "Novo")
      botao(18, 42, "Cancela")
   else
      botao(16, 42, "Seleciona")
      botao(18, 42, "Cancela")
   endif
   @  5, 27 to 19, 41
   set color to (g_corcaixa + SubStr(g_cormenu, 8))
   if (Len(g_049xuxa) == 0)
      keyboard "N"
      botaoforma()
      keyboard Chr(27)
   else
      keyboard Chr(5)
      achoice(6, 28, 18, 40, g_049xuxa, .T., "OpcoesFormatos")
   endif
   limparodap()
   closewindo()
   set color to (Local1)
   return ""

********************************
static function RECADOS

   local Local1, Local2
   Local1:= {}
   openwindow(7, 9, 17, 71, Nil, Nil, .F., .F., .F., .T.)
   AAdd(Local1, cript(" "))
   AAdd(Local1, "Â}ðÜxçò¶—†Ñ")
   AAdd(Local1, "Í" + cript("gi", 3) + "˜…œåòbnmÂÖÔžs’‰")
   AAdd(Local1, "Ëª”ÔxÔÒJX†¿ÙÔ™z")
   AAdd(Local1, cript(" "))
   AAdd(Local1, "¾ ˜¾ìÈÊÂbŽ³·Í¶")
   AAdd(Local1, "Í­·wÆÄ9f²ÕµÅsxé•ƒ¨XåÜu¾ÐÎ•ÕÏIR}")
   AAdd(Local1, "Á§üEÎÐË—…ÒÓFX„ÆÓÁ™c·ÂžóûýßÆ„›‹ò")
   AAdd(Local1, cript(" "))
   for Local2:= 1 to Len(Local1)
      @ 7 + Local2, 10 say padc(alltrim(descript(Local1[Local2])), 60)
   next
   InKey(0)
   closewindo()
   return ""

********************************
static function SAIBOTAO

   set color to (Left(g_corbotao, 7) + "," + Left(g_corbotao, 7) + ;
      ",n,n," + Left(g_corbotao, 7))
   keyboard Chr(24) + Chr(3)
   g_136clapt:= 1
   return ""

********************************
static function SELECMIDIA( nMidia )

   local Local1
   Local1:= {}
   do case
   case g_019oxoss == 2
      imprime(20, g_049xuxa[ nMidia ])
   case g_019oxoss == 3
      if (!isprinter())
         bip(600, 1)
         bip(500, 1)
         alert("Falha na impress„o. Verifique impressora !!")
      else
         imprime(58, g_049xuxa[nMidia])
      endif
   case g_019oxoss == 4
      set color to (g_cormenu)
      openwindow(8, 25, 13, 52, Nil, Nil, .T., .F., .T., .F.)
      @ 10, 28 say "Nome Arquivo:"
      @ 11, 28 say "Extens„o:"
      g_050marre:= Left(Left(g_049xuxa[nMidia], At(".", ;
         g_049xuxa[nMidia]) - 1) + Space(8), 8)
      g_051zika:= "TXT"
      SetPos(10, 42)
      AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_050marre, ;
         g_050marre:= _1)}, "G_050Marrecuz", "NNNNNNNN", Nil, ;
         Nil):display())
      SetPos(11, 42)
      AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_051zika, g_051zika:= ;
         _1)}, "G_051Zika", "NNN", Nil, Nil):display())
      tratacurso(.T.)
      ReadModal(Local1)
      Local1:= {}
      tratacurso(.F.)
      if (LastKey() != K_ESC)
         imprime(58, g_049xuxa[nMidia])
      endif
      closewindo()
   case g_019oxoss == 5
      gera(g_049xuxa[nMidia])
   endcase
   return ""

********************************
static function SETAPRINTE(cAtiva)

   if (Empty(cAtiva))
      return ""
   endif
   Arg1:= Upper(Arg1)
   if ("INI" $ cAtiva .AND. !Empty(g_ambinici))
      DevOut(&g_ambinici)
   endif
   if ("10CPI" $ cAtiva .AND. !Empty(g_ambnorma))
      DevOut(&g_ambnorma)
   endif
   if ("12CPI" $ cAtiva .AND. !Empty(g_ambcpi12))
      DevOut(&g_ambcpi12)
   endif
   if ("EXP+" $ cAtiva .AND. !Empty(g_ambexpan))
      DevOut(&g_ambexpan)
   endif
   if ("EXP-" $ cAtiva .AND. !Empty(g_ambn_exp))
      DevOut(&g_ambn_exp)
   endif
   if ("COMP+" $ cAtiva .AND. !Empty(g_ambcompr))
      DevOut(&g_ambcompr)
   endif
   if ("COMP-" $ cAtiva .AND. !Empty(g_ambn_com))
      DevOut(&g_ambn_com)
   endif
   if ("NEG+" $ cAtiva .AND. !Empty(g_ambnegri))
      DevOut(&g_ambnegri)
   endif
   if ("NEG-" $ cAtiva .AND. !Empty(g_ambn_neg))
      DevOut(&g_ambn_neg)
   endif
   if ("ITA+" $ cAtiva .AND. !Empty(g_ambitali))
      DevOut(&g_ambitali)
   endif
   if ("ITA-" $ cAtiva .AND. !Empty(g_ambn_ita))
      DevOut(&g_ambn_ita)
   endif
   if ("ESP1" $ cAtiva .AND. !Empty(g_ambesp1))
      DevOut(&g_ambesp1)
   endif
   if ("ESP2" $ cAtiva .AND. !Empty(g_ambesp2))
      DevOut(&g_ambesp2)
   endif
   if ("ESP3" $ cAtiva .AND. !Empty(g_ambesp3))
      DevOut(&g_ambesp3)
   endif
   return ""

********************************
static function SOBEPAGINA

   keyboard Replicate(Chr(5), 9)
   return ""

********************************
static function TABESC

   keyboard Chr(27)
   return ""

********************************
static function TAMCAMPO

   parameters g_aux
   do case
   case Type(g_aux) = "U"
      g_tamanho[g_053proxi]:= 0
   case ValType(&g_aux) = "C"
      g_tamanho[g_053proxi]:= Len(&g_aux)
   case ValType(&g_aux) = "N"
      g_tamanho[g_053proxi]:= lennum(&g_aux)
   case ValType(&g_aux) = "D"
      g_tamanho[g_053proxi]:= 8
   otherwise
      g_tamanho[g_053proxi]:= 0
   endcase
   return .T.

********************************
static function TECLASFORM( lTecla )

   if (lTecla)
      set key K_CTRL_N to insereveto
      set key K_CTRL_U to apagavetor
      set key K_DOWN to filtraseta
      set key K_F1 to helparq
      set key K_F10 to implayout
      set key K_F2 to mostratecl
      set key K_F3 to copialinha
      set key K_F4 to programate
      set key K_TAB to navegalayo
      set key K_CTRL_DOWN to descepagin
      set key K_CTRL_UP to sobepagina
   else
      SetKey(K_CTRL_N, Nil)
      SetKey(K_CTRL_U, Nil)
      SetKey(K_DOWN, Nil)
      SetKey(K_F1, Nil)
      SetKey(K_F10, Nil)
      SetKey(K_F2, Nil)
      SetKey(K_F3, Nil)
      SetKey(K_F4, Nil)
      SetKey(K_TAB, Nil)
      SetKey(K_CTRL_DOWN, Nil)
      SetKey(K_CTRL_UP, Nil)
   endif
   return ""

********************************
static function TELAIMP (lTabela)

   local Local1, Local2, Local3[FCount()], Local4:= SetColor(), ;
      Local5:= {}
   g_124asia:= .F.
   if (!lTabela)
      if (BOF())
         goto top
      endif
      if (EOF())
         goto bottom
      endif
      if (BOF() .AND. EOF())
         return ""
      endif
   endif
   if (!FLock())
      bip(600, 1)
      bip(500, 1)
      alert("Arquivo bloqueado;Aguarde !!")
      return ""
   endif
   g_123xypz:= RecNo()
   for Local1:= 1 to FCount()
      if (lTabela)
         Local3[Local1]:= Space(Len(fieldget(Local1)))
      else
         Local3[Local1]:= fieldget(Local1)
      endif
   next
   set color to (g_corpadra)
   openwindow(3, 14, 20, 67, "Configuracao de Impressora", Nil, .T., ;
      .T., .T., .F.)
   Local1:= 0
   Local2:= 4
   @ Local2++, 15 say "Modelo..............:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@!", {|| ;
      iif(!Empty(Local3[1]), .T., bip(600, 1) .AND. bip(500, 1))}, ;
      Nil, {++Local1}):display())
   @ Local2++, 15 say "Inicializacao.......:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[2]) .OR. Type(Local3[2]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Ativa expandido.....:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[3]) .OR. Type(Local3[3]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Desativa Expandido..:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[4]) .OR. Type(Local3[4]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Impressao 12 cpp....:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[5]) .OR. Type(Local3[5]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Impressao Normal....:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[6]) .OR. Type(Local3[6]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Ativa Comprimido....:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[7]) .OR. Type(Local3[7]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Desativa Comprimido.:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[8]) .OR. Type(Local3[8]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Ativa Negrito.......:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[9]) .OR. Type(Local3[9]) = "C", .T., bip(600, ;
      1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Desativa Negrito....:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[10]) .OR. Type(Local3[10]) = "C", .T., ;
      bip(600, 1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Ativa Italico.......:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[11]) .OR. Type(Local3[11]) = "C", .T., ;
      bip(600, 1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Desativa Italico....:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[12]) .OR. Type(Local3[12]) = "C", .T., ;
      bip(600, 1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Tamanho da Pagina...:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[13]) .OR. Type(Local3[13]) = "C", .T., ;
      bip(600, 1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Efeito Especial 1...:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[14]) .OR. Type(Local3[14]) = "C", .T., ;
      bip(600, 1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Efeito Especial 2...:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[15]) .OR. Type(Local3[15]) = "C", .T., ;
      bip(600, 1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   @ Local2++, 15 say "Efeito Especial 3...:"
   SetPos(Row(), Col() + 1)
   AAdd(Local5, __GetA({|| Local3}, "G_127Mare", "@s30", {|| ;
      iif(Empty(Local3[16]) .OR. Type(Local3[16]) = "C", .T., ;
      bip(600, 1) .AND. bip(500, 1))}, Nil, {++Local1}):display())
   tratacurso(.T.)
   ReadModal(Local5)
   Local5:= {}
   tratacurso(.F.)
   set color to (Local4)
   if (Empty(Local3[1]))
      keyboard Chr(27)
   endif
   bip(400, 3)
   if (alert("Confirma?", {"Sim", "N„o"}) == 1)
      if (lTabela)
         append blank
      endif
      for Local1:= 1 to FCount()
         fieldput(Local1, Local3[Local1])
      next
   endif
   closewindo()
   g_123xypz:= RecNo()
   saibotao()
   unlock
   return ""

********************************
static function TRATACURSO(tipocurs)

   if (ValType(tipocurs) != "L")
      if (setcursor() != 0)
         if (readinsert())
            readinsert(.F.)
         else
            readinsert(.T.)
         endif
         if (readinsert())
            setcursor(2)
         else
            setcursor(1)
         endif
      endif
   elseif (tipocurs)
      if (readinsert())
         setcursor(2)
      else
         setcursor(1)
      endif
   else
      setcursor(0)
   endif
   return ""

********************************
static function TURNOFF

   closewindo()
   return ""

********************************
static function TURNON(nLintur, nColTur, cMenTur)

   local Local1
   Local1:= SetColor()
   set color to (g_cormsg)
   openwindow(nLintur - 2, nColTur - 2, nLInTur + 2, nColTur + Len(cMenTur) + 2, ;
      Nil, Nil, .T., .F., .F., .F.)
   set color to (g_cormsg + "*")
   @ nLintur, nColTur say cMenTur
   set color to (Local1)
   return ""

********************************
function LPP( nLlp )

   if (nLlp = Nil)
      nLlp:= 9999999.0
   endif
   if (nLlp == 0)
      nLlp:= 9999999.0
   endif
   if (g_019oxoss != 2)
      g_055marte:= nLlp
   endif
   return ""

********************************
function LINHASPG(nLsp)

   if (nLsp = Nil)
      nLsp:= 9999999.0
   endif
   if (nLsp == 0)
      nLsp:= 9999999.0
   endif
   if (g_019oxoss != 2)
      g_055marte:= nLsp
   endif
   return ""

********************************
function QUEBRA(cQuebra)

   if (g_054jupte)
      return ""
   endif
   if (!g_113marau)
      g_025musta++
      g_022trash[g_025musta]:= cQuebra
      g_114beauf[g_025musta]:= &cQuebra
   endif
   return ""

********************************
function SALTAPAGIN

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      eject
   endif
   return ""

********************************
function DATA

   return DToC(Date())

********************************
function SOMA(cArg1)

   local Local1, Local2
   if (g_054jupte)
      return 0
   endif
   Local2:= ascan(g_116lagg, g_098bhor)
   if (g_102tempe)
      Local1:= g_117yak[Local2]
      g_117yak[Local2]:= 0
   else
      Local1:= &cArg1
   endif
   return Local1

********************************
function ABRENADA

   return ""

********************************
function ZERALINHA

   if (g_054jupte)
      return ""
   endif
   g_086linha:= 0
   return ""

********************************
function DBCADPRINT(nArg1, nArg2)

   local Local1:= Row(), Local2:= SetColor()
   set color to (g_cormenu)
   if (RecNo() - (Local1 - 9) > 0)
      @ 18, 37 say ""
   else
      @ 18, 37 say "Ä"
   endif
   if (RecNo() + (17 - Local1) < LastRec())
      @ 18, 38 say ""
   else
      @ 18, 38 say "Ä"
   endif
   set color to (Local2)
   if (LastKey() = K_ESC .OR. LastKey() = K_ENTER)
      return 0
   endif
   return 1

********************************
function PAGINA

   return g_041sabba

********************************
function EXTENSO(cValor)

   local Local1:= {"", "HUM ", "DOIS ", "TRES ", "QUATRO ", ;
      "CINCO ", "SEIS ", "SETE ", "OITO ", "NOVE "}, Local2:= {"", ;
      "XXX", "DOZE ", "TREZE ", "QUATORZE ", "QUINZE ", ;
      "DEZESSEIS ", "DEZESSETE ", "DEZOITO ", "DEZENOVE "}, Local3:= ;
      {"", "XXX", "VINTE ", "TRINTA ", "QUARENTA ", "CINQUENTA ", ;
      "SESSENTA ", "SETENTA ", "OITENTA ", "NOVENTA "}, Local4:= ;
      {"", "CENTO ", "DUZENTOS ", "TREZENTOS ", "QUATROCENTOS ", ;
      "QUINHENTOS ", "SEISCENTOS ", "SETECENTOS ", "OITOCENTOS ", ;
      "NOVECENTOS "}, Local5:= {"TRILHOES, ", "BILHOES, ", ;
      "MILHOES, ", "MIL ", ""}, Local6:= {"TRILHAO, ", "BILHAO, ", ;
      "MILHAO, ", "MIL ", ""}, Local7:= strzero(cValor, 18, 2), ;
      Local8:= "", Local9:= 0, Local10, Local11, Local12, Local13
   for Local10:= 1 to 13 step 3
      Local9++
      if (SubStr(Local7, Local10, 3) = "000")
         loop
      endif
      if (Local9 = 5 .AND. !Empty(Local8))
         Local8:= Local8 + "E "
      endif
      if (SubStr(Local7, Local10, 3) = "100")
         Local8:= Local8 + ("CEM " + Local5[Local9])
         loop
      endif
      if (SubStr(Local7, Local10, 3) = "001")
         Local8:= Local8 + ("HUM " + Local6[Local9])
         loop
      endif
      Local11:= SubStr(Local7, Local10, 1)
      Local12:= SubStr(Local7, Local10 + 1, 1)
      Local13:= SubStr(Local7, Local10 + 2, 1)
      Local8:= Local8 + Local4[Val(Local11) + 1]
      if (Local12 + Local13 = "10")
         Local8:= Local8 + (iif(Local11 = "0", "", "E ") + "DEZ " + ;
            Local5[Local9])
         loop
      elseif (Local12 + Local13 = "11")
         Local8:= Local8 + (iif(Local11 = "0", "", "E ") + "ONZE " + ;
            Local5[Local9])
         loop
      endif
      if (Local12 = "1")
         Local8:= Local8 + (iif("0" $ Local11 + Local12, "", "E ") + ;
            Local2[Val(Local13) + 1] + Local5[Local9])
         loop
      else
         Local8:= Local8 + (iif("0" $ Local11 + Local12, "", "E ") + ;
            Local3[Val(Local12) + 1])
      endif
      Local8:= Local8 + (iif(Local11 + Local12 = "00" .OR. Local13 = ;
         "0", "", "E ") + Local1[Val(Local13) + 1] + Local5[Local9])
   next
   if (!Empty(Local8))
      if (Local8 == "HUM ")
         Local8:= Local8 + "CRUZEIRO REAL "
      elseif (right(Local8, 2) = ", ")
         Local8:= Left(Local8, Len(Local8) - 2) + ;
            " DE CRUZEIROS REAIS"
      else
         Local8:= Local8 + "CRUZEIROS REAIS "
      endif
   endif
   Local11:= SubStr(Local7, 17, 1)
   Local12:= SubStr(Local7, 18, 1)
   if (Local11 + Local12 != "00")
      Local8:= Local8 + "E "
      if (Local11 + Local12 = "10")
         Local8:= Local8 + "DEZ "
      elseif (Local11 + Local12 = "11")
         Local8:= Local8 + "ONZE "
      elseif (Local11 = "1")
         Local8:= Local8 + Local2[Val(Local12) + 1]
      else
         Local8:= Local8 + (Local3[Val(Local11) + 1] + ;
            Local1[Val(Local12) + 1])
      endif
      Local8:= Local8 + iif(Local11 + Local12 = "01", "CENTAVO", ;
         "CENTAVOS")
   endif
   return Local8

********************************
function SALTALINHA(nLinSal)

   if (g_054jupte)
      return ""
   endif
   g_086linha:= g_086linha + iif(nLInSal = 0, 1, nLInSal)
   DevPos(PRow(), 0)
   return ""

* EOP GENE04.PRG