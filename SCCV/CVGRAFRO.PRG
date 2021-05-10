***************************************************************************
* Arquivo: CVGRFRO.PRG        
* 07/01/94
* Grafico de PIZZA
* Arquivo de dados   : CVVCAR.DBF
* Arquivo indice     : CVIGRA1.NTX
***************************************************************************


* Declaracao das variaveis
CLOSE ALL
* Declaracao das variaveis
private cAreaUsu        && area do usuario.
private cFiltUsu        && filtro do usuario.
private nReg            && numero de registros 
private nposY
private i               && contador generico
private acTt[2]         && Titulo e subtitulo do grafico  
private nCorTt, nFontTt && atributos de titulo
private nCorId, nFonId  && atributos de identificadores
private nCorFun, nCorConF && cor de fundo e contorno da janela
private nCTR              && controladora ativa
private aux
declare aParCTR[1]        && vetor de inicializacao da controladora

* Inicializacao das variaveis

* Inicia titulos
acTt[1] = "Fiat - Fralleti Ltda. Piraju SP"
acTt[2] = "Grafico de Venda Mensal de Veiculos"

aParCTR[1] = 0

* Abertura do banco de dados
M->cAreaUsu = select()             && Salva a area de trabalho do usuario.
select 0                           && proxima area livre
use CVVCAR.DBF 
index on descar to cvigrac1
set index to CVIGRAC1.NTX       && Abre arquivo de indice

* Conta o numero de registros visiveis no arquivo de dados.
count to nReg
go top

if M->nReg == 0
  gip_erro(1)

  use                               && Fecha a area de dados do grafico.
  if M->cAreaUsu <> 0
    select (M->cAreaUsu)            && Ativa a area do usuario.
  endif
return
endif

* Inicia a CLBC
M->nCTR = bc_cplaca()
bc_inic(1.000000000000000000000000000000000000000000000000000000000000000000000, 0)
M->aux = bc_inictr(M->nCTR, aParCTR) && Ativa controladora
if M->aux = 0             && nao conseguiu ativar...
  M->nCTR = 11            && ativa contr. default    
endif

* Constroi os vetores de dados (anValor), de identificadores (acIden),
* de destaque (anDest).
declare anValor[M->nReg]  && Vetor com os valores numericos das fatias.
declare acId[M->nReg]     && Vetor com os identificadores das fatias.
declare anDest[M->nReg]   && Vetor que informa se a fatia sera destacada ou nao.
private nFatDes        && Posicao da fatia de destaque no vetor.
M->nFatDes = 1

M->i = 1
do while .not. EOF()            && Percorre os registros do arquivo DBF.
* le o valor da fatia
  anValor[M->i] = QUANTV
* le o identificador
  acId[M->i] = alltrim(DESCAR)
  anDest[M->i] = 0
  * Atualiza fatia de destaque 
  if anValor[M->i] > anValor[M->nFatDes]
    M->nFatDes = M->i
  endif
  M->i=M->i+1
  skip
enddo                           && Terminou o DBF.
anDest[M->nFatDes] = 1

private anVetCor[16]
anVetCor[1] = 0
anVetCor[2] = 1
anVetCor[3] = 2
anVetCor[4] = 3
anVetCor[5] = 4
anVetCor[6] = 5
anVetCor[7] = 6
anVetCor[8] = 7
anVetCor[9] = 8
anVetCor[10] = 9
anVetCor[11] = 10
anVetCor[12] = 11
anVetCor[13] = 12
anVetCor[14] = 13
anVetCor[15] = 14
anVetCor[16] = 15

* Constroi o vetor de cores anCorFat.
private anCorFat[M->nReg]
for M->i=1 to M->nReg
    anCorFat[M->i] = gip_lcor(anVetCor[(((M->i)-1)%16)+1])
next M->i


* Constroi o vetor de padroes de preenchimento anPPFat.
private anPPFat[M->nReg]
gip_pad(anPPFat, M->nReg)     && chama funcao do gip


* Definicao e ajuste de cores, conforme modo grafico
M->nCorTt   = gip_lcor(10)
M->nCorId   = gip_lcor(12)
M->nCorConF = gip_lcor(7)
M->nCorConP = gip_lcor(0)
if bc_cncor() < 16
  M->nCorFun  = 0
else
  M->nCorFun = 1
endif


* Carrega fontes de caracteres necessarios
M->nFonTt = bc_fontem("8X8.BCM")
M->nFonId = M->nFonTt
bc_gdabja(1.000000000000000000000000000000000000000000000000000000000000000000000)
bc_gdtitu(M->nCorTt, 0.0125, 0.0400, 0.0000, M->nFonTt)
bc_gdiden(M->nCorId, 0.0125, 0.0400, 0.0000, M->nFonId)
bc_gabjan(0.0, 0.0, 1.0, 1.0, M->nCorConF, M->nCorFun)
bc_gpizza(acTt, M->nReg, anValor, acId, anDest, anPPFat, anCorFat, M->nCorConP)
inkey(0)
bc_libfm(M->nFonTt)
bc_gfejan()
bc_fim(0)          && Volta ao modo alfanumerico.

  use                               && Fecha a area de dados do grafico.
  if M->cAreaUsu <> 0
    select (M->cAreaUsu)            && Ativa a area do usuario.
  endif
