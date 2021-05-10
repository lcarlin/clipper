#include <dos.h>
#include <extenda.h>

 mouse()
{ union REGS registers;
  registers.x.ax=0;
  int86(0x33,&registers,&registers);
  _retni(registers.x.ax);}

 ligmouse()
{ union REGS registers;
  registers.x.ax=1;
  int86(0x33,&registers,&registers);}

 desmouse()
{ union REGS registers;
  registers.x.ax=2;
  int86(0x33,&registers,&registers);}

 colmouse()
{ union REGS registers;
  registers.x.ax=3;
  int86(0x33,&registers,&registers);
  _retni(registers.x.cx/8);}

 linmouse()
{ union REGS registers;
  registers.x.ax=3;
  int86(0x33,&registers,&registers);
  _retni(registers.x.dx/8);}

 botao()
{ union REGS registers;
  registers.x.ax=3;
  int86(0x33,&registers,&registers);
  _retni(registers.x.bx & 3);}

 posmouse()
{ union REGS registers;
  registers.x.ax = 4;
  registers.x.dx = _parni(1)*8;
  registers.x.cx = _parni(2)*8;
  int86(0x33,&registers,&registers);}

 ajustmouse()
{ union REGS registers;
  registers.x.ax = 0x0007;
  registers.x.cx = _parni(1)*8;
  registers.x.dx = _parni(3)*8;
  int86(0x33,&registers,&registers);
  registers.x.ax = 0x0008;
  registers.x.cx = _parni(2)*8;
  registers.x.dx = _parni(4)*8;
  int86(0x33,&registers,&registers);}
