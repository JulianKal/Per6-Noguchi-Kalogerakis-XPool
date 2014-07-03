

public class World{
  ArrayList<Surface> surfaces;
  ArrayList<Segment> segments;
  ArrayList<Point> points;
  ArrayList<Ball> balls;
  ArrayList<Collidable> objects;
  Point p1,p2,p3,p4,p5,p6,p7,p8;
  
  public World(int x, int y, int z){ //Dimensions of the world will be 2x, 2y, and 2z
    surfaces = new ArrayList<Surface>();
    segments = new ArrayList<Segment>();
    points = new ArrayList<Point>();
    balls = new ArrayList<Ball>();
    initPoints(x,y,z);
    initSurfaces();
    initSegments();
    initBalls();
    objectify();
  }
  
  public void renderSurfaces(){
    for(Collidable c : objects){
      c.renderSurfaces(200,0,0);
    }
  }
  
  public void update(){
    for(Ball b : balls){
      b.update();
    }
    
  }
  
  public void initPoints(float x,float y,float z){
    p1 = new Point(x,y,z);
    p2 = new Point(x,-y,z);
    p3 = new Point(-x,-y,z);
    p4 = new Point(-x,y,z);
    p5 = new Point(x,y,-z);
    p6 = new Point(x,-y,-z);
    p7 = new Point(-x,-y,-z);
    p8 = new Point(-x,y,-z);
  }
  
  public void initSurfaces(){
    //Walls////////////////////////////////////////////////////////
    ArrayList<Point> points1 = new ArrayList<Point>();
    ArrayList<Point> points2 = new ArrayList<Point>();
    ArrayList<Point> points3 = new ArrayList<Point>();
    ArrayList<Point> points4 = new ArrayList<Point>();
    ArrayList<Point> points5 = new ArrayList<Point>();
    ArrayList<Point> points6 = new ArrayList<Point>();
    
    points1.add(p1);
    points1.add(p2);
    points1.add(p3);
    points1.add(p4);
    
    points2.add(p5);
    points2.add(p6);
    points2.add(p7);
    points2.add(p8);

    points3.add(p1);
    points3.add(p2);
    points3.add(p6);
    points3.add(p5);

    points4.add(p2);
    points4.add(p3);
    points4.add(p7);
    points4.add(p6);

    points5.add(p3);
    points5.add(p4);
    points5.add(p8);
    points5.add(p7);
 
    points6.add(p1);
    points6.add(p4);
    points6.add(p8);
    points6.add(p5);
    
    surfaces.add(new Surface(points1));
    surfaces.add(new Surface(points2));
    surfaces.add(new Surface(points3));
    surfaces.add(new Surface(points4));
    surfaces.add(new Surface(points5));
    surfaces.add(new Surface(points6));
    ///////////////////////////////////////////////////////////////////////
    
    //Bumpers//////////////////////////////////////////////////////////////
    points1 = new ArrayList<Point>();
    points2 = new ArrayList<Point>();
    points3 = new ArrayList<Point>();
    points4 = new ArrayList<Point>();
    points5 = new ArrayList<Point>();
    points6 = new ArrayList<Point>(); 
    
    
    ///////////////////////////////////////////////////////////////////////
  }
  
  public void initSegments(){
    //Walls////////////////////////////////////////////////////////////////
    segments.add(new Segment(p1,p2));
    segments.add(new Segment(p1,p4));
    segments.add(new Segment(p2,p3));
    segments.add(new Segment(p3,p4));
    segments.add(new Segment(p5,p6));
    segments.add(new Segment(p5,p8));
    segments.add(new Segment(p6,p7));
    segments.add(new Segment(p7,p8));
    segments.add(new Segment(p1,p5));
    segments.add(new Segment(p2,p6));
    segments.add(new Segment(p3,p7));
    segments.add(new Segment(p4,p8));
    ///////////////////////////////////////////////////////////////////////
    
    //Bumpers//////////////////////////////////////////////////////////////
    
    
    ///////////////////////////////////////////////////////////////////////
  }
  
  public void initBalls(){
    balls.add( new Ball(0,0,100,loadImage("14.png"),3,2,1)); 
    
    
  }
  
  public void objectify(){
    objects = new ArrayList<Collidable>();
    for(Surface s : surfaces){
      objects.add(s);
    }
    for(Segment s : segments){
      objects.add(s);
    }
    for(Ball b : balls){
      objects.add(b);
    }
    
  }
  
  public ArrayList<Segment> getSegments(){ return segments;}
  public ArrayList<Surface> getSurfaces(){ return surfaces;}
  public ArrayList<Collidable> getObjects(){ return objects;}
  public ArrayList<Ball> getBalls(){ return balls;}
  
}
