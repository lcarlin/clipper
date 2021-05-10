
********************************
* PROCEDURE QUE PERMITE ALTERAR AS CORES DO SISTEMA
* ROUBADA DO GENESIS
******************************
Function CORES

   local Local1:= SetColor(), Local2, Local3:= {}, Local4:= {}, ;
      Local5:= {}, Local6:= 1, Local7:= 0, Local8:= 0, Local9:= 0, ;
      Local10:= 0, Local11:= 0, Local12:= 0, Local13:= " Op‡”es ", ;
      Local14:= " Frente ", Local15:= " Fundo ", Local16:= {}, Local17
   if (iscolor() = .F.)
      tone(600, 1)
      tone(500, 1)
      alert("Recurso n„o disponivel neste equipamento !!")
      return ""
   endif
   IF .NOT. file("Cores.mem")
      cCorTmpa:= "w+ /n  ,n  /w  ,n,n,gr+/n  "
      cCorTmme:= "n  /w  ,w+ /b  ,n,n,w+ /b  "
      cCorTmbo:= "w+ /r  ,n  /g  ,n,n,w+ /r  "
      cCorTmca:= "w+ /bg "
      cCorTmre:= "w+ /bg "
      cCorTmla:= "w+ /b  "
      cCorTmte:= "b  /bg "
      save all like cCortm* to cores
      cCorpadra:= cCorTmpa
      cCormenu:= cCorTmme
      cCortela:= cCorTmte
      cCorbotao:= cCorTmbo
      cCorregua:= cCorTmre
      cCorlayou:= cCorTmla
      cCorcaixa:= cCorTmca
   ENDIF
   setcursor(0)
*  limparodap()
   set color to (cCormenu)
   @ 24,  1 say "³ESC³Sai   ³TAB³Avan‡a   ³SHFTt+TAB³Retorna   "
   sombra(3,20,21,67)
   @ 03,30 say "Deficicao de Cores"
