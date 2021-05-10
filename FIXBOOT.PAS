Program FixBootSector;
Uses Crt, DOS;
Type
  Len_Sec  = array[0..512] of byte;
var
  NumOfbytes : integer;
  Buffer     : Len_sec;
  Regs       : Registers;
Begin
  ClrScr;
  Write('Coloque em A: um disco LIMPO e Tecle <ENTER>...');
  readln;
  Regs.ES:=Seg(buffer);
  Regs.BX:=ofs(buffer);
  Regs.AH:=02;
  Regs.DL:=00;
  Regs.DH:=00;
  Regs.CH:=00;
  regs.CL:=01;
  Regs.AL:=01;
  Intr($13,regs);
  writeln;
  writeln;
  Write('Coloque em A: o disco com BOOT SECTOR Suspeito e tecle <ENTER>');
  readln;
  Regs.ES:=Seg(buffer);
  Regs.BX:=ofs(buffer);
  Regs.AH:=03;
  Regs.DL:=00;
  Regs.DH:=00;
  Regs.CH:=00;
  regs.CL:=01;
  Regs.AL:=01;
  Intr($13,regs);
  writeln;
  writeln;
  write('BOOT SECTOR gravado neste disco');
end.

