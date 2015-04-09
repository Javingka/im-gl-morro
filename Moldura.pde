class Moldura {
  PVector posicao;
  int vWidth, vHeight;
  PGraphics filtro;
  Ponto p1, p2, p3, p4, pcentro;
  PVector rect1, rect2;
  int x1,x2,y1,y2; //coordenadas x e y dos retangulos que contém o circulo central
  
  Moldura () {
    setWidth(50);
    setHeight(100);
    setPosicaoInicial(width/2, height/2);
  }
  
  void update( float px, float py) {
     p1.isHover(px, py);
     p2.isHover(px, py);
     p3.isHover(px, py);
     p4.isHover(px, py);   
      
     PVector pc1 = PVector.add(new PVector(p3.x(), p3.y()), new PVector (p1.x(), p1.y()) );
     PVector pc2 = PVector.add(new PVector(p4.x(), p4.y()), new PVector (p2.x(), p2.y()) );
     PVector pc3 = PVector.add(pc1, pc2) ;
     float mp = pc3.mag();
     pc3.normalize();
     pc3.mult(mp/4);
     pcentro.setPosicao(pc3.x, pc3.y);
     
     PVector desp = pcentro.isHover(px, py);
     setPosicaoVariavel(desp);
   //    posicao = new PVector(pcentro.x(), pcentro.y());
     
  }
  void desenhaFigura(){
    fill(0,120);
    rectMode(CENTER);
    noFill();
    stroke(255, 102, 0);
 
 //Desenha poligono
    fill(255);
    quad(p1.x(), p1.y(), p2.x(), p2.y(), p3.x(), p3.y(), p4.x(), p4.y());
    
//Desenha centro
    PVector pontoBezier_1  = calculaVetor(new PVector(p4.x(), p4.y()), new PVector (p1.x(), p1.y()) );
    PVector pontoBezier_2  = calculaVetor(new PVector(p3.x(), p3.y()), new PVector (p2.x(), p2.y()) );
    PVector pontoBezier_3  = calculaVetor(new PVector(p1.x(), p1.y()), new PVector (p4.x(), p4.y()) );
    PVector pontoBezier_4  = calculaVetor(new PVector(p2.x(), p2.y()), new PVector (p3.x(), p3.y()) ); 
    fill(255,0,0,120);
    stroke(0, 0, 0);
    bezier( pontoBezier_1.x, pontoBezier_1.y, p1.x(), p1.y(), p2.x(), p2.y(), pontoBezier_2.x, pontoBezier_2.y);
    bezier( pontoBezier_3.x, pontoBezier_3.y, p4.x(), p4.y(), p3.x(), p3.y(), pontoBezier_4.x, pontoBezier_4.y);
    fill(255,0,0);
    text( pcentro.x() + " , " + pcentro.y() , pcentro.x()-20  , pcentro.y()+20 );
  //Desenha rect
    noFill();
    stroke(255);
    rectMode(CORNERS);
    x1 = int( min(p1.x(), p4.x()) );
    x2 = int( max(p2.x(), p3.x()) ); //<>//
    y1 = int( min(p1.y(), p2.y()) );
    y2 = int( max(p4.y(), p3.y()) );
    rect( x1 , y1,  x2,  y2);
    fill(255);
    text( (x2-x1) , x1 + ((x2-x1)/2) , y1-20);
    text( (y2-y1) , x1*.9, y1 + ((y2-y1)/2) );
    setWidth(x2-x1);
    rect1 = new PVector(x1, y1);
    rect2 = new PVector(x2, y2);
    setHeight(y2-y1);
    
//Desenha pontos
    p1.disenha();
    p2.disenha();
    p3.disenha();
    p4.disenha();
    pcentro.disenha();
  }
  
  private PVector calculaVetor (PVector pv1, PVector pv2) {
    PVector m = PVector.sub(pv1, pv2); 
    float mag = m.mag();
    m.normalize();
    m.setMag(mag/2);
    PVector np = new PVector( pv2.x+m.x , pv2.y+m.y ); 
    return np;
  }
  
  void desenhaFiltro() {
    PVector pontoBezier_1  = calculaVetor(new PVector(p4.x(), p4.y()), new PVector (p1.x(), p1.y()) );
    PVector pontoBezier_2  = calculaVetor(new PVector(p3.x(), p3.y()), new PVector (p2.x(), p2.y()) );
    strokeWeight(1);
    fill(0);
    noStroke();
    //filtro.beginDraw();
    beginShape();
    vertex(x1-5, y2);
    bezierVertex(x1-5, pontoBezier_1.y, x1-5, y2, x1-5, pontoBezier_1.y );
    bezierVertex(pontoBezier_1.x, pontoBezier_1.y,  x1-5, pontoBezier_1.y, pontoBezier_1.x, pontoBezier_1.y);
    bezierVertex( p4.x(), p4.y(),  p3.x(), p3.y(), pontoBezier_2.x, pontoBezier_2.y);
    bezierVertex(x2+5, pontoBezier_2.y, pontoBezier_2.x, pontoBezier_2.y, x2+5, pontoBezier_2.y);
    bezierVertex(x2+5, y2, x2+5, pontoBezier_2.y, x2+5, y2);
    endShape();
    beginShape();
    vertex(x1-5, y1);
    bezierVertex(x1-5, pontoBezier_1.y, x1-5, y1, x1-5, pontoBezier_1.y );
    bezierVertex(pontoBezier_1.x, pontoBezier_1.y,  x1-5, pontoBezier_1.y, pontoBezier_1.x, pontoBezier_1.y);
    bezierVertex( p1.x(), p1.y(),  p2.x(), p2.y(), pontoBezier_2.x, pontoBezier_2.y);
    bezierVertex(x2+5, pontoBezier_2.y, pontoBezier_2.x, pontoBezier_2.y, x2+5, pontoBezier_2.y);
    bezierVertex(x2+5, y1, x2+5, pontoBezier_2.y, x2+5, y1);
    endShape();
 
 }
 
/*===========
  SETTERS
  ==========*/
  
  void setWidth(int nw) {
    vWidth = nw;
  }
  void setHeight(int nh) {
    vHeight = nh;
  }
  void setPosicaoVariavel(PVector varia){
    p1.subPosicao(varia);
    p2.subPosicao(varia);
    p3.subPosicao(varia);
    p4.subPosicao(varia);
  }
  void setPosicaoInicial(float px, float py){
    posicao = new PVector(px, py);
    float p1x = posicao.x - vWidth/2;
    float p1y = posicao.y - vHeight/2;
    p1 = new Ponto(p1x, p1y); 
    float p2x = posicao.x + vWidth/2;
    float p2y = posicao.y - vHeight/2;
    p2 = new Ponto(p2x, p2y); 
    float p3x = posicao.x + vWidth/2;
    float p3y = posicao.y + vHeight/2;    
    p3 = new Ponto(p3x, p3y);
    float p4x = posicao.x - vWidth/2;
    float p4y = posicao.y + vHeight/2;
    p4 = new Ponto(p4x, p4y); 
    
    PVector pc = calculaVetor(new PVector(p3.x(), p3.y()), new PVector (p1.x(), p1.y()) );
    pcentro = new Ponto ( pc.x, pc.y );
  }
  
/*===========
  GETTERS
  ===========*/
  int getWidth (){
    return vWidth;  
  }
  int getHeight(){
    return vHeight;
  }
  PVector getPos(){
    return pcentro.getPos(); 
  }
  PVector getRecPont1() {
    return rect1;
  }
  PVector getRecPont2() {
    return rect2;
  }
  
  
  
}
