********************************
function SETMOUSE(Arg1)

   local Local1
   Local1:= Static7
   default Arg1 to ""
   smmou:= alltrim(Upper(Arg1))
   if (Arg1 = "ON")
      if (ismouse())
         m_reset()
         if (settable())
            m_install(2)
            m_csrput(24, 79)
         endif
         m_csroff()
         Static7:= .T.
      else
         Static7:= .F.
      endif
   elseif (Arg1 = "OFF" .AND. Static7)
      m_csroff()
      Static7:= .F.
   endif
   return Static7

********************************
function SETTABLE(Arg1)

   default Arg1 to " "
   Arg1:= alltrim(Upper(Arg1))
   _tbold:= Static40
   if (Arg1 = "ON")
      if (fontvalid(1) .AND. mswversion() = 0)
         Static42:= fontheight()
         fontsave(0, Static42, 256, 1, @Static41)
         scanlines(350, 0)
         _tblon()
         Static40:= .T.
      endif
   elseif (Arg1 = "OFF" .AND. _tbold)
      if (Static42 == 16)
         scanlines(400, 0)
      else
         scanlines(350, 0)
      endif
      fontload(0, Static42, 256, 1, Static41)
      Static40:= .F.
   endif
   return _tbold

********************************
function SFT_COMP(Arg1, Arg2, Arg3)

   local Local1:= 0, Local2:= 0, Local3:= 0, Local4:= .F., Local5
   Local5:= {{|| alltrim(Arg2) == Left(Upper(arqgad->gad_nom), ;
      Len(alltrim(Arg2)))}, {|| Arg2 == arqgad->gad_reg}, {|| Arg2 ;
      == arqgad->gad_san}, {|| Arg2 == arqgad->gad_sex}, {|| Arg2 == ;
      arqgad->gad_nas}, {|| Arg2 == arqgad->gad_var}, {|| ;
      alltrim(Arg2) == Left(Upper(arqgad->gad_pai), ;
      Len(alltrim(Arg2)))}, {|| alltrim(Arg2) == ;
      Left(Upper(arqgad->gad_mae), Len(alltrim(Arg2)))}}
   default Arg3 to 1
   default Arg1 to 1
   select ArqGad
   set order to Arg3
   goto top
   _openmessa("Por favor espere enquanto imprimo... [ESC] para sair...", ;
      Nil, Nil, Nil)
   if (deviceinit() != 0)
      do while (!EOF())
         if (eval(Local5[Arg1]))
            if (Local1 == 0)
               @ Local1 + 1, Local2 say "" + ;
                  padc("CASA DE CARNE WAGNER RAMOS MOLINA", 40)
               @ Local1 + 2, Local2 say padc("Relatorio Geral", 40)
               @ Local1 + 3, Local2 say Replicate("-", 80)
               Local1:= 5
            endif
            @ Local1++, Local2 say "Controle...: " + ;
               _ntocz(arqgad->gad_con, 4)
            @ Local1++, Local2 say "Nome.......: " + arqgad->gad_nom
            @ Local1++, Local2 say "Registro...: " + arqgad->gad_reg ;
               + "   " + "Grau Sangue.: " + arqgad->gad_san
            @ Local1++, Local2 say "Nascimento.: " + ;
               DToC(arqgad->gad_nas) + "   " + "Sexo...: " + ;
               arqgad->gad_sex + "   Variedade.: " + arqgad->gad_var
            @ Local1++, Local2 say "Pai..: " + arqgad->gad_pai + ;
               "   Registro..: " + arqgad->gad_prg
            @ Local1++, Local2 say "Mae..: " + arqgad->gad_mae + ;
               "   Registro..: " + arqgad->gad_mrg
            Local1:= Local1 + 2
            Local4:= .T.
            if (Local1 > 48)
               Local1:= 52
               @ Local1++, Local2 say Replicate("-", 80)
               @ Local1, Local2 say "Wagner Ramos Molina."
               @ Local1, Local2 say padl("Pagina...: " + ;
                  _ntocz(++Local3, 2), 80)
               Local1:= 0
               Local4:= .F.
            endif
         endif
         skip 
      enddo
      if (Local4)
         Local1:= 52
         @ Local1++, Local2 say Replicate("-", 80)
         @ Local1, Local2 say "Wagner Ramos Molina"
         @ Local1, Local2 say padl("Pagina...: " + _ntocz(++Local3, ;
            3), 80)
         Local1:= 0
         Local4:= .F.
      endif
   endif
   eject
   deviceclos()
   closewindo()
   return .T.

********************************
function SFT_INKEY(Arg1, Arg2)

   local Local1:= Row() + 1, Local2:= 10, Local3, Local4
   Local3:= {}
   Local4:= {{"Nome....:", Space(40), "@!", Nil, 55}, {"Registro:", ;
      Space(17), "!!/!!-!!!!!!!!!!!", Nil, 30}, {"Sangue..:", ;
      Space(4), "!!!!", Nil, 17}, {"Sexo....:", " ", "!", {|| ;
      Local4[Arg1][2] $ "FM"}, 15}, {"Nascimento.:", CToD(Space(8)), ;
      "99/99/99", Nil, 25}, {"Variedade.:", "  ", "!!", Nil, 20}, ;
      {"Pai.....:", Space(40), "@!", Nil, 55}, {"Mae.....:", ;
      Space(40), "@!", Nil, 55}}
   default Local4[Arg1][4] to {|| .T.}
   openwindow(Local1, Local2, Local1 + 2, Local2 + Local4[Arg1][5], ;
      "S", 2, "W+/B")
   @ Local1 + 1, Local2 + 2 say Local4[Arg1][1]
   SetPos(Row(), Col() + 1)
   AAdd(Local3, __GetA({|| Local4}, "nDado", Local4[Arg1][3], {|| ;
      eval(Local4[Arg1][4])}, Nil, {Arg1, 2}):display())
   ReadModal(Local3)
   Local3:= {}
   if (Arg2 == 1)
      sft_list(Arg1, Local4[Arg1][2])
   elseif (Arg2 == 2)
      sft_comp(Arg1, Local4[Arg1][2])
   endif
   closewindo()
   return .T.

