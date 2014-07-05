public abstract class Mass extends Collidable{
  protected float mass;
  
  public void applyEnergy(Mass c, PVector p){
    insertKinetic(c.mass,PVector.mult(p,-1));
    c.insertKinetic(this.mass,p);
  }
  
  public void insertKinetic(float mass,PVector v){
    println("\tinsertKinetic( " + (int)mass + ", " + v + ")");
    insertKinetic(mass,v.x,v.y,v.z);
  }
  
  public void insertKinetic(float mass,float vx,float vy,float vz){
    if(movable){
      for(Point p : points){
        p.addVelocity((this.mass/mass) * vx,
                      (this.mass/mass) * vy,
                      (this.mass/mass) * vz);
      }
    }
  }
  
  public float getMass(){ return mass;}
  public void setMass(float f){ mass =f;}
  
  
}
