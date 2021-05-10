//
//  Sistema de Controle de Gado v1.0á
//  Copyright (c) CAOS TechnoSoft, Inc. 1993.
//  All Right Reserved.
//
//  Program.: SCC02.PRG
//  Purpose.: Relatorios diversos.
//
//  Programmers: Rogen Alexandre da Silva Cardim
//               Stefano Correa Rodrigues Damaceno
//
//  Linguage: Clipper 5.2
//            Copyright (c) 1985-1993 Computer Associates International, Inc.
//            All Rights Reserved.
//

#include "caos.ch"
#include "inkey.ch"

function SFT_Relator()
   local aMen := {}

   aadd menu aMen with " 1)       pelo Nome ", "SFT_Ropc(1)"
   aadd menu aMen with " 2)   pelo Registro ", "SFT_Ropc(2)"
   aadd menu aMen with " 3) por Grau Sangue ", "SFT_Ropc(3)"
   aadd menu aMen with " 4)       pelo Sexo ", "SFT_Ropc(4)"
   aadd menu aMen with " 5) pelo Nascimento ", "SFT_Ropc(5)"
   aadd menu aMen with " 6)  pela Variedade ", "SFT_Ropc(6)"
   aadd menu aMen with " 7)        pelo Pai ", "SFT_Ropc(7)"
   aadd menu aMen with " 8)        pela Mae ", "SFT_Ropc(8)"
   aadd menu aMen with line
   aadd menu aMen with " 9)        Retornar " end
   read menu aMen into row() + 1, col() - 10 title "Relatorios" explode
retry

function SFT_Ropc( nOpc )
   local aMen := {}

   aadd menu aMen with " 1)      Listagem ", "SFT_Inkey("+str(nOpc)+",1)"
   aadd menu aMen with " 2)         Ficha ", "SFT_Inkey("+str(nOpc)+",2)"
   aadd menu aMen with line
   aadd menu aMen with " 3) Menu anterior " end
   read menu aMen into Row() + 1, col() - 10 title "Relatorio" explode

retry

function SFT_Inkey( nOption, nList )
   local nLin := row() + 1, nCol := 10
   local GetList := {}
   local nDado := { { "Nome....:", space(40), "@!",, 55 }, ;
                    { "Registro:", space(17), "!!/!!-!!!!!!!!!!!",, 30}, ;
                    { "Sangue..:", space(4), "!!!!",, 17}, ;
                    { "Sexo....:", " ", "!", { || (nDado[nOption][2] $ "FM")}, 15}, ;
                    { "Nascimento.:", ctod(space(8)), "99/99/99",, 25}, ;
                    { "Variedade.:", "  ", "!!",, 20}, ;
                    { "Pai.....:", space(40), "@!",, 55 }, ;
                    { "Mae.....:", space(40), "@!",, 55 } ;
                  }

   default nDado[nOption][4] to { || true }

   open window nLin, nCol to nLin + 2, nCol + nDado[nOption][5] color "W+/B" explode

   @ nLin + 1, nCol + 2 say nDado[nOption][1] ;
      get nDado[nOption][2] pict nDado[nOption][3] ;
      valid eval( nDado[nOption][4])

   read

   if nList == 1
      SFT_List( nOption, nDado[nOption][2])
   elseif nList == 2
      SFT_Comp( nOption, nDado[nOption][2])
   endif

   close window
retry

