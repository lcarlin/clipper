/*
 bop  winclass.ch
 definicao da classe window
 micro sistemas n§ 137 pg 54
*/

#translate DEFINE CLASS <oClass> USING <exp,...> => FUNCTION <oClass> ( <exp> )
#translate DEFINE METHOD <cMethod> [MESSAGES <exp,...>] => FUNCTION <cMethod> ( <exp> )
#translate OBJECT LOCAL <Object,...> => LOCAL <Object>
#translate OBJECT STATIC <Object,...> => STATIC <Object>

* DEFINICOES PARTICULARES.
* #define DAS VARIAVEIS

#define _BORDER     1
#define _COLOR      2
#define _TITLE      3
#define _COLORTITLE 4
#define _SCREEN     5
#define _TOP        6
#define _LEFT       7
#define _BOTTOM     8
#define _RIGHT      9

#translate .<object>:border    =>  <object>\[_BORDER]
#translate .<object>:color     =>  <object>\[_COLOR]
#translate .<object>:title     =>  <object>\[_TITLE]
#translate .<object>:coltitle  =>  <object>\[_COLORTITLE]
#translate .<object>:screen    =>  <object>\[_SCREEN]
#translate .<object>:top       =>  <object>\[_TOP]
#translate .<object>:left      =>  <object>\[_LEFT]
#translate .<object>:bottom    =>  <object>\[_BOTTOM]
#translate .<object>:right     =>  <object>\[_RIGHT]

* DEFINE OS METODOS DA CLASSE

#translate .<Object>:OpenWin()  => OpenWin ( @<Object> )
#translate .<Object>:CloseWin()  => CloseWin ( @<Object> )

* eop winclass.ch