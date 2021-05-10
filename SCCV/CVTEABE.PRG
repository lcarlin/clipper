*******************************
* telas do sistema
* 24/06/94
*********************************
SET PROC TO DESARQ
public estrada
declare vet[1]
vet = 0
bc_inic(0,0)
BC_VIUPVD(0.0, 0.0, 1.0, 1.0)   && define viuporte de video (tela inteira)
BC_DELAST(-1, 1, 1)             && desativa o elastico
placa = bc_inictr(25,vet)
if placa = 0
   placa = bc_inictr(20,vet)
   if placa = 0
      placa = bc_inictr(21,vet)
      if placa = 0
	 set color to
	 @10,0 say "Adaptadores Graficos nao Compativeis; SCCV no Modo Grafico nao Pode Ser Ativado"
	 inkey(0)
	 bc_fim(0)
	 ?
	 ?
	 quit
      endif
   endif
endif
bc_arqvd(0.00 ,0.00 ,"cvteabe.pcx",1)
set color to w/b
INKEY(2)
bc_FIM(0)
return

