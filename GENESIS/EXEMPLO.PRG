/*
  ***********************************************************************

    Sistema ..:  Exemplo de utilizacao do GENESIS
    Programa .:  Exemplo.Prg
    Autor ....:  Alexandre de Oliveira Pinto
    Data .....:  5.Abril.1993

  ***********************************************************************
*/


*-------------  Configuracao Ambiente

set date to brit
set score off
set bell off
set talk off
set deleted on
set key 303 to RelatVideo()   //  Alt_V  -> Visualiza um arquivo do disco


*-------------  Variaveis Padrao

private EstrArq := {}        , ;
        Opcao   := 0         , ;
        CodIni  := 0         , ;
        CodFim  := 0         , ;
        NomeIni := space(20) , ;
        NomeFim := space(20) , ;
        i       := 0


*-------------  Tela Principal

clear

@04,00,23,80 box repl(chr(177),9)
@00,00 say padc(" PROGRAMA EXEMPLO DE UTILIZA€ŽO DO GENESIS ",80)
@24,00 say padc(" Chips Micro-Inform tica Ltda.   Tel: (0152) 21-8763 / 21-0130",80)


*-------------  Cria Arquivos/Indices caso nao existao


if !file("Clientes.Dbf")
   EstrArq := { ;
                { "CodCli",     "N",  4, 0 } , ;
                { "Nome",       "C", 40, 0 } , ;
                { "End",        "C", 40, 0 } , ;
                { "Bairro",     "C", 25, 0 } , ;
                { "Cidade",     "C", 25, 0 } , ;
                { "Cep",        "C",  9, 0 } , ;
                { "UF",         "C",  2, 0 } , ;
                { "Tel",        "C", 15, 0 } , ;
                { "Credito",    "C",  1, 0 } , ;
                { "ValCred",    "N", 15, 2 } , ;
                { "CodAtiv",    "N",  2, 0 } , ;
              }
   dbcreate("Clientes", EstrArq)
   use
endif

if !file("Atividades.Dbf")
   EstrArq := { ;
                { "CodAti",    "N",  2, 0 } , ;
                { "Atividade", "C", 30, 0 } , ;
              }
   dbcreate("Atividades", EstrArq)
   use
endif

use "Clientes.Dbf" new

if !file("Clientes.I01")
   index on CodCli to "Clientes.I01"
endif

if !file("Clientes.I02")
   index on Nome to "Clientes.I02"
endif

use "Atividades.Dbf" new

if !file("Atividades.I01")
   index on CodAti to "Atividades.I01"
endif

if !file("Atividades.I02")
   index on Atividade to "Atividades.I02"
endif

close databases



*-------------  Menu Principal

@01,00 to 03,79

do while .t.

   @02,10 prompt " Arquivos "
   @02,25 prompt " Relat¢rios "
   @02,43 prompt " Sair "
   menu to Opcao

   if     Opcao = 1
      Arquivos()
   elseif Opcao = 2
      Relatorios()
   elseif Opcao = 3
      clear
      exit
   endif

enddo

return




*******************  Funcoes  ******************************************


function Arquivos
private Opcao := 0

   AbreJanela(03,08,06,21,"",.f.)
   @03,08 say "Â"
   @03,21 say "Â"

   do while .t.
      @04,09 prompt " Clientes   "
      @05,09 prompt " Atividades "
      menu to Opcao

      if lastkey() = 27
         exit
      elseif Opcao = 1 .or. Opcao = 2
         Cadastro()
      endif

   enddo

   FechaJanela()
return ""



function Relatorios
private Opcao := 0

   AbreJanela(03,24,06,37,"",.f.)
   @03,24 say "Â"
   @03,37 say "Â"

   do while .t.
      @04,25 prompt " Clientes   "
      @05,25 prompt " Atividades "
      menu to Opcao

      if lastkey() = 27
         exit
      elseif Opcao = 1
         Genesis("AbreClie()","Cli","Formatos")  // Chamada p/ o " Genesis "
      elseif Opcao = 2
         Genesis("AbreAtiv()","Ati","Formatos")
      endif
   enddo

   FechaJanela()
return ""



