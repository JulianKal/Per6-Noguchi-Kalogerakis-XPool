public abstract class Mass extends Collidable{
  protected float mass;
  
  public void applyEnergy(Mass c, float mass, float vx, float vy, float vz){
    c.insertKinetic(mass,vx,vy,vz);
    insertKinetic(mass,-vx,-vy,-vz);
  }
  public void insertKinetic(float mass,float vx,float vy,float vz){
    if(movable){
      for(Point p : points){
        p.addVelocity((mass/this.mass) * vx,
                      (mass/this.mass) * vy,
                      (mass/this.mass) * vz);
      }
    }
    
  }
  
  public float getMass(){ return mass;}
  public void setMass(float f){ mass =f;}
  
  
}
