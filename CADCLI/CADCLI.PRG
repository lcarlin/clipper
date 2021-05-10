/*******************************
bop cadcli.prg
programa   cadcli.prg
autor      Luiz Antonio Carlin
data       01/06/95
funcao     Cadastro e impressao de listagem de clientes

*/
linha_dos:=row()
coluna_dos:=col()
save screen to tela_dos
cls

PUBLIC mNome
IF .not. FILE("arquivo.dbf")
    aMatEstru := {{"selec   ","C",01,0},;
                  {"nome    ","C",30,0},; 
                  {"BANCO   ","C",15,0},;    
                  {"AGENCIA ","C",10,0},;
                  {"CCORRENT","C",15,0},;
                  {"telef   ","C",15,0},;
                  {"obs     ","C",30,0}}
   dbcreate("arquivo",aMatEstru)
   CLOSE ALL
ENDIF

if .not. file([indice.ntx])
   use arquivo
   index on nome to indice
   close all
else
   use arquivo index indice
   reindex
endif

public  vet_camp:={"selec" ,"nome" ,"BANCO"    ,"AGENCIA","CCORRENT","telef",   "obs"}
public  vet_masc:={"!"     ,"@!"   ,"@!"       ,"@!"     ,"@!"      ,"@!"   ,    "@!"}
public  vet_cab :={"Selec. ","Nome","Banco"    ,"Agencia","Conta Corrente","Telefone","Obs"}

set bell off
set score off
set wrap on
set date brit

set color to b/bg 
@ 0,0,24,79 box "²²²²²²²²²"
set color to gr+/b
centra(00,"Controle de Clientes v1.0 - CS # 1995","b/r")
centra(01,"Rural Corretora de Mercadorias  -  Piraju  -  SP","b/r")
@ 02,02 clear to 07,72
@ 02,02 to 07,72
aOpc := array(8,3)
aOpc := {{03,03,"<F2> - INCLUI"},{03,18,"<F3> - IMPRIME"},{03,34,"<F4> - MARCA"},;
        {03,48,"<F5> - ANULA SELECAO"},;
        {05,03,"<ENTER> - EDITA"},{05,20,"<DEL> - EXCLUI"},;
        {05,37,"<ESC> - SAIR"},{05,51,"<F6> - LOCALIZA"}}
opc := botao(aOpc,.f.)
sombra (08,00,23,76)
DBEDIT(09,01,22,75,VET_CAMP,"EDITA",VET_MASC,VET_CAB)
set color to
restore screen from tela_dos
setpos(linha_dos,coluna_dos)

**************************************************************
function edita(modo,indice)
tecla:=lastkey()
campo:=vet_camp[indice]
mascara := vet_masc[indice]
do case
   case modo = 1
	return 1
   case modo = 2
	RETURN 1
   case modo = 3
	append blank
	return 1
   case modo = 4
	if tecla = 27
	   if confirma ("Deseja Realmente Sair")
	      return 0
	   endif
	   return 1
	elseif tecla=13
	   if campo != "selec"
	      @ row(),col() get &campo picture mascara
	      set cursor on
	      read
	      set cursor off
	   endif
	   return 2
	elseif tecla = 7
	   count for selec="S" to exc
	   if exc > 0
	      IF CONFIRMA ("Excluir Registro(s)")
		 dele all for selec = "S"
		 pack
		 return 2
	      endif
	   else
	      mensagem("Nao ha registros marcados")
	   endif
	   return 1
       elseif tecla = -3
	   if selec = "S"
	      replace selec with " "
	   else
	      replace selec with "S"
	   endif
	   return 1
       elseif tecla=-1
           SAVE SCREEN TO TELA_IC
           append blank
           cor := setcolor()
           APRE := SETCURSOR(1)
           sombra(08,08,15,56)
           @ 09,09 clear to 14,55
           @ 08,30 say "Inclusao"
           @ 09,09 SAY "Nome...........:" get nome picture"@!"
           @ 10,09 SAY "Banco..........:" get banco picture"@!"
           @ 11,09 say "Agencia........:" get agencia picture"@!"
           @ 12,09 say "Conta Corrente.:" get ccorrent picture"@!"
           @ 13,09 say "Telefone.......:" get telef picture"@!"
           @ 14,09 say "Observacoes....:" get obs   picture "@!"
           read
           if lastkey()=27
              dele
              pack
           endif
           SETCURSOR(APRE)
           set color to &cor
           RESTORE SCREEN FROM TELA_IC
	   return 2
       ELSEIF TECLA=-2
	   save screen to tela_2
	   cor_1:=setcolor()
	   set color to R/N
	   sombra(09,09,20,50)
	   @ 09,15 say "Impressao" color "r/n"
	   mopc := array(5,3)
	   mopc := {{10,13,"Imprime todo o arquivo"},{12,13,"Imprime por BANCO"},{14,13,"Imprime registros SELECIONADOS"},{18,13,"Voltar"}}	   
           escolha := botao(mopc)
	   set color to &cor_1
	   set console off
	   begin sequence
             if escolha > 0 .AND. ESCOLHA < 4
	        MENSAGEM("Verifique a IMPRESSORA!!!")
                If .not. isprinter()
	           mensagem("A Impressora nao pode estar pronta")
	           break
		ENDIF
	     endif
	     do case
		case escolha = 1
		     sombra(11,25,13,47)
		     @ 12,26 say "Aguarde!! Imprindo..." color "W*/n"
		     go top
                     NUM_IMP := RECCOUNT()
		     impressao("Completo ",NUM_IMP)
		case escolha = 2
		     mbanco=space(20)
		     sombra(11,20,13,60)
                     apre := setcursor(1)
		     @ 12,21 say "Entre com o BANCO" get MBANCO picture"@!" valid(mBANCO<>" ")
		     read
		     if lastkey()=27
			break
		     endiF
                     setCursor(apre)
		     sombra(08,25,10,47)
		     @ 09,26 say "Aguarde!! Imprindo..." color "r*/n"
		     mbanco = alltrim(mbanco)
                     COUNT FOR BANCO = MBANCO TO NUM_IMP
		     set filter to banco = mbanco
		     go top
                     impressao (" Por Banco ",NUM_IMP)
		     set filter to
		case escolha = 3
		     sombra(11,25,13,47)
		     @ 12,26 say "Aguarde!! Imprindo..." color "r*/n"
                     COUNT FOR SELEC = "S" TO NUM_IMP
		     set filter to selec="S"
		     go top
                     impressao (" Parcial ",NUM_IMP)
		     set filter to
	       otherwise
	            break
	     endcase
	   END
	   set console on
	   set device to screen
	   restore screen from tela_2
	   release tela_2, cor_1, mopc, escolha
           GO TOP
	   return 1
       ELSEIF LASTKEY()=-4
	   SET FILTER TO SELEC="S"
	   GO TOP
	   DO WHILE .NOT. EOF()
	      REPLACE SELEC WITH " "
	      SKIP
	   enddo
	   SET FILTER TO
           GO TOP
	   RETURN 2
        ELSEIF LASTKEY() = -5 
           SAVE SCREEN TO TELA_ANT
           APRES:=SETCURSOR(1)
           sombra(05,08,07,67)
           mnome := space(40) 
           @ 06,26 SAY " " 
           @ 06,09 say "Entre com o nome:" GET MNOME PICT "@!" 
           READ
           mNOME := ALLTRIM(MNOME)
           RESTORE SCREEN FROM TELA_ANT
           SETCURSOR(APRES)
           IF EMPTY(MNOME)
              SET FILTER TO 
              go top 
              RETURN 2
          ENDIF 
          SET FILTER tO NOME = MNOME
          go top 
          RETURN 2
       else
	   return 1
       endif
