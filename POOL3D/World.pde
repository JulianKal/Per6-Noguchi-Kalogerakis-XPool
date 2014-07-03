

public class World{
  ArrayList<Surface> surfaces;
  ArrayList<Segment> segments;
  ArrayList<Point> points;
  Point p1,p2,p3,p4,p5,p6,p7,p8;
  
  public World(int x, int y, int z){ //Dimensions of the world will be 2x, 2y, and 2z
    initPoints();
    initSurfaces();
    initSegments();
  }
  
  public void initPoints(){
    points = new ArrayList<Point>();
    p1 = new Point(800,800,800);
    p2 = new Point(800,-800,800);
    p3 = new Point(-800,-800,800);
    p4 = new Point(-800,800,800);
    p5 = new Point(800,800,-800);
    p6 = new Point(800,-800,-800);
    p7 = new Point(-800,-800,-800);
    p8 = new Point(-800,800,-800);

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
    points1.add(p4);
    points1.add(p3);
    
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
    ///////////////////////////////////////////////////////////////////////
    
    
    
  }
  
  public void initSegments(){
    segments = new ArrayList<Segment>();
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
    
  }
  
  
}
