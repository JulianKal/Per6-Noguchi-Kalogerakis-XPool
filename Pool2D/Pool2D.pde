Pool p = new Pool();
Ball b1 = new Ball();
Ball b2 = new Ball();
Ball b3 = new Ball();
Ball cueBall = new Ball();
float x, y, z;
float mousestuffZ;
boolean rotatable = true;
boolean aim = true;
float mx, my;

void setup() {
  size(1000,600,P3D);
  background(0);
  
  x = width/2;
  y = height/2;
  z=0;
  for(int x=0;x<5;x++){
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
  //translate(x,y,z);
  //camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  
  if(rotatable){
    rotateX(PI/2);
    chooseRotation();
    
    translate(x-25,-500,-500);
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
  rotatable = !rotatable;
  
}

void buttonListener(){
  if(key==CODED){
    if(keyCode == LEFT){
       mousestuffZ += -PI/256;
       keyCode = UP;
    }else if(keyCode == RIGHT){
      mousestuffZ += PI/64;
      keyCode = UP;
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
}

void chooseRotation(){
  if(!aim){
    translate(x,y-500,z);
    rotateZ(mousestuffZ);
    translate(-x,-y+500,-z);
  }else{
    translate(x+b1.getX()/2,y-500 + b1.getY()/2,z);
    rotateZ(mousestuffZ);
    translate(-x-b1.getX()/2,-y+500-b1.getY()/2,-z);
  }
}

