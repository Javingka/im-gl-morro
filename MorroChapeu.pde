import java.awt.Frame; //<>//
import java.awt.event.KeyEvent;
import java.text.*; 
import processing.video.*;
import geomerative.*;

ArrayList <Bambole> telas;
ArrayList <BamboleFrases> telasF;
//CargaFrases cargaFrases;
//MovimentoPontos movimentoPontos,movimentoPontosB;
//boolean mostraFrase;
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
//  cargaFrases = new CargaFrases (20);
  
//  movimentoPontos = new MovimentoPontos(new PVector(545, 619), 20, 185, 200 );
//  movimentoPontosB = new MovimentoPontos(new PVector(749, 639), 20, 185, 200 );
  
//  novaFrase();
  presentacao = false;
  
  telas = new ArrayList <Bambole>();
  telasF = new ArrayList <BamboleFrases>();
  
  addTelas();
  
  frameRate(30);  
}
void addTelas() {
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(221);
  telas.get(telas.size()-1).setHeight(263);
  telas.get(telas.size()-1).setPosicaoInicial(141,560 );
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(205);
  telas.get(telas.size()-1).setHeight(230);
  telas.get(telas.size()-1).setPosicaoInicial(364, 596);
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(233);
  telas.get(telas.size()-1).setHeight(247);
  telas.get(telas.size()-1).setPosicaoInicial(969, 591);
  telas.add( new Bambole(this, "testm.mov", new PVector( width * .3, height * .3) ) ); 
  telas.get(telas.size()-1).setWidth(271);
  telas.get(telas.size()-1).setHeight(267);
  telas.get(telas.size()-1).setPosicaoInicial(1218, 607);
  //======== Telas Textos ==========//
  telasF.add( new BamboleFrases(this, "frases.csv", new PVector(545, 619), 20, 18, 185, 190 ) );
  telasF.get(telasF.size()-1).setWidth(185);
  telasF.get(telasF.size()-1).setHeight(200);
  telasF.get(telasF.size()-1).setPosicaoInicial(545, 619);
  telasF.add( new BamboleFrases(this, "frases.csv", new PVector(749, 639), 20, 18, 185, 190 ) );
  telasF.get(telasF.size()-1).setWidth(185);
  telasF.get(telasF.size()-1).setHeight(200);
  telasF.get(telasF.size()-1).setPosicaoInicial(749, 639);
  telasF.add( new BamboleFrases(this, "frases.csv", new PVector(width*.5, 250), 60, 25, 800, 240 ) );
  telasF.get(telasF.size()-1).setWidth(800);
  telasF.get(telasF.size()-1).setHeight(250);
  telasF.get(telasF.size()-1).setPosicaoInicial(width*.5, 250);
}
void draw() {
  background(0);
  for (Bambole b : telas) {
    b.ativa();  
  }
  for (BamboleFrases b : telasF) {
    b.ativa();  
  }
}


void keyPressed(){
  
  
  
  if (key == 'c')  {
    presentacao = !presentacao;
    for (Bambole b : telas) {
      b.presentacao( presentacao ) ; //!b.getPres() );  
    }
    for (BamboleFrases b : telasF) {
      b.presentacao( presentacao ) ; //!b.getPres() );  
    }
  }
}
void movieEvent(Movie m) {
  m.read();
}

void mouseReleased () {
  //  muda();
}
