program vesainfo;
uses crt, fwrite;
type
   charlist    = array[0..65520] of char;
   charlistptr = ^charlist;
   vmlist      = array[0..65520 div 2] of word;
   vmlistprt   = ^vmlist;
   infobuffer  = RECORD
     vesasignature  :  array[1..4] of char;
     vesaversion    :  word;
     oemstring      :  charlistptr;
     capabilities   :  longint;
     videomodeprt  :  vmlistprt;
     totalmemory    :  byte;
     reserved       :  array[0..235] of byte;
  end;
  modeinfo = record
     modeattributes   :  word;
     winaattributes   :  byte;
     winbattributes   :  byte;
     wingranularity   :  word;
     winsize          :  word;
     winasegment      :  word;
     winbsegment      :  word;
     winfuncprt       :  pointer;
     bytesperscanline :  word;
     xresolution      :  word;
     yresolution      :  word;
     xcharsize        :  byte;
     ycharsize        :  byte;
     numberofplanes   :  byte;
     bitsperpixel     :  byte;
     numberofbanks    :  byte;
     memorymodel      :  byte;
     banksize         :  byte;
     numofimagepages  :  byte;
     reserved         :  byte;
     filler           :  array[0..224] of byte;
   end;
  var
     mbuffer          :  modeinfo;
     buffer           :  infobuffer;
     vidmode, cmpx, cmpy,
     n, x, y, cmpmode :  word;
     cmp8x8           :  boolean;
     ch               :  char;
     power2           :  array[0..15] of word;
     s                :  string;
     function hexw( w : word ) : string;
     const
     digits : array[0..$f] of char = '0123456789abcdef';
     begin
       hexw[0] :=  #4;
       hexw[1] :=  digits[hi(w) shr 4];
       hexw[2] :=  digits[hi(w) and $f];
       hexw[3] :=  digits[lo(w) shr 4];
       hexw[4] :=  digits[lo(w) and $f];
     end;

     function supportvesa : boolean; assembler;
     asm
     mov ah, 4fh
     mov al, 00h
     push ds
     pop es
     lea di, buffer
     int 10h
     cmp al, 4fh
     jne @novesa
     mov al, 1
     ret
     @novesa:
   end;
   function getvesavidmode : word; assembler;
   asm
     mov ah, 4fh
     mov ah, 03h
     int 10h
     cmp ah, 0h
     jne @failed
     mov ax, bx
     ret
     @failed:
     mov ax, 0ffffh
   end;
   function getmodeinfo(m : word) : boolean; assembler;
   asm
     mov ah, 4fh
     mov al, 01h
     mov cx, m
     push ds
     pop es
     lea di, mbuffer
     int 10h
     mov al, 0
     cmp ah, 0h
     jne @failed
     inc al
     @failed:
   end;
   procedure showmodeinfo( m : word );
   begin
     write(' ','$'+hexw(m),'':5);
     if (not getmodeinfo(m)) or (mbuffer.modeattributes and 2 = 0) then
        writeln('Informa‡ao indispon¡vel ! ')
     else
        with mbuffer do
          begin
            if memorymodel = 0 then
              begin
                write('text','':5);
                if xresolution*yresolution = cmpx*cmpy then
                  begin
                     cmpx := xresolution;
                     cmpy := yresolution;
                     cmpmode := m;
                     cmp8x8 := ycharsize = 8;
                  end;
              end
           else writeln('graf','':5);
           write(xresolution:4,'x');
           write(yresolution:4,'':6);
         write(power2[bitsperpixel]:4,'':8);
         writeln(xcharsize:3,'x',ycharsize);
         end;
   end;
   procedure setsupervgamode( m : word); assembler;
   asm
     mov ah, 4fh
     mov al, 02h
     mov bx, m
     int 10h
   end;

 begin
   clrscr;
   if not supportvesa then
     begin
       writeln('Esta placa nao suporta VESA');
       halt;
     end;
   vidmode := getvesavidmode;
   if vidmode = $ffff then
     begin
       writeln('A tentativa de obter modos de v¡deo VESA falhou !!');
       halt;
     end;
   if buffer.vesasignature <> 'VESA' then
     begin
       write('Li o block VESA ');
       writeln('mas  a assinatura VESA nÆo est  presente !!!');
       halt;
     end;
   write('Placa suporta  VESA. O modo corrente ‚ ');
   write(vidmode);
   writeln;
   with  buffer do 
     begin
       Write('VersÆo VESA   : ',hi(vesaversion));
       writeln('.',lo(vesaversion));
       write('String OEM    : "');
       n := 0;
       repeat
         write(oemstring^[n]);
         inc(n)
       until (oemstring^[n] = #0) or (n > 256);
       writeln('"');
       if vesaversion > $100 then
          writeln('Mem¢ria total : ',totalmemory*64,'k')
       else writeln('Check de mem¢ria total indispon¡vel em VESA v1.0');
       writeln;
       power2[0] := 1;
       for n := 1 to 15 do
         power2[n] := 2*power2[pred(n)];
       n := 0;
       cmpmode := 0; cmpx:=80; cmpy := 25;
       while videomodeprt^[n] <> $ffff do
         begin
           if n mod 20 = 0 then
             begin
                write('Tecle <ENTER>');
                readln;
                clrscr;
                write  ('Modo#    Tipo     Resolu‡ao');
                writeln('       cores    tam. char');
             end;
           showmodeinfo(videomodeprt^[n]);
           inc(n);
         end;
         writeln;
       end;
       if cmpmode <>0 then
         begin
           write('Por  em ',cmpx,'x',cmpy,'modo Texto (S/N) ');
           repeat
             ch := upcase(readkey);
           until (ch = 'S') or (ch='N');
           writeln(ch);
           if ch = 'S' then
             begin
               if cmp8x8 then
                 textmode(lastmode or font8x8);
               setsupervgamode(cmpmode);
               window(1,1,100,75);
               checkwidthheight;
               for y := 1 to cmpy-1 do
                 begin
                   str(y:4, s);
                   s := s+'    *';
                   repeat
                     s := s+ '      *';
                   until length(s) > cmpx;
                   s[0] := char(cmpx);
                   fastwrite(s, 1, y, $0f);
                 end;
                str(cmpy:4,s);
                fastwrite(s,1,cmpy,$0f);
                fastwrite('Tecle <ENTER>', cmpx-15,cmpy,$8f);
                readln;
                textmode(vidmode);
              end;
          end;
end.


