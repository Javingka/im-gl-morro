class Bambole extends Moldura {
  Clip clip;
  boolean presentacao = false;
  
  Bambole(PApplet _p5, String nomeClip, PVector pi) {
    clip = new Clip (_p5, nomeClip);
    setPosicaoInicial(pi.x, pi.y);
  }
  void ativa(){
    if (presentacao) 
    {
       clip.novo_corner1(getRecPont1());
       clip.novo_corner2(getRecPont2());
     //  clip.novo_h(getHeight());
       clip.newPos(getPos()); 
       clip.ver();  
       
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
