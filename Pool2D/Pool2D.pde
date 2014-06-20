import javax.swing.*;

////////////////////////////////////////////////////////////////////
//SETTING UP////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
Pool p = new Pool();
float x, y, z;
float viewHorizontal,keyHorizontal,mouseHorizontal;
float viewVertical = .35;
float addSpinHoriz, addSpinVert;
boolean aim = true;
boolean rotatable = true;
static boolean scratch = false;
boolean shooting = true;
boolean specialMode = true;
boolean checked = true;
float mx, my;
float lastTime = millis();
float delay;
float shotPower = .7;
public static float specialPower = 1.0;
public static boolean randomizeNow = false;
public static boolean addPower = false;
public static boolean liftSolidsNow = false;
public static boolean dropSolidsNow = false;
boolean precisionAim = false;
float RAD = 12.5;
float FRICTION = -0.04;
float FPS = 60;
Ball cueBall;
PowerUpTable POWERS = new PowerUpTable();
boolean POWERMODE = true;
//boolean POWERMODE = false;

void setup() {
  
  size(1000,600,P3D);
  background(0);
  frameRate(FPS);
  
  x = width/2;
  y = height/2;
  z = 500;
  
  keyHorizontal = -PI/2;
  
  PImage cueImage = loadImage("Zero.png");
  cueBall = new Ball(-300,0, cueImage);
  cueBall.setCueBall();
  cueBall.initializeSphere(35);
  scratch = true;
  rotatable = false;
  p.set(cueBall);
  for(int x=1;x<=15;x++){
    Ball b = new Ball(random(500)-250,random(500)-250, loadImage("" + x + ".png"));
    b.initializeSphere(35);
    b.setBallNumber(x);
    p.set(b);
    p.getBallSet().get(x).initializeSphere(35);
  }
  p.getBall(1).setXY(100,0);
  p.getBall(2).setXY(100+15*sqrt(3),15);
  p.getBall(3).setXY(100+15*sqrt(3),-15);
  p.getBall(4).setXY(100+30*sqrt(3),30);
  p.getBall(5).setXY(100+30*sqrt(3),0);
  p.getBall(6).setXY(100+30*sqrt(3),-30);
  p.getBall(7).setXY(100+45*sqrt(3),-45);
  p.getBall(8).setXY(100+45*sqrt(3),-15);
  p.getBall(9).setXY(100+45*sqrt(3),15);
  p.getBall(10).setXY(100+45*sqrt(3),45);
  p.getBall(11).setXY(100+60*sqrt(3),-60);
  p.getBall(12).setXY(100+60*sqrt(3),-30);
  p.getBall(13).setXY(100+60*sqrt(3),0);
  p.getBall(14).setXY(100+60*sqrt(3),30);
  p.getBall(15).setXY(100+60*sqrt(3),60);
  
  p.set(new Hole(0, -275));
  p.set(new Hole(0, 275));
  
  for(int x=0;x<40;x+=5){
    p.set(new Hole(-445-x, -245-x));
    p.set(new Hole(-445-x, 245+x));
    p.set(new Hole(445+x, -245-x));
    p.set(new Hole(445+x, 245+x));
  }
  
  if(POWERMODE){
    POWERS.add(1);
    POWERS.add(1);
    POWERS.add(2);
    POWERS.add(2);
    POWERS.add(3);
    POWERS.add(3);
    POWERS.add(4);
    POWERS.add(5);
    POWERS.add(4);
    POWERS.add(5);
  }
  
}

////////////////////////////////////////////////////////////////////
//DRAWIN'////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void draw(){
  
  background(190, 197, 185);
  ambientLight(255, 255, 255);
  if(addPower){
    int i = 1 + (int)(random(5));
    if(i == 4){
      POWERS.add(5);
    }
    if(i == 5){
      POWERS.add(4);
    }
    POWERS.add(i);
    addPower = false;
  }
  
  if(shooting){
    showBallAim();
    showPowers();
  }
  translate(x,y,35);
  
  if(rotatable){
    viewHorizontal = mouseHorizontal + keyHorizontal;
    mouseHorizontal = -(mouseX-x) * 0.001;
    viewVertical = mouseY*0.001;
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
    shooting = true;
  }
}

void exit(){
  super.exit();
}

void mouseClicked(){
  scratch = !scratch;
  rotatable = !rotatable;
}


void shoot(){
  if(shooting){
    //println(shotPower*addSpinHoriz);
    cueBall.insertForce(shotPower*specialPower,(1.5*PI)-viewHorizontal);
    cueBall.insertSpinHoriz(shotPower*addSpinHoriz,(1.5*PI)-viewHorizontal);
    cueBall.insertSpinVert(shotPower*addSpinVert);
    shotPower = 0;
    shooting = false;
    addSpinVert = 0;
    addSpinHoriz = 0;
    if(specialPower > 1){
      specialPower = 1;
    }
  }
}

