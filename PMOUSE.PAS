{ data 14/03/93
comentarios : Programa p/ mouse em TP 6.0
eXtraido de MS-N§128}

unit Pmouse;
interface
uses dos, crt;
var reg :registers;
dx , dy :integer;

procedure executa;
procedure resseta(com:integer);
procedure habilita_cursor;
procedure desabilita_cursor;
procedure le_cursor(var botao:string;var x ,y:integer);
procedure seta_localizacao_cursor(x,y:integer);
procedure retorna_coordenada(botao:string;var x,y:integer;pressionado:boolean);
procedure define_faixa(minimo,maximo:integer;horizontal:boolean);
function  maiuscula( texto : string ) : string;
procedure instala(com:integer);

implementation

procedure instala(com:integer);
{($m$4000,0,$4000)}
var aux:string[1];
begin
 str(com,aux);
 exec('gmouse.com',aux);
end;

procedure executa;
begin
 intr($33,reg);
end;

procedure resseta;
begin
 reg.ax:=0;
 executa;
 if reg.ax=655535 then writeln('***mouse Instalado');
 if reg.ax=0 then begin
  writeln('***mouse nao instalado***');
  writeln('instala <S/N>?');
  if upcase(readkey)='S' then instala(com)
  else halt;
 end;
end;

FUNCTION maiuscula;
var i:integer;d:string[1];aux:string;
 begin
  aux:='';
  for i:=1 to length(texto) do begin
   d:=copy(texto,i,1);
   aux:=aux+upcase(d[1]);
  end;
  maiuscula:=aux;
 end;

procedure habilita_cursor;
{aparece o cursor na tela}
begin
 reg.ax:=1;
 executa;
end;

procedure desabilita_cursor;
{desapacerce cursor da tela}
begin
 reg.ax:=2;
 executa;
end;

procedure le_cursor;
begin
 reg.ax:=3;
 executa;
 x:=reg.cx;
 y:=reg.dx;
 case reg.bx of
  1:botao:='esquerdo';
  2:botao:='direito';
  3:botao:='meio';
 else botao:='eerro';
 end;
end;

procedure seta_localizacao_cursor;
begin
 reg.ax:=4;
 reg.cx:=x;
 reg.dx:=y;
 executa;
end;

procedure retorna_coordenada;
begin
 if maiuscula(botao)='ESQUERDO' then reg.bx:=0;
 if maiuscula(botao)='DIREITO' then reg.bx:=1;
 if maiuscula(botao)='MEIO' then reg.bx:=2;
 if pressionado then reg.ax:=5
 else reg.ax:=6;
 executa;
 x :=reg.cx;
 y :=reg.dx;
end;

procedure define_faixa;
begin
 if horizontal then reg.ax:=7
 else reg.ax:=8;
 reg.cx:=minimo;
 reg.dx:=maximo;
 executa;
end;
end.


