uses pmouse, graph,dos,crt;
var hora,minuto,minuto2,segundo,segundo2,decseg,count,erro,tempo,word,a,b,x,y,placa,driver,d,com,intervalo:integer;
tecla :char;
botao :string;

begin
clrscr;
gotoxy(5,12);write('Mouse foi instalado em qual porta ?[1 ou 2]:');
case readkey of
 '1' :com :=1;
 '2' :com :=2;
else  begin writeln;writeln;writeln(^g,'===> Digite 1 ou 2:');
{haltend;}
end;
gotoxy(5,16);write('Qual o tipo de computador utilizado [1]xt [2]at:');
case readkey of
 '1' :d:=0;
 '2' :d:=10;
else writeln(^g,'digite [1] ou [2]');
{haltend;}
end;

gotoxy(5,18);write('quanto tempo voce dejesa jogar:');
readln(intervalo);
count:=0;
randomize;
resseta(com);
detectgraph(placa,driver);
{inigraph(placa,driver,'');}
habilita_cursor;

define_faixa(0,getmaxx,true);

define_faixa(0,getmaxx,false);

seta_localizacao_cursor(0,0);

setcolor(3);

setlinestyle(solidln,0,normwidth);
setfillstyle(solidfill,3);
erro:=0;

gettime(hora,minuto,segundo,decseg);
inc(minuto,intervalo);
repeat
a:=random(getmaxx-10-d);b:=randomgetmaxx-10-d);
bar(a,b,+10+D,b+10+d);
tempo:=30+d*300;
repeat

gettime(hora,minuto2msegundo2,decseg);
dec(tempo);

retorna_coordenada('esquerdo'x,y,true);
if d=0 then x:=x div 2; until(((x>=a)and(x<=a+10+d))and((y>=b)and(y<=b+10+d))or9tempo=0);
if tempo >0 then begin
 writeln(^g);inc(count);end
else inc(erro);
 desabilita_cursor;
 clear device;
 habilita_cursor;
 uintil(minuto2>=(minutomod60))and(segundo2>=(segundomod60))
 desabilita_cursor
 closegraph;
 gotoxy(10,12);
 writeln(total de erros:',erro);
 goto(1,25)
 end.



