**************************************************************
* BOP CVCONCLI.PRG                                           *
* PROGRAMA PARA CONSULTA DE REGISTROS DE CLIENTES            *
* AUTORES: EVERTON/LUIZ/WILSON/OSWALDO                       *
* DATA: 20/05/94                                             *
**************************************************************


USE CVBCLIEN INDEX CVICLI1
SAVE SCREEN TO TEL_CON
MCODCLI = 0
opc1=menu_con(05,13)
IF opc1 = 0
   RESTORE SCREEN FROM TEL_CON
   RETURN
ENDIF
if opc1=2
   BORDA(05, 12, 07,30, "W/BG")
   @ 06,13 SAY "Codigo....:" GET MCODCLI PICT "99999"
   READ
   IF LASTKEY() = 27
      RESTORE SCREEN FROM TEL_CON
      RETURN
   ENDIF
   IF .not. empty(MCODCLI)
      SEEK MCODCLI
      IF .NOT. FOUND()
         MENSAGEM("Codigo Nao Cadastrado ")
         INKEY(2)
         RETURN
      ENDIF
   ENDIF
endif
DECLARE VCAB[12]
VCAB[1]  = "Codigo"
VCAB[2]  = "Nome"
VCAB[3]  = "Endereco"
VCAB[4]  = "CEP"
VCAB[5]  = "Estado"
VCAB[6]  = "Telefone"
VCAB[7]  = "RG"
VCAB[8]  = "CIC"
VCAB[9]  = "Nascimento"
VCAB[10] = "Cadastramento"
VCAB[11] = "Cidade"
VCAB[12] = "Consorcio"
BORDA(04,04,19,75,"W+/N")
DBEDIT(05,05,18,74,.T.,"FUNDBCON",.T.,VCAB,.T.,.T.,.T.)
RESTORE SCREEN FROM TEL_CON
         
* Eop CVCONCLI.PRG
