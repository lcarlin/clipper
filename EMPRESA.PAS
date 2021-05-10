{ programa empresa.pas
 le os dados da BIOS
 programa CLIPPER
 }

program SISTEMA;

{$M 62000, 0, 62000}

Uses CRT, DOS, Graph;

VAR
   P    : Pointer;
   Size : Word;
   i,d  : longint;
   q    : integer;
   par  : string[255];

Procedure Inicia;
Var
 GraphDriver, GraphMode: Integer;

Begin
 DetectGraph(GraphDriver,GraphMode);
 InitGraph(GraphDriver,GraphMode,'');
 if GraphResult <> grOK then
    halt(1);
End;

Procedure Espera;
Begin
 Repeat
 Until KeyPressed;
End;

Procedure desenha;
Var
 L, C  : Integer;

Begin
 setcolor(red);
 for c:= 40 to 100 do
 line(70,120,c,30);
 settextstyle(1,1,2);
 outtextxy(90,28,'Empresa');
 size := imageSize(25,25,115,135);
 GetMem(p,Size);
 getImage(25,25,115,135,p^);
 c := 30;
 l := 30;
 ClearDevice;
 repeat
 putimage(c,l,p^,NormalPut);
 c:=c+5;
 l:=l+2;
 until l > 110;
 PutImage(c,l,p^,NormalPut);
 settextstyle(0,0,1);
 setcolor(white);
 outtextxy(190,240,'trabalhando pelo futuro');
end;

Begin
 Inicia;
 desenha;
 Espera;
 CloseGraph;
 i := $FFF5;
 d := 1;
 par := '';
 repeat
 begin
 par := par+chr(mem[$F000:i]);
 i := i+1;
 d := d+1
 end;
 until d > 8;

 i := $30;
 repeat
 q := mem[$F000:i];
 if q>32 then
 par := par+chr(q);
 i:=i+1;
 d:=d+1;
 until d> 255;

 SwapVectors;
 exec('Sistema.exe',par);
 { executa o sistema.exe substitua por instala.exe para executa-lo}
 swapvectors;

 if doserror <> 0 Then begin
  write( doserror);
  readln;
  end;
end.
