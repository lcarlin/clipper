/*
BOP BK2.PRG
DATA 15/06/95
*/
SET INTENSITY OFF
SET CENTURY OFF
STORE 0 TO  COP_ARQ, GRAVADO, DISK_FREE, CONT, NUM_FRA
STORE 1 TO DISCO, COPIA
IF BK_MEM = 0
   DRIVE := "A:"
   DRIVE1:= "A"
ELSE
   DRIVE := "B:"
   DRIVE1:= "B"
ENDIF
* PEDE DISCO 1
SET CURSOR ON

@ 08,10 SAY "Insira o disquete "+strzero(disco,2)+" no drive "+drive1
@ 09,10 say "e apos tecle algo........[ESC] cancela"
inkey(0)
@ 08,10 clear to 09,78
SET CURSOR OFF
IF LASTKEY() = 27
   FIM:= .T.
   SET INTENSITY ON
   RETURN
ENDIF
CANCELA := .F.
DO WHILE .T.
   FONTE := FOPEN(DRIVE+"CONTROL.001")
   IF FONTE = -1
      MENS ("Erro de abert. "+drive+" CONTROL.001")
      CANCELA := .T.
      EXIT
   ENDIF
   DO OPEN_CTL
   IF CANCELA
      EXIT
   ENDIF
   IF VAL(DISK_CTL)<>1
      SN := CONFIRMA("Atencao! Disco nao confere. Continuar (S/N)")
      if SN = "N"
         CANCELA = .T.
         EXIT
      ENDIF
      FCLOSE(FONTE)
      LOOP
   ENDIF
   EXIT
ENDDO
IF CANCELA
   SET INTEN ON
   SET CURSOR ON
   RETURN
ENDIF
@ 13,10 SAY "Data do backup:"
@ 13,col() say SUBSTR(DAT_CTL,1,2)+"/"+SUBSTR(DAT_CTL,3,2)+"/"+SUBSTR(DAT_CTL,5,2)
@ 14,10 SAY "Hora do backup: "
@ 14,col() say SUBSTR(HOR_CTL,1,2)+"/"+SUBSTR(HOR_CTL,3,2)+"/"+SUBSTR(HOR_CTL,5,2)
PRIVATE ARR_DIR01[ADIR(DRIVE+"*.*")], ARR_TM01[ADIR(DRIVE+"*.*")]
DECLARE ARR_DIR01[ADIR(DRIVE+"*.*")]
DECLARE ARR_TM01[ADIR(DRIVE+"*.*")]
NUM_ARQ := ADIR(DRIVE+"*.*",ARR_DIR01,ARR_TM01)
DISK_FREE := DISKSPACE()
IF DISK_FREE < 1
   MENS("Nao ha espaco no disco rigido. Tecle algo...")
   set INTENSITY ON
   SET CURSOR ON
   RETURN
ENDIF
TOT_ARQ = 0
FOR F := 1 TO (NUM_ARQ - 1)
    TOT_ARQ+=ARR_TM01[F]
NEXT
DISK_FREE := DISKSPACE() - (NUM_ARQ*900)
@ 08,10 SAY "Disco:"+STRZERO(DISCO,2)
@ 08,30 SAY REPlICATE(chr(176),51)
passo := tot_arq / 50
fra := .f.
DO RT_DADOS
IF CANCELA .OR. ERRO
   MENS("Restauracao cancelada. Tecle Algo..")
endif
SET INTENSITY ON
SET CURSOR ON
@ 08,10 CLEAR TO 18,70
CLOSE ALL

