{$m 51200,0,0}
{
PROGRAMA  : MOUSE-DOS Controler V1.1
FUNCAO    : PERMITIR O USO DO MOUSE NO DOS
AUTOR     : Giuliano S. Nascimento
REQUISITOS: IBM PC COMPATIVEL E MOUSE
}
USES CRT,DOS;

VAR P:POINTER;
    D:LONGINT;
    BOTAO:BYTE;
    ULTVEZ,SOM:BOOLEAN;
    PROMPT:BOOLEAN;
    TECLA1,TECLA2:BYTE;
    REG:REGISTERS;
    A,B,X,Y:WORD;
    TEMPO:LONGINT;
    S:STRING;

CONST SCAN:ARRAY[0..125] OF BYTE=($00,$00,$00,$00,$00,$00,$00,$00,
				 $0E,$00,$00,$00,$00,$1C,$00,$00,
				 $00,$00,$00,$00,$00,$00,$00,$00,
				 $00,$00,$00,$01,$00,$00,$00,$00,
				 $39,$02,$28,$04,$05,$06,$08,$28,
				 $0A,$0B,$09,$0D,$33,$0C,$34,$35,
				 $0B,$02,$03,$04,$05,$06,$07,$08,
				 $09,$0A,$27,$27,$33,$0D,$34,$35,
				 $03,$1E,$30,$2E,$20,$12,$21,$22,
				 $23,$17,$24,$25,$26,$32,$31,$18,
				 $19,$10,$13,$1F,$14,$16,$2F,$11,
				 $2D,$15,$2C,$1A,$2B,$1B,$07,$0C,
				 $29,$1E,$30,$2E,$20,$12,$21,$22,
				 $23,$17,$24,$25,$26,$32,$31,$18,
				 $19,$10,$13,$1F,$14,$16,$2F,$11,
				 $2D,$15,$2C,$1A,$2B,$1B);

PROCEDURE MOUSE;INTERRUPT;
{ BOTAO = 0 nenhum
	  1 esquerdo
	  2 esquerdo 2 clicks
	  3 direito
	  4 direito 2 clicks
	  5 ambos
}
VAR LIN,COL:WORD;
BEGIN
 INC(TEMPO);
 IF TEMPO>25 THEN BEGIN
  IF PROMPT THEN BEGIN
   TEMPO:=0;
   A:=WHEREX;
   B:=WHEREY;
   TEXTBACKGROUND(3);TEXTCOLOR(15);GOTOXY(1,1);
   WRITE('      | A: B: C: D: . .. \ /? CD RD DIR /P CLS COPY DEL TYPE TREE >PRN |MORE  ');
   MEM[$B800:2]:=8;
   MEM[$B800:4]:=8;
   MEM[$B800:8]:=27;
   MEM[$B800:158]:=254;
   MEM[$B800:159]:=63;
   GOTOXY(A,B);
  END ELSE BEGIN
  MEM[$B800:158]:=254;
  MEM[$B800:159]:=63;
 END;
END;
REG.AX:=3;
INTR($33,REG);
BOTAO:=0;

