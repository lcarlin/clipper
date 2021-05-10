**************************************************************
* BOP CVCONFUN.PRG                                           *
* PROGRAMA PARA CONSULTA DE REGISTROS DE CLIENTES            *
* AUTORES: EVERTON/LUIZ                                      *
* DATA: 20/05/94                                             *
**************************************************************
USE CVBFUNC INDEX CVIFUN1
SAVE SCREEN TO TEL_CON
MCODFUN = 0
opc1=menu_con(05,23)
IF opc1 = 0
   RESTORE SCREEN FROM TEL_CON
   RETURN
ENDIF
if opc1=2
   BORDA(05, 12, 07,30, "W/BG")
   @06,13 SAY "Codigo....:" GET MCODFUN PICT "99999"
   READ
   IF LASTKEY() = 27
      RESTORE SCREEN FROM TEL_CON
      RETURN
   ENDIF
   IF .not. empty(MCODFUN)
      SEEK MCODFUN
      IF .NOT. FOUND()
         MENSAGEM("Codigo Nao Cadastrado ")
         INKEY(2)
         RETURN
      ENDIF
   ENDIF
endif
DECLARE VCAB[8]
VCAB[1]  = "Codigo"
VCAB[2]  = "Nome"
VCAB[3]  = "Endereco"
VCAB[4]  = "Cargo"
VCAB[5]  = "Salario"
VCAB[6]  = "Cidade"
VCAB[7]  = "Comissao"
VCAB[8]  = "CEP"
BORDA(04,04,19,75,"W+/N")
DBEDIT(05,05,18,74,.T.,"FUNDBCON",.T.,VCAB,.T.,.T.,.T.)
RESTORE SCREEN FROM TEL_CON

* Eop CVCONFUN.PRG
