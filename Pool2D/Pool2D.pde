//Purely for testing the further improved physics engine (with new and improved spin!)

Pool p = new Pool();
float x, y, z;
float viewHorizontal,keyHorizontal,mouseHorizontal;
float viewVertical = .35;
boolean aim = true;
boolean rotatable = true;
boolean scratch = false;
boolean shooting = true;
float mx, my;
float lastTime = millis();
float delay;
float shotPower = .7;
boolean precisionAim = false;
float RAD = 15;
float FRICTION = -0.05;
float FPS = 60;
Ball cueBall;

void setup() {
  size(1000,600,P3D);
  background(0);
  frameRate(FPS);
  
  x = width/2;
  y = height/2;
  z = 500;
  
  PImage cueImage = loadImage("Zero.png");
  cueBall = new Ball(random(500)-250,random(500)-250, cueImage);
  cueBall.setCueBall();
  cueBall.initializeSphere(35);
  p.set(cueBall);
  for(int x=1;x<15;x++){
    p.set(new Ball(random(500)-250,random(500)-250, loadImage("" + x + ".png")));
    p.getBallSet().get(x).initializeSphere(35);
  }
  
  p.set(new Hole(0, -285));
  p.set(new Hole(0, 285));
  p.set(new Hole(-440, -240));
  p.set(new Hole(-440, 240));
  p.set(new Hole(440, -240));
  p.set(new Hole(440, 240));
}

void draw(){
  background(190, 197, 185);
  ambientLight(255, 255, 255);
  if(shooting){
    showBallAim();
  }
  translate(x,y,35);
  
  if(rotatable){
    viewHorizontal = mouseHorizontal + keyHorizontal;
    mouseHorizontal = -(mouseX-x) * 0.001;
    rotateX(PI*viewVertical);
    rotate(viewHorizontal);
  }
  if(!scratch && shooting){
    translate(-cueBall.getX(),-cueBall.getY(),0);
  }
  paintRectangle();
  if(shooting){
    paintSights();
  }
  paintBalls();  
  buttonListener();
  p.update();
  
  if(p.stopped()){
    if(shooting==false){
      try{
        Thread.sleep(3000);
     }catch(Exception e){}
    }
    shooting = true;
  }
}

void exit(){
  super.exit();
}

void mouseClicked(){
  shoot();
}

void shoot(){
  if(shooting){
    cueBall.insertForce(shotPower,(1.5*PI)-viewHorizontal);
    shotPower = 0;
    shooting = false;
  }
}

void keyPressed(){
  if(key=='s'){
    if(viewVertical < .55){
      viewVertical += .005;
    }
  }
  if(key=='a'){
    if(viewVertical > .1){
      viewVertical -= .005;
    }
  }
  if(key=='x'){
    if(shotPower<15){
      shotPower+=.5;
    }
  }
  if(key=='z'){
    if(shotPower>1){
      shotPower-=1;
    }
  }
  if(key==','){
    keyHorizontal += PI/32;
  }
  if(key=='.'){
    keyHorizontal -= PI/32;
  }
  if(key=='p'){
    scratch = !scratch;
    rotatable = !rotatable;
  }
  if(key=='w'){
    
  }
  if(key=='a'){
    
  }
  if(key=='s'){
    
  }
  if(key=='d'){
    
  }
  if(key==' '){
    shoot();
  }
  if(key=='b'){
    println(" " + cueBall.getX() + ", " + cueBall.getY());
  }
}

void buttonListener(){
  if(key==CODED){
    if(keyCode == UP){
      if(p.stopped()){
        cueBall.insertForce(shotPower,(1.5*PI)-viewHorizontal);
        //cueBall.insertSpinVert(1);
        delay = 3000;
      }
      keyCode = DOWN;
    }
    else if(keyCode == SHIFT){
      precisionAim = !precisionAim;
      keyCode = DOWN;
    }
  }
}

void paintRectangle(){
  pushMatrix();
  translate(0,0,-RAD);
  fill(0,70,0);
  rectMode(CENTER);
  rect(0,0,900,500,25);
  popMatrix();
}

void paintBalls(){
  for(Ball b : p.getBallSet()){
    if(!b.inYet()){
      pushMatrix();
      lights();
      ambientLight(255, 255, 255);
      directionalLight(255, 255, 255, b.getX() + 25, b.getY() - 25, - 50); 
      directionalLight(255, 255, 255, b.getX() - 25, b.getY() + 25, - 50); 
      directionalLight(255, 255, 255, b.getX() - 25, b.getY() - 25, 50); 
      directionalLight(255, 255, 255, b.getX() + 25, b.getY() + 25, 50); 
      pointLight(255, 255, 255, b.getX() + 25, b.getY() - 25, + 50); 
      translate(b.getX(),b.getY(),0);
      /*if(rotatable){
        fill(b.getColor());
        //shininess(4.0);
        //specular(255);
        stroke(0);
        strokeWeight(0.25);
        sphere(RAD);
      }else{
        fill(b.getColor());
        ellipse(0,0,RAD*2,RAD*2);
      }
      */
      b.insertSpinRotations();
      b.renderGlobe();  
      popMatrix();
    }
  }
  if(scratch){
    cueBall.setX(mouseX-x);
    cueBall.setY(mouseY-y);
  }
}

void showBallAim(){
  translate(30,30,0);
  fill(255);
  ellipse(0,0,60,60);
  
}

void paintSights(){
  //cue stick
  if(precisionAim){
    /*
    pushMatrix();
    translate(cueBall.getX(), cueBall.getY(), 0);
    stroke(0, 0, 15+shotPower*100, shotPower*30+30);
    rotateZ(-viewHorizontal);
    fill( 0, 0, 15+shotPower*100, shotPower*30+30);
    cylinder(15, 2600, 90);
    popMatrix();
    */
  }
  else{
    pushMatrix();
    translate(cueBall.getX(), cueBall.getY(), 0);
    rotateZ(-viewHorizontal);
      pushMatrix();
      translate(0,250+shotPower*8,0);
      fill(0, 0, 15+shotPower*100, shotPower*30+30);
      stroke(15+shotPower*15, 0, 0, shotPower*15+30);
      cylinder(3.5, 500-(shotPower*16), 90);
      popMatrix();
      
      pushMatrix();
      fill(255,51,102);
      translate(-10,175+shotPower*8,90);
      cylinder(0.5, shotPower*8, 90);
      popMatrix();
    popMatrix();
  }
}

void cylinder(float w, float h, int sides){
  float angle;
  float[] x = new float[sides+1];
  float[] y = new float[sides+1];
  for(int i=0; i<x.length; i++){
    angle = TWO_PI/sides*i;
    x[i] = sin(angle)*w;
    y[i] = cos(angle)*w;
  }
  beginShape(TRIANGLE_FAN); 
  vertex(0, -h/2, 0);
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, y[i]);
  }
  endShape();
  beginShape(QUAD_STRIP);
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, y[i]);
    vertex(x[i], h/2, y[i]);
  }
  endShape();
  beginShape(TRIANGLE_FAN);
  vertex(0, h/2, 0);
  for(int i=0; i < x.length; i++){
    vertex(x[i], h/2, y[i]);
  }
  endShape();    
}
  




