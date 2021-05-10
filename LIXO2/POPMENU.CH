/* BOP POPMENU.CH

   ARQUIVO HEADER DA CLASSE DE MENUS POP-UP
   micro sistemas n§138 pg 50,51,52
*/
#command SET MENU COLORS TO <cor1>, <cor2>, <cor3>  => _Mcores( <cor1>, <cor2>, <cor3> )
#command SET MENU BORDER TO <par1> => _mBorda ( <par1> )
#command @ <l> , <c> OPTION <par1> WITH <par2> => _mOpcao ({<l>,<c>,<par1>,<par2>})
#command POPUP TO <var> => <var> = _mchoice()
