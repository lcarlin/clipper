/*
bop instala.prg
data 16/06/95
funcao instalacao do sistema de estoque
 autor luiz antonio carlin
linguagem  turbo c++ 1.0
*/
IF PCOUNT()=0
   ?
   ?"Sintaxe : INSTALA [DRIVE-ORIGEM]"
   ?"Ex.: Instala A:"
   ?
   quit
endif
IF PCOUNT() = 1
   PARAMETERS _ORIGEM
ENDIF
if PCOUNT() = 2
   PARAMETERS _ORIGEM, tipo
ELSE
   TIPO = " "
ENDIF
_OR =  ALLTRIM(UPPER(_ORIGEM))
IF _OR != "A:" .AND. _OR != "B:"
   ?
   ? "Unidade Invalida"
   ?
   quit
endif
IF .NOT. EMPTY(TIPO)
   IF UPPER(tipo) = "/DESINSTALA"
      TESTE = "[O Corsario]"
      if .not. MEMOWRIT("TEST_DISK.CS",TESTE)
         ?
         ? "Disco protegido conta Gravacao! Desproteja-o e repita a operacao"
         ?
         QUIT
      endif
      DELE FILE TEST_DISK.CS
      dentro = MEMOREAD("C:\_CONTROL.LOG")
      IF .not. empty(dentro)
         ?
         ?"Aguarde!! Desinstalando o Sistema"
         ?
         DELETE FILE C:\_CONTROL.LOG
         IF FILE("C:\CE\*.*")
            NUMERO_D = ADIR("C:\CE\*.*")
            DECLARE ARQUIVO[NUMERO_D]
            ADIR("C:\CE\*.*",ARQUIVO)
            FOR I = 1 TO numero_d
                APAGA = "C:\CE\"+ARQUIVO[I]
                DELETE FILE &APAGA
            NEXT
            ! cd c:\
            ! rd c:\ce
            IF FILE("INSTALA.CFG")
               DELETE FILE INSTALA.CFG
            ENDIF
         ENDIF
         ?
         ?"Sistema Desinstalado"
         ?
         quit
      ELSE
         ?
         ?"Sistema nao Instalado!!! Desinstalacao impossivel de ser executada"
         ?
         quit
      ENDIF
   ELSE
      ?
      ?"Parametro Invalido"
      ?
      QUIT
   ENDIF
ENDIF
TESTE = "[O Corsario]"
if .not. MEMOWRIT("TEST_DISK.CS",TESTE)
   ?
   ? "Disco protegido conta Gravacao! Desproteja-o e repita a operacao"
   ?
   QUIT
endif
DELE FILE TEST_DISK.CS
IF DISKSPACE(3) < 747520
   ? "Espaco insuficiente no disco rigido!! tente remover alguns "
   ? "arquivos e execute a instalacao novamente!!"
   quit
endif
IF .NOT. FILE("INSTALA.CFG")
   !VOL C: > INSTALA.CFG
ENDIF
!VOL C: > INSTALA.TMP
CONTEUDO = MEMOREAD("INSTALA.CFG")
CONTEUDO2 = MEMOREAD("INSTALA.TMP")
DELETE FILE INSTALA.TMP
IF CONTEUDO <> CONTEUDO2
   ?
   ?"Instalacao ja foi executada. "
   ?"Entre em contato com Seu distribuido para legalizar mais copia"
   ?
   quit
endif
CONTEUDO3 = "CS # 1995 Controle de Estoque v1.0 - L.A.C. - {O Corsario(tm)}"
?
?"Aguarde!! Expandindo Arquivos"
?
?
?
EXPANDE =_ORIGEM+"_CE.EXE"
!MD C:\CE
!CD C:\CE
!C:
! &EXPANDE
NUMERO = FCREATE("C:\_CONTROL.LOG",2)
FWRITE(NUMERO,CONTEUDO3)
?
?"Sistema Instalado! Para entrar Digite CE<ENTER>"
?
QUIT

* eop instala.prg
