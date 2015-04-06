import java.awt.Frame; //<>//
import java.awt.event.KeyEvent;
import java.text.*; 
import processing.video.*;


ArrayList <Bambole> telas;

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
  telas = new ArrayList <Bambole>();
  addTelas();
  
  frameRate(30);  
}
void addTelas() {
  telas.add( new Bambole(this, "rc10.mov", new PVector( width * .3, height * .3) ) ); 
  telas.add( new Bambole(this, "rc10.mov", new PVector( width * .6, height * .3) ) );
}
void draw() {
  background(0);
  for (Bambole b : telas) {
    b.ativa();  
  }
  
}
void keyPressed(){
  for (Bambole b : telas) {
    b.presentacao( !b.getPres() );  
  }
}
void movieEvent(Movie m) {
  m.read();
}
