   vetpar[1] = 0
   BC_INIC(0,0)                    && entra no contexto CLBC
   BC_JANVD(janx1 , jany1 , janx2 , jany2)    && define janela de video
   BC_VIUPVD(0.0, 0.0, 1.0, 1.0)   && define viuporte de video (tela inteira)
   BC_DELAST(-1, 1, 1)             && desativa o elastico
   BC_DCUR(cor_cursor, tipo_cursor)
      && posiciona localizador no centro do video
   BC_POSLOC( (janx2+janx1) / 2 , (jany2+jany1) / 2 )
   BC_REACUR(15, 0, 0.10, 0.0125, 0.04, 0, 0, -0.05, 8, 3)

   * Testa se ha' driver de mouse (driver do fabricante)
   IF BC_INICTR(110, vetpar) = 1
      mouse_ativo = .t.
   ELSE
      mouse_ativo = .f.
   ENDIF

   define_ctr()     