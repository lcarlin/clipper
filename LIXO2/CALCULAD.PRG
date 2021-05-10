#include "common.ch"
#include "inkey.ch"

********************************
function CALCULAD

   parameters calc_lin, calc_col, calc_cor
   private c_cor_ant, clin, corrente, atual, decimal, ult_char, ;
      operador, primeiro, tecla_pres, dp, calc_char, corvisor, ;
      corcalc, corteccalc, cor_calc, cor_tecla_, cor_visor_, enter, ;
      igual, esc, setadir, setaesq, setabaixo, setacima, move_tecla, ;
      cortemp, lowcortemp, cont_opera, tl_calc, tl_ant, estcur
   if (PCount() < 2 .OR. Type("calc_lin") != "N" .OR. ;
         Type("calc_col") != "N")
      calc_lin:= 1
      calc_col:= 53
   else
      if (calc_lin > 8)
         calc_lin:= 8
      endif
      if (calc_col > 53)
         calc_col:= 53
      endif
   endif
   estcur:= setcursor()
   setcursor(0)
   corvisor:= "n/w, n/w, "
   corcalc:= "w+/n, w+/n, "
   corteccalc:= corcalc
   if (Type("calc_cor") = "C")
      lowcortemp:= Lower(calc_cor)
      if (lowcortemp $ "n\b\g\bg\r\rb\gr\w")
         cortemp:= "w+"
         corteccalc:= "n/" + calc_cor + ", n/" + calc_cor + ", "
         if (lowcortemp = "n")
            corteccalc:= "w+/n, w+/n, "
         elseif (lowcortemp = "w" .OR. lowcortemp = "bg" .OR. ;
               lowcortemp = "gr")
            if (lowcortemp = "w")
               corvisor:= "w+/n, w+/n, "
            endif
            cortemp:= "n"
         endif
         corcalc:= cortemp + "/" + calc_cor + ", " + cortemp + "/" + ;
            calc_cor + ", "
      endif
   endif
   cor_calc:= corcalc
   cor_tecla_:= corteccalc
   cor_visor_:= corvisor
   esc:= 27
   enter:= 13
   igual:= 61
   setadir:= 4
   setaesq:= 19
   setacima:= 5
   setabaixo:= 24
   move_tecla:= Chr(setadir) + Chr(setaesq) + Chr(setacima) + ;
      Chr(setabaixo)
   tam_max_nu:= 19
   clin:= 0
   c_cor_ant:= SetColor(cor_calc)
   tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
      23)
   @ calc_lin, calc_col to calc_lin + 15, calc_col + 23
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 to calc_lin + clin + 3, calc_col ;
      + 22
   clin:= clin + 1
   set color to (cor_visor_)
   @ calc_lin + clin, calc_col + 2 say Space(20)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 2 say Space(20)
   clin:= clin + 2
   set color to (cor_calc)
   @ calc_lin + clin, calc_col + 1 say "  C    cE   Sr     ö/ "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  7    8    9      *  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  4    5    6      +  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  1    2    3      -  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   set color to (cor_calc)
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say "  0    .    Yü     =  "
   set color to (cor_tecla_)
   @ calc_lin + clin, calc_col + 5 say "³"
   @ calc_lin + clin, calc_col + 10 say "³"
   @ calc_lin + clin, calc_col + 15 say "³"
   @ calc_lin + clin, calc_col + 22 say "³"
   clin:= clin + 1
   @ calc_lin + clin, calc_col + 1 say " ÍÍÍ¾ ÍÍÍ¾ ÍÍÍ¾   ÍÍÍ¾"
   tl_calc:= SaveScreen(calc_lin, calc_col, calc_lin + 15, calc_col ;
      + 23)
   tecla_pres:= dp:= 0
   corrente:= atual:= 0
   operador:= " "
   ult_char:= "C"
   decimal:= .F.
   primeiro:= .T.
   cont_opera:= 0
   algarismo:= .F.
   calc_char:= " "
   do while (tecla_pres != esc)
      set color to (cor_visor_)
      if (calc_char $ "+-*Y/")
         @ calc_lin + 2, calc_col + 2 say calc_char
      endif
      @ calc_lin + 3, calc_col + 2 say corrente picture ;
         "@E 9,999,999,999,999.99"
      tecla_pres:= 0
      tecla_pres:= InKey(0)
      if (tecla_pres = enter)
         tecla_pres:= igual
      elseif ((tecla_pres = 114 .OR. tecla_pres = 82) .AND. ;
            procname(3) = "GET")
         exit
      endif
      calc_char:= Upper(Chr(tecla_pres))
      if (calc_char $ "+-/*Y")
         algarismo:= .F.
         if (cont_opera == 0)
            cont_opera:= 1
         else
            operador:= calc_char
            loop
         endif
      else
         cont_opera:= 0
      endif
      do case
      case tecla_pres = esc
      case calc_char $ move_tecla
         do case
         case tecla_pres = setadir
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_col:= calc_col + 1
            if (calc_col + 23 > 78)
               calc_col:= 1
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         case tecla_pres = setaesq
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_col:= calc_col - 1
            if (calc_col < 1)
               calc_col:= 55
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         case tecla_pres = setacima
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_lin:= calc_lin - 1
            if (calc_lin < 1)
               calc_lin:= 9
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         case tecla_pres = setabaixo
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_ant)
            calc_lin:= calc_lin + 1
            if (calc_lin + 15 > 24)
               calc_lin:= 1
            endif
            tl_ant:= SaveScreen(calc_lin, calc_col, calc_lin + 15, ;
               calc_col + 23)
            RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + ;
               23, tl_calc)
         endcase
         if (!algarismo)
            cont_opera:= 1
         endif
      case calc_char = "E"
         corrente:= 0
         dp:= 0
      case calc_char = "C"
         @ calc_lin + 2, calc_col + 2 say " "
         ult_char:= calc_char
         corrente:= 0
         atual:= 0
      case calc_char = "="
         @ calc_lin + 2, calc_col + 2 say " "
         if (atual = 0 .AND. operador != "Y")
            atual:= corrente
            operador:= " "
         endif
         calc_math()
         ult_char:= "="
      case calc_char = "S"
         if (ult_char = "=")
            corrente:= atual:= Sqrt(corrente)
         else
            corrente:= Sqrt(corrente)
         endif
      case calc_char $ "+-/*Y"
         if (ult_char $ "=C")
            @ calc_lin + 2, calc_col + 2 say " "
            if (ult_char = "C")
               atual:= corrente
            endif
            ult_char:= " "
            primeiro:= .T.
         else
            calc_math()
         endif
         operador:= ult_char:= calc_char
         dp:= 0
      case calc_char = "."
         decimal:= .T.
      case calc_char $ "0123456789"
         algarismo:= .T.
         get_corren()
      endcase
   enddo
   RestScreen(calc_lin, calc_col, calc_lin + 15, calc_col + 23, ;
      tl_ant)
   set color to (c_cor_ant)
   setcursor(estcur)
   if (tecla_pres = 114 .OR. tecla_pres = 82)
      keyboard alltrim(Str(corrente, 10, 2))
   else
      clear typeahead
   endif
   return .T.

