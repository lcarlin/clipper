#include "common.ch"
#include "inkey.ch"

static Static1, Static2, Static3, Static4
static Static5:= "S"
static Static6:= 0
static Static7:= .F., Static8:= {}, Static9:= {}
static Static10:= .F., Static11:= .F., Static12, Static13, Static14, ;
   Static15:= .F.
static Static16, Static17, Static18, Static19, Static20, Static21:= ;
   "C", Static22
static Static23:= {}, Static24:= {}
static Static25:= {}, Static26:= 0, Static27:= .F., Static28
static Static29:= 0, Static30:= 0, Static31, Static32:= {}, ;
   Static33[50, 50], Static34[50], Static35[50], Static36[50], ;
   Static37[50], Static38[50], Static39[50]
static Static40:= .F., Static41, Static42, Static43:= {}
static Static44:= {}
static Static45:= {}
static Static46, Static47:= .F.
static Static48:= .F., Static49, Static50, Static51:= {}, Static52:= ;
   {}

********************************
function ABROWSE(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
   Arg9, Arg10, Arg11)

   local Local1, Local2, Local3, Local4, Local5, Local6
   Local1:= 0
   Arg1:= iif(Arg1 = Nil, {}, Arg1)
   Arg2:= iif(Arg2 = Nil, {}, Arg2)
   Arg3:= iif(Arg3 = Nil, 0, Arg3)
   Arg4:= iif(Arg4 = Nil, 0, Arg4)
   Arg5:= iif(Arg5 = Nil, MaxRow(), Arg5)
   Arg6:= iif(Arg6 = Nil, MaxCol(), Arg6)
   Arg10:= iif(Arg10 = Nil, SetColor(), Arg10)
   Arg9:= iif(Arg9 = Nil, "void", Arg9)
   Arg11:= iif(Arg11 = Nil, {}, Arg11)
   if (Len(Arg1) == 0)
      return 0
   endif
   openwindow(Arg3, Arg4, Arg5, Arg6, "S", 1, Nil)
   obrowser:= tbrowsenew(Arg3 + 1, Arg4 + 1, Arg5 - 1, Arg6 - 1)
   for Local3:= 1 to Len(Arg1[1])
      Local6:= tbcolumnne(iif(ISNIL(Arg2[Local3]), "", ;
         centerhead(Arg1, Arg2, Arg8, Local3)), makeablock(Arg1, ;
         Local3, Arg8))
      if (Left(Type("aColumn[1][nCol]"), 1) != "U")
         Local6:cargo(Arg11[1][Local3])
      endif
      obrowser:addcolumn(Local6)
   next
   Local4:= Arg9 + "( aArray, nRow)"
   obrowser:cargo(&("{||" + Local4 + "}"))
   obrowser:colorspec(Arg10)
   obrowser:gotopbloc({|| Static46:= 1})
   obrowser:gobottomb({|| Static46:= Len(Arg1)})
   obrowser:skipblock({|_1| skipperarr(_1, Arg1)})
   Static46:= 1
   do while (.T.)
      do while (!obrowser:stabilize())
      enddo
      if (obrowser:stable())
         nkey:= InKey(0)
      endif
      Arg1:= standrdkey(obrowser, nkey, Arg1, Arg7)
      if (nkey == k_esc)
         exit
      elseif (nkey == k_enter .OR. Static47)
         if (Static47)
            keyboard Chr(nkey)
         endif
         dataentry(obrowser, Arg1, Arg8)
      endif
   enddo
   closewindo()
   return Static46

********************************
function ACERGETS

   flag:= 0
   do while (flag = 0)
      for c:= 1 to 8
         @ 6 + c * 2, 37 get hora[c] picture "99:99"
         @ 6 + c * 2, 43 get hist[c] picture "@!"
      next
      read
      if (LastKey() == K_ESC)
         if (con6 == 1)
            if (input_sn("Confirma Dados (S/N)?") = "S")
               new_rec("GraDia()", "ArqAgen")
            endif
         else
            _llin:= 22
            _lcol:= 48
            openwindow(_llin, _lcol, _llin + 2, _lcol + 22, "S", 2, ;
               Nil)
            res:= Space(1)
            @ _llin + 1, _lcol + 1 say "[G]rava ou [D]eleta" get Res ;
               picture "!" valid res $ "GD"
            read
            if (LastKey() != K_ESC)
               if (res = "G")
                  write_rec("GraDia()", "ArqAgen", RecNo())
               else
                  del_rec("ArqAgen", RecNo())
               endif
            endif
            closewindo()
         endif
         closewindo()
         flag:= 1
      endif
   enddo
   return .T.

********************************
procedure ACERTA

   adata:= CToD(stuff(DToC(data), 1, 2, "01"))
   sema:= DoW(adata)
   e:= 0
   n:= {31, 28 + iif(mod(Year(adata), 4) = 0, 1, 0), 31, 30, 31, 30, ;
      31, 31, 30, 31, 30, 31}
   pos_ini:= (sema - 1) * 4 + acol + 2
   for c:= 1 to n[Month(adata)]
      if (pos_ini > 28)
         pos_ini:= acol + 2
         e:= e + 2
      endif
      adia[c]:= e
      @ alin + 3 + e, pos_ini say _ntoc(c, 2)
      pos_ini:= pos_ini + 4
   next
   achames(data, .T.)
   return

********************************
function ACHAMES(Arg1, Arg2)

   set century off
   select ArqAgen
   goto top
   con2:= 0
   con3:= 0
   do while (!EOF())
      if (Left(Str(_dton(agen_data)), 4) = Left(Str(_dton(Arg1)), 4))
         con3:= 0
         con2:= 0
         if (Arg2)
            color1:= SetColor()
            set color to W++/R*
            @ alin + adia[Day(agen_data)] + 3, acol + ;
               (DoW(agen_data) - 1) * 4 + 2 say ;
               _ntoc(Day(agen_data), 2)
            set color to (color1)
         elseif (Day(agen_data) = Day(Arg1))
            con2:= 1
            return .T.
         endif
      endif
      skip 
   enddo
   set century on
   if (con3 = 0 .AND. con2 = 0)
      return .F.
   endif
   return .T.

********************************
function AGENBOOK

   setcursor(1)
   color:= SetColor()
   cagenind:= 1
   set color to W+/R*,,,,W+/R*
   flag:= 0
   agenscreen()
   if (con1 = 1 .OR. con7 = 1)
      valgets()
   endif
   if (con5 == 0)
      acergets()
   endif
   con5:= 0
   set color to (color)
   return .T.

