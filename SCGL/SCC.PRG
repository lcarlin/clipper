//
//  Sistema de Controle de Gado Leiteiro v1.0á
//  Copyright (c) CAOS TechnoSoft, Inc. 1994.
//  All Right Reserved.
//
//  Program.: SCC.PRG
//  Purpose.: Main System.
//
//  Hackers.: Rogen Alexandre da Silva Cardim
//            Stefano Correa Rodrigues Damaceno
//
//  Linguage: Clipper 5.2
//            Copyright (c) 1985-1993 Computers Associates International, Inc.
//            All Rights Reserved.
//

#include "caos.ch"
#include "funcky.ch"
#include "inkey.ch"

static exAct := FALSE, hiAct := FALSE

announce CustomInit

   static sDosScreen, nDosRow, nDosCol

   function main()
      local lMenu

      setcancel( FALSE)
      set cursor off
      set confirm off
      set date brazil
      set exclusive off
      set key    K_F2 to Calculator()
      set key    K_F3 to DBF_Show
      set key    K_F4 to Agend
      set key K_ALT_X to SCC_Exit()
      set key K_ALT_M to SCC_High()
      set deleted on
      set scoreboard off
      set wrap on

      set default to c:\SCGL
      set path    to c:\SCGL

      if fontValid(1)
         flcalligraphy(1)
      endif

      foreground( " ", "W*/N")

      SetMouse( "ON")
      if setmouse()
         m_csroff()
      endif

      SCC_Open()

      if fontValid(1)
         fl3270(1)
      endif
/*
      If !_PassWord( "SCCPAS", 0)
         quit
      Endif
*/
      setcolor( "N/W*")
      @ 0, 0 Say Space(80)
      @ 23, 0 Say Space(80)
      @ 24, 0 Say Space(80)
      SayCenter( "Sistema de Controle de Gado Leiteiro v1.0á", 0, "R+/W*")
      SayCenter( "All Right Reserved. Unauthorized duplication prohibited.", 24)
      @ 23, 65 Say PortuDate()
      If !SetTable()
         @ 1, 0 Say Replicate( "Ü", 80) Color "N+/W*"
      Else
         @ 1, 0 Say Replicate( Chr(11), 80) Color "W+/N*"
      Endif
      SetColor( "W+/R*")
      SayMouse(  1, 61, " "+left( blisernum(), 15) + " ", "SCC_Open()")
      SayMouse(  0, 0, if( settable(), Chr( 018) + Chr(19), "[]"), "SCC_High()", "W+/N")
      SetColor( "N+/W*")
      @ 23, 63 Say Chr(179)
      @ 00, 69 Say Chr(179)
      SetColor( "R+/W*")
      SayMouse( 23,  1,  "F2", "Calculator()")
      SayMouse( 23, 17,  "F3", "DBF_Show()")
      SayMouse( 23, 28,  "F4", "Agend()")
      SayMouse( 23, 39, "F10", "SCC_Open()")
      SayMouse( 23, 50, "Alt+X", "SCC_Exit()")
      SetColor( "B/W*")
      SayMouse( 23,  4, "Calculadora", "Calculator()")
      SayMouse( 23, 20, "Browse", "DBF_Show()")
      SayMouse( 23, 31, "Agenda", "Agend()")
      SayMouse( 23, 43, "About", "SCC_Open()")
      SayMouse( 23, 56, "Sair", "SCC_Exit()")
      Clock24( 0, 71, 240)
      Open Alert "Verificando a existencia dos arquivos! Espere um momento..." Into 4, 5
      SCC_Arcs()
      Close Alert
      SetColor( "W/B")

      lMenu := {}
      AAdd Menu lMenu With " 1)   Manutencao de Gado ", "Manager(1)"
      aadd menu lMenu with " 2)    Relatorios Gerais ", "SFT_Relator()"
      AAdd Menu lMenu With line
      AAdd Menu lMenu With " 3)  Retornar ao Sistema " End
      Read Menu lMenu Into 03, 03 Title "Menu Principal" Explode

   retry

   init function DosSave
      setcolor( "w+/n")
      ? "Sistema de Controle de Gado Leiteiro v1.0á"
      ? "Copyright (c) by Wagner Ramos Molina. 1994"
      set color to
      ?
      nDosRow := row()
      nDosCol := col()
      save screen to sDosScreen
      settable( "ON")
      blinkbit( false)
   return( NIL )

   exit function DosRestore
      Close All
      _AllWindows()
      SetMouse( "OFF")
      SetTable( "OFF")
      unclock24()
      restore screen from sDosScreen
      setpos( nDosRow, nDosCol)
   return( NIL )

request CustomInit


function SCC_High
   local hiLin := 0, hiCol := 0, hiMen := {}
   if hiAct = TRUE
      retry
   endif
   hiAct := TRUE
   AAdd Menu hiMen With " ~About         ", "SCC_Open()"
   AAdd Menu hiMen With Line
   AAdd Menu hiMen With " E~xit    Alt+X ", "SCC_Exit()"
   Read Menu hiMen Into hiLin, hiCol Color "N/W*" End
   hiAct := FALSE
retry

function SCC_Exit
   if exAct = TRUE
      retry
   endif
   exAct := TRUE
   if input_sn( "Deseja realmente sair do sistema (S/N)?",, 12) = "N" .or. lastkey() = K_ESC
      exAct := FALSE
      retry
   endif
   quit
retry
