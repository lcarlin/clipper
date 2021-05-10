*---------------------------------------------------------------------------*
* EDITOR GRAFICO da CLBC 2.7                   (c) SoftCAD Informatica 1992 *
*---------------------------------------------------------------------------*
* Arquivo  : DESARQ.PRG          rotina para desenho de DBF                 *
*                                                                           *
* Descricao: Este arquivo contem a funcao DESENHA_DBF que permite que um    *
*            arquivo DBF de desenho seja apresentado na tela.               *
*                                                                           *
*            O primeiro parametro da funcao especifica o nome do arquivo a  *
*            ser desenhado. A funcao checa inicialmente se o arquivo e'     *
*            realmente um arquivo de desenho. Se for, le os dados e apre-   *
*            nta o desenho na tela. Para maiores detalhes sobre o formato   *
*            do arquivo de desenho, consulte o arquivo EDITOR.DOC.          *
*                                                                           *
*            A funcao DESENHA_DBF utiliza algumas funcoes auxiliares        *
*            (presentes neste arquivo). Sao elas:                           *
*                                                                           *
*            DES_RETANGULO    Le os dados e desenha um retangulo            *
*            DES_CIRCUNF      Idem para circunferencia                      *
*            DES_MARCA        Idem para polimarca                           *
*            DES_POLILINHA    Idem para polilinha                           *
*            DES_ELIPSE       Idem para elipse                              *
*                                                                           *
*            FORMATO_VALIDO   Verifica se o formato do arquivo DBF e'       *
*                             valido.                                       *
*                                                                           *
* ATENCAO:   A DESENHA_DBF permite que as polilinhas sejam desenhadas atra- *
*            ves do 'efeito laser', o que e' habilitado se o segundo para-  *
*            metro da funcao for .T.. Por isto, e' necessario que o arquivo *
*            LASER.OBJ seja linkado ao programa. Caso este efeito nao seja  *
*            desejado, recomenda-se eliminar o acionamento da funcao        *
*            desenha_laser() dentro da DESENHA_POLILINHA. Desta maneira,    *
*            torna-se desnecessaria a linkedicao do arquivo LASER.OBJ.      *
*---------------------------------------------------------------------------*


*****************************************************************************
 FUNCTION  DESENHA_DBF
 PARAMETER nome_arq, usa_laser
*****************************************************************************

    * Abre o arquivo e testa se e' realmente arquivo de desenho
    IF ! formato_valido(nome_arq)
       RETURN .F.                      && Nao e' arquivo de desenho
    ENDIF

    * Define as variaveis que serao utilizadas na leitura do arquivo
    PRIVATE cor, padrao, x1, y1, x2, y2, raio, centrox, centroy
    PRIVATE angi, angf, anginc, n_marcas, n_vertices, eixoh, eixov, i

    SKIP
    DO WHILE .NOT. EOF()       && enquanto nao for fim de arquivo
       DO CASE
          case alltrim(campo_1) == "RETANGULO"  && se for retangulo
               DES_RETANGULO()
          case alltrim(campo_1) == "CIRCULO"    && se for circunferencia
               DES_CIRCUNF()
          case alltrim(campo_1) == "POLIMARCA"  && se for polimarca
               DES_MARCA()
          case alltrim(campo_1) == "POLILINHA"  && se for polilinha
               DES_POLILINHA()
          case alltrim(campo_1) == "ELIPSE"     && se for elipse
               DES_ELIPSE()
       ENDCASE
       SKIP
    ENDDO
RETURN .t.


*****************************************************************************
 PROCEDURE DES_RETANGULO
*****************************************************************************

    SKIP
    cor = VAL(ALLTRIM(campo_1))        && le cor e padrao
    padrao = VAL(ALLTRIM(campo_2))
    SKIP
    x1 = VAL(ALLTRIM(campo_1))         && le coordenadas do retangulo
    y1 = VAL(ALLTRIM(campo_2))
    SKIP
    x2 = VAL(ALLTRIM(campo_1))
    y2 = VAL(ALLTRIM(campo_2))

    BC_DRETAN(cor,padrao)         && define atributos do retangulo
    BC_RETANG(x1, y1, x2 ,y2)     && desenha retangulo

RETURN


*****************************************************************************
 PROCEDURE DES_CIRCUNF
