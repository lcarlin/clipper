/*
BOP BK1.PRG
DATA  15/06//95
*/

SET CURSOR OFF
SET INTENS OFF
SET CENTURY OFF

ARQUIVOS1 := ADIR("*.DBF")
ARQUIVOS2 := aDIR("*.DBT")

DECLARE ARR_DIR[ARQUIVOS1]
DECLARE ARR_DR1[ARQUIVOS2]
DECLARE ARR_TAM[ARQUIVOS1]
DECLARE ARR_TM1[ARQUIVOS2]

ADIR("*.DBF",ARR_DIR,ARR_TAM)
ADIR("*.DBT",ARR_DR1,ARR_TM1)

IF BK_MEM1 = 0
   DRIVE  := "A:"
   DRIVE1 := "A"
ELSE
   DRIVE  := "B:"
   DRIVE1 := "B"
ENDIF

DAT_BK := dtoc(DATE())
CABDADOS := SUBSTR(DAT_BK,1,2)+SUBSTR(DAT_BK,4,2)+SUBSTR(DAT_BK,7,2)
INICIO := .T.
FLAG1  := .F.
TIME_BK:= TIME()
CABDADOS+=SUBSTR(TIME_BK,1,2)+SUBSTR(TIME_BK,4,2)+SUBSTR(TIME_BK,7,2)

DO BK_DADOS

SET INTENS ON
SET CURSOR ON
CLOSE ALL

*************************
PROCEDURE BK_DADOS
/*
ROTINA PRINCIPAL DO BACKUP (do disco rigido para o disquete)
*/

STORE .F. TO CANCELA, REPETE, ERRO, FIM, ARQ_DBT, FIM_DBT, LAST_DISK, FLAG
STORE 0 TO GRAVADO, DISCO, TAM, GRV_ARQ

DISQUETE := .F.
NUM_ARQ := ADIR('*.DBF')
NUM_ARQ1 := ADIR('*.DBT')
TOT_ARQ := NUM_ARQ+NUM_ARQ1
STORE 1 TO COPIA, IND_ARQ

IF NUM_ARQ = 0
   MENS("Nao ha arquivos .DBF para fazer backup!")
   RETURN
ENDIF

DO GET_DISK
IF erro .OR. CANCELA
   MENS("Backup cancelado! Tecle algo..")
   return
ENDIF

@ 12,10 SAY "COPIANDO ARQUIVO --> "
DO WHILE .T.
   DO OPEN_FON
   IF CANCELA
      EXIT
   ENDIF
   DO WHILE .T.
      @ 12,34 SAY SPACE(15)
      IF .NOT. ARQ_DBT
         @ 12,34 SAY ARR_DIR[COPIA]
      ELSE
         @ 12,34 SAY ARR_DR1[COPIA]
      ENDIF
      ARQ_DES := DRIVE + ARQ_FON

      DO OPEN_DES
      IF CANCELA
         EXIT
      ENDIF

      IF TAM > DISK_FREE
         FLAG := .T.
	 F_SIZE := DISK_FREE
	 DO GRAVA
	 IF CANCELA
	     EXIT
	 ENDIF
	 TAM-=GRV_ARQ
	 FCLOSE(DESTINO)
	 DO GET_DISK
	 IF ERRO .OR. CANCELA
            EXIT
         ENDIF
         @ 12,10 SAY "Copiando arquivo --> "
      ELSE          	     
         F_SIZE := TAM
         DISK_FREE-=TAM
         DO GRAVA
         IF CANCELA
            EXIT
         ENDIF
         FCLOSE(DESTINO)
         FCLOSE(FONTE)
         COPIA++
         IF COPIA > NUM_ARQ
            IF ARQ_DBT
               FIM_DBT := .T.
               EXIT
             ENDIF
             IF NUM_ARQ1 = 0
                FIM := .T.
                EXIT
             ENDIF
             EXIT
         ENDIF
         DO OPEN_FON
         IF CANCELA
            EXIT
         ENDIF
         LOOP
      ENDIF
   ENDDO
   IF ERRO .OR. FIM .OR. CANCELA
      EXIT
   ENDIF
   IF FIM_DBT
      EXIT
   ENDIF
   ARQ_DBT := .F.
   NUM_ARQ := ADIR("*.DBT")
   IF NUM_ARQ = 0
      EXIT
   ENDIF
   ARQ_DBT := .T.
   COPIA = 1
ENDDO

IF CANCELA .OR. ERRO
   MENS("Backup cancelado ! Tecle algo...")
   return
