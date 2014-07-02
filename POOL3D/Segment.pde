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
  
  public Point normalPoint(Point p){
    //formula from http://www.geometrictools.com/Documentation/DistancePointLine.pdf
    Point zero = new Point(0,0,0);
    PVector starting = zero.vectorTo(points.get(0));
    PVector direction = points.get(0).vectorTo(points.get(1));
    float t = direction.dot(new PVector(p.getX()-starting.x,p.getY()-starting.y,p.getZ()-starting.z)) / (direction.dot(direction));
    if(t<=0){
      return new Point(starting);
    }else if(t>0 && t<1){
      return new Point(PVector.add(starting, PVector.mult(direction,t)));
    }else if(t>=1){
      return new Point(direction);
    }
    return null;
  }
  
  public float distance(Point p){
    return p.distance(normalPoint(p)); //Inefficient.
  }
  
}