*  openwindow(3, 20, 21, 67, " Defini‡„o de Cores ", Nil, .F., .F., ;
*      .F., .T.)
   if (Len(cCorpadra) != 27)
      cCorTmpa:= "w+ /n  ,n  /w  ,n,n,gr+/n  "
      cCorTmme:= "n  /w  ,w+ /b  ,n,n,w+ /b  "
      cCorTmca:= "w+ /bg "
      cCorTmbo:= "w+ /r  ,n  /g  ,n,n,w+ /r  "
      cCorTmre:= "w+ /bg "
      cCorTmla:= "w+ /b  "
      cCorTmte:= "b  /bg "
   endif
   AAdd(Local3, {" Apresenta‡„o Edi‡„o    ", SubStr(cCorTmpa, 1, ;
      3), SubStr(cCorTmpa, 5, 3)})
   AAdd(Local3, {" Selecionado Edi‡„o     ", SubStr(cCorTmpa, 9, ;
      3), SubStr(cCorTmpa, 13, 3)})
   AAdd(Local3, {" N„o selecionado Edi‡„o ", SubStr(cCorTmpa, 21, ;
      3), SubStr(cCorTmpa, 25, 3)})
   AAdd(Local3, {" Apresenta‡„o Menu      ", SubStr(cCorTmme, 1, ;
      3), SubStr(cCorTmme, 5, 3)})
   AAdd(Local3, {" Selecionado Menu       ", SubStr(cCorTmme, 9, ;
      3), SubStr(cCorTmme, 13, 3)})
   AAdd(Local3, {" N„o Selecionado Menu   ", SubStr(cCorTmme, 21, ;
      3), SubStr(cCorTmme, 25, 3)})
   AAdd(Local3, {" Caixa Op‡”es Menu      ", SubStr(cCorTmca, 1, ;
      3), SubStr(cCorTmca, 5, 3)})
   AAdd(Local3, {" Bot„o Selecionado      ", SubStr(cCorTmbo, 9, ;
      3), SubStr(cCorTmbo, 13, 3)})
   AAdd(Local3, {" Bot„o N„o Selecionado  ", SubStr(cCorTmbo, 1, ;
      3), SubStr(cCorTmbo, 5, 3)})
   AAdd(Local3, {" R‚gua Lay-Out          ", SubStr(cCorTmre, 1, ;
      3), SubStr(cCorTmre, 5, 3)})
   AAdd(Local3, {" Lay-Out                ", SubStr(cCorTmla, 1, ;
      3), SubStr(cCorTmla, 5, 3)})
   AAdd(Local3, {" Fundo Tela Principal   ", SubStr(cCorTmte, 1, ;
      3), SubStr(cCorTmte, 5, 3)})
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
   set color to (cCormenu)
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
   set color to (cCormenu)
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
   set color to (cCormenu)
   @  5, 23 to 18, 48
   SetPos(5, 32)
   AAdd(Local16, __Get({|_1| iif(empty(_1), Local13, Local13:= _1)}, ;
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
      set color to (cCormenu)
      SetPos(Local6 + 5, 24)
      AAdd(Local16, __GetA({|| Local3}, "G_165Sky", Nil, Nil, Nil, ;
         {Local6, 1}):display())
      __KillRead()
      Local16:= {}
      if (LastKey() == K_ESC)
         exit
      endif
      InKey(0)
      set color to (cCormenu)
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
         set color to (cCormenu)
         @  5, 32 say Local13
         SetPos(5, 54)
         AAdd(Local16, __Get({|_1| iif(empty(_1), Local14, Local14:= ;
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
               set color to (cCormenu)
               @  5, 54 say Local14
               SetPos(12, 54)
               AAdd(Local16, __Get({|_1| iif(empty(_1), Local15, ;
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
               set color to (cCormenu)
               @ 12, 54 say Local15
               SetPos(5, 54)
               AAdd(Local16, __Get({|_1| iif(empty(_1), Local14, ;
                  Local14:= _1)}, "G_175Cooper", Nil, Nil, ;
                  Nil):display())
               __KillRead()
               Local16:= {}
               Local3[Local6][3]:= Local5[Local12][3]
            endcase
         enddo
         set color to (cCormenu)
         SetPos(5, 32)
         AAdd(Local16, __Get({|_1| iif(empty(_1), Local13, Local13:= ;
            _1)}, "G_174Alice", Nil, Nil, Nil):display())
         __KillRead()
         Local16:= {}
         @  5, 54 say Local14
         Local3[Local6][2]:= Local4[Local11][3]
      endif
   enddo
   do while (.T.)
      tone(400, 3)
      Local2:= alert("Grava nova configura‡„o de cores?", {"Sim", ;
         "N„o", "Padr„o"})
      set color to (cCorpadra)
      if (Local2 == 1)
         cCorTmpa:= Local3[1][2] + "/" + Local3[1][3] + "," + ;
            Local3[2][2] + "/" + Local3[2][3] + ",n,n," + ;
            Local3[3][2] + "/" + Local3[3][3]
         cCorTmme:= Local3[4][2] + "/" + Local3[4][3] + "," + ;
            Local3[5][2] + "/" + Local3[5][3] + ",n,n," + ;
            Local3[6][2] + "/" + Local3[6][3]
         cCorTmte:= Local3[12][2] + "/" + Local3[12][3]
         cCorTmbo:= Local3[9][2] + "/" + Local3[9][3] + "," + ;
            Local3[8][2] + "/" + Local3[8][3] + ",n,n," + ;
            Local3[9][2] + "/" + Local3[9][3]
         cCorTmre:= Local3[10][2] + "/" + Local3[10][3]
         cCorTmla:= Local3[11][2] + "/" + Local3[11][3]
         cCorTmca:= Local3[7][2] + "/" + Local3[7][3]
         save all like cCortm* to cores
         cCorpadra:= cCorTmpa
         cCormenu:= cCorTmme
         cCortela:= cCorTmte
         cCorbotao:= cCorTmbo
         cCorregua:= cCorTmre
         cCorlayou:= cCorTmla
         cCorcaixa:= cCorTmca
      elseif (Local2 = 2 .OR. Local2 = 0)
         restore from cores additive
      elseif (Local2 == 3)
         cCorTmpa:= "w+ /n  ,n  /w  ,n,n,gr+/n  "
         cCorTmme:= "n  /w  ,w+ /b  ,n,n,w+ /b  "
         cCorTmbo:= "w+ /r  ,n  /g  ,n,n,w+ /r  "
         cCorTmca:= "w+ /bg "
         cCorTmre:= "w+ /bg "
         cCorTmla:= "w+ /b  "
         cCorTmte:= "b  /bg "
         save all like cCortm* to cores
         cCorpadra:= cCorTmpa
         cCormenu:= cCorTmme
         cCortela:= cCorTmte
         cCorbotao:= cCorTmbo
         cCorregua:= cCorTmre
         cCorlayou:= cCorTmla
         cCorcaixa:= cCorTmca
      endif
      exit
   enddo
*   closewindo()
*   limparodap()
   set color to (Local1)
   return ""

* EOF
