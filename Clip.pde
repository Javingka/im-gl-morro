class Clip {
 PApplet p5;
 Movie movie;
 PVector centroIma;
 int w,h;
 PVector corner1, corner2;
 
 Clip (PApplet _p5, String path) {
   p5 = _p5;
   movie = new Movie(p5, path);
   movie.loop();
   imageMode(CORNERS);
   w = 200;
   h = 300;
   centroIma = corner1 = corner2 = new PVector(0,0);
 }
 
 void ver() {
   
  image(movie, corner1.x, corner1.y, corner2.x, corner2.y); 
 }
 void newPos(PVector p){
   centroIma = p;
 }
 void novo_corner1( PVector nc) {
   corner1 = nc;
 }
 void novo_corner2( PVector nc) {
   corner2 = nc;
 }
 void novo_w (int _w){
   w = _w;
 }
 void novo_h (int _h){
   h = _h;
 }
}
