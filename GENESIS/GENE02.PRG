* bop gene02.prg
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

* eop gene02.prg