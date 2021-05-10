********************
function border 
parameters l , c, l2, c2, frt
if type([l])+type([c])+type([l2])+type([c2])<>"NNNN" .or. l < 0 .or. c < 0 .or. l2 > 24 .or. c2 > 77
   return .f.
endif
if l > l2
   swap(@l,@l2)
endif
if c > c2
   swap(@c,@c2)
endif
frt=if(type([frt])="U",8,min(frt,15))
shadow(l+1,c2+1,l2+1,c2+2,frt)
shadow(l2+1,c+1,l2+1,c2+2,frt)
return .t.
***************************
function shadow
parameters  y, x, y2, x2, corf, corb
*Private corf, corb, y, x, y2, x2, atr, nlen, svt, tmp,

if type([y])+type([x])+type([y2])+type([x2])<>"NNNN" .or. y < 0 .or. x < 0 .or. y2 > 24 .or. x2 > 79
   return .f.
endif
if y > y2
   swap(@y,@y2)
endif
if x > x2
   swap(@x,@x2)
endif
corf=if(type([corf])="U",8,min(corf,15))
corb=if(type([corb])="U",0,min(corb,15))
atr=(corb*16)+corf
nlen=(x2-x+1)*(y2-y+1)+(x2-x)
if nlen>960
   return .f.
endif
svt=savescreen(y,x,y2,x2)
restscreen(y,x,y2,x2,transform(svt,replicate([x]+chr(atr),nlen)))
return .t.

***3***************
function swap (par1, par2)
temp=par1
par1=par2
par2=temp
return .t.


