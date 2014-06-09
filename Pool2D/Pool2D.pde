import javax.swing.*;

Pool p = new Pool();
Player p1,p2;
Player turn;
float x, y, z;
float viewHorizontal,keyHorizontal,mouseHorizontal;
float viewVertical = .35;
float addSpinHoriz, addSpinVert;
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
float FRICTION = -0.04;
float FPS = 60;
Ball cueBall;

void setup() {
  Player p1 = new Player();
  p1.setColor(0);
  Player p2 = new Player();
  p2.setColor(0);
  
  turn = p1;
  
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
  
}

void draw(){
  if(p.stopped()){
    checkTurns();
  }
  
  background(190, 197, 185);
  ambientLight(255, 255, 255);
  
  pushMatrix();
  
  fill(100);
  textFont(createFont("Ariel",16,true));
  if(turn==p1){
    text("Turn: Player 1:",20,50);
  }else{
    text("Turn: Player 2:",20,50);
  }
  
  popMatrix();
  
  if(shooting){
    showBallAim();
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
    if(shooting==false){
      try{
        Thread.sleep(3000);
        checkTurns();
     }catch(Exception e){}
    }
    shooting = true;
  }
}

void exit(){
  super.exit();
}

void checkTurns(){
  if(!turn.getGotBallIn()){
    changeTurns();
  }
  if(turn.getScratched()){
    changeTurns();
    scratch = !scratch;
    rotatable = !rotatable;
  }
  if(turn.lost()){
    //WIN!
    println("End game.");
  }
  if(turn.won()){
    println("end game.");
  }
}

void changeTurns(){
  if(turn==p1){
    turn=p2;
  }else{
    turn=p1;
  }
}

void mouseClicked(){
  scratch = !scratch;
  rotatable = !rotatable;
}

void shoot(){
  if(shooting){
    println(shotPower*addSpinHoriz);
    cueBall.insertForce(shotPower,(1.5*PI)-viewHorizontal);
    cueBall.insertSpinHoriz(shotPower*addSpinHoriz,(1.5*PI)-viewHorizontal);
    cueBall.insertSpinVert(shotPower*addSpinVert);
    shotPower = 0;
    shooting = false;
    addSpinVert = 0;
    addSpinHoriz = 0;
  }
}

void keyPressed(){
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
  translate(-22.5, -22.5, -15);
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
      ambientLight(255, 255, 255);
      directionalLight(255, 255, 255, b.getX() + 25, b.getY() - 25, - 50); 
      directionalLight(255, 255, 255, b.getX() - 25, b.getY() + 25, - 50); 
      directionalLight(255, 255, 255, b.getX() - 25, b.getY() - 25, 50); 
      directionalLight(255, 255, 255, b.getX() + 25, b.getY() + 25, 50); 
      pointLight(255, 255, 255, b.getX() + 25, b.getY() - 25, + 50); 
      translate(b.getX(),b.getY(),0);
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
  pushMatrix();
  translate(x,30,0);
  fill(255);
  ellipse(0,0,60,60);
  noStroke();
  fill(100,100,20);
  ellipse(100*addSpinVert,-100*addSpinHoriz,3,3);
  popMatrix();
}

void paintSights(){
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
    translate(0,shotPower*8,0);
    translate(addSpinVert*75,0,addSpinHoriz*75);
    cylinder(0.5, shotPower*16, 90);
    popMatrix();
  popMatrix();
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
  




