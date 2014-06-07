public class Hole{
  float x, y;
      
  public Hole(float x, float y){    
    this.x = x;
    this.y = y;
  } 
  void update(){
    stroke(35, 0, 0, 50);
    fill(35, 35, 53, 255);
    pushMatrix();
    translate(x, y, -500);
    rotateX(HALF_PI);
    cylinder(40, 1000, 60);
    popMatrix();
  }
  
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }

void cylinder(float w, float h, int sides){
  float angle;
  float[] x = new float[sides+1];
  float[] y = new float[sides+1];
  for(int i=0; i<x.length; i++){
    angle = TWO_PI/sides*i;
    x[i] = sin(angle)*w;
    y[i] = cos(angle)*w;
  }
  beginShape(TRIANGLE_FAN); 
  vertex(0, -h/2, 0);
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, y[i]);
  }
  endShape();
  beginShape(QUAD_STRIP);
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, y[i]);
    vertex(x[i], h/2, y[i]);
  }
  endShape();
  beginShape(TRIANGLE_FAN);
  vertex(0, h/2, 0);
  for(int i=0; i < x.length; i++){
    vertex(x[i], h/2, y[i]);
  }
  endShape();    
}
  


}
