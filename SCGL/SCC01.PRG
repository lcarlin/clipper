//
//  Sistema de Controle de Gado v1.0á
//  Copyright (c) CAOS TechnoSoft, Inc. 1993.
//  All Right Reserved.
//
//  Program.: SCC01.PRG
//  Purpose.: Manutencao de Dados.
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

function Manager( mArq)
   local aMen:={}

   aadd menu aMen With " 1) Cadastrar ", "ManagerControl(1,"+Str(mArq)+")"
   aadd menu aMen With " 2) Pesquisar ", "ManagerSearch(2,"+Str(mArq)+")"
   aadd menu aMen With " 3)   Alterar ", "ManagerSearch(3,"+Str(mArq)+")"
   aadd menu aMen With " 4)   Deletar ", "ManagerSearch(4,"+Str(mArq)+")"
   aadd menu aMen with line
   aadd menu aMen With " 5)  Retornar " End
   Read Menu aMen Into Row()+1,Col()-10 title "Opcao" Explode
Retry

Function ManagerSearch( _Tip, nOpc)
   local aMen:={}

   If nOpc==1
      aadd menu aMen With " 1)  pelo Controle ", "ManagerControl("+Str(_Tip)+","+Str(nOpc)+",1)"
      aadd menu aMen With " 2)      pelo Nome ", "ManagerControl("+Str(_Tip)+","+Str(nOpc)+",2,,2,1,,3)"
      aadd menu aMen With " 3)  pelo Registro ", "ManagerControl("+Str(_Tip)+","+Str(nOpc)+",3,,3,2,,3)"
      aadd menu aMen With " 4) por Nascimento ", "ManagerControl("+Str(_Tip)+","+Str(nOpc)+",05,,05,3,,3)"
      aadd menu aMen With " 5)      pelo Sexo ", "ManagerControl("+Str(_Tip)+","+Str(nOpc)+",06,,06,4,,3)"
      aadd menu aMen with line
      aadd menu aMen With " 6)       Retornar " end
   Endif
   Read Menu aMen Into Row()+1, Col()-10 title "Gado" Explode
Retry

function ManagerControl( nType, _Var, _Des, cValid, _cGet, _cFil, _nCod, nOrder)
   local _Con := true, _acCol,_acHea,_acSay,_ngRec
   local fArq := { "ArqGad" }
   local nCol := 03, nLin:=03, nRecord:=0
   local aField := {}
   local aOper := { "Cadastro", "Pesquisa", "Alteracao", "Delecao"}

   local aFilter := { { {|| Upper(Left(ArqGad->Gad_Nom, Len(Alltrim(aField[_cGet])))) == Upper(Alltrim(aField[_cGet])) }, ;
                        {|| Upper(Left(ArqGad->Gad_Reg, Len(Alltrim(aField[_cGet])))) == Upper(Alltrim(aField[_cGet])) }, ;
                        {|| If(Empty(aField[_cGet]), .t.,(ArqGad->Gad_Nas == aField[_cGet]) ) },;
                        {|| If(Empty(aField[_cGet]),.T.,(ArqGad->Gad_Sex==aField[_cGet]) ) } } }

   local aHeader := { { {"gad_Con","Gad_Nom","Gad_Reg","Gad_San","Gad_Nas","Gad_Sex","Gad_Var"},;
                        {"Controle","Nome","Registro","Grau Sangue","Nascimento","Sexo", "Variedade" },;
                        {"9999","","","","","","" } } }

   Default _Des   to  0
   Default cValid to  0
   Default _cGet  to  0
   Default _cfil  to  0
   Default _nCod  to  0
   default nOrder to  0

   Do While _Con
      aField := ManagerGet(_Var,0)
      If If( ValType( _nCod) == "C", Val(_nCod) <> 0, _NCod <> 0)
         aField[1] := _nCod
      Endif
      ManagerScreen( aField, _Des, nType == 1, nType == 1, _Var, 1, cValid)
      If _Des >=2 .and. ntype >= 2
         Set Filter to Eval( aFilter[_Var][_CFil])
         ( dbsetorder( nOrder), dbgotop())
         If !Eof()
            Open Window 10,05 to 17, 70 Color "W+/B"
            _acCol := aHeader[_Var][1]
            _acHea := aHeader[_Var][2]
            _acSay := aHeader[_Var][3]
            Dbedit( 11, 06, 16, 69, _acCol,, _acSay, _acHea)
            Close Window
            _ngRec := Recno()
         Endif
         Set Filter to
      Endif
      If (nType >= 2) .and. (LastKey() <> K_ESC)
         Close Window
         aField := ManagerGet(_Var,2)
         nRecord := Recno()
         ManagerScreen( aField, 1, nType==3, .T., _Var, 2)
      Endif
      If nType <> 2 .and. ( nType == 4 .or. Lastkey()<>K_ESC ) .and. Input_Sn("Confirma "+aOper[nType]+" (S/N)?")=="S" .and. Lastkey()<>K_ESC
         If nType==1
            New_Rec( { || ManagerWrite(aField) }, fArq[_Var] )
         Elseif nType==3
            Write_Rec( { || ManagerWrite(aField)}, fArq[_Var], nRecord)
         Elseif nType == 4
            Del_Rec( fArq[_Var], nRecord)
         Endif
      Endif
      If cValid == 0
         _Con:= Input_Sn( "Deseja continuar " + aOper[nType] + " (S/N)?") == "S" ;
                .and. lastkey() <> K_ESC
      Else
         _Con:= false
      Endif
      Close Window
      set relation to
   Enddo
