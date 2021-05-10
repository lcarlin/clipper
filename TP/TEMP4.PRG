            @ m,  2 get aMatmat[m - 8][1] picture "9999" valid ;
               amatmat[m - 8][1] != 0
            @ m,  7 get aMatmat[m - 8][2] picture "@!" valid ;
               acha(amatmat[m - 8][2])
            read
            amatmat[m - 8][3]:= valunitv
            amatmat[m - 8][2]:= produto
            @ m,  7 get aMatmat[m - 8][2]
            @ m, 48 say amatmat[m - 8][3] * amatmat[m - 8][1] ;
               picture "99,999,999.99"
            clear gets
            nacdiv:= nacdiv + amatmat[m - 8][3] * amatmat[m - 8][1]
            @ 19,  8 say "Valor do Orcamento:"
            @ 19, Col() say nacdiv picture "99,999,999.99"
            if (LastKey() == K_ESC)
               m:= 9
               exit
            endif
         next