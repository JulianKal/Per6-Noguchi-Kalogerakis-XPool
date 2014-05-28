Pool p = new Pool();
Ball b1 = new Ball();
Ball b2 = new Ball();
Ball b3 = new Ball();
float x, y, z;
float mousestuffZ;
boolean end = true;

void setup() {
  size(1000,600,P3D);
  background(0);
  
  x = width/2;
  y = height/2;
  z=0;
  for(int x=0;x<10;x++){
    p.set(new Ball(random(500)-250,random(500)-250,random(50)-25,random(50)-25));
  }
  p.set(b1);
  b1.setX(150);
  b1.setY(150);
  b1.setXVel(-50);
  b1.setYVel(40);
  
  lights();
}

void draw(){
  background(0);
  //translate(x,y,z);
  //camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  rotateX(PI/2);
  
  if(!end){
    translate(x,y-500,z);
    rotateZ(mousestuffZ);
    translate(-x,-y+500,-z);
  }else{
    translate(x+b1.getX()/2,y-500 + b1.getY()/2,z);
    rotateZ(mousestuffZ);
    translate(-x-b1.getX()/2,-y+500-b1.getY()/2,-z);
  }
  
  translate(x-25,-500,-500);
  pushMatrix();
  translate(0,y,-25);
  fill(100);
  rectMode(CENTER);
  rect(0,0,900,500);
  popMatrix();
  
  for(Ball b : p.getBallSet()){
    pushMatrix();
    stroke(255);
    fill(b.getColor());
    translate(b.getX(),b.getY()+y,0);
    rotateZ(mousestuffZ);
    sphere(25);
    popMatrix();
  }
  if(key==CODED){
    if(keyCode == LEFT){
       mousestuffZ += -PI/64;
       keyCode = UP;
    }else if(keyCode == RIGHT){
      mousestuffZ += PI/64;
      keyCode = UP;
    }
  }
  
  p.update();
  
}

void exit(){
  super.exit();
}

void mouseClicked(){
  end  = !end;
}