ENDIF
LAST_DISK := .T.
DO GRV_CAB
MENS("Backup concluido. Tecle Algo...")
RETURN


********************************
PROCEDURE OPEN_FON
/*
ABRE ARQUIVOS DO HD A SEREM GRAVADOS NO FD
*/
IF .NOT. ARQ_DBT
   ARQ_FON := ARR_DIR[COPIA]
ELSE
   ARQ_FON := ARR_DR1[COPIA]
ENDIF
ARQ_FRAG := ARq_FON
FONTE := FOPEN(ARQ_FON,2)
IF FONTE = -1
   DO ALERTA
   RETURN
ENDIF
TAM := FSEEK(FONTE,0,2)
RETURN


********************************************
PROCEDURE OPEN_DES

// ABRE ARQUIVOS NO FD PARA GRAVACAO

DO WHILE .T.
   DESTINO := FCREATE(ARQ_DES,0)
   IF DESTINO = -1
      DO ALERTA
      IF REPETE
         REPETE := .F.
         LOOP
      ENDIF
   ENDIF
   EXIT
ENDDO
RETURN

***************************************
PROCEDURE GRAVA
//  ROTINA QUE GRAVA UM ARQUIVO DO HD P/ O FD
STORE .F. TO CANCELA, REPETE
GRV_ARQ := 0
DO WHILE .T.
   BLOC := 4096
   BUFFER := SPACE (BLOC)
   IF F_SIZE < 4096
      BLOC = F_SIZE
      BUFFER := SPACE(BLOC)
   ENDIF

   DO WHILE .T.
      rbytes   := fread(FONTE,@BUFFer,BLOC)
      IF R_BYTES != BLOC
         DO ALERTA
         IF REPETE
            REPETE := .F.
            LOOP
         ENDIF
      ENDIF
      EXIT
   ENDDO
   IF CANCELA
      RETURN
   ENDIF

   DO WHILE .T.
      W_BUFFER := FWRITE(DESTINO,BUFFER,BLOC)
      IF FWRITE != BLOC
         DO ALERTA
         IF REPETE
            REPETE := .F.
            LOOP
         ENDIF
      ENDIF
      IF CANCELA
         RETURN
      ENDIF
      EXIT
   ENDDO

   F_SIZE-=4096
   GRAVADO+=W_BYTES
   GRV_ARQ+=W_BYTES
   @ 15,10 SAY "Gravado ate agora.........:"
   @ 15,COL() SAY GRAVADO PICT "@E 9,999,999"
   DO BARRA
   IF F_SIZE < 1
      EXIT
   ENDIF
ENDDO
RETURN

***************************************
PROCEDURE GET_DISK

//ROTINA QUE PEDE O FD P/ GRAVACAO

R:= " "
STORE 0 TO GRAVADO,COP_ARQ,DISK_FREE, CONT
IF .NOT. INICIO
   DO GRV_CAB
ENDIF
INICIO := .F.
STOP  := .F.

IF FLAG
   FLAG1 := .T.
   FLAG  := .F.
ENDIF
DISCO++
@ 08,10 CLEAR TO 15,78
TONE(1000,1)

SET CURSOR ON
@ 08,10 SAY "Insira o disquete "+strzero(disco,2)+" no Drive "+drive1
@ 09,10 say "Atencao! todos os arquivos da unidade "+drive1+" serao"
@ 10,10 say "apagados...[ESC] cancela."
inkey(0)
SET CURSOR OFF
IF LASTKEY() = 27
   CANCELA := .T.
   RETURN
ENDIF

DO APAGA
IF CANCELA
   RETURN
ENDIF

DO WHILE .T.
   DISK_FREE := DISKSPACE(BK_MEM1+1)
   IF DISK_FREE < 1
      SN := CONFIRMA("Erro de leitura no drive "+drive1+" Repitir (S/N)")
      IF SN = "S"
         LOOP
      ENDIF
      CANCELA := .T.
   ENDIF
   EXIT
ENDDO
IF CANCELA
   ERRO := .T.
   RETURN
ENDIF
IF .NOT. ARQ_DBT
   FOR F := IND_ARQ TO NUM_ARQ
       COP_ARQ+=ARR_TAM[F]
       CONT++
       IF DISK_FREE<(COP_ARQ+(900*CONT))
          STOP := .T.
          EXIT
       ENDIF
   NEXT
   IF NUM_ARQ1 > 0 .AND. .NOT. STOP
      FOR F := 1 TO NUM_ARQ1
          COP_ARQ+=ARR_DIR[F]
          CONT++
          IF DISK_FREE<(COP_ARQ+(900*CONT))
             EXIT
           ENDIF
      NEXT
   ENDIF
