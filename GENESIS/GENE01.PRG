* bop gene01.prg
#include "common.ch"
#include "inkey.ch"

static Static1:= .F., Static2:= .F., Static3:= .F.

********************************
function ERROVALTYP( ErroValor )

   g_063hverr:= .T.
   break
   return ""

********************************
function ERROTIPOA( ErroTipo )

   g_063hverr:= .T.
   break
   return ""

********************************
function INICIA

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("INI")
   endif
   return ""

********************************
static function APAGAVETOR

   adel(g_tipo, g_053proxi)
   adel(g_linha, g_053proxi)
   adel(g_campo, g_053proxi)
   adel(g_tamanho, g_053proxi)
   adel(g_picture, g_053proxi)
   adel(g_020yin, g_053proxi)
   asize(g_tipo, Len(g_tipo) - 1)
   asize(g_linha, Len(g_linha) - 1)
   asize(g_campo, Len(g_campo) - 1)
   asize(g_tamanho, Len(g_tamanho) - 1)
   asize(g_picture, Len(g_picture) - 1)
   asize(g_020yin, Len(g_020yin) - 1)
   if (g_053proxi > Len(g_tipo))
      AAdd(g_tipo, Space(2))
      AAdd(g_linha, 0)
      AAdd(g_campo, Space(200))
      AAdd(g_tamanho, 0)
      AAdd(g_picture, Space(20))
      AAdd(g_020yin, "")
   endif
   @ g_077zaxxo - 1, g_179atire + 2 say Space(g_180no - g_179atire - ;
      2)
   @ g_077zaxxo - 1, g_179atire + 2 say g_053proxi picture "999-"
   @ g_077zaxxo - 1, Col() + 1 say g_tipo[g_053proxi] picture "!9"
   @ g_077zaxxo - 1, Col() + 1 say g_linha[g_053proxi] picture "99"
   @ g_077zaxxo - 1, Col() + 1 say g_campo[g_053proxi] picture ;
      "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
   @ g_077zaxxo - 1, Col() + 1 say g_tamanho[g_053proxi] picture "999"
   @ g_077zaxxo - 1, Col() + 2 say g_picture[g_053proxi] picture "@S8"
   return ""