********************************
function SFT_LIST(Arg1, Arg2, Arg3)

   local Local1:= 0, Local2:= 0, Local3:= 0, Local4:= .F., Local5
   Local5:= {{|| alltrim(Arg2) == Left(Upper(arqgad->gad_nom), ;
      Len(alltrim(Arg2)))}, {|| Arg2 == arqgad->gad_reg}, {|| Arg2 ;
      == arqgad->gad_san}, {|| Arg2 == arqgad->gad_sex}, {|| Arg2 == ;
      arqgad->gad_nas}, {|| Arg2 == arqgad->gad_var}, {|| ;
      alltrim(Arg2) == Left(Upper(arqgad->gad_pai), ;
      Len(alltrim(Arg2)))}, {|| alltrim(Arg2) == ;
      Left(Upper(arqgad->gad_mae), Len(alltrim(Arg2)))}}
   default Arg3 to 1
   default Arg1 to 1
   select ArqGad
   set order to Arg3
   goto top
   _openmessa("Por favor espere enquanto imprimo... [ESC] para sair...", ;
      Nil, Nil, Nil)
   if (deviceinit() != 0)
      do while (!EOF())
         if (eval(Local5[Arg1]))
            if (Local1 == 0)
               @ Local1 + 1, Local2 say "" + ;
                  padc("CASA DE CARNE WAGNER RAMOS MOLINA", 40)
               @ Local1 + 2, Local2 say padc("Relatorio Geral", 40)
               @ Local1 + 3, Local2 say Replicate("-", 80)
               Local1:= 5
            endif
            @ Local1++, Local2 say Transform(arqgad->gad_con, ;
               "9999") + "  -  " + arqgad->gad_nom + "    " + ;
               arqgad->gad_reg
            Local4:= .T.
            if (Local1 > 50)
               Local1:= 52
               @ Local1++, Local2 say Replicate("-", 80)
               @ Local1, Local2 say "Wagner Ramos Molina"
               @ Local1, Local2 say padl("Pagina...: " + ;
                  _ntocz(++Local3, 2), 80)
               Local1:= 0
               Local4:= .F.
            endif
         endif
         skip 
      enddo
      if (Local4)
         Local1:= 52
         @ Local1++, Local2 say Replicate("-", 80)
         @ Local1, Local2 say "Wagner Ramos Molina."
         @ Local1, Local2 say padl("Pagina...: " + _ntocz(++Local3, ;
            3), 80)
         Local1:= 0
         Local4:= .F.
      endif
   endif
   eject
   deviceclos()
   closewindo()
   return .T.

********************************
function SFT_RELATO

   local Local1
   Local1:= {}
   Local1:= _aaddmenu(Local1, " 1)       pelo Nome ", "SFT_Ropc(1)")
   Local1:= _aaddmenu(Local1, " 2)   pelo Registro ", "SFT_Ropc(2)")
   Local1:= _aaddmenu(Local1, " 3) por Grau Sangue ", "SFT_Ropc(3)")
   Local1:= _aaddmenu(Local1, " 4)       pelo Sexo ", "SFT_Ropc(4)")
   Local1:= _aaddmenu(Local1, " 5) pelo Nascimento ", "SFT_Ropc(5)")
   Local1:= _aaddmenu(Local1, " 6)  pela Variedade ", "SFT_Ropc(6)")
   Local1:= _aaddmenu(Local1, " 7)        pelo Pai ", "SFT_Ropc(7)")
   Local1:= _aaddmenu(Local1, " 8)        pela Mae ", "SFT_Ropc(8)")
   Local1:= _aaddmenu(Local1, "", "-")
   Local1:= _aaddmenu(Local1, " 9)        Retornar ", "~")
   _popmenu(Row() + 1, Col() - 10, Local1, .T., Nil, Nil, Nil, Nil, ;
      Nil, "Relatorios")
   return .T.

********************************
function SFT_ROPC(Arg1)

   local Local1
   Local1:= {}
   Local1:= _aaddmenu(Local1, " 1)      Listagem ", "SFT_Inkey(" + ;
      Str(Arg1) + ",1)")
   Local1:= _aaddmenu(Local1, " 2)         Ficha ", "SFT_Inkey(" + ;
      Str(Arg1) + ",2)")
   Local1:= _aaddmenu(Local1, "", "-")
   Local1:= _aaddmenu(Local1, " 3) Menu anterior ", "~")
   _popmenu(Row() + 1, Col() - 10, Local1, .T., Nil, Nil, Nil, Nil, ;
      Nil, "Relatorio")
   return .T.

********************************
function SHOWDBF1

   if (LastKey() == K_ESC)
      return 0
   endif
   @ Static49 + 1, Static50 + 2 say "Registro [ " + ;
      alltrim(Str(RecNo())) + "/" + alltrim(Str(LastRec())) + ;
      " ]             "
   return 1

********************************
static function SKIPPERARR(Arg1, Arg2)

   local Local1
   Local1:= 0
   if (Static46 + Arg1 < 1)
      Local1:= -Static46 + 1
      Static46:= 1
   elseif (Static46 + Arg1 > Len(Arg2))
      Local1:= Len(Arg2) - Static46
      Static46:= Len(Arg2)
   else
      Local1:= Arg1
      Static46:= Static46 + Arg1
   endif
   return Local1

********************************
function SPLITCOLOR(Arg1)

   local Local1:= 1, Local2, Local3:= {}, Local4, Local5
   default Arg1 to SetColor()
   do while ((Local2:= At(",", Arg1)) != 0)
      Local4:= SubStr(Arg1, 1, Local2 - 1)
      Local5:= At("/", Local4)
      AAdd(Local3, {Left(Local4, Local5 - 1), right(Local4, ;
         Len(Local4) - Local5)})
      Arg1:= SubStr(Arg1, Local2 + 1)
   enddo
   Local5:= At("/", Arg1)
   AAdd(Local3, {Left(Arg1, Local5 - 1), right(Arg1, Len(Arg1) - ;
      Local5)})
   return Local3

********************************
static function STANDRDKEY(Arg1, Arg2, Arg3, Arg4)

   local Local1
   Static47:= .F.
   do case
   case Arg2 == k_up
      Arg1:up()
   case Arg2 == k_down
      Arg1:down()
   case Arg2 == k_left
      Arg1:left()
   case Arg2 == k_right
      Arg1:right()
   case Arg2 == k_home
      Arg1:home()
   case Arg2 == k_end
      Arg1:end()
   case Arg2 == k_pgup
      Arg1:pageup()
   case Arg2 == k_pgdn
      Arg1:pagedown()
   case Arg2 == k_ctrl_pgu
      Arg1:gotop()
   case Arg2 == k_ctrl_pgd
      Arg1:gobottom()
   case Arg2 == k_ctrl_hom
      Arg1:panhome()
   case Arg2 == k_ctrl_end
      Arg1:panend()
   case Arg2 == k_ctrl_lef
      Arg1:panleft()
   case Arg2 == k_ctrl_rig
      Arg1:panright()
   case Arg2 == k_del
      adel(Arg3, Static46)
      asize(Arg3, Len(Arg3) - 1)
      Arg1:refreshall()
      Arg1:stabilize()
   case Arg2 == k_ins
      asize(Arg3, Len(Arg3) + 1)
      ains(Arg3, Static46)
      Arg3[Static46]:= Arg4[1]
      Arg1:refreshall()
      Arg1:stabilize()
   case (Local1:= SetKey(Arg2)) != Nil
      _push_colo(SetColor())
      eval(Local1, {|| (procname(), procline, readvar())})
      _pop_color()
   otherwise
      Static47:= .T.
   endcase
   return Arg3

