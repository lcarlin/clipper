**************************************************************
* BOP CVCONFOR.PRG                                           *
* PROGRAMA PARA CONSULTA DE REGISTROS DE CLIENTES            *
* AUTORES: EVERTON/LUIZ/WILSON/OSWALDO                       *
* DATA: 27/05/94                                             *
**************************************************************
USE CVBFORNE INDEX CVIFOR1
SAVE SCREEN TO TEL_CON
MCODFOR=0
opc3=menu_con(05, 42)
IF opc3= 0
   RESTORE SCREEN FROM TEL_CON
   RETURN
ENDIF
if opc3=2
   BORDA(04, 41, 06, 61, "W/BG")
   @05,42 SAY "Codigo....:" GET MCODFOR PICT "99999"
   READ
   IF LASTKEY() = 27
      RESTORE SCREEN FROM TEL_CON
      RETURN
   ENDIF
   IF ! empty(MCODFOR)
      SEEK MCODFOR
      IF .NOT. FOUND()
         MENSAGEM("Codigo Nao Cadastrado ")
         INKEY(2)
         RETURN
      ENDIF
   ENDIF
ENDIF
DECLARE VCAB1[07]
VCAB1[1]  =  "Codigo"
VCAB1[2]  =  "Nome"
VCAB1[3]  =  "Codigo do Item"
VCAB1[4]  =  "Descri‡„o"
VCAB1[5]  =  "F brica"
VCAB1[6]  =  "C.G.C."
VCAB1[7]  =  "Observa‡”es"
BORDA(04,04,19,76,"W+/N")
DBEDIT(05,05,18,75,.T.,"FUNDBCON",.T.,VCAB1,.T.,.T.,.T.)
RESTORE SCREEN FROM TEL_CON

* EOP CVCONFOR.PRG