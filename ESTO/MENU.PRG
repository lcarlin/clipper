**************************************************
* PROGRAMA        : MENU .PRG                      *
* AUTOR           : LUIZ A. CARLIN                 *
* DATA            : 10/15/93                       *
* DATA DA ATUAL.  :   /  /                         *
* FUNCAO          : MENU PRINCIPAL DO SISTEMA DE   *
*                 : ESTOQUE P/ DELEGACIA DE ENSINO *
****************************************************
SET DATE BRITISH
SET INTEN ON
SET SCOREBOARD OFF
SET WRAP ON
SET PATH TO C:\DOS;
QUDR=CHR(127)+CHR(178)+CHR(127)+CHR(178)+CHR(127)+CHR(178)+CHR(127)+CHR(178)+CHR(176)
public MCODMAT, MCODE, NPRO
CLEAR
SET MESSAGE TO 23 CENTER
set key -1 to imp_cod
set key -2 to imp_esc
set key -3 to edit
SET COLOR TO W+/BG
@ 0,0,24,79 BOX QUDR
SET COLOR TO B+/RB
centra(2,"ESTO; Programa De Controle De Estoque De Materiais; ˚ 1.1")
set color to
@ 05,60,08,69  box chr(176)
SET COLOR TO B+/RB
@ 04,59 to 07,68
@ 05,60 say " Data : "
@ 06,60 SAY DATE()
set color to
centra(3," MENU PRINCIPAL ")
@ 06,25,16,48 BOX CHR(176)
@ 05,24 CLEAR  TO 15,47
@ 05,24 TO 15,47 DOUBLE
SET COLOR TO N/W
@ 06,47 SAY CHR(24)
@ 07,47 SAY CHR(177)
@ 08,47 SAY CHR(177)
@ 09,47 SAY CHR(177)
@ 10,47 SAY CHR(177)
@ 11,47 SAY CHR(177)
@ 12,47 SAY CHR(177)
@ 13,47 SAY CHR(177)
@ 14,47 SAY CHR(25)
SET COLOR TO
@ 5,3,18,21 BOX CHR(176)
@ 4,2 CLEAR TO 17,20
@ 04,02 TO 17,20
@ 05,03 SAY "<F1>-Help"
@ 07,03 say "<F2>-Imprime"
@ 08,03 say "Codigos De"
@ 09,03 say "Materiais"
@ 11,03 say "<F3>-Imprime"
@ 12,03 say "Codigo De Escolas"
@ 14,03 say "<F4>-Consulta De"
@ 15,03 say "Banco De Dados"
save screen to tela_men
DO WHILE .t.
    ENCE=" "
    restore screen from tela_men
    @ 06,28 PROMPT "1.MATERIAIS....1" MESSAGE "InclusÑo/ManutencÑo    De    Materiais"
    @ 07,28 PROMPT "2.ESCOLAS......2" MESSAGE "Cadastra/Exclui  Escolas  Do  Programa"
    @ 08,28 PROMPT "3.MOVIMENTAÄèO.3" MESSAGE "Movimenta Materias (Baixa  De Estoque)"
    @ 09,28 PROMPT "4.ORGANIZAÄèO..4" MESSAGE "Ordena  E  Indexa  Arquivos  De  Dados"
    @ 10,28 PROMPT "5.RELATORIOS...5" MESSAGE "Emite     Relatorios    De      Baixas"
    @ 11,28 PROMPT "6.CONSULTAR....6" MESSAGE "Consulta   De  Materiais  Movimentados"
    @ 12,28 PROMPT "7.EXCLUIR......7" MESSAGE "ExclusÑo  De   Movimentacîes   Antigas"
    @ 13,28 PROMPT "8.UTILITARIO...8" MESSAGE "Roda DOS; Espaáo De Disco; Backup; Etc"
    @ 14,28 PROMPT "9.FINALIZAR....9" MESSAGE "Encerra   A   ExcuáÑo   Do    Programa"
    MENU TO OPC
    if lastkey()=27
       opc=9
       ENCE=" "
       keyboard chr(13)
    endif
    READ
    DO CASE
	  CASE OPC=1
	       DO INCLUI
	  CASE OPC=2
	       DO CADESC
	  CASE OPC=3
	       DO MOVIME
	  CASE OPC=4
	       ?? CHR(07)
	       USE MATERIAL
	       INDEX ON CODMAT TO INX1
	       USE ESCOLA
	       INDEX ON CODESCO TO INX2
	       USE MOVIME
	       INDEX ON CODMAT+CODESCO TO INX3
	       INDEX ON DATA TO INX4
	       USE CODES
	       INDEX ON SENHA TO CODX
	       CLOSE DATABASES
		@ 21,00 CLEAR  TO 24,79
	  CASE OPC=5
	       DO IMPRI
	  CASE OPC=6
	       DO CONSUL
	  CASE OPC=7
	       DO EXCLUI
	  CASE OPC=8
	       DO UTIL
	  CASE OPC=9
	       tone (250,2)
	       @ 21,25 say "Quer Mesmo Sair <S/N> ? " GET ENCE PICTURE "!"
	       READ
	       IF ENCE="S"
		  centra(20,"Aguare !!! Reindexando Arquivos")
		  usE MATERIAL  index inx1
		  reindex
		  use escola index inx2
		  reindex
		  use movime index inx3
		  reindex
		  use movime index inx4
		  reindex
		  CLEAR
		  CLOSE DATABASES
		  RESTORE SCREEN FROM TEL_0
		  @ LINHA,COLUNA
		  CLEAR MEMORY
		  CANCEL
	       ENDIF
    ENDCASE
ENDDO
************************************************************************
