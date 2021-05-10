#include "inkey.ch"
STATIC nColunaDos
STATIC nLInhaDos
STATIC sTelaDos
PUBLIC cNivel, vquem, identifica, nNivel
 
/*
public cod_ret   := 0            // Codigo de retorno da funcao hlleprot
 
*
***  O Codigo abaixo faz a verifica‡„o da prote‡„o
*
cod_ret := hlleprot( "FLYSOFT",;           // Nome cadastrado no HPROT.EXE - opcao Define
                     "PIRATA",;            // Chave de prote‡„o cadastrada no HPROT
                     "",;                  // Diret¢rio da onde est  a prote‡„o da aplicacao
                     1,;                   // Atualizar controle se for copia com limites
                     1 )                   // Controlar Licen‡as de uso em rede nesta chamada
?
? str(cod_ret) + " - " + hlmsgerr( )
?
 
*
***  Neste ponto voce dever  testar o resultado e poder  enviar a
***  sua mensagem de erro, e cancelar o programa, se for o caso
*
if cod_ret <> 0
   if cod_ret = 9
      ? "Programa n„o Instalado ou prote‡„o n„o localizada"
      ?
   endif
   return
endif
 
  *
  ***  Neste ponto a sua Aplica‡„o poder  continuar normalmente.
  ***  As fun‡”es abaixo podem ser usadas para obter do HandProt
  ***  alguns dados como : nome do usuario e nro de serie da copia
  *
  ? "Nome Usuario        : " + hlusuario ( )
  ? "Numero de Serie     : " + hlnumserie( )
  ? "Execucoes Restantes : " + str( hlexecs( ) )
  ? "Dias Restantes      : " + str( hldias( ) )
  ? "Numero de Licencas  : " + str( hlmaxrede() )
  ? "Dir. de Instalacao  : " + hldirinst()
 
  ?
  ? " Execucao Normal da Aplicacao "
  ?
inkey(5)
*/
 
SELECT 1
IF FILE("SEMAFARO.DBF")
   IF NETUSE("SEMAFARO",.F.,10)
      IF .NOT. FILE("SEMAFARO.NTX")
         INDEX ON BANCODADOS TO SEMAFARO
      ELSE
         SET INDEX TO SEMAFARO
      ENDIF
   ELSE
      MENSAGEMT("ARQUIVO DE CONTROLE DOS DADOS NAO DISPONIVEL")
      return
   ENDIF
else
   Mensagem({"Arquivo de controle dos dados n„o encontrado" ,;
              "Imposs¡vel acesso ao sistema" })
   RETURN
endif
 
 
SELECT 2
IF FILE("CONSEN.DBF")
   IF NETUSE("CONSEN",.F.,10)
      IF .NOT. FILE("OPER_A.NTX")
         INDEX ON CODOP                  TO OPER_A
      ELSE
         SET INDEX TO OPER_A
      ENDIF
   ELSE
      MENSAGEMT("ARQUIVO DE SENHAS NAO DISPONIVEL")
      return
   ENDIF
else
   Mensagem({"Arquivo de controle dos dados n„o encontrado" ,;
              "Imposs¡vel acesso ao sistema" })
   RETURN
endif
 
nColunaDos := col()
nLInhaDos  := row()
sTelaDos := savescreen(00,00,maxrow(),maxcol())
SETCOLOR("g")
CLS
SETBLINK(.T.)
CENTRA(00,"ÚÄÄ¿  ÚÄÂÄ¿            ÚÄÂÄ¿                  ")
CENTRA(01,"³       ³                ³                    ")
CENTRA(02,"ÀÄÄ¿ÂÚÄ¿³ÚÄ¿ÚÄÂÄ¿ÚÄ¿     ³ÚÄ¿ÚÄ¿   ÚÄÂÄ¿ÚÄ¿ÚÄ¿")
CENTRA(03,"³  ³³ÀÄ¿³ÃÄÙ³ ³ ³ÚÄ´     ³ÃÄÙ³   Ä ³ ³ ³ÚÄ´³ ³")
CENTRA(04,"ÀÄÄÙÁÀÄÙÁÀÄÙÁ Á ÁÀÄÙ     ÁÀÄÙÀÄÙ   Á Á ÁÀÄÙÀÄ´")
CENTRA(05,"                                             Ù")
CENTRA(06,"Sistema de Controle Bancario V1.0",'G*')
 
setcolor("g+")
 
CENTRA(08, [(A) Desenvolvido  TEC MAQ INFORMATICA ] )
CENTRA(10,'Rua Treze de Maio, n§ 881 - Piraju - S„o Paulo - Fone (014) 351-1728')
CENTRA(12,'CGC/MF n§ 56.660.591/0001-15  Inc. Estadual n§ 537.010.714.112')
 
CENTRA(14,'Diretor Geral : Nelson Abrantes')
CENTRA(15,'Diretor Comercial : Antonio Waldemir Leme')
CENTRA(16,'Diretor de Vendas : Flavio Luiz Marin')
CENTRA(17,'Programador Analista : Luiz Antonio Carlin')
 
ACESSO=1
SAI = ' '
IDENTIFICA = SPACE(3)
DO WHILE SAI <> "N"
   @ 20,15 SAY space(30)
   @ 21,15 SAY space(30)
   @ 20,15 SAY "Operador.: " GET IDENTIFICA
   READ
   IF UPPER(IDENTIFICA)="FIM"
      EXIT
   ENDIF
   num=0
   SET Conso OFF
   @ 21,15 SAY 'SENHA:.... '
   cSenha=senha(21,col()+1)
   PASSWORD := esconde(cSenha)
   SEEK IDENTIFICA
   IF EOF()
      IF ACESSO <=3
         mensagemt("Operador n„o cadastrado! Digite novamente")
         ACESSO++
         LOOP
      ELSE
         Mensagemt("O Numero de tentativas excedeu trez vezes. Acesso negado!")
         EXIT
      ENDIF
   ELSE
      IF CODSEN=password
         //ALTDATA()
         COR=SETCOLOR()
         SETCOLOR("W/N")
         MensagemT([Ok! ]+QUEM+[ Senha Aprovada...])
         vquem = quem
         cNivel := decripto(NIVEL)
         nNivel := val(cNivel)
         SETCOLOR(COR)
         CLOSE ALL
         SAI = "N"
         MENU001 ()
         EXIT
      ELSE
        IF ACESSO <=3
           Mensagemt("Senha N„o Compativel Com o Operador.")
           ACESSO++
           LOOP
        ELSE
           Mensagemt("O Numero de tentativas excedeu trez vezes. Acesso negado !!")
           EXIT
        ENDIF
      ENDIF
   ENDIF
ENDDO
RESTSCREEN(00,00,maxrow(),maxcol(),StELAdOS)
setpos(nLinhaDos,nColunaDos)
* EOP MENU.PRG