*****************************************************************************

    raio = VAL(campo_2)               && le raio
    SKIP
    cor = VAL(ALLTRIM(campo_1))       && le cor e padrao
    padrao = VAL(ALLTRIM(campo_2))
    SKIP
    centrox = VAL(ALLTRIM(campo_1))   && le centro
    centroy = VAL(ALLTRIM(campo_2))
    SKIP
    angi = VAL(ALLTRIM(campo_1))      && le angulos
    angf = VAL(ALLTRIM(campo_2))

    BC_DCIRC(cor,padrao)              && define circunferencia
    BC_CIRCUN(centrox, centroy, raio ,angi,angf)   && desenha circunferencia

RETURN


*****************************************************************************
 PROCEDURE DES_MARCA
*****************************************************************************

    n_marcas = VAL(campo_2)          && le numero de marcas
    SKIP
    cor = VAL(ALLTRIM(campo_1))      && le cor e padrao
    padrao = VAL(ALLTRIM(campo_2))
    PRIVATE vetaux[ 2*n_marcas ]     && variavel auxiliar que contera

    FOR i=1 to n_marcas              && as coordenadas das marcas
        SKIP
        vetaux[2*i-1] = VAL(ALLTRIM(campo_1))
        vetaux[2*i  ] = VAL(ALLTRIM(campo_2))
    NEXT

    BC_DPMAR(cor,padrao)             && define atributos da marca
    BC_PMARCA(n_marcas,vetaux)       && desenha as marcas

RETURN


*****************************************************************************
 PROCEDURE DES_POLILINHA
*****************************************************************************

    n_vertices = VAL(campo_2)            && le numero de vertices
    SKIP
    cor = VAL(ALLTRIM(campo_1))          && le cor e padrao
    padrao = VAL(ALLTRIM(campo_2))

    PRIVATE vetaux[ 2*n_vertices ]       && declara vetor auxiliar

    * Le coordenadas dos vertices
    FOR i=1 to n_vertices
        SKIP
        vetaux[2*i-1] = VAL(ALLTRIM(campo_1))
        vetaux[2*i  ] = VAL(ALLTRIM(campo_2))
    NEXT

    BC_DPLIN(cor,padrao)                 && define atributos da polilinha

    * Testa se deve usar o 'efeito laser'
    IF usa_laser
     *  desenha_laser(n_vertices, vetaux)
    else
       BC_PLINHA(n_vertices,vetaux)         && desenha polilinha
    endif

RETURN


*****************************************************************************
 PROCEDURE DES_ELIPSE
*****************************************************************************

    anginc = VAL(campo_2)               && le angulo de inclinacao
    SKIP
    cor = VAL(ALLTRIM(campo_1))         && le cor e padrao
    padrao = VAL(ALLTRIM(campo_2))
    SKIP
    centrox = VAL(ALLTRIM(campo_1))     && le centro da elipse
    centroy = VAL(ALLTRIM(campo_2))
    SKIP
    eixoh = VAL(ALLTRIM(campo_1))       && le semi-eixos da elipse
    eixov = VAL(ALLTRIM(campo_2))
    SKIP
    angi = VAL(ALLTRIM(campo_1))        && le angulos inicial e final
    angf = VAL(ALLTRIM(campo_2))

    BC_DELIP(cor,padrao)                && define atributos da elipse

    * Desenha elipse
    BC_ELIPSE(centrox, centroy,eixoh , eixov ,angi,angf , anginc)

RETURN


****************************************************************************
 FUNCTION FORMATO_VALIDO
****************************************************************************
                             && Esta funcao verifica se um arquivo DBF e'
                             && arquivo de desenho. Se for, retorna .T.,
                             && caso contrario, retorna .F.

   USE &nome_arq                       && Abre arquivo de desenho

   PRIVATE  numero_campos
   numero_campos = FCOUNT()

   * Obtem a estrutura do arquivo

   PRIVATE nome_campos[2],tipo_campos[2]
   PRIVATE tamanho_campos[2] , casas_decimais[2]
   AFIELDS(nome_campos, tipo_campos, tamanho_campos, casas_decimais)

   * Testa se a estrutura corresponde a um arquivo de desenho

   IF ( (numero_campos != 2)  .OR. (nome_campos[1] != "CAMPO_1") .OR.;
      (nome_campos[2] != "CAMPO_2") .OR. (tipo_campos[1] != "C") .OR.;
      (tipo_campos[2] != "C")   .OR.   (tamanho_campos[1] != 10) .OR.;
      (tamanho_campos[2] != 10) )

      USE
      RETURN .F.
   ENDIF

   * Testa o identificador do arquivo (1o. registro)

   IF ( ( campo_1 != "CLBC des") .OR. ( campo_2 !="versao 1.0") )
      USE
      RETURN .F.
   ENDIF

RETURN .T.

