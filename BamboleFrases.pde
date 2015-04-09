class BamboleFrases extends Moldura {
  CargaFrases cargaFrases;
  MovimentoPontos movimentoPontos; //,movimentoPontosB;
  boolean presentacao = false;
  boolean mostraFrase = false;
  
  BamboleFrases(PApplet _p5, String frases_path, PVector pi, int lxl, int tamT, int w, int h) {
    
    cargaFrases = new CargaFrases (frases_path, lxl); //lxl => letras x linhas
    movimentoPontos = new MovimentoPontos(new PVector(pi.x, pi.y), tamT, w, h );
    //movimentoPontosB = new MovimentoPontos(new PVector(749, 639), 20, 185, 200 );  
    
    novaFrase();
    
  
    setPosicaoInicial(pi.x, pi.y);
  }
  //Frases
  void muda() {
    mostraFrase = !mostraFrase;
    if (mostraFrase)
      novaFrase();
  }
  void mudaFrase() {
    if (mostraFrase) {
      if (frameCount%550 == 0) 
        muda();
    } else {
      if (frameCount%200 == 0) 
        muda();
    }
  }
  void novaFrase() {
    cargaFrases.getFrases( (int) random (cargaFrases.cantLinhas-1) ); //carregamos novas frases
    movimentoPontos.geraFrase(cargaFrases.linhasFrase()); //As frases pasam como Array de Strings
    movimentoPontos.geraPontosSoltos();
//    cargaFrases.getFrases( (int) random (cargaFrases.cantLinhas-1) ); //carregamos novas frases
 //   movimentoPontosB.geraFrase(cargaFrases.linhasFrase()); //As frases pasam como Array de Strings
 //   movimentoPontosB.geraPontosSoltos();
  }

  void ativa(){
    //  movimentoPontos.mostraZona();
//  movimentoPontosB.mostraZona()
    if (presentacao) {
        if (mostraFrase) {
          movimentoPontos.desenhaPontosPraFrase();
        }else {
          movimentoPontos.atualizaDeriba();
          movimentoPontos.desenhaPontosSoltos();
        }
        mudaFrase();
        desenhaFiltro();
      }
      else
      {
       // setPosicao(mouseX, mouseY);     
       update(mouseX, mouseY);
       desenhaFigura();
      }
    }
  
  void presentacao (boolean p) {
    presentacao = p;
  }
 
  boolean getPres(){
     return presentacao; 
  }
}
