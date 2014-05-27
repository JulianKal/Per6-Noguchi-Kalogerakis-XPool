Pool p = new Pool();
Ball b1 = new Ball();
Ball b2 = new Ball();
Ball b3 = new Ball();
float x, y, z;

void setup() {
  size(1000,600,P3D);
  background(0);
  
  x = width/2;
  y = height/2;
  z=0;
  
  b1.setX(-150);
  b1.setY(0);
  b1.setXVel(45);
  b1.setYVel(-35);
  
  b2.setX(150);
  b2.setY(0);
  b2.setXVel(-50);
  b2.setYVel(40);
  
  b3.setX(0);
  b3.setY(-150);
  b3.setXVel(10);
  b3.setYVel(-30);
  
  p.set(b1);
  p.set(b2);
  p.set(b3);
}

void draw(){
  background(0);
  translate(x,y,z);
  
  fill(100);
  rectMode(CENTER);
  rect(0,0,900,500);
  
  for(Ball b : p.getBallSet()){
    fill(255);
    ellipse(b.getX(),b.getY(),50,50);
  }
    
  p.update();
  
}
