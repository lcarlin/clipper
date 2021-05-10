seleciona a area 1
abre arq. de clientes

seleciona a area 2
abre arq. de produtos

seleciona a area 3
abre arq. de vendas

inicializa variavel de continuacao

faca enquanto variavel de continuacao = condicao
     limpa a tela
     contruir a nova tela
     incializa variavel de codigo
     aceita codigo do produto
     se codigo=vazio  .ou. tecla = esc
        sai
     fim se
     seleciona arq. 2
     procura codigo
     se nao encontrar
        mensagem de erro
        retorna
     fim se
     carrega dados do produto (nome quantidade valor unitario qtd min)
     apresenta dados na tela
     verifica se e produto desejado
     se nao for
        retorna
     fim se
     aceita codigo do cliente
     se codigo=vazio  .ou. tecla = esc
        sai
     fim se
     seleciona arq. 1
     procura codigo
     se nao encontrar
        mensagem de erro
        retorna
     fim se
     carrega dados do cliente (nome )
     apresenta dados  na tela
     verifica se o cliente e desejado
     se nao for
        retorna
     fim se
     inicializa quantidade
     aceita quantidade vendida
     se quantidade > (qtd. estoque - qtd min)
        mensagem de erro
        retorna
     endif
     verificar se os dados estao corretos
     se nao estiver
        retorna
     fim se
     seleciona arq 3
     cria novo registro
     grava dados do cliente (nome, codigo)
     grava dados do produto (nome , codigo)
     grava dados da compra (quantidade , valor, data, etc...)
     aceita variavel de continuacao
fim faca