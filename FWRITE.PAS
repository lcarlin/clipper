{$r-}
unit fwrite;
interface
uses crt;
var
  screenwidth,
  screenheight  :  byte;

procedure fastwrite(S : string; co, ro, at : byte);
procedure fasterwrite(S : string; co, ro, at : word);
procedure checkwidthheight;

implementation

type
 wordarray = array[0..65520 div 2] of word;
var
 display : ^wordarray;
 crt_cols : word absolute $0040:$004a;
 crt_rows: word absolute $0040:$0084;


procedure fastwrite( s : string; co, ro, at : byte);
var
  start, wordattr : word;
  n : byte;
begin
  start := pred(ro)*screenwidth+pred(co);
  wordattr := word(at) shl 8;
  for n := 1 to length(s) do display^[start+pred(n)] := wordattr+ord(s[n]);
end;

procedure fasterwrite(S : string; co, ro, at : word);  assembler;
asm
  mov ax, ro
  dec al
  shl al, 1 
  mul screenwidth
  add ax, co
  dec ax
  mov di, word(display)
  add di, ax
  mov ax, word(display+2)
  mov es, ax
  push ds
  lds si, s
  xor cx, cx
  mov cl, [si]
  inc si
  mov bh, byte(at)
  @loop:
    movsb
    mov es:[di], bh
    inc di
  loop @loop
  pop ds
end;

procedure checkwidthheight;
begin
 screenwidth  := crt_cols;
 screenheight := succ(crt_rows);
end;

begin
  checkwidthheight;
  if lastmode = 7 then
     display := ptr($b800, 0)
  else display := ptr($b800, 0);
end.



