save screen to fecha
cCor := setcolor(cCorpadra)
nApre := setcursor(1)
centra(24,"Compacta‡„o de Arquivos.")
 
IF .NOT. Confirma("Confirma a Reindexa‡„o ?",cCorCaixa)
   setcursor(nApre)
   setcolor(cCor)
   restore screen from fecha
   RETURN
ENDIF
 
SOMBRA(03,02,17,75)
@ 04,03 say "                                                                        "
@ 05,03 say "   - Produto             - Cliente                - Cheque              "
@ 06,03 say "   - fornecedor          - Movimento              - Credito             "
@ 07,03 say "   - Grupo               - Credito                - Debito              "
@ 08,03 say "   - Saida               - Pagamento              - Deposito            "
@ 09,03 say "   - Entrada             - Movimento Morto        - Banco               "
@ 10,03 say "   - troca               - Credito Morto          - Duplicata           "
@ 11,03 say "   - deteorados          - Senha                  - Predatado           "
@ 12,03 say "   - Acerto              - Mapa Resumo            - Notas               "
@ 13,03 say "   - LH                  - Manuten‡„o             - Devolu‡™es          "
@ 14,03 say "   - Cota‡„o             - Semafaro                                     "
@ 15,03 say "   - Vasilhame                                                          "
@ 16,03 say "   - Emprestimo                                                         "
setcolor(ccorcaixa)
@ 03,03 say " Arquivos do Estoque   Arquivos do Cliente      Arquivo do Banco        "
centra(24,"Aguarde!! realizando o processamento","r*/n")
 
SELECT 1
IF NETUSE("SEMAFARO",.F.,10)
   SET INDEX TO SEMAFARO
ELSE
   setcolor(cCorAnt)
   restore screen from fecha
   close all
   return
ENDIF
 
SELECT 2
IF NETUSE("CONSEN",.F.,10)
   SET INDEX TO OPER_A
else
   setcolor(cCorAnt)
   restore screen from fecha
   close all
   return
endif
 
