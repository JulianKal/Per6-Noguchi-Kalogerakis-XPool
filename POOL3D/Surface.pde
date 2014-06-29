

public class Surface extends Collidable{
  //Equation constants- ax + by + cz = d
  public float a, b, c, d;
  PVector normal;
  
  public Surface(ArrayList<Point> points){
    this.points = points;
    calculateEquation(); //ONly needs to be calculated once.
//    print(normal + " " );
//    println("" + a + " " + b + " " + c + " " + d);
  }
  
  public void update(){
    for(Point p : points){
      p.update();
    }
    
  }
  
  public void renderSurfaces(int r,int g,int b){
    pushMatrix();
    fill(200,0,0);
    stroke(30);
    beginShape();
    for(Point p : points){
      p.placeVertex();
    }
    endShape();
    popMatrix();
  }
  
  public void calculateEquation(){
    calculateNormal();
    d = normal.dot(points.get(1).getX(),points.get(1).getY(),points.get(1).getZ());
    a = normal.x;
    b = normal.y;
    c = normal.z;
  }
  public void calculateNormal(){
    PVector p1 = points.get(0).vectorTo(points.get(2));
    PVector p2 = points.get(1).vectorTo(points.get(3));
    normal = p1.cross(p2);
  }
  public PVector normal(){
    return normal;
  }
}
