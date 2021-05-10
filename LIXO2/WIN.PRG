#include "winclas.ch"   // hearder da classe winndow
#include "box.ch"       // header para as bordas
#include "inkey.ch"     // header para as teclas
#include "setcurs.ch"   // headre para o cursor

function main()
local ojan1, ojan2, ojan3, ojan4

dispbox(00,00,24,79,replicate(chr(177),9),"w+/r")
setcursor(SC_NONE)  //desliga

/*
definicao da primeira janela
*/
// windownew(ntop,nright,nbottom,nleft) -> objeto
ojan1  :=  windownew(01,01,14,49)
// prepara a borda
.ojan1:border  := B_SINGLE+chr(178)
// prepara cor da janela
.ojan1:color    := "w+/r"
// prepara titulo
.ojan1:title   := "Janela  1"
// pre[para cor do titulo
.ojan1:coltitle  :=  "w+/bg"

/*
definicao da segunda janela
*/
ojan2  :=  windownew(10,10,20,59)
// prepara a borda
.ojan2:border  := B_DOUBLE
// prepara cor da janela
.ojan2:color    := "w+/b"
.Ojan2:title    := "O Corsario (tm)"
.Ojan2:coltitle := "w/b"

/*
definicao da terceira janela
*/
ojan3  :=  windownew(02,15,15,69)
// prepara a borda
.ojan3:border  := B_DOUBLE_SINGLE+chr(178)
// prepara cor da janela
.ojan3:color    := "bg+/r"
// prepara titula
.ojan3:title  := "Janela  3"
// prepara cor do titulo
.ojan3:coltitle := "r/b"

/*
definicao da  quarta janela
*/
OJAN4:=windownew(10,06,17,56)
.ojan4:color  :=  "w+/r"
.oJan4:TITLE  := "Eddie would Go !"
.Ojan4:coltitle := "w+/n"


.ojan1:Openwin ()
inkey(2)


.ojan2:openwin ()
inkey(2)


.ojan3:openwin ()
inkey(2)


.ojan4:openwin ()
@ 24,00 say padc("Use as setas para movimentar a janela, ESC encerra.",80,chr(177)) color "w+/r"
while .t.
      inkey(0)
      if lastkey()==K_ESC
         exit
      endif
      .ojan4:closewin()
      if lastkey()==K_UP
         .ojan4:top--
         .ojan4:bottom--
      elseif lastkey()== K_DOWN
         .ojan4:top++
         .ojan4:bottom++
      elseif lastkey()==K_RIGHT
         .ojan4:left++
         .ojan4:right++
      ELSEIF lastkeY() == K_LEFT
         .OJAN4:LEFT--
         .OJAN4:RIGHT--
      endif
      .ojan4:openwin()
end
@ 24,00 say replicate (chr(177),80) color "w+/r"
// fecha janela4
.ojan4:closewin()
inkey(2)

// fecha janela3
.ojan3:closewin()
inkey(2)

// fecha janela2
.ojan2:closewin()
inkey(1)

// fecha janela1
.ojan1:closewin()
inkey(1)

cls
setcursor(SC_NORMAL)

retUrn nil
