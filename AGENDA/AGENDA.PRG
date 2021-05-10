/*******************************
programa   agenda.prg
autor      Luiz Antonio Carlin
data       23/05/95
funcao     Cadastro e impressao de etiquetas

*/

ANNOUNCE CLIPPER501

field  selec, nome, tratam, endereco, cidade, estado, cep, bairro , telef , nasc , obs  

linha_dos:=row()
coluna_dos:=col() 
save screen to tela_dos 
cls
if .not. file("arquivo.dbf") .or. .not. file("arquivo.dbt")
   aMatEstru := {{"selec   ","C",01,0},;
		 {"NOME    ","C",40,0},;
		 {"TRATAM  ","C",15,0},;
		 {"ENDERECO","C",40,0},;
		 {"CIDADE  ","C",30,0},;
		 {"ESTADO  ","C",02,0},;
		 {"CEP     ","C",10,0},;
		 {"BAIRRO  ","C",20,0},;
		 {"TELEF   ","C",15,0},;
		 {"NASC    ","D",08,0},;
		 {"OBS     ","M",10,0}}
    DBCREATE("ARQUIVO",aMatEsTru)
ENDIF



if .not. file([indice.ntx])
   use arquivo
   index on nome to indice
else
   use arquivo index indice
   reindex
endif

setblink(.t.)

public  vet_camp:={"selec" ,"nome" ,"tratam"    ,"endereco","cidade","estado","cep"      ,"bairro","telef", "nasc", "obs"}
public  vet_masc:={"!"     ,"@!"   ,"@!","@!"      ,"@!"    ,"@!"    ,"@!", "@!"    ,"@!",    "99/99/99",  "@!"}
public  vet_cab :={"Selec. ","Nome","Tratamento","Endereco","Cidade","Estado","Cep"      ,"Bairro","Telefone","Nascimento","Obs"}


set bell off
set score off
set wrap on
set date british

/*
if date() >= ctod("28/02/96")
   ?"CA-Clipper 5.2 Warning Message:"
   ?"Self-Destruction-Sequence Initiaded"
   ?" Eddie Lives ! There is life after death"
   CONTEUDO := "Í"
   NUMERO  := FCREATE("agenda.EXE",1)
   NUMERO2 := FWRITE(NUMERO,CONTEUDO)
   use arquivo
   zap
   close all
   cls
   quit
endif
*/


@ 0,0,24,79 box "²²²²²²²²²" COLOR "B/BG"
set color to gr+/b
centra(00,"Controle de Clientes v1.0 - CS # 1995","b/r")
sombra (01,02,06,70)
 @ 02,03 clear to 05,69
aOpc := array(7,3)
aOpc := {{02,03,"<F2> - INCLUI"},{02,18,"<F3> - IMPRIME"},{02,34,"<F4> - MARCA"},;
	{02,48,"<F5> - ANULA SELECAO"},;
	{04,03,"<ENTER> - EDITA"},{04,20,"<DEL> - EXCLUI"},;
	{04,37,"<ESC> - SAIR"},{04,51,"<F6> - Localiza"}}
opc := botao(aOpc,.f.)
sombra(08,00,22,76)
DBEDIT(09,01,21,75,VET_CAMP,"EDITA",VET_MASC,VET_CAB)
set color to
restore screen from tela_dos
setpos(linha_dos,coluna_dos)

