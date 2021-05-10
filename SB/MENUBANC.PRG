opc10 := 0
aBanc00:= {{08,31,"Arquivos     ",""},;
          {10,31,"Relatorios   ",""},;
          {12,31,"Consultas    ",""},;
          {14,31,"Menu Anterior",""}}
sombra(07,30,15,45)
@ 07,35 Say "Banco"
SAVE SCREEN TO BANC
DO WHILE .T.
   RESTORE SCREEN FROM BANC
   Opc10 := botao(aBanc00,,cCorBin,cCorBat)
   DO CASE
      CASE OPC10=1
           DO BANC1
      CASE OPC10=2
           DO BANC2
      CASE OPC10=3
           DO BANC3
      OTHERWISE
           restore screen from banc
           RETURN
   ENDCASE
ENDDO
 
*************************************************************
PROCEDURE BANC1
aBanc1:={{03,51,"Cheques emitidos   ","Emite, consulta, exclui cheque emitidos" },;
         {05,51,"Cr‚ditos           ","Cadastra, consulta, exclui cr‚ditos"     },;
         {07,51,"D‚bitos            ","Cadastra, consulta, exclui d‚bitos"      },;
         {09,51,"Dep¢sito           ","Cadastra, consulta, exclui dep¢sitos"    },;
         {11,51,"Cadastro banc rio  ","Cadastra, consulta, exclui bancos"       },;
         {13,51,"Duplicatas         ","Cadastra, consulta, exclui duplicatas"   },;
         {15,51,"Cheques pr‚-datados","Cadastra, consulta, exclui pr‚-datados"  },;
         {17,51,"Consulta N. Fiscais","Consulta, exclui notas f¡scais"          },;
         {19,51,"Cadastra N. Fiscais","Cadastra Notas Fiscais"                  },;
         {21,51,"Menu Anterior      ","Retorna Para o Menu Banco"               }}
         sombra(02,50,22,71)
@ 02,55 SAY "Arquivos"
SAVE SCREEN TO TELA01
DO WHILE .T.
   RESTORE SCREEN FROM TELA01
   opc1 := botao(aBanc1,,cCorBin,cCorBat)
      DO CASE
         CASE OPC1=1
              do banc000
         CASE OPC1=2
              do banc001
         CASE OPC1=3
              do banc002
         CASE OPC1=4
              do banc018
         CASE OPC1=5
              do banc003
         CASE OPC1=6
              do banc004
         CASE OPC1=7
              do banc005
         CASE OPC1=8
              do banc006
         CASE OPC1=9
              do banc019
         CASE OPC1=10
              RETURN
   ENDCASE
ENDDO
 
**************************************************************
PROCEDURE BANC2
aBanc2 :={{05,51,"C¢pia de cheque    ","Emite c¢pia de cheque"                    },;
         {07,51,"Cr‚ditos           ","Relat¢rio de todos os cr‚ditos"           },;
         {09,51,"D‚bitos            ","Relat¢rio de todos os d‚bitos"            },;
         {11,51,"Dep¢sitos          ","Relat¢rio de todos os dep¢sitos"          },;
         {13,51,"Duplicatas         ","Relat¢rio de todas as duplicatas a pagar" },;
         {15,51,"Cheques pr‚-datados","Relat¢rio de todos os cheque pr‚-datados" },;
         {17,51,"L¡vro caixa        ","Gera livro caixa di rio"                  },;
         {19,51,"Previs„o movimento ","Gera previs„o de movimento futuros"       },;
         {21,51,"Menu Anterior      ","Retorna Para o Menu de Bancos"}}
sombra(04,50,22,71)
@ 04,56 SAY "Relatorios"
SAVE SCREEN TO TELA03
DO WHILE .T.
   RESTORE SCREEN FROM TELA03
   opc2 := botao(aBanc2,,cCorBin,cCorBat)
   DO CASE
      CASE OPC2=9
           RETURN
      CASE OPC2=1
           do banc007
      CASE OPC2=2
           do banc009
      CASE OPC2=3
           do banc008
      CASE OPC2=4
           do banc017
      CASE OPC2=5
           do banc010
      CASE OPC2=6
           do banc011
      CASE OPC2=7
           do banc013
      CASE OPC2=8
           do banc014
   ENDCASE
ENDDO
 
*************************************************
PROCEDURE BANC3
aBanc3:={{07,51,"Cheques devolvidos","Arqu¡vo de cheques devolvidos"            },;
         {09,51,"Saldo banc rio    ","Emite saldo real e banc rio de uma conta" },;
         {11,51,"Menu Anterior     ","Retorna Para o Menu de Cheques"}}
sombra(06,50,12,70)
@ 06,57 SAY "Consultas"
SAVE SCREEN TO TELA03
DO WHILE .T.
   RESTORE SCREEN FROM TELA03
   opc3 := botao(aBanc3,,cCorBin,cCorBat)
   DO CASE
      CASE OPC3=3
           RETURN
      CASE OPC3=1
           do banc015
      CASE OPC3=2
           do banc016
   ENDCASE
ENDDO
