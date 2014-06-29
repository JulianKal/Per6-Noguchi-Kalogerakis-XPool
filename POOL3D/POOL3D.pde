static float X_MID, Y_MID, Z_MID; //Purely for translational purposes.
float FPS = 60;
static float RAD = 13;
static float RES = 10;
float FRICTION = -.04;
Cloth c;
Bumper b1, b2, b3, b4, b5, b6;
Ball testBall;
ViewManager worldViewer;
static int WINDOW_X = 1200;
static int WINDOW_Y = 600;

ArrayList<Collidable> objects;
ArrayList<Bumper> bumpers;
ArrayList<Surface> surfaces;

void setup(){
  size(WINDOW_X, WINDOW_Y,P3D);
  X_MID = WINDOW_X/2;
  Y_MID = WINDOW_Y/2;
  Z_MID = 0;
  background(24,10,10,30);
  frameRate(FPS);
  c = new Cloth();
  
  objects = new ArrayList<Collidable>();
  bumpers = new ArrayList<Bumper>();
  surfaces = new ArrayList<Surface>();
  
  bumpers.add( new Bumper(-400, -220,  -20, -220,  -20 - 27 * cos(PI/2.25), -220 + 27 * sin(PI/2.25), -400 + 40 * cos(PI/4), -220 + 40 * sin(PI/4)));
  bumpers.add( new Bumper( 400, -220,   20, -220,   20 + 27 * cos(PI/2.25), -220 + 27 * sin(PI/2.25),  400 - 40 * cos(PI/4), -220 + 40 * sin(PI/4)));
  bumpers.add( new Bumper(-400,  220,  -20,  220,  -20 - 27 * cos(PI/2.25),  220 - 27 * sin(PI/2.25), -400 + 40 * cos(PI/4),  220 - 40 * sin(PI/4)));
  bumpers.add( new Bumper( 400,  220,   20,  220,   20 + 27 * cos(PI/2.25),  220 - 27 * sin(PI/2.25),  400 - 40 * cos(PI/4),  220 - 40 * sin(PI/4)));
  
  bumpers.add( new Bumper(-420, -200, -420,  200, -420 + 40 * cos(PI/4.00),  200 - 40 * sin(PI/4.00), -420 + 40 * cos(PI/4), -200 + 40 * sin(PI/4)));
  bumpers.add( new Bumper( 420, -200,  420,  200,  420 - 40 * cos(PI/4.00),  200 - 40 * sin(PI/4.00),  420 - 40 * cos(PI/4), -200 + 40 * sin(PI/4)));
  
  
  testBall = new Ball(0,0,300,loadImage("14.png"),0,0,0);
  objects.add(testBall);
  objects.add(c.getSurface());
  
  surfaces.add(c.getSurface());
  
  
  for(int x=0;x<bumpers.size();x++){
    for(int y=0;y<bumpers.get(x).getSurfaces().size();y++){
      objects.add(bumpers.get(x).getSurfaces().get(y));
      surfaces.add(bumpers.get(x).getSurfaces().get(y));
    }
  }
  
  worldViewer = new ViewManager();
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
  for(Collidable o : objects){
    o.renderSurfaces(0,200,0);
  }
}

void update(){
  for(Collidable o : objects){
    o.update();
  }
}


void lighting(){
  ambientLight(255, 255, 250);
  directionalLight(150, 155, 150, 100, 100, -20);
}

 