void keyPressed(){
  if(key == '1' && shooting){
    try{
      POWERS.remove(1);
    }catch(Exception e){
      e.printStackTrace();
    }
    key = 'p'; 
  }
  if(key == '2' && shooting){
    try{
      POWERS.remove(2).usePower();
    }catch(Exception e){
      e.printStackTrace();
    }
    keyCode = DOWN; 
  }
  if(key == '3' && shooting){
    try{
      POWERS.remove(3).usePower();
    }catch(Exception e){
      e.printStackTrace();
    }
    if(randomizeNow){
      randomizeBalls();
    }
  }
  if(key == '4' && shooting){
    try{
      POWERS.remove(4).usePower();
    }catch(Exception e){
      e.printStackTrace();
    }
    if(liftSolidsNow){
      liftSolids();
    }
  }
  if(key == '5' && shooting){
    try{
      POWERS.remove(5).usePower();
    }catch(Exception e){
      e.printStackTrace();
    }
    liftSolidsNow = false;
    if(dropSolidsNow){
      dropSolids();
    }
  }
  if(key==';'){
    if(viewVertical < .55){
      viewVertical += .005;
    }
  }
  if(key=='/'){
    if(viewVertical > .1){
      viewVertical -= .005;
    }
  }
  if(key=='x'){
    if(shotPower<25){
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
    cueBall.stop();
  }
  if(key=='w'){
    if(addSpinHoriz<0.2){
      addSpinHoriz += 0.01;
    }
  }
  if(key=='a'){
   if(addSpinVert >-.2){
     addSpinVert-=0.01;
   }
  }
  if(key=='s'){
    if(addSpinHoriz >-.2){
      addSpinHoriz-=0.01;
    }
  }
  if(key=='d'){
    if(addSpinVert<0.2){
      addSpinVert+=0.01;
    }
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
  pushMatrix();
  translate(-22.5, -22.5, -12.5);
  fill(0,0,118);
  rectMode(CENTER);
  rect(30, 30, 960, 560, 45);
  popMatrix();
  popMatrix();
}

void paintBalls(){
  for(Ball b : p.getBallSet()){
    if(!b.inYet()){
      pushMatrix();
      lights();
      if(liftSolidsNow && !dropSolidsNow && b.getBallNumber() <= 8 && b.getBallNumber() > 0){
        b.setElevation(b.getElevation() + 1);
      }
      if(!liftSolidsNow && dropSolidsNow && b.getBallNumber() <= 8 && b.getBallNumber() > 0){
        b.setElevation(b.getElevation() - 1);
      }
      if(b.getElevation() > 120){
        b.setElevation(120);
      }
      if(b.getElevation() < 0){
        b.setElevation(0);
      }
      translate(b.getX(),b.getY(), b.getElevation());
      b.insertSpinRotations();
      b.renderGlobe();  
      popMatrix();
      pushMatrix();
      //directionalLight(255, 255, 255, b.getX() + 25, b.getY() - 25, - 50); 
      //directionalLight(255, 255, 255, b.getX() - 25, b.getY() + 25, - 50); 
      //directionalLight(255, 255, 255, b.getX() - 25, b.getY() - 25, 50); 
      //directionalLight(255, 255, 255, b.getX() + 25, b.getY() + 25, 50); 
      //pointLight(255, 255, 255, b.getX() + 25, b.getY() - 25, + 50); 
      popMatrix();
    }
  }
  if(scratch){
    cueBall.setX(mouseX-x);
    cueBall.setY(mouseY-y);
  }
}

void showBallAim(){
  pushMatrix();
  translate(x,30,0);
  fill(255);
  ellipse(0,0,60,60);
  noStroke();
  fill(100,100,20);
  ellipse(100*addSpinVert,-100*addSpinHoriz,3,3);
  popMatrix();
}

void showPowers(){
  for(int i=0; i<6; i++){
    if(!POWERS.getStack(i).empty()){
      pushMatrix();
      translate((i-1)*45,0,0);
      stroke(255, 140);
      fill(50 * i, 135);
      if(i==5){
        rect(0, 0, 45, 50*(i-1));
      }
      else{
        rect(0, 0, 45, 50*i);
      }
      popMatrix();
    }
  }
}

void paintSights(){
  pushMatrix();
  translate(cueBall.getX(), cueBall.getY(), 0);
  rotateZ(-viewHorizontal);
  
    pushMatrix();
    translate(0,250+shotPower*8,0);
    translate(addSpinVert*75,0,addSpinHoriz*75);
    fill(0, 0, 15+shotPower*100, shotPower*30+30);
    if(specialPower > 1){
      stroke(15+shotPower*15, shotPower*15+30);
    }
    stroke(15+shotPower*15, 0, 0, shotPower*15+30);
    cylinder(3.5, 500-(shotPower*16), 90);
    popMatrix();
    
    pushMatrix();
    fill(255,51,102);
    translate(0,shotPower*8,0);
    translate(addSpinVert*75,0,addSpinHoriz*75);
    cylinder(0.5, shotPower*16, 90);
    popMatrix();
  popMatrix();
}

public void randomizeBalls(){
  for(Ball b : p.getBallSet()){
    if(abs(b.getX()) < 450 && abs(b.getY()) < 250){
      b.setX(random(900)-450);
      b.setY(random(500)-250);
    }
  }
  randomizeNow = false;
}

public void liftSolids(){
  for(Ball b: p.getBallSet()){
    if((abs(b.getX()) < 450 && abs(b.getY()) < 250) && b.getBallNumber() <= 8 && b.getBallNumber() > 0){
      if(liftSolidsNow && !dropSolidsNow){
        b.setElevation(b.getElevation() + 10);
      }
    }
  }
}

public void dropSolids(){
  for(Ball b: p.getBallSet()){
    if((abs(b.getX()) < 450 && abs(b.getY()) < 250) && b.getBallNumber() <= 8 && b.getBallNumber() > 0){
      b.setElevation(b.getElevation() - 10);
    }
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