ELSE
   FOR F := IND_ARQ TO NUM_ARQ1
       COP_ARQ+=ARR_DR1[F]
       CONT++
       IF DISK_FREE<(COP_ARQ+(900*CONT))
          EXIT
       ENDIF
   NEXT
ENDIF
DISK_FREE = DISKSPACE(BK_MEM1+1) - (CONT*900) - 512
@ 08,10 CLEAR TO 18,78
@ 08,10 SAY "Disco :"+STRZERO(DISCO,2)
@ 08,30 SAY "GRAVANDO....."
@ 10,10 SAY REPLICATE(CHR(176),51)
PASSO := DISK_FREE / 50
@ 13,10 SAY "Espaco total do disco......:"
@ 13,col() say "Espaco disponivel p/ backup: "
@ 14,10 say disk_free pict "@E 9,999,999"
RETURN

**************************************
PROCEDURE GRV_CAB
//ROTINA QUE GRAVA ARQUIVO DE CONTROLE EM CADA FD
ARQ_CAB := DRIVE+"CONTROL."+STRZERO(DISCO,3)
DO WHILE .T.
   DEST_CAB := FCREATE(ARQ_CAB,0)
   IF DEST_CAB = -1
      DO ALERTA
      IF REPETE
         REPETE := .F.
         LOOP
      ENDIF
   ENDIF
   EXIT
ENDDO
IF CANCELA
   RETURN
ENDIF
TEXTO := STRZERO(DISCO,2)+CABDADOS
IF FLAG
   TEXTO+="1"
ELSE
   TEXTO+=0
ENDIF

IF FLAG1
   TEXTO+="1"
ELSE
   TEXTO+="0"
ENDIF

IF LAST_DISK
   TEXTO+="1"
ELSE
   TEXTO+="0"
ENDIF

TEXTO+=ARQ_FON
TAM_CAB = LEN(TEXTO)
DO WHILE .T.
   W_CAB := FWRITE(DEST_CAB,TEXTO,TAM_CAB)
   IF W_CAB<>TAM_CAB
      DO ALERTA
      IF REPETE
         REPETE := .F.
         LOOP
      ENDIF
   ENDIF
   EXIT
ENDDO
IF CANCELA
   RETURN
ENDIF
FCLOSE(DEST_CAB)
RETURN


****************************
PROCEDURE APAGA
// ROTINA QUE APAGA OS DADOS DO FD P/ POSTERIOR GRAVACAO
CANCELA := .F.
DO WHILE .T.
   PRIVATE ARQ[ADIR(DRIVE+"*.*")]
   DECLARE ARQ[ADIR(DRIVE+"*.*")]
   ADIR(DRIVE+"*.*")
   N_ARQ = ADIR(DRIVE+"*.*")

   IF N_ARQ = 0
      ARQTESTE := FCREATE(DRIVE+"TESTE.000",0)
      IF ARQTESTE = -1
         SN = CONFIRMA("Atencao! Problemas c/ Drive ou disquete. repitir (S/N)")
         IF SN = "S"
            LOOP
         ENDIF
         CANCELA := .T.
      ELSE
         FCLOSE(ARQTESTE)
         DELE FILE &(DRIVE+"TESTE.000")
      ENDIF
   ENDIF
   EXIT
ENDDO
IF CANCELA
   RETURN
ENDIF
@ 11,10 SAY "Aguarde! apagando os arquivos da unidade"+ drive+"....."
FOR H := 1 TO N_ARQ
    MASC := DRIVE+ARQ[H]
    DELE FILE &MASC
NEXT
@ 11,10 SAY ''
RETURN

**********************
PROCEDURE BARRA
// ROTINA QUE MOSTRA NA TELA O ANDAMENTO DA GRAVACAO ATRAVES DE BARRAS
COL_BAR := INT(GRAVADO/PASSO)
SETCOLOR(XCOR2)
@ 10,10+COL_BAR SAY CHR(177)
SETCOLOR(XCOR1)
RETURN

********************
PROCEDURE ALERTA
// ROTINA EVOCADA QUANDO OCORRE UM ERRO QUALQUER DURANTE O BACKUP
// TAMBEM UTILIZADA PELO PROGRAMA BK2.PRG
SN := CONFIRMA("Atencao! Erro DOS:"+str(ferrOR(),2)+" Repetir (S/N)")
STORE .F. TO CANCELA, REPETE
IF SN = "N"
   CANCELA := .T.
ELSE
   REPETE := .F.
ENDIF
RETURN

* EOP BK.PRG