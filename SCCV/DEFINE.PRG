PROCEDURE define_ctr
PRIVATE   vetpar[5]
   vetpar[1] = 2      && redefine botoes do mouse
   vetpar[2] = 1      && botao 1 = RETURN , botao 3 = ESC
   vetpar[3] = 13
   vetpar[4] = 2
   vetpar[5] = 27
   IF mouse_ativo = .T.
      BC_INICTR(110,vetpar)
      BC_DISLOC(9,disp_localizador)     && ativa cursor e mouse
   ELSE
      vetpar[1] = 0
      BC_INICTR(110,vetpar)
      BC_DISLOC(1,disp_localizador)     && ativa cursor
   ENDIF
   BC_DCUR(cor_cursor,tipo_cursor)
   BC_DELAST(-1, 1, 1)             && desativa o elastico
   IF ( (cursor_preso = .T.) .AND. (grade_ativa = .T.) )
      BC_DUTLOC(0,0,-1,"")         && cursor preso a grade
   ELSE
      BC_DUTLOC(0,0,0,"")          && cursor livre
   ENDIF
RETURN