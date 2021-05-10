#include <stdio.h>
#include <conio.h>
#include <dos.h>

#define VIDEO 0x10

void movetoxy(int x, int y)
{
   union REGS regs;

   regs.h.ah = 2;  /* set cursor postion */
   regs.h.dh = y;
   regs.h.dl = x;
   regs.h.bh = 0;  /* video page 0 */
   int86(VIDEO, &regs, &regs);
}

int main(void)
{
   clrscr();
   movetoxy(35, 10);
   printf("Hello\n");
   return 0;
}
