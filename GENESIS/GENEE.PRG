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


* eop gene01.prg* bop gene02.prg
********************************
function CPI12

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("12CPI")
   endif
   return ""

********************************
static function CRIATMP

   local Local1:= alias(), Local2:= .F., Local3, Local4, Local5
   if (!file(Local1 + ".Tmp"))
      Local2:= .T.
   else
      use (Local1 + ".Tmp") alias Temp new shared
      if (FLock())
         Local2:= .T.
      else
         Local2:= .F.
      endif
      close
      select (Local1)
   endif
   if (Local2)
      Local3:= dbstruct()
      for Local4:= 1 to Len(Local3)
         if (Local3[Local4][2] = "M")
            Local3[Local4][2]:= "C"
            Local3[Local4][3]:= 1
            Local3[Local4][3]:= 0
         endif
      next
      dbcreate(Local1 + ".Tmp", Local3)
      use (Local1 + ".Tmp") shared
      FLock()
      append blank
      for Local5:= 1 to FCount()
         if (ValType(fieldget(Local5)) = "C")
            fieldput(Local5, Replicate("X", Len(fieldget(Local5))))
         elseif (ValType(fieldget(Local5)) = "D")
            fieldput(Local5, CToD("11/11/11"))
         elseif (ValType(fieldget(Local5)) = "N")
            fieldput(Local5, 1)
         endif
      next
   else
      use (Local1 + ".Tmp") shared
   endif
   return ""

********************************
static function CRIPT(cMensagem, nMensagem)

   local Local1:= {123, 56, 162, 151, 37, 158, 159, 150, 101, 88, ;
      160, 162, 25, 32, 77, 144, 160, 161, 108, 67, 100, 83, 44, ;
      132, 152, 156, 125, 101, 100, 99}, Local2:= "", Local3
   if (nMensagem = Nil)
      nMensagem := 1
   endif
   for Local3:= 1 to Len(cMensagem)
      if (nMensagem > 30)
         nMensagem:= 1
      endif
      Local2:= Local2 + Chr(Asc(SubStr(cMensagem, Local3, 1)) + ;
         Local1[nMensagem])
      nMensagem++
   next
   return Local2

********************************
static function DESCEPAGIN

   keyboard Replicate(Chr(3), 9)
   return ""

********************************
static function DESCRIPT(cMensaDec , nMensaDec)

   local Local1:= {123, 56, 162, 151, 37, 158, 159, 150, 101, 88, ;
      160, 162, 25, 32, 77, 144, 160, 161, 108, 67, 100, 83, 44, ;
      132, 152, 156, 125, 101, 100, 99}, Local2:= "", Local3
   if (nMensaDec = Nil)
      nMensaDec:= 1
   endif
   for Local3:= 1 to Len(cMensaDec)
      if (nMensaDec > 30)
         nMensaDec := 1
      endif
      Local2:= Local2 + Chr(Asc(SubStr(cMensaDec, Local3, 1)) - ;
         Local1[nMensaDec])
      nMensaDec++
   next
   return Local2

********************************
function DIGITAR(cMensa1, cMensa2, cMensa3)

   local Local1:= "", Local2, Local3:= {}
   if (g_054jupte)
      return ""
   endif
   if (Upper(cMensa2) = "D")
      Local1:= CToD("  /  /  ")
   elseif (Upper(cMensa2) = "N")
      Local1:= 0
   else
      Local1:= Space(Len(cMensa3))
   endif
   Local2:= Int((80 - (Len(cMensa3) + Len(cMensa1) + 4)) / 2)
   openwindow(10, Local2, 14, 80 - Local2, Nil, Nil, .F., .F., .F., ;
      .T.)
   @ 12, Local2 + 1 say cMensa1
   SetPos(Row(), Col() + 1)
   AAdd(Local3, __Get({|_1| iif(ISNIL(_1), Local1, Local1:= _1)}, ;
      "G_119Klingon", cMensa3, Nil, Nil):display())
   tratacurso(.T.)
   ReadModal(Local3)
   Local3:= {}
   tratacurso(.F.)
   closewindo()
   return Local1

********************************
function ERROGENESI(oErro)

   local Local1, Local2, Local3, Local4
   Local1:= SetColor()
   Local4:= {"Argumento inv lido", ;
      "Opera‡„o inv lida envolvendo matriz", ;
      "Estouro: String maior que 65519 caracteres", ;
      "Estouro: Valor num‚rico muito grande", "Divis„o por zero", ;
      "Estouro: Valor num‚rico muito grande", "Erro de sintaxe", ;
      "Opera‡„o muito complexa", " ", " ", "Mem¢ria insuficiente", ;
      "Fun‡„o indefinida", "M‚todo n„o export vel", ;
      "Vari vel n„o definida", "Alias n„o definido", ;
      "Vari vel n„o export vel", " ", " ", " ", ;
      "Arquivo n„o pode ser criado", "Arquivo n„o pode ser aberto", ;
      "Arquivo n„o pode ser fechado", "Erro na leitura do arquivo", ;
      "Erro na grava‡„o do arquivo", "Falha na impress„o", " ", " ", ;
      " ", " ", "Opera‡„o n„o suportada", ;
      "Limite de ¡ndices excedido", "Arquivo corrompido", ;
      "Atribui‡„o de tipos incompat¡veis", ;
      "Estouro: Valor excede tamanho do campo", " ", " ", ;
      "Falha no compartilhamento de arquivos", ;
      "Falha no travamento de arquivo/registro", ;
      "Arquivo aberto apenas para leitura", ;
      "Falha no travamento de arquivo/registro"}
   set device to screen
   set printer to 
   set color to (g_cormsg)
   tratacurso(.F.)
   openwindow(8, 15, 15, 65, Nil, Nil, .F., .F., .F., .T.)
   g_ctrlerro++
   if (g_ctrlerro > 1)
      @ 11, 16 say padc("Erro interno (" + alltrim(Str(procline(2), ;
         5, 0)) + ")", 48)
   elseif (g_103refer >= 0 .AND. g_103refer <= Len(g_referenc))
      @ 10, 16 say padc("Erro detectado na linha " + ;
         Str(g_referenc[g_103refer], 3, 0), 48)
      @ 11, 16 say padc(Local4[oErro:gencode()], 48)
      Local2:= padc(alltrim(Left(g_campo[g_103refer], 48)), 48)
      @ 13, 16 say Local2
      Local3:= At(Left(oErro:operation(), 4), Upper(Local2))
      if (Local3 != 0)
         set color to (g_cormsg + "*")
         @ 12, 15 + Local3 say ""
      endif
      if (procname(2) != "IMPRIME")
         @  9, 16 say padc(procname(2) + "/" + ;
            alltrim(Str(procline(2))), 48)
      endif
   else
      if (g_103refer == -1)
         @ 10, 16 say padc("Erro detectado em express„o de Quebra", ;
            48)
      elseif (g_103refer == -2)
         @ 10, 16 say ;
            padc("Erro detectado em express„o de Subtotal", 48)
      else
         @ 10, 16 say padc("Erro externo ao formato (" + ;
            alltrim(Str(procline(2), 5, 0)) + ")", 48)
      endif
      @ 11, 16 say padc(Local4[oErro:gencode()], 48)
   endif
   clear typeahead
   InKey(0)
   closewindo()
   set color to (Local1)
   g_063hverr:= .T.
   g_ctrlerro--
   if (oErro:gencode() != 25)
      break
   endif
   return .T.

********************************
function ESPECIAL1

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("ESP1")
   endif
   return ""

********************************
function ESPECIAL2

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("ESP2")
   endif
   return ""

********************************
function ESPECIAL3

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("ESP3")
   endif
   return ""

********************************
static function EXCLUIIMP

   g_124asia:= .F.
   if (BOF())
      goto top
   endif
   if (EOF())
      goto bottom
   endif
   if (BOF() .AND. EOF())
      return ""
   endif
   if (!FLock())
      bip(600, 1)
      bip(500, 1)
      alert("Arquivo bloqueado;Aguarde !!")
      return ""
   endif
   bip(400, 3)
   if (alert("Confirma?", {"Sim", "N„o"}) == 1)
      delete
      goto top
   endif
   g_123xypz:= RecNo()
   saibotao()
   return ""

********************************
function EXPANDE

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("EXP+")
   endif
   return ""

