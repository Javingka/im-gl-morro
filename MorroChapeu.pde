import java.awt.Frame; //<>//
import java.awt.event.KeyEvent;
import java.text.*; 
import processing.video.*;
import geomerative.*;

ArrayList <Bambole> telas;
CargaFrases cargaFrases;
MovimentoPontos movimentoPontos;
boolean mostraFrase;
boolean presentacao;

public void init() {
  println("frame: processing e PApplet: processing / primeira janela de projecao. frame e PApplet por default");
  // to make a frame not displayable, you can
  // use frame.removeNotify()

  frame.removeNotify();
  frame.setUndecorated(true);

  // addNotify, here i am not sure if you have 
  // to add notify again.  
  frame.addNotify();
  super.init();
}

void setup() {
  size (displayWidth , displayHeight, P2D);
  frame.setLocation(0, 0); //posicionamento da janela
  
    //inicializacāo da biblioteca
  RG.init(this);
  RG.setPolygonizer(RG.ADAPTATIVE);
  cargaFrases = new CargaFrases (20);
  
   PVector centroFrases = new PVector(238, 375);
  movimentoPontos = new MovimentoPontos(centroFrases, 25, 80, 200 );
  
  novaFrase();
  presentacao = mostraFrase = false;
  
  telas = new ArrayList <Bambole>();
  addTelas();
  
  frameRate(30);  
}
void addTelas() {
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(150);
  telas.get(telas.size()-1).setHeight(275);
  telas.get(telas.size()-1).setPosicaoInicial(width/2,height/2 );
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(150);
  telas.get(telas.size()-1).setHeight(275);
  telas.get(telas.size()-1).setPosicaoInicial(1104, 583);
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(150);
  telas.get(telas.size()-1).setHeight(275);
  telas.get(telas.size()-1).setPosicaoInicial(104, 683);
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(150);
  telas.get(telas.size()-1).setHeight(275);
  telas.get(telas.size()-1).setPosicaoInicial(600, 323);
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(150);
  telas.get(telas.size()-1).setHeight(275);
  telas.get(telas.size()-1).setPosicaoInicial(750, 80);
  
}
void draw() {
  background(0);
  for (Bambole b : telas) {
    b.ativa();  
  }
  movimentoPontos.mostraZona();
  if (presentacao) {
    if (mostraFrase) {
      movimentoPontos.desenhaPontosPraFrase();
    }else {
      movimentoPontos.atualizaDeriba();
      movimentoPontos.desenhaPontosSoltos();
    }
    mudaFrase();
  }
  
}
void novaFrase() {
  cargaFrases.getFrases( (int) random (cargaFrases.cantLinhas-1) ); //carregamos novas frases
  movimentoPontos.geraFrase(cargaFrases.linhasFrase()); //As frases pasam como Array de Strings
  movimentoPontos.geraPontosSoltos();
}

void keyPressed(){
  
  presentacao = !presentacao;
  for (Bambole b : telas) {
    b.presentacao( presentacao ) ; //!b.getPres() );  
  }
  
  if (key == 'c')  movimentoPontos.mudaCentro();
}
void movieEvent(Movie m) {
  m.read();
}

//Frases
void muda() {
  mostraFrase = !mostraFrase;
  if (mostraFrase)
    novaFrase();
}

void mouseReleased () {
    muda();
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
