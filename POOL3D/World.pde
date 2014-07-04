

public class World{
  ArrayList<Surface> surfaces;
  ArrayList<Segment> segments;
  ArrayList<Point> points;
  ArrayList<Ball> balls;
  ArrayList<Collidable> objects;
  Point p1,p2,p3,p4,p5,p6,p7,p8;
  Point w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24;
  Point b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27,b28,b29,b30,b31,b32,b33,b34,b35,b36,b37,b38,b39,b40,b41,b42,b43,b44,b45,b46,b47,b48;
  
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
    //World vertices.
    p1 = new Point(x,y,z);
    p2 = new Point(x,-y,z);
    p3 = new Point(-x,-y,z);
    p4 = new Point(-x,y,z);
    p5 = new Point(x,y,-z);
    p6 = new Point(x,-y,-z);
    p7 = new Point(-x,-y,-z);
    p8 = new Point(-x,y,-z);
    
    //Wall Vertices.
    w1 = new Point(x-4*RAD,y-4*RAD,z);
    w2 = new Point(x,y-4*RAD,z-4*RAD);
    w3 = new Point(x-4*RAD,y,z-4*RAD);
    
    w4 = new Point(x-4*RAD,-y+4*RAD,z);
    w5 = new Point(x,-y+4*RAD,z-4*RAD);
    w6 = new Point(x-4*RAD,-y,z-4*RAD);
    
    w7 = new Point(-x+4*RAD,-y+4*RAD,z);
    w8 = new Point(-x,-y+4*RAD,z-4*RAD);
    w9 = new Point(-x+4*RAD,-y,z-4*RAD);
    
    w10 = new Point(-x+4*RAD,y-4*RAD,z);
    w11 = new Point(-x,y-4*RAD,z-4*RAD);
    w12 = new Point(-x+4*RAD,y,z-4*RAD);
    
    w13 = new Point(x-4*RAD,y-4*RAD,-z);
    w14 = new Point(x,y-4*RAD,-z+4*RAD);
    w15 = new Point(x-4*RAD,y,-z+4*RAD);
    
    w16 = new Point(x-4*RAD,-y+4*RAD,-z);
    w17 = new Point(x,-y+4*RAD,-z+4*RAD);
    w18 = new Point(x-4*RAD,-y,-z+4*RAD);
    
    w19 = new Point(-x+4*RAD,-y+4*RAD,-z);
    w20 = new Point(-x,-y+4*RAD,-z+4*RAD);
    w21 = new Point(-x+4*RAD,-y,-z+4*RAD);
    
    w22 = new Point(-x+4*RAD,y-4*RAD,-z);
    w23 = new Point(-x,y-4*RAD,-z+4*RAD);
    w24 = new Point(-x+4*RAD,y,-z+4*RAD);
    
    //Bumper Vertices (Wall Midpoints)
    b1 = new Point(4*RAD,y-4*RAD,z);
    b2 = new Point(x-4*RAD,4*RAD,z);
    b3 = new Point(x,4*RAD,z-4*RAD);
    b4 = new Point(x,y-4*RAD,4*RAD);
    b5 = new Point(4*RAD,y,z-4*RAD);
    b6 = new Point(x-4*RAD,y,4*RAD);
    
    b7 = new Point(4*RAD,-y+4*RAD,z);
    b8 = new Point(x-4*RAD,-4*RAD,z);
    b9 = new Point(x,-4*RAD,z-4*RAD);
    b10 = new Point(x,-y+4*RAD,4*RAD);
    b11 = new Point(4*RAD,-y,z-4*RAD);
    b12 = new Point(x-4*RAD,-y,4*RAD);
    
    b13 = new Point(-4*RAD,-y+4*RAD,z);
    b14 = new Point(-x+4*RAD,-4*RAD,z);
    b15 = new Point(-x,-4*RAD,z-4*RAD);
    b16 = new Point(-x,-y+4*RAD,4*RAD);
    b17 = new Point(-4*RAD,-y,z-4*RAD);
    b18 = new Point(-x+4*RAD,-y,4*RAD);
    
    b19 = new Point(-4*RAD,y-4*RAD,z);
    b20 = new Point(-x+4*RAD,4*RAD,z);
    b21 = new Point(-x,4*RAD,z-4*RAD);
    b22 = new Point(-x,y-4*RAD,4*RAD);
    b23 = new Point(-4*RAD,y,z-4*RAD);
    b24 = new Point(-x+4*RAD,y,4*RAD);
    
    b25 = new Point(4*RAD,y-4*RAD,-z);
    b26 = new Point(x-4*RAD,4*RAD,-z);
    b27 = new Point(x,4*RAD,-z+4*RAD);
    b28 = new Point(x,y-4*RAD,-4*RAD);
    b29 = new Point(4*RAD,y,-z+4*RAD);
    b30 = new Point(x-4*RAD,y,-4*RAD);
    