********************************
static function FCABECALHO

   local Local1
   if (g_054jupte)
      return ""
   endif
   if (EOF())
      return ""
   endif
   if (g_106xacum)
      if (g_086linha > g_055marte .OR. g_086linha < 0)
         @  0,  0 say ""
         g_086linha:= 0
         Local1:= ascan(g_tipo, "C")
         if (Local1 > 0)
            g_101eka:= g_linha[Local1]
            do while (Local1 <= Len(g_tipo))
               g_103refer:= Local1
               if (g_tipo[Local1] = "*")
                  Local1++
                  loop
               endif
               if (g_tipo[Local1] != "C")
                  exit
               endif
               if (Empty(g_picture[Local1]))
                  g_picture[Local1]:= ""
               endif
               if (Left(g_campo[Local1], 1) = "@")
                  g_095exec:= SubStr(g_campo[Local1], 2)
                  g_095exec:= &g_095exec
               else
                  if (g_101eka < g_linha[Local1])
                     @ g_086linha + g_101eka - 1,  0 say ""
                     g_101eka:= g_linha[Local1]
                  endif
                  @ g_086linha + g_101eka - 1, iif(g_019oxoss = 2, ;
                     Col(), PCol()) say &(g_campo[Local1]) picture ;
                     alltrim(g_picture[Local1])
               endif
               Local1++
            enddo
         endif
         g_086linha:= iif(g_019oxoss = 2, Row(), PRow())
         g_099niels:= iif(g_019oxoss = 2, Row(), PRow())
         g_231mil++
         g_041sabba:= Str(g_231mil, 3)
         g_100putz:= Local1
      endif
      if (g_019oxoss == 2)
         g_106xacum:= .F.
      endif
   elseif (g_019oxoss == 2 .AND. g_086linha > g_055marte)
      @ 24,  1 say "Pressione alguma tecla para continuar..!"
      InKey(0)
      if (LastKey() == K_ESC)
         keyboard Chr(27) + Chr(27)
      endif
      g_086linha:= g_099niels
      @ g_086linha,  0 clear to 24, 79
      @ g_086linha,  0 say ""
   endif
   return ""

