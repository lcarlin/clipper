/******************************************
BOP CACPARQ.PRG
DATA    10/11/95
AUTOR   Luiz A. carlin
FUNCAO  COPIA DE DBF E DBT
SISTEMA CONTROLE DE ACOUGUES
LINGUAGEM CLIPPER 5.2
*/

PARAMETERS nTipoC

aMatOpc   := array(3,3)
aMatOpc   := {{10,40,"Unidade A:"},{12,40,"Unidade B:"},{14,40,"Cancelar"}}
aVetMens1 := {"A copia ira apagar os dados do disquete de Destino !!",;
             "   Deseja continuar com esta operacao ?"}
aVetMens2 := {"A Restauracao ira apagar os dados do atuais  ",;
              "e ira utilizar os dados contidos no disquete!",;
             "   Deseja continuar com esta operacao ?"}
nUnidade  := 0
aArq      := {}
nArq      := 0
aArqDb    := directory("*.db?")
nArqDb    := len(aArqDb)
aArqDb2   := {}
nArqDb2   := 0
lErro     := .T.
BEGIN SEQUENCE
      cMens := "aVetMens"+str(nTipoC,1,0)
      IF confirma( &cMens )
         sombra(08,35,18,69)
         @ 08,40 SAY if(nTipoC=1,"Copiar dados:","Restaurar dados")
         @ 09,36 SAY "Selecione a Unidade:"
         nUnidade := botao(aMatOpc)
         IF nUnidade = 0 .OR. nUnidade = 3
            lErro := .F.
            BREAK
         ENDIF
         cDrive := if(nUnidade = 1,"A:","B:")
         ARQTESTE := FCREATE(cDRIVE+"TESTE.000",0)
         IF ARQTESTE = -1
            mensagem("Atencao! Problemas c/ Drive ou disquete !")
            lErro := .f.
            BREAK
         ELSE
            FCLOSE(ARQTESTE)
            DELE FILE cDRIVE+"TESTE.000"
         ENDIF
         IF nTipoC = 1
            aArq := directory(cDrive+"*.*")
            nArq := len(aArq)
            IF nArq > 0
               @ 16,36 SAY "Aguarde! apagando os arquivos"
               @ 17,36 SAY "da unidade "+ cdrive
               FOR H := 1 TO nArq
                   MASC := cDRIVE+aArq[h][1]
                   DELE FILE &MASC
               NEXT
            ENDIF
         ENDIF
         @ 16,36 SAY "Aguarde ! "+if(nTipoC=1,"Copiando ","Restaurando ")+"os arquivos"
         @ 17,36 SAY if(nTipoC=1,"para a ","da ")+"Unidade "+cDrive
         IF nTipoC = 2
            aArqDb2 := directory(cDrive+"*.db?")
            nArqDb2 := len(aArqDb2)
            IF nArqDb2 = 0
               mensagem("Nao ha arquivos de dados na Unidade "+cDrive+" !")
               lErro := .F.
               BREAK
            ENDIF
         ENDIF
         FOR H := 1 TO if(nTipoC=1,nArqdb,nArqDb2)
             MASC   := if(nTipoC=1,cDRIVE+aArqdb[h][1],aArqdb[h][1])              
             cMasc2 := if(nTipoC=1,aArqdb[h][1],cDRIVE+aArqdb[h][1])
             COPY FILE &cMasc2 TO &MASC
         NEXT
         mensagem("Arquivos "+if(nTipoC=1,"Copiados !","Restaurados"))
         BREAK
     ELSE
         lErro := .F.
         BREAK
     ENDIF
END SEQUENCE
IF nTipoC = 2 .AND. lErro
   mensagem({"Voce devera reinicializar o programa ",;
             "para que as alteracoes tenham efeito"})
  SAI()
ENDIF
RELEASE all
RETURN

* eop cacparq.prg