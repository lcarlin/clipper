/*
  bop psclass.ch
  header de definiccoes das pseudo-classes
  ms 137 pg 36
*/
#translate CONSTRUCTOR <funcao> ( <exp,...> ) => FUNCTION <funcao> (<exp>)
#translate METHOD <funcao> CLASS <classe> => FUNCTION <funcao> (<classe>)
#translate METHOD <funcao> CLASS <classe> MESSAGES <exp,...> => FUNCTION <funcao> (<classe>,<exp>)
#translate OBJECT LOCAL <objeto,...> => LOCAL <objeto>
#translate OBJECT STATIC <objeto,...> => STATIC <objeto>
#translate OBJECT PUBLIC <objeto,...> => PUBLIC <objeto>
#translate OBJECT PRIVATE <objeto,...> => PRIVATE <objeto>

* EOP