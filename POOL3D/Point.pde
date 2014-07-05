public class Point extends Collidable{
  private float _x,_y,_z;
  private PVector velocity;
  private ArrayList<PVector> velocityUpdates;
  
  public Point(float x,float y, float z, PVector velocity){
    _x = x;
    _y = y;
    _z = z;
    this.velocity = velocity;
    velocityUpdates = new ArrayList<PVector>();
  }
  
  public Point(float x, float y, float z, float vx, float vy, float vz){
    this(x,y,z,new PVector(vx,vy,vz));
  }
  
  public Point(float x,float y,float z){
    this(x,y,z,new PVector(0,0,0));
  }
  
  public Point(PVector v,PVector velocity){
    this(v.x,v.y,v.z,velocity);
  }
  
  public Point(PVector v,float vx, float vy, float vz){
    this(v.x,v.y,v.z,vx,vy,vz);
  }
  
  public Point(PVector v){
    this(v.x,v.y,v.z);
  }
  
  public Point(){
    this(0,0,0);
  }
  
  public void renderSurfaces(int r, int g, int b){
  
  }
  
  public void placeVertex(){
    vertex(_x,_y,_z);
  }
  
  public void update(){
    updateVelocity();
    _x += velocity.x;
    _y += velocity.y;
    _z += velocity.z;
    applyFriction();
  }
  
  public PVector vectorTo(Point p){
    return new PVector(p.getX()-_x,p.getY()-_y,p.getZ()-_z);
  }
  
  public float distance(Point p){
    return sqrt(sq(_x-p.getX()) + sq(_y-p.getY()) + sq(_z-p.getZ()));
  }
  
  public float distanceSq(Point p){
    return sq(_x-p.getX()) + sq(_y-p.getY()) + sq(_z-p.getZ());
  }
  
  public void updateVelocity(){
    for(PVector v : velocityUpdates){
      addVelocity(v.x,v.y,v.z);
    }
    velocityUpdates.clear();
  }
  public void updateVelocity(PVector v){
    velocityUpdates.add(v);
  }
  public void applyFriction(){
    velocity.mult(1-FRICTION);
  }
  
  public float getX(){ return _x;}
  public float getY(){ return _y;}
  public float getZ(){ return _z;}
  public void setX(float x){ _x = x;}
  public void setY(float y){ _y = y;}
  public void setZ(float z){ _z = z;}
  public PVector getPVector(){ return new PVector(_x,_y,_z);}
  public PVector velocity(){ return velocity;}
  public void setVelocity(float x, float y, float z){velocity.set(x,y,z);}
  public void setVelocity(PVector v){ velocity = v;}
  public void addVelocity(float x, float y, float z){
    velocity.set(velocity.x+x, velocity.y+y, velocity.z+z);
  }
  
                                                             
  public String toString(){
    return "(" + (int)_x + "," + (int)_y + "," + (int)_z + ")";
  }
  
}
