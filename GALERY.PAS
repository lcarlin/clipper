uses crt, graph, dos, mouse;
const
  FUNDO = 8;
var
  L, V, COR,
  X, Y : integer;

procedure Mudacor(pNC:word);
  begin
    setcolor(cor);
    setfillstyle (1,cor);
    if area(30,290,90,320) then hidemou;
    showmou;
  end;

procedure Button
(pC,pL,pCF,pLF,pH:integer;pM:string);
  begin
    if fundo<>0 then setcolor(0) else setcolor(8);
    rectangle(pC,pL,pCF,pLF);
    rectangle(pC+pH,pL+pH,pCF-pH,pLF-pH);
    line(pC,pLF,pC+pH,pLF-pH);
    setfillstyle(1,0);
    floodfill(pC+pH,pLF-1,getcolor);
    setfillstyle(1,7);
    floodfill(pC+1,pL+1,getcolor);
    setfillstyle(1,8);
    bar(pC+pH,pL+pH,pCF-pH,pLF-pH);
    settextjustify(centertext,centertext);
    settextstyle(0,0,0);
    setcolor(15);
    outtextxy(1+pC+(pCF-pC)div 2,1+pL+(pLF-pL)div 2,pM);
    setcolor(0);
    outtextxy(pC+(pCF-pC)div 2,pL+(pLF-pL) div 2,pM);
  end;

function XRead:string;
  var
    S,W : string;
    T   : char;
  begin
    S := '';
    t := upcase(readkey);
    while t<>#13 do begin
      if (T in['A'..'Z']) or (T in ['1'..'2']) then begin
         outtext (T);
         W := T;
         S := S+W;
      end;
      if T=#8 then begin
        moveto(getx-textwidth('W'),gety);
        bar(getx,gety,getx+10,gety+10);
        S:=copy(S,1,length(s)-1);
      end;
      T := upcase(readkey);
   end;
   XRead := S;
 end;

function barra : string;
  var
    S : string;
  begin
    if fundo<>4 then setfillstyle (1,4) else setfillstyle(1,1);
    bar(5,10,getmaxx-5,20);
    setcolor(15);
    getdir(0,S);
    settextjustify(bottomtext,righttext);
    outtextxy(5,10,S+'.:');
    moveto(5+textwidth(S+'.:'),10);
    S := XRead;
    setcolor(cor);
    barra := S;
  end;

Procedure retorno;
  begin
    Setfillstyle(1,FUNDO);
    bar(5,10,getmaxx-5,20);
  end;

Procedure abre;
  var
    NA  : string;
    ARQ : text;
    CH  : char;
    N,G,
    H   : integer;
  begin
    hidemou;
    NA := barra;
    assign(ARQ,NA+'.GLR');
    reset(ARQ);
    readln(ARQ);
    readln(ARQ);
    readln(ARQ);
    moveto(121,31);
    while not eof(ARQ) do begin
       while not eoln(ARQ) do begin
         read(ARQ,CH);
         N := ord(CH)-32;
         G := getx div 10 - 11;
         H := gety div 10 - 02;
         putpixel(35+G,355+H,N);
         setfillstyle(1,N);
         floodfill(getx,gety,15);
         moveto (getx+10,gety);
       end;
       readln(ARQ);
       moveto (121,gety+10);
    end;
    close (ARQ);
    retorno;
    showmou;
  end;

procedure salva;
  var
    NA  : string;
    ARQ : text;
    CH  : char;
    N   : integer;
  begin
    hidemou;
    NA := barra;
    assign (ARQ,NA+'.GLR');
    rewrite(ARQ);
    writeln(ARQ,'All rights for');
    writeln(ARQ,'Luiz Antonio Carlin');
    writeln(ARQ,'');
    L := 31;
    while L <= 411  do begin;
      V := 121;
      while V <= 601 do begin
        N  := getpixel(V, L);
        CH := chr(n+32);
        write(ARQ,CH);
        inc(V,10);
      end;
      writeln(ARQ,'');
      inc(L,10);
    end;
    close (ARQ);
    retorno;
    showmou;
  end;

procedure limpa;
  var
    N : integer;
  begin
    hidemou;
    setfillstyle(1,10);
    bar(30,350,90,420);
    L := 31;
    while l <= 411 do begin
      V := 121;
      while V <= 601 do begin
        N := getpixel (V,L);
        if N <> 0 then floodfill(V,L,15);
        inc(V,10);
      end;
      inc(L,10);
    end;
    showmou;
  end;

procedure inicializa;
  const
    GDRIVER : integer = 9;
    GMODE   : integer = 2;
    GPATH   : string  = '';
  begin
    COR := 1;
    initgraph(GDRIVER,GMODE,GPATH);
    setfillstyle(1,FUNDO);
    bar(0,0,getmaxx,getmaxy);
    V := 30;
    for L := 0 to 15 do begin
       setfillstyle (1,L);
       if (l mod 2) = 0 then
         bar(30,v,60,v+30)
       else begin
         bar(60,v,90,v+30);
         inc (V,30);
       end;
    end;
    if FUNDO = 0 then setcolor(15) else setcolor(0);
      rectangle(29,29,91,V+1);
      rectangle(29,V+19,91,V+51);
      setfillstyle(1,COR);
      bar(30,V+20,90,V+50);
      setfillstyle(1,0);
      bar(120,30,610,420);
      bar(30,350,90,420);
      Button(120,430,220,470,4,'SALVAR');
      Button(225,430,325,470,4,'ABRIR');
      Button(330,430,430,470,4,'SAIR');
      Button(435,430,535,470,4,'LIMPAR');
      setcolor(15);
      L := 30;
      while L <= 420 do begin
        V := 120;
        while V <= 610 do begin
          line(V,30,V,420);
          inc(V,10);
        end;
        line(120,L,610,L);
      inc (L,10);
    end;
    setfillstyle(1,cor);
  end;


procedure Verifica;
 begin
  if not mouseon then begin
    writeln('Este programa requer mouse...');
    halt(0);
  end;
 end;

begin
 verifica;
 inicializa;
 showmou;
 repeat
   if ebutton then begin
     if area(30,30,90,250) then begin
       hidemou;
       COR := getpixel(moux,mouy);
       showmou;
       mudacor(COR);
     end;
     if area(120,30,608,420) then begin
       hidemou;
       floodfill(moux,mouy,15);
       X := moux div 10 - 11;
       Y := mouy div 10 - 02;
       putpixel(35+X,355+Y,COR);
       showmou;
     end;
     if area(124,423,216,466) then Salva;
     if area(229,432,321,466) then abre;
     if area(439,434,531,466) then limpa;
   end;
 until area(334,434,426,466) and ebutton;
 closegraph;
end.
