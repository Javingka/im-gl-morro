class FraseAoParticula {
  ArrayList <RShape> linhasF; //as linhas de texto
  ArrayList <RPoint[]> pontosFrase;  //Array com os pontos pela cada frase
  ArrayList <RPoint[]> pontosFrasePrevia; 
  ArrayList <PVector> pontosPos; //array ocm todas as posiçōes
  ArrayList <PVector> pontosPosDeriva; //array ocm todas as posiçōes
  ArrayList <PVector> velocidadeDeriva; //velocidade dos pontos na deriva
  PVector centro; //centro do texto
  float posSup; //posicao superior do texto
  float distDasFrases; //espaço entre uma fra e a seguente
  int tamanhoTexto; //tamanho do texto
  String nombreFuente;
  int frasCant;
  int distEntrePontos;
  int totalPontos;
  color frs;
  float alphaFrase;
  
  FraseAoParticula (PVector _centro, int _tt) {
    centro = _centro;
    tamanhoTexto = _tt;
    pontosFrase = new ArrayList <RPoint[]>();
    pontosFrasePrevia = new ArrayList <RPoint[]>();
    linhasF = new ArrayList <RShape>();
    pontosPos = new ArrayList <PVector>();
    pontosPosDeriva = new ArrayList <PVector>();
    velocidadeDeriva = new ArrayList <PVector>();
    nombreFuente = "Arial.ttf";//Mistral.ttf";
    frasCant=0;
    distEntrePontos = 3; //pixels entre cada ponto da frase
    totalPontos = 0;
    distDasFrases = tamanhoTexto * 1.5;
    frs = color(255);
    alphaFrase = 0; //alpha pra apariçāo da frase
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(distEntrePontos);
     
  }
  
  void mudaCentro () {
    centro = new PVector (mouseX, mouseY);
    println ("novo centro: "+centro);
  }
  void geraFrase (String [] frases) {
//    println ("frases: "+frases[0]); 
      linhasF.clear();
      pontosFrase.clear();
      pontosFrasePrevia.clear();
      pontosPos.clear();
      pontosPosDeriva.clear();
      velocidadeDeriva.clear();
      totalPontos = 0;
      
    frasCant = frases.length;
    
    for (int f = 0 ; f < frasCant ; f++ ) {
      linhasF.add (RG.getText (frases[f], nombreFuente, tamanhoTexto, RFont.CENTER) );
    }
    posSup = centro.y - (  distDasFrases * (frasCant/2) );
    geraPontosFrase(); //Geramos os pontos de cada frase 
    geraPosPontos();
    
  }
  
  void geraPontosFrase() {
     
     for (int p = 0 ; p < frasCant ; p++ ) {
      pontosFrase.add (linhasF.get(p).getPoints() );
    } 
//    println ("totalPontos: "+totalPontos);
  } 
  
    void geraPosPontos () {
    int i=0;
    for (RPoint [] LinhaPonto : pontosFrase) {
      for (RPoint p : LinhaPonto) {
        pontosPos.add (new PVector(p.x + centro.x , p.y + posSup + (distDasFrases * i)) );
        pontosPosDeriva.add ( new PVector (random(movimentoPontos.x1, movimentoPontos.x2),
                                  random(movimentoPontos.y1, movimentoPontos.y2) ) );
        totalPontos++;// = totalPontos+pontosFrase.get(p).length; //vamos somando os pontos
      }
      i++;   
    }
  }
  
  int ObterTotalPontos(){
    return totalPontos;
  }
  
  void setAlpha() {
    alphaFrase = 0;
  }
  void desenhaFrase() {
    pushStyle();
      fill(frs, alphaFrase);
      stroke(frs, alphaFrase); strokeWeight(1);
      noStroke();
      int i=0;
      
      for (RShape f : linhasF) {
        pushMatrix();
        translate (centro.x, posSup + (distDasFrases * i) );
        f.draw();
        popMatrix(); 
        i++;
      }
    popStyle();
//    alphaFrase+=4;
//    alphaFrase = constrain(alphaFrase, 0, 255);
    println ("Disenha Frase - alphaFrase: "+alphaFrase);
  }
  
  void atualizaDeriba() {
    int i=0;
    for (PVector ppd : pontosPosDeriva) {
      ppd.add(new PVector (random (-2,2), random(-2,2) ));
      i++;
    }
  }
  
  void desenhaPontosFrase() {
    pushStyle();
    stroke(frs); 
    strokeWeight(1);
      
    int i=0;
    for (RPoint [] LinhaPonto : pontosFrase) { //pegamos os array dentor lo arrayList
      
      for (RPoint p : LinhaPonto) { //Percorre cada um dos arrays
          point ( p.x + centro.x , p.y + posSup + (distDasFrases * i));
      }
      i++;
    }
    
    popStyle();
  }
}
