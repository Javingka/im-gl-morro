class MovimentoPontos extends FraseAoParticula {
  ArrayList<PontoSolto> pontosSoltos;
  float largura;
  float altura;
  float x1, x2, y1, y2;
  private boolean pontosEmPos;
  private boolean partidaDaFrase;
  
  MovimentoPontos (PVector _centro, int _tt, float _largura, float _altura) {
    //Aquinao se ve mais carga o construtor da clase FraseAoParticula
    super (_centro, _tt);
    pontosSoltos = new ArrayList<PontoSolto>(); 
    largura = _largura;
    altura = _altura;
    x1 = centro.x - (largura / 2) ;
    y1 = centro.y - (altura / 2) ;
    x2 = centro.x + (largura / 2) ;
    y2 = centro.y + (altura / 2) ; 
    pontosEmPos = false;
    partidaDaFrase = false;
  }
  
  void mostraZona() {
   pushMatrix();
   pushStyle();
   rectMode (CENTER);
   stroke (255,0,0);
   noFill();
     translate (centro.x, centro.y);
     rect (0,0, largura, altura);
   popStyle();
   popMatrix();
  }
  
  void geraPontosSoltos() {
     pontosSoltos.clear();
     pontosEmPos = false;
     partidaDaFrase = false;
     for (int p = 0 ; p < ObterTotalPontos() ; p++ ) {
       pontosSoltos.add(new PontoSolto(random(x1, x2),random(y1, y2), color (255) ) );
     }
     
  }
  
  void desenhaPontosPraFrase() {
    int index = 0;
    int CantPontosEmPos = 0;
//    println ("pontosSoltos.length: "+pontosSoltos.size() );
//     println ("pontosPos.length: "+ pontosPos.size() );
    boolean partidaAnt = partidaDaFrase; //pra saber quando se produz a mudança da variavel
//    if (!pontosEmPos) {
      for (PontoSolto p : pontosSoltos) {
        p.PontoNaFrase(pontosPos.get(index));
        p.atualiza();
        p.mostra(true);
  //      p.bordes();
        if (p.PontoEmFrase()) {//somamos os pontos em posiçāo
          CantPontosEmPos++;
        }
        index++;
      }
//    } 
    
  /*   if (CantPontosEmPos > index/3) 
      if (!partidaDaFrase) partidaDaFrase = true;
    if ( !partidaAnt && partidaDaFrase)
      setAlpha();
      
   if (partidaDaFrase) {
      desenhaFrase();
    }*/
    
  /*  if (CantPontosEmPos > index/3) { //== index) {
      pontosEmPos = true;
    } */
    //println ("pontosEmPosicao: "+pontosEmPos);
  }
  
  void desenhaPontosSoltos() {
    int index = 0;
    for (PontoSolto p : pontosSoltos) {
        p.PontoEmMov(pontosPosDeriva.get(index) );
        p.atualiza();
        p.mostra(false);
        p.bordes();
        index++;
      }
  }
}
