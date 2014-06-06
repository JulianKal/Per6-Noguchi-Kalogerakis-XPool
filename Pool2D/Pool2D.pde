

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
  }
  p.set(new Hole(440, 540));
  p.set(new Hole(-440, 60));
  p.set(new Hole(440, 60));
  p.set(new Hole(0, 50));
  p.set(new Hole(0, 550));
  p.set(new Hole(-440, 540));
  
  p.set(cueBall);
  cueBall.setX(150);
  cueBall.setY(150);
  cueBall.setXVel(-10);
  cueBall.setYVel(10);
  cueBall.setColor(150);
  cueBall.setCueBall();
  lights();
}

void draw(){
  mx = mouseX; 
  my = mouseY;
  background(0);
  if(rotatable){
    rotateX(PI/2);
    chooseRotation();
    translate(x-15,-500,-400);
    pushMatrix();
    rotateX(HALF_PI);
    translate(0, 0, -300);
    fill(150, 0, 0);
    cylinder(5, 5000, 5);
    popMatrix();
    mx-=x+15;
    my-=-500;
  }else{
    translate(x,0,0);
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

void paintSights(){
  if(precisionAim){
    pushMatrix();
    translate(cueBall.getX(), cueBall.getY() + 300, 0);
    stroke(50, 10);
    rotateZ(-mousestuffZ);
    fill( 0, 0, 15 + shotPower*100, 30);
    cylinder(15, 2500, 30);
    popMatrix();
  }
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
    }
  }
  
}

void paintRectangle(){
  pushMatrix();
  translate(0,y,-18);
      my-=y;
  fill(0, 100, 0);
  rectMode(CENTER);
  box(900,500, -3);
  popMatrix();
}

void paintBalls(){
  for(Ball b : p.getBallSet()){
    if(!b.inYet()){
      pushMatrix();
      translate(b.getX(),b.getY()+y,0);
      if(rotatable){
        stroke(b.getColor());
        fill(100);
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
  

