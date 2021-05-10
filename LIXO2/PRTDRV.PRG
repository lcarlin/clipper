/*
 funcao que permite alterar os caracteres de impressao
  livro clipper5.2 pg 139
*/
FUNCTION PrtDrv ()
#define cEsc    chr(27)
// Codiogs de HP laser
aHp := {{"eReset"     , cEsc+"E"        },;
        {"ePortMode"  , cEsc+"&l0O"     },;
        {"eLandMode"  , cEsc+"&l1O"     },;
        {"eStdPItch"  , cEsc+"(s10H"    },;
        {"eCompPich"  , cEsc+"(s16.66H" },;
        {"eBold"      , cEsc+"(s3B"     },;
        {"eUnBold"    , cEsc+"(s0B"     },;
        {"eItal"      , cEsc+"(s1S"     },;
        {"eUnItal"    , cEsc+"(s0S"     },;
        {"eScore"     , cEsc+"&dD"      },;
        {"eUnScore"   , cEsc+"&d@"      },;
        {"eLegal"     , cEsc+"&l84P"    },;
        {"eStdPage"   , cEsc+"&l66P"    }}

// codigos da epson fx
aFx := {{"eReset"     , cEsc+"E"        },;
        {"ePortMode"  , cEsc+"&l0O"     },;
        {"eLandMode"  , cEsc+"&l1O"     },;
        {"eStdPItch"  , cEsc+"(s10H"    },;
        {"eCompPich"  , cEsc+"(s16.66H" },;
        {"eBold"      , cEsc+"(s3B"     },;
        {"eUnBold"    , cEsc+"(s0B"     },;
        {"eItal"      , cEsc+"(s1S"     },;
        {"eUnItal"    , cEsc+"(s0S"     },;
        {"eScore"     , cEsc+"&dD"      },;
        {"eUnScore"   , cEsc+"&d@"      },;
        {"eLegal"     , cEsc+"&l84P"    },;
        {"eStdPage"   , cEsc+"&l66P"    }}
