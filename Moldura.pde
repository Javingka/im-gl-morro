class Moldura {
  PVector posicao;
  int vWidth, vHeight;
  PGraphics filtro;
  Ponto p1, p2, p3, p4, pcentro;
  PVector rect1, rect2;
  
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

  //Desenha rect
    noFill();
    stroke(255);
    rectMode(CORNERS);
    int x1 = int( min(p1.x(), p4.x()) );
    int x2 = int( max(p2.x(), p3.x()) ); //<>//
    int y1 = int( min(p1.y(), p2.y()) );
    int y2 = int( max(p4.y(), p3.y()) );
    rect( x1 , y1,  x2,  y2);
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
    filtro = createGraphics(vWidth, vHeight);
    PVector pontoBezier_1  = calculaVetor(new PVector(p4.x(), p4.y()), new PVector (p1.x(), p1.y()) );
    PVector pontoBezier_2  = calculaVetor(new PVector(p3.x(), p3.y()), new PVector (p2.x(), p2.y()) );
    PVector pontoBezier_3  = calculaVetor(new PVector(p1.x(), p1.y()), new PVector (p4.x(), p4.y()) );
    PVector pontoBezier_4  = calculaVetor(new PVector(p2.x(), p2.y()), new PVector (p3.x(), p3.y()) ); 
    
    filtro.fill(255);
    //filtro.beginDraw();
    beginShape();
    vertex(p1.x(), p1.y() );
    bezierVertex(p2.x(), p2.y(), p1.x(), p1.y(), p2.x(), p2.y());
    bezierVertex(p3.x(), p3.y(), p2.x(), p2.y(), p3.x(), p3.y());
    bezierVertex(p4.x(), p4.y(), p3.x(), p3.y(), p4.x(), p4.y());
    endShape();
  //  filtro.endDraw();
    
/*    beginShape();
vertex(p3.x(), p3.y());
bezierVertex(80, 0, 80, 75, 30, 75);
bezierVertex(50, 80, 60, 25, 30, 20);
endShape();
*/
/*    filtro.loadPixels();
    for (int i = 0; i < filtro.pixels.length; i++) {
      filtro.pixels[i] = color(0, 90, 102, i % filtro.width * 2); 
    }
    filtro.updatePixels();*/
    image(filtro, pcentro.x(), pcentro.y() );
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
