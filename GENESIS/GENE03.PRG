* eop gene03.prg
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

* EOP GENE03.PRG