********************************
function TELAGADO(Arg1, Arg2, Arg3, Arg4)

   local Local1:= 4, Local2:= 5, Local3
   openwindow(Local1, Local2, Local1 + 16, Local2 + 70, "S", 1, ;
      "W+/B")
   @ Local1, Local2 say padc("Manutencao de Gado", 71) color "B/W*"
   @ Local1 + 2, Local2 + 2 say "Controle.:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "9999", {|| ;
      codeverify(Arg1[1], Arg3)}, {|| Arg2 == 1}, {1}):display())
   @ Local1 + 4, Local2 + 2 say "Nome.....:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", Nil, Nil, Nil, ;
      {2}):display())
   @ Local1 + 5, Local2 + 2 say "Registro.:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "!!/!!-!!!!!!!!!!!", Nil, ;
      Nil, {3}):display())
   @ Local1 + 5, Col() + 2 say "Grau Sangue.:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "!!!!", Nil, Nil, ;
      {4}):display())
   @ Local1 + 6, Local2 + 2 say "Data Nasc:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "99/99/99", Nil, Nil, ;
      {5}):display())
   @ Local1 + 6, Col() + 2 say "Sexo.:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "!", {|| Arg1[6] $ "MF"}, ;
      Nil, {6}):display())
   @ Local1 + 6, Col() + 2 say "Variedade:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "!!", Nil, Nil, ;
      {7}):display())
   @ Local1 + 8, Local2 + 2 say "Pai:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", Nil, Nil, Nil, ;
      {8}):display())
   @ Local1 + 8, Col() + 1 say "Rg:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "!!/!!-!!!!!!!!!!!", Nil, ;
      Nil, {9}):display())
   @ Local1 + 9, Local2 + 2 say "Mae:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", Nil, Nil, Nil, ;
      {10}):display())
   @ Local1 + 9, Col() + 1 say "Rg:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "!!/!!-!!!!!!!!!!!", Nil, ;
      Nil, {11}):display())
   @ Local1 + 11, Local2 + 2 say "Obs......:"
   SetPos(Row(), Col() + 1)
   AAdd(Arg4, __GetA({|| Arg1}, "aField", "@S54", Nil, Nil, ;
      {12}):display())
   ATail(Arg4):reader({|| (Local3:= SetColor("N/W"), Arg1[12]:= ;
      memoedit(Arg1[12], Local1 + 11, Local2 + 13, Local1 + 15, ;
      Local2 + 68), SetColor(Local3))})
   keyboard Chr(27)
   Local3:= SetColor("N/W")
   Arg1[12]:= memoedit(Arg1[12], Local1 + 11, Local2 + 13, Local1 + ;
      15, Local2 + 68)
   SetColor(Local3)
   return .T.

********************************
function UPMONTH(Arg1)

   local Local1, Local2, Local3, Local4, Local5
   default Arg1 to Date()
   if (!(ISDATE(Arg1)) .OR. Empty(Arg1))
      return CToD(Space(8))
   endif
   Local1:= Month(Arg1)
   Local2:= Year(Arg1)
   Local3:= {31, 28 + iif(mod(Local2, 4) = 0, 1, 0), 31, 30, 31, 30, ;
      31, 31, 30, 31, 30, 31}
   if (Local2 > 100)
      if (Local1 == 1)
         Local4:= 31
      else
         Local4:= iif(Local3[Local1 - 1] < Day(Arg1), ;
            Local3[Local1], Local3[Local1 - 1])
      endif
      Arg1:= Arg1 - Local4
   endif
   Local5:= Arg1
   return Local5

********************************
function USEDBF(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)

   local Local1, Local2, Local3, Local4, Local5
   default Arg4 to .F.
   default Arg6 to .F.
   default Arg7 to "Arquivo de suporte..."
   Arg3:= alltrim(Upper(Arg3))
   Local5:= ascan(Static51, Arg3)
   if (Local5 == 0)
      AAdd(Static51, Arg3)
      AAdd(Static52, Arg2)
   else
      Static52[Local5]:= Arg2
   endif
   if (Select(Arg3) != 0)
      select (Arg3)
      close
   endif
   if (!file(Arg1 + ".DBF"))
      _openmessa("Criando o arquivo de dados " + Arg1 + ".DBF", Nil, ;
         Nil, Nil)
      dbcreate(Arg1, Arg2)
      closewindo()
   endif
   use (Arg1) alias (Arg3) new
   if (ValType(Arg5) = "C")
      Arg5:= {Arg5}
   endif
   if (Arg4)
      for Local2:= 1 to Len(Arg5)
         Local4:= Arg5[Local2]
         Local3:= Arg1 + Str(Local2, 1, 0)
         if (Arg6 .AND. file(Local3 + ".NTX"))
            Local1:= Arg1 + ".NTX"
            erase (Local1)
         elseif (!file(Local3 + ".NTX"))
            select (Arg3)
            goto top
            _percentin(Local4, Arg7, ;
               "Criando o arquivo de indexacao " + Local3 + ".NTX")
            Local1:= Local4
            ordcondset(Nil, Nil, Nil, Nil, {|| _percentru()}, Nil, ;
               RecNo(), Nil, Nil, Nil, Nil)
            ordcreate(Local3, Nil, Local1, &("{||" + Local1 + "}"), ;
               Nil)
            close
            use (Arg1) alias (Arg3) new
            _percentdo(Local3 + ".NTX")
         endif
      next
      select (Arg3)
      close
      use (Arg1) alias (Arg3)
      for Local2:= 1 to Len(Arg5)
         dbSetIndex(Arg1 + Str(Local2, 1, 0))
      next
   endif
   set filter to
   set relation to
   return .T.

********************************
function VALGETS

   for e:= 1 to 8
      hora[e]:= Space(5)
      hist[e]:= Space(33)
   next
   return .T.

********************************
function VARGES

   for d:= 1 to 8
      gra1:= "AGEN_DAT" + right("0" + alltrim(Str(d)), 1)
      gra2:= "AGEN_TIM" + right("0" + alltrim(Str(d)), 1)
      hist[d]:= &gra1
      hora[d]:= &gra2
   next
   set century on
   return .T.

********************************
static function VERIFYREGI(Arg1)

   local Local1
   for Local1:= Len(Arg1) to 1 step -1
      if (m_region(Arg1[Local1][1], Arg1[Local1][2], Arg1[Local1][1] ;
            + Arg1[Local1][13] + 1, Arg1[Local1][2] + ;
            Arg1[Local1][12] + 1))
         return Local1
      endif
   next
   return 0

********************************
function VERII

   con2:= 0
   con5:= 0
   if (achames(data, .F.))
      con1:= 0
      con5:= 0
      con6:= 0
      con7:= 0
      varges()
      agenbook()
      return .T.
   endif
   con1:= 0
   con7:= 1
   agenbook()
   return .T.

********************************
static function VOID

   return Nil

********************************
function WPASSWORD

   replace arqpas->pass_nom with Static2
   replace arqpas->pass_cod with Static1
   replace arqpas->pass_niv with _makecode(_ntocz(Static3, 2) + "CTS")
   return .T.

********************************
function WRITESHADO(Arg1, Arg2, Arg3, Arg4)

   local Local1, Local2, Local3, Local4
   default Arg4 to SetColor()
   Local1:= Len(Arg3)
   Local2:= getattr(Arg1 + 1, Arg2 + 1)
   Local4:= Int(Local2 / 256)
   Local3:= Local2 - Local4 * 256
   attrlow(Local3, 0)
   attrhigh(Local4, Local4)
   setattr(Arg1, Arg2 + 1, Arg1 + 1, Arg2 + Local1, 8192)
   _sayout(Arg1, Arg2 + Local1, "Ü")
   _sayout(Arg1 + 1, Arg2 + 1, Replicate("ß", Local1))
   @ Arg1, Arg2 say Arg3 color Arg4
   return .T.