********************************
function AGEND

   local Local1:= alias(), Local2:= SetColor(), Local3:= Col(), ;
      Local4:= Row(), Local5
   public acol:= 2, alin:= 5, adia[31], data, flag, color, con1, ;
      con5, con6
   public hora[8], hist[8], agarq
   _push_gets()
   agarq:= "CTSAG"
   col:= SetColor()
   SetKey(K_F4, Nil)
   set date british
   set deleted on
   agenfiles(agarq)
   setcursor(0)
   data:= Date()
   set color to W+/B*
   openwindow(alin - 3, acol, alin - 1, acol + 35, "S", 2, "W+/B*")
   openwindow(alin, acol, alin + 14, acol + 28, "S", 2, "W+/B*")
   do while (.T.)
      set color to W+/B*
      @ alin - 2, acol + 2 say Space(33)
      @ alin - 2, acol + 2 say extenddate(data)
      @ alin + 1, acol + 1 say " D   S   T   Q   Q   S   S "
      @ alin + 2, acol + 1 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      for Local5:= 3 to 13
         @ alin + Local5, acol + 1 say "                           "
      next
      set color to W+/B*
      col_data()
      dia_atual()
      akey:= InKey(0)
      dat1:= CToD("10/01/91")
      n:= {31, 28 + iif(mod(Year(data), 4) = 0, 1, 0), 31, 30, 31, ;
         30, 31, 31, 30, 31, 30, 31}
      cdata:= DToC(data)
      nyear:= Val(right(cdata, 4))
      do case
      case akey == 24
         if (nyear < 2999)
            data:= data + Month(dat1) * n[Month(data)]
         endif
      case akey == 5
         if (nyear > 100)
            data:= upmonth(data)
         endif
      case akey == 19
         data--
         if (Val(right(DToC(data), 4)) < 100)
            data++
         endif
      case akey == 4
         data++
         if (Val(right(DToC(data), 4)) > 2999)
            data--
         endif
      case akey == 3
         data:= CToD(Left(cdata, 6) + iif(nyear < 2999, _ntoc(nyear ;
            + 1, 4), _ntoc(nyear, 4)))
      case akey == 18
         data:= CToD(Left(cdata, 6) + iif(nyear > 100, _ntoc(nyear - ;
            1, 4), _ntoc(nyear, 4)))
      case akey == -5
         data:= Date()
      case akey == -6
         set color to W+/B*
         setcursor(1)
         openwindow(alin + 5, acol + 10, alin + 7, acol + 31, "S", ;
            2, Nil)
         aindate:= data
         @ alin + 6, acol + 12 say "Data..:" get aInDate picture ;
            "99/99/9999"
         read
         if (!Empty(aindate) .AND. LastKey() != K_ESC)
            data:= aindate
         endif
         setcursor(0)
         closewindo()
      case akey == 27
         exit
      case akey == 13
         con1:= 1
         con5:= 0
         con6:= 1
         con7:= 1
         agenbook()
      endcase
   enddo
   closewindo()
   closewindo()
   set century off
   setcursor(1)
   set color to (col)
   set key K_F4 to agend
   _pop_gets()
   set color to (Local2)
   SetPos(Local4, Local3)
   select (Local1)
   return .T.

