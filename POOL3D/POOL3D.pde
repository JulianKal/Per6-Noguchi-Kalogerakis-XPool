//To do:
//To speed up the code, change squareroot < radius to blah < radius^2
//Improve collisions with location modifications (fix overlap at ricochets)
//Find out reason for delayed collisions with edges.
//Change collision detecting such that each ball can only make one collision with each surface (points and segments included)
//      Update: this works now, but it needs to be coupled with collision detecting from the pool cloth which still doesn't work well.
//      Update: Problem fixed by only allowing collisions with one object at a time. A very temporary fix.


static float X_MID, Y_MID, Z_MID; //Purely for translational purposes.
float FPS = 2000; //If you set the FPS to lower htan this, you get some weird collisions (collisions with more than one wall).
static float RAD = 13;
static float RES = 10;
float FRICTION = -.04;
Cloth c;
Bumper b1, b2, b3, b4, b5, b6;
Ball testBall;
static int WINDOW_X = 1200;
static int WINDOW_Y = 800;

//List of collidables
ArrayList<Collidable> objects;
ArrayList<Bumper> bumpers;
ArrayList<Surface> surfaces;
ArrayList<Segment> segments;
ArrayList<Point> points;

World world;
ViewManager worldViewer;

void setup(){
  size(WINDOW_X, WINDOW_Y,P3D);
  X_MID = WINDOW_X/2;
  Y_MID = WINDOW_Y/2;
  Z_MID = 0;
  background(24,10,10,30);
  frameRate(FPS);

  objects = new ArrayList<Collidable>();
  bumpers = new ArrayList<Bumper>();
  surfaces = new ArrayList<Surface>();
  segments = new ArrayList<Segment>();
  points = new ArrayList<Point>();  
  
  world = new World(800,800,800);
  worldViewer = new ViewManager();
  
  
//  bumpers.add( new Bumper(-400, -220,  -20, -220,  -20 - 27 * cos(PI/2.25), -220 + 27 * sin(PI/2.25), -400 + 40 * cos(PI/4), -220 + 40 * sin(PI/4)));
//  bumpers.add( new Bumper( 400, -220,   20, -220,   20 + 27 * cos(PI/2.25), -220 + 27 * sin(PI/2.25),  400 - 40 * cos(PI/4), -220 + 40 * sin(PI/4)));
//  bumpers.add( new Bumper(-400,  220,  -20,  220,  -20 - 27 * cos(PI/2.25),  220 - 27 * sin(PI/2.25), -400 + 40 * cos(PI/4),  220 - 40 * sin(PI/4)));
//  bumpers.add( new Bumper( 400,  220,   20,  220,   20 + 27 * cos(PI/2.25),  220 - 27 * sin(PI/2.25),  400 - 40 * cos(PI/4),  220 - 40 * sin(PI/4)));
//  bumpers.add( new Bumper(-420, -200, -420,  200, -420 + 40 * cos(PI/4.00),  200 - 40 * sin(PI/4.00), -420 + 40 * cos(PI/4), -200 + 40 * sin(PI/4)));
//  bumpers.add( new Bumper( 420, -200,  420,  200,  420 - 40 * cos(PI/4.00),  200 - 40 * sin(PI/4.00),  420 - 40 * cos(PI/4), -200 + 40 * sin(PI/4)));
//  for(Bumper b : bumpers){
//    for(Surface s : b.getSurfaces()){
//      surfaces.add(s);
//      objects.add(s);
//    }
//    for(Segment s : b.getSegments()){
//      segments.add(s);
//      objects.add(s);
//    }
//  }

  

//  ArrayList<Point> pointList = new ArrayList<Point>();
//  pointList.add(new Point(400,200,-4));
//  pointList.add(new Point(-400,200,-4));
//  pointList.add(new Point(-400,400,-4));
//  pointList.add(new Point(400,400,-4));
//  objects.add(new Surface(pointList));
//  surfaces.add(new Surface(pointList));
//  segments.add(new Segment(new Point(400,200,-4),new Point(-400,200,-4)));
//  for(Surface s : surfaces){ //Optimization : remove duplicates.
//    for(Segment seg : s.getSegments()){
//      objects.add(seg);
//      segments.add(seg);
//    }
//  }

    
//  testBall = new Ball(0,0,0,loadImage("14.png"),0.2,0,0.5);
//  objects.add(testBall);
  
}

void draw(){
  smooth();
  fill(0, 0, 0, 180);
  lighting();
  translate(X_MID, Y_MID, Z_MID);
  background(0, 0, 0, 30);
  worldViewer.update();
  renderSurfaces();
  update();
}

void keyPressed(){
  if(key==' '){
    worldViewer.toggleView();
  }
}

void renderSurfaces(){
  world.renderSurfaces();
}

void update(){
  world.update();
}


void lighting(){
  ambientLight(255, 255, 250);
  directionalLight(150, 155, 150, 100, 100, -20);
}

 