Retry

function ManagerScreen( aField, nGet, lRead, lPes, nOpc, nType, cValid)
   local GetList := {}

   if nOpc==1
      TelaGado( @aField, nType, lPes, @GetList)
   endif

   if lRead
      ReadModal( GetList)
   elseif nGet == 0
      GetList := {}
   else
      _One_Get( nGet, @GetList)
   endif

   set relation to
retry

function CodeVerify( _Codigo, lPes, nOrder)
   local Flag:= true

   Default nOrder to 1
   DbSetOrder( nOrder)
   If Dbseek( _Codigo)
      If lPes
         Message( "Codigo ja cadastrado. Tecle [Enter] para sair")
         Resume
      Endif
   Else
      If !lPes
         Message("Codigo nao cadastrado. Tecle [Enter] para sair.")
         Resume
      Endif
   Endif
retry

Function ManagerWrite( aField)
   Local nInd

   For nInd:=1 to Fcount()
       FieldPut(nInd, aField[nInd] )
   Next
Retry

Function ManagerGet( nOpc, nType)
   local nInd, _Arry:={}, _Temp
   local fArq := { "ArqGad" }

   _Temp := fArq[nOpc]
   Select &_Temp
   If nType==0
      DbGoto(0)
   Endif
   for nInd:=1 to fCount()
      aadd( _Arry, Fieldget( nInd) )
   Next
return _Arry

function TelaGado( aField, nType, lPes, GetList)
   local nLin := 4, nCol := 5, aCor

   open window nLin, nCol to nLin + 16, nCol + 70 color "W+/B"
   @ nLin, nCol say padc( "Manutencao de Gado", 71) color "B/W*"

   @ nLin +  2, nCol  + 2 say "Controle.:" get aField[01] pict "9999" ;
      valid CodeVerify( aField[01], lPes) ;
      when nType == 1
   @ nLin +  4, nCol  + 2 say "Nome.....:" get aField[02]
   @ nLin +  5, nCol  + 2 say "Registro.:" get aField[03] pict "!!/!!-!!!!!!!!!!!"
   @ nLin +  5, Col() + 2 say "Grau Sangue.:" get aField[04] pict "!!!!"
   @ nLin +  6, nCol  + 2 say "Data Nasc:" get aField[05] pict "99/99/99"
   @ nLin +  6, col() + 2 say "Sexo.:"     get aField[06] pict "!" valid ( aField[06] $ "MF")
   @ nLin +  6, col() + 2 say "Variedade:" get aField[07] pict "!!"
   @ nLin +  8, nCol  + 2 say "Pai:" get aField[08]
   @ nLin +  8, col() + 1 say "Rg:" get aField[09] pict "!!/!!-!!!!!!!!!!!"
   @ nLin +  9, nCol  + 2 say "Mae:" get aField[10]
   @ nLin +  9, col() + 1 say "Rg:" get aField[11] pict "!!/!!-!!!!!!!!!!!"
   @ nLin + 11, nCol  + 2 say "Obs......:" get aField[12] picture "@S54" ;
      send reader := { || ( (aCor := setcolor( "N/W")), (aField[12] := memoedit(aField[12], ;
         nLin + 11, nCol + 13, nLin + 15, nCol + 68)), setcolor( aCor))}
   __keyboard( chr(27))
   ( (aCor := setcolor( "N/W")), (aField[12] := memoedit(aField[12], ;
      nLin + 11, nCol + 13, nLin + 15, nCol + 68)), setcolor( aCor))

retry
