#include <dos.h>
#include <NANDEF.H>
#include <extend.h> 



CLIPPER cores256()
{
int i,j;
int pallete[256][3]; /* para armazenar as cores */
modo(19);
for (i=0;i<256;i++)
{
plt(i,0,0,0);
linha (i,0,i+60,199,i);
}
for(i=0;i<64;i++)
      {
      pallete[i][0]=i;
      pallete[i][1]=0;
      pallete[i][2]=i;
      plt(i,i,0,i);
      pallete[64+i][0]=63;
      pallete[64+i][1]=i;
      pallete[64+i][2]=63-i;
      plt(64+i,63,i,63-i);
      pallete[128+i][0]=63-i;
      pallete[128+i][1]=63;
      pallete[128+i][2]=i;
      plt(128+i,63-i,63,i);
      pallete[192+i][0]=0;
      pallete[192+i][1]=63-i;
      pallete[192+i][2]=63-i;
      plt(192+i,0,63-i,63-i);
      }
getch();
for(j=63;j>=0;j--)
       for (i=0;i<256;i++)
       {
       if(pallete[i][0]>j)pallete[i][0]--;  if(pallete[i][1]>j)pallete[i][1]--;if(pallete[i][2]>j)pallete[i][2]--;plt(i,pallete[i][0],pallete[i][1],pallete[i][2]);
       }
modo(3);
return;                                 
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
