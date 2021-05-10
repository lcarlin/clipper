verifica tipo de relatorio
se tipo=vazio ou tecla = esc
   sai
fim se
se tipo de relatorio = tela
   numero de linha limite = 21
senao
   numero de linha limite = 55
   se impressora=nao ativa
      mensagem de erro
      sai
   fim se
   prepara saidas para a impressora
fim se
abre arquivo
se numero de dados = 0
   mensagem de erro
   sai
fim se
incializa numero de pagina
inicializa conta pagina
inicializa conta linha
faz o cabecalho
faca enquanto nao for final de arquivo
     imprime o registro na linha corrente
     adiciona 1 a conta linha
     passa p/ o proximo registro
     se conta linha > numero de linha limite
        se tipo de relatorio = impressora
           ejetar a folha
        senao
           provocar pausa no programa
           limpar a tela
        fim se
        adicionar 1 ao conta pagina
        reinicializar o conta linha
        fazer o cabecalho
     fim se
fim faca
se tipo = tela
   provocar pausa
senao
   ejetar folha
   retornar as saidas a tela
fim se
fechar arquivos
sair