endcase

****************************************************************
procedure cabecalho (pagina,tipo)
if pagina>1
   eject
endif
set print on
@ 00,00 say chr(18)+chr(20)
set print off
@ 01,01 say "RURAL CORRETORA DE MERCADORIAS"
@ 01,65 say "Pagina: "+str(pagina,3,0)
@ 02,02 say "Avenida Sao Sebastiao, 747 - Piraju - Telefax.: (0143) 51-3122"
@ 03,02 say "Relatorio "+tipo+"de Produtores Cadastrados ate "+dtoc(date())
set print on
??chr(14)+chr(15)
set print off
@ 04,00 say "+"
@ 04,01 say replicate("-",126)
@ 04,127 say "+"            
@ 05,00  say "|"
@ 05,05  say " P R O D U T O R "
@ 05,33  say "|"
@ 05,36  say " B A N C O"
@ 05,50  say "|"
@ 05,52  say "AGEN."
@ 05,62  SAY "|"
@ 05,63  say " C.Corrent"
@ 05,78  SAY "|"
@ 05,81  say "Telefone"
@ 05,95  SAY "|"
@ 05,96  SAY "Observacoes"
@ 05,127 say "|"
@ 06,00  say "+"
@ 06,01  SAY REPLICATE("-",126)
@ 06,127 say "|"
return


******************************   
procedure impressao (rtipo, NUM_REG)
******************************
IF EOF()
   MENSAGEM("Nao ha registros para imprimir!!")
   return
endif
SOMBRA(13,15,16,60)
@ 14,16 clear to 15,59
num_pag := num_reg/53
num_pag2 := if(num_pag/int(num_pag)=0,num_pag,int(num_pag)+1)
num_pag3 := if(num_pag2=0,num_pag2+1,num_pag2)
@ 14,16 SAY "Numero de registros a serem impressos: "+str(num_reg,5,0)
@ 15,16 say "Numero aproximado de paginas :"+ str(num_pag3,5,0)
inkey(3)
p=1
l=7
set console off
set device to printer
cabecalho (p,rtipo)
do while .not. eof()
   @ l,00  say "|"
   @ l,01  say nome
   @ l,33  say "|"
   @ l,34  say banco
   @ l,50  say "|"
   @ l,51  say agencia
   @ L,62  SAY "|"
   @ l,63  say ccorrent
   @ L,78  SAY "|"
   @ l,79  say telef
   @ L,95  SAY "|"
   @ L,96  SAY OBS
   @ L,127 SAY "|"
   L++
   skip
   IF L >=60
      @ l,00 say "+"
      @ l,01 say replicate("-",126)
      @ l,127 say "+"
      P++
      CABECALHO (P,rtipo)
      l=7
   endif
enddo
@ l,00 say "+"
@ l,01 say replicate("-",126)
@ l,127 say "+"
set print on
??chr(18)+chr(20)
set print off
eject

*************************
* eop cadcli.prg
*************************