********************************
function AGENFILES(Arg1)

   banco:= {}
   AAdd(banco, {"AGEN_DAT1", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM1", "C", 5, 0})
   AAdd(banco, {"AGEN_DAT2", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM2", "C", 5, 0})
   AAdd(banco, {"AGEN_DAT3", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM3", "C", 5, 0})
   AAdd(banco, {"AGEN_DAT4", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM4", "C", 5, 0})
   AAdd(banco, {"AGEN_DAT5", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM5", "C", 5, 0})
   AAdd(banco, {"AGEN_DAT6", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM6", "C", 5, 0})
   AAdd(banco, {"AGEN_DAT7", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM7", "C", 5, 0})
   AAdd(banco, {"AGEN_DAT8", "C", 33, 0})
   AAdd(banco, {"AGEN_TIM8", "C", 5, 0})
   AAdd(banco, {"AGEN_DATA", "D", 8, 0})
   usedbf(Arg1, banco, "ArqAgen", .T., "AGEN_DATA")
   return .T.

********************************
function AGENSCREEN

   local Local1
   if (con1 == 1)
      verii()
      con5:= 1
   else
      public cagenlin:= 3, cagencol:= 35
      set color to W+/R*
      openwindow(cagenlin + 1, cagencol, cagenlin + 20, cagencol + ;
         41, "S", 1, "W+/R*")
      @ cagenlin + 1, cagencol say ;
         padc("CAOS - Agenda Eletronica v1.0á", 42) color "N/W"
      @ cagenlin + 3, cagencol + 1 say ;
         "                                        "
      @ cagenlin + 2, cagencol say ;
         "  Hora   Anotacoes                        " color "B/W*"
      for Local1:= 4 to 18
         @ cagenlin + Local1, cagencol + 1 say ;
            "ÄÄÄÄÄÄ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
         Local1++
         @ cagenlin + Local1, cagencol + 1 say ;
            "                                        "
      next
      return .T.
   endif

********************************
function ALENGHT(Arg1, Arg2)

   local Local1, Local2
   Arg2:= iif(Arg2 = Nil, 0, Arg2)
   Local1:= 0
   if (Arg2 > 0)
      for Local2:= 1 to Len(Arg1)
         Local1:= iif(Len(Arg1[Local2][Arg2]) > Local1, ;
            Len(Arg1[Local2][Arg2]), Local1)
      next
   else
      for Local2:= 1 to Len(Arg1)
         Local1:= iif(Len(Arg1[Local2]) > Local1, Len(Arg1[Local2]), ;
            Local1)
      next
   endif
   return Local1

********************************
function ASEARCH(Arg1, Arg2)

   local Local1, Local2
   Local1:= 0
   for Local2:= 1 to Len(Arg1)
      if (Arg1[Local2] == Arg2)
         Local1:= Local2
         Local2:= Len(Arg1)
      endif
   next
   return Local1

********************************
function BEEP(Arg1)

   if (Arg1 == 1)
      tone(87.3, 2)
      tone(40, 7)
   elseif (Arg1 == 2)
      tone(261.7, 2)
      tone(392, 7)
   elseif (Arg1 == 3)
      tone(300, 4)
      tone(300, 4)
      tone(300, 4)
   endif
   return .T.

********************************
function CALCULATOR

   return .T.

********************************
static function CENTERHEAD(Arg1, Arg2, Arg3, Arg4)

   return padc(Arg2[Arg4], Len(Transform(Arg1[Arg4][1], Arg3[Arg4])) ;
      + 2)

********************************
function CLOSEWINDO

   local Local1
   if (Len(Static32) == 0)
      return .T.
   endif
   Local1:= Len(Static32)
   if (Static32[Local1][6] == 2)
      implode_bo()
   endif
   RestScreen(Static32[Local1][2], Static32[Local1][3], ;
      Static32[Local1][4], Static32[Local1][5], Static32[Local1][1])
   asize(Static32, Local1 - 1)
   return .T.

********************************
function CODEVERIFY(Arg1, Arg2, Arg3)

   local Local1
   Local1:= .T.
   default Arg3 to 1
   set order to Arg3
   if (dbSeek(Arg1))
      if (Arg2)
         message("Codigo ja cadastrado. Tecle [Enter] para sair")
         return .F.
      endif
   elseif (!Arg2)
      message("Codigo nao cadastrado. Tecle [Enter] para sair.")
      return .F.
   endif
   return .T.

********************************
procedure COL_DATA

   sema:= mes:= pos_ini:= dat1:= c:= e:= n:= 0
   dat1:= CToD("10/01/91")
   acerta()
   return

********************************
procedure CUSTOMINIT

   return

********************************
static function DATAENTRY(Arg1, Arg2, Arg3)

   local Local1, Local2, Local3:= setcursor(1), Local4:= ;
      Set(_SET_SCOREBOARD, .F.)
   Local1:= Arg1:getcolumn(Arg1:colpos())
   Local2:= getnew(Row(), Col(), Local1:block(), Nil, ;
      Arg3[Arg1:colpos()], "N/W*")
   ReadModal({Local2})
   setcursor(Local3)
   Set(Local4)
   Arg1:refreshcur()
   return Nil

********************************
function DBF_SHOW

   local Local1, Local2, Local3
   if (Static48)
      return .T.
   endif
   _push_posi()
   Static48:= .T.
   Local3:= dbstruct()
   Local2:= RecNo()
   Local1:= alias()
   Static50:= 0
   Static49:= 9
   if (!Empty(dbf()))
      SetKey(K_F3, Nil)
      _push_colo("W+/RB")
      openwindow(Static49, Static50, Static49 + 11, Static50 + 77, ;
         "S", 1, Nil)
      @ Static49, Static50 say padc(dbf(), 78) color "B/w*"
      dbedit(Static49 + 2, Static50 + 1, Static49 + 10, Static50 + ;
         76, Nil, "ShowDbf1")
      _pop_color()
      closewindo()
      set key K_F3 to dbf_show
   endif
   alias(Local1)
   goto Local2
   Static48:= .F.
   _pop_posit()
   return .T.

********************************
function DEL_REC(Arg1, Arg2)

   select (Arg1)
   if ;
         (!fil_lock("Arquivo truncado em outra rede. Tenta outra vez (S/N)?", ;
         5))
      return .F.
   endif
   DBEval({|| dbDelete()}, Nil, Nil, Nil, Arg2, .F.)
   unlock
   return .T.

********************************
function DEVICECLOS

   if (Static6 == 2)
      set printer to 
      openwindow(0, 0, 24, 79, "S", 1, "w+/b")
      memoedit(memoread(getenv("TEMP") + "\temp.$$$"), 1, 1, 23, 78, ;
         .F., Nil, 256)
      closewindo()
   endif
   set device to screen
   return .T.

********************************
function DEVICEINIT

   Static6:= _boxalert("Deseja saida para?", Nil, Nil, Nil, ;
      {"Impressora", "Video", "Cancela"}, "W+/B*", "W+/R*")
   Static6:= iif(Static6 == 3, 0, Static6)
   if (Static6 == 2)
      set printer to (getenv("TEMP") + "\temp.$$$")
   endif
   if (Static6 != 0)
      set device to printer
   endif
   set device to printer
   return Static6

********************************
procedure DIA_ATUAL

   if (Month(Date()) = Month(data) .AND. Year(Date()) = Year(data))
      set color to N*/W
      @ alin + adia[Day(Date())] + 3, acol + (DoW(Date()) - 1) * 4 + ;
         2 say _ntoc(Day(Date()), 2)
   endif
   set color to N/W
   @ alin + adia[Day(data)] + 3, acol + (DoW(data) - 1) * 4 + 2 say ;
      _ntoc(Day(data), 2)
   return

********************************
function DNMONTH(Arg1)

   local Local1, Local2, Local3, Local4
   default Arg1 to Date()
   if (!(ISDATE(Arg1)) .OR. Empty(Arg1))
      return CToD(Space(8))
   endif
   Local1:= Month(Arg1)
   Local2:= Year(Arg1)
   Local3:= {31, 28 + iif(mod(Local2, 4) = 0, 1, 0), 31, 30, 31, 30, ;
      31, 31, 30, 31, 30, 31}
   if (Local2 < 2999)
      Arg1:= Arg1 + Local3[Local1]
   endif
   Local4:= Arg1
   return Local4

********************************
exit function DOSRESTOR

   close databases
   select 1
   close format
   _allwindow()
   setmouse("OFF")
   settable("OFF")
   unclock24()
   restore screen from Static12
   SetPos(Static13, Static14)
   return Nil

********************************
init function DOSSAVE

   set color to w+/n
   ? "Sistema de Controle de Gado Leiteiro v1.0á"
   ? "Copyright (c) by Wagner Ramos Molina. 1994"
   set color to 
   ? 
   Static13:= Row()
   Static14:= Col()
   save screen to Static12
   settable("ON")
   blinkbit(.F.)
   return Nil

********************************
function EXPLODE_BO(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)

   local Local1
   private ir, ic, ir1, ic1
   Static30++
   Arg1:= Int(Arg1)
   Arg3:= Int(Arg3)
   Arg2:= Int(Arg2)
   Arg4:= Int(Arg4)
   Static35[Static30]:= Arg1
   Static37[Static30]:= Arg3 + 1
   Static36[Static30]:= Arg2
   Static38[Static30]:= Arg4 + 2
   Static34[Static30]:= 0
   ir:= (Arg1 + Arg3) / 2 - 1
   ic:= (Arg2 + Arg4) / 2 - 1
   ir1:= ir + 1
   ic1:= ic + 1
   Local1:= .F.
   do while (.T.)
      Local1:= !Local1
      if (Local1)
         if (ir > Arg1)
            ir--
            if (ir < Arg1)
               ir:= Arg1
            endif
         endif
         if (ir1 < Arg3)
            ir1++
            if (ir1 > Arg3)
               ir1:= Arg3
            endif
         endif
      endif
      if (ic > Arg2)
         ic--
         if (ic < Arg2)
            ic:= Arg2
         endif
      endif
      if (ic1 < Arg4)
         ic1++
         if (ic1 > Arg4)
            ic1:= Arg4
         endif
      endif
      Static34[Static30]++
      Static33[Static30][Static34[Static30]]:= ;
         SaveScreen(Static35[Static30], Static36[Static30], ;
         Static37[Static30], Static38[Static30])
      mould(ir, ic, ir1, ic1, Arg5, Arg6, Arg7)
      if (ir = Arg1 .AND. ic = Arg2 .AND. ir1 = Arg3 .AND. ic1 = Arg4)
         exit
      endif
   enddo
   return .T.

********************************
function EXTENDDATE(Arg1)

   local Local1, Local2
   Local1:= {"Janeiro", "Fevereiro", "Marco", "Abril", "Maio", ;
      "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", ;
      "Dezembro"}
   Local2:= {"Domingo", "Segunda", "Terca", "Quarta", "Quinta", ;
      "Sexta", "Sabado"}
   default Arg1 to Date()
   if (Empty(Arg1))
      return ""
   endif
   return Local2[DoW(Arg1)] + ", " + _ntoc(Day(Arg1), 2) + " de " + ;
      Local1[Month(Arg1)] + " de" + Str(Year(Arg1))

********************************
function FILTERPRIN(Arg1)

   Arg1:= strtran(Arg1, "‡", "c")
   Arg1:= strtran(Arg1, "€", "C")
   Arg1:= strtran(Arg1, " ", "a")
   Arg1:= strtran(Arg1, "…", "a")
   Arg1:= strtran(Arg1, "ƒ", "a")
   Arg1:= strtran(Arg1, "Æ", "a")
   Arg1:= strtran(Arg1, "¢", "o")
   Arg1:= strtran(Arg1, "‚", "e")
   Arg1:= strtran(Arg1, "§", "o")
   Arg1:= strtran(Arg1, "¦", "a")
   Arg1:= strtran(Arg1, "£", "u")
   Arg1:= strtran(Arg1, "ä", "o")
   Arg1:= strtran(Arg1, "“", "o")
   Arg1:= strtran(Arg1, "•", "o")
   return Arg1

********************************
function FIL_LOCK(Arg1, Arg2)

   local Local1, Local2, Local3
   if (FLock())
      return .T.
   endif
   Local2:= .T.
   Local1:= Arg2 = 0
   do while (Local2)
      Local3:= Arg2
      do while (Local1 .OR. Local3 > 0)
         if (FLock())
            return .T.
         endif
         InKey(0.5)
         Local3:= Local3 - 0.5
      enddo
      Local2:= input_sn(Arg1) = "S"
   enddo
   return .F.

********************************
function FOREGROUND(Arg1, Arg2)

   local Local1, Local2, Local3, Local4, Local5
   Local3:= ""
   for Local2:= 1 to Len(Arg1)
      Local4:= Asc(SubStr(Arg1, Local2, 1))
      if (Local4 != 32 .AND. fontheight() >= 14 .AND. mswversion() = ;
            0)
         fontget(Local4, 14, 1, @Local1)
         Local4:= 129 + Local2
         fontput(Local4, 14, 1, Local1)
      endif
      Local3:= Local3 + Chr(Local4)
   next
   Local5:= 2000 / Len(Local3) + 2
   areplicate(0, 0, Local3, Local5, atoattr(Arg2))
   return .T.

********************************
function GRADIA

   for d:= 1 to 8
      gra1:= "AGEN_DAT" + right("0" + alltrim(Str(d)), 1)
      gra2:= "AGEN_TIM" + right("0" + alltrim(Str(d)), 1)
      replace &gra1 with hist[d]
      replace &gra2 with hora[d]
   next
   set century off
   replace agen_data with data
   set century on
   return .T.

********************************
function IMPLODE_BO

   local Local1
   if (Static30 < 1)
      return .F.
   endif
   for Local1:= Static34[Static30] to 1 step -1
      RestScreen(Static35[Static30], Static36[Static30], ;
         Static37[Static30], Static38[Static30], ;
         Static33[Static30][Local1])
      Static33[Static30][Local1]:= Nil
   next
   Static35[Static30]:= Static36[Static30]:= Static37[Static30]:= ;
      Static38[Static30]:= Nil
   Static30--
   return .T.

********************************
function INPUT_DATE(Arg1, Arg2, Arg3, Arg4)

   local Local1, Local2, Local3, Local4
   Local4:= {}
   default Arg4 to iif(!blinkbit(), "W+/B*", "W+/G")
   Local1:= CToD(Space(8))
   Local2:= Len(Arg1) + 3
   Local3:= Local2 / 2
   default Arg3 to 36 - Local3
   default Arg2 to 17
   openwindow(Arg2, Arg3, Arg2 + 2, Arg3 + Local2 + 10, "S", 2, Arg4)
   do while (.T.)
      @ Arg2 + 1, Arg3 + 2 say Arg1
      SetPos(Row(), Col() + 1)
      AAdd(Local4, __Get({|_1| iif(ISNIL(_1), Local1, Local1:= _1)}, ;
         "idDat", "99/99/99", Nil, Nil, {}):display())
      ATail(Local4):colordisp(Arg4)
      ReadModal(Local4)
      if (LastKey() == K_ESC)
         Local1:= CToD(Space(8))
         exit
      endif
      if (Local1 != CToD(Space(8)))
         exit
      endif
      beep(1)
   enddo
   closewindo()
   return Local1

********************************
function INPUT_SN(Arg1, Arg2, Arg3, Arg4, Arg5)

   local Local1
   Local1:= {}
   default Arg2 to (80 - Len(Arg1)) / 2 - 2
   default Arg3 to 21
   default Arg4 to iif(!blinkbit(), "W+/R*", "W/R")
   default Arg5 to "SN"
   _push_posi()
   openwindow(Arg3, Arg2, Arg3 + 2, Arg2 + Len(Arg1) + 5, "S", 2, ;
      Arg4)
   @ Arg3 + 1, Arg2 + 2 say Arg1 color Arg4
   SetPos(Row(), Col() + 1)
   AAdd(Local1, __Get({|_1| iif(ISNIL(_1), Static5, Static5:= _1)}, ;
      "iSnRes", "@!", {|| Static5 $ Arg5}, Nil, {}):display())
   ReadModal(Local1)
   closewindo()
   _pop_posit()
   return Static5

********************************
function MAIN

   local Local1
   setcancel(.F.)
   setcursor(0)
   set confirm off
   set date british
   set exclusive off
   set key K_F2 to calculator
   set key K_F3 to dbf_show
   set key K_F4 to agend
   set key K_ALT_X to scc_exit
   set key K_ALT_M to scc_high
   set deleted on
   set scoreboard off
   set wrap on
   set default to c:\SCGL
   set path to c:\SCGL
   if (fontvalid(1))
      flcalligra(1)
   endif
   foreground(" ", "W*/N")
   setmouse("ON")
   if (setmouse())
      m_csroff()
   endif
   scc_open()
   if (fontvalid(1))
      fl3270(1)
   endif
   if (!_password("SCCPAS", 0))
      quit
   endif
   set color to N/W*
   @  0,  0 say Space(80)
   @ 23,  0 say Space(80)
   @ 24,  0 say Space(80)
   saycenter("Sistema de Controle de Gado Leiteiro v1.0á", 0, "R+/W*")
   saycenter("All Right Reserved. Unauthorized duplication prohibited.", ;
      24)
   @ 23, 65 say portudate()
   if (!settable())
      @  1,  0 say Replicate("Ü", 80) color "N+/W*"
   else
      @  1,  0 say Replicate("", 80) color "W+/N*"
   endif
   set color to W+/R*
   saymouse(1, 61, " " + Left(blisernum(), 15) + " ", "SCC_Open()")
   saymouse(0, 0, iif(settable(), "", "[]"), "SCC_High()", "W+/N")
   set color to N+/W*
   @ 23, 63 say "³"
   @  0, 69 say "³"
   set color to R+/W*
   saymouse(23, 1, "F2", "Calculator()")
   saymouse(23, 17, "F3", "DBF_Show()")
   saymouse(23, 28, "F4", "Agend()")
   saymouse(23, 39, "F10", "SCC_Open()")
   saymouse(23, 50, "Alt+X", "SCC_Exit()")
   set color to B/W*
   saymouse(23, 4, "Calculadora", "Calculator()")
   saymouse(23, 20, "Browse", "DBF_Show()")
   saymouse(23, 31, "Agenda", "Agend()")
   saymouse(23, 43, "About", "SCC_Open()")
   saymouse(23, 56, "Sair", "SCC_Exit()")
   clock24(0, 71, 240)
   _openmessa("Verificando a existencia dos arquivos! Espere um momento...", ;
      4, 5, Nil)
   scc_arcs()
   closewindo()
   set color to W/B
   Local1:= {}
   Local1:= _aaddmenu(Local1, " 1)   Manutencao de Gado ", ;
      "Manager(1)")
   Local1:= _aaddmenu(Local1, " 2)    Relatorios Gerais ", ;
      "SFT_Relator()")
   Local1:= _aaddmenu(Local1, "", "-")
   Local1:= _aaddmenu(Local1, " 3)  Retornar ao Sistema ", "~")
   _popmenu(3, 3, Local1, .T., Nil, Nil, Nil, Nil, Nil, ;
      "Menu Principal")
   return .T.

********************************
static function MAKEABLOCK(Arg1, Arg2, Arg3)

   return {|_1| iif(ISNIL(_1), iif(ISNIL(Arg3[Arg2]), ;
      Arg1[Static46][Arg2], Transform(Arg1[Static46][Arg2], ;
      Arg3[Arg2])), Arg1[Static46][Arg2]:= _1)}

********************************
function MANAGER(Arg1)

   local Local1
   Local1:= {}
   Local1:= _aaddmenu(Local1, " 1) Cadastrar ", "ManagerControl(1," ;
      + Str(Arg1) + ")")
   Local1:= _aaddmenu(Local1, " 2) Pesquisar ", "ManagerSearch(2," + ;
      Str(Arg1) + ")")
   Local1:= _aaddmenu(Local1, " 3)   Alterar ", "ManagerSearch(3," + ;
      Str(Arg1) + ")")
   Local1:= _aaddmenu(Local1, " 4)   Deletar ", "ManagerSearch(4," + ;
      Str(Arg1) + ")")
   Local1:= _aaddmenu(Local1, "", "-")
   Local1:= _aaddmenu(Local1, " 5)  Retornar ", "~")
   _popmenu(Row() + 1, Col() - 10, Local1, .T., Nil, Nil, Nil, Nil, ;
      Nil, "Opcao")
   return .T.

********************************
function MANAGERCON(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7:= 3, ;
      Local8:= 3, Local9:= 0, Local10, Local11, Local12, Local13
   Local1:= .T.
   Local6:= {"ArqGad"}
   Local10:= {}
   Local11:= {"Cadastro", "Pesquisa", "Alteracao", "Delecao"}
   Local12:= {{{|| Upper(Left(arqgad->gad_nom, ;
      Len(alltrim(Local10[Arg5])))) == ;
      Upper(alltrim(Local10[Arg5]))}, {|| ;
      Upper(Left(arqgad->gad_reg, Len(alltrim(Local10[Arg5])))) == ;
      Upper(alltrim(Local10[Arg5]))}, {|| iif(Empty(Local10[Arg5]), ;
      .T., arqgad->gad_nas == Local10[Arg5])}, {|| ;
      iif(Empty(Local10[Arg5]), .T., arqgad->gad_sex == ;
      Local10[Arg5])}}}
   Local13:= {{{"gad_Con", "Gad_Nom", "Gad_Reg", "Gad_San", ;
      "Gad_Nas", "Gad_Sex", "Gad_Var"}, {"Controle", "Nome", ;
      "Registro", "Grau Sangue", "Nascimento", "Sexo", "Variedade"}, ;
      {"9999", "", "", "", "", "", ""}}}
   default Arg3 to 0
   default Arg4 to 0
   default Arg5 to 0
   default Arg6 to 0
   default Arg7 to 0
   default Arg8 to 0
   do while (Local1)
      Local10:= managerget(Arg2, 0)
      if (iif(ISCHARACTER(Arg7), Val(Arg7) != 0, Arg7 != 0))
         Local10[1]:= Arg7
      endif
      managerscr(Local10, Arg3, Arg1 == 1, Arg1 == 1, Arg2, 1, Arg4)
      if (Arg3 >= 2 .AND. Arg1 >= 2)
         set filter to Eval( aFilter[_Var][_CFil])
         dbSetOrder(Arg8)
         dbGoTop()
         if (!EOF())
            openwindow(10, 5, 17, 70, "S", 1, "W+/B")
            Local2:= Local13[Arg2][1]
            Local3:= Local13[Arg2][2]
            Local4:= Local13[Arg2][3]
            dbedit(11, 6, 16, 69, Local2, Nil, Local4, Local3)
            closewindo()
            Local5:= RecNo()
         endif
         set filter to
      endif
      if (Arg1 >= 2 .AND. LastKey() != K_ESC)
         closewindo()
         Local10:= managerget(Arg2, 2)
         Local9:= RecNo()
         managerscr(Local10, 1, Arg1 == 3, .T., Arg2, 2)
      endif
      if (Arg1 != 2 .AND. (Arg1 == 4 .OR. LastKey() != K_ESC) .AND. ;
            input_sn("Confirma " + Local11[Arg1] + " (S/N)?") == "S" ;
            .AND. LastKey() != K_ESC)
         if (Arg1 == 1)
            new_rec({|| managerwri(Local10)}, Local6[Arg2])
         elseif (Arg1 == 3)
            write_rec({|| managerwri(Local10)}, Local6[Arg2], Local9)
         elseif (Arg1 == 4)
            del_rec(Local6[Arg2], Local9)
         endif
      endif
      if (Arg4 == 0)
         Local1:= input_sn("Deseja continuar " + Local11[Arg1] + ;
            " (S/N)?") == "S" .AND. LastKey() != K_ESC
      else
         Local1:= .F.
      endif
      closewindo()
      set relation to
   enddo
   return .T.

********************************
function MANAGERGET(Arg1, Arg2)

   local Local1, Local2, Local3, Local4
   Local2:= {}
   Local4:= {"ArqGad"}
   Local3:= Local4[Arg1]
   select (Local3)
   if (Arg2 == 0)
      goto 0
   endif
   for Local1:= 1 to FCount()
      AAdd(Local2, fieldget(Local1))
   next
   return Local2

********************************
function MANAGERSCR(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)

   local Local1
   Local1:= {}
   if (Arg5 == 1)
      telagado(@Arg1, Arg6, Arg4, @Local1)
   endif
   if (Arg3)
      ReadModal(Local1)
   elseif (Arg2 == 0)
      Local1:= {}
   else
      _one_get(Arg2, @Local1)
   endif
   set relation to
   return .T.

********************************
function MANAGERSEA(Arg1, Arg2)

   local Local1
   Local1:= {}
   if (Arg2 == 1)
      Local1:= _aaddmenu(Local1, " 1)  pelo Controle ", ;
         "ManagerControl(" + Str(Arg1) + "," + Str(Arg2) + ",1)")
      Local1:= _aaddmenu(Local1, " 2)      pelo Nome ", ;
         "ManagerControl(" + Str(Arg1) + "," + Str(Arg2) + ;
         ",2,,2,1,,3)")
      Local1:= _aaddmenu(Local1, " 3)  pelo Registro ", ;
         "ManagerControl(" + Str(Arg1) + "," + Str(Arg2) + ;
         ",3,,3,2,,3)")
      Local1:= _aaddmenu(Local1, " 4) por Nascimento ", ;
         "ManagerControl(" + Str(Arg1) + "," + Str(Arg2) + ;
         ",05,,05,3,,3)")
      Local1:= _aaddmenu(Local1, " 5)      pelo Sexo ", ;
         "ManagerControl(" + Str(Arg1) + "," + Str(Arg2) + ;
         ",06,,06,4,,3)")
      Local1:= _aaddmenu(Local1, "", "-")
      Local1:= _aaddmenu(Local1, " 6)       Retornar ", "~")
   endif
   _popmenu(Row() + 1, Col() - 10, Local1, .T., Nil, Nil, Nil, Nil, ;
      Nil, "Gado")
   return .T.

********************************
function MANAGERWRI(Arg1)

   local Local1
   for Local1:= 1 to FCount()
      fieldput(Local1, Arg1[Local1])
   next
   return .T.

********************************
function MESSAGE(Arg1, Arg2, Arg3)

   return _boxalert(Arg1, Nil, Nil, Arg3, Arg2)

********************************
function MINKEY

   local Local1, Local2
   Local1:= 0
   do while (Local1 == 0)
      Local1:= InKey()
      if (mousesay())
         Local1:= 0
      endif
   enddo
   return Local1

********************************
function MMENUTO(Arg1, Arg2, Arg3)

   local Local1, Local2
   Local2:= Len(Static23)
   default Arg1 to "n/w"
   default Arg2 to right(SetColor(), At("/", SetColor()) - 1) + "+"
   default Arg3 to 1
   Arg3:= iif(Arg3 > Local2, Local2, Arg3)
   Local1:= iif(Local2 < 1, 0, mmoveto(Local2, Arg1, Arg2, Arg3))
   return Local1

********************************
static function MMOVETO(Arg1, Arg2, Arg3, Arg4)

   local Local1, Local2:= .T., Local3:= 0, Local4, Local5, Local6, ;
      Local7, Local8
   Local7:= setcursor(0)
   Local1:= Arg4
   for Local8:= 1 to Arg1
      @ Static23[Local8][1], Static23[Local8][2] + ;
         Static23[Local8][4] - 1 say Static23[Local8][5] color Arg3
   next
   do while (Local2)
      @ Static23[Local1][1], Static23[Local1][2] say ;
         Static23[Local1][3] color Arg2
      Local3:= 0
      if (setmouse())
         m_csron()
      endif
      do while (Local3 == 0)
         Local3:= InKey()
         if (Local3 == 0 .AND. setmouse())
            Local5:= mregion(m_row(), m_col())
            if (Local5 != 0)
               Local4:= readmouse()
               if (Local4 == 1)
                  @ Static23[Local1][1], Static23[Local1][2] say ;
                     Static23[Local1][3]
                  Local1:= Local5
                  Local3:= 13
                  @ Static23[Local1][1], Static23[Local1][2] say ;
                     Static23[Local1][3] color Arg2
               endif
            else
               mousesay()
            endif
         endif
      enddo
      if (setmouse())
         m_csroff()
      endif
      @ Static23[Local1][1], Static23[Local1][2] say ;
         Static23[Local1][3]
      @ Static23[Local1][1], Static23[Local1][2] + ;
         Static23[Local1][4] - 1 say Static23[Local1][5] color Arg3
      if (Local3 == 13)
         RestScreen(Static24[Local1][2], Static24[Local1][3], ;
            Static24[Local1][2] + 1, Static24[Local1][3] + ;
            Static24[Local1][4] + 2, Static24[Local1][1])
         InKey(0.1)
         Local2:= .F.
      endif
      do case
      case Local3 == 5 .OR. Local3 == 19
         Local1:= iif(Local1 = 1, Arg1, Local1 - 1)
      case Local3 == 24 .OR. Local3 == 4
         Local1:= iif(Local1 = Arg1, 1, Local1 + 1)
      case Local3 == 27
         Local1:= 0
         Local2:= .F.
      case (Local6:= SetKey(Local3)) != Nil
         _push_colo(SetColor())
         _push_posi()
         setcursor(Local7)
         oldver:= {Local1, Local5, Static23, Static24, Local7, Local2}
         Static23:= {}
         Static24:= {}
         Local5:= Local1:= 1
         eval(Local6, {|| (procname(), procline, readvar())})
         Local1:= oldver[1]
         Local5:= oldver[2]
         Static23:= oldver[3]
         Static24:= oldver[4]
         Local7:= oldver[5]
         Local2:= oldver[6]
         setcursor(0)
         _pop_posit()
         _pop_color()
      otherwise
         mfim:= .T.
         mnew:= 1
         do while (mnew <= Len(Static23) .AND. mfim)
            if (Upper(Chr(Local3)) == Upper(Static23[mnew][5]))
               Local1:= mnew
               keyboard Chr(13)
               mfim:= .F.
            endif
            mnew++
         enddo
      endcase
   enddo
   setcursor(Local7)
   if (setmouse())
      m_csroff()
   endif
   Static23:= {}
   Static24:= {}
   return Local1

********************************
function MOULD(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)

   default Arg6 to SetColor()
   Arg5:= Upper(Arg5)
   if (Arg2 < 0 .OR. Arg2 = Nil)
      Arg2:= 0
   endif
   setattr(Arg1 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2, 8)
   @ Arg1, Arg2, Arg3, Arg4 box Replicate(" ", 9) color Arg6
   if (Arg5 = "D")
      @ Arg1, Arg2, Arg3, Arg4 box iif(!settable(), "ÉÍ»º¼ÍÈº", ;
         Chr(10) + "" + Chr(13) + "") color Arg6
   elseif (Arg5 = "S")
      @ Arg1, Arg2, Arg3, Arg4 box iif(!settable(), "ÚÄ¿³ÙÄÀ³", ;
         Chr(10) + "" + Chr(13) + "") color Arg6
   else
      @ Arg1, Arg2, Arg3, Arg4 box Arg5 color Arg6
   endif
   return .T.

********************************
function MOUSESAY

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10
   Local1:= 1
   if (setmouse() .AND. readmouse() = 1)
      do while (Local1 <= Len(Static8))
         Local2:= m_col()
         Local3:= m_row()
         if (Static8[Local1][1] = Local3 .AND. Local2 >= ;
               Static8[Local1][2] .AND. Local2 <= Static8[Local1][2] ;
               + Static8[Local1][3] - 1)
            m_csroff()
            Local10:= alias()
            Local8:= Col()
            Local9:= Row()
            Local7:= SetColor()
            Local5:= Static8[Local1][4]
            Local6:= &Local5
            SetPos(Local9, Local8)
            set color to (Local7)
            alias(Local10)
            m_csron()
            return .T.
         endif
         Local1++
      enddo
   endif
   return .F.

********************************
function MPROMPT(Arg1, Arg2, Arg3, Arg4)

   local Local1, Local2, Local3
   default Arg4 to .F.
   Local1:= At("~", Arg3)
   Local1:= iif(Local1 = 0, At(LTrim(Arg3), Arg3), Local1)
   Arg3:= strtran(Arg3, "~", "")
   Local2:= SubStr(Arg3, Local1, 1)
   @ Arg1, Arg2 say Arg3
   AAdd(Static24, {SaveScreen(Arg1, Arg2, Arg1 + 1, Arg2 + Len(Arg3) ;
      + 2), Arg1, Arg2, Len(Arg3)})
   if (Arg4)
      writeshado(Arg1, Arg2, Arg3)
   endif
   AAdd(Static23, {Arg1, Arg2, Arg3, Local1, Local2})
   return .T.

********************************
static function MREGION(Arg1, Arg2)

   local Local1, Local2
   Local1:= 0
   for Local2:= 1 to Len(Static23)
      if (Arg1 == Static23[Local2][1] .AND. Arg2 >= ;
            Static23[Local2][2] .AND. Arg2 <= Static23[Local2][2] + ;
            Len(Static23[Local2][3]) - 1)
         Local1:= Local2
      endif
   next
   return Local1

********************************
function NEW_REC(Arg1, Arg2, Arg3)

   local Local1, Local2
   default Arg3 to .T.
   select (Arg2)
   if ;
         (!fil_lock("Arquivo truncado em outra rede. Tenta outra vez (S/N)?", ;
         5))
      return .F.
   endif
   append blank
   Local2:= ValType(Arg1)
   if (Local2 == "C")
      Local1:= &Arg1
   elseif (Local2 == "B")
      eval(Arg1)
   endif
   if (Arg3)
      commit
   endif
   unlock
   return .T.

********************************
static function OPENPASS(Arg1)

   local Local1
   Local1:= {}
   AAdd(Local1, {"PASS_NOM", "C", 30, 0})
   AAdd(Local1, {"PASS_COD", "C", 20, 0})
   AAdd(Local1, {"PASS_NIV", "C", 5, 0})
   usedbf(Arg1, Local1, "ArqPas", .T., "PASS_NOM")
   return .T.

********************************
function OPENWINDOW(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)

   Arg6:= iif(cputype() < 80386.0, 1, Arg6)
   AAdd(Static32, {SaveScreen(Arg1, Arg2, Arg3 + 1, Arg4 + 2), Arg1, ;
      Arg2, Arg3 + 1, Arg4 + 2, Arg6})
   if (Arg6 == 1)
      mould(Arg1, Arg2, Arg3, Arg4, Arg5, Arg7)
   elseif (Arg6 == 2)
      explode_bo(Arg1, Arg2, Arg3, Arg4, Arg5, Arg7)
   endif
   return .T.

********************************
function PACK_FIL(Arg1)

   select (Arg1)
   if ;
         (!fil_lock("Arquivo truncado em outra rede. Tenta outra vez (S/N)?", ;
         5))
      return .F.
   endif
   pack
   unlock
   return .T.

********************************
function PORTUDATE(Arg1)

   local Local1, Local2
   Local1:= {"Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", ;
      "Set", "Out", "Nov", "Dez"}
   Local2:= {"Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"}
   default Arg1 to Date()
   if (Empty(Arg1))
      return ""
   endif
   return Local2[DoW(Arg1)] + ", " + SubStr(DToC(Arg1), 1, 3) + ;
      Local1[Month(Arg1)] + SubStr(DToC(Arg1), 6, 3)

********************************
function READMOUSE

   local Local1, Local2
   Local2:= 0
   if (!setmouse())
      return 0
   endif
   Local2:= button()
   if (Local2 != 0)
      do while (Local2 == button())
      enddo
   endif
   return Local2

********************************
function REC_LOCK(Arg1, Arg2)

   local Local1, Local2, Local3
   if (RLock())
      return .T.
   endif
   Local2:= .T.
   Local1:= Arg2 = 0
   do while (Local2)
      Local3:= Arg2
      do while (Local1 .OR. Local3 > 0)
         if (RLock())
            return .T.
         endif
         InKey(0.5)
         Local3:= Local3 - 0.5
      enddo
      Local2:= input_sn(Arg1) = "S"
   enddo
   return .F.

********************************
function SAYCENTER(Arg1, Arg2, Arg3)

   local Local1
   default Arg2 to 12
   default Arg3 to SetColor()
   Local1:= (80 - Len(Arg1)) / 2
   @ Arg2, Local1 say Arg1 color Arg3
   return .T.

********************************
function SAYMOUSE(Arg1, Arg2, Arg3, Arg4, Arg5)

   default Arg4 to "_PopEmpty()"
   default Arg5 to SetColor()
   AAdd(Static8, {Arg1, Arg2, Len(Arg3), Arg4})
   @ Arg1, Arg2 say Arg3 color Arg5
   return .T.

********************************
function SCC_ARCS

   local Local1
   Local1:= {}
   close databases
   select 1
   close format
   AAdd(Local1, {"GAD_CON", "N", 4, 0, "Codigo de Controle"})
   AAdd(Local1, {"GAD_NOM", "C", 40, 0, "Nome do Animal"})
   AAdd(Local1, {"GAD_REG", "C", 17, 0, "Registro do Animal"})
   AAdd(Local1, {"GAD_SAN", "C", 4, 0, "Grau de Sangue"})
   AAdd(Local1, {"GAD_NAS", "D", 8, 0, "Data de Nascimento"})
   AAdd(Local1, {"GAD_SEX", "C", 1, 0, "Sexo do Animal"})
   AAdd(Local1, {"GAD_VAR", "C", 2, 0, "Variedade"})
   AAdd(Local1, {"GAD_PAI", "C", 40, 0, "Pai do Animal"})
   AAdd(Local1, {"GAD_PRG", "C", 17, 0, "Registro do Pai"})
   AAdd(Local1, {"GAD_MAE", "C", 40, 0, "Mae do Animal"})
   AAdd(Local1, {"GAD_MRG", "C", 17, 0, "Registro da Mae"})
   AAdd(Local1, {"GAD_OBS", "M", 10, 0, "Observacoes sobre o Animal"})
   usedbf("SCCGAD", Local1, "ArqGad", .T., {"GAD_CON", "GAD_NOM", ;
      "GAD_REG"}, Nil, "Arquivo de Manutencao de Gado")
   return .T.

********************************
function SCC_EXIT

   if (Static10 = .T.)
      return .T.
   endif
   Static10:= .T.
   if (input_sn("Deseja realmente sair do sistema (S/N)?", Nil, 12) ;
         = "N" .OR. LastKey() = K_ESC)
      Static10:= .F.
      return .T.
   endif
   quit
   return .T.

********************************
function SCC_HIGH

   local Local1:= 0, Local2:= 0, Local3:= {}
   if (Static11 = .T.)
      return .T.
   endif
   Static11:= .T.
   Local3:= _aaddmenu(Local3, " ~About         ", "SCC_Open()")
   Local3:= _aaddmenu(Local3, "", "-")
   Local3:= _aaddmenu(Local3, " E~xit    Alt+X ", "SCC_Exit()")
   _popmenu(Local1, Local2, Local3, .F., "N/W*", Nil, Nil, Nil, Nil, ;
      Nil, .T.)
   Static11:= .F.
   return .T.

********************************
function SCC_OPEN

   local Local1:= Col(), Local2:= Row(), Local3:= 5, Local4:= 4, ;
      Local5
   Local5:= SetColor("N/W*")
   if (Static15)
      return .T.
   endif
   Static15:= .T.
   SetKey(K_F10, Nil)
   openwindow(Local4, Local3, Local4 + 15, Local3 + 70, ;
      "          ", 1, Nil)
   @ Local4, Local3 say padc("Informacoes", 71) color "W+/w"
   @ Local4 + 2, Local3 + 2 to Local4 + 6, Local3 + 68
   @ Local4 + 3, Local3 + 4 say "Sistema Controle de Gado Leiteiro."
   @ Local4 + 4, Local3 + 4 say "Version 1.0á"
   @ Local4 + 5, Local3 + 4 say ;
      "Copyright (c) 1994. All rights reserved."
   @ Local4 + 8, Local3 + 2 to Local4 + 11, Local3 + 68
   @ Local4 + 9, Local3 + 4 say "Programmer: WS Assessorias S/C. Ltd."
   @ Local4 + 10, Local3 + 4 say "Company: Wagner Ramos Molina."
   set color to "B/W*"
   @ Local4 + 2, Local3 + 4 say " Program Information "
   @ Local4 + 8, Local3 + 4 say " Developer Information "
   _sayout(Local4 + 14, Local3 + 31, "ßßßßßßßßßß")
   mprompt(Local4 + 13, Local3 + 30, "    Ok    ")
   _sayout(Local4 + 13, Col(), "Ü")
   set color to w+/n
   _pushmouse()
   saymouse(Local4, Local3, iif(settable(), "", "[]"), ;
      "__keyboard( chr(27))")
   set color to BG+/B
   mmenuto("B/BG*")
   _popmouse()
   closewindo()
   set key K_F10 to scc_open
   set color to (Local5)
   SetPos(Local2, Local1)
   Static15:= .F.
   return .T.

* EOF
