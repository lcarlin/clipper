OPC40=1
sombra(05,30,21,54)
centracl(05,30,54,"Gerais")
aGera00 := array(05,04)
aGera00 := {{06,31,"Cadastra Usuarios    ","Cadastra Usuarios Novos"},;
            {08,31,"Cores do Sistema     ","Modifica todas as cores do sistema"},;
            {10,31,"Reindexa Arquivos    ","Reindexa todos os ¡ndices de todos os arquivos"},;
            {12,31,"Backup               ","C¢pia de seguran‡a de todos os arquivos"},;
            {14,31,"Restore              ","Restaura copia de seguran‡a"},;
            {16,31,"Compacta             ","Elemina Registros Deletados dos arquivos"},;
            {18,31,"Limpa Registros      ","Elemina Registros at‚ a data informada"},;
            {20,31,"Menu Anterior        "}}
 
SAVE SCREEN TO TELAESTO
DO WHILE .T.
   RESTORE SCREEN FROM TELAESTO
   opc40 := botao(aGera00,,cCorBin,cCorBat)
   DO CASE
      CASE OPC40=1
           DO CADUSU
      CASE OPC40=2
           centra(24,"")
           cores()
           lAtlCor := .t.
           RESTORE FROM CORES ADDITIVE
           cCorpadra:= cCorTmpa   //   := "w+ /n  ,n  /w  ,n,n,gr+/n  "
           cCormenu := cCorTmme   //   := "n  /w  ,w+ /b  ,n,n,w+ /b  "
           cCortela := cCorTmte   //   := "b  /bg "
           cCorbotao:= cCorTmbo   //   := "w+ /r  ,n  /g  ,n,n,w+ /r  "
           cCorregua:= cCorTmre   //   := "w+ /bg "
           cCorlayou:= cCorTmla   //   := "w+ /b  "
           cCorcaixa:= cCorTmca   //   := "w+ /bg "
 
           cCorTitulo := substr(cCorPadra,21,7)
           cCorSubMenu:= substr(cCorMenu ,9,7)
           cCorBat    := substr(cCorBotao,9,7)
           cCorBat2   := substr(cCorBotao,21,7)
           cCorBin    := substr(cCorBotao,1,7)
           cCorServ   := substr(cCorMenu ,21,7)
           cCorTitul2 := SubStr(cCorRegua,01,7)
           cCorjanela := substr(cCorMenu ,09,7)+","+ substr(cCorPadra,9,7)
      CASE OPC40=3
           DO INDEXA
      CASE OPC40=4
           DO utibecape
      CASE OPC40=5
           DO utirestau
      CASE OPC40=6
           DO conp001
      CASE OPC40=7
           DO limp001
      CASE OPC40 = 8
           RESTORE SCREEN FROM TELAESTO
           RETURN
   ENDCASE
ENDDO