********************************
static function BIGGET

   local Local1, Local2:= 0, Local3:= "", Local4:= SetColor(), ;
      Local5:= "C", Local6:= {}, Local7
   parameters g_076qix, g_179atire, g_077zaxxo, g_180no, g_181macum
   private g_053proxi:= 1, g_025musta, g_026tempe, g_027light, ;
      g_028filtr, g_029quack:= 0, g_030micke, g_031marx, ;
      g_032plank:= Space(30), g_033einst:= Space(30), g_034jesus:= ;
      Space(30), g_035crist:= Space(30), g_036krisn:= Space(30), ;
      g_037hare:= Space(30), g_038rama:= Space(30), g_039buda:= ;
      Space(30), g_040black:= Space(30), g_061ops:= 1
   limparodap()
   set color to (g_corpadra)
   openwindow(g_076qix, g_179atire, g_077zaxxo, g_180no, g_181macum, ;
      Nil, .T., .T., .F., .F.)
   set color to (g_corlayou)
   openwindow(13, 0, 23, 79, Nil, Nil, .F., .F., .F., .F.)
   set color to (g_corregua)
   @ 13,  0 clear to 13, 79
   @ 13,  0 clear to 23,  0
   if (Len(g_020yin) != 0)
      navegalayo(".t.")
   endif
   teclasform(.T.)
   set color to (g_cormenu)
   @ 24,  1 say "³ESC³Sai ³F1³Ajuda ³F2³Outras Teclas"
   for g_053proxi:= 1 to 9999
      if (g_053proxi > Len(g_tipo))
         AAdd(g_tipo, Space(2))
         AAdd(g_linha, 0)
         AAdd(g_campo, Space(200))
         AAdd(g_tamanho, 0)
         AAdd(g_picture, Space(20))
         AAdd(g_020yin, "")
      endif
      if (nextkey() == 0)
         navegalayo(".t.")
      endif
      set color to (g_corpadra)
      @ g_077zaxxo - 2, g_179atire + 1 to g_077zaxxo - 2, g_180no - 1
      @ g_077zaxxo - 2, g_179atire + 6 say ;
         " Tp Lin Campo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Tam  Mascara"
      @ g_077zaxxo - 1, g_179atire + 2 say Space(g_180no - ;
         g_179atire - 3)
      @ g_077zaxxo - 1, g_179atire + 2 say g_053proxi picture "999-"
      SetPos(g_077zaxxo - 1, Col() + 1)
      AAdd(Local6, __GetA({|| g_tipo}, "G_Tipo", "!!", {|| ;
         chktipo()}, Nil, {g_053proxi}):display())
      SetPos(g_077zaxxo - 1, Col() + 1)
      AAdd(Local6, __GetA({|| g_linha}, "G_Linha", "99", {|| ;
         chklin()}, Nil, {g_053proxi}):display())
      SetPos(g_077zaxxo - 1, Col() + 1)
      AAdd(Local6, __GetA({|| g_campo}, "G_Campo", "@s50", {|| ;
         chkcampo(.F.)}, Nil, {g_053proxi}):display())
      SetPos(g_077zaxxo - 1, Col() + 1)
      AAdd(Local6, __GetA({|| g_tamanho}, "G_Tamanho", "999", Nil, ;
         Nil, {g_053proxi}):display())
      SetPos(g_077zaxxo - 1, Col() + 2)
      AAdd(Local6, __GetA({|| g_picture}, "G_Picture", "@S8", Nil, ;
         Nil, {g_053proxi}):display())
      set key 39 to filtraaspa
      set key K_DOWN to filtraseta
      tratacurso(.T.)
      readexit(.T.)
      do while (.T.)
         ReadModal(Local6)
         if (LastKey() == K_ESC)
            exit
         endif
         if ((LastKey() = K_UP .OR. LastKey() = K_ESC) .AND. ;
               g_053proxi = Len(g_tipo))
            exit
         endif
         if (chktipo() .AND. chkcampo(.T.))
            exit
         endif
         loop
      enddo
      if (g_tipo[g_053proxi] = "V" .AND. updated() .AND. LastKey() ;
            != K_ESC)
         g_095exec:= &(g_campo[g_053proxi])
      endif
      __KillRead()
      Local6:= {}
      readexit(.F.)
      tratacurso(.F.)
      SetKey(39, Nil)
      SetKey(K_DOWN, Nil)
      if (LastKey() == K_ESC)
         bip(400, 3)
         Local5:= alert("Grava Formato?", {"Sim", "N„o"})
         if (Local5 = 1 .OR. Local5 = 2)
            exit
         else
            g_053proxi--
            loop
         endif
      endif
      if (updated())
         if (g_053proxi > Len(g_020yin))
            AAdd(g_020yin, "")
         endif
         g_020yin[g_053proxi]:= g_tipo[g_053proxi] + ;
            Str(g_linha[g_053proxi], 2, 0) + geralayout()
      endif
      if (LastKey() == K_UP)
         if (g_053proxi > 1)
            Scroll(g_076qix + 1, g_179atire + 1, g_077zaxxo - 3, ;
               g_180no - 1, -1)
            Local7:= g_077zaxxo - g_076qix - 1 - g_053proxi
            if (Local7 < 1)
               @ g_076qix + 1, g_179atire + 2 say Abs(Local7) + 1 ;
                  picture "999-"
               SetPos(g_076qix + 1, Col() + 1)
               AAdd(Local6, __GetA({|| g_tipo}, "G_Tipo", "!!", Nil, ;
                  Nil, {Abs(Local7) + 1}):display())
               SetPos(g_076qix + 1, Col() + 1)
               AAdd(Local6, __GetA({|| g_linha}, "G_Linha", "99", ;
                  Nil, Nil, {Abs(Local7) + 1}):display())
               SetPos(g_076qix + 1, Col() + 1)
               AAdd(Local6, __GetA({|| g_campo}, "G_Campo", "@S50", ;
                  Nil, Nil, {Abs(Local7) + 1}):display())
               SetPos(g_076qix + 1, Col() + 1)
               AAdd(Local6, __GetA({|| g_tamanho}, "G_Tamanho", ;
                  "999", Nil, Nil, {Abs(Local7) + 1}):display())
               SetPos(g_076qix + 1, Col() + 2)
               AAdd(Local6, __GetA({|| g_picture}, "G_Picture", ;
                  "@S8", Nil, Nil, {Abs(Local7) + 1}):display())
               __KillRead()
               Local6:= {}
            endif
            g_053proxi:= g_053proxi - 2
         else
            clear typeahead
            g_053proxi:= 0
         endif
      else
         Scroll(g_076qix + 1, g_179atire + 1, g_077zaxxo - 3, ;
            g_180no - 1, 1)
         @ g_077zaxxo - 3, g_179atire + 2 say g_053proxi picture ;
            "999-"
         SetPos(g_077zaxxo - 3, Col() + 1)
         AAdd(Local6, __GetA({|| g_tipo}, "G_Tipo", "!!", Nil, Nil, ;
            {g_053proxi}):display())
         SetPos(g_077zaxxo - 3, Col() + 1)
         AAdd(Local6, __GetA({|| g_linha}, "G_Linha", "99", Nil, ;
            Nil, {g_053proxi}):display())
         SetPos(g_077zaxxo - 3, Col() + 1)
         AAdd(Local6, __GetA({|| g_campo}, "G_Campo", "@s50", Nil, ;
            Nil, {g_053proxi}):display())
         SetPos(g_077zaxxo - 3, Col() + 1)
         AAdd(Local6, __GetA({|| g_tamanho}, "G_Tamanho", "999", ;
            Nil, Nil, {g_053proxi}):display())
         SetPos(g_077zaxxo - 3, Col() + 2)
         AAdd(Local6, __GetA({|| g_picture}, "G_Picture", "@S8", ;
            Nil, Nil, {g_053proxi}):display())
         __KillRead()
         Local6:= {}
      endif
   next
   teclasform(.F.)
   limparodap()
   closewindo()
   closewindo()
   set color to (Local4)
   tratacurso(.F.)
   return Local5

********************************
static function BIP(nFreq, nDura)

   tone(nFreq, nDura)
   return .F.

********************************
static function BOTAO(nLin, nCol, cTitulo)

   local Local1
   Local1:= SetColor()
   cTitulo:= " " + cTitulo + " "
   if (iscolor())
      set color to ("n/" + SubStr(g_cormenu, 5, 3))
      @ nLIn, nCol + Len(cTitulo) say "Ü"
      @ nLin + 1, nCol + 1 say Replicate("ß", Len(cTitulo))
   endif
   set color to (g_corbotao)
   @ nLIn, nCol say cTitulo
   set color to (Local1)
   return ""

********************************
static function BOTAOARQUI

   local Local1
   private g_136clapt:= 1
   set key K_TAB to saibotao
   Local1:= SetColor()
   set color to (g_corbotao)
   do while (.T.)
      @ 16, 42 prompt " Seleciona "
      @ 18, 42 prompt " Cancela "
      menu to g_136clapt
      if (LastKey() == K_PGDN)
         g_136clapt:= 1
         exit
      elseif (LastKey() = K_ESC .OR. g_136clapt = 2)
         keyboard Chr(27)
         exit
      elseif (g_136clapt == 1)
         keyboard Chr(13)
         exit
      endif
   enddo
   set color to (Local1)
   set key K_TAB to botaoarqui
   return ""

