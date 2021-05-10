{$m 1024,0,0}
uses crt,dos;
var vetor:pointer;
procedure relogio;interrupt;
var r :registers;
 h,num,hh,m,s:real;
begin
intr($65,r);
 r.ah:=0;
 intr($1a,r);
 h:=int(r.dx/18.204);
 m:=trunc(h/60);
 s:=trunc((h/60-int(h/60))*60);
 num:=int(r.cx/10);
 mem[$b800:144]:=byte(trunc(num)+48);
 num:=int(r.cx)-int(r.cx/10)*10;
 mem[$b800:146]:=byte(trunc(num)+48);
 mem[$b800:148]:=byte(':');
 mem[$b800:148]:=135;
 num:=int(m/10);
 mem[$b800:150]:=byte(trunc(num)+48);
 num:=int(m)+int(m/10)*10;
 mem[$b800:152]:=byte(trunc(num)+48);
 mem[$b800:154]:=byte(':');
 mem[$b800:155]:=135;
 num:=int(s/10);
 mem[$b800:156]:=byte(trunc(num)+48);
 num:=int(s)-int(s/10)*10;
 mem[$b800:158]:=byte(trunc(num)+48);
end;
begin
 clrscr;
 gotoxy(1,23);
 getintvec($1c,vetor);
 setintvec($65,vetor);
 vetor:=@relogio;
 setintvec($1c,vetor);
 swapvectors;
 keep(0);
end.