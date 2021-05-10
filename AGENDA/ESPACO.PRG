*******************************************************
* PROGRAMA       : ESPACO.PRG
* AUTOR          : DANIEL G. RODRIGUES
* DATA           : 01/10/89
* DATA ATUALIZ	 : 10/10/93
* FUNCAO	 : VERIFICAR ESPACO LIVRE DO DISCO
* OBS		 :
********************************************************
@ 01,28 SAY &INVERSO
SET COLOR TO W/N
OPCAO="S"
DRIVE="A"
DO WHILE OPCAO="S"
   @ 09,01 CLEAR
   @ 09,28 TO 11,50
   @ 10,29 SAY "ENTRE C/ O DRIVE: " GET DRIVE PICTURE "!"
   READ
   IF DRIVE>="A" .AND. DRIVE <="D"
      @ 09,01 CLEAR
      @ 09,24 TO 11,55
      @ 10,25 SAY "ESPACO: "
      SET DEFA TO &DRIVE
      @ 10,34 SAY DISKSPACE()
      @ 10,49 SAY "BYTES"
      @ 20,32 SAY "OUTRO DRIVE?" GET OPCAO PICTURE "!"
      READ
   ELSE
      @ 09,01 CLEAR
      @ 09,30 TO 11,46
      @ 10,31 SAY "DRIVE INVALIDO!!"
   ENDIF
ENDDO
*SET DEFA TO C
DO AGENDA
RETURN