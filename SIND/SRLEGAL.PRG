cConteudo   :=     ; 
   cripto("CS # 1995 Controle de Estoque v1.0 - L.A.C. - {O Corsario(tm)}")
nNumero := FCREATE("C:\WINB30.486",2)
nfim := fwrite(nNumero,cConteudo)
? "Arquivo gerado..."
