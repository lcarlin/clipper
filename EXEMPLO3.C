#include <dos.h>
main()
{
int i;

modo (19);
for (i=0;i<300;i++)
    {
    ponto(rand()%20,rand()%200,rand()%256);
    ponto(300+rand()%20,rand()%200,rand()%256);
    ponto(rand()%320,rand()%20,rand()%256);
    ponto(rand()%320,180+rand()%20,rand()%256);
    linha(50+rand()%220,40+rand()%120,50+rand()%220,40+rand()%120,rand()%256);
    }
getch();
modo(3);
return 0;
}

modo(int mode_code)
{
union REGS r;
r.h.al = mode_code;
r.h.ah=0;
int86(0x10,&r,&r);
return 0;
}

ponto(int x,int y, int cor)
{
char buf;
buf=(char)cor;
pokeb(0xA000,y*320+x,buf);
return 0;
}

/*****************************/
linha(int x1, int y1, int x2, int y2, int cor)
{
int x, y, t, e, dx, dy, denom;
int xinc=1 , yinc=1; 
char buf;
int vertlonger=0,aux;
buf=(char)cor;
dx=x2-x1;dy=y2-y1;
if(dx<0){xinc=-1;dx=-dx;}
if(dy<0){yinc=-1;dy=-dy;}
if(dy>dx){vertlonger = 1; aux=dx;dx=dy;dy=aux;}
denom=denom<<1;
t=dy<<1;
e=-dx;x=x1;
y=y1;
while(dx-- >= 0)
       {
       pokeb(0xA000,y*320+x,buf);;
       if((e+=t)>0)
		 {
		 if(vertlonger)x+=xinc;
		 else y+=xinc;
		 e-=denom;
		 }
       if (vertlonger)y+=yinc;
       else x+=xinc;
       }
return 0;
}
/********************************************/

plt(int cori, int ri, int gi, int bi)
{
char pltb = 0, r= 0x00, g=0x00, b= 0x00;
r=(char)ri;
g=(char)gi;
b=(char)bi;
pltb=(char)cori;
outportb(968,pltb);
outportb(969,r);
outportb(969,g);
outportb(969,b);
return 0;
}

