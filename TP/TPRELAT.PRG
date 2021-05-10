/*
 bop tprela.prg
 funcao : impressao das tabelas de precos
 data 05-01-96
 sistema : tabela de precos
 autor : luiz antonio carlin
 linguagem clipper 5.2
*/
USE TABELA INDEX ITAB1
aMatOpc:={{10,05,"Imprimir todo o arquivo"},;
          {10,30,"Imprimir por categoria"},;
          {10,54,"Cancelar"}}
nOpcr := botao(aMatOpc,,cCorbin,cCorbat)
IF nOpcr = 0 .OR. nOpcr = 3
   close all
   RETURN
ELSEIF nOpcr = 2
   cCateg := catego()
   IF LASTKEY() = 27
      close all
      RETURN
   ENDIF
   nCatego := aScan(aCatego,cCateg)
   SET FILTER TO CODIGO = cCateg
   GO TOP
ENDIF
IF eof()
   mensagem("Nao ha dados a serem impressos!")
   close all
   RETURN
ENDIF
mensagem("Verifique a Impressora !")
IF .NOT. isprinter()
   mensagem("Impressora Nao Preparada !")
   close all
   return
ENDIF
@ 09,15 TO 11,39
@ 10,16 SAY   "Aguarde ! Imprimindo..." COLOR "W*/N"
SET CONSOLE OFF
SET DEVICE TO PRINTER
nL := 10
nP := 1
@ 00,00 SAY REPLICATE("=",80)
@ 01,00 SAY "Pagina No.: "+str(nP,3,0)
@ 01,65 SAY "Data:"+DTOC(Date())
cent_imp(2,"*=*=* M E T A   E N G E N H A R I A *=*=*")
cent_imp(3,"=============================")
cent_imp(4,"Tabela de Precos")
cTexto := if(nOpcr = 1, "Todas as Categorias","Categoria :"+aCatego[nCatego])
cent_imp(6,cTexto)
@ 08,0 say "[ Codigo  |  Descricao"+space(31)+"| UN |      Preco  ]"
@ 09,0 say "----------+--"+ replicate("-",40)+"+----+--------------"
DO WHILE .NOT. eof()
   @ nL,0 SAY "[ "
   @ nL,PCOL() SAY CODIGO
   @ nL,PCOL() SAY " |  "
   @ nL,PCOL() SAY Descricao
   @ nL,Pcol() SAY "| "
   @ nL,Pcol() SAY UN
   @ nL,Pcol() SAY " |"
   @ nL,Pcol() SAY PRECO PICT "99,999,999.99"
   @ nL,Pcol() SAY "]"
   nL++
   SKIP
   IF nL > 60
      nL = 10
      nP ++
      EJECT
      @ 00,00 SAY REPLICATE("=",80)
      @ 01,00 SAY "Pagina No.: "+str(nP,3,0)
      @ 01,65 SAY "Data:"+DTOC(Date())
      cent_imp(2,"*=*=* M E T A   E N G E N H A R I A *=*=*")
      cent_imp(3,"=============================")
      cent_imp(4,"Tabela de Precos")
      cent_imp(6,cTexto)
      @ 08,0 say "[ Codigo  |  Descricao"+space(31)+"| UN |      Preco  ]"
      @ 09,0 say "----------+--"+ replicate("-",40)+"+----+--------------"
   ENDIF
ENDDO
EJECT
SET DEVICE TO SCREEN
SET CONSOLE ON
CLOSE ALL
RETURN
* EOP TPRELAT.PRG