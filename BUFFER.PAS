program StuffKeyBuffer;
Uses dos;
var
   PassCommand    :  string;
   LenCommand, i  :  integer;
   Regs           :  registers;
begin
   Passcommand := 'Dir /w'+ #13;
   LenCommand  := length (Passcommand);
   mem[0000:1050] := 30;
   mem[0000:1052] := 30+lencommand*2;
   for i := 1 to lencommand do
      mem[0000:1052+i*2]:=ord(Passcommand[i])
end.


