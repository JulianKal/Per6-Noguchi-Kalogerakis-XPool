

public class Segment extends Collidable{
  
  public Segment(float a,float b,float c,float d,float e,float f){
    this(new Point(a,b,c), new Point(d,e,f));
  }
  public Segment(Point a, Point b){
    points = new ArrayList<Point>();
    points.add(a);
    points.add(b);
    movable = false;
  }
  public Segment(ArrayList<Point> points){
    this.points = points;
    movable = false;
  }
  public void renderSurfaces(int r, int g, int b){
        
  }
  public void update(){
    
  }
  
  public float distance(Point p){
    return 0;
  }
  
}
