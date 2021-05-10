/*
 bop CFrelaT.prg
 funcao : impressao das registros dos eleitores
 data 24-01-96
 sistema : controle de eleitores
 autor : luiz antonio carlin
 linguagem clipper 5.2
*/
PARAMETERS cTitu_Rel

SET CONSOLE OFF
SET DEVICE TO PRINTER
nL := 6
nP := 1
set printer on
@00,00 say CHR(18)+CHR(20)
set printer off
@ 00,00 SAY REPLICATE("=",80)
@ 01,00 SAY "Pagina No.: "+str(nP,3,0)
@ 01,65 SAY "Data:"+DTOC(Date())
@ 01,00 SAY "Pagina No.: "+str(nP,3,0)
@ 01,65 SAY "Data:"+DTOC(Date())
cent_imp(2,"- Tec Maq Inform tica LTDA - Fone : (0143) 51-1728 - Piraju - SP -")
cent_imp(3,"Controle de Filiados")
cent_imp(4,if(empty(cTitu_rel),replicate("=",80),cTitu_rel))
SET PRINT ON
??chr(14)+chr(15)
SET PRINT OFF
@ 05,09 SAY "| Nome"+space(36)+" | Titulo N§       | Se‡„o | Data de Filia‡„o | N§ de Inscri‡„o | Partido |"
DO WHILE .NOT. eof()
   @ nL ,09 SAY "| "+NOME+" | "+TITULO+" |  "+SECAO+" |     "+dtoc(FILIACAO)+"     |       "+INSCRICAO+"     |  "+Partido+" |"
   nL++
   SKIP
   IF nL >=  60
      nL = 6
      nP ++
      EJECT
      SET PRINT ON
      ??chr(18)+chr(20)
      SET PRINT OFF
      @ 00,00 SAY REPLICATE("=",80)
      @ 01,00 SAY "Pagina No.: "+str(nP,3,0)
      @ 01,65 SAY "Data:"+DTOC(Date())
      @ 01,00 SAY "Pagina No.: "+str(nP,3,0)
      @ 01,65 SAY "Data:"+DTOC(Date())
      cent_imp(2,"- Tec Maq Inform tica LTDA - Fone : (0143) 51-1728 - Piraju - SP -")
      cent_imp(3,"Controle de Filiados")
      cent_imp(4,if(empty(cTitu_rel),replicate("=",80),cTitu_rel))
      SET PRINT ON
      ??chr(14)+chr(15)
      SET PRINT OFF
      @ 05,09 SAY "| Nome"+space(36)+" | Titulo N§       | Se‡„o | Data de Filia‡„o | N§ de Inscri‡„o | Partido |"
   ENDIF
ENDDO
set printer on
@ prow(),pcol() say cHR(18)+CHR(20)
set printer off
EJECT
SET DEVICE TO SCREEN
SET CONSOLE ON
RETURN

*******************************************************

* EOP TPRELAT.PRG