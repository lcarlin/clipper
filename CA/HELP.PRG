
procedure help (prog, lin, var)

save screen to tela_hlp
COR_HLP := SETCOLOR("gr+/b")
CURSOR := SETCURSOR(0)
prog:=lower(prog)
prg:=substr(prog,1,2)
BEGIN SEQUENCE
      if prg<>"ca"
         arquivo :="cahelp.hlp"
      else        
         arquivo=""+prog+".hlp"
      endif
      arquivo := upper(arquivo)
      if .not. file(arquivo)
         mensagem("Ajuda Nao esta Disponivel")
         BREAK
      endif
      var_hlp1 := memoread(arquivo)
      var_hlp := {}
      sombra(11,07,13,35)
      @ 12,08 say "Aguarde! Pesquisando Ajuda." COLOR "r*/w"
      FOR in_hlp :=1 to mlcount(var_hlp1,39)
          aadd(var_hlp,memoline(var_hlp1,39,in_hlp))
      next
      var := "# "+prog+" "+lower(var)
      posicao := 0
      acha := .t.
      nPosicao1 := 0
      nPosicao2 := 0
      nPosicao1 := ascan(var_hlp,var)
      IF nPosicao1 = 0
         mensagem("Ajuda nao esta disponivel")
         break
      endif
      nPOsicao2 := aScan(var_hlp,"# fim",nPosicao1)
      IF nPosicao2 = 0
         mensagem("Ajuda nao esta disponivel")
         break
      endif
      socorro :=""
      FOR ind2 := nPosicao1+1 TO nPosicao2 -1
          socorro+=var_hlp[ind2]
      next
      sombra(10,03,20,44)
      @ 10,16 say " Ajuda "
      @ 20,10 say "<ESC> - Retorna"
      set key 28 to
      set color to w/n
      ajuda := memoedit(socorro,11,04,19,43,.f.,,39,0)
END

SETCURSOR(CURSOR)
setcolor(cor_hlp)
restore screen from tela_hlp
set key 28 to help
RETURN