********************************
static function CALC_MATH

   do case
   case operador = "+"
      atual:= atual + corrente
   case operador = "-"
      atual:= atual - corrente
   case operador = "*"
      atual:= atual * corrente
   case operador = "/"
      if (corrente == 0)
         atual:= 0
         corrente:= 0
         @ calc_lin + 3, calc_col + 2 say "          E r r o!!"
         InKey(0)
         clear typeahead
         keyboard "C"
      else
         atual:= atual / corrente
      endif
   case operador = "Y"
      atual:= atual ^ corrente
   endcase
   corrente:= atual
   primeiro:= .T.
   dp:= 0
   return .T.


********************************
static function GET_CORREN

   if (decimal)
      if (primeiro)
         primeiro:= .F.
         corrente:= Val("0." + calc_char)
      else
         corrente:= Val(LTrim(Str(corrente, tam_max_nu, 0)) + "." + ;
            calc_char)
      endif
      decimal:= .F.
      dp:= 1
   elseif (primeiro)
      primeiro:= .F.
      corrente:= Val(calc_char)
   else
      corrente:= Val(LTrim(Str(corrente, tam_max_nu, dp)) + calc_char)
      if (dp > 0)
         dp:= dp + 1
      endif
   endif
   return .T.

* EOF

* EOF
