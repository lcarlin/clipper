//
//  Sistema de Controle de Gado v1.01á
//  Copyright (c) CAOS TechnoSoft, Inc. 1993-94.
//  All Right Reserved.
//
//  Program.: SCCOPEN.PRG
//  Purpose.: Header Archives.
//
//  Hackers.: Rogen Alexandre da Silva Cardim
//            Stefano Correa Rodrigues Damacena
//
//  Linguage: Clipper 5.2
//            Copyright (c) 1985-1993 Computer Associates International, Inc.
//            All Rights Reserved.
//

#include "caos.ch"
#include "inkey.ch"

static lOpen := false

function SCC_Open()
   local _Lcol := Col(), _Llin := Row()
   local Acol := 5, Alin := 4
   local Acorel := SetColor("N/W*")

   if lOpen
      retry
   endif

   lOpen := true

   Set Key K_F10 To
   Open Window Alin, Acol To Alin + 15, Acol + 70 Blank
   @ Alin, Acol say padc( "Informacoes", 71) color "W+/w"
   @ Alin +  2, Acol + 2 to Alin + 6, Acol + 68
   @ Alin +  3, Acol + 4 say "Sistema Controle de Gado Leiteiro."
   @ Alin +  4, Acol + 4 say "Version 1.0á"
   @ Alin +  5, Acol + 4 say "Copyright (c) 1994. All rights reserved."
   @ Alin +  8, Acol + 2 to Alin + 11, Acol + 68
   @ Alin +  9, Acol + 4 say "Programmer: WS Assessorias S/C. Ltd."
   @ Alin + 10, Acol + 4 say "Company: Wagner Ramos Molina."
   set color to "B/W*"
   @ Alin +  2, Acol + 4 say " Program Information "
   @ Alin +  8, Acol + 4 say " Developer Information "
   _sayout( Alin + 14, Acol + 31, "ßßßßßßßßßß")
   mPrompt( Alin + 13, Acol + 30, "    Ok    ")
   _sayout( Alin + 13, col(), "Ü")
   setcolor( "w+/n")
   _pushmouse()
   saymouse( Alin, Acol, if( settable(), chr( 18)+chr( 19), "[]"), "__keyboard( chr(27))")
   setcolor( "BG+/B")
   mMenuTo( "B/BG*")
   _popmouse()
   Close Window
   Set Key K_F10 To SCC_OPEN
   SetColor( Acorel)
   Locate _Llin, _Lcol
   lOpen := false
retry

function SCC_Arcs
   local aDbf := {}

   close all

   aadd( aDbf, { "GAD_CON", "N",  4, 0, "Codigo de Controle"})
   aadd( aDbf, { "GAD_NOM", "C", 40, 0, "Nome do Animal"})
   aadd( aDbf, { "GAD_REG", "C", 17, 0, "Registro do Animal"})
   aadd( aDbf, { "GAD_SAN", "C",  4, 0, "Grau de Sangue"})
   aadd( aDbf, { "GAD_NAS", "D",  8, 0, "Data de Nascimento"})
   aadd( aDbf, { "GAD_SEX", "C",  1, 0, "Sexo do Animal"})
   aadd( aDbf, { "GAD_VAR", "C",  2, 0, "Variedade"})
   aadd( aDbf, { "GAD_PAI", "C", 40, 0, "Pai do Animal"})
   aadd( aDbf, { "GAD_PRG", "C", 17, 0, "Registro do Pai"})
   aadd( aDbf, { "GAD_MAE", "C", 40, 0, "Mae do Animal"})
   aadd( aDbf, { "GAD_MRG", "C", 17, 0, "Registro da Mae"})
   aadd( aDbf, { "GAD_OBS", "M", 10, 0, "Observacoes sobre o Animal"})
   useDBF( "SCCGAD", aDbf, "ArqGad", true, { "GAD_CON", "GAD_NOM", "GAD_REG"}, ;
      , "Arquivo de Manutencao de Gado")

retry