********************************
static function BOTAOFORMA(nForma)

   local Local1:= SetColor(), Local2, Local3, Local4:= {}
   private g_136clapt:= 1
   set color to (g_corbotao)
   do while (.T.)
      if (g_019oxoss == 5)
         @ 10, 42 prompt " Seleciona "
         @ 12, 42 prompt " Apaga "
         @ 14, 42 prompt " Duplica "
         @ 16, 42 prompt " Novo "
         @ 18, 42 prompt " Cancela "
         set key K_TAB to tabesc
         menu to g_136clapt
         SetKey(K_TAB, Nil)
         do case
         case LastKey() == K_ESC
            exit
         case g_136clapt == 1
            gera(g_049xuxa[nForma])
            exit
         case g_136clapt == 2
            bip(400, 3)
            if (alert("Confirma?", {"Sim", "N„o"}) == 1)
               use (g_218ao_am + "\" + g_049xuxa[nForma])
               if (neterr())
                  bip(600, 1)
                  bip(500, 1)
                  alert("Acesso bloqueado !!")
               else
                  close
                  erase (g_218ao_am + "\" + g_049xuxa[nForma])
                  keyboard Chr(27) + Chr(13)
               endif
            endif
            exit
         case g_136clapt == 3
            set color to (g_cormenu)
            openwindow(8, 25, 13, 54, "Duplica Formato", Nil, .T., ;
               .F., .T., .F.)
            @ 10, 27 say "Nome Novo Formato:"
            @ 11, 27 say "Extensao:"
            Local2:= Space(8)
            Local3:= g_217e_igu
            SetPos(10, 45)
            AAdd(Local4, __Get({|_1| iif(ISNIL(_1), Local2, Local2:= ;
               _1)}, "G_137Bruce", "NNNNNNNN", Nil, Nil):display())
            SetPos(11, 45)
            AAdd(Local4, __Get({|_1| iif(ISNIL(_1), Local3, Local3:= ;
               _1)}, "G_138Jeff", "NNN", Nil, Nil):display())
            tratacurso(.T.)
            ReadModal(Local4)
            Local4:= {}
            tratacurso(.F.)
            if (LastKey() != K_ESC .AND. !Empty(Local2))
               copy file (g_218ao_am + "\" + g_049xuxa[nForma]) to ;
                  (g_218ao_am + "\" + alltrim(Local2) + "." + Local3)
               keyboard Chr(27) + Chr(13)
            endif
            closewindo()
            exit
         case g_136clapt == 4
            gera(Space(8))
            keyboard Chr(27) + Chr(13)
            exit
         case g_136clapt == 5
            keyboard Chr(27)
            exit
         endcase
      else
         @ 16, 42 prompt " Seleciona "
         @ 18, 42 prompt " Cancela "
         set key K_TAB to tabesc
         menu to g_136clapt
         SetKey(K_TAB, Nil)
         if (LastKey() == K_ESC)
            exit
         elseif (g_136clapt == 1)
            selecmidia(nForma)
            exit
         elseif (g_136clapt == 2)
            keyboard Chr(27)
            exit
         endif
      endif
   enddo
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
   set color to (Local1)
   return g_136clapt

********************************
static function BOTAOIMP

   local Local1, Local2:= Row(), Local3:= printer->modelo + " ", ;
      Local4:= {}
   private g_136clapt:= 1
   SetPos(Local2, 28)
   AAdd(Local4, __Get({|_1| iif(ISNIL(_1), Local3, Local3:= _1)}, ;
      "G_150Eletron", Nil, Nil, Nil):display())
   __KillRead()
   Local4:= {}
   set key K_TAB to saibotao
   Local1:= SetColor()
   set color to (g_corbotao)
   do while (.T.)
      @  9, 42 prompt " Seleciona "
      @ 11, 42 prompt " Inclui "
      @ 13, 42 prompt " Exclui "
      @ 15, 42 prompt " Altera "
      @ 17, 42 prompt " Cancela "
      menu to g_136clapt
      do case
      case LastKey() == K_PGDN
         exit
      case LastKey() = K_ESC .OR. g_136clapt = 5
         keyboard Chr(27)
         exit
      case g_136clapt == 1
         keyboard Chr(13)
         exit
      case g_136clapt == 2
         telaimp(.T.)
      case g_136clapt == 3
         excluiimp()
      case g_136clapt == 4
         telaimp(.F.)
      endcase
   enddo
   set color to (Local1)
   set key K_TAB to botaoimp
   if (g_124asia = .F.)
      keyboard Chr(27)
   endif
   return ""

********************************
static function CADKIT

   local Local1:= SetColor(), Local2:= 1, Local3:= 5, Local4:= 20, ;
      Local5:= 5, Local6, Local7, Local8:= {}
   use Kit new shared
   if (neterr())
      bip(600, 1)
      bip(500, 1)
      alert("Acesso bloqueado !!")
      return ""
   endif
   if (!FLock())
      bip(600, 1)
      bip(500, 1)
      alert("Acesso bloqueado !!")
      kit->(dbCloseArea())
      return ""
   endif
   set color to (g_cormenu)
   openwindow(3, 30, 22, 49, "Kit de Utilidades", Nil, .F., .F., ;
      .F., .T.)
   @  4, 31 to 21, 48
   set color to (g_corcaixa + SubStr(g_cormenu, 8))
   do while (.T.)
      for Local6:= Local3 to Local4
         @ Local6, 32 say fieldget(Local2 - (Local5 - Local3) + ;
            (Local6 - Local3))
      next
      Local7:= fieldget(Local2)
      SetPos(Local5, 32)
      AAdd(Local8, __Get({|_1| iif(ISNIL(_1), Local7, Local7:= _1)}, ;
         "G_133Kant", Nil, Nil, Nil):display())
      tratacurso(.T.)
      readexit(.T.)
      ReadModal(Local8)
      Local8:= {}
      readexit(.F.)
      tratacurso(.F.)
      if (LastKey() == K_ESC)
         exit
      endif
      fieldput(Local2, Local7)
      if (LastKey() == K_UP)
         Local2--
         Local5--
      else
         Local2++
         Local5++
      endif
      if (Local2 > 99)
         Local2:= 99
      endif
      if (Local2 < 1)
         Local2:= 1
      endif
      if (Local5 < Local3)
         Local5:= Local3
      endif
      if (Local5 > Local4)
         Local5:= Local4
      endif
   enddo
   unlock
   kit->(dbCloseArea())
   closewindo()
   set color to (Local1)
   return ""

********************************
static function CADPRINTER

   local Local1:= SetColor(), Local2, Local3:= {"Modelo"}, Local4:= {}
   private g_124asia:= .T., g_123xypz
   use Printer.Drv new shared
   if (neterr())
      bip(600, 1)
      bip(500, 1)
      alert("Acesso bloqueado !!")
      set color to (Local1)
      tratacurso(.F.)
      return ""
   endif
   set filter to !deleted()
   goto top
   g_123xypz:= RecNo()
   set color to (g_cormenu)
   openwindow(5, 25, 19, 56, "Impressoras", Nil, .T., .F., .T., .F.)
   @  7, 27 say "Impressora atual:"
   SetPos(Row(), Col() + 1)
   AAdd(Local4, __Get({|_1| iif(ISNIL(_1), g_ambmodel, g_ambmodel:= ;
      _1)}, "G_AmbModelo", Nil, Nil, Nil):display())
   __KillRead()
   Local4:= {}
   @  9, 27 to 18, 39
   botao(9, 42, "Seleciona")
   botao(11, 42, "Inclui")
   botao(13, 42, "Exclui")
   botao(15, 42, "Altera")
   botao(17, 42, "Cancela")
   keyboard Chr(5)
   do while (.T.)
      g_124asia:= .T.
      goto g_123xypz
      set key K_TAB to botaoimp
      set color to (g_corcaixa + SubStr(g_cormenu, 8))
      dbedit(10, 28, 17, 38, Local3, "dbCadPrinter", "", "", "")
      set color to (Local1)
      SetKey(K_TAB, Nil)
      if (g_124asia)
         exit
      endif
      keyboard Chr(255)
   enddo
   if (LastKey() == K_ENTER)
      g_ambmodel:= printer->modelo
      g_ambinici:= printer->inicia
      g_ambexpan:= printer->expande
      g_ambn_exp:= printer->n_expande
      g_ambcpi12:= printer->cpi12
      g_ambnorma:= printer->normal
      g_ambcompr:= printer->comprime
      g_ambn_com:= printer->n_comprime
      g_ambnegri:= printer->negrito
      g_ambn_neg:= printer->n_negrito
      g_ambitali:= printer->italico
      g_ambn_ita:= printer->n_italico
      g_ambt_pag:= printer->t_pagina
      g_ambesp1:= printer->especial1
      g_ambesp2:= printer->especial2
      g_ambesp3:= printer->especial3
      save all like G_Amb* to Genesis
   endif
   closewindo()
   printer->(dbCloseArea())
   return .T.

********************************
static function CHKCAMPO(lVerivica)

   local Local1:= .F., Local2, Local3, Local4:= alias(), Local5
   private g_063hverr
   if (LastKey() = K_UP .AND. !lVerifica)
      Local1:= .T.
   elseif (g_tipo[g_053proxi] $ "* D XFXIV A I U " .OR. ;
         Left(LTrim(g_campo[g_053proxi]), 1) = "@" .OR. ;
         Left(LTrim(g_campo[g_053proxi]), 1) = "*" .OR. ;
         Left(LTrim(g_campo[g_053proxi]), 1) = "#")
      do case
      case Empty(g_campo[g_053proxi]) .AND. g_tipo[g_053proxi] != "* "
         Local1:= .F.
      case g_tipo[g_053proxi] = "V "
         g_063hverr:= .F.
         Local5:= errorblock({|_1| errovaltyp(_1)})
         begin sequence
            if (ValType(&(g_campo[g_053proxi])) == "U")
               g_063hverr:= .T.
            endif
         end sequence
         errorblock(Local5)
         if (g_063hverr)
            Local1:= .F.
         else
            Local1:= .T.
         endif
      case g_tipo[g_053proxi] = "A "
         if (g_001xango)
            bip(600, 1)
            bip(500, 1)
            alert("Tipo [A] ‚ recurso exclusivo;do m¢dulo execut vel !!")
         elseif (ascan(g_056dharm, g_campo[g_053proxi]) == 0)
            g_235b_52:= g_campo[g_053proxi]
            if (Type(g_campo[g_053proxi]) = "C" .AND. ;
                  (file(&(g_campo[g_053proxi])) .OR. ;
                  file(&(g_campo[g_053proxi]) + ".Dbf")))
               g_063hverr:= .F.
               Local5:= errorblock({|_1| errotipoa(_1)})
               begin sequence
                  use &(g_campo[g_053proxi]) new exclusive readonly
               end sequence
               errorblock(Local5)
               if (!g_063hverr)
                  AAdd(g_021yang, alias())
                  asort(g_021yang)
                  AAdd(g_056dharm, g_campo[g_053proxi])
                  criatmp()
               endif
               select (Local4)
               Local1:= .T.
            endif
         else
            Local1:= .T.
         endif
      case g_tipo[g_053proxi] = "I "
         if (Type(g_campo[g_053proxi]) = "C")
            Local1:= .T.
         endif
      case Left(LTrim(g_campo[g_053proxi]), 1) = "#" .AND. ;
            Left(g_tipo[g_053proxi], 1) $ "QLST"
         do case
         case Upper(Left(g_campo[g_053proxi], 6)) = "#LABEL"
            Local1:= .T.
         case Upper(Left(g_campo[g_053proxi], 5)) = "#SKIP"
            if (Upper(alltrim(SubStr(g_campo[g_053proxi], 6))) = ;
                  "ON" .OR. ;
                  Upper(alltrim(SubStr(g_campo[g_053proxi], 6))) = ;
                  "OFF")
               Local1:= .T.
            endif
         case Upper(Left(g_campo[g_053proxi], 5)) = "#GOTO"
            Local2:= At("#CASE", Upper(g_campo[g_053proxi]))
            if (Local2 == 0)
               Local1:= .T.
            else
               Local3:= alltrim(SubStr(g_campo[g_053proxi], Local2 + ;
                  5))
               Local1:= .T.
            endif
         case Upper(Left(g_campo[g_053proxi], 3)) = "#IF"
            Local3:= alltrim(SubStr(g_campo[g_053proxi], 4))
            Local1:= .T.
         case Upper(Left(g_campo[g_053proxi], 5)) = "#ELSE"
            Local1:= .T.
         case Upper(Left(g_campo[g_053proxi], 6)) = "#ENDIF"
            Local1:= .T.
         endcase
      otherwise
         Local1:= .T.
      endcase
   else
      g_063hverr:= .F.
      Local5:= errorblock({|_1| errovaltyp(_1)})
      begin sequence
         if (ValType(&(g_campo[g_053proxi])) == "U")
            g_063hverr:= .T.
         endif
      end sequence
      errorblock(Local5)
      if (!(g_063hverr .OR. Empty(g_campo[g_053proxi])))
         Local1:= .T.
         tamcampo(g_campo[g_053proxi])
      endif
   endif
   if (!Local1)
      bip(600, 1)
      bip(500, 1)
   endif
   return Local1

********************************
static function CHKLIN

   local Local1
   Local1:= .T.
   if (Left(g_tipo[g_053proxi], 1) $ "CQLST" .AND. ;
         g_linha[g_053proxi] = 0 .AND. LastKey() != K_UP)
      Local1:= .F.
      bip(600, 1)
      bip(500, 1)
   endif
   return Local1

********************************
static function CHKTIPO

   local Local1
   Local1:= .F.
   private g_aux:= g_tipo[g_053proxi]
   if (Type("G_Aux") = "C" .AND. (g_tipo[g_053proxi] $ ;
         "D V XFXIA U F I O C L T * " .OR. Left(g_tipo[g_053proxi], ;
         1) $ "QS" .AND. right(g_tipo[g_053proxi], 1) $ "123456789" ;
         .OR. LastKey() = K_UP .AND. g_053proxi = Len(g_tipo)))
      return .T.
   endif
   if (!Local1)
      bip(500, 1)
      clear typeahead
   endif
   return Local1

********************************
static function CLOSEWINDO

   RestScreen(g_225taxma[g_229janel], g_226warlu[g_229janel], ;
      g_227yeste[g_229janel], g_228letit[g_229janel], ;
      g_238jam[g_229janel])
   g_229janel--
   return ""

********************************
function COMPRIME

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("COMP+")
   endif
   return ""

********************************
static function CONDSUPERI

   local Local1, Local2
   Local2:= .T.
   for Local1:= 1 to g_111salam - 1
      if (!g_112intru[Local1])
         Local2:= .F.
      endif
   next
   return Local2

********************************
static function COPIALINHA

   local Local1:= {}, Local2:= {}, Local3:= {}, Local4:= {}, ;
      Local5:= {}, Local6:= {}, Local7:= 0, Local8:= 0, Local9, ;
      Local10:= SetColor()
   private g_076qix:= 0, g_077zaxxo:= 0
   set color to (g_cormenu)
   openwindow(9, 29, 14, 51, "Copia Linhas", Nil, .T., .F., .T., .F.)
   @ 11, 31 say "Linha Inicial:"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_076qix, g_076qix:= ;
      _1)}, "G_076Qix", "999", {|| iif(g_076qix > 0 .AND. g_076qix ;
      <= Len(g_tipo), .T., bip(600, 1) .AND. bip(500, 1))}, ;
      Nil):display())
   @ 12, 31 say "Linha Final:  "
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), g_077zaxxo, g_077zaxxo:= ;
      _1)}, "G_077Zaxxon", "999", {|| iif(g_077zaxxo >= g_076qix ;
      .AND. g_077zaxxo <= Len(g_tipo), .T., bip(600, 1) .AND. ;
      bip(500, 1))}, Nil):display())
   teclasform(.F.)
   readexit(.F.)
   ReadModal(Local1)
   Local1:= {}
   readexit(.T.)
   teclasform(.T.)
   if (LastKey() != K_ESC)
      for Local7:= g_076qix to g_077zaxxo
         AAdd(Local2, g_tipo[Local7])
         AAdd(Local3, g_linha[Local7])
         AAdd(Local4, g_campo[Local7])
         AAdd(Local5, g_tamanho[Local7])
         AAdd(Local6, g_picture[Local7])
      next
      for Local7:= Len(Local2) to 1 step -1
         AAdd(g_tipo, Nil)
         ains(g_tipo, g_053proxi)
         g_tipo[g_053proxi]:= Local2[Local7]
         AAdd(g_linha, Nil)
         ains(g_linha, g_053proxi)
         g_linha[g_053proxi]:= Local3[Local7]
         AAdd(g_tamanho, Nil)
         ains(g_tamanho, g_053proxi)
         g_tamanho[g_053proxi]:= Local5[Local7]
         AAdd(g_campo, Nil)
         ains(g_campo, g_053proxi)
         g_campo[g_053proxi]:= Local4[Local7]
         AAdd(g_picture, Nil)
         ains(g_picture, g_053proxi)
         g_picture[g_053proxi]:= Local6[Local7]
      next
   endif
   g_020yin:= {}
   Local9:= g_053proxi
   for Local7:= 1 to Len(g_tipo)
      g_053proxi:= Local7
      AAdd(g_020yin, g_tipo[Local7] + Str(g_linha[Local7], 2, 0) + ;
         geralayout())
   next
   g_053proxi:= Local9
   closewindo()
   keyboard Chr(3) + Chr(5)
   set color to (Local10)
   return ""

