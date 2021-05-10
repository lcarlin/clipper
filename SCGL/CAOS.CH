/***
*
*  Caos.ch
*
*  CAOS Clipper standard language definitions.
*
*  Copyright (c) 1990-1993, CAOS TechnoSoft, Inc.
*  All rights reserved.
*
*  IMPORTANT:  Functions beginning with an underscore
*  character are reserved, version-dependent functions.
*  These functions should not be called directly.
*
*/


// Single-line box
#define B_SINGLE                If( !SetTable(), ;
                                   ( CHR(218) + CHR(196) + CHR(191) + CHR(179) + CHR(217) + CHR(196) + CHR(192) + CHR(179) ), ;
                                   ( CHR(010) + CHR(011) + CHR(012) + CHR(013) + CHR(014) + CHR(015) + CHR(016) + CHR(017) ))
#define B_DOUBLE                If( !SetTable(), ;
                                   ( CHR(201) + CHR(205) + CHR(187) + CHR(186) + CHR(188) + CHR(205) + CHR(200) + CHR(186) ), ;
                                   ( CHR(010) + CHR(011) + CHR(012) + CHR(013) + CHR(014) + CHR(015) + CHR(016) + CHR(017) ))
#define B_SINGLE_DOUBLE         If( !SetTable(), ;
                                  ( CHR(214) + CHR(196) + CHR(183) + CHR(186) + CHR(189) + CHR(196) + CHR(211) + CHR(186) ), ;
                                  ( CHR(010) + CHR(011) + CHR(012) + CHR(013) + CHR(014) + CHR(015) + CHR(016) + CHR(017) ))
#define B_DOUBLE_SINGLE         If( !SetTable(), ;
                                  ( CHR(213) + CHR(205) + CHR(184) + CHR(179) + CHR(190) + CHR(205) + CHR(212) + CHR(179) ), ;
                                  ( CHR(010) + CHR(011) + CHR(012) + CHR(013) + CHR(014) + CHR(015) + CHR(016) + CHR(017) ))

#translate TRUE               => .T.
#translate FALSE              => .F.
#translate MIDCHAR( <var>, <pos>)  => SUBSTR( <var>, <pos>, 1)
#translate ASHRINK( <arr>)         => ASIZE( <arr>, Len(<arr>) - 1)


#command BOXSHADOW <top>, <left> [TO] <bottom>, <right> [ <boxstring> ] [COLOR <color>] =>;
         Mould( <top>, <left>, <bottom>, <right>, Replicate( <boxstring>, 9), <color>)

#command BOXSHADOW <top>, <left> [TO] <bottom>, <right> [COLOR <color>] DOUBLE =>;
         Mould( <top>, <left>, <bottom>, <right>, "D", <color>)

#command BOXSHADOW <top>, <left> [TO] <bottom>, <right> [COLOR <color>] SINGLE =>;
         Mould( <top>, <left>, <bottom>, <right>, "S", <color>)

#command FILLBOX <top>, <left> [TO] <bottom>, <right> <boxstring> [COLOR <color>] =>;
         @ <top>, <left>, <bottom>, <right> BOX Replicate( <boxstring>, 9) [COLOR <color>]


#command WINDOW CENTER <text> [INTO [<row>] [, <left> [, <right>]]] [COLOR <color>]=> ;
         Center( <text>, <row>, <left>, <right>, <color>)

#command @ <top>, <left> ATTRIB TO <bottom>, <right> <tip> => ;
         Vidatb( <top>, <left>, <bottom>, <right>, <tip>)

#command OPEN WINDOW <top>, <left> TO <bottom>, <right> [COLOR <color>] => ;
         OpenWindow( <top>, <left>, <bottom>, <right>, "S", 1, <color>)

#command OPEN WINDOW <top>, <left> TO <bottom>, <right> [COLOR <color>] EXPLODE => ;
         OpenWindow( <top>, <left>, <bottom>, <right>, "S", 2, <color>)

#command OPEN WINDOW <top>, <left> TO <bottom>, <right> [COLOR <color>] BLANK=> ;
         OpenWindow( <top>, <left>, <bottom>, <right>, "          ", 1, <color>)

#command OPEN WINDOW <top>, <left> TO <bottom>, <right> [COLOR <color>] EXPLODE BLANK=> ;
         OpenWindow( <top>, <left>, <bottom>, <right>, "          ", 2, <color>)

#command CLOSE WINDOW => CloseWindow()

#command LOCATE <row>, <col> => Setpos( <row>, <col>)

#command PUSH GETS => _Push_Gets()

#command POP GETS =>  _Pop_Gets()

#command PUSH COLOR <var> => _Push_Color( <var>)

#command POP COLOR => _Pop_Color()

#command OPEN MENU <var> INTO <row>, <col> WITH <list> => ;
         <var> := _ReadMenu( <row>, <col>, <list>)

#command OPEN MENU <var> INTO <row>, <col> WITH <list> EXPLODE => ;
         <var> := _ReadMenu( <row>, <col>, <list>, TRUE)

#command CLOSE MENU = > CLOSE WINDOW

// #command DEFAULT <var> TO <valor> => <var> := iif( <var> = NIL, <valor>, <var>)

#command OPEN ALERT <message> [INTO <row> [, <col>]] [COLOR <color>] => ;
         _OpenMessage( <message>, <row>, <col>, <color>)

#command OPEN ALERT <message> [INTO <row> [, <col>]] [COLOR <color>] BLINK => ;
         _OpenMessage( <message>, <row>, <col>, <color>, TRUE)

