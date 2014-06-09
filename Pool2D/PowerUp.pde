public class PowerUp{
  private int type;
  
  public PowerUp(){
    type = 0;
  }
  
  public PowerUp(int x){
    type = x;
  }
    
  public int getType(){
    return type;
  }
  
  public void setType(int x){
    this.type = x;
  }
  
  public void usePower(){
    if(type == 1){
      //someScratchMethod();
    }
    else if (type == 2){
      Pool2D.specialPower += .65;
    }
    else if(type == 3){
      //randomizeBalls();
    }
    else if(type == 4){
      //liftEnemyBalls();
    }
  }
  
}