********************************
static function COPIAUMALI

   local Local1:= {}, Local2:= 0, Local3:= SetColor()
   set color to (g_cormenu)
   openwindow(16, 45, 19, 65, Nil, "w/n", .T., .F., .T., .F.)
   @ 17, 46 say "Linha:"
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), Local2, Local2:= _1)}, ;
      "G_079Zulu", "999", {|| iif(Local2 > 0 .AND. Local2 <= ;
      Len(g_tipo), .T., bip(600, 1) .AND. bip(500, 1))}, ;
      Nil):display())
   teclasform(.F.)
   ReadModal(Local1)
   Local1:= {}
   teclasform(.T.)
   if (LastKey() != K_ESC)
      g_tipo[g_053proxi]:= g_tipo[Local2]
      g_linha[g_053proxi]:= g_linha[Local2]
      g_campo[g_053proxi]:= g_campo[Local2]
      g_tamanho[g_053proxi]:= g_tamanho[Local2]
      g_picture[g_053proxi]:= g_picture[Local2]
   endif
   closewindo()
   keyboard Chr(3) + Chr(5)
   set color to (Local3)
   return ""

********************************
static function CORES

   local Local1:= SetColor(), Local2, Local3:= {}, Local4:= {}, ;
      Local5:= {}, Local6:= 1, Local7:= 0, Local8:= 0, Local9:= 0, ;
      Local10:= 0, Local11:= 0, Local12:= 0, Local13:= " Op‡”es ", ;
      Local14:= " Frente ", Local15:= " Fundo ", Local16:= {}, Local17
   if (iscolor() = .F.)
      bip(600, 1)
      bip(500, 1)
      alert("Recurso n„o disponivel neste equipamento !!")
      return ""
   endif
   setcursor(0)
   limparodap()
   set color to (g_cormenu)
   @ 24,  1 say "³ESC³Sai   ³TAB³Avan‡a   ³SHFTt+TAB³Retorna   "
   openwindow(3, 20, 21, 67, " Defini‡„o de Cores ", Nil, .F., .F., ;
      .F., .T.)
   if (Len(g_corpadra) != 27)
      g_ambcorpa:= "w+ /n  ,n  /w  ,n,n,gr+/n  "
      g_ambcorme:= "n  /w  ,w+ /b  ,n,n,w+ /b  "
      g_ambcorca:= "w+ /bg "
      g_ambcorbo:= "w+ /r  ,n  /g  ,n,n,w+ /r  "
      g_ambcorre:= "w+ /bg "
      g_ambcorla:= "w+ /b  "
      g_ambcorte:= "b  /bg "
   endif
   AAdd(Local3, {" Apresenta‡„o Edi‡„o    ", SubStr(g_ambcorpa, 1, ;
      3), SubStr(g_ambcorpa, 5, 3)})
   AAdd(Local3, {" Selecionado Edi‡„o     ", SubStr(g_ambcorpa, 9, ;
      3), SubStr(g_ambcorpa, 13, 3)})
   AAdd(Local3, {" N„o selecionado Edi‡„o ", SubStr(g_ambcorpa, 21, ;
      3), SubStr(g_ambcorpa, 25, 3)})
   AAdd(Local3, {" Apresenta‡„o Menu      ", SubStr(g_ambcorme, 1, ;
      3), SubStr(g_ambcorme, 5, 3)})
   AAdd(Local3, {" Selecionado Menu       ", SubStr(g_ambcorme, 9, ;
      3), SubStr(g_ambcorme, 13, 3)})
   AAdd(Local3, {" N„o Selecionado Menu   ", SubStr(g_ambcorme, 21, ;
      3), SubStr(g_ambcorme, 25, 3)})
   AAdd(Local3, {" Caixa Op‡”es Menu      ", SubStr(g_ambcorca, 1, ;
      3), SubStr(g_ambcorca, 5, 3)})
   AAdd(Local3, {" Bot„o Selecionado      ", SubStr(g_ambcorbo, 9, ;
      3), SubStr(g_ambcorbo, 13, 3)})
   AAdd(Local3, {" Bot„o N„o Selecionado  ", SubStr(g_ambcorbo, 1, ;
      3), SubStr(g_ambcorbo, 5, 3)})
   AAdd(Local3, {" R‚gua Lay-Out          ", SubStr(g_ambcorre, 1, ;
      3), SubStr(g_ambcorre, 5, 3)})
   AAdd(Local3, {" Lay-Out                ", SubStr(g_ambcorla, 1, ;
      3), SubStr(g_ambcorla, 5, 3)})
   AAdd(Local3, {" Fundo Tela Principal   ", SubStr(g_ambcorte, 1, ;
      3), SubStr(g_ambcorte, 5, 3)})
   AAdd(Local4, {6, 53, "n  "})
   AAdd(Local4, {6, 56, "b  "})
   AAdd(Local4, {6, 59, "g  "})
   AAdd(Local4, {6, 62, "bg "})
   AAdd(Local4, {7, 53, "r  "})
   AAdd(Local4, {7, 56, "rb "})
   AAdd(Local4, {7, 59, "gr "})
   AAdd(Local4, {7, 62, "w  "})
   AAdd(Local4, {8, 53, "n+ "})
   AAdd(Local4, {8, 56, "b+ "})
   AAdd(Local4, {8, 59, "g+ "})
   AAdd(Local4, {8, 62, "bg+"})
   AAdd(Local4, {9, 53, "r+ "})
   AAdd(Local4, {9, 56, "rb+"})
   AAdd(Local4, {9, 59, "gr+"})
   AAdd(Local4, {9, 62, "w+ "})
   AAdd(Local5, {13, 53, "n  "})
   AAdd(Local5, {13, 56, "b  "})
   AAdd(Local5, {13, 59, "g  "})
   AAdd(Local5, {13, 62, "bg "})
   AAdd(Local5, {14, 53, "r  "})
   AAdd(Local5, {14, 56, "rb "})
   AAdd(Local5, {14, 59, "gr "})
   AAdd(Local5, {14, 62, "w  "})
   set color to (g_cormenu)
   @  5, 51 to 10, 64
   @  5, 54 say Local14
   set color to n
   @  6, 52 say "ÛÛÛ"
   set color to b
   @  6, Col() say "ÛÛÛ"
   set color to g
   @  6, Col() say "ÛÛÛ"
   set color to bg
   @  6, Col() say "ÛÛÛ"
   set color to r
   @  7, 52 say "ÛÛÛ"
   set color to rb
   @  7, Col() say "ÛÛÛ"
   set color to gr
   @  7, Col() say "ÛÛÛ"
   set color to w
   @  7, Col() say "ÛÛÛ"
   set color to n+
   @  8, 52 say "ÛÛÛ"
   set color to b+
   @  8, Col() say "ÛÛÛ"
   set color to g+
   @  8, Col() say "ÛÛÛ"
   set color to bg+
   @  8, Col() say "ÛÛÛ"
   set color to r+
   @  9, 52 say "ÛÛÛ"
   set color to rb+
   @  9, Col() say "ÛÛÛ"
   set color to gr+
   @  9, Col() say "ÛÛÛ"
   set color to w+
   @  9, Col() say "ÛÛÛ"
   set color to (g_cormenu)
   @ 12, 51 to 15, 64
   @ 12, 54 say Local15
   set color to n
   @ 13, 52 say "ÛÛÛ"
   set color to b
   @ 13, Col() say "ÛÛÛ"
   set color to g
   @ 13, Col() say "ÛÛÛ"
   set color to bg
   @ 13, Col() say "ÛÛÛ"
   set color to r
   @ 14, 52 say "ÛÛÛ"
   set color to rb
   @ 14, Col() say "ÛÛÛ"
   set color to gr
   @ 14, Col() say "ÛÛÛ"
   set color to w
   @ 14, Col() say "ÛÛÛ"
   set color to (g_cormenu)
   @  5, 23 to 18, 48
   SetPos(5, 32)
   AAdd(Local16, __Get({|_1| iif(ISNIL(_1), Local13, Local13:= _1)}, ;
      "G_174Alice", Nil, Nil, Nil):display())
   __KillRead()
   Local16:= {}
   for Local17:= 1 to 12
      @ 5 + Local17, 24 say Local3[Local17][1]
   next
   do while (.T.)
      Local11:= ascan(Local4, {|_1| _1[3] = Local3[Local6][2]})
      if (Local3[Local6][2] $ "n  n+ b  ")
         set color to (Local3[Local6][2] + "/w")
      else
         set color to (Local3[Local6][2] + "/n")
      endif
      @ Local4[Local11][1], Local4[Local11][2] say ""
      Local12:= ascan(Local5, {|_1| _1[3] = Local3[Local6][3]})
      if (Local3[Local6][3] $ "n  n+ b  ")
         set color to (Local3[Local6][3] + "/w")
      else
         set color to (Local3[Local6][3] + "/n")
      endif
      @ Local5[Local12][1], Local5[Local12][2] say ""
      set color to (Local3[Local6][2] + "/" + Local3[Local6][3])
      @ 19, 23 say "TEXTO TEXTO TEXTO TEXTO TEXTO TEXTO TEXTO."
      @ 20, 23 say "texto texto texto texto texto texto texto."
      set color to (g_cormenu)
      SetPos(Local6 + 5, 24)
      AAdd(Local16, __GetA({|| Local3}, "G_165Sky", Nil, Nil, Nil, ;
         {Local6, 1}):display())
      __KillRead()
      Local16:= {}
      if (LastKey() == K_ESC)
         exit
      endif
      InKey(0)
      set color to (g_cormenu)
      if (LastKey() == K_ESC)
         exit
      endif
      @ Local6 + 5, 24 say Local3[Local6][1]
      set color to (Local3[Local6][2] + "/n")
      @ Local4[Local11][1], Local4[Local11][2] say "Û"
      set color to (Local3[Local6][3] + "/n")
      @ Local5[Local12][1], Local5[Local12][2] say "Û"
      if (LastKey() = K_UP .AND. Local6 > 1)
         Local6--
      elseif (LastKey() = K_DOWN .AND. Local6 < 12)
         Local6++
      elseif (LastKey() == K_TAB)
         set color to (g_cormenu)
         @  5, 32 say Local13
         SetPos(5, 54)
         AAdd(Local16, __Get({|_1| iif(ISNIL(_1), Local14, Local14:= ;
            _1)}, "G_175Cooper", Nil, Nil, Nil):display())
         SetPos(Local6 + 5, 24)
         AAdd(Local16, __GetA({|| Local3}, "G_165Sky", Nil, Nil, ;
            Nil, {Local6, 1}):display())
         __KillRead()
         Local16:= {}
         Local7:= Local4[Local11][1]
         Local8:= Local4[Local11][2]
         do while (.T.)
            if (Local3[Local6][3] $ "n  n+ b  ")
               set color to (Local3[Local6][3] + "/w")
            else
               set color to (Local3[Local6][3] + "/n")
            endif
            @ Local5[Local12][1], Local5[Local12][2] say ""
            Local11:= ascan(Local4, {|_1| _1[1] = Local7 .AND. _1[2] ;
               = Local8})
            if (Local4[Local11][3] $ "n  n+ b  ")
               set color to (Local4[Local11][3] + "/w")
            else
               set color to (Local4[Local11][3] + "/n")
            endif
            @ Local7, Local8 say ""
            set color to (Local4[Local11][3] + "/" + ;
               Local5[Local12][3])
            @ 19, 23 say "TEXTO TEXTO TEXTO TEXTO TEXTO TEXTO TEXTO."
            @ 20, 23 say "texto texto texto texto texto texto texto."
            if (LastKey() == K_ESC)
               exit
            endif
            InKey(0)
            @ Local7, Local8 say "Û"
            do case
            case LastKey() == K_SH_TAB
               exit
            case LastKey() == K_ESC
               exit
            case LastKey() = K_UP .AND. Local7 > 6
               Local7--
            case LastKey() = K_DOWN .AND. Local7 < 9
               Local7++
            case LastKey() = K_LEFT .AND. Local8 > 53
               Local8:= Local8 - 3
            case LastKey() = K_RIGHT .AND. Local8 < 62
               Local8:= Local8 + 3
            case LastKey() == K_TAB
               Local3[Local6][2]:= Local4[Local11][3]
               set color to (g_cormenu)
               @  5, 54 say Local14
               SetPos(12, 54)
               AAdd(Local16, __Get({|_1| iif(ISNIL(_1), Local15, ;
                  Local15:= _1)}, "G_176Gilmour", Nil, Nil, ;
                  Nil):display())
               __KillRead()
               Local16:= {}
               if (Local3[Local6][2] $ "n  n+ b  ")
                  set color to (Local3[Local6][2] + "/w")
               else
                  set color to (Local3[Local6][2] + "/n")
               endif
               @ Local4[Local11][1], Local4[Local11][2] say ""
               Local9:= Local5[Local12][1]
               Local10:= Local5[Local12][2]
               do while (.T.)
                  Local12:= ascan(Local5, {|_1| _1[1] = Local9 .AND. ;
                     _1[2] = Local10})
                  if (Local5[Local12][3] $ "n  n+ b  ")
                     set color to (Local5[Local12][3] + "/w")
                  else
                     set color to (Local5[Local12][3] + "/n")
                  endif
                  @ Local9, Local10 say ""
                  set color to (Local4[Local11][3] + "/" + ;
                     Local5[Local12][3])
                  @ 19, 23 say ;
                     "TEXTO TEXTO TEXTO TEXTO TEXTO TEXTO TEXTO."
                  @ 20, 23 say ;
                     "texto texto texto texto texto texto texto."
                  InKey(0)
                  set color to (Local5[Local12][3] + "/n")
                  @ Local9, Local10 say "Û"
                  do case
                  case LastKey() == K_SH_TAB
                     exit
                  case LastKey() == K_ESC
                     exit
                  case LastKey() = K_UP .AND. Local9 > 13
                     Local9--
                  case LastKey() = K_DOWN .AND. Local9 < 14
                     Local9++
                  case LastKey() = K_LEFT .AND. Local10 > 53
                     Local10:= Local10 - 3
                  case LastKey() = K_RIGHT .AND. Local10 < 62
                     Local10:= Local10 + 3
                  endcase
               enddo
               set color to (g_cormenu)
               @ 12, 54 say Local15
               SetPos(5, 54)
               AAdd(Local16, __Get({|_1| iif(ISNIL(_1), Local14, ;
                  Local14:= _1)}, "G_175Cooper", Nil, Nil, ;
                  Nil):display())
               __KillRead()
               Local16:= {}
               Local3[Local6][3]:= Local5[Local12][3]
            endcase
         enddo
         set color to (g_cormenu)
         SetPos(5, 32)
         AAdd(Local16, __Get({|_1| iif(ISNIL(_1), Local13, Local13:= ;
            _1)}, "G_174Alice", Nil, Nil, Nil):display())
         __KillRead()
         Local16:= {}
         @  5, 54 say Local14
         Local3[Local6][2]:= Local4[Local11][3]
      endif
   enddo
   do while (.T.)
      bip(400, 3)
      Local2:= alert("Grava nova configura‡„o de cores?", {"Sim", ;
         "N„o", "Padr„o"})
      set color to (g_corpadra)
      if (Local2 == 1)
         g_ambcorpa:= Local3[1][2] + "/" + Local3[1][3] + "," + ;
            Local3[2][2] + "/" + Local3[2][3] + ",n,n," + ;
            Local3[3][2] + "/" + Local3[3][3]
         g_ambcorme:= Local3[4][2] + "/" + Local3[4][3] + "," + ;
            Local3[5][2] + "/" + Local3[5][3] + ",n,n," + ;
            Local3[6][2] + "/" + Local3[6][3]
         g_ambcorte:= Local3[12][2] + "/" + Local3[12][3]
         g_ambcorbo:= Local3[9][2] + "/" + Local3[9][3] + "," + ;
            Local3[8][2] + "/" + Local3[8][3] + ",n,n," + ;
            Local3[9][2] + "/" + Local3[9][3]
         g_ambcorre:= Local3[10][2] + "/" + Local3[10][3]
         g_ambcorla:= Local3[11][2] + "/" + Local3[11][3]
         g_ambcorca:= Local3[7][2] + "/" + Local3[7][3]
         save all like G_Amb* to Genesis
         g_corpadra:= g_ambcorpa
         g_cormenu:= g_ambcorme
         g_cortela:= g_ambcorte
         g_corbotao:= g_ambcorbo
         g_corregua:= g_ambcorre
         g_corlayou:= g_ambcorla
         g_corcaixa:= g_ambcorca
      elseif (Local2 = 2 .OR. Local2 = 0)
         restore from Genesis additive
      elseif (Local2 == 3)
         g_ambcorpa:= "w+ /n  ,n  /w  ,n,n,gr+/n  "
         g_ambcorme:= "n  /w  ,w+ /b  ,n,n,w+ /b  "
         g_ambcorbo:= "w+ /r  ,n  /g  ,n,n,w+ /r  "
         g_ambcorca:= "w+ /bg "
         g_ambcorre:= "w+ /bg "
         g_ambcorla:= "w+ /b  "
         g_ambcorte:= "b  /bg "
         save all like G_Amb* to Genesis
         g_corpadra:= g_ambcorpa
         g_cormenu:= g_ambcorme
         g_cortela:= g_ambcorte
         g_corbotao:= g_ambcorbo
         g_corregua:= g_ambcorre
         g_corlayou:= g_ambcorla
         g_corcaixa:= g_ambcorca
      endif
      exit
   enddo
   closewindo()
   limparodap()
   set color to (Local1)
   return ""


* eop gene01.prg