select 3
if netuse("pdv_plu",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 05,04 say chr(219)
   setcolor("W/N")
   index on cod_item               to pdv_plu
   index on codigo1+dsc_item       to prod_b
   index on codigo2+dsc_item       to prod_c
   index on dsc_item               to plu_dsc
   index on gondola+dsc_item       to prod_e
   @ 05,04 say chr(251)
   DESTRARQ("PDV_PLU")
   close pdv_plu
else
   QUEMTRAVA("PDV_PLU")
   mensagemt("O arquivo de produto n„o foi reindexado. Ok!")
endif
 
SELECT 4
IF NETUSE("FORNECEDOR",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 06,04 say chr(219)
   setcolor("W/N")
   index on codigo                 to forn_a
   index on nome                   to forn_b
   index on fantasia               to forn_c
   index on cidade                 to forn_d
   @ 06,04 say chr(251)
   DESTRARQ("FORNECEDOR")
   close fornecedor
ELSE
   quemtrava("FORNECEDOR")
   mensagemt("O arquivo de fornecedor n„o foi reindexado. Ok!")
endif
 
select 5
if netuse("grupo",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 07,04 say chr(219)
   setcolor("W/N")
   index on codigo                 to grup_a
   index on nome                   to grup_b
   @ 07,04 say chr(251)
   DESTRARQ("GRUPO")
   close grupo
else
   quemtrava("GRUPO")
   mensagemt("O arquivo de grupo n„o foi reindexado. Ok!")
endif
 
SELECT 6
IF NETUSE("SAIDA",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 08,04 say chr(219)
   setcolor("W/N")
   index on cod_item               to said_a
   index on dsc_item               to said_b
   index on data                   to said_c
   index on grupo                  to said_d
   @ 08,04 say chr(251)
   DESTRARQ("SAIDA")
   close SAIDA
ELSE
   queMtrava("SAIDA")
   mensagemt("O arquivo de saida n„o foi reindexado. Ok!")
endif
 
 
SELECT 7
IF NETUSE("ENTRADA",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 09,04 say chr(219)
   setcolor("W/N")
   index on cod_item               to entr_a
   index on dsc_item               to entr_b
   index on data                   to entr_c
   @ 09,04 say chr(251)
   DESTRARQ("ENTRADA")
   close entrada
ELSE
   queMtrava("ENTRADA")
   mensagemt("O arquivo de entrada n„o foi reindexado. Ok!")
endif
 
 
SELECT 8
IF NETUSE("TROCA",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 10,04 say chr(219)
   setcolor("W/N")
   index on cod_item               to troc_a
   index on dsc_item               to troc_b
   index on data                   to troc_c
   index on grupo                  to troc_d
   @ 10,04 say chr(251)
   DESTRARQ("TROCA")
   close troca
ELSE
   queMtrava("TROCA")
   mensagemt("O arquivo de troca n„o foi reindexado. Ok!")
endif
 
 
SELECT 9
IF NETUSE("DETEORA",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 11,04 say chr(219)
   setcolor("W/N")
   index on cod_item               to dete_a
   index on dsc_item               to dete_b
   index on data                   to dete_c
   index on grupo                  to dete_d
   @ 11,04 say chr(251)
   DESTRARQ("DETEORA")
   close deteora
ELSE
   queMtrava("DETEORA")
   mensagemt("O arquivo de deteorados n„o foi reindexado. Ok!")
endif
 
 
SELECT 10
IF NETUSE("ACERTO",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 12,04 say chr(219)
   setcolor("W/N")
   index on cod_item               to acer_a
   index on dsc_item               to acer_b
   index on data                   to acer_c
   index on grupo                  to acer_d
   @ 12,04 say chr(251)
   DESTRARQ("ACERTO")
   close acerto
ELSE
   queMtrava("ACERTO")
   mensagemt("O arquivo de acerto n„o foi reindexado. Ok!")
endif
 
SELECT 11
IF NETUSE("LHSNT",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 13,04 say chr(219)
   setcolor("W/N")
   index on cod_item               to lhsn_a
   index on dsc_item               to lhsn_b
   index on data                   to lhsn_c
   index on grupo                  to lhsn_d
   @ 13,04 say chr(251)
   DESTRARQ("LHSNT")
   close LHSNT
ELSE
   queMtrava("LHSNT")
   mensagemt("O arquivo de LH n„o foi reindexado. Ok!")
endif
 
SELECT 12
IF NETUSE("COTACAO",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 14,04 say chr(219)
   index on codigo                 to cota_a
   index on produto                to cota_b
   setcolor("W/N")
   @ 14,04 say chr(251)
   DESTRARQ("COTACAO")
   close cotacao
ELSE
   queMtrava("COTACAO")
   mensagemt("O arquivo de cota‡„o n„o foi reindexado. Ok!")
endif
 
SELECT 13
IF NETUSE("FLAYVASI",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 15,04 say chr(219)
   INDEX ON CODIGO                 TO VASI_A
   INDEX ON NOME                   TO VASI_B
   setcolor("W/N")
   @ 15,04 say chr(251)
   DESTRARQ("FLAYVASI")
   close flayvasi
ELSE
   queMtrava("FLAYVASI")
   mensagemt("O arquivo de vasilhame n„o foi reindexado. Ok!")
endif
 
SELECT 14
IF NETUSE("FLAYVATO",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 16,04 say chr(219)
   INDEX ON CLIENTE                TO VATO_A
   INDEX ON END                    TO VATO_B
   setcolor("W/N")
   @ 16,04 say chr(251)
   DESTRARQ("FLAYVATO")
   close flayvato
ELSE
   queMtrava("FLAYVATO")
   mensagemt("O arquivo de Emprestimo n„o foi reindexado. Ok!")
endif
 
select 15
IF NETUSE("diclient",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 05,26 say chr(219)
   setcolor("W/N")
   index on codigo                 to dicl_a
   index on nomcli                 to dicl_b
   index on nomfan                 to dicl_c
   index on endres                 to dicl_d
   index on cidres                 to dicl_e
   index on month(faxres)          to dicl_f
   @ 05,26 say chr(251)
   DESTRARQ("DICLIENT")
   close DICLIENT
ELSE
   quemtrava("DICLIENT")
   mensagemt("O arquivo de cliente n„o foi reindexado. Ok!")
endif
 
SELECT 16
IF NETUSE("dimovime",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 06,26 say chr(219)
   setcolor("W/N")
   index on ordem                  to dimo_a
   index on cheqn                  to dimo_b
   index on codcl                  to dimo_c
   index on nomec                  to dimo_d
   index on datco                  to dimo_e
   index on valco                  to dimo_f
   @ 06,26 say chr(251)
   DESTRARQ("DIMOVIME")
   close DIMOVIME
ELSE
   quentrava("DIMOVIME")
   mensagemt("O arquivo de movimento n„o foi reindexado. Ok!")
endif
 
SELECT 17
IF NETUSE("DICREDIT",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 07,26 say chr(219)
   setcolor("W/N")
   index on ordem                  to dicr_a
   index on deve                   to dicr_b
   index on nome                   to dicr_c
   index on data                   to dicr_d
   @ 07,26 say chr(251)
   DESTRARQ("DICREDIT")
   close DICREDIT
ELSE
   QUEMTRAVA("DICREDIT")
   mensagemt("O arquivo de cr‚dito n„o foi reindexado. Ok!")
endif
 
SELECT 18
IF NETUSE("diapaga",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 08,26 say chr(219)
   setcolor("W/N")
   index on codigo                 to apag_a
   index on nome                   to apag_b
   index on data                   to apag_c
   @ 08,26 say chr(251)
   DESTRARQ("DIAPAGA")
   close DIAPAGA
ELSE
   QUEMTRAVA("DIAPAGA")
   mensagemt("O arquivo de pagamentos n„o foi reindexado. Ok!")
endif
 
SELECT 19
IF NETUSE("dimovmor",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 09,26 say chr(219)
   setcolor("W/N")
   index on  ordem                 to dimm_a
   index on  cheqn                 to dimm_b
   index on  codcl                 to dimm_c
   index on  nomec                 to dimm_d
   index on  datco                 to dimm_e
   @ 09,26 say chr(251)
   DESTRARQ("DIMOVMOR")
   close DIMOVMOR
ELSE
   QUEMTRAVA("DIMOVMOR")
   mensagemt("O arquivo de movimento morto n„o foi reindexado. Ok!")
endif
 
SELECT 20
IF NETUSE("DICREMOR",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 10,26 say chr(219)
   setcolor("W/N")
   index on ordem                  to dicc_a
   index on deve                   to dicc_b
   index on nome                   to dicc_c
   index on data                   to dicc_d
   @ 10,26 say chr(251)
   DESTRARQ("DICREMOR")
   close DICREMOR
ELSE
   QUEMTRAVA("DICREMOR")
   mensagemt("O arquivo de cr‚dito morto n„o foi reindexado. Ok!")
endif
 
 
SELECT 21
IF NETUSE("CONSEN",.F.,10)
   setcolor("W*/N")
   @ 11,26 say chr(219)
   setcolor("W/N")
   @ 11,26 say chr(251)
ELSE
   QUEMTRAVA("CONSEN")
   mensagemt("O arquivo de senha n„o foi reindexado. Ok!")
endif
 
 
 
SELECT 22
IF NETUSE("PDV_RES",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 12,26 say chr(219)
   index on GT01                   to pdv_res
   setcolor("W/N")
   @ 12,26 say chr(251)
   DESTRARQ("PDV_RES")
   close PDV_RES
ELSE
   QUEMTRAVA("PDV_RES")
   mensagemt("O arquivo de Resumo de Caixa n„o foi reindexado. Ok!")
endif
 
SELECT 23
IF NETUSE("dimanute",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 13,26 say chr(219)
   index on cod                    to dima_a
   setcolor("W/N")
   @ 13,26 say chr(251)
   DESTRARQ("DIMANUTE")
   close DIMANUTE
ELSE
   QUEMTRAVA("DIMANUTE")
   mensagemt("O arquivo de Manuten‡„o n„o foi reindexado. Ok!")
endif
 
 
SELECT 24
IF NETUSE("SEMAFARO",.F.,10)
   setcolor("W*/N")
   @ 14,26 say chr(219)
   setcolor("W/N")
   @ 14,26 say chr(251)
ELSE
   QUEMTRAVA("SEMAFARO")
   mensagemt("O arquivo de Semafaro n„o foi reindexado. Ok!")
endif
 
SELECT 25
IF NETUSE("CHEQUE",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 05,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flych_a
   index on fornecedor             to flych_b
   index on data                   to flych_c
   index on datven                 to flych_d
   index on numero                 to flych_e
   index on datbaix                to flych_f
   @ 05,51 say chr(251)
   DESTRARQ("CHEQUE")
   close CHEQUE
ELSE
   quemtrava("CHEQUE")
   mensagemt("O arquivo de cheque n„o foi reindexado. Ok!")
endif
 
 
SELECT 26
IF NETUSE("credito",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 06,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flycr_a
   index on fornecedor             to flycr_b
   index on data                   to flycr_c
   index on datven                 to flycr_d
   index on numero                 to flycr_e
   index on datbaix                to flycr_f
   @ 06,51 say chr(251)
   DESTRARQ("CREDITO")
   close CREDITO
ELSE
   quemtrava("CREDITO")
   mensagemt("O arquivo de cr‚dito n„o foi reindexado. Ok!")
ENDIF
 
 
SELECT 27
IF NETUSE("DEBITO",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 07,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flyde_a
   index on fornecedor             to flyde_b
   index on data                   to flyde_c
   index on datven                 to flyde_d
   index on numero                 to flyde_e
   index on datbaix                to flyde_f
   @ 07,51 say chr(251)
   DESTRARQ("DEBITO")
   close DEBITO
ELSE
   QUEMTRAVA("DEBITO")
   mensagemt("O arquivo de d‚bito n„o foi reindexado. Ok!")
ENDIF
 
 
SELECT 28
IF NETUSE("DEPOSIT",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 08,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flydt_a
   index on fornecedor             to flydt_b
   index on data                   to flydt_c
   index on datven                 to flydt_d
   index on numero                 to flydt_e
   index on datbaix                to flydt_f
   @ 08,51 say chr(251)
   DESTRARQ("DEPOSIT")
   close DEPOSIT
ELSE
   quemtrava("DEPOSIT")
   mensagemt("O arquivo de deposito n„o foi reindexado. Ok!")
endif
 
SELECT 29
IF NETUSE("banco",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 09,51 say chr(219)
   setcolor("W/N")
   index on codigo                 to flaygr_a
   index on banco                  to flaygr_b
   @ 09,51 say chr(251)
   DESTRARQ("BANCO")
   close BANCO
ELSE
   quemtrava("BANCO")
   mensagemt("O arquivo de banco n„o foi reindexado. Ok!")
endif
 
 
SELECT 30
IF NETUSE("duplicat",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 10,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flydu_a
   index on fornecedor             to flydu_b
   index on data                   to flydu_c
   index on datven                 to flydu_d
   index on numero                 to flydu_e
   index on datbaix                to flydu_f
   @ 10,51 say chr(251)
   DESTRARQ("DUPLICAT")
   close DUPLICAT
ELSE
   QUEMTRAVA("DUPLICAT")
   mensagemt("O arquivo de duplicata n„o foi reindexado. Ok!")
endif
 
 
SELECT 31
IF NETUSE("predatad",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 11,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flypr_a
   index on fornecedor             to flypr_b
   index on data                   to flypr_c
   index on datven                 to flypr_d
   index on numero                 to flypr_e
   index on datbaix                to flypr_f
   @ 11,51 say chr(251)
   DESTRARQ("PREDATAD")
   close predatad
ELSE
   QUEMTRAVA("PREDATAD")
   mensagemt("O arquivo de pr‚-datado n„o foi reindexado. Ok!")
endif
 
select 32
IF NETUSE("nota",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 12,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flyno_a
   index on fornecedor             to flyno_b
   index on data                   to flyno_c
   index on datven                 to flyno_d
   index on numero                 to flyno_e
   index on datent                 to flyno_f
   @ 12,51 say chr(251)
   DESTRARQ("NOTA")
   close nota
ELSE
   QUEMTRAVA("NOTA")
   mensagemt("O arquivo de nota n„o foi reindexado. Ok!")
endif
 
SELECT 33
IF NETUSE("devoluc",.T.,10)
   filock(0)
   setcolor("W*/N")
   @ 13,51 say chr(219)
   setcolor("W/N")
   index on ordem                  to flydo_a
   index on fornecedor             to flydo_b
   index on data                   to flydo_c
   index on datven                 to flydo_d
   index on numero                 to flydo_e
   index on datbaix                to flydo_f
   @ 13,51 say chr(251)
   DESTRARQ("devoluc")
   close devoluc
ELSE
   quemtrava("DEVOLUC")
   mensagemt("O arquivo de devolu‡„o n„o foi reindexado. Ok!")
endif
CLOSE all
mensagemt("Arqu¡vos todos reindexados...")
setcolor(CcOR)
setcursor(nApre)
RETURN
