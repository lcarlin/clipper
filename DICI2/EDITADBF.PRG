set key -3 to nada
variavel=readvar()
linvar=row()
colvar=col()
save screen to telact
CORANT=SETCOLOR()
set color to gb/n,n/r
set deleted off
sombra(11,14,16,25,.t.)
ed=0
clear gets
public ed, mcamp, mmasc, mcab, exp1, PROCURA, MCAMP, MCAB, MMAC, cond, por
ARQUIVO=DBF()
set filter to
@ 11,15 say    " Consulta "
@ 12,15 prompt "Palavras.."
@ 13,15 prompt "Verbos...."
@ 14,15 prompt "Expressoes"
@ 15,15 prompt "Retorna..."
menu to ed
if lastkey()=27
   set deleted on
   set key -3 to banco
   restore screen from telact
   set color to &corant
   read
   return
endif
do case
   case ed=1
        declare mcamp[5]
        mcamp[1] = "pling"
        mcamp[2] = "plpor"
        mcamp[3] = "plingp"
        mcamp[4] = "plporp"
        mcamp[5] = "outros"
        declare mmasc[5]
        mmasc[1] = "@!"
        mmasc[2] = "@!"
        mmasc[3] = "@!"
        mmasc[4] = "@!"
        mmasc[5] = "@!"
        declare mcab[5]
        mcab[1] = "Palavra Em Ingles"
        mcab[2] = "Palavra Em Portugues"
        mcab[3] = "Palavra Ingles e Plural"
        mcab[4] = "Palavra Portugues e Plural"
        mcab[5] = "Outros Significados"
        use palavras index indice1, indice2
        exp1 = "plPOR"
   case ed=2
        declare mcamp[7]
        mcamp[1] = "veii"
        mcamp[2] = "veip"
        mcamp[3] = "veie"
        mcamp[4] = "vepi"
        mcamp[5] = "veit"
        mcamp[6] = "veig"
        mcamp[7] = "tipo"
        declare mmasc[7]
        mmasc[1] = "@!"
        mmasc[2] = "@!"
        mmasc[3] = "@!"
        mmasc[4] = "@!"
        mmasc[5] = "@!"
        mmasc[6] = "@!"
        mmasc[7] = "@!"
        declare mcab[7]
        mcab[1] = "Verbo Em Ingles"
        mcab[2] = "Verbo Em Portugues"
        mcab[3] = "Verbo No Presente"
        mcab[4] = "Verbo No Passado"
        mcab[5] = "Verbo No Participo"
        mcab[6] = "Verbo No Gerundio"
        mcab[7] = "Tipo De Verbo"
        use verbos index indice3,indice4
        exp1 = "veiP"
   case ed=3
        declare mcamp[2]
        mcamp[1] = "exping"
        mcamp[2] = "exppor"
        declare mmasc[2]
        mmasc[1] = "@!"
        mmasc[2] = "@!"
        declare mcab[2]
        mcab[1] = "Expressao Em Ingles"
        mcab[2] = "Expressao Em Portugues"
	sele 1
        use expresso index indice5,indice6
        exp1 = "expPOR"
   case ed=4
        set deleted on
        restore screen from telact
	set key -3 to banco
        read
        return
endcase
cond=.t.
por=.f.
SOMBRA(09,19,21,77,.t.)
STATUS()
sele 1
procura=space(20)
dbedit(10,20,18,76,mcamp,"edita",mmasc,mcab,.t.,.t.,.t.,.t.)
set deleted on
set key -3 to banco
set color to &corant
RESTORE SCREEN FROM TELAct
return
*********************************************
FUNCTION EDITA
PARAMETER statu
TLCA=LASTKEY()
private tlca
@ 10,76 say chr(24)
@ 20,76 say chr(25)
@ 20,75 say chr(26)
@ 20,20 say chr(27)
STATUS()
if statu=4
   if tlca = -5 .or. tlca= -4
      IF TLCA=-4
         por=.f.
         PROCURA=SPACE(20)
         SET CURSOR ON
         @ 20,20 SAY "Procura Em Ingles : " get PROCURA PICT "@!"
         READ
         SET CURSOR OFF
         @ 20,20 SAY "                                                 "
         IF EMPTY(PROCURA)
            RETURN 1
         ENDIF
      ELSEIF TLCA=-5
         por=.t.
         PROCURA = SPACE(20)
         SET CURSOR ON
         @ 20,20 SAY "Procura Em Portugues : " get procura picture "@!"
         read
         set cursor off
         @ 20,20 say "                                            "
         if empty (procura)
            return 1
         endif
      ENDIF
      if por
         set order to 2
         seek  procura
      else
         set order to 1
         seek  procura
      endif
      return 1
   elseif tlca=27
      set deleted on
      RESTORE SCREEN FROM TELAct
      return 0
   ENDIF
ELSEIF statu=3
   STATUS()
   return 1
ELSEIF statu=2
  STATUS()
  return 1
ELSEIF statu=1
  STATUS()
  return 1
ELSEIF statu=0
  STATUS()
  RETURN 1
ENDIF