********************************
function WRITE_REC(Arg1, Arg2, Arg3, Arg4)

   local Local1
   default Arg4 to .T.
   select (Arg2)
   goto Arg3
   if ;
         (!rec_lock("Registro truncado em outra rede. Tenta outra vez (S/N)?", ;
         5))
      return .F.
   endif
   if (ISCHARACTER(Arg1))
      Local1:= &Arg1
   elseif (ISBLOCK(Arg1))
      eval(Arg1)
   endif
   if (Arg4)
      commit
   endif
   unlock
   return .T.

********************************
static function X(Arg1)

   return Chr(hex2dec(Arg1))

********************************
function ZAP_FIL(Arg1)

   select (Arg1)
   if ;
         (!fil_lock("Arquivo truncado em outra rede. Tenta outra vez (S/N)?", ;
         5))
      return .F.
   endif
   zap
   unlock
   return .T.

********************************
function _AADDMENU(Arg1, Arg2, Arg3)

   local Local1, Local2
   default Arg3 to "_PopEmpty()"
   default Arg1 to {}
   Local1:= At("~", Arg2)
   Local1:= iif(Local1 = 0, At(LTrim(Arg2), Arg2), Local1)
   Arg2:= strtran(Arg2, "~", "")
   Local2:= SubStr(Arg2, Local1, 1)
   AAdd(Arg1, {Arg2, Local1, Local2, Arg3})
   return Arg1

********************************
function _ALLWINDOW

   local Local1
   do while (Len(Static32) > 0)
      closewindo()
      InKey(0.1)
   enddo
   return .T.

********************************
function _BOXALERT(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)

   local Local1, Local2, Local3, Local4, Local5, Local6
   default Arg2 to 10
   default Arg3 to (80 - Len(Arg1)) / 2 - 2
   default Arg6 to iif(!blinkbit(), "W+/B*", "W+/RB")
   default Arg7 to "W+/R"
   _pushmouse()
   _push_colo(Arg6)
   if (Arg5 = Nil .OR. Len(Arg5) = 0)
      default Arg4 to 1
      if (Arg4 == 1)
         Arg5:= {"Ok"}
      elseif (Arg4 == 2)
         Arg5:= {"Sim", "Nao"}
      elseif (Arg4 == 3)
         Arg5:= {"Sim", "Nao", "Cancela"}
      else
         return 0
      endif
   elseif (ISNIL(Arg4))
      Arg4:= Len(Arg5)
   endif
   Local4:= Len(Arg1) + 2
   Local2:= alenght(Arg5) + 2
   Local3:= (Local2 + 2) * Arg4 + 4
   Local4:= iif(Local4 < Local3, Local3, Local4)
   Local5:= iif(Local4 > Local3, (Local4 - Local3) / 2, 0)
   openwindow(Arg2, Arg3, Arg2 + 5, Arg3 + Local4 + 2, "S", 2, Nil)
   @ Arg2 + 1, Arg3 + 2 say Arg1
   set color to w+/n
   saymouse(Arg2, Arg3, iif(settable(), "", "[]"), ;
      "__keyboard(chr(27))")
   set color to (Arg7)
   if (Arg4 == 1)
      writeshado(Arg2 + 3, Arg3 - 2 + Local4 / 2, " " + Arg5[1] + " ")
      mprompt(Arg2 + 3, Arg3 - 2 + Local4 / 2, " " + Arg5[1] + " ")
   else
      for Local6:= 1 to Arg4
         mprompt(Arg2 + 3, Arg3 + Local5 + 2 + (Local2 + 4) * ;
            (Local6 - 1), padc(Arg5[Local6], Local2, " "), .T.)
      next
   endif
   Local1:= mmenuto()
   closewindo()
   _popmouse()
   _pop_color()
   if (ISNIL(Arg8))
      return Local1
   endif
   return .F.

********************************
function _DTON(Arg1)

   local Local1, Local2, Local3, Local4
   Local1:= DToC(Arg1)
   Local2:= SubStr(Local1, 4, 2)
   Local3:= Left(Local1, 2)
   Local4:= right(Local1, 2)
   return Val(Local4 + Local2 + Local3)

********************************
function _EDITPASSW

   local Local1:= 10, Local2:= 7, Local3:= .T., Local4:= 1, Local5
   Local5:= {}
   _push_colo("bg+/b")
   _pushmouse()
   openwindow(Local2, Local1, Local2 + 10, Local1 + 24, ;
      "          ", 2, "n/w*")
   @ Local2, Local1 say padc("PassWord", 25) color "w+/w"
   _push_colo("w+/n")
   saymouse(Local2, Local1, iif(settable(), "", "[]"), ;
      "__keyboard(chr(27))")
   _pop_color()
   do while (Local3)
      mprompt(Local2 + 2, Local1 + 2, " Cadastrar Usuario ", .T.)
      mprompt(Local2 + 4, Local1 + 2, "  Alterar Usuario  ", .T.)
      mprompt(Local2 + 6, Local1 + 2, " Informacao de Uso ", .T.)
      mprompt(Local2 + 8, Local1 + 2, "   Menu Anterior   ", .T.)
      Local4:= mmenuto("B/BG*", "GR+/B", Local4)
      if (Local4 == 1)
      elseif (Local4 == 2)
      elseif (Local4 == 3)
      else
         Local3:= .F.
      endif
   enddo
   _popmouse()
   closewindo()
   _pop_color()
   return .T.

********************************
function _EMPTY(Arg1, Arg2)

   if (Empty(Arg1))
      message(Arg2)
      keyboard Chr(LastKey())
      return .F.
   endif
   return .T.

********************************
function _INPUTQUIE(Arg1, Arg2, Arg3, Arg4, Arg5)

   local Local1, Local2, Local3, Local4
   Local1:= ""
   Local4:= {}
   default Arg3 to Row()
   default Arg4 to Col()
   default Arg5 to "N/W"
   @ Arg3, Arg4 say Arg1
   Arg4:= Col() + 1
   @ Arg3, Arg4 say Space(Arg2) color Arg5
   if (setmouse())
      m_csron()
   endif
   do while (Len(Local1) < Arg2)
      SetPos(Arg3, Arg4 + Len(Local1))
      Local2:= 0
      do while (Local2 == 0)
         Local2:= InKey()
         if (Local2 == 0 .AND. mousesay())
            m_csron()
         endif
      enddo
      if (setmouse() .AND. Local2 != 0)
         m_csroff()
      endif
      do case
      case Local2 = 27
         exit
      case Local2 = 13
         exit
      case Local2 = 8 .OR. Local2 = 19
         if (Len(Local1) > 0)
            Local1:= Left(Local1, Len(Local1) - 1)
            @ Arg3, Arg4 + Len(Local1) say " " color Arg5
         endif
      case (Local3:= SetKey(Local2)) != Nil
         eval(Local3, {|| (procname(), procline, readvar())})
      otherwise
         @ Arg3, Arg4 + Len(Local1) say "þ" color Arg5
         Local1:= Local1 + Chr(Local2)
      endcase
      if (setmouse())
         m_csron()
      endif
   enddo
   if (setmouse())
      m_csroff()
   endif
   return Local1

********************************
static function _MAKECODE(Arg1)

   local Local1, Local2, Local3
   Arg1:= alltrim(Arg1)
   Local1:= Len(Arg1)
   for Local2:= 1 to Local1
      Local3:= Asc(SubStr(Arg1, Local2, 1)) - (Local1 + Local2)
      Local3:= iif(Local3 < 0, 256 + Local3, Local3)
      Arg1:= stuff(Arg1, Local2, 1, Chr(Local3))
   next
   return Arg1

