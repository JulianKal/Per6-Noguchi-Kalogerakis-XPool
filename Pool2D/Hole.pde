public class Hole{
  float x, y;
      
  public Hole(float x, float y){    
    this.x = x;
    this.y = y;
  } 
  void update(){
    fill(0);
    stroke(255);
    pushMatrix();
    ellipse(x, y, 50, 50);
    popMatrix();
  }
  
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }


}
