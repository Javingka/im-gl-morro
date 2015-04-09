class PontoSolto {
   // All the usual stuff
  PVector posicao;
  PVector velocidade;
  PVector aceleracao;
  float diam;
  float diamFrase;
  float tempoNoise;
  float maxForca;    // Maximum steering force
  float maxVel;    // Maximum speed
  color colorPonto;
  private boolean PontoEmPosicaoFrase;
  float alphaVar;
  float x1,x2,y1,y2; //Para conocer los limites de su area
  
  PontoSolto (float x, float y, color c, float _x1, float _x2, float _y1, float _y2) {
    posicao = new PVector(x, y);
    diam = 2;
    diamFrase = 1;
    maxVel = 3;
    maxForca = 0.2;
    aceleracao = new PVector(0, 0);
    velocidade = new PVector(0, 0);
    colorPonto = c;
    PontoEmPosicaoFrase= false;
    tempoNoise = random (3000);
    alphaVar = 255;
    x1 = _x1; y1 = _y1; x2 = _x2; y2 = _y2;
  }
  
  void PontoNaFrase(PVector alvo) {
     //PVector separateForce = separate(ps);
     PVector seekForce = procuraPonto(alvo);
     //separateForce.mult(2);
     seekForce.mult(1);
     //applyForce(separateForce);
     aplicaForca(seekForce); 
  }
  
  void PontoEmMov(PVector alvo) {
     //PVector separateForce = separate(ps);
     PVector seekForce = procuraPontoEnMov(alvo);
     //separateForce.mult(2);
     seekForce.mult(1);
     //applyForce(separateForce);
     aplicaForca(seekForce); 
  }
  
  PVector procuraPontoEnMov (PVector target) {
    PVector deseado = PVector.sub(target,posicao);  // A vector pointing from the location to the target
    PVector steer = PVector.sub(deseado,velocidade);
    steer.limit(maxForca);  // Limit to maximum steering force
    return steer;
  }
  
  PVector procuraPonto (PVector target) {
    PVector deseado = PVector.sub(target,posicao);  // A vector pointing from the location to the target
    float d = deseado.mag();
    diamFrase = map (d, 0, 100, 2, diam);
    
    if (d < 100) { //escalada a una magnitud variable
      float m = map (d, 0, 100, 0, maxVel);
      deseado.normalize();
      deseado.mult(m);//setMag (m);
    } else {
      deseado.normalize();
      deseado.mult(maxVel);//desired.setMag(maxspeed); //escalada a la maxima magnitud
    }
//    println ("d: "+d);
    if (d < 5) 
         PontoEmPosicaoFrase = true;
      else {
        PontoEmPosicaoFrase = false;
      }
     
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(deseado,velocidade);
    steer.limit(maxForca);  // Limit to maximum steering force
    return steer;
  }
  
  void aplicaForca(PVector force) {
    // We could add mass here if we want A = F / M
    aceleracao.add(force);
  }
  
  void atualiza() {
    // Update velocity
    velocidade.add(aceleracao);
    // Limit speed
    velocidade.limit(maxVel);
    posicao.add(velocidade);
    // Reset accelertion to 0 each cycle
    aceleracao.mult(0);
  }
  
  void mostra(boolean frase) {
    float diametroActual;
    float diamVar = noise (tempoNoise);
    tempoNoise += .01;
    diam = map (diamVar, 0,1, 1, 5);//variables de clase padre 
    
    if (frase) {
      diametroActual = diamFrase;
      //     alphaVar --;
    } else {
      diametroActual = diam;
    }
    
    stroke(colorPonto);
    strokeWeight(diametroActual);
    pushMatrix();
    translate(posicao.x, posicao.y);
    point(0, 0);
    popMatrix();
  }
  
  boolean PontoEmFrase() {
   return PontoEmPosicaoFrase; 
  }
  
  void bordes() {
 /*   if (posicao.x < movimentoPontos.x1) aceleracao.x = -aceleracao.x;
    if (posicao.y < movimentoPontos.y1) aceleracao.y = -aceleracao.y;
    if (posicao.x > movimentoPontos.x2) aceleracao.x = -aceleracao.x;
    if (posicao.y > movimentoPontos.y2) aceleracao.y = -aceleracao.y;*/
    
    if (posicao.x < x1) posicao.x = x2;
    if (posicao.y < y1) posicao.y = y2;
    if (posicao.x > x2) posicao.x = x1;
    if (posicao.y > y2) posicao.y = y1;
    
  }
  
}
