/*
bop carjes.prg
programa  carjes.prg
data      07/07/95
autor     Luiz Antonio CArlin
funcao    Reajuste de precos dos materiais
Sistema   Controle de estoque
LInguagem Clipper 5.01
*/

LOCAL aVet_camp := {"marcado","codigo","produto","valunit",}
LOCAL aVet_masc := {"!","@!","@!","999,999.99"}
LOCAL aVet_cab  := {"Sel.","Codigo","Item","Valor"}


USE cabest INDEX caiest

sombra(04,01,22,77)
@ 04,29 SAY "Reajuste de Precos"
@ 21,04 SAY "<F2>-Marcar/Desmarca; <F3>-Reajusta os precos"
dbedit(05,02,20,76,aVet_camp,"reajuste",aVet_masc,aVet_cab,"�","�")

CLOSE ALL
RELEASE ALL
RETURN

***********************************************************
FUNCTION reajuste (modo_r, Indice_r)
_cor_rj := setcolor()

IF MODO_r = 1  .or. modo_r = 2 .or. modo_r = 0
   return 1
ELSEIF modo_r = 3
   mensagem ("Nao ha produtos cadastrados !!!")
   RETURN 0
ELSE
   IF lastkey() = -1
      IF Marcado = "S"
         REPLACE Marcado WITH " "
      ELSE
         REPLACE Marcado WITH "S"
      ENDIF
      return 1
   ELSEIF lastkey() = -2
      SAVE SCREEN TO tTela_rj
      aMat_opc1 := array(3,3)
      aMat_opc2 := array(2,3)
      nPorcen   := 0
      aMat_opc1 := {{10,10,"Reajustar TODOS os Itens"},{12,10,"Reajustar Itens SELECIONADOS"},{14,10,"Cancelar"}}
      aMat_opc2 := {{10,40,"Aumentar Preco"},{12,40,"Diminuir Preco"}}
      opcao1 := opcao2 := opcao3 := 0
      sombra(08,07,17,60)
      @ 08,23 SAY "Reajuste:"
      @ 09,39 to 15,39
      @ 16,10 SAY "Em :        %"
      n:=botao(aMat_opc2,.f.)
      opcao1 := botao(aMat_opc1)
      IF opcao1 = 3 .or. opcao1 = 0
         RESTORE SCREEN FROM tTela_rj
	 SET COLOR TO &_COR_RJ
         return 1
      ENDIF
      opcao2 := botao(aMat_opc2)
      _cursor := Setcursor(1)
      @ 16,15 GET nPorcen PICT "999.99" valid(nPorcen<=100.00)
      read
      setcursor(_cursor)
      RESTORE SCREEN FROM tTela_rj
      SET COLOR TO &_COR_RJ
      IF LASTKEY() = 27 .OR. empty(nPorcen)
         RETURN 1
      ENDIF
      IF OPCAO1 = 1
         GO TOP
         DO WHILE .NOT. eof()
            IF opcao2 = 1
               nValorc  := Valunit
               nValorcr := ((nValorc*nPorcen)/100)+nValorc
	    ELSE
	       nValorc  := Valunit
               nValorcr := nValorc-((nValorc*nPorcen)/100)
	    ENDIF
	    REPLACE Valunit WITH nValorcr
            SKIP
         ENDDO
      ELSE
         SET FILTER TO Marcado = "S"
	 GO TOP
	 IF eof()
	    mensagem ("Nao ha registros Marcados !!!")
	    SET FILTER TO
	    GO TOP
	    RESTORE SCREEN FROM tTela_rj
	    RETURN 1
	 ENDIF
         DO WHILE .NOT. eof()
            IF opcao2 = 1
               nValorc  := Valunit
               nValorcr := ((nValorc*nPorcen)/100)+nValorc
            ELSE
	       nValorc  := Valunit
               nValorcr := nValorc-((nValorc*nPorcen)/100)
	    ENDIF
            REPLACE Valunit WITH nValorcr
            REPLACE Marcado WITH " "
            SKIP
         ENDDO
	 SET FILTER TO
	 GO TOP
      ENDIF
      SET COLOR TO &_COR_RJ
      RESTORE SCREEN FROM tTela_rj
      GO TOP
      RETURN 2
   ELSEIF lastkey() = 27
      RETURN 0
   ELSE
      RETURN 1
   ENDIF
ENDIF

* eop carjes.prg