********************************
static function FILTRAASPA

   keyboard ["]
   return ""

********************************
static function FILTRASETA

   keyboard Chr(3)
   return ""

********************************
function GENESIS

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
      Local15, Local16, Local17, Local18, Local19, Local20, Local21, ;
      Local22, Local23, Local24, Local25, Local26, Local27, Local28, ;
      Local29, Local30
   parameters g_216tem, g_217e_igu, g_218ao_am, g_219que, g_220voce
   Local30:= {}
   if (procname() != descript("Â}ðÜxçò"))
      bip(50, 6)
      bip(30, 2)
      alert("Arquivo corrompido !!")
      quit
   endif
   private g_001xango
   g_001xango:= iif(Empty(procname(1)), .F., .T.)
   private g_221fez:= .T., g_242queme:= "", jatestou:= .F.
   if (file("\Genesis.Per") .OR. file("\Genesis\Genesis.Per"))
      if (file("\Genesis.Per"))
         g_242queme:= descript(memoread("\Genesis.Per"))
      elseif (file("\Genesis\Genesis.Per"))
         g_242queme:= descript(memoread("\Genesis\Genesis.Per"))
      endif
      if (Left(g_242queme, 12) != SubStr(g_242queme, 13))
         bip(50, 6)
         bip(30, 2)
         alert("Arquivo corrompido !!")
         quit
      endif
      g_221fez:= .F.
      jatestou:= .T.
   endif
   private g_095exec, g_243aux1, g_244aux1, g_245aux1
   if (g_216tem = Nil)
      g_216tem:= ""
   endif
   if (g_217e_igu = Nil)
      g_217e_igu:= "REL"
   endif
   if (g_218ao_am = Nil)
      g_218ao_am:= "."
   endif
   if (g_219que != Nil)
      g_219que:= Upper(g_219que)
   endif
   Local2:= Upper(g_216tem + " " + g_217e_igu + " " + g_218ao_am + ;
      " ")
   Local3:= At("?", Local2)
   if (Local3 != 0)
      ? 
      ? "GENESIS 2.1"
      ? "Chips Micro-Inform tica"
      ? 
      ? "use:  GENESIS /d:DirFormatos  /e:ExtFormatos"
      ? 
      ? ;
         "     /d:DirFormatos  Informa o diret¢rio onde est„o os arquivos de formato"
      ? ;
         "                     (N„o tem efeito sobre DBFs ou quaisquer outros arquivos)"
      ? ;
         "     /e:ExtFormatos  Informa a extens„o dos arquivos de formato"
      ? 
      ? 
      quit
   endif
   Local3:= At("/E:", Local2)
   Local4:= Local3
   if (Local3 != 0)
      g_217e_igu:= SubStr(Local2, Local3 + 3, 3)
      Local3:= At(" ", g_217e_igu)
      if (Local3 != 0)
         g_217e_igu:= Left(g_217e_igu, Local3 - 1)
      endif
      g_216tem:= ""
   endif
   Local3:= At("/D:", Local2)
   Local5:= Local3
   if (Local3 != 0)
      g_218ao_am:= SubStr(Local2, Local3 + 3, 40)
      Local3:= At(" ", g_218ao_am)
      if (Local3 != 0)
         g_218ao_am:= Left(g_218ao_am, Local3 - 1)
      endif
      g_216tem:= ""
   endif
   if (Local4 != 0 .AND. Local5 = 0)
      g_218ao_am:= "."
   endif
   if (Local5 != 0 .AND. Local4 = 0)
      g_217e_igu:= "REL"
   endif
   if (fcreate("CriaDir.bat", 2) > -1)
      @  2,  0 say ""
      Local1:= fopen("CriaDir.bat", 2)
      fwrite(Local1, "@echo off" + Chr(13) + Chr(10) + "ctty nul" + ;
         Chr(13) + Chr(10) + "md " + g_218ao_am + Chr(13) + Chr(10) ;
         + "ctty con" + Chr(13) + Chr(10) + "echo off")
      fclose(Local1)
      run CriaDir.bat
      erase CriaDir.bat
   endif
   if (!g_001xango)
      g_216tem:= "AbreNada()"
   endif
   Local13:= Set(_SET_DELIMITERS)
   Local14:= Set(_SET_INTENSITY)
   Local15:= Set(_SET_MESSAGE)
   Local9:= Set(_SET_EXACT)
   Local10:= Set(_SET_BELL)
   Local11:= Set(_SET_CONFIRM)
   Local12:= Set(_SET_SCOREBOARD)
   Local16:= SetKey(K_CTRL_N)
   Local17:= SetKey(K_CTRL_U)
   Local18:= SetKey(K_DOWN)
   Local19:= SetKey(K_F1)
   Local20:= SetKey(K_F10)
   Local21:= SetKey(K_F2)
   Local22:= SetKey(K_F3)
   Local23:= SetKey(K_F4)
   Local24:= SetKey(K_TAB)
   Local25:= SetKey(K_CTRL_DOWN)
   Local26:= SetKey(K_CTRL_UP)
   set exact off
   set bell off
   set confirm off
   set scoreboard off
   set delimiters off
   set intensity on
   set message to 24 center
   set key K_INS to tratacurso
   tratacurso(.F.)
   private g_019oxoss, g_nomedemo:= descript("Ñ}ôêfí¿Úª¥ïðltŸÑãâ»"), ;
      g_nomeusua, g_serie, g_ctrlerro:= 0, g_238jam[30], ;
      g_225taxma[30], g_226warlu[30], g_227yeste[30], ;
      g_228letit[30], g_229janel:= 0, g_049xuxa, g_cororigi:= ;
      SetColor(), g_241traca:= .T.
   g_nomeusua:= g_nomedemo
   g_serie:= "VERSAO DEMO"
   private g_ambmodel:= "EPSON    ", g_ambinici:= [chr(27) + "@" ], ;
      g_ambexpan:= [chr(27) + "W1" ], g_ambn_exp:= ;
      [chr(27) + "W0" ], g_ambcpi12:= [chr(27) + "M" ], g_ambnorma:= ;
      [chr(27) + "P" ], g_ambcompr:= "chr(15)", g_ambn_com:= ;
      "chr(18)", g_ambnegri:= [chr(27) + "G" ], g_ambn_neg:= ;
      [chr(27) + "H" ], g_ambitali:= ;
      [chr(27) + "t" + chr(0)  + chr(27) + "4"], g_ambn_ita:= ;
      [chr(27) + "5" + chr(27) + "t"     + chr(1)], g_ambt_pag:= "", ;
      g_ambesp1:= "", g_ambesp2:= "", g_ambesp3:= "", g_ambcorpa:= ;
      "w+ /n  ,n  /w  ,n,n,gr+/n  ", g_ambcorme:= ;
      "n  /w  ,w+ /b  ,n,n,w+ /b  ", g_ambcorbo:= ;
      "w+ /r  ,n  /g  ,n,n,w+ /r  ", g_ambcorca:= "w+ /bg ", ;
      g_ambcorre:= "w+ /bg ", g_ambcorla:= "w+ /b  ", g_ambcorms:= ;
      "w+ /r  ", g_ambcorte:= "b  /bg "
   if (file("Genesis.Mem"))
      restore from Genesis additive
   else
      save all like G_Amb* to Genesis
   endif
   private g_corpadra:= iif(iscolor(), g_ambcorpa, ;
      "w  /n  ,n  /w  ,n,n,w+ /n  "), g_cormenu:= iif(iscolor(), ;
      g_ambcorme, "n  /w  ,w  /n  ,n,n,n  /w  "), g_cortela:= ;
      iif(iscolor(), g_ambcorte, "n  /w  "), g_corbotao:= ;
      iif(iscolor(), g_ambcorbo, "wU /n  ,w* /n  "), g_corregua:= ;
      iif(iscolor(), g_ambcorre, "w  /n  "), g_corlayou:= ;
      iif(iscolor(), g_ambcorla, "n  /w  "), g_cormsg:= ;
      iif(iscolor(), g_ambcorms, "n  /w  "), g_corcaixa:= ;
      iif(iscolor(), g_ambcorca, "n  /w  ")
   if (!file("Printer.Drv"))
      Local29:= {{"Modelo", "C", 10, 0}, {"Inicia", "C", 50, 0}, ;
         {"Expande", "C", 50, 0}, {"N_Expande", "C", 50, 0}, ;
         {"Cpi12", "C", 50, 0}, {"Normal", "C", 50, 0}, {"Comprime", ;
         "C", 50, 0}, {"N_Comprime", "C", 50, 0}, {"Negrito", "C", ;
         50, 0}, {"N_Negrito", "C", 50, 0}, {"Italico", "C", 50, 0}, ;
         {"N_Italico", "C", 50, 0}, {"T_Pagina", "C", 50, 0}, ;
         {"Especial1", "C", 50, 0}, {"Especial2", "C", 50, 0}, ;
         {"Especial3", "C", 50, 0}}
      dbcreate("Printer.drv", Local29)
      use Printer.drv new exclusive
      append blank
      replace printer->modelo with g_ambmodel
      replace printer->inicia with g_ambinici
      replace printer->expande with g_ambexpan
      replace printer->n_expande with g_ambn_exp
      replace printer->cpi12 with g_ambcpi12
      replace printer->normal with g_ambnorma
      replace printer->comprime with g_ambcompr
      replace printer->n_comprime with g_ambn_com
      replace printer->negrito with g_ambnegri
      replace printer->n_negrito with g_ambn_neg
      replace printer->italico with g_ambitali
      replace printer->n_italico with g_ambn_ita
      replace printer->t_pagina with g_ambt_pag
      replace printer->especial1 with g_ambesp1
      replace printer->especial2 with g_ambesp2
      replace printer->especial3 with g_ambesp3
      printer->(dbCloseArea())
   endif
   if (!file("Kit.Dbf"))
      Local29:= {}
      for Local6:= 1 to 99
         AAdd(Local29, {"Kit" + strzero(Local6, 2, 0), "C", 15, 0})
      next
      dbcreate("Kit.Dbf", Local29)
      use Kit new exclusive
      append blank
      Local6:= 1
      fieldput(Local6++, "Data()")
      fieldput(Local6++, "Pagina()")
      fieldput(Local6++, "Extenso()")
      fieldput(Local6++, "Digitar(")
      fieldput(Local6++, "LinhasPg(")
      fieldput(Local6++, "ImpCab()")
      fieldput(Local6++, "SaltaLinha()")
      fieldput(Local6++, "ZeraLinha()")
      fieldput(Local6++, "Normal()")
      fieldput(Local6++, "Cpi12()")
      fieldput(Local6++, "Comprime()")
      fieldput(Local6++, "NaoComprime()")
      fieldput(Local6++, "Expande()")
      fieldput(Local6++, "NaoExpande()")
      fieldput(Local6++, "Negrito()")
      fieldput(Local6++, "NaoNegrito()")
      fieldput(Local6++, "Italico()")
      fieldput(Local6++, "NaoItalico()")
      fieldput(Local6++, "Especial1()")
      fieldput(Local6++, "Especial2()")
      fieldput(Local6++, "Especial3()")
      kit->(dbCloseArea())
   endif
   Local27:= SaveScreen(0, 0, 24, 79)
   if (g_219que = Nil)
      set color to w/b
      for Local6:= 0 to 40 step 2
         @  0, Local6 clear to 24, Local6 + 1
         @  0, 79 - Local6 - 1 clear to 24, 79 - Local6
         InKey(0.01)
      next
      @  0,  0,  0, 79 box " "
      SetColor("gr+/r", "i")
      @  0,  0 say descript("Âü˜¶—†Ñ")
      set color to gr+/b
      @  0, 15 say "S‚rie: " + g_serie
      set color to (g_cormenu)
      @  1,  0,  1, 79 box " "
      @ 24,  0, 24, 79 box " "
      set color to (g_cortela)
      @  2,  0, 23, 79 box Replicate("²", 9)
      do while (.T.)
         g_049xuxa:= array(adir(g_218ao_am + "\*." + g_217e_igu))
         adir(g_218ao_am + "\*." + g_217e_igu, g_049xuxa)
         asort(g_049xuxa)
         set color to (g_cormenu)
         @  1,  1 prompt "" message ""
         @  1,  5 prompt "Video" message "Imprime um formato no v¡deo"
         @  1, 13 prompt "Impressora" message ;
            "Imprime um formato na impressora"
         @  1, 26 prompt "Disco" message ;
            "Imprime um formato em um arquivo no disco"
         @  1, 34 prompt "Formata" message "Manuten‡„o de formatos"
         @  1, 44 prompt "Configura" message ;
            "Op‡”es de configura‡„o do sistema"
         @  1, 56 prompt "Sai" message "Sai do GENESIS"
         set key K_ALT_E to g_241traca
         menu to g_019oxoss
         SetKey(K_ALT_E, Nil)
         limparodap()
         do case
         case g_019oxoss == 1
            recados()
         case g_019oxoss = 2 .OR. g_019oxoss = 3 .OR. g_019oxoss = 4 ;
               .OR. g_019oxoss = 5
            if (g_019oxoss == 5)
               if (g_221fez .AND. (jatestou .OR. ;
                     !(file("a:\Genesis.Per") .OR. ;
                     file("b:\Genesis.Per"))))
                  bip(600, 1)
                  bip(500, 1)
                  alert("Op‡„o bloqueada!")
               else
                  jatestou:= .T.
                  g_221fez:= .F.
                  qualformat()
               endif
            else
               qualformat()
            endif
         case g_019oxoss == 6
            set color to (g_cormenu)
            openwindow(2, 44, 6, 62, Nil, Nil, .T., .F., .T., .F.)
            do while (.T.)
               @  3, 45 prompt "Impressora       "
               @  4, 45 prompt "Kit de Utilidades"
               @  5, 45 prompt "Cores            "
               menu to Local28
               do case
               case LastKey() == K_ESC
                  exit
               case Local28 == 1
                  cadprinter()
               case Local28 == 2
                  cadkit()
               case Local28 == 3
                  cores()
                  keyboard Chr(27)
               endcase
            enddo
            closewindo()
            set color to (g_cormenu)
            @  1,  0,  1, 79 box ""
            limparodap()
            set color to (g_cortela)
            @  2,  0, 23, 79 box Replicate("²", 9)
         case g_019oxoss == 7
            exit
         endcase
      enddo
      set color to w/b
      for Local6:= 0 to 40 step 2
         @  0, Local6 clear to 24, Local6 + 1
         @  0, 79 - Local6 - 1 clear to 24, 79 - Local6
         InKey(0.01)
      next
   else
      if (g_219que = "V")
         g_019oxoss:= 2
      elseif (g_219que = "I")
         g_019oxoss:= 3
      elseif (g_219que = "D")
         g_019oxoss:= 4
      endif
      if (g_220voce = Nil)
         g_049xuxa:= array(adir(g_218ao_am + "\*." + g_217e_igu))
         adir(g_218ao_am + "\*." + g_217e_igu, g_049xuxa)
         asort(g_049xuxa)
         qualformat()
      else
         private g_050marre, g_051zika
         if (g_019oxoss == 2)
            imprime(20, g_220voce)
         elseif (g_019oxoss == 3)
            if (!isprinter())
               bip(600, 1)
               bip(500, 1)
               alert("Falha na impress„o. Verifique impressora !!")
            else
               imprime(58, g_220voce)
            endif
         elseif (g_019oxoss == 4)
            set color to (g_cormenu)
            openwindow(8, 25, 13, 52, Nil, Nil, .T., .F., .T., .F.)
            @ 10, 28 say "Nome Arquivo:"
            @ 11, 28 say "Extens„o:"
            g_050marre:= Left(Left(g_220voce, At(".", g_220voce) - ;
               1) + Space(8), 8)
            g_051zika:= "TXT"
            SetPos(10, 42)
            AAdd(Local30, __Get({|_1| iif(ISNIL(_1), g_050marre, ;
               g_050marre:= _1)}, "G_050Marrecuz", "NNNNNNNN", Nil, ;
               Nil):display())
            SetPos(11, 42)
            AAdd(Local30, __Get({|_1| iif(ISNIL(_1), g_051zika, ;
               g_051zika:= _1)}, "G_051Zika", "NNN", Nil, ;
               Nil):display())
            tratacurso(.T.)
            ReadModal(Local30)
            Local30:= {}
            tratacurso(.F.)
            if (LastKey() != K_ESC)
               imprime(58, g_220voce)
            endif
            closewindo()
         endif
      endif
   endif
   if (!Empty(g_216tem))
      close databases
   endif
   SetKey(K_INS, Nil)
   set color to (g_cororigi)
   setcursor(Local7)
   set exact (Local9)
   set bell (Local10)
   set confirm (Local11)
   set scoreboard (Local12)
   set delimiters (Local13)
   set intensity (Local14)
   Set(_SET_MESSAGE, Local15)
   SetKey(K_CTRL_N, Local16)
   SetKey(K_CTRL_U, Local17)
   SetKey(K_DOWN, Local18)
   SetKey(K_F1, Local19)
   SetKey(K_F10, Local20)
   SetKey(K_F2, Local21)
   SetKey(K_F3, Local22)
   SetKey(K_F4, Local23)
   SetKey(K_TAB, Local24)
   SetKey(K_CTRL_DOWN, Local25)
   SetKey(K_CTRL_UP, Local26)
   readexit(Local8)
   RestScreen(0, 0, 24, 79, Local27)
   return Nil

********************************
static function GERA

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8:= SetColor(), Local9:= {}, Local10
   parameters g_024spitf
   private g_041sabba:= "999", g_054jupte:= .T., g_022trash[9], ;
      g_023metal[9], g_021yang:= {}, g_056dharm:= {}, g_053proxi, ;
      g_020yin:= {}, g_tipo:= {}, g_linha:= {}, g_campo:= {}, ;
      g_tamanho:= {}, g_picture:= {}, mem[99], g_aux
   if (g_024spitf = Space(8))
      set color to (g_cormenu)
      openwindow(9, 26, 13, 54, "Novo Formato", Nil, .T., .F., .T., ;
         .F.)
      @ 11, 27 say "Nome do Formato: "
      SetPos(11, Col())
      AAdd(Local9, __Get({|_1| iif(ISNIL(_1), g_024spitf, ;
         g_024spitf:= _1)}, "G_024Spitfire", "NNNNNNNN", Nil, ;
         Nil):display())
      tratacurso(.T.)
      ReadModal(Local9)
      Local9:= {}
      tratacurso(.F.)
      if (Empty(g_024spitf) .OR. LastKey() = K_ESC)
         closewindo()
         close databases
         set color to (Local8)
         tratacurso(.F.)
         return ""
      endif
      g_024spitf:= Upper(alltrim(g_024spitf)) + "." + g_217e_igu
      closewindo()
   endif
   if (!file(g_218ao_am + "\" + g_024spitf))
      Local10:= {}
      AAdd(Local10, {"Tip", "C", 2, 0})
      AAdd(Local10, {"Lin", "N", 2, 0})
      AAdd(Local10, {"Cam", "C", 200, 0})
      AAdd(Local10, {"Tam", "N", 3, 0})
      AAdd(Local10, {"Pic", "C", 20, 0})
      dbcreate(g_218ao_am + "\" + g_024spitf, Local10)
   endif
   if ((g_031marx:= &g_216tem, !Empty(g_216tem) .AND. neterr()))
      close databases
      return ""
   endif
   Local1:= alias()
   Local2:= alias()
   for Local5:= 1 to 250
      select (Local5)
      if (Empty(alias()))
         loop
      endif
/*
      if (g_nomeusua = g_nomedemo .AND. (Year(Date()) > 1994 .OR. ;
            LastRec() > 50))
         bip(50, 6)
         bip(30, 2)
         alert("Vers„o para demonstra‡„o !!")
         quit
      endif
*/
      AAdd(g_021yang, alias())
      criatmp()
   next
   use Kit new shared readonly
   AAdd(g_021yang, alias())
   for Local5:= 1 to 9
      g_022trash[Local5]:= ""
      g_023metal[Local5]:= ""
   next
   afill(mem, 1)
   use (g_218ao_am + "\" + g_024spitf) alias Formatto new exclusive
   if (neterr())
      bip(600, 1)
      bip(500, 1)
      alert("Acesso bloqueado;Formato em edi‡„o;Aguarde !!")
      set color to (Local8)
      tratacurso(.F.)
      close databases
      return ""
   endif
   g_020yin:= {}
   g_tipo:= {}
   g_linha:= {}
   g_campo:= {}
   g_tamanho:= {}
   g_picture:= {}
   Local5:= 0
   Local7:= Day(lupdate())
   set color to (g_cormenu)
   openwindow(10, 22, 15, 57, Nil, Nil, .T., .F., .T., .F.)
   @ 12, 26 say "    Carregando Formato"
   @ 13, 26 say "0%                      100%"
   set color to (SubStr(g_cormenu, 9, 7))
   @ 13, 29 say "°°°°°°°°°°°°°°°°°°°°"
   do while (!EOF())
      @ 13, 29 say Replicate(" ", Int(20 / 100 * (RecNo() / ;
         LastRec() * 100)))
      if (formatto->tip = "XF" .AND. ;
            !pedesenha(Left(Upper(descript(Trim(formatto->cam), ;
            Local7)) + Space(10), 10)))
         close databases
         closewindo()
         set color to (Local8)
         tratacurso(.F.)
         return ""
      endif
      Local5++
      AAdd(g_tipo, formatto->tip)
      AAdd(g_linha, formatto->lin)
      AAdd(g_campo, Left(descript(Trim(formatto->cam), Local7) + ;
         Space(200), 200))
      AAdd(g_tamanho, formatto->tam)
      AAdd(g_picture, formatto->pic)
      if (g_tipo[Local5] = "A " .AND. (file(&(g_campo[Local5])) .OR. ;
            file(&(g_campo[Local5]) + ".Dbf")))
         Local3:= alias()
         use &(g_campo[Local5]) new shared readonly
/*
         if (g_nomeusua = g_nomedemo .AND. (Year(Date()) > 1994 .OR. ;
               LastRec() > 50))
            bip(50, 6)
            bip(30, 2)
            alert("Vers„o para demonstra‡„o !!")
            quit
         endif
*/
         AAdd(g_021yang, alias())
         AAdd(g_056dharm, g_campo[Local5])
         criatmp()
         select (Local3)
      endif
      if (g_tipo[Local5] = "V")
         g_095exec:= &(g_campo[Local5])
      endif
      g_053proxi:= Local5
      AAdd(g_020yin, g_tipo[Local5] + Str(g_linha[Local5], 2, 0) + ;
         geralayout())
      skip 
   enddo
   asort(g_021yang)
   closewindo()
   if (!Empty(Local1))
      select (Local1)
   endif
   __KillRead()
   Local9:= {}
   Local4:= SaveScreen(0, 0, 24, 79)
   if (bigget(1, 0, 12, 79, "Formato: " + g_024spitf) == 1)
      gravaforma()
   endif
   close databases
   RestScreen(0, 0, 24, 79, Local4)
   set color to (Local8)
   tratacurso(.F.)
   return ""

* eop gene02.prg* eop gene03.prg
********************************
static function GERALAYOUT

   local Local1, Local2, Local3, Local4, Local5, Local6:= "", ;
      Local7:= "V", Local8:= "", Local9:= 0, Local10
   private g_aux:= g_tipo[g_053proxi], g_063hverr
   if (Type("G_Aux") != "C")
      return ""
   endif
   if (Empty(g_tipo[g_053proxi]) .OR. g_tipo[g_053proxi] $ ;
         "D XIXFV A U I O F * " .OR. ;
         Left(alltrim(g_campo[g_053proxi]), 1) = "@" .OR. ;
         Left(alltrim(g_campo[g_053proxi]), 1) = "*" .OR. ;
         Left(alltrim(g_campo[g_053proxi]), 1) = "#")
      return ""
   endif
   g_063hverr:= .F.
   Local10:= errorblock({|_1| errovaltyp(_1)})
   begin sequence
      if (ValType(&(g_campo[g_053proxi])) == "U")
         g_063hverr:= .T.
      endif
   end sequence
   errorblock(Local10)
   if (g_063hverr)
      return "­ERRO!"
   endif
   do case
   case !Empty(g_picture[g_053proxi])
      Local4:= alltrim(g_picture[g_053proxi])
      Local3:= At(" ", Local4)
      Local6:= iif(Local3 = 0, Local4, SubStr(Local4, Local3 + 1))
   case ValType(&(g_campo[g_053proxi])) = "D"
      Local6:= "11/11/11"
   case ValType(&(g_campo[g_053proxi])) = "N"
      Local6:= Replicate("9", lennum(&(g_campo[g_053proxi])))
   case ValType(&(g_campo[g_053proxi])) = "C"
      Local6:= &(g_campo[g_053proxi])
   endcase
   return Local6

********************************
static function GRAVAFORMA

   local Local1
   select Formatto
   copy to (g_218ao_am + "\" + stuff(g_024spitf, At(".", ;
      g_024spitf), 4, ".BAK")) all
   if (Len(g_tipo) == 0)
      close databases
      erase (g_218ao_am + "\" + g_024spitf)
      return ""
   endif
   zap
   set color to (g_cormenu)
   openwindow(10, 22, 15, 57, Nil, Nil, .T., .F., .T., .F.)
   @ 12, 26 say "     Gravando Formato"
   @ 13, 26 say "0%                      100%"
   set color to (SubStr(g_cormenu, 9, 7))
   @ 13, 29 say "°°°°°°°°°°°°°°°°°°°°"
   for Local1:= 1 to Len(g_tipo)
      @ 13, 29 say Replicate(" ", Int(20 / 100 * (Local1 / ;
         Len(g_tipo) * 100)))
      g_aux:= g_tipo[Local1]
      if (Type("G_Aux") != "C")
         loop
      endif
      if (Empty(g_tipo[Local1]))
         loop
      endif
      g_aux:= g_campo[Local1]
      if (Type("G_Aux") != "C")
         loop
      endif
      if (Empty(g_campo[Local1]) .AND. g_tipo[Local1] != "* ")
         loop
      endif
      append blank
      replace formatto->tip with g_tipo[Local1]
      replace formatto->lin with g_linha[Local1]
      replace formatto->cam with cript(Trim(g_campo[Local1]), ;
         Day(Date()))
      replace formatto->tam with g_tamanho[Local1]
      replace formatto->pic with g_picture[Local1]
   next
   closewindo()
   return ""

********************************
static function G_241TRACA

   g_241traca:= !g_241traca
   return ""
   return Nil

********************************
static function HELPARQ

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10, Local11, Local12
   Local1:= SetColor()
   private g_074xenon
   teclasform(.F.)
   if ("G_TIPO" $ readvar())
      set color to (g_cormenu)
      openwindow(3, 31, 21, 49, "Tipos", Nil, .T., .F., .T., .F.)
      Local8:= {"D - Descricao  ", "V - Define Var.", ;
         "XI- Senha Imp. ", "XF- Senha Form.", "A - Arquivo    ", ;
         "U - Comando    ", "I - Indice     ", "O - Ordenacao  ", ;
         "F - Filtro     ", "C - Cabecalho  ", "Qn- Quebra  n  ", ;
         "L - Linha      ", "Sn- Subtotal n ", "T - Total geral", ;
         "* - Comentario "}
      @  4, 32 to 20, 48
      set color to (g_corcaixa + SubStr(g_cormenu, 8))
      Local2:= achoice(5, 33, 19, 47, Local8)
      closewindo()
      if (LastKey() != K_ESC .AND. Local2 != 0)
         g_tipo[g_053proxi]:= ;
            SubStr("D V XIXFA U I O F C Q L S T * ", Local2 * 2 - 1, ;
            2)
         keyboard Chr(4)
      endif
   elseif ("G_CAMPO" $ readvar())
      qualarquiv()
      if (LastKey() != K_ESC .AND. g_029quack != 0)
         g_236p_47:= g_021yang[g_029quack]
         select (g_236p_47)
         Local9:= array(FCount())
         Local10:= array(FCount())
         Local11:= array(FCount())
         Local12:= array(FCount())
         g_074xenon:= {}
         afields(Local9, Local10, Local11, Local12)
         for Local4:= 1 to FCount()
            do case
            case Local10[Local4] = "C"
               Local6:= "Caractere "
            case Local10[Local4] = "N"
               Local6:= "Numerico  "
            case Local10[Local4] = "D"
               Local6:= "Data      "
            case Local10[Local4] = "M"
               Local6:= "Memo      "
            case Local10[Local4] = "L"
               Local6:= "Logico    "
            endcase
            if (g_236p_47 = "KIT")
               if (!Empty(fieldget(Local4)))
                  AAdd(g_074xenon, fieldget(Local4))
               endif
            else
               AAdd(g_074xenon, Left(Local9[Local4] + Space(11), 11) ;
                  + Local6 + Str(Local11[Local4], 4, 0) + " " + ;
                  Str(Local12[Local4], 2, 0))
            endif
         next
         asort(g_074xenon)
         g_181macum:= g_021yang[g_029quack]
         set color to (g_cormenu)
         openwindow(3, 24, 23, 56, "Campos do Dbf " + ;
            g_021yang[g_029quack], Nil, .T., .F., .T., .F.)
         @  4, 25 to 22, 55
         set color to (g_corcaixa + SubStr(g_cormenu, 8))
         keyboard Chr(5)
         Local3:= achoice(5, 26, 21, 54, g_074xenon, .T., ;
            "OpcoesCampos")
         if (LastKey() == K_ENTER)
            if (g_021yang[g_029quack] = "KIT")
               Local7:= alltrim(g_074xenon[Local3])
            else
               Local3:= ascan(Local9, ;
                  alltrim(Left(g_074xenon[Local3], 10)))
               Local7:= g_236p_47 + "->" + alltrim(Local9[Local3])
            endif
            Local5:= alltrim(g_campo[g_053proxi])
            if (right(Local5, 1) = "+")
               Local5:= Left(Local5, Len(Local5) - 1)
            endif
            if (!Empty(Local5) .AND. Type(Local5) = "C" .AND. ;
                  Local10[Local3] = "N" .AND. g_021yang[g_029quack] ;
                  != "KIT")
               Local7:= "str(" + Local7 + "," + ;
                  alltrim(Str(Local11[Local3], 4, 0)) + "," + ;
                  alltrim(Str(Local12[Local3], 2, 0)) + ")"
            endif
            if (!Empty(Local5) .AND. Type(Local5) = "C" .AND. ;
                  Local10[Local3] = "D" .AND. g_021yang[g_029quack] ;
                  != "KIT")
               Local7:= iif(g_tipo[g_053proxi] = "O", "dtos(", ;
                  "dtoc(") + Local7 + ")"
            endif
            g_campo[g_053proxi]:= alltrim(g_campo[g_053proxi]) + ;
               Local7
            g_campo[g_053proxi]:= Left(g_campo[g_053proxi] + ;
               Space(200), 200)
            if (Type(g_campo[g_053proxi]) = "C")
               g_tamanho[g_053proxi]:= Len(&(g_campo[g_053proxi]))
            elseif (Type(g_campo[g_053proxi]) = "N")
               g_tamanho[g_053proxi]:= lennum(&(g_campo[g_053proxi]))
            elseif (Type(g_campo[g_053proxi]) = "D")
               g_tamanho[g_053proxi]:= 8
            endif
            keyboard Chr(1) + Chr(6)
         endif
         closewindo()
      endif
   endif
   teclasform(.T.)
   set color to (g_cormenu)
   @ 24,  1 say "³ESC³Sai ³F1³Ajuda ³F2³Outras Teclas"
   set color to (Local1)
   return .T.

********************************
function IMPCAB

   if (!g_054jupte)
      g_086linha:= g_055marte + 1
      fcabecalho()
   endif
   return ""

********************************
static function IMPLAYOUT

   local Local1
   if (isprinter())
      set device to printer
      setprc(0, 0)
      setaprinte("COMP+")
      for Local1:= 1 to Len(g_campo)
         if (Local1 = 1 .OR. PRow() > 58)
            if (Local1 != 1)
               eject
            endif
            setaprinte("EXP+")
            @ PRow(),  0 say "LISTAGEM DO FORMATO: " + g_024spitf
            setaprinte("EXP-")
            @ PRow() + 1,  0 say "EMISSAO: " + DToC(Date())
            @ PRow() + 1,  0 say ;
               "     Tp  Lin  Campo ------------------------------------------------------------------------------------------ Tam Mascara"
            @ PRow() + 1,  0 say ""
         endif
         @ PRow() + 1,  0 say Local1 picture "999"
         @ PRow(), PCol() + 2 say g_tipo[Local1]
         @ PRow(), PCol() + 2 say g_linha[Local1] picture "99"
         @ PRow(), PCol() + 3 say Left(g_campo[Local1], 95)
         @ PRow(), PCol() + 2 say g_tamanho[Local1] picture "999"
         @ PRow(), PCol() + 2 say g_picture[Local1]
         if (!Empty(SubStr(g_campo[Local1], 96, 95)))
            @ PRow() + 1, 14 say SubStr(g_campo[Local1], 96, 95)
         endif
         if (!Empty(SubStr(g_campo[Local1], 191, 10)))
            @ PRow() + 1, 14 say SubStr(g_campo[Local1], 191, 10)
         endif
         skip 
      next
      eject
      setaprinte("COMP-")
      set device to screen
   else
      bip(600, 1)
      bip(500, 1)
      alert("Falha na impress„o. Verifique impressora !!")
   endif
   return ""

********************************
static function IMPRIME

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7:= 0, ;
      Local8:= "", Local9, Local10:= SetColor(), Local11, Local12:= ;
      .F., Local13, Local14, Local15, Local16:= {}
   parameters g_055marte, g_024spitf
   private g_041sabba:= "", g_042zappa:= DToC(Date()), g_043vudu:= ;
      Left(DToC(Date()), 2), g_044karma:= SubStr(DToC(Date()), 4, ;
      2), g_045sila:= right(DToC(Date()), 2), g_046shiva, ;
      g_047prana, mem[99], g_054jupte:= .F., g_114beauf[9], ;
      g_115meteo[9], g_086linha, g_098bhor, g_099niels, g_100putz, ;
      g_101eka, g_102tempe:= .T., g_103refer:= 0, g_106xacum:= .T., ;
      g_063hverr:= .T., g_113marau, g_025musta, g_022trash[9], ;
      g_023metal[9], g_053proxi
   private g_110lavoc:= .T., g_111salam:= 1, g_112intru[9]
   g_112intru[1]:= .T.
   tratacurso(.F.)
   if (!Empty(g_216tem))
      close databases
      g_031marx:= &g_216tem
      if (neterr())
         close databases
         return ""
      endif
   elseif (g_001xango)
      goto top
   endif
   Local2:= alias()
   for Local7:= 1 to 9
      g_022trash[Local7]:= ""
      g_023metal[Local7]:= ""
   next
   afill(mem, 0)
   g_086linha:= -1
   g_231mil:= 1
   g_053proxi:= 1
   g_041sabba:= Str(g_231mil, 3)
   g_tipo:= {}
   g_linha:= {}
   g_campo:= {}
   g_tamanho:= {}
   g_picture:= {}
   g_referenc:= {}
   use (g_218ao_am + "\" + g_024spitf) alias Formatto new shared ;
      readonly
   if (neterr())
      bip(600, 1)
      bip(500, 1)
      alert("Acesso bloqueado;Formato em edi‡„o;Aguarde !!")
      set color to (Local10)
      tratacurso(.F.)
      if (!Empty(g_216tem))
         close databases
      endif
      return ""
   endif
   Local14:= Day(lupdate())
   set color to (g_cormenu)
   openwindow(10, 22, 15, 57, Nil, Nil, .T., .F., .T., .F.)
   @ 12, 26 say "    Carregando Formato"
   @ 13, 26 say "0%                      100%"
   set color to (SubStr(g_cormenu, 9, 7))
   @ 13, 29 say "°°°°°°°°°°°°°°°°°°°°"
   do while (!EOF())
      @ 13, 29 say Replicate(" ", Int(20 / 100 * (RecNo() / ;
         LastRec() * 100)))
      if (formatto->tip = "* " .OR. ;
            Left(descript(Trim(formatto->cam), Local14), 1) = "*")
         skip 
         loop
      endif
      if (formatto->tip = "XI" .AND. ;
            !pedesenha(Left(Upper(descript(Trim(formatto->cam), ;
            Local14)) + Space(10), 10)))
         formatto->(dbCloseArea())
         select (Local2)
         if (!Empty(g_216tem))
            close databases
         endif
         closewindo()
         set color to (Local10)
         tratacurso(.F.)
         return ""
      endif
      AAdd(g_tipo, formatto->tip)
      AAdd(g_linha, formatto->lin)
      AAdd(g_campo, Left(descript(Trim(formatto->cam), Local14) + ;
         Space(200), 200))
      AAdd(g_tamanho, formatto->tam)
      AAdd(g_picture, formatto->pic)
      AAdd(g_referenc, RecNo())
      skip 
   enddo
   closewindo()
   set color to (g_cororigi)
   close
   if (!Empty(Local2))
      select (Local2)
   endif
   Local11:= g_229janel
   if (g_241traca)
      Local13:= errorblock({|_1| errogenesi(_1)})
   endif
   begin sequence
      g_103refer:= ascan(g_tipo, "V ")
      if (g_103refer > 0)
         do while (g_tipo[g_103refer] = "V ")
            tratacurso(.T.)
            g_095exec:= &(g_campo[g_103refer])
            tratacurso(.F.)
            g_103refer++
            if (g_103refer > Len(g_tipo))
               exit
            endif
         enddo
      endif
      g_103refer:= ascan(g_tipo, "U ")
      if (g_103refer > 0)
         do while (g_tipo[g_103refer] = "U ")
            tratacurso(.T.)
            g_095exec:= &(g_campo[g_103refer])
            tratacurso(.F.)
            g_103refer++
            if (g_103refer > Len(g_tipo))
               exit
            endif
         enddo
      endif
      if (LastKey() == K_ESC)
         break
      endif
      g_113marau:= .F.
      g_025musta:= 0
      afill(g_022trash, "")
      afill(g_115meteo, .T.)
      for g_103refer:= 1 to Len(g_tipo)
         if ("QUEBRA(" $ Upper(g_campo[g_103refer]))
            g_095exec:= &(iif(g_campo[g_103refer] = "@", ;
               SubStr(g_campo[g_103refer], 2), g_campo[g_103refer]))
         endif
      next
      g_113marau:= .T.
      private g_116lagg:= {}, g_117yak:= {}
      for g_103refer:= 1 to Len(g_tipo)
         if ("SOMA(" $ Upper(g_campo[g_103refer]))
            AAdd(g_116lagg, g_103refer)
            AAdd(g_117yak, 0)
         endif
      next
      g_103refer:= ascan(g_tipo, "I ")
      if (g_103refer > 0)
         if (!.F.)
            set index to 
         endif
         ordListAdd(Trim(&(g_campo[g_103refer])))
      endif
      Local8:= ""
      Local15:= ""
      g_103refer:= ascan(g_tipo, "O ")
      if (g_103refer > 0)
         Local15:= &("{||" + g_campo[g_103refer] + "}")
         Local8:= g_218ao_am + "\GTMP" + right(Time(), 2) + ;
            SubStr(Time(), 4, 2) + ".Ntx"
      endif
      Local3:= ""
      g_103refer:= ascan(g_tipo, "F ")
      if (g_103refer != 0)
         Local3:= &("{||" + g_campo[g_103refer] + "}")
      endif
      if (!Empty(Local15) .AND. !Empty(Local3) .AND. "5.2" $ ;
            version())
         turnon(12, 25, "Aguarde, organizando arquivo...")
         ordcondset("eval(G_028Filtro)", {|| eval(Local3)}, Nil, ;
            Nil, Nil, Nil, RecNo(), Nil, Nil, Nil, Nil)
         ordcreate(Local8, Nil, "eval(G_239Kenga)", {|| ;
            eval(Local15)}, Nil)
         goto top
         turnoff()
      else
         if (!Empty(Local15))
            turnon(12, 25, "Aguarde, reordenando arquivo...")
            index on eval(G_239Kenga) to (Local8)
            goto top
            turnoff()
         endif
         if (!Empty(Local3))
            set filter to eval(G_028Filtro)
            turnon(12, 24, "Aguarde, posicionando arquivo...")
            goto top
            turnoff()
         endif
      endif
      if (g_019oxoss == 2)
         Local6:= SaveScreen(0, 0, 24, 79)
         Local12:= .T.
         clear screen
         __KillRead()
         Local16:= {}
         set device to screen
      elseif (g_019oxoss == 3)
         turnon(12, 34, "Imprimindo...")
         set device to printer
         setprc(0, 0)
         inicia()
      elseif (g_019oxoss == 4)
         turnon(12, 34, "Imprimindo...")
         set device to printer
         set printer to (alltrim(g_050marre) + "." + g_051zika)
         inicia()
      endif
      do while (!EOF() .AND. InKey() != K_ESC .AND. LastKey() != ;
            K_ESC .AND. nextkey() != 27)
/*
         if (g_nomeusua = g_nomedemo .AND. (Year(Date()) > 1994 .OR. ;
               LastRec() > 10 * 5))
            bip(50, 6)
            bip(30, 2)
            alert("Vers„o para demonstra‡„o !!")
            quit
         endif
*/
         g_103refer:= 0
         for g_025musta:= 1 to 9
            if (!Empty(g_022trash[g_025musta]) .AND. ;
                  (&(g_022trash[g_025musta]) != ;
                  g_114beauf[g_025musta] .OR. ;
                  g_115meteo[g_025musta]) .AND. g_025musta != 9)
               if (Type("ValQuebra[IndQ+1]") = "C")
                  g_114beauf[g_025musta + 1]:= "@@@@@@@@@@"
               elseif (Type("ValQuebra[IndQ+1]") = "N")
                  g_114beauf[g_025musta + 1]:= -9999999999
               elseif (Type("ValQuebra[IndQ+1]") = "D")
                  g_114beauf[g_025musta + 1]:= CToD("01/01/00")
               endif
            endif
         next
         for g_025musta:= 9 to 1 step -1
            if ((g_098bhor:= ascan(g_tipo, "S" + Str(g_025musta, 1, ;
                  0)), !Empty(g_022trash[g_025musta]) .AND. ;
                  &(g_022trash[g_025musta]) != ;
                  g_114beauf[g_025musta] .AND. ;
                  !g_115meteo[g_025musta] .AND. g_098bhor != 0))
               fcabecalho()
               g_101eka:= g_linha[g_098bhor]
               do while (g_098bhor <= Len(g_tipo))
                  g_103refer:= g_098bhor
                  if (g_tipo[g_098bhor] != "S" + Str(g_025musta, 1, ;
                        0))
                     exit
                  endif
                  if (Empty(g_picture[g_098bhor]))
                     g_picture[g_098bhor]:= ""
                  endif
                  if (Left(g_campo[g_098bhor], 1) = "#")
                     Local9:= processaco()
                     if (Local9 == 1)
                        loop
                     elseif (Local9 == 2)
                        exit
                     endif
                  elseif (g_112intru[g_111salam])
                     if (Left(g_campo[g_098bhor], 1) = "@")
                        g_095exec:= SubStr(g_campo[g_098bhor], 2)
                        g_095exec:= &g_095exec
                     else
                        if (g_101eka < g_linha[g_098bhor])
                           @ g_086linha + g_101eka - 1,  0 say ""
                           g_101eka:= g_linha[g_098bhor]
                        endif
                        @ g_086linha + g_101eka - 1, iif(g_019oxoss ;
                           = 2, Col(), PCol()) say ;
                           &(g_campo[g_098bhor]) picture ;
                           alltrim(g_picture[g_098bhor])
                     endif
                  endif
                  g_098bhor++
               enddo
               g_086linha:= iif(g_019oxoss = 2, Row(), PRow())
            endif
         next
         g_103refer:= 0
         for g_025musta:= 1 to 9
            if (!Empty(g_022trash[g_025musta]) .AND. ;
                  (&(g_022trash[g_025musta]) != ;
                  g_114beauf[g_025musta] .OR. g_115meteo[g_025musta]))
               fcabecalho()
               g_098bhor:= ascan(g_tipo, "Q" + Str(g_025musta, 1, 0))
               g_101eka:= g_linha[g_098bhor]
               do while (g_098bhor <= Len(g_tipo))
                  g_103refer:= g_098bhor
                  if (g_tipo[g_098bhor] != "Q" + Str(g_025musta, 1, ;
                        0))
                     exit
                  endif
                  if (Empty(g_picture[g_098bhor]))
                     g_picture[g_098bhor]:= ""
                  endif
                  if (Left(g_campo[g_098bhor], 1) = "#")
                     Local9:= processaco()
                     if (Local9 == 1)
                        loop
                     elseif (Local9 == 2)
                        exit
                     endif
                  elseif (g_112intru[g_111salam])
                     if (Left(g_campo[g_098bhor], 1) = "@")
                        g_095exec:= SubStr(g_campo[g_098bhor], 2)
                        g_095exec:= &g_095exec
                     else
                        if (g_101eka < g_linha[g_098bhor])
                           @ g_086linha + g_101eka - 1,  0 say ""
                           g_101eka:= g_linha[g_098bhor]
                        endif
                        @ g_086linha + g_101eka - 1, iif(g_019oxoss ;
                           = 2, Col(), PCol()) say ;
                           &(g_campo[g_098bhor]) picture ;
                           g_picture[g_098bhor]
                     endif
                  endif
                  g_098bhor++
               enddo
               g_086linha:= iif(g_019oxoss = 2, Row(), PRow())
               g_115meteo[g_025musta]:= .F.
               g_114beauf[g_025musta]:= &(g_022trash[g_025musta])
            endif
         next
         fcabecalho()
         g_098bhor:= ascan(g_tipo, "L")
         if (g_098bhor > 0)
            g_101eka:= g_linha[g_098bhor]
            do while (g_098bhor <= Len(g_tipo))
               g_103refer:= g_098bhor
               if (g_tipo[g_098bhor] != "L")
                  exit
               endif
               if (Empty(g_picture[g_098bhor]))
                  g_picture[g_098bhor]:= ""
               endif
               if (Left(g_campo[g_098bhor], 1) = "#")
                  Local9:= processaco()
                  if (Local9 == 1)
                     loop
                  elseif (Local9 == 2)
                     exit
                  endif
               elseif (g_112intru[g_111salam])
                  if (Left(g_campo[g_098bhor], 1) = "@")
                     g_095exec:= SubStr(g_campo[g_098bhor], 2)
                     g_095exec:= &g_095exec
                  else
                     if (g_101eka < g_linha[g_098bhor])
                        g_101eka:= g_linha[g_098bhor]
                        @ g_086linha + g_101eka - 1,  0 say ""
                     endif
                     @ g_086linha + g_101eka - 1, iif(g_019oxoss = ;
                        2, Col(), PCol()) say &(g_campo[g_098bhor]) ;
                        picture alltrim(g_picture[g_098bhor])
                  endif
               endif
               g_098bhor++
            enddo
         endif
         g_103refer:= -2
         Local7:= 1
         g_102tempe:= .F.
         do while (Local7 <= Len(g_116lagg))
            g_098bhor:= g_116lagg[Local7]
            g_117yak[Local7]:= g_117yak[Local7] + ;
               &(g_campo[g_116lagg[Local7]])
            Local7++
         enddo
         g_102tempe:= .T.
         g_086linha:= iif(g_019oxoss = 2, Row(), PRow())
         if (g_110lavoc)
            skip 
         endif
         if (EOF() .OR. InKey() = K_ESC .OR. LastKey() = K_ESC)
            exit
         endif
      enddo
      for g_025musta:= 9 to 1 step -1
         if ((g_098bhor:= ascan(g_tipo, "S" + Str(g_025musta, 1, ;
               0)), !Empty(g_022trash[g_025musta]) .AND. g_098bhor ;
               != 0))
            fcabecalho()
            g_101eka:= g_linha[g_098bhor]
            do while (g_098bhor <= Len(g_tipo))
               g_103refer:= g_098bhor
               if (g_tipo[g_098bhor] != "S" + Str(g_025musta, 1, 0))
                  exit
               endif
               if (Empty(g_picture[g_098bhor]))
                  g_picture[g_098bhor]:= ""
               endif
               if (Left(g_campo[g_098bhor], 1) = "#")
                  Local9:= processaco()
                  if (Local9 == 1)
                     loop
                  elseif (Local9 == 2)
                     exit
                  endif
               elseif (g_112intru[g_111salam])
                  if (Left(g_campo[g_098bhor], 1) = "@")
                     g_095exec:= SubStr(g_campo[g_098bhor], 2)
                     g_095exec:= &g_095exec
                  else
                     if (g_101eka < g_linha[g_098bhor])
                        @ g_086linha + g_101eka - 1,  0 say ""
                        g_101eka:= g_linha[g_098bhor]
                     endif
                     @ g_086linha + g_101eka - 1, iif(g_019oxoss = ;
                        2, Col(), PCol()) say &(g_campo[g_098bhor]) ;
                        picture alltrim(g_picture[g_098bhor])
                  endif
               endif
               g_098bhor++
            enddo
            g_086linha:= iif(g_019oxoss = 2, Row(), PRow())
         endif
      next
      g_098bhor:= ascan(g_tipo, "T")
      if (g_098bhor > 0)
         fcabecalho()
         g_101eka:= g_linha[g_098bhor]
         do while (g_098bhor <= Len(g_tipo))
            g_103refer:= g_098bhor
            if (g_tipo[g_098bhor] != "T")
               exit
            endif
            if (Empty(g_picture[g_098bhor]))
               g_picture[g_098bhor]:= ""
            endif
            if (Left(g_campo[g_098bhor], 1) = "#")
               Local9:= processaco()
               if (Local9 == 1)
                  loop
               elseif (Local9 == 2)
                  exit
               endif
            elseif (g_112intru[g_111salam])
               if (Left(g_campo[g_098bhor], 1) = "@")
                  g_095exec:= SubStr(g_campo[g_098bhor], 2)
                  g_095exec:= &g_095exec
               else
                  if (g_101eka < g_linha[g_098bhor])
                     @ g_086linha + g_101eka - 1,  0 say ""
                     g_101eka:= g_linha[g_098bhor]
                  endif
                  @ g_086linha + g_101eka - 1, iif(g_019oxoss = 2, ;
                     Col(), PCol()) say &(g_campo[g_098bhor]) ;
                     picture alltrim(g_picture[g_098bhor])
               endif
            endif
            g_098bhor++
         enddo
      endif
      g_086linha:= iif(g_019oxoss = 2, Row(), PRow())
      if (g_019oxoss == 2)
         @ 24,  1 say "Pressione alguma tecla p/continuar ...!"
         InKey(0)
         RestScreen(0, 0, 24, 79, Local6)
      else
         @ g_086linha + 1,  0 say Space(1)
      endif
   end sequence
   if (g_241traca)
      errorblock(Local13)
   endif
   if (g_063hverr .AND. Local12)
      RestScreen(0, 0, 24, 79, Local6)
   endif
   if (!Empty(g_216tem))
      close databases
   endif
   set device to screen
   set printer to 
   if (file(Local8))
      erase (Local8)
   endif
   set color to (Local10)
   tratacurso(.F.)
   do while (g_229janel > Local11)
      closewindo()
   enddo
   return .T.

********************************
function IMP_CAB

   if (!g_054jupte)
      g_086linha:= g_055marte + 1
      fcabecalho()
   endif
   return ""

********************************
static function INSEREVETO

   if (!(g_053proxi = Len(g_tipo) .AND. Empty(g_tipo)))
      AAdd(g_tipo, Space(2))
      AAdd(g_linha, 0)
      AAdd(g_campo, Space(200))
      AAdd(g_tamanho, 0)
      AAdd(g_picture, Space(20))
      AAdd(g_020yin, "")
      ains(g_tipo, g_053proxi)
      ains(g_linha, g_053proxi)
      ains(g_campo, g_053proxi)
      ains(g_tamanho, g_053proxi)
      ains(g_picture, g_053proxi)
      ains(g_020yin, g_053proxi)
      g_tipo[g_053proxi]:= Space(2)
      g_linha[g_053proxi]:= 0
      g_campo[g_053proxi]:= Space(200)
      g_tamanho[g_053proxi]:= 0
      g_picture[g_053proxi]:= Space(20)
      g_020yin[g_053proxi]:= ""
   endif
   @ g_077zaxxo - 1, g_179atire + 2 say Space(g_180no - g_179atire - ;
      2)
   @ g_077zaxxo - 1, g_179atire + 2 say g_053proxi picture "999-"
   @ g_077zaxxo - 1, Col() + 1 say g_tipo[g_053proxi] picture "!9"
   @ g_077zaxxo - 1, Col() + 1 say g_linha[g_053proxi] picture "99"
   @ g_077zaxxo - 1, Col() + 1 say g_campo[g_053proxi] picture ;
      "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
   @ g_077zaxxo - 1, Col() + 1 say g_tamanho[g_053proxi] picture "999"
   @ g_077zaxxo - 1, Col() + 2 say g_picture[g_053proxi] picture "@S8"
   return ""

********************************
function ITALICO

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("ITA+")
   endif
   return ""

********************************
static function LIMPARODAP

   local Local1
   Local1:= SetColor()
   set color to (g_cormenu)
   @ 24,  0
   @ 24, 72 say descript(".XåŽ")
   set color to (Local1)
   return ""

********************************
static function MOSTRATECL

   local Local1
   Local1:= SetColor()
   set color to (g_cormenu)
   openwindow(4, 20, 22, 60, "Outras Teclas", Nil, .F., .F., .F., .T.)
   @  5, 21 clear to 21, 59
   @  6, 25 say "³TAB³      Acessa LayOut"
   @  8, 25 say "³CTRL³ ³³ Sobe 9 linhas"
   @ 10, 25 say "³CTRL³ ³³ Desce 9 linhas"
   @ 12, 25 say "³CTRL³ ³N³ Insere linha"
   @ 14, 25 say "³CTRL³ ³U³ Elimina linha"
   @ 16, 25 say "³F3³ Copia Linhas"
   @ 18, 25 say "³F4³ Programa Teclas"
   @ 20, 25 say "³F10³ Imprime Formato"
   InKey(0)
   closewindo()
   set color to (Local1)
   return ""

********************************
function NAOCOMPRIM

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("COMP-")
   endif
   return ""

********************************
function NAOEXPANDE

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("EXP-")
   endif
   return ""

********************************
function NAOITALICO

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("ITA-")
   endif
   return ""

********************************
function NAONEGRITO

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("NEG-")
   endif
   return ""

********************************
static function NAVEGALAYO(lAtiva)

   local Local1:= 1, Local2:= ascan(g_020yin, g_tipo[g_053proxi] + ;
      Str(g_linha[g_053proxi], 2, 0)), Local3:= "", Local4:= "", ;
      Local5:= SetColor(), Local6, Local7, Local8
   private g_aux, g_086linha:= 13
   if (Local2 == 0)
      return ""
   endif
   if (lAtiva != ".t.")
      limparodap()
      set color to (g_cormenu)
      @ 24,  1 say "³ESC³Sai  ³TAB³Sai"
   endif
   tratacurso(.F.)
   teclasform(.F.)
   do while (.T.)
      Local6:= ascan(g_020yin, Left(g_020yin[Local2], 4))
      Local8:= Local6
      g_086linha:= 13
      Local1:= 1
      Local3:= ""
      set color to (g_corregua)
      @ 13,  0 clear to 13, 79
      @ 13,  0 clear to 23,  1
      for Local7:= 2 to 79
         if ((g_061ops + Local7 - 2) / 10 = Int((g_061ops + Local7 - ;
               2) / 10))
            if (g_061ops + Local7 - 2 < 100)
               @ 13, Local7 say Str(g_061ops + Local7 - 2, 2, 0)
               Local7++
            else
               @ 13, Local7 say Str(g_061ops + Local7 - 2, 3, 0)
               Local7:= Local7 + 2
            endif
         else
            @ 13, Local7 say "."
         endif
      next
      set color to (g_corlayou)
      @ 14,  2 clear to 23, 79
      do while (g_086linha < 22 .AND. Local6 <= Len(g_tipo))
         g_aux:= g_tipo[Local6]
         if (Type("G_Aux") != "C")
            exit
         endif
         if (Empty(g_tipo[Local6]))
            exit
         endif
         if (Left(g_020yin[Local6], 2) $ "* D XIXFV A U I O F E " ;
               .OR. Left(alltrim(g_campo[Local6]), 1) = "*")
            Local6++
            Local8:= Local6
            loop
         endif
         if (Left(g_020yin[Local6], 4) != iif(Local6 = 1, "XXXX", ;
               Left(g_020yin[Local6 - 1], 4)))
            g_086linha++
            set color to (g_corregua)
            @ g_086linha,  0 say Left(g_020yin[Local8], 2)
            Local8:= Local6
            set color to (g_corlayou)
            @ g_086linha,  2 say SubStr(Local3, g_061ops, 78)
            Local3:= ""
         endif
         Local3:= Local3 + SubStr(g_020yin[Local6], 5)
         Local6++
      enddo
      g_086linha++
      set color to (g_corregua)
      if (Local8 <= Len(g_020yin))
         @ g_086linha,  0 say Left(g_020yin[Local8], 2)
      endif
      set color to (g_corlayou)
      @ g_086linha,  2 say SubStr(Local3, g_061ops, 78)
      if (lAtiva = ".t.")
         exit
      endif
      InKey(0)
      do case
      case LastKey() = K_ESC .OR. LastKey() = K_TAB
         exit
      case LastKey() == K_UP
         Local4:= Left(g_020yin[Local2], 4)
         do while ((Left(g_020yin[Local2], 4) = Local4 .OR. ;
               Left(g_020yin[Local2], 2) $ "* D XIXFV A U I O F ") ;
               .AND. Local2 > 1)
            Local2--
         enddo
      case LastKey() == K_DOWN
         Local4:= Left(g_020yin[Local2], 4)
         do while ((Left(g_020yin[Local2], 4) = Local4 .OR. ;
               Left(g_020yin[Local2], 2) $ "* D XIXFV A U I O F ") ;
               .AND. Local2 < Len(g_tipo) .AND. ;
               !Empty(g_020yin[Local2 + 1]))
            Local2++
         enddo
      case LastKey() == K_LEFT
         g_061ops:= g_061ops - 5
         if (g_061ops < 1)
            g_061ops:= 1
         endif
      case LastKey() == K_RIGHT
         g_061ops:= g_061ops + 5
         if (g_061ops > 300)
            g_061ops:= 300
         endif
      case LastKey() == 1
         g_061ops:= 1
      case LastKey() == K_END
         g_061ops:= 80
      endcase
   enddo
   if (lAtiva != ".t.")
      set color to (g_cormenu)
      @ 24,  1 say "³ESC³Sai ³F1³Ajuda ³F2³Outras Teclas"
   endif
   set color to (Local5)
   tratacurso(.T.)
   teclasform(.T.)
   return ""

********************************
function NEGRITO

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("NEG+")
   endif
   return ""

********************************
function NORMAL

   if (g_019oxoss = 3 .OR. g_019oxoss = 4)
      setaprinte("10CPI")
   endif
   return ""

********************************
function OPCOESARQU(g_021yang , nLinOp , Arg3)

   local Local1:= SetColor(), Local2:= Row()
   if (Len(g_021yang) == 0)
      return 0
   endif
   set color to (g_cormenu)
   if (nLinOp - (Local2 - 5) > 0)
      @ 19, 38 say ""
   else
      @ 19, 38 say "Ä"
   endif
   if (nLinOp + (18 - Local2) < Len(g_021yang))
      @ 19, 39 say ""
   else
      @ 19, 39 say "Ä"
   endif
   set color to (Local1)
   if (LastKey() == K_ESC)
      return 0
   elseif (LastKey() == K_ENTER)
      return 1
   elseif (LastKey() >= 65 .AND. LastKey() <= 122)
      set color to (Local1)
      if (Static3)
         keyboard Chr(254)
      endif
      Static3:= !Static3
      return 3
   endif
   return 2

* EOP GENE03.PRG* bop gene04.prg
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