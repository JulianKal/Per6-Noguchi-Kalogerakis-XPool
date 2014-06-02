Pool p = new Pool();
Ball b1 = new Ball();
Ball b2 = new Ball();
Ball b3 = new Ball();
Ball cueBall = new Ball();
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

void setup() {
  size(1000,600,P3D);
  background(0);
  
  x = width/2;
  y = height/2;
  z = 500;
  for(int x=0;x<10;x++){
    p.set(new Ball(random(500)-250,random(500)-250,random(80)-40,random(80)-40));
  }
  p.set(b1);
  p.set(cueBall);
  b1.setX(150);
  b1.setY(150);
  b1.setXVel(-50);
  b1.setYVel(40);
  b1.setColor(150);
  lights();
}

void draw(){
  mx = mouseX; 
  my = mouseY;
  background(0);
  
  pushMatrix();
  translate(mx, my, 0);
  stroke(20);
  rotateY(-mousestuffZ);
  fill(155, 0, 0);
  box(2500, 5, 5);
  fill( 0, 0, 155);
  box(5, 2500, 5);
  fill(0, 155, 0);
  box(5, 5, 2500);
  popMatrix();
  
  if(rotatable){
    rotateX(PI/2);
    chooseRotation();
    translate(x-25,-500,-400);
    mx-=x+25;
    my-=-500;
  }else{
    translate(x,0,0);
  }
  
  paintRectangle();
  paintBalls();
  
  /*
  cueBall.setX(mx);
  cueBall.setY(my);
  */
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
        b1.setXVel(10*shotPower*sin(PI+mousestuffZ));
        b1.setYVel(10*shotPower*cos(PI+mousestuffZ));
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
  translate(0,y,-25);
      my-=y;
  fill(100);
  rectMode(CENTER);
  rect(0,0,900,500);
  popMatrix();
}

void paintBalls(){
  for(Ball b : p.getBallSet()){
    pushMatrix();
    translate(b.getX(),b.getY()+y,0);
    if(rotatable){
      stroke(b.getColor());
      fill(100);
      sphere(25);
    }else{
      fill(b.getColor());
      ellipse(0,0,50,50);
    }
    popMatrix();
  }
  if(scratch){
    b1.setX(mouseX-x);
    b1.setY(mouseY-y);
  }
}

void chooseRotation(){
  println(p.stopped());
  //If all of the balls have stopped moving, then..
  if(!p.stopped()){
    translate(x,y-500,z);
    rotateZ(mousestuffZ);
    translate(-x,-y+500,-z); 
  }
  //If at least one of the balls is in motion, then..
  else{
    translate(x+b1.getX()/2,y-500 + b1.getY()/2,z);
    rotateZ(mousestuffZ);
    translate(-x-b1.getX()/2,-y+500-b1.getY()/2,-z);
  }
}