function SFT_List( nOption, nFil, nOrder)
   local pLin := 0, pCol := 0, pPag := 0, pFim := false
   local aBlock := { { || alltrim( nFil) == left( upper( ArqGad->GAD_NOM), len( alltrim( nFil)))}, ;
                     { || nFil == ArqGad->GAD_REG }, ;
                     { || nFil == ArqGad->GAD_SAN }, ;
                     { || nFil == ArqGad->GAD_SEX }, ;
                     { || nFil == ArqGad->GAD_NAS }, ;
                     { || nFil == ArqGad->GAD_VAR }, ;
                     { || alltrim( nFil) == left( upper( ArqGad->GAD_PAI), len( alltrim( nFil)))}, ;
                     { || alltrim( nFil) == left( upper( ArqGad->GAD_MAE), len( alltrim( nFil)))} ;
                   }

   default nOrder  to 1
   default nOption to 1

   select ArqGad
   set order to nOrder
   go top

   open alert "Por favor espere enquanto imprimo... [ESC] para sair..."

   if DeviceInit() <> 0

      do while !eof()
         if eval( aBlock[nOption])

            if pLin == 0
               @ pLin + 1, pCol say chr(14) + padc("CASA DE CARNE WAGNER RAMOS MOLINA", 40)
               @ pLin + 2, pCol say padc( "Relatorio Geral", 40)
               @ pLin + 3, pCol say replicate( "-", 80)
               pLin := 5
            endif

            @ pLin++, pCol say transform( ArqGad->GAD_CON, "9999") + "  -  " + ;
               ArqGad->GAD_NOM + "    " + ArqGad->GAD_REG

            pFim := true

            if pLin > 50
               pLin := 52
               @ pLin++, pCol say replicate( "-", 80)
               @ pLin, pCol say "Wagner Ramos Molina"
               @ pLin, pCol say padl( "Pagina...: " + _ntocz( ++pPag, 2), 80)
               pLin := 0
               pFim := false
            endif

         endif
         skip
      enddo

      if pFim
         pLin := 52
         @ pLin++, pCol say replicate( "-", 80)
         @ pLin, pCol say "Wagner Ramos Molina."
         @ pLin, pCol say padl( "Pagina...: " + _ntocz( ++pPag, 3), 80)
         pLin := 0
         pFim := false
      endif

   endif

   eject

   DeviceClose()

   close alert
retry

function SFT_Comp( nOption, nFil, nOrder)
   local pLin := 0, pCol := 0, pPag := 0, pFim := false
   local aBlock := { { || alltrim( nFil) == left( upper( ArqGad->GAD_NOM), len( alltrim( nFil)))}, ;
                     { || nFil == ArqGad->GAD_REG }, ;
                     { || nFil == ArqGad->GAD_SAN }, ;
                     { || nFil == ArqGad->GAD_SEX }, ;
                     { || nFil == ArqGad->GAD_NAS }, ;
                     { || nFil == ArqGad->GAD_VAR }, ;
                     { || alltrim( nFil) == left( upper( ArqGad->GAD_PAI), len( alltrim( nFil)))}, ;
                     { || alltrim( nFil) == left( upper( ArqGad->GAD_MAE), len( alltrim( nFil)))} ;
                   }

   default nOrder  to 1
   default nOption to 1

   select ArqGad
   set order to nOrder
   go top

   open alert "Por favor espere enquanto imprimo... [ESC] para sair..."

   if DeviceInit() <> 0

      do while !eof()
         if eval( aBlock[nOption])

            if pLin == 0
               @ pLin + 1, pCol say chr(14) + padc("CASA DE CARNE WAGNER RAMOS MOLINA", 40)
               @ pLin + 2, pCol say padc( "Relatorio Geral", 40)
               @ pLin + 3, pCol say replicate( "-", 80)
               pLin := 5
            endif

            @ pLin++, pCol say "Controle...: " + _ntocz(ArqGad->GAD_CON, 4)
            @ pLin++, pCol say "Nome.......: " + ArqGad->GAD_NOM
            @ pLin++, pCol say "Registro...: " + ArqGad->GAD_REG + "   " + ;
               "Grau Sangue.: " + ArqGad->GAD_SAN
            @ pLin++, pCol say "Nascimento.: " + dtoc(ArqGad->GAD_NAS) + "   " + ;
               "Sexo...: " + ArqGad->GAD_SEX + "   Variedade.: " + ArqGad->GAD_VAR
            @ pLin++, pCol say "Pai..: " + ArqGad->GAD_PAI + "   Registro..: " + ArqGad->GAD_PRG
            @ pLin++, pCol say "Mae..: " + ArqGad->GAD_MAE + "   Registro..: " + ArqGad->GAD_MRG
            pLin += 2

            pFim := true

            if pLin > 48
               pLin := 52
               @ pLin++, pCol say replicate( "-", 80)
               @ pLin, pCol say "Wagner Ramos Molina."
               @ pLin, pCol say padl( "Pagina...: " + _ntocz( ++pPag, 2), 80)
               pLin := 0
               pFim := false
            endif

         endif
         skip
      enddo

      if pFim
         pLin := 52
         @ pLin++, pCol say replicate( "-", 80)
         @ pLin, pCol say "Wagner Ramos Molina"
         @ pLin, pCol say padl( "Pagina...: " + _ntocz( ++pPag, 3), 80)
         pLin := 0
         pFim := false
      endif

   endif

   eject

   DeviceClose()

   close alert
retry
