//Purely for testing the further improved physics engine (with new and improved spin!)

Pool p = new Pool();
Ball cueBall = new Ball();
Ball b2 = new Ball();
Ball b3 = new Ball();
float x, y, z;
float mousestuffZ;
boolean aim = true;
boolean rotatable = true;
boolean scratch = false;
float mx, my;
float lastTime = millis();
float delay;
float shotPower = .7;
boolean precisionAim = false;
float RAD = 15;
float FRICTION = -0.05;
float FPS = 60;

void setup() {
  size(1000,600,P3D);
  background(0);
  frameRate(FPS);
  
  x = width/2;
  y = height/2;
  z = 500;
  for(int x=0;x<10;x++){
    p.set(new Ball(random(500)-250,random(500)-250,random(10)-5,random(10)-5));
    p.getBallSet().get(x).setColor(color(random(5)*30 + 170,random(5)*30 + 170, random(5)*30 + 170, 100));
  }
  
  p.set(new Hole(0, -285));
  p.set(new Hole(0, 285));
  p.set(new Hole(-440, -240));
  p.set(new Hole(-440, 240));
  p.set(new Hole(440, -240));
  p.set(new Hole(440, 240));
  p.set(cueBall);
  cueBall.setX(-100);
  cueBall.setY(0);
  cueBall.setXVel(-15);
  cueBall.setYVel(0);
  cueBall.setColor(150);
  cueBall.setCueBall();
  //cueBall.insertSpinHoriz(2,3*PI/2);
  cueBall.insertSpinVert(-2);
  cueBall.insertSpinVert(1);
  
  //p.set(b2);
  b2.setX(100);
  b2.setXVel(-10);
  b2.setYVel(1);
  b2.setColor(255);
  //b2.insertSpinHoriz(1,0);
}

void draw(){
  mx = mouseX;
  my = mouseY;
  background(0);
  pointLight(255, 255, 210, 600, 1200, 50);
  ambientLight(220, 220, 200);
  directionalLight(255, 255, 255, 600, 1200, 50);
  translate(x,y,35);
  if(rotatable){
    rotateX(PI*.25);
    rotate(mousestuffZ);
  }
  translate(-cueBall.getX(),-cueBall.getY(),0);
  paintRectangle();
  paintBalls();  
  paintSights();
  buttonListener();
  p.update();
}

void exit(){
  super.exit();
}

void mouseClicked(){
  scratch = !scratch;
  rotatable = !rotatable;
}

void buttonListener(){
  if(key==CODED){
    if(keyCode == UP){
      if(p.stopped()){
        cueBall.setXVel(10*shotPower*sin(PI+mousestuffZ));
        cueBall.setYVel(10*shotPower*cos(PI+mousestuffZ));
        delay = 3000;
      }
      keyCode = DOWN;
    }
    if(keyCode == LEFT){
      if(millis()-lastTime>delay){
        if (precisionAim){
          mousestuffZ += PI/1810;
        }
        else{
          mousestuffZ += PI/60;
        }
        keyCode = DOWN;
        lastTime = millis();
        delay = 0;
      }
    }else if(keyCode == RIGHT){
      if(millis()-lastTime>delay){
        if (precisionAim){
          mousestuffZ -= PI/1810;
        }
        else{
          mousestuffZ -= PI/60;
        }
        keyCode = DOWN;
        lastTime = millis();
        delay= 0;
      }
    }else if(keyCode == ALT){
      if(millis()-lastTime>delay){
        shotPower += .05;
        keyCode = DOWN;
        lastTime = millis();
        delay = 0;
      }
    }else if(keyCode == CONTROL){
      if(millis()-lastTime>delay){
        shotPower -= .05;
        keyCode = DOWN;
        lastTime = millis();
        delay = 0;
      }  
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
      translate(b.getX(),b.getY(),0);
      if(rotatable){
        fill(b.getColor());
        shininess(4.0);
        specular(255);
        sphere(RAD);
      }else{
        fill(b.getColor());
        ellipse(0,0,RAD*2,RAD*2);
      }
      popMatrix();
    }
  }
  if(scratch){
    cueBall.setX(mouseX-x);
    cueBall.setY(mouseY-y);
  }
}

void paintSights(){
  if(precisionAim){
    pushMatrix();
    translate(cueBall.getX(), cueBall.getY(), 0);
    stroke(0, 0, 15+shotPower*100, shotPower*30+30);
    rotateZ(-mousestuffZ);
    fill( 0, 0, 15+shotPower*100, shotPower*30+30);
    cylinder(15, 2600, 90);
    popMatrix();
  }
  else{
    pushMatrix();
    translate(cueBall.getX(), cueBall.getY(), 0);
    rotateZ(-mousestuffZ);
    fill(15+shotPower*100, 0, 0, shotPower*30+30);
    stroke(15+shotPower*100, 0, 0, shotPower*30+30);
    cylinder(3.5, 2600, 90);
    popMatrix();
  }
} 

void chooseRotation(){
  //If all of the balls have stopped moving, then..
  if(!p.stopped()){
    translate(x,y-500,z);
    rotateZ(mousestuffZ);
    translate(-x,-y+500,-z);
  }
  //If at least one of the balls is in motion, then..
  else{
    translate(x+cueBall.getX()/2,y-500 + cueBall.getY()/2,z);
    rotateZ(mousestuffZ);
    translate(-x-cueBall.getX()/2,-y+500-cueBall.getY()/2,-z);
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
  