******************************
PROCEDURE RT_DADOS
//ROTINA PINCIPAL PARA RESTAURACAO DOS DADOS DO FD
STORE .F. TO CANCELA, REPETE, ERRO, FIM, ARQ_DBT, FIM_DBT, FLAG, FRA_ANT
STORE 0 TO GRAVADO, TAM, GRV_ARQ, FLAG, TOT_ARQ, NARQ_CTL, wDRIVE,N_DRIVE
ARQ_ANT := " "
WDRIVE := "C:"
@ 12,10 SAY "Restaurando arquivo -> "
grv_prim := .f.
DO WHILE .T.
   VETOR1 := 'ARR_DIR'+STRZERO(DISCO,2)
   VETOR2 := 'ARR_TM'+STRZERO(DISCO,2)
   DO R_OPFON
   IF CANCELA
      EXIT
   ENDIF

   DO WHILE .T.
      @ 12,34 SAY SPACE(15)
      @ 12,34 SAY &VETOR1[COPIA]
      arq_des:=wdrive+&vetor1[copia]
      IF FRA_CTL1 = 0
         R_OPDES()
      ENDIF
      IF CANCELA
         EXIT
      ENDIF
      IF FRA_CTL1 = "1" .AND. COPIA <>1
         R_OPDES()
      ENDIF
      IF CANCELA
         EXIT
      ENDIF
      IF TAM > DISK_FREE
         MENS("Atencao! Nao ha espaco p/ continuar restauracao. Tecle algo...")
         cancela := .t.
         exit
       ENDIF
       F_SIZE := TAM
       DISK_FREE-=TAM
       DO R_GRAVA
       IF CANCELA
          EXIT
       ENDIF
       IF (COPIA+1)=NUM_ARQ
          IF FRA_CTL = '0'
             fcloSE(DESTINO)
             FIM:= .T.
           ENDIF
           EXIT
        ELSE
           FCLOSE(DESTINO)
        ENDIF
        FCLOSE(FONTE)
        COPIA++
        DO R_OPFON
        IF CANCELA
           EXIT
        ENDIF
     ENDDO
     IF ERRO .OR. FIM .OR. CANCELA
        exit
     ENDIF
     FCLOSE(FONTE)
     STORE 0 TO COP_ARQ, GRAVADO, DISK_FREE, CONT
     DISCO++
     VETOR1 := 'ARR_DIR'+STRZERO(DISCO,2)
     VETOR2 := 'ARR_TM'+STRZERO(DISCO,2)
     COPIA := 1
     @ 08,10 SAY "Insira o disquete "+strzero(disco,2)+ " no drive "+drive1
     @ 09,10 say "[ESC] Cancela."
     INKEY(0)
     @ 08,10 TO 09,78
     SET CURSOR OFF
     IF LASTKEY() = 27
        CANCELA := .T.
        EXIT
     ENDIF
     DO WHILE .T.
        FONTE := FOPEN (DRIVE+"CONTROL."+STRZERO(DISCO,3))
        IF FONTE = -1
           MENS ("Erro de abert."+drive+"CONTROL."+STRZERO(DISCO,3))
           CANCELA := .T.
           EXIT
        ENDIF
        DO OPEN_CTL
        IF VAL(DISK_CTL)<>DISCO
           TONE(1000,1)
           @ 17,20 SAY "Atencao! Disco nao confere!! Troque o disco e"
           @ 18,20 say "Apos tecle [ENTER]. [ESC] Cancela"
           inkey(0)
           @ 17,20 CLEAR TO 18,78
           IF LASTKEY() = 27
              CANCELA := .T.
              EXIT
           ENDIF
           FCLOSE(FONTE)
           LOOP
        ENDIF
        EXIT
     ENDDO
     IF CANCELA
        EXIT
     ENDIF
     DISK_FREE := DISKSPACE()
     IF DISK_FREE < 1
        MENS("Atencao! Nao ha mais espaco p/ restaurar os arquivos.")
        erro := .T.
        EXIT
     ENDIF
     DECLARE &VETOR1[ADIR(DRIVE+"*.*")]
     DECLARE &VETOR2[ADIR(DRIVE+"*.*")]
     NUM_ARQ := ADIR(DRIVE+"*.*",&VETOR1,&VETOR2)
     TOT_ARQ := 0
     FOR F := 1 TO (NUM_ARQ-1)
         TOT_ARQ+=&VETOR2[F]
     NEXT
     DISK_FREE := DISKSPACE()-(NUM_ARQ*900)
     @ 08,10 clear to 18,78
     @ 08,10 SAY "Disco: "+strzero(DISCO,2)
     @ 08,30 SAY "Restaurando....."
     @ 10,10 SAY REPLICATE(CHR(176),51)
     PASSO := TOT_ARQ/50
     @ 12,10 SAY "Restaurando Arquivos ->"
     @ 14,10 say "data do backup:"
     @ 14,col() say substr(DAT_CTL,1,2)+"/"+SUBSTR(DAT_CTL,3,2)+"/"+SUBSTR(DAT_CTL,5,2)
     @ 15,10 SAY "Hora do Backup:"
     @ 15,col() say substr(hor_CTL,1,2)+":"+subsTR(HOR_CTL,3,2)+":"+SUBSTR(HOR_CTL,5,2)
  ENDDO