********************************
function _MAKEDATE(Arg1, Arg2, Arg3)

   return CToD(_ntoc(Arg1, 2) + "/" + _ntoc(Arg2, 2) + "/" + ;
      _ntoc(Arg3, 2))

********************************
function _MAKEPASSW(Arg1)

   local Local1, Local2, Local3, Local4, Local5
   Local5:= {}
   Local1:= .F.
   Local3:= 25
   Local2:= 8
   _push_colo(SetColor())
   openwindow(Local2, Local3, Local2 + 4, Local3 + 37, "          ", ;
      2, Nil)
   @ Local2, Local3 say padc("Senha Geral", 38) color "w+/w"
   _pushmouse()
   @ Local2 + 2, Local3 + 15 say Space(20) color "b/bg*"
   _sayout(Row(), Col(), "Ü")
   _sayout(Local2 + 3, Local3 + 16, Replicate("ß", 20))
   _push_colo("W+/N")
   saymouse(Local2, Local3, iif(settable(), "", "[]"), ;
      "__keyboard(chr(27))")
   _pop_color()
   _push_colo(SetColor())
   Static1:= _makecode(Upper(_inputquie("Acesso....:", 20, Local2 + ;
      2, Local3 + 2, "b/bg*")))
   _popmouse()
   closewindo()
   if (Static1 == "3CA95-<*:@Ã")
      openpass(Arg1)
      _push_gets()
      Static2:= Space(30)
      openwindow(Local2, Local3, Local2 + 6, Local3 + 46, ;
         "          ", 2, Nil)
      @ Local2, Local3 say padc("Usuario Principal", 47) color "w+/w"
      _push_colo("W+/N")
      saymouse(Local2, Local3, iif(settable(), "", "[]"), ;
         "__keyboard(chr(27))")
      _pop_color()
      do while (.T.)
         Static1:= Space(20)
         @ Local2 + 2, Local3 + 2 say "Usuario...:"
         SetPos(Row(), Col() + 1)
         AAdd(Local5, __Get({|_1| iif(ISNIL(_1), Static2, Static2:= ;
            _1)}, "mWordNom", "@!", Nil, Nil):display())
         _sayout(Local2 + 3, Local3 + 15, Replicate("ß", 30))
         _sayout(Row(), Col(), "Ü")
         @ Local2 + 4, Local3 + 2 say "Senha.....:"
         SetPos(Row(), Col() + 1)
         AAdd(Local5, __Get({|_1| iif(ISNIL(_1), Static1, Static1:= ;
            _1)}, "mWordPas", Nil, Nil, Nil):display())
         ATail(Local5):reader({|_1| (Static1:= ;
            _makecode(Upper(_inputquie("Senha.....:", 20, Local2 + ;
            4, Local3 + 2, "b/bg*"))), Static1)})
         _sayout(Row(), Col(), "Ü")
         _sayout(Local2 + 5, Local3 + 15, Replicate("ß", 20))
         ReadModal(Local5)
         Local5:= {}
         if (LastKey() == K_ESC)
            exit
         endif
         if (Static1 == _makecode(Upper(_inputquie("Confirma..:", ;
               20, Local2 + 4, Local3 + 2, "b/bg*"))))
            Static3:= 0
            new_rec("wPassWord()", "ArqPas")
            Local1:= .T.
            set key K_ALT_S to _editpassw
            exit
         else
            message("C¢digo inv lido!!! Tente de novo...")
         endif
      enddo
      closewindo()
      _pop_gets()
   else
      message("Acesso Negado!!! Voce nao tem acesso autorizado ao Sistema.")
      Local1:= .F.
   endif
   _pop_color()
   return Local1

********************************
function _MENUSDV_(Arg1)

   return 0

********************************
function _MONTHYEAR(Arg1)

   local Local1
   Local1:= {"Janeiro", "Fevereiro", "Marco", "Abril", "Maio", ;
      "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", ;
      "Dezembro"}
   return Local1[Month(Arg1)] + " de " + _ntocz(Year(Arg1), 4)

********************************
function _NTOC(Arg1, Arg2)

   return right(Replicate(" ", Arg2) + alltrim(Str(Arg1)), Arg2)

********************************
function _NTOCZ(Arg1, Arg2)

   return right(Replicate("0", Arg2) + alltrim(Str(Arg1)), Arg2)

********************************
function _OPENMESSA(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)

   default Arg2 to 12
   default Arg3 to (80 - Len(Arg1)) / 2
   default Arg4 to iif(!blinkbit(), "W+/B*", "W+/G")
   default Arg5 to .F.
   default Arg6 to .F.
   _push_colo()
   if (Arg6)
      openwindow(Arg2, Arg3, Arg2 + 2, Arg3 + Len(Arg1) + 3, "S", 2, ;
         Arg4)
   else
      openwindow(Arg2, Arg3, Arg2 + 2, Arg3 + Len(Arg1) + 3, "S", 1, ;
         Arg4)
   endif
   if (Arg5)
      set color to (stuff(Arg4, 2, 0, "*"))
   endif
   @ Arg2 + 1, Arg3 + 2 say Arg1 color Arg4
   _pop_color()
   return .T.

********************************
function _PASSWORD(Arg1, Arg2, Arg3)

   local Local1, Local2, Local3, Local4, Local5, Local6:= {}, ;
      Local7:= {}
   default Arg2 to 0
   default Arg3 to iif(blinkbit(), "W+/RB,N/W", ;
      "n/w*,b/bg*,,b/bg*,b/bg*")
   setcursor(1)
   _push_colo(Arg3)
   Local1:= 15
   Local2:= 7
   Local3:= Space(30)
   Local5:= Space(20)
   if (!file(Arg1 + ".DBF"))
      if (message("Acesso Negado!!! O programa foi adulterado.") == 0)
         return _makepassw(Arg1)
      endif
      return .F.
   endif
   openpass(Arg1)
   Local4:= .F.
   set color to n/w*
   _pushmouse()
   openwindow(Local2, Local1, Local2 + 6, Local1 + 46, "          ", ;
      2, Nil)
   @ Local2, Local1 say padc("Senha/Usuario", 47) color "W+/W"
   set color to (Arg3)
   @ Local2 + 2, Local1 + 2 say "Usuario...:"
   SetPos(Row(), Col() + 1)
   AAdd(Local7, __Get({|_1| iif(ISNIL(_1), Local3, Local3:= _1)}, ;
      "pWordNom", "@!", {|| _verifypas(Local3)}, Nil):display())
   _sayout(Local2 + 2, Local1 + 44, "Ü")
   _sayout(Local2 + 3, Local1 + 15, Replicate("ß", 30))
   @ Local2 + 4, Local1 + 2 say "Senha.....:"
   SetPos(Row(), Col() + 1)
   AAdd(Local7, __Get({|_1| iif(ISNIL(_1), Local5, Local5:= _1)}, ;
      "pWordPass", Nil, Nil, Nil):display())
   ATail(Local7):reader({|| Local5:= ;
      _makecode(Upper(_inputquie("Senha.....:", 20, Local2 + 4, ;
      Local1 + 2, "b/bg*")))})
   _sayout(Row(), Col(), "Ü")
   _sayout(Local2 + 5, Local1 + 15, Replicate("ß", 20))
   _push_colo("W+/N")
   saymouse(Local2, Local1, iif(settable(), "", "[]"), ;
      "__keyboard(chr(27))")
   _pop_color()
   ReadModal(Local7, 1)
   if (LastKey() != K_ESC)
      if (Local5 == Left(arqpas->pass_cod, Len(Local5)) .AND. ;
            !Empty(Local5))
         Local4:= .T.
         Static3:= Val(Left(_restcode(arqpas->pass_niv), 2))
         set key K_ALT_S to _editpassw
      else
         message("Senha inv lida!!! Acesso nao Permitido.")
      endif
   endif
   _pop_color()
   _popmouse()
   closewindo()
   return Local4

