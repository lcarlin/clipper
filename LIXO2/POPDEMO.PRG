#include "POPMENU.CH"

PROCEDURE MAIN()
   LOCAL nOpcao := 1
   SET WRAP ON
   SET KEY -1 TO CALCULA
   DO WHILE .T.
      CLS
      SET MENU COLORS TO "g/n" ,   "W/g,b/w" , "W+/RG,bg+/r"
*     SET MENU BORDER TO
      cCor:=setcolor("r+/b")
      @ 00,00,24,79 box replicate("°",9)
      setcolor(cCor)
      @ 0,00 TO 24,79
      @ 24,27 SAY "Selecione FIM para sair "
      @ 03,16 to 05,66 double
      @ 04,18 SAY ">> Demostracao do uso da Biblioteca Popmenu <<"
      @ 00,03 OPTION " Clientes " WITH {"Inclusao ","Exclusao ","Alteracao","Consulta ",;
                                        "Includao1","Exclusao1","Alteracao1","Consulta1",;
                                        "Inclusao2","Exclusao2","Alteracao2","Consulta2"}
      @ 00,15 OPTION "Fornecedores" wITH {"Inclusao ","Consulta ","Exclusao "}
      @ 00,31 OPTION "Utilitarios" wITH {"Compacta Arquivos",;
                                         "Edita Arquivos   ",;
                                         "Diretorio        ",;
                                         "Backup           ",;
                                         "Restore          ",;
                                         "Proc. de textos  "}
      @ 00,47 OPTION "Reindexacao" WITH NIL
      @ 00,60 OPTION "Relatorios" WITH {"A Pagar     ", ;
                                        "A Receber   ",;
                                        "Fornecedores",;
                                        "Clientes    "}
      @ 00,75 option "Fim" with nil
      POPUP TO nOpcao
      @ 20,05 say "Opcao selecionada:"+str(nOpcao,3,0)
      wait "Pressione Algo..."
      if nOpcao = 61
         exit
      endif
   enddo
   CLS
RETURN

