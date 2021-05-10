/*
 bop CNRELAT.prg
 funcao : impressao das DADOS DE CLIENTES
 data 07-02-96
 sistema : CONTROLE DE NOTAS
 autor : luiz antonio carlin
 linguagem clipper 5.2
*/
USE CNBCLI INDEX CNICLI2 , CNICLI1
aMatOpc:={{10,05,"Imprimir todo o arquivo"},;
          {10,32,"Imprimir por Nome"},;
          {10,54,"Cancelar"}}
nOpcr := botao(aMatOpc,,cCorbin,cCorbat)
IF nOpcr = 0 .OR. nOpcr = 3
   close all
   RETURN
ELSEIF nOpcr = 2
   cFiltro := space(40)
   @ 12,05 SAY "Digite o Nome..:" GET cFiltro PICTURE "@!"
   READ
   IF LASTKEY() = 27 .OR. empty(cFiltro)
      close all
      RETURN
   ENDIF
   SET FILTER TO NOME = cFiltro
   GO TOP
ENDIF
IF eof()
   mensagem("N„o h  dados para serem impressos!")
   close all
   RETURN
ENDIF
mensagem("Verifique a Impressora !")
IF .NOT. isprinter()
   mensagem("Impressora N„o Preparada !")
   close all
   return
ENDIF
@ 09,15 TO 11,39
@ 10,16 SAY   "Aguarde ! Imprimindo..." COLOR "W*/N"
SET CONSOLE OFF
SET DEVICE TO PRINTER
nL := 07
nP := 1
@ 00,00 SAY REPLICATE("=",80)
@ 01,00 SAY "Pagina No.: "+str(nP,3,0)
@ 01,00 SAY "Pagina No.: "+str(nP,3,0)
@ 01,65 SAY "Data:"+DTOC(Date())
@ 01,65 SAY "Data:"+DTOC(Date())
cent_imp(2,"Tec Maq Informatica Ltda - Fone : (0143) 51-1728 - Piraju - SP")
cent_imp(3,"Relat¢rio de Clientes")
cTexto := if(nOpcr = 1, "Todos os Clientes","Clientes :"+cFiltro)
cent_imp(4,cTexto)
@ 05,00 SAY replicate("=",80)
@ 06,00 SAY "|Codigo|Nome"+space(36)+"|Endereco"+space(32)+"|Telefone"+space(12)+"|"
DO WHILE .NOT. eof()
   @ nL,0 SAY "|"+CODIGO+"|"+NOME+"|"+ENDERECO+"|"+TELEFONE+"|"
   nL++
   SKIP
   IF nL > 60
      nL = 10
      nP ++
      EJECT
      @ 00,00 SAY REPLICATE("=",80)
      @ 01,00 SAY "Pagina No.: "+str(nP,3,0)
      @ 01,00 SAY "Pagina No.: "+str(nP,3,0)
      @ 01,65 SAY "Data:"+DTOC(Date())
      @ 01,65 SAY "Data:"+DTOC(Date())
      cent_imp(2,"Tec Maq Informatica Ltda - Fone : (0143) 51-1728 - Piraju - SP")
      cent_imp(3,"Relat¢rio de Clientes")
      cTexto := if(nOpcr = 1, "Todos os Clientes","Clientes :"+cFiltro)
      cent_imp(4,cTexto)
      @ 05,00 SAY replicate("=",80)
      @ 06,00 SAY "|Codigo|Nome"+space(36)+"|Endereco"+space(32)+"|Telefone"+space(12)+"|"
   ENDIF
ENDDO
EJECT
SET DEVICE TO SCREEN
SET CONSOLE ON
CLOSE ALL
RETURN
* EOP CNRELAT.PRG