********************************
function _PERCENTDO(Arg1)

   local Local1, Local2, Local3, Local4
   setattr(Static19 + 4, Static20 + 2, Static19 + 4, Static20 + 61, ;
      atoattr("N*/W*"))
   _sayout(Static19 + 4, Static20 + 30, Transform(100, "@e 999") + ;
      "%")
   Set(_SET_CURSOR, Static16)
   Static17:= .F.
   set color to (Static18)
   closewindo()
   return .T.

********************************
function _PERCENTIN(Arg1, Arg2, Arg3)

   local Local1
   Local1:= &Arg1
   Static21:= ValType(Local1)
   Static19:= Static20:= 10
   Static22:= 0
   default Arg2 to "Quantidade de Indexacao"
   default Arg3 to "Indexando arquivo..."
   Static16:= Set(_SET_CURSOR, 0)
   Static17:= .T.
   Static18:= SetColor(iif(!blinkbit(), "W+/B*", "W+/G"))
   openwindow(Static19, Static20, Static19 + 6, Static20 + 63, "S", ;
      1, iif(!blinkbit(), "W+/B*", "W+/G"))
   @ Static19, Static20 say padc(Arg2, 64) color "B/W*"
   center(Arg3, Static19 + 2, Static20, Static20 + 63, Nil)
   @ Static19 + 4, Static20 + 2 say Replicate(" ", 60) color "n/w"
   return .T.

********************************
function _PERCENTRU

   local Local1, Local2
   Static22++
   Local1:= Int(Static22 * 100 / LastRec())
   Local1:= iif(Local1 > 100, 0, Local1)
   Local2:= Int(Local1 / 100 * 60)
   Local2:= iif(Local2 >= 60, 59, Local2)
   setattr(Static19 + 4, Static20 + 2, Static19 + 4, Static20 + 2 + ;
      Local2, atoattr("N*/W*"))
   _sayout(Static19 + 4, Static20 + 30, Transform(Local1, "@e 999") ;
      + "%")
   return .T.

********************************
function _POPEMPTY

   message("Funcao ainda nao implementada...")
   return .T.

