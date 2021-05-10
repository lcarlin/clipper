**************************************************************
* BOP CVCLI.PRG                                              *
* PROGRAMA PARA CONSULTA DE REGISTROS DE FORNECEDORES        *
* AUTORES: EVERTON/LUIZ/WILSON/OSWALDO                       *
* DATA: 27/05/94                                             *
**************************************************************

USE CVCLIENT INDEX CVICLI1
SAVE SCREEN TO TEL_CON
SET FILTER TO CONSOR = "N"
DO WHILE .T.
   MCODCLI = 0
   CCOR(9, 24, 11, 44, "W/BG")
   @10,25 SAY "Codigo....:" GET MCODCLI PICT "99999"
   READ
   IF LASTKEY() = 27
      RESTORE SCREEN FROM TEL_CON
      RETURN
   ENDIF
   IF MCODCLI <> 0
      SEEK MCODCLI
      IF .NOT. FOUND()
         MENSAGEM("Codigo Nao Cadastrado ")
         INKEY(2)
      ENDIF
   ENDIF
   DECLARE CVCAMP[11]
   CVCAMP[1] = 'CODCLI'
   CVCAMP[2] = 'NOMCLI'
   CVCAMP[3] = 'ENDCLI'
   CVCAMP[4] = 'CIDCLI'
   CVCAMP[5] = 'CEPCLI'
   CVCAMP[6] = 'UFCLI'
   CVCAMP[7] = 'TELCLI'
   CVCAMP[8] = 'RGCLI'
   CVCAMP[9] = 'CICCLI'
   CVCAMP[10] = 'NASCLI'
   CVCAMP[11] = 'DATCLI'
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
   CCOR(04,04,17,75,"W+/N")
   DBEDIT(04,04,16,75,CVCAMP,"FUNDBCON",.T.,VCAB,.T.,.T.,.T.)
   EXIT
ENDDO
RESTORE SCREEN FROM TEL_CON



* Eop CVCONCLI.PRG