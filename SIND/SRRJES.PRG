#include "common.ch"
#include "inkey.ch"

********************************

   PUBLIC Local1, Local2, Local3
   Local1:= {"marcado", "codigo", "produto", "valunit", "valunitv"}
   Local2:= {"!", "@!", "@!", "999,999.99", "999,999.99"}
   Local3:= {"Sel.", "Codigo", "Item", "(COMPRA)", "(VENDA)"}
   use cebest index ceiest
   sombra(4, 1, 22, 77)
   @  4, 29 say "Reajuste de Precos"
   @ 21,  4 say "<F2>-Marcar/Desmarca; <F3>-Reajusta os pre‡os; <ENTER>-Edita o Pre‡o"
   dbedit(5, 2, 20, 76, Local1, "reajuste", Local2, Local3, "Ä", "³")
   close databases
   select 1
   close format
   release all
   return
********************************
function REAJUSTE(Arg1, Arg2)

   _cor_rj:= SetColor()
   do case
   case Arg1 = 1 .OR. Arg1 = 2 .OR. Arg1 = 0
      return 1
   case Arg1 == 3
      mensagem("Nao ha produtos cadastrados !!!")
      return 0
   case LastKey() == K_F2
      if (marcado = "S")
         replace marcado with " "
      else
         replace marcado with "S"
      endif
      return 1
   case LastKey() == K_F3
      save screen to ttela_rj
      amat_opc1:= array(3, 3)
      amat_opc2:= array(2, 3)
      amat_opc3:= array(2, 3)
      nporcen:= 0
      amat_opc1:= {{10, 10, "Reajustar TODOS os Itens"}, {12, 10, ;
         "Reajustar Itens SELECIONADOS"}, {14, 10, "Cancelar"}}
      amat_opc2:= {{10, 40, "Valor de Compra"}, {12, 40, ;
         "Valor de Venda"}}
      amat_opc3:= {{10, 58, "Aumentar Preco"}, {12, 58, ;
         "Diminuir Preco"}}
      opcao1:= opcao2:= opcao3:= 0
      sombra(8, 7, 17, 75)
      @  8, 23 say "Reajuste:"
      @  9, 39 to 15, 39
      @  9, 57 to 15, 57
      @ 16, 10 say "Em :        %"
      botao(amat_opc2,.F.)
      botao(amat_opc3,.F.)
      opcao1:= botao(amat_opc1)
      if (opcao1 = 3 .OR. opcao1 = 0)
         restore screen from ttela_rj
         set color to "&_COR_RJ"
         return 1
      endif
      opcao2:= botao(amat_opc2)
      opcao3:= botao(amat_opc3)
      _cursor:= setcursor(1)
      @ 16, 15 get nPorcen picture "999.99" valid nporcen <= 100.0
      read
      setcursor(_cursor)
      restore screen from ttela_rj
      set color to "&_COR_RJ"
      if (LastKey() = K_ESC .OR. Empty(nporcen))
         return 1
      endif
      if (opcao1 == 1)
         goto top
         do while (!EOF())
            if (opcao2 == 1)
               if (opcao3 == 1)
                  nvalorc:= valunit
                  nvalorcr:= nvalorc * nporcen / 100 + nvalorc
               else
                  nvalorc:= valunit
                  nvalorcr:= nvalorc - nvalorc * nporcen / 100
               endif
               replace valunit with nvalorcr
            else
               if (opcao3 == 1)
                  nvalorv:= valunitv
                  nvalorvr:= nvalorv * nporcen / 100 + nvalorv
               else
                  nvalorv:= valunitv
                  nvalorvr:= nvalorv - nvalorv * nporcen / 100
               endif
               replace valunitv with nvalorvr
            endif
            skip 
         enddo
      else
         set filter to Marcado = "S"
         goto top
         if (EOF())
            mensagem("Nao ha registros Marcados !!!")
            set filter to
            goto top
            restore screen from ttela_rj
            return 1
         endif
         do while (!EOF())
            if (opcao2 == 1)
               if (opcao3 == 1)
                  nvalorc:= valunit
                  nvalorcr:= nvalorc * nporcen / 100 + nvalorc
               else
                  nvalorc:= valunit
                  nvalorcr:= nvalorc - nvalorc * nporcen / 100
               endif
               replace valunit with nvalorcr
            else
               if (opcao3 == 1)
                  nvalorv:= valunitv
                  nvalorvr:= nvalorv * nporcen / 100 + nvalorv
               else
                  nvalorv:= valunitv
                  nvalorvr:= nvalorv - nvalorv * nporcen / 100
               endif
               replace valunitv with nvalorvr
            endif
            replace marcado with " "
            skip 
         enddo
         set filter to
         goto top
      endif
      setcolor(_COR_RJ)
      restore screen from ttela_rj
      goto top
      return 2
   case LastKey() == K_ESC
      return 0
   case Lastkey() == 13
      c_campo := local1[arg2]
      c_masc  := local2[arg2]
      n_curs := setcursor(1)
      @ row(),col() GET &c_Campo PICTURE c_masc WHEN(subst(c_masc,1,1)="9")
      READ
      setcursor(n_curs)
      RETURN 1
   otherwise
      return 1
   endcase

* EOP cerjes.prg