#command OPEN ALERT <message> [INTO <row> [, <col>]] [COLOR <color>] EXPLODE=> ;
         _OpenMessage( <message>, <row>, <col>, <color>, ,TRUE)

#command OPEN ALERT <message> [INTO <row> [, <col>]] [COLOR <color>] BLINK => ;
         _OpenMessage( <message>, <row>, <col>, <color>, TRUE, TRUE)

#command CLOSE ALERT => CLOSE WINDOW

#command AADD MENU <var> WITH <menu> [, <func>] => ;
         <var> := _AAddMenu( <var>, <menu>, <func>)

#command AADD MENU <var> WITH <menu> END => ;
         <var> := _AAddMenu( <var>, <menu>, "~")

#command AADD MENU <var> [WITH] LINE => ;
         <var> := _AAddMenu( <var>, "", "-")

#command READ MENU <list> [INTO <row> [, <col>]] [TITLE <title>] [COLOR <color> [, <first>[, <cursor>]]]=> ;
         _PopMenu( <row>, <col>, <list>, .F., <color>, <first>, <cursor>,,, <title>)

#command READ MENU <list> [INTO <row> [, <col>]] [TITLE <title>] [COLOR <color> [, <first>[, <cursor>]]] EXPLODE=> ;
         _PopMenu( <row>, <col>, <list>, .T., <color>, <first>, <cursor>,,, <title>)

#command READ MENU <list> [INTO <row> [, <col>]] [TITLE <title>] [COLOR <color> [, <first>[, <cursor>]]] END => ;
         _PopMenu( <row>, <col>, <list>, .F., <color>, <first>, <cursor>,,, <title>, .T.)

#command READ MENU <list> [INTO <row> [, <col>]] [TITLE <title>] [COLOR <color> [, <first>[, <cursor>]]] EXPLODE END => ;
         _PopMenu( <row>, <col>, <list>, .T., <color>, <first>, <cursor>,,, <title>, .T.)

#xcommand SET DATE [TO] BRAZIL           => _DFSET( "dd/mm/yyyy", "dd/mm/yy" )

#xcommand RETRY      =>     Return .T.
#xcommand RESUME     =>     Return .F.

#xtranslate ISNIL( <v1> )         => ( <v1> == NIL )
#xtranslate ISARRAY( <v1> )       => ( valtype( <v1> ) == "A" )
#xtranslate ISBLOCK( <v1> )       => ( valtype( <v1> ) == "B" )
#xtranslate ISCHARACTER( <v1> )   => ( valtype( <v1> ) == "C" )
#xtranslate ISDATE( <v1> )        => ( valtype( <v1> ) == "D" )
#xtranslate ISLOGICAL( <v1> )     => ( valtype( <v1> ) == "L" )
#xtranslate ISMEMO( <v1> )        => ( valtype( <v1> ) == "M" )
#xtranslate ISNUMBER( <v1> )      => ( valtype( <v1> ) == "N" )
#xtranslate ISOBJECT( <v1> )      => ( valtype( <v1> ) == "O" )

#xcommand DEFAULT <v1> TO <x1> [, <vn> TO <xn> ]                        ;
          =>                                                            ;
          IF <v1> == NIL ; <v1> := <x1> ; END                           ;
          [; IF <vn> == NIL ; <vn> := <xn> ; END ]

#xcommand UPDATE <v1> IF <exp> TO <v2> ;
          =>                           ;
          IF <exp> ; <v1> := <v2> ; END

#command @ <row>, <col> GET <var>                                        ;
                        [PICTURE <pic>]                                  ;
                        [VALID <valid>]                                  ;
                        [WHEN <when>]                                    ;
                        [SEND <msg>]                                     ;
                        [KEYSET <nKey> TO <kCodeBlock>]                   ;
                        [READER <rCodeBlock>]                             ;
                                                                         ;
      => SetPos( <row>, <col> )                                          ;
       ; AAdd(                                                           ;
           GetList,                                                      ;
           _GET_( <var>, <(var)>, <pic>, <{valid}>, <{when}> ):display() ;
             )                                                           ;
      [; ATail(GetList):<msg>]                                           ;
      [; ATail(GetList):cargo := { |nKey| if( nKey == <nKey>,            ;
         (<kCodeBlock>, .t.), .f.)}]                                      ;
      [; ATail(GetList):reader := <rCodeBlock>]



#command @ <row>, <col> SAY <sayxpr>                                    ;
                        [<sayClauses,...>]                              ;
                        GET <var>                                       ;
                        [<getClauses,...>]                              ;
                                                                        ;
      => @ <row>, <col> SAY <sayxpr> [<sayClauses>]                     ;
       ; @ Row(), Col()+1 GET <var> [<getClauses>]



// @..GET..RANGE (preprocessed to @..GET..VALID)

#command @ <row>, <col> GET <var>                                       ;
                        [<clauses,...>]                                 ;
                        RANGE <lo>, <hi>                                ;
                        [<moreClauses,...>]                             ;
                                                                        ;
      => @ <row>, <col> GET <var>                                       ;
                        [<clauses>]                                     ;
                        VALID {|_1| RangeCheck(_1,, <lo>, <hi>)}        ;
                        [<moreClauses>]


// @..GET COLOR

#command @ <row>, <col> GET <var>                                       ;
                        [<clauses,...>]                                 ;
                        COLOR <color>                                   ;
                        [<moreClauses,...>]                             ;
                                                                        ;
      => @ <row>, <col> GET <var>                                       ;
                        [<clauses>]                                     ;
                        SEND colorDisp(<color>)                         ;
                        [<moreClauses>]
