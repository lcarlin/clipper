uses DOS;
const
   msg:string ='dir /p $';
var
   regs: registers;
begin
   regs.ah:=9;
   regs.ds:=seg(msg);
   regs.dx:=OfS(msg[1]);
   intr($21,regs);
  { MsDos(regs);}
end.