//For the classic pool-game version.

public class Bumper{
  Point p1,p2,p3,p4,p5,p6,p7,p8;
  Surface s1,s2,s3,s4,s5;
  ArrayList<Surface> surfaces;
  ArrayList<Segment> segments;
  
  public Bumper(float a,float b, float c, float d, float e, float f, float g, float h){
    
    p1 = new Point(a,b,100);
    p2 = new Point(c,d,100);
    p3 = new Point(e,f,100);
    p4 = new Point(g,h,100);
    p5 = new Point(a,b,0.1-3*RAD);
    p6 = new Point(c,d,0.1-3*RAD);
    p7 = new Point(e,f,0.1-3*RAD);
    p8 = new Point(g,h,0.1-3*RAD);
    
    segments = new ArrayList<Segment>();
//    segments.add(new Segment(p1,p5));
//    segments.add(new Segment(p1,p2));
//    segments.add(new Segment(p1,p4));
//    segments.add(new Segment(p3,p2));
//    segments.add(new Segment(p3,p4));
//    segments.add(new Segment(p3,p7));
//    segments.add(new Segment(p6,p2));
//    segments.add(new Segment(p6,p5));
//    segments.add(new Segment(p6,p7));
//    segments.add(new Segment(p8,p5));
//    segments.add(new Segment(p8,p7));
//    segments.add(new Segment(p8,p4));
    
    ArrayList<Point> s1points = new ArrayList<Point>();
    ArrayList<Point> s2points = new ArrayList<Point>();
    ArrayList<Point> s3points = new ArrayList<Point>();
    ArrayList<Point> s4points = new ArrayList<Point>();
    ArrayList<Point> s5points = new ArrayList<Point>();
    
    s1points.add(p1);
    s1points.add(p2);
    s1points.add(p3);
    s1points.add(p4);
    
    s2points.add(p1);
    s2points.add(p5);
    s2points.add(p6);
    s2points.add(p2);
    
    s3points.add(p2);
    s3points.add(p6);
    s3points.add(p7);
    s3points.add(p3);
    
    s4points.add(p3);
    s4points.add(p7);
    s4points.add(p8);
    s4points.add(p4);
    
    s5points.add(p4);
    s5points.add(p8);
    s5points.add(p5);
    s5points.add(p1);
    
    
    s1 = new Surface(s1points);
    s2 = new Surface(s2points);
    s3 = new Surface(s3points);
    s4 = new Surface(s4points);
    s5 = new Surface(s5points);
    surfaces = new ArrayList<Surface>();
    surfaces.add(s1);
    surfaces.add(s2);
    surfaces.add(s3);
    surfaces.add(s4);
    surfaces.add(s5);
    
  }
  
  public void update(){
    for(Surface s : surfaces){
      s.update();
    }
  }
   
  public void renderSurfaces(int r, int g, int b){
    
    pushMatrix();
    for(int x=0;x<surfaces.size();x++){
      surfaces.get(x).renderSurfaces(r,g,b);
    }
    popMatrix();
    
  }
  
  public ArrayList<Surface> getSurfaces(){ return surfaces; }
  public ArrayList<Segment> getSegments(){ return segments; }
  
}