RETURN


***********************
PROCEDURE R_OPFON
// ROTINA QUE ABRE ARQUIVO NO FD P/ GRVACAO NO HD

CANCELA := .T.
DO WHILE .T.
   ARQ_FON := DRIVE+&VETOR1[COPIA]
   FONTE := FOPEN(ARQ_FON,2)
   IF FONTE = -1
      DO ALERTA
      IF REPETE
         LOOP
      ENDIF
   ENDIF
   EXIT
ENDDO
IF CANCELA
   RETURN
ENDIF
TAM := FSEEK(FONTE,0,2)
FSEEK(FONTE,0,0)
RETURN

************************************
PROCEDURE R_OPDES

//PROCEDURE QUE ABRE OS ARQUIVOS NO HD PARA SEREM GRAVADOS
CANCELA := .F.
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

*************************************
PROCEDURE R_GRAVA
// PROCEDURE QUE GRAVA UM ARQUIVO DO FD P/ O HD
STORE .F. TO CANCELA,REPETE
GRV_ARQ := 0
DO WHILE .T.
   BLOC := 4096
   BUFFER := SPACE(BLOC)
   IF F_SIZE < 4096
      bloc := fsize
      BUFFER := SPACE(BLOC)
   ENDIF
   DO WHILE .T.
      R_BYTES := FREAD(FONTE,@BUFFER,BLOC)
      IF R_BYTES := BLOC
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
      W_BYTES := FWRITE(DESTINO,BUFFER,BLOC)
      IF W_BYTES != BLOC
         DO ALERTA
         IF REPETE
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
   DO R_BARRA
   IF F_SIZE < 1
      EXIT
   ENDIF
ENDDO
RETURN

*********************************
PROCEDURE R_BARRA
// ROTINA QUE MOSTRTA O ANDAMENTO DA GRAVACAO ATRAVES DE BARRAS
COL_BAR := INT(GRAVADO/PASSO)+1
SETCOLOR(XCOR2)
@ 10,10 SAY REPLICATE(CHR(177),COL_BAR)
SETCOLOR(XCOR1)
RETURN

************************************
PROCEDURE OPEN_CTL
// ROTINA QUE ABRE OS ARQUIVOS DE CONTROLE DE CADA DISQUETE
TAM_CTL := FSEEK(FONTE,0,2)
IF TAM_CTL < 1
   MENS("Erro no acesso ao arquivo fonte.Tecle algo...")
   cancela := .t.
   return
ENDIF
FSEEK(FONTE,0,0)
BUFFER := SPACE(TAM_CTL)
DO WHILE .T.
   R_BYTES := FREAD(FONTE,@BUFFER,TAm_CTL)
   IF R_BYTES != TAM_CTL
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
FCLOSE(FONTE)
DISK_CTL := SUBSTR(BUFFER,1,2)
DAT_CTL := SUBSTR(BUFFER,3,6)
HOR_CTL := SUBSTR(BUFFER,6,9)
FRA_CTL := SUBSTR(BUFFER,15,1)
FRA_CTL1:= SUBSTR(BUFFER,16,1)
LAST_CTL:= SUBSTR(BUFFER,17,1)
ARQ_CTL := SUBSTR(BUFFER,18,(TAM_CTL-17))
RETURN
*EOP BK2.PRG