{-------VERIFIA BOTOES}
IF REG.BX=0 THEN ULTVEZ:=FALSE;
 IF ULTVEZ=FALSE THEN BEGIN
  IF REG.BX<>0 THEN BEGIN
   IF SOM THEN BEGIN SOUND(700);DELAY(3);END;
    IF (D<>0) AND (BOTAO=0) THEN BEGIN
     CASE REG.BX OF
      1:BOTAO:=2;
      2:BOTAO:=4;
      3:BOTAO:=5;
     END;
     D:=0;
    END;
    ULTVEZ:=TRUE;
   END;
  END;
 IF (D=0)AND(BOTAO=0)AND(REG.BX<>0) THEN D:=$AAAF;
  IF (D<$AAAB) AND (D>0) THEN BEGIN
   D:=0;
   CASE REG.BX OF
    1:BOTAO:=1;
    2:BOTAO:=3;
    3:BOTAO:=5;
   END;
  END;
 NOSOUND;
 LIN:=REG.DX DIV 8;
 COL:=REG.CX DIV 8;
 {------COMANDOS DO DOS}
 CASE BOTAO OF
  1:BEGIN
   IF (LIN=0)AND(COL=79) THEN BEGIN
    A:=WHEREX;
    B:=WHEREY;
    TEXTBACKGROUND(0);TEXTCOLOR(15);
    GOTOXY(1,1);CLREOL;GOTOXY(80,1);WRITE(CHR (254));
    GOTOXY(A,B);
    IF PROMPT THEN PROMPT:=FALSE ELSE PROMPT:=TRUE;
     END ELSE BEGIN
     S:='';
     X:=(LIN*160+COL*2);
     B:=MEM[$B800:X];
     IF B=32 THEN BEGIN
      WHILE (X<9600)AND((B=32)OR(B=91)OR(B=93)) DO BEGIN
       INC(X);INC(X);
       B:=MEM[$B800:X];
      END;
     END ELSE BEGIN
      WHILE (X>=0)AND(B<>32)AND(B<>91)AND(B<>93) DO BEGIN	
       DEC(X);DEC(X);
       B:=MEM[$B800:X]
      END;
      INC(X);INC(X);
      B:=MEM[$B800:X];
     END;
     IF X<9600 THEN BEGIN
      WHILE (X<9600)AND(B<>32)AND(B<>93) DO BEGIN
      S:=S+CHR(B);
      INC(X);INC(X);
      B:=MEM[$B800:X];
     END;
     S:=S+CHR(32);
     FOR A:=1 TO LENGTH(S) DO BEGIN
      IF MEM[SEG(S[A]):OFS(S[A])]<125 THEN BEGIN
       REG.AH:=5;
       REG.CH:=SCAN[MEM[SEG(S[A]):OFS(S[A])]];
       REG.CL:=MEM[SEG(S[A]):OFS(S[A])];
       INTR($16,REG);
      END;
     END;
    END;
   END;
  END;
  2:BEGIN
   REG.AH:=5;
   REG.CH:=$1C;
   REG.CL:=13;
   INTR($16,REG);
  END;
  3:BEGIN
   S:='DIR/W'+CHR(13);
   FOR A:=1 TO LENGTH(S) DO BEGIN
    REG.AH:=5;
    REG.CH:=SCAN[MEM[SEG(S[A]):OFS(S[A])]];
    REG.CL:=MEM[SEG(S[A]):OFS(S[A])];
    INTR($16,REG);
   END;
  END;
  4:BEGIN
   A:=WHEREX;
   B:=WHEREY;
   TEXTBACKGROUND(3);TEXTCOLOR(15);
   S:=CHR(196)+CHR(196)+CHR(196)+CHR(196)+CHR(196)+CHR(196)+CHR(196)+CHR(196)+CHR(196)+CHR(196);
   GOTOXY(69,2);
   WRITE(CHR(214)+S+CHR(214));
   GOTOXY(69,3);
   WRITE(CHR(186)+' BACKUP   '+CHR(183));
   GOTOXY(69,4);
   WRITE(CHR(186)+' RESTORE  '+CHR(186));
   GOTOXY(69,5);
   WRITE(CHR(186)+' CHKDSK   '+CHR(186));
   GOTOXY(69,6);
   WRITE(CHR(186)+' MEM /C   '+CHR(186));
   GOTOXY(69,7);
   WRITE(CHR(186)+' XCOPY    '+CHR(186));
   GOTOXY(69,8);
   WRITE(CHR(186)+' PRINT    '+CHR(186));
   GOTOXY(69,9);
   WRITE(CHR(186)+' FORMAT   '+CHR(186));
   GOTOXY(69,10);
   WRITE(CHR(186)+' WIN /3   '+CHR(186));
   GOTOXY(69,11);
   WRITE(CHR(199)+S+CHR(182));
   GOTOXY(69,12);
   WRITE(CHR(186)+' MOUSEDOS '+CHR(186));
   GOTOXY(69,13);
   WRITE(CHR(186)+' GIU#SOFT '+CHR(186));
   GOTOXY(69,14);WRITE(CHR(211)+S+CHR(189));
   TEXTBACKGROUND(5);TEXTCOLOR(15);
   GOTOXY(70,12);WRITE(' MOUSEDOS ');
   GOTOXY(70,13);WRITE(' GIU#SOFT ');
   GOTOXY(A,B);
  END;
  5:BEGIN
   REG.AH:=5;
   REG.CH:=46;
   REG.CL:=3;
   INTR($16,REG);
   REG.AX:=1;
   INTR($33,REG);
  END;
 END;
 IF D<>0 THEN DEC(D);
END;
{**************FIM DA PARTE RESIDENTE}

BEGIN
{____---VARIAVEIS}
 TECLA1:=0;
 TECLA2:=0;
 BOTAO :=0;
 ULTVEZ:=FALSE;
 SOM   :=TRUE;
 TEMPO :=0;
 PROMPT:=TRUE;
 REG.AX:=0;
 REG.BX:=0;
 REG.CX:=0;
 REG.DX:=0;
 REG.SI:=0;
 REG.DI:=0;
 INTR($33,reg);
 {-------VERIFICA PARAMETROS}
 CLRSCR;
 WRITELN('');
 WRITELN('MOUSE-DOS CONTROLER V1.1');
 WRITELN('GiuSoft (C) 1993 - Salvador');
 WRITELN('');
 FOR A:=1 TO PARAMCOUNT DO BEGIN
  IF (PARAMSTR(A)='/S')OR(PARAMSTR(A)='/S') THEN SOM:=FALSE;
   IF (PARAMSTR(A)='/?')OR(PARAMSTR(A)='-?') THEN BEGIN;
    WRITELN('CONTROLE DE MOUSE P/ DOS');
    WRITELN('');
    WRITELN('Permite que sejam informados os comandos sem o uso do teclado.');
    WRITELN('');
    WRITELN('Digite: MOUSEDOS [/S] [/?]');
    WRITELN('');
    WRITELN('/? Mostra este Help');
    WRITELN('/S Desativa o som durante a selecao');
    REG.AX:=0;
    WRITELN('');
   END;
  END;
  {-------TESTA SE CONTROLADORES DO MOUSE ESTA INSTALADO }
  IF REG.AX <> 0 THEN BEGIN
   REG.AX:=1;
   REG.BX:=0;
   REG.CX:=0;
   REG.DX:=0;
   REG.SI:=0;
   REG.DI:=0;
   INTR($33,REG);
   WRITELN('Programa instalado.');
   WRITELN('PRESSIONE...');
   WRITELN('');
   WRITELN('1 vez Botao Direito - DIR/W');
   WRITELN('2 vezes Botao Direito - Tabela extra de comandos');
   WRITELN('1 vez Botao Esquerdo - Seleciona texto ou arquivo');
   WRITELN('2 vezes Botao Esquedo - Executa <ENTER>');
   WRITELN('Ambos ou odo meio - interrompe <CTRL-C> e liga cursor do mouse');
   P:=@MOUSE;
   SETINTVEC($1C,P);
   KEEP(0)
  END ELSE WRITELN('Sinto Muito...Mouse n„o instalado...');
 END.