    b31 = new Point(4*RAD,-y+4*RAD,-z);
    b32 = new Point(x-4*RAD,-4*RAD,-z);
    b33 = new Point(x,-4*RAD,-z+4*RAD);
    b34 = new Point(x,-y+4*RAD,-4*RAD);
    b35 = new Point(4*RAD,-y,-z+4*RAD);
    b36 = new Point(x-4*RAD,-y,-4*RAD);
    
    b37 = new Point(-4*RAD,-y+4*RAD,-z);
    b38 = new Point(-x+4*RAD,-4*RAD,-z);
    b39 = new Point(-x,-4*RAD,-z+4*RAD);
    b40 = new Point(-x,-y+4*RAD,-4*RAD);
    b41 = new Point(-4*RAD,-y,-z+4*RAD);
    b42 = new Point(-x+4*RAD,-y,-4*RAD);
    
    b43 = new Point(-4*RAD,y-4*RAD,-z);
    b44 = new Point(-x+4*RAD,4*RAD,-z);
    b45 = new Point(-x,4*RAD,-z+4*RAD);
    b46 = new Point(-x,y-4*RAD,-4*RAD);
    b47 = new Point(-4*RAD,y,-z+4*RAD);
    b48 = new Point(-x+4*RAD,y,-4*RAD);
  }
  
  public void initSurfaces(){
    //Walls////////////////////////////////////////////////////////
    ArrayList<Point> points1 = new ArrayList<Point>();
    ArrayList<Point> points2 = new ArrayList<Point>();
    ArrayList<Point> points3 = new ArrayList<Point>();
    ArrayList<Point> points4 = new ArrayList<Point>();
    ArrayList<Point> points5 = new ArrayList<Point>();
    ArrayList<Point> points6 = new ArrayList<Point>();
    ArrayList<Point> points7 = new ArrayList<Point>();
    ArrayList<Point> points8 = new ArrayList<Point>();
    ArrayList<Point> points9 = new ArrayList<Point>();
    ArrayList<Point> points10 = new ArrayList<Point>();
    ArrayList<Point> points11 = new ArrayList<Point>();
    ArrayList<Point> points12 = new ArrayList<Point>();
    ArrayList<Point> points13 = new ArrayList<Point>();
    ArrayList<Point> points14 = new ArrayList<Point>();
    ArrayList<Point> points15 = new ArrayList<Point>();
    ArrayList<Point> points16 = new ArrayList<Point>();
    ArrayList<Point> points17 = new ArrayList<Point>();
    ArrayList<Point> points18 = new ArrayList<Point>();
    ArrayList<Point> points19 = new ArrayList<Point>();
    ArrayList<Point> points20 = new ArrayList<Point>();
    ArrayList<Point> points21 = new ArrayList<Point>();
    ArrayList<Point> points22 = new ArrayList<Point>();
    ArrayList<Point> points23 = new ArrayList<Point>();
    ArrayList<Point> points24 = new ArrayList<Point>();
    
    points1.add(w1);
    points1.add(w4);
    points1.add(w7);
    points1.add(w10);
    
    points2.add(w13);
    points2.add(w16);
    points2.add(w19);
    points2.add(w22);

    points3.add(w2);
    points3.add(w5);
    points3.add(w17);
    points3.add(w14);

    points4.add(w6);
    points4.add(w9);
    points4.add(w21);
    points4.add(w18);

    points5.add(w8);
    points5.add(w11);
    points5.add(w23);
    points5.add(w20);
 
    points6.add(w3);
    points6.add(w12);
    points6.add(w24);
    points6.add(w15);
    
//    points7.add(w1);
//    points7.add(w4);
//    points7.add(w7);
//    points7.add(w10);
//    
//    points8.add(w13);
//    points8.add(w16);
//    points8.add(w19);
//    points8.add(w22);
//
//    points9.add(w2);
//    points9.add(w5);
//    points9.add(w17);
//    points9.add(w14);
//
//    points10.add(w6);
//    points10.add(w9);
//    points10.add(w21);
//    points10.add(w18);
//
//    points11.add(w8);
//    points11.add(w11);
//    points11.add(w23);
//    points11.add(w20);
// 
//    points12.add(w3);
//    points12.add(w12);
//    points12.add(w24);
//    points12.add(w15);
//    
//    points13.add(w1);
//    points13.add(w4);
//    points13.add(w7);
//    points13.add(w10);
//    
//    points14.add(w13);
//    points14.add(w16);
//    points14.add(w19);
//    points14.add(w22);
//
//    points15.add(w2);
//    points15.add(w5);
//    points15.add(w17);
//    points15.add(w14);
//
//    points15.add(w6);
//    points15.add(w9);
//    points15.add(w21);
//    points15.add(w18);
//
//    points16.add(w8);
//    points16.add(w11);
//    points16.add(w23);
//    points16.add(w20);
// 
//    points17.add(w3);
//    points17.add(w12);
//    points17.add(w24);
//    points17.add(w15);
//    
//    points18.add(w1);
//    points18.add(w4);
//    points18.add(w7);
//    points18.add(w10);
//    
//    points19.add(w13);
//    points19.add(w16);
//    points19.add(w19);
//    points19.add(w22);
//
//    points20.add(w2);
//    points20.add(w5);
//    points20.add(w17);
//    points20.add(w14);
//
//    points21.add(w6);
//    points21.add(w9);
//    points21.add(w21);
//    points21.add(w18);
//
//    points22.add(w8);
//    points22.add(w11);
//    points22.add(w23);
//    points22.add(w20);
// 
//    points23.add(w3);
//    points23.add(w12);
//    points23.add(w24);
//    points23.add(w15);
//    
//    points24.add(w3);
//    points24.add(w12);
//    points24.add(w24);
//    points24.add(w15);
    
    surfaces.add(new Surface(points1));
    surfaces.add(new Surface(points2));
    surfaces.add(new Surface(points3));
    surfaces.add(new Surface(points4));
    surfaces.add(new Surface(points5));
    surfaces.add(new Surface(points6));
//    surfaces.add(new Surface(points7));
//    surfaces.add(new Surface(points8));
//    surfaces.add(new Surface(points9));
//    surfaces.add(new Surface(points10));
//    surfaces.add(new Surface(points11));
//    surfaces.add(new Surface(points12));
//    surfaces.add(new Surface(points13));
//    surfaces.add(new Surface(points14));
//    surfaces.add(new Surface(points15));
//    surfaces.add(new Surface(points16));
//    surfaces.add(new Surface(points17));
//    surfaces.add(new Surface(points18));
//    surfaces.add(new Surface(points19));
//    surfaces.add(new Surface(points20));
//    surfaces.add(new Surface(points21));
//    surfaces.add(new Surface(points22));
//    surfaces.add(new Surface(points23));
//    surfaces.add(new Surface(points24));
    ///////////////////////////////////////////////////////////////////////
    
    //Bumpers//////////////////////////////////////////////////////////////
    points1 = new ArrayList<Point>();
    points2 = new ArrayList<Point>();
    points3 = new ArrayList<Point>();
    points4 = new ArrayList<Point>();
    points5 = new ArrayList<Point>();
    points6 = new ArrayList<Point>(); 
    points7 = new ArrayList<Point>();
    points8 = new ArrayList<Point>();
    points9 = new ArrayList<Point>();
    points10 = new ArrayList<Point>();
    points11 = new ArrayList<Point>();
    points12 = new ArrayList<Point>();
    
    points1.add(w1);
    points1.add(b2);
    points1.add(b3);
    points1.add(w2);
    
    points2.add(w1);
    points2.add(b1);
    points2.add(b5);
    points2.add(w3);
    
    points3.add(w2);
    points3.add(b4);
    points3.add(b6);
    points3.add(w3);
    
    points4.add(w4);
    points4.add(b8);
    points4.add(b9);
    points4.add(w5);
    
    points5.add(w4);
    points5.add(b7);
    points5.add(b11);
    points5.add(w6);
    
    points6.add(w5);
    points6.add(b10);
    points6.add(b12);
    points6.add(w6);
//    
//    points1.add();
//    points1.add();
//    points1.add();
//    points1.add();
//    
//    points1.add();
//    points1.add();
//    points1.add();
//    points1.add();
//    
//    points1.add();
//    points1.add();
//    points1.add();
//    points1.add();
    
    surfaces.add(new Surface(points1));
    surfaces.add(new Surface(points2));
    surfaces.add(new Surface(points3));
    surfaces.add(new Surface(points4));
    surfaces.add(new Surface(points5));
    surfaces.add(new Surface(points6));
    ///////////////////////////////////////////////////////////////////////
  }
  
  public void initSegments(){
    //Walls////////////////////////////////////////////////////////////////
    segments.add(new Segment(w1,w4));
    segments.add(new Segment(w4,w7));
    segments.add(new Segment(w7,w10));
    segments.add(new Segment(w1,w10));
    segments.add(new Segment(w13,w16));
    segments.add(new Segment(w16,w19));
    segments.add(new Segment(w19,w22));
    segments.add(new Segment(w13,w22));
    segments.add(new Segment(w2,w5));
    segments.add(new Segment(w5,w17));
    segments.add(new Segment(w17,w14));
    segments.add(new Segment(w2,w14));
    segments.add(new Segment(w6,w9));
    segments.add(new Segment(w9,w21));
    segments.add(new Segment(w21,w18));
    segments.add(new Segment(w6,w18));
    segments.add(new Segment(w8,w11));
    segments.add(new Segment(w11,w23));
    segments.add(new Segment(w23,w20));
    segments.add(new Segment(w8,w20));
    segments.add(new Segment(w3,w12));
    segments.add(new Segment(w12,w24));
    segments.add(new Segment(w24,w15));
    segments.add(new Segment(w3,w15));
    ///////////////////////////////////////////////////////////////////////
    
    //Bumpers//////////////////////////////////////////////////////////////
    
    
    ///////////////////////////////////////////////////////////////////////
  }
  
  public void initBalls(){
    balls.add( new Ball(0,0,0,loadImage("14.png"),2,1,4)); 
    
    
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
