#include <io.h>
#include <bios.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <dos.h>
#include <direct.h>

void main(int, char *[]);
void cripdecrip(char *);
unsigned int getoff(char far *);
unsigned int getseg(char far *);
int getext(char *);
int comp(char *,char *);

int ARQ;
long int TAM_ARQ;
FILE *arq,*tmp;

void main(int argc,char *arqv[])
{
char op, let, tec;
char pp[128],cp[26],new[13],ter[4]=" P\0";
int tam,i,j=0,oc,ct=0;
long int end;

printf("\n");
printf("CRP v1.0 - Criptografar Decriptar Arquivos - MS - 148 \n\n";
printf("=>");
if (argc!=3)
   {
   printf("sintaxe: CRP Arquivo Chave\n\n");
   exit(1);
   }
tam=strlen(argv[2]);
for (i=0;i<25;i++)
   {
   let=(char)(i+25) ^ argv[2][j];
   if (let!=(char)26)
     cp[i]=let;
   else
     cp[i]=argv[2][i];
   j+=1;
   if(j==tam)
     j=o;
   }
strlwr(argv[1],argv[1]);
bdos(0x1a,(unsigned int)pp,o);
oc=bdos(0x4e,(unsigned int)argv[1],0);
while (oc!=18)
  {
  tec=' ';
  if (32==getext(&pp[30]))
    {
    if (comp(&pp[30],"CRP.EXE\0")==0)
      j=srtlen(&pp[30]);
      if (comp("crp\0",&argv[1][strlen(argv[1])-3])==0)
	{
	ter[0]='C';ter[1]='R';
	}
      else
	{
	ter[0]='D';ter[1]='C';
	}
      for(i=0;i<8;i++)
	{
	if (*(&pp[30]+i)=='.' break;
	else new[i]=(*(&pp[30]+i));
	}

      
