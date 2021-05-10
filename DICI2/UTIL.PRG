* Bop Util.prg
*****************************************************************************
procedure espaco
SAVE SCREEN TO TELA2
OPCAO="S"
DRIVE="A"
ESP=0
DO WHILE OPCAO="S"
   RESTORE SCREEN FROM TELA2
   sombra(11,48,16,71,.t.)
   @ 12,49 SAY "ENTRE C/ O DRIVE: " GET DRIVE PICTURE "!"
   READ
   if empty(drive)
      restore screen from tela2
      return
   endif
   IF DRIVE>="A" .AND. DRIVE <="C"
      IF DRIVE="A"
	 SET DEFA TO A:
	 !A:
	 ESP=DISKSPACE()
       ELSEIF DRIVE="B"
	  SET DEFA TO B:
	  !B:
	  ESP=DISKSPACE()
      ELSEIF DRIVE="C"
	 SET DEFA TO C:
	 !C:
	 ESP=DISKSPACE()
      ENDIF
      SET DEFA TO C:
      !C:
      ESP=ESP/1024
      ESP=ESP/1024
      @ 13,49 SAY "ESPACO: "+STR(ESP,9,2)
      @ 14,49 SAY "MEGA-BYTES"
      @ 15,56 SAY "OUTRO DRIVE?" GET OPCAO PICTURE "!"
      READ
      @ 15,56 SAY "                   "
   ELSE
      @ 15,56 SAY "DRIVE INVALIDO!!"
      INKEY(0)
      @ 16,56 SAY "                "
   ENDIF
ENDDO
RESTORE SCREEN FROM TELA2
RETURN
******************************************************************************
procedure rodados
SAVE SCREEN TO TELA4
COMA=SPACE(40)
DO WHILE .T.
   sombra(12,24,16,65,.t.)
   @ 13,35 SAY "Digite o Comando : "
   @ 14,35 say "Ou <ENTER> P/ Sair"
   @ 15,25 get coma pict "@!"
   READ
   IF COMA=SPACE(40)
      RESTORE SCREEN FROM TELA4
      RETURN
   ENDIF
   COMA=ALLTRIM(COMA)
   SAVE SCREEN TO TELA4A
   COR=SETCOLOR()
   SET COLOR TO
   CLEAR
   IF COMA="COMMAND"
       ?"Digite <EXIT> para voltar"
   ENDIF
   RUN &COMA
   @ 24,25 SAY "Tecle <ENTER> p/ Continuar"
   inkey (0)
   SET COLOR TO &COR
   RESTORE SCREEN FROM TELA4A
   COMA=SPACE(40)
ENDDO
RETURN
*****************************************************************************
procedure anotar
save screen to tela_1
oe=0
sombra(03,61,07,75,.t.)
do while .t.
   nome=space(12)
   @ 04,62 prompt "Nova Anotacao"
   @ 05,62 prompt "Edita Antiga "
   @ 06,62 prompt "  Volta      "
   menu to oe
   if lastkey()=27
      restore screen from tela_1
      return
   endif
   do case
      case oe=1
	   save screen to tela_2
	   sombra(09,39,11,77,.t.)
	   @ 10,40 say "Nome Da Nova Anotacao->" Get nome picture "@!"
	   read
	   if empty(nome)
	       exit
	   endif
	   sombra(10,13,22,77,.t.)
	   texto=memoread(nome)
	   @ 10,15 say " ¯ "+alltrim(nome)+" ® "
		   if empty(texto)
	      edit=.t.
		   else
	      edit=.f.
		   endif
	   texto=memoedit(texto,11,14,21,75,edit,"ACENTOS",120,4)
	   if lastkey()<>27
	      @ 23,30 say "Gravando..."
	      ok=memowrit(nome,texto)
	   endif
	   restore screen from tela_2
      case oe=2
	   save screen to tela_2
	   sombra(09,35,11,77,.t.)
	   @ 10,36 say "Nome Da Antiga Anotacao->" Get   nome picture "@!"
	   read
	   if empty(nome)
	      exit
	   endif
	   sombra(10,13,22,77,.t.)
	   @ 10,15 say " ¯ "+alltrim(nome)+" ® "
	   texto=memoread(nome)
	   texto=memoedit(texto,11,14,21,75,.t.,"ACENTOS",120,4)
	   if lastkey()<>27
	      @ 23,30 say "Gravando..."
	      ok=memowrit(nome,texto)
	   endif
	   restore screen from tela_2
      case oe = 3
	   restore screen from tela_1
	   return
   endcase
enddo
restore screen from tela_1
return
*********************
function acentos
parameters modo,linha,coluna
private retorna
retorna=lastkey()
cursor=.f.
@ 23,50 say "Linha:"+str(linha,3,0)+"   Coluna:"+str(coluna,3,0)
do case
   case modo=3
	cursor=.f.
endcase
*****************************************************************************
procedure copseg
SAVE SCREEN TO TELA5
set path to c:\dos
sombra(11,34,14,56,.t.)
DO WHILE .T.
   UNI=" "
   SET INTEN On
   @ 12,35 SAY "Unidade Destino : " GET UNI PICT "@!"
   @ 13,35 SAY "Ou <ENTER> P/ Sair"
   READ
   save screen to tela5a
   IF UNI=" "
      RESTORE SCREEN FROM TELA5
      SET INTEN ON
      EXIT
   ENDIF
   if uni >="A" .AND. UNI<="B"
      SAVE SCREEN TO TELA5A
      UNI= ALLTRIM(UNI)+":"
      COR=SETCOLOR()
      SET COLOR TO
      CLEAR
      RUN BACKUP C: &UNI
      SET COLOR TO &COR
      RESTORE SCREEN FROM TELA5A
   ELSE
      @ 14,25 SAY "Drive Invalido!!"
      inkey(.9)
      restore screen from tela5a
      loop
  endif
ENDDO
RETURN
