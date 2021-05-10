#include "common.ch"
#include "inkey.ch"

********************************

   parameters ntipo_inc
   save screen to stela_agd1
   if (ntipo_inc == 1)
      select 5
      use CEBFOR index ceifor
      cpessoa:= "Fornecedor"
      ctipo:= "D"
      ctipod:= "Pagamento  "
   else
      select 5
      use CEBCLI index ceicli
      cpessoa:= "Cliente   "
      ctipo:= "C"
      ctipod:= "Recebimento"
   endif
   select 6
   use CEBAGEN index CEIAGEN
   fim:= .T.
   sombra(7, 7, 12, 69)
   @  7, 20 say "Inclusao da Agenda de " + ctipod
   @  8,  8 say "Codigo.............:"
   @  9,  8 say cpessoa + ".........:"
   @ 10,  8 say "Valor..............:"
   @ 11,  8 say "Data do " + ctipod + ":"
   save screen to stela_agd
   corcli:= SetColor()
   do while (fim)
      select 5
      restore screen from stela_agd
      ccodigo:= Space(6)
      cempresa:= Space(40)
      ddata:= CToD("  /  /  ")
      nvalor:= 0
      @  8, 29 get cCodigo picture "@!"
      read
      if (Empty(ccodigo) .AND. LastKey() = K_ENTER)
         nproc:= tabela()
         if (Empty(nproc))
            loop
         endif
         ccodigo:= codigo
         @  8, 29 get cCodigo picture "@!"
         clear gets
      elseif (Empty(ccodigo) .AND. LastKey() = K_ESC)
         exit
      endif
      set color to (corcli)
      seek ccodigo
      if (!Found())
         mensagem(cpessoa + " nao cadastrado")
         loop
      endif
      cnome:= nome
      @  9, 29 get cNome
      clear gets
      @ 10, 29 get nValor picture "999,999.99"
      @ 11, 29 get dData picture "99/99/99" valid dia_util(ddata)
      read
      if (confirma("Os dados estao corretos ?"))
         select 6
         append blank
         replace codigo with ccodigo
         replace nome_for with cnome
         replace valor with nvalor
         replace data_pg with ddata
         replace tipo with ctipo
      endif
      fim:= confirma("Deseja Continuar na Agenda de " + ctipod)
   enddo
   close databases
   select 1
   close format
   release all
   restore screen from stela_agd1
   return

* EOF
