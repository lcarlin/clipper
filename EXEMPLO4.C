#include <dos.h>
main()
{
int x, y, i=0, k=0, j=0;
int tx=22, ty=17;
char rosto[374]={
0x08, 0x05, 0x06, 0x13, 0x11, 0x14, 0x42, 0x46, 0x54
,0x64, 0x68, 0x69, 0x69, 0x69, 0x67, 0x69, 0x69, 0x07 
,0x07, 0x0E, 0x21, 0x13, 0x09, 0x1f, 0x52, 0x51, 0x46
,0x52, 0x69, 0x6A, 0x6A, 0x6A, 0x69, 0x6A, 0x0D, 0x0E
,0x19, 0x42, 0x17, 0x06, 0x17, 0x52, 0x57, 0x52, 0x4c
,0x40, 0x67, 0x6A, 0x6A, 0x6A, 0x6C, 0x10, 0x16, 0x32
,0x51, 0x17, 0x18, 0x48, 0x47, 0x5D, 0x57, 0x52, 0x3C
,0x40, 0x67, 0x6B, 0x6B, 0x6C, 0x1E, 0x32, 0x4E, 0x58
,0x1F, 0x0C, 0x3B, 0x47, 0x57, 0x5D, 0x57, 0x4D, 0x38
,0x40, 0x65, 0x6C, 0x6C, 0x35, 0x4E, 0x58, 0x56, 0x2B
,0x18, 0x4B, 0x4E, 0x5D, 0x5D, 0x57, 0x4A, 0x33, 0x46
,0x47, 0x65, 0x6C, 0x45, 0x50, 0x58, 0x58, 0x47, 0x42
,0x4E, 0x5D, 0x5D, 0x5D, 0x5B, 0x4A, 0x3E, 0x4C, 0x4A
,0x45, 0x60, 0x41, 0x51, 0x58, 0x58, 0x56, 0x4E, 0x5d
,0x62, 0x61, 0x58, 0x53, 0x51, 0x4E, 0x4A, 0x51, 0x4A
,0x30, 0x46, 0x56, 0x5E, 0x5C, 0x58, 0x58, 0x5D, 0x5C
,0x5C, 0x58, 0x52, 0x50, 0x51, 0x3c, 0x49, 0x52, 0x4A
,0x4D, 0x56, 0x61, 0x5C, 0x55, 0x5C, 0x5F, 0x5F, 0x5F
,0x58, 0x58, 0x49, 0x51, 0x33, 0x22, 0x51, 0x56, 0x4C
,0x51, 0x58, 0x51, 0x4D, 0x56, 0x5C, 0x5E, 0x61, 0x5C
,0x5F, 0x4D, 0x50, 0x2C, 0x22, 0x3C, 0x56, 0x49, 0x55
,0x5C, 0x32, 0x27, 0x4A, 0x56, 0x51, 0x4D, 0x4D, 0x58
,0x44, 0x49, 0x28, 0x2E, 0x28, 0x51, 0x4D, 0x58, 0x56
,0x12, 0x1E, 0x52, 0x5D, 0x58, 0x4F, 0x44, 0x49, 0x23
,0x4A, 0x28, 0x28, 0x26, 0x51, 0x4D, 0x58, 0x42, 0x0A
,0x00, 0x57, 0x62, 0x5E, 0x56, 0x46, 0x41, 0x2A, 0x49
,0x1A, 0x34, 0x29, 0x51, 0x5A, 0x5E, 0x17, 0x0E, 0x66
,0x57, 0x5F, 0x61, 0x5E, 0x46, 0x2F, 0x44, 0x3C, 0x1D
,0x34, 0x2C, 0x58, 0x59, 0x4E, 0x14, 0x03, 0x43, 0x4E
,0x5F, 0x5F, 0x5E, 0x51, 0x41, 0x51, 0x3C, 0x22, 0x25
,0x44, 0x5C, 0x58, 0x30, 0x1B, 0x15, 0x36, 0x4E, 0x5F
,0x63, 0x61, 0x51, 0x4D, 0x56, 0x33, 0x25, 0x3C, 0x55
,0x5C, 0x4D, 0x2B, 0x21, 0x0B, 0x1F, 0x53, 0x61, 0x5F
,0x5C, 0x5D, 0x56, 0x50, 0x20, 0x33, 0x4D, 0x56, 0x56
,0x3D, 0x1F, 0x1C, 0x0D, 0x4A, 0x61, 0x5F, 0x61, 0x5A
,0x4c, 0x50, 0x51, 0x40, 0x56, 0x56, 0x4D, 0x39, 0x37
,0x1E, 0x19, 0x30, 0x5C, 0x5E, 0x5E, 0x58, 0x51, 0x49
,0x4C, 0x58, 0x58, 0x56, 0x45, 0x24, 0x11, 0x35, 0x27
,0x32, 0x51, 0x58, 0x58, 0x5C, 0x56, 0x4C, 0x3A, 0x49
,0x4D, 0x50, 0x41, 0x27, 0x12, 0x04, 0x31, 0x31, 0x37
,0x49, 0x49, 0x4C, 0x4C, 0x49, 0x3F, 0x2D, 0x3A, 0x3C
,0x35, 0x24, 0x12, 0x06, 0x02};
int pal[109][3]={
0x1A,0x1C,0x26, 0x03,0x01,0x03, 0x03,0x02,0x01,
0x06,0x05,0x08, 0x06,0x06,0x09, 0x06,0x06,0x0B,
0x07,0x07,0x0C, 0x07,0x07,0x0E, 0x08,0x09,0x10,
0x08,0x09,0x13, 0x08,0x0A,0x13, 0x09,0x0A,0x15,
0x0F,0x0E,0x0E, 0x0A,0x0C,0x19, 0x0C,0x0F,0x1A,
0x0C,0x0E,0x1D, 0x0D,0x10,0x1D, 0x0D,0x10,0x1F,
0x12,0x14,0x15, 0x0D,0x11,0x20, 0x10,0x13,0x1E,
0x13,0x16,0x17, 0x0E,0x13,0x23, 0x11,0x0D,0x30,
0x0F,0x14,0x23, 0x0F,0x14,0x25, 0x13,0x0E,0x31,
0x0F,0x15,0x26, 0x12,0x16,0x23, 0x0E,0x15,0x2A,
0x11,0x16,0x27, 0x14,0x10,0x33, 0x0E,0x16,0x2B,
0x11,0x17,0x28, 0x16,0x11,0x33, 0x16,0x12,0x35,
0x12,0x18,0x2B, 0x19,0x14,0x32, 0x18,0x13,0x34,
0x12,0x19,0x2C, 0x14,0x1A,0x29, 0x18,0x14,0x35,
0x12,0x19,0x2F, 0x1c,0x15,0x34, 0x13,0x1A,0x2F,
0x17,0x1C,0x2B, 0x13,0x1A,0x30, 0x15,0x1C,0x2D,
0x17,0x1B,0x31, 0x1C,0x17,0x36, 0x15,0x1D,0x2F,
0x1F,0x21,0x22, 0x15,0x1C,0x31, 0x19,0x1C,0x31,
0x17,0x1E,0x2F, 0x15,0x1C,0x32, 0x20,0x21,0x27,
0x19,0x1D,0x33, 0x17,0x1E,0x31, 0x1A,0x1F,0x2E,
0x17,0x1D,0x34, 0x1A,0x1F,0x31, 0x18,0x1F,0x32,
0x1A,0x20,0x2F, 0x28,0x25,0x21, 0x19,0x1F,0x34,
0x1A,0x20,0x31, 0x1A,0x20,0x33, 0x1D,0x22,0x31,
0x22,0x25,0x28, 0x1B,0x21,0x35, 0x1C,0x22,0x33,
0x23,0x23,0x2E, 0x1C,0x22,0x35, 0x1D,0x23,0x36,
0x1F,0x24,0x33, 0x1D,0x23,0x37, 0x1F,0x24,0x35,
0x1F,0x25,0x36, 0x21,0x26,0x35, 0x22,0x25,0x37,
0x25,0x27,0x34, 0x1F,0x26,0x38, 0x21,0x26,0x37,
0x25,0x27,0x37, 0x22,0x27,0x38, 0x21,0x28,0x37,
0x21,0x28,0x39, 0x24,0x28,0x37, 0x24,0x29,0x39,
0x28,0x2A,0x37, 0x24,0x2A,0x39, 0x28,0x2A,0x39,
0x2D,0x2D,0x33, 0x27,0x2B,0x3A, 0x2A,0x2C,0x39,
0x2A,0x2C,0x3B, 0x2D,0x2F,0x3A, 0x34,0x33,0x37,
0x37,0x35,0x34, 0x36,0x35,0x3A, 0x3A,0x3B,0x3B,
0x3A,0x3B,0x3C, 0x3C,0x3C,0x3D, 0x3C,0x3D,0x3E,
0x3E,0x3E,0x3E
};
modo(19);
for(x=0;x<109;x++) 
plt(x,pal[x][2],pal[x][1],pal[x][0]);
for(x=0;x<tx;x++)
   for(y=0;y<ty;y++)
   {
   for (i=10;i<320-tx;i+=tx*2)
      for(j=10;j<200-ty;j+=ty*2)
      pokeb(0xA000,x+i+(y+j)*320,rosto[k]);
      k++;
      }
getch();
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