function Cadastro

   if Opcao=1
      AbreJanela(06,11,20,70," CADASTRO DE CLIENTES ")
      use "Clientes.Dbf" new
   else
      AbreJanela(09,18,14,64," CADASTRO DE ATIVIDADES ")
      use "Atividades.Dbf" new
   endif

   go top

   do while .t.

      if eof()
         append blank
      endif

      if Opcao=1
         @08,13 say "Codigo .......:" get CodCli
         @09,13 say "Nome .........:" get Nome
         @10,13 say "Endere‡o .....:" get End
         @11,13 say "Bairro .......:" get Bairro
         @12,13 say "Cidade .......:" get Cidade
         @13,13 say "Cep ..........:" get Cep
         @14,13 say "U.F ..........:" get UF
         @15,13 say "Telefone .....:" get Tel
         @16,13 say "Credito ......:" get Credito
         @17,13 say "Vlr.Credito ..:" get ValCred
         @18,13 say "Cod.Atividade :" get CodAtiv
      else
         @11,20 say "Codigo.....:" get CodAti
         @12,20 say "Descri‡„o..:" get Atividade
      endif

      read

      if lastkey()=27
         exit

      elseif lastkey()=18
         skip -1

         if bof()
            tone(500,3)
         endif

      elseif lastkey()=3 .or. lastkey()=13

         if Opcao=1

            if CodCli#0
               skip
            else
               tone(500,3)
            endif

         else

            if CodAti#0
               skip
            else
               tone(500,3)
            endif

         endif

      endif

   enddo

   FechaJanela()
   close databases
return ""




function AbreJanela
parameters li,ci,lf,cf,Titulo,Borda
private CorAtual:=setcolor()

   if pcount() < 5
      Titulo = ""
   endif

   if pcount() < 6
      Borda = .t.
   endif

   if type("NumJan")="U"
      public NumJan := 0,;
             MJan  [10],;
             PJan1 [10],;
             PJan2 [10],;
             PJan3 [10],;
             PJan4 [10]
   endif

   NumJan = NumJan + 1
   MJan  [NumJan] = savescreen(li,ci,lf+1,cf+2)
   PJan1 [NumJan] = li
   PJan2 [NumJan] = ci
   PJan3 [NumJan] = lf+1
   PJan4 [NumJan] = cf+2

   if Borda = .t.
      @li,ci to lf,cf double
   else
      @li,ci to lf,cf
   endif

   setcolor("n/w")
   @li,(cf-ci-len(Titulo))/2+ci say Titulo

   setcolor(CorAtual)
   @li+1,ci+1 clear to lf-1,cf-1

   setcolor("n+")
   @lf+1,ci+2 say repl(chr(255),cf-ci+1)

   for li=li+1 to lf
      @li,cf+1 say chr(255)+chr(255)
   next

   setcolor(CorAtual)

return ""


function FechaJanela
   restscreen(PJan1 [NumJan],;
              PJan2 [NumJan],;
              PJan3 [NumJan],;
              PJan4 [NumJan],;
              MJan  [NumJan])
   NumJan--
return ""


function RelatVideo
private Texto    := space(12),;
        CorAtual := setcolor()

   setcolor("w/n")
   AbreJanela(09,32,13,47," TEXTO ")
   @11,34 get Texto
   set cursor on
   read
   set cursor off
   FechaJanela()

   if file(Texto)
      AbreJanela(00,00,24,79,trim(Texto))
      set cursor on
      memoedit(memoread(Texto),01,01,23,78,.f.,'',250)
      set cursor off
      FechaJanela()
   endif

   setcolor(CorATual)

return ""


function FilCli

   AbreJanela(07,20,14,58," Filtro de Clientes ")

   @09,22 say "Codigo Inicial" get CodIni  pict "9999"
   @10,22 say "Codigo Final  " get CodFim  pict "9999"
   @11,22 say "Nome Inicial  " get NomeIni
   @12,22 say "Nome Final    " get NomeFim
   read

   if CodFim=0
      CodFim=9999
   endif

   if NomeFim=space(20)
      NomeFim=repl("Z",20)
   endif

   set filter to CodCli                 >= CodIni           .and. ;
                 CodCli                 <= CodFim           .and. ;
                 alltrim(left(Nome,20)) >= alltrim(NomeIni) .and. ;
                 alltrim(left(Nome,20)) <= alltrim(NomeFim)

   FechaJanela()

return ""


*******************  Funcoes p/ abertura de arquivos (Genesis) *********


function AbreClie
   use "Atividades.Dbf"  new readonly index "Atividades.I01" , ;
                                            "Atividades.I02"
   use "Clientes.Dbf"    new          index "Clientes.I01" , ;
                                            "Clientes.I02"
return ""


function AbreAtiv
   use "Atividades.Dbf"  new          index "Atividades.I01", ;
                                            "Atividades.I02"
return ""