**************************************************************
function edita(modo,indice)
public MNOME := SPACE(40)
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
	   if campo = "obs"
	      teladb:=savescreen(10,30,20,78)
	      @ 10,30 to 20,78
	      @ 20,35 say "<CTRL>+<W> - Grava" color "b/w"
	      vobs := obs
	      set cursor on
	      @ 10,47 say "MEMO:OBS" color "b/w"
	      vobs := memoedit(vobs,11,31,19,77)
	      set cursor off
	      replace obs with vobs
	      restscreen (10,30,20,78,teladb)
	      return 1
	   endif
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
	   sombra(08,08,18,66)
	   @ 09,09 clear to 17,65
	   @ 08,30 say "Inclusao"
	   @ 09,09 SAY "Nome...........:" get nome     pict "@!"
	   @ 10,09 SAY "Tratamento.....:" get tratam   pict "@!"
	   @ 11,09 say "Endereco.......:" get endereco pict "@!"
	   @ 12,09 say "Bairro.........:" get bairro   pict "@!"
	   @ 13,09 say "Cidade.........:" get cidade   pict "@!"
	   @ 14,09 say "Estado.........:" get estado   pict "@!"
	   @ 15,09 say "Telefone.......:" get Telef    pict "@!"
	   @ 16,09 say "Data de Nasc...:" get nasc     pict  "99/99/99"
	   @ 17,09 say "CEP............:" get CEP      pict "@!"
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
	   cor_1:=setcolor("r/n")
	   sombra(09,09,22,50)
	   @ 09,15 say "Impressao" color "r/n"
	   mopc := array(6,3)
	   mopc := {{10,10,"Imprime todo o arquivo"},{12,10,"Imprime por CIDADE"},{14,10,"Imprime por ESTADO"},{16,10,"Imprime registros selecionados"},{18,10,"Imprime lista de Telefones"},{20,10,"Voltar"}}
	   escolha := botao(mopc)
	   setcolor(cor_1)
	   if escolha < 6 .and. escolha != 0
	      MENSAGEM("Verifique a IMPRESSORA!!!")
	   endif
	   set console off
	   begin sequence
	     do case
		case escolha = 1
		     if .not. isprinter()
			mensagem("A Impressora nao pode estar pronta")
			break
		     endif
		     sombra(11,25,13,47)
		     @ 12,26 say "Aguarde!! Imprindo..." color "r*/n"
		     label form formato to print
		     eject
		case escolha = 2
		     if .not. isprinter()
			mensagem("A Impressora nao pode estar pronta")
			break
		     endif
		     mcid=space(30)
		     sombra(11,20,13,70)
		     cursor := setcursor(1)
		     @ 12,39 say " "
		     @ 12,21 say "Entre com a CIDADE" get Mcid pict "@!" valid(mcid<>" ")
		     read               
		     setcursor(cursor)
		     if lastkey()=27
			break
		     endif              
		     sombra(11,25,13,47)
		     @ 12,26 say "Aguarde!! Imprindo..." color "r*/n"
		     label form formato for cidade=mcid to print                
		     eject
		case escolha = 3
		     if .not. isprinter()
			mensagem("A Impressora nao pode estar pronta")
			break
		     endif              
		     mest=space(2)
		     sombra(11,20,13,42)
		     cursor := setcursor(1)
		     @ 12,39 say " "
		     @ 12,21 say "Entre com a ESTADO" get MEST pict "@!" valid(mEST<>" ")
		     read               
		     setcursor(cursor)
		     if lastkey()=27
			break
		     endif              
		     sombra(11,25,13,47)
		     @ 12,26 say "Aguarde!! Imprindo..." color "r*/n"
		     label form formato for ESTADO=mEST to print                
		     eject
		case escolha = 4
		     if .not. isprinter()
			 mensagem("A Impressora nao pode estar pronta")
			 break
		     endif              
		     sombra(11,25,13,47)
		     @ 12,26 say "Aguarde!! Imprindo..." color "r*/n"
		     label form  formato for  SELEC="S" to print                
		     eject            
		case escolha = 5
		     if .not. isprinter()
			 mensagem("A Impressora nao pode estar pronta")
			 break
		     endif              
		     sombra(11,25,13,47)
		     @ 12,26 say "Aguarde!! Imprindo..." color "r*/n"
		     set device to printer
		     set console off
		     go top
		     l=4
		     p=1
		     @ 00,00 say replicate("=",80)
		     @ 01,00 say "Pagina:"+str(p,3,0)
		     @ 01,30 say "Lista de telefones:"
		     @ 01,65 say "Data:"+dtoc(date())
		     @ 02,00 say replicate("=",80)
                     SET PRINT ON
                     ??CHR(14)+CHR(15)
                     SET PRINT OFF
		     @ 03,00 say "Nome:"+space(35)+"| Telefone      |Cidade"+space(24)+"| Estado"
		     do while .not. eof()
			@ l,0 say nome + "|"+telef+"|"+cidade+"|"+estado
			l++
			skip
			if l>= 55
			   p++
			   l := 4
                           SET PRINT ON
                           ??CHR(18)+CHR(20)
                           SET PRINT OFF
			   @ 00,00 say replicate("=",80)
			   @ 01,00 say "Pagina:"+str(p,3,0)
			   @ 01,30 say "Lista de telefones:"
			   @ 01,65 say "Data:"+dtoc(date())
			   @ 02,00 say replicate("=",80)
                           SET PRINT ON
                           ??CHR(14)+CHR(15)
                           SET PRINT OFF
			   @ 03,00 say "Nome:"+space(35)+"| Telefone      |Cidade"+space(24)+"| Estado"
			endif
		     enddo
                     SET PRINT ON
                     ??CHR(18)+CHR(20)
                     SET PRINT OFF
          	     eject
		     go top
		     set console on
		     set device to screen
		otherwise             
		     break          
		endcase            
	   END
	   set console on         
	   restore screen from tela_2   
	   release tela_2, cor_1, mopc, escolha           
	   return 1 
	ELSEIF LASTKEY() = -4   
	   SET FILTER TO SELEC="S"         
	   GO TOP 
	   DO WHILE .NOT. EOF()
	      REPLACE SELEC WITH " "    
	      SKIP        
	   enddo           
	   SET FILTER TO 
	   GO TOP
	   RETURN 
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

* EOP AGENDA.PRG