********************************
function _POPMENU(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
   Arg9, Arg10, Arg11)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
      Local15, Local16, Local17, Local18, Local19, Local20, Local21, ;
      Local22, Local23, Local24, Local25
   default Arg10 to ""
   default Arg1 to Row()
   default Arg2 to Col()
   default Arg4 to .F.
   default Arg3 to {}
   default Arg5 to SetColor()
   default Arg6 to iif(SubStr(Arg5, 2, 1) = "/", "GR+" + right(Arg5, ;
      Len(Arg5) - 1), "GR+" + right(Arg5, Len(Arg5) - 2))
   default Arg7 to iif(!blinkbit(), "N/W", "N/W")
   default Arg8 to iif(SubStr(Arg5, 2, 1) = "/", "W+" + right(Arg5, ;
      Len(Arg5) - 1), "W" + right(Arg5, Len(Arg5) - 2))
   default Arg9 to iif(SubStr(Arg5, 2, 1) = "/", "G+" + right(Arg5, ;
      Len(Arg5) - 1), "G+" + right(Arg5, Len(Arg5) - 2))
   default Arg11 to .F.
   _push_colo(SetColor())
   if (Left(Arg6, 6) = "GR+/W*")
      Arg6:= "R+/W*"
      Arg7:= "W+/B*"
   endif
   Local2:= Len(Arg3)
   if (Local2 < 1)
      return .F.
   endif
   Local14:= 0
   for Local3:= 1 to Local2
      Local14:= iif(Local14 > Len(Arg3[Local3][1]), Local14, ;
         Len(Arg3[Local3][1]))
   next
   set color to (Arg8)
   if (Arg4)
      openwindow(Arg1, Arg2, Arg1 + Local2 + 1, Arg2 + Local14 + 1, ;
         "S", 2, Nil)
   else
      openwindow(Arg1, Arg2, Arg1 + Local2 + 1, Arg2 + Local14 + 1, ;
         "S", 1, Nil)
   endif
   @ Arg1, Arg2 + 2 say padc(Arg10, Local14) color "B/W*"
   @ Arg1, Arg2 say iif(settable(), "", "[]") color "W+/N"
   set color to (Arg5)
   for Local3:= 1 to Local2
      @ Arg1 + Local3, Arg2 + 1 say Arg3[Local3][1]
      @ Arg1 + Local3, Arg2 + Arg3[Local3][2] say Arg3[Local3][3] ;
         color Arg6
      if (Arg3[Local3][4] = "-")
         @ Arg1 + Local3, Arg2 + 1 say Replicate("Ä", Local14) color ;
            Arg5
      endif
   next
   Local4:= .T.
   Local1:= 1
   Static28:= 0
   Local25:= 0
   AAdd(Static25, {Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
      Arg9, Arg10, Arg11, Local14, Local2, Local1})
   do while (Local4 .AND. Len(Static25) > 0)
      if (Static28 <= 0)
         if (Static27)
            Local24:= Len(Static25)
            Arg1:= Static25[Local24][1]
            Arg2:= Static25[Local24][2]
            Arg3:= Static25[Local24][3]
            Arg4:= Static25[Local24][4]
            Arg5:= Static25[Local24][5]
            Arg6:= Static25[Local24][6]
            Arg7:= Static25[Local24][7]
            Arg8:= Static25[Local24][8]
            Arg9:= Static25[Local24][9]
            Arg10:= Static25[Local24][10]
            Arg11:= Static25[Local24][11]
            Local14:= Static25[Local24][12]
            Local2:= Static25[Local24][13]
            Local1:= Static25[Local24][14]
         endif
         Static27:= .F.
         @ Arg1 + Local1, Arg2 + 1 say Arg3[Local1][1] color Arg7
         Local6:= Local1
         setcursor(0)
         Local5:= 0
         m_csron()
         do while (Local5 == 0 .AND. Len(Static25) > 0)
            Local5:= InKey()
            if (Local5 == 0 .AND. setmouse())
               m_csron()
               Local21:= Static28:= 0
               if (verifyregi(Static25) == 0)
                  mousesay()
               elseif ((mrow:= m_row()) != Local25 .AND. ;
                     m_region(Arg1 + 1, Arg2 + 1, Arg1 + Local2, ;
                     Arg2 + Local14) .AND. mrow > Arg1 .AND. mrow <= ;
                     Arg1 + Local2)
                  m_csroff()
                  @ Arg1 + Local1, Arg2 + 1 say Arg3[Local1][1]
                  @ Arg1 + Local1, Arg2 + Arg3[Local1][2] say ;
                     Arg3[Local1][3] color Arg6
                  Local6:= Local1
                  Local1:= mrow - Arg1
                  Local1:= iif(Arg3[Local1][4] = "-", Local6, Local1)
                  @ Arg1 + Local1, Arg2 + 1 say Arg3[Local1][1] ;
                     color Arg7
                  Local25:= mrow
                  Local6:= Local1
                  m_csron()
               endif
               Local7:= readmouse()
               Local20:= Local9:= .F.
               if (Local7 == 1)
                  Local17:= m_col()
                  Local18:= m_row()
                  Local20:= .F.
                  Local22:= 0
                  for Local22:= Len(Static25) to 1 step -1
                     Arg1:= Static25[Local22][1]
                     Arg2:= Static25[Local22][2]
                     Arg3:= Static25[Local22][3]
                     Arg4:= Static25[Local22][4]
                     Arg5:= Static25[Local22][5]
                     Arg6:= Static25[Local22][6]
                     Arg7:= Static25[Local22][7]
                     Arg8:= Static25[Local22][8]
                     Arg9:= Static25[Local22][9]
                     Arg10:= Static25[Local22][10]
                     Arg11:= Static25[Local22][11]
                     Local14:= Static25[Local22][12]
                     Local2:= Static25[Local22][13]
                     Local1:= Static25[Local22][14]
                     pmtet:= .T.
                     if (m_region(Arg1 + 1, Arg2 + 1, Arg1 + Local2, ;
                           Arg2 + Local14))
                        Local19:= Local1
                        pmtet:= .T.
                        if (Local21 > 0 .AND. !Local20)
                           Arg1:= Static25[Local22 + 1][1]
                           Arg2:= Static25[Local22 + 1][2]
                           Arg3:= Static25[Local22 + 1][3]
                           Arg4:= Static25[Local22 + 1][4]
                           Arg5:= Static25[Local22 + 1][5]
                           Arg6:= Static25[Local22 + 1][6]
                           Arg7:= Static25[Local22 + 1][7]
                           Arg8:= Static25[Local22 + 1][8]
                           Arg9:= Static25[Local22 + 1][9]
                           Arg10:= Static25[Local22 + 1][10]
                           Arg11:= Static25[Local22 + 1][11]
                           Local14:= Static25[Local22 + 1][12]
                           Local2:= Static25[Local22 + 1][13]
                           Local1:= Static25[Local22 + 1][14]
                           pmtet:= .F.
                           Local5:= 27
                        endif
                        if (pmtet)
                           Local19:= Local1
                           Local1:= Local18 - Arg1
                           Static25[Local22][14]:= Local1
                        endif
                        if (pmtet .AND. Arg3[Local1][4] != "-")
                           Local5:= 13
                           @ Arg1 + Local1, Arg2 + 1 say ;
                              Arg3[Local1][1] color Arg7
                        elseif (pmtet)
                           Local1:= Local19
                        endif
                        Local20:= .T.
                     endif
                     if (Local17 = Arg2 .AND. Local18 = Arg1 .AND. ;
                           pmtet)
                        Local5:= 27
                        Local20:= .T.
                        Static25[Local22][14]:= Local1
                     elseif (settable() .AND. Local17 = Arg2 + 1 ;
                           .AND. Local18 = Arg1 .AND. pmtet)
                        Local20:= 27
                        Local5:= 27
                        Static25[Local22][14]:= Local1
                     endif
                     if (!Local20)
                        Local24:= Len(Static25)
                        Arg1:= Static25[Local24][1]
                        Arg2:= Static25[Local24][2]
                        Arg3:= Static25[Local24][3]
                        Arg4:= Static25[Local24][4]
                        Arg5:= Static25[Local24][5]
                        Arg6:= Static25[Local24][6]
                        Arg7:= Static25[Local24][7]
                        Arg8:= Static25[Local24][8]
                        Arg9:= Static25[Local24][9]
                        Arg10:= Static25[Local24][10]
                        Arg11:= Static25[Local24][11]
                        Local14:= Static25[Local24][12]
                        Local2:= Static25[Local24][13]
                        Local1:= Static25[Local24][14]
                     else
                        Local10:= Local22:= 0
                        Static27:= .F.
                        if (Local10 = 1 .AND. Local12)
                           _popmenu(Arg1, Arg2, Arg3, Arg4, Arg5, ;
                              Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)
                           return .T.
                        endif
                        Static28:= Local21
                        Local21:= 0
                     endif
                     Local21:= Local21 + 1
                  next
                  Local21:= Local7:= 0
               endif
            endif
         enddo
      else
         Local5:= 27
      endif
      if (Len(Static25) > 0)
         m_csroff()
         @ Arg1 + Local6, Arg2 + 1 say Arg3[Local6][1]
         @ Arg1 + Local6, Arg2 + Arg3[Local6][2] say Arg3[Local6][3] ;
            color Arg6
         SetPos(Arg1 + Local1, Arg2 + Local14 + 1)
         setcursor(1)
         do case
         case Local5 = 5 .OR. Local5 = 19
            Local1--
            if (Local1 < 1)
               Local1:= Local2
            endif
            Local1:= iif(Arg3[Local1][4] = "-", Local1 - 1, Local1)
            if (Local1 < 1)
               Local1:= Local2
            endif
         case Local5 == 6
            Local1:= Local2
         case Local5 == 1
            Local1:= 1
         case Local5 = 24 .OR. Local5 = 4
            Local1++
            if (Local1 > Local2)
               Local1:= 1
            endif
            Local1:= iif(Arg3[Local1][4] = "-", Local1 + 1, Local1)
            if (Local1 > Local2)
               Local1:= 1
            endif
         case Local5 == 27
            Local4:= .F.
            Static28--
         case Local5 == 13
            @ Arg1 + Local1, Arg2 + 1 say Arg3[Local1][1] color Arg7
            Static25[Len(Static25)][14]:= Local1
            if (Arg3[Local1][4] = "~")
               Local4:= .F.
            else
               _push_colo(SetColor())
               _push_posi()
               @ Arg1, Arg2 + 2 say padc(Arg10, Local14) color "N/W*"
               if (settable())
                  @ Arg1, Arg2 say "" color "N/W*"
               endif
               _pop_posit()
               Local15:= &(Arg3[Local1][4])
               _push_posi()
               @ Arg1, Arg2 + 2 say padc(Arg10, Local14) color "B/W*"
               if (settable())
                  @ Arg1, Arg2 say "" color "W+/N"
               endif
               _pop_posit()
               Local4:= iif(Arg11, .F., .T.)
               _pop_color()
            endif
         case (Local13:= SetKey(Local5)) != Nil
            _push_colo(SetColor())
            _push_posi()
            @ Arg1, Arg2 + 2 say padc(Arg10, Local14) color "N/W*"
            if (settable())
               @ Arg1, Arg2 say "" color "N/W*"
            endif
            _pop_posit()
            eval(Local13, {|| (procname(), procline, readvar())})
            @ Arg1, Arg2 + 2 say padc(Arg10, Local14) color "B/W*"
            if (settable())
               @ Arg1, Arg2 say "" color "W+/N"
            endif
            _pop_posit()
            _pop_color()
         otherwise
            Local3:= 1
            Local16:= .F.
            do while (Local3 <= Local2)
               if (Upper(Chr(Local5)) == Upper(Arg3[Local3][3]))
                  Local1:= Local3
                  Local16:= .T.
                  exit
               endif
               Local3++
            enddo
            if (Local16)
               @ Arg1 + Local6, Arg2 + 1 say Arg3[Local6][1]
               @ Arg1 + Local6, Arg2 + Arg3[Local6][2] say ;
                  Arg3[Local6][3] color Arg6
               @ Arg1 + Local1, Arg2 + 1 say Arg3[Local1][1] color ;
                  Arg7
               if (Arg3[Local1][4] = "~")
                  Local4:= .F.
               else
                  _push_colo(SetColor())
                  _push_posi()
                  @ Arg1, Arg2 + 2 say padc(Arg10, Local14) color ;
                     "N/W*"
                  if (settable())
                     @ Arg1, Arg2 say "" color "N/W*"
                  endif
                  _pop_posit()
                  Local15:= &(Arg3[Local1][4])
                  Local4:= iif(Arg11, .F., .T.)
                  _push_posi()
                  @ Arg1, Arg2 + 2 say padc(Arg10, Local14) color ;
                     "B/W*"
                  if (settable())
                     @ Arg1, Arg2 say "" color "W+/N"
                  endif
                  _pop_posit()
                  _pop_color()
               endif
            endif
            iif(Len(Static25) > 0, Static25[Len(Static25)][14]:= ;
               Local1, .T.)
         endcase
      else
         exit
      endif
   enddo
   adel(Static25, Len(Static25))
   asize(Static25, Len(Static25) - 1)
   Static27:= .T.
   closewindo()
   _pop_color()
   m_csron()
   return .T.

