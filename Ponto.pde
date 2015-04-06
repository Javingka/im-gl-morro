class Ponto {
  PVector posicao;
  int cor;
  float diam;
  boolean presionando;
  
  Ponto ( float px, float py ) {
    posicao = new PVector(px, py);
    cor = color(255,0,0);
    diam = 10;
  }
  
  void disenha() {
    pushStyle();
    pushMatrix();
    translate(posicao.x, posicao.y);
    fill(cor);
    ellipse(0,0, diam, diam);
    popStyle();
    popMatrix();
  }
  
/*===========
  EDITING
  ===========*/
  PVector isHover(float tx, float ty){
    boolean resp = false;
    PVector rest = new PVector (0,0);
    
    float dist = PVector.dist(posicao, new PVector(tx,ty));
    if (dist < diam/2 ) {
      cor = color(255,255,0);
      if (mousePressed) {
        presionando = true;
      }
    } else {
      cor = color(255,0,0);
    }
    
    if (presionando) {
      rest = PVector.sub( posicao, new PVector(tx,ty));
      setPosicao(mouseX, mouseY);
      resp = true;
      
    }
    
    if (!mousePressed) {
      presionando = false;
    }
    
    return rest;
  }
  
/*===========
  SETTERS
  ===========*/
  
  void setPosicao(float px, float py){
    posicao = new PVector(px, py);
  }
  void subPosicao( PVector v){
    posicao.sub(v);
  }
  
/*===========
  GETTERS
  ===========*/
  float x (){return posicao.x;}
  float y (){return posicao.y;}
  PVector getPos(){return posicao;}
}
