LOCAL SCORFUNDO, SCORFRENTE
LOCAL AOPCOES :={"INCLUSAO","ALTERACAO","FERRAMENTAS","RELATORIOS"}
LOCAL AOP     :={"EMPRESAS","SETORES","OUTROS","SAIR"}
LOCAL NESCOLHA, NOPCAO, TELA
SET WRAP ON
SET CURSOR OFF
CLEAR
NESCOLHA := 1
SCORFRENTE := "W/B+"
SCORUNDOR := "RG+/R+"
DO WHILE NESCOLHA <> 5 .AND. NESCOLHA <> 0
   NESCOLHA := MENUBAR(nEscolha,1,5,SCORFRENTE,SCORFUNDO,AOPCOES)
   DO CASE
      CASE NESCOLHA == 1
           TELA := SAVESCREEN(00,00,24,74)
           NOPCAO := POPUP(3,3,SCORFRENTE,SCORFUNDO,AOP)
           @ 24,10 SAY "Voce selecionou a opcao -->"+aop[NOPCAO]
           INKEY(2)
           RESTSCREEN(0,00,24,79,TELA)
      CASE NESCOLHA == 2
           ALERT("Voce poderia incluir a sua funcao de ALTERACAO aqui !",{"Pressione algo"})
      CASE NESCOLHA == 3
           ALERT("Voce poderia incluir a sua funcao de FERRAMENTA aqui !",{"Pressione algo"})
      CASE NESCOLHA == 4
           ALERT("Voce poderia incluir a sua funcao de RELATORIO aqui !",{"Pressione algo"})
      CASE NESCOLHA == -1
           ALERT("Nao existe mouse ou mouse Driver instalado")
           EXIT
   ENDCASE
ENDDO
SET CURSOR ON
CLEAR
RETURN(NIL)