********************************
function _POPMOUSE

   if (Len(Static9) > 0)
      Static8:= Static9[Len(Static9)]
      asize(Static9, Len(Static9) - 1)
   endif
   return .T.

********************************
function _POP_COLOR

   if (Len(Static45) > 0)
      set color to (Static45[Len(Static45)])
      asize(Static45, Len(Static45) - 1)
   endif
   return .T.

********************************
function _POP_POSIT

   if (Len(Static44) > 0)
      SetPos(Static44[Len(Static44)][1], Static44[Len(Static44)][2])
      asize(Static44, Len(Static44) - 1)
   endif
   return .T.

********************************
function _PUSHMOUSE

   local Local1, Local2
   Local1:= {}
   for Local2:= 1 to Len(Static8)
      AAdd(Local1, {Static8[Local2][1], Static8[Local2][2], ;
         Static8[Local2][3], Static8[Local2][4]})
   next
   AAdd(Static9, Local1)
   return .T.

********************************
function _PUSH_COLO(Arg1)

   default Arg1 to SetColor()
   AAdd(Static45, SetColor(Arg1))
   return .T.

********************************
function _PUSH_POSI

   AAdd(Static44, {Row(), Col()})
   return .T.

********************************
static function _RESTCODE(Arg1)

   local Local1, Local2, Local3
   Local2:= Len(Arg1)
   for Local1:= 1 to Local2
      Local2:= Len(Arg1)
      Local3:= Asc(SubStr(Arg1, Local1, 1)) + (Local2 + Local1)
      Local3:= iif(Local3 > 255, Local3 - 256, Local3)
      Arg1:= stuff(Arg1, Local1, 1, Chr(Local3))
   next
   return Arg1

********************************
function _SAYOUT(Arg1, Arg2, Arg3)

   local Local1, Local2, Local3
   Local1:= Len(Arg3)
   Local3:= SaveScreen(Arg1, Arg2, Arg1, Arg2 + Local1)
   for Local2:= 1 to Local1
      Local3:= stuff(Local3, Local2 * 2 - 1, 1, SubStr(Arg3, Local2, ;
         1))
   next
   RestScreen(Arg1, Arg2, Arg1, Arg2 + Local1, Local3)
   return .T.

********************************
function _TBLON

   local Local1
   AAdd(Static43, x("FF") + x("FF") + x("FF") + x("FF") + x("FF") + ;
      x("FF") + x("FF") + x("FF") + x("C0") + x("C0") + x("C0") + ;
      x("C0") + x("C0") + x("C0"))
   AAdd(Static43, x("FF") + x("FF") + x("FF") + x("FF") + x("FF") + ;
      x("FF") + x("FF") + x("FF") + x("00") + x("00") + x("00") + ;
      x("00") + x("00") + x("00"))
   AAdd(Static43, x("FF") + x("FF") + x("FF") + x("FF") + x("FF") + ;
      x("FF") + x("FF") + x("FF") + x("03") + x("03") + x("03") + ;
      x("03") + x("03") + x("03"))
   AAdd(Static43, x("03") + x("03") + x("03") + x("03") + x("03") + ;
      x("03") + x("03") + x("03") + x("03") + x("03") + x("03") + ;
      x("03") + x("03") + x("03"))
   AAdd(Static43, x("03") + x("03") + x("03") + x("03") + x("03") + ;
      x("03") + x("03") + x("03") + x("03") + x("03") + x("03") + ;
      x("03") + x("FF") + x("FF"))
   AAdd(Static43, x("00") + x("00") + x("00") + x("00") + x("00") + ;
      x("00") + x("00") + x("00") + x("00") + x("00") + x("00") + ;
      x("00") + x("FF") + x("FF"))
   AAdd(Static43, x("C0") + x("C0") + x("C0") + x("C0") + x("C0") + ;
      x("C0") + x("C0") + x("C0") + x("C0") + x("C0") + x("C0") + ;
      x("C0") + x("FF") + x("FF"))
   AAdd(Static43, x("C0") + x("C0") + x("C0") + x("C0") + x("C0") + ;
      x("C0") + x("C0") + x("C0") + x("C0") + x("C0") + x("C0") + ;
      x("C0") + x("C0") + x("C0"))
   AAdd(Static43, x("FF") + x("80") + x("80") + x("80") + x("80") + ;
      x("80") + x("9F") + x("9F") + x("80") + x("80") + x("80") + ;
      x("80") + x("80") + x("FF"))
   AAdd(Static43, x("FF") + x("01") + x("01") + x("01") + x("01") + ;
      x("01") + x("F9") + x("F9") + x("01") + x("01") + x("01") + ;
      x("01") + x("01") + x("FF"))
   AAdd(Static43, x("00") + x("40") + x("60") + x("70") + x("78") + ;
      x("7C") + x("7E") + x("7F") + x("7F") + x("7C") + x("4C") + ;
      x("0C") + x("06") + x("06"))
   for Local1:= 1 to 11
      fontput(9 + Local1, 14, 1, Static43[Local1])
   next
   return .T.

********************************
function _VALDATE(Arg1, Arg2, Arg3)

   return _dton(_makedate(Arg1, Arg2, Arg3))

********************************
function _VERIFYPAS(Arg1)

   select ArqPas
   locate for alltrim(arqpas->pass_nom) = alltrim(Arg1)
   if (!Found())
      message("Usu rio invalido!!! Acesso nao permitido")
      return .F.
   endif
   return .T.

