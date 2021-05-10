/*
   BOP NETUDFS.PRG
   FUNCOES DE ABERTURA DE ARQUIVOS EM REDE
   ROUBADA DA BIBLIOTECA TILEY.LIB
   DATA    10-02-96
   HACKER  LAC
   LIVRO CLIPPER 5.2 PGS 358..360
   LINGUAGEM CLIPPER 5.2
*/
#include "common.ch"
#include "inkey.ch"

/* 
   UseFile
   Parametros :
   1 - NOme do Arquivo (entre aspas)
   2 - Modo : (.T. = Exclusivo .F. = COMPARTILHADO)
   3 - Nome da RDD (ENTRE ASPAS)
   SEMPRE ABRE ARQUIVO EM UMA NOVA AREA DE TRABALHO
   Usefile("Cust",.T.,"DBFNTX")
*/
function USEFILE(cDataFile, lUseMode, cRdd)

   local Local1, Local2
   Local1:= 5
   Local2:= .F.
   do while (.T.)
      dbUseArea(.T., cRdd, cDataFile, Nil, lUseMode)
      if (!neterr())
         Local2:= .T.
         exit
      endif
      if (Local1 > 0)
         InKey(1)
         Local1--
         loop
      elseif (lockwin(procname(), cDataFile))
         Local1:= 5
         loop
      else
         exit
      endif
   enddo
   return Local2

/*
  APND
  tenta Criar novo registro e opcionalmente libera todos bloqueados
  parametro := Modo (opcional) .T. = lIbera .F. Nao libera
  DEFAULT = .F.
*/
********************************
function APND(lRelease)

   local nDelay, lRetval
   nDelay:= 5
   lRetval:= .F.
   default lRelease to .T.
   do while (.T.)
      dbAppend(lRelease)
      if (!neterr())
         lRetval:= .T.
         exit
      endif
      if (nDelay > 0)
         InKey(1)
         nDelay--
         loop
      elseif (lockwin(procname(), alias()))
         nDelay:= 5
         loop
      else
         exit
      endif
   enddo
   return lRetval

/*
   RLOK
   BLOQUEIA UM REGISTRO
   PARAMETROS  xIdentity = Identificador de um registro exclusivo pra
   especificar um registro a ser bloqueado. Se for Omitido, o registro
   corrente sera incluido na lista de bloqueios
*/

********************************
function RLOK(xIdentity)

   local nDelay, lRetVal
   nDelay:= 5
   lRetVal:= .F.
   do while (.T.)
      if (ISNIL(xIdentity))
         if (dbrlock())
            lRetVal:= .T.
            exit
         endif
      elseif (dbrlock(xIdentity))
         lRetVal:= .T.
         exit
      endif
      if (nDelay > 0)
         InKey(1)
         nDelay--
         loop
      elseif (lockwin(procname(), alias))
         nDelay:= 5
         loop
      else
         exit
      endif
   enddo
   return lRetVal

********************************
procedure FLOK

   local nDelay
   nDelay:= 5
   lRetVal:= .F.
   do while (.T.)
      if (FLock())
         lRetVal:= .T.
         return
      endif
      if (nDelay > 0)
         InKey(1)
         nDelay--
         loop
      elseif (lockwin(procname(), alias))
         nDelay:= 5
         loop
      else
         return
      endif
   enddo

********************************
static function LOCKWIN(cProc, cDataFile)

   local nChoice, lCursor, lRetVal
   lRetVal:= .F.
   winshade(8, 15, 20, 65, "ON")
   do case
   case cProc == "UseFile"
      aMensa := {"                                            ",;
                 "Arquivo de dados: " + cDataFile,;
                 "Este Arquivo Nao Esta Disponivel no momento.",;
                 "Deseja Continuar Tentando Abri-lo",;
                 "Por Mais Cinco Segundos ?"}
   case cProc == "APND"
      aMensa := {"Nao Houve Exito na Cria‡„o de Novo registro.",;
                 "Deseja Continuar Tentado Inclui-lo",;
                 "Por mais Cinco Segundos ?",;
                 "Arquivo de dados: " +cDataFile}
   case cProc == "RLOK"
      aMensa := {"Nao Houver Exito no Bloqueio de Registro.",;
                 "Deseja Continuar Tentando Bloquea-lo",;
                 "Por Mais Cinco Segundos ?",;
                 "Arquivo de dados: " + cDataFile}
   case cProc == "FLOK"
      aMensa := {"N„o Houve Exito no Bloqueio do Arquivo.", ;
                 "Deseja continuar Tentando Bloquea-lo",;
                 "Por mais Cinco Segundos?",;
                  "Arquivo de dados: " + cDataFile}
   endcase
   nRetVal := Confirma(aMensa)
   return lRetVal

*  EOP NETUDFS.PRG