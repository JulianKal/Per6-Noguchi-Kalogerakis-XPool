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
    if (type == 2){
      Pool2D.specialPower += .65;
    }
    else if(type == 3){
      Pool2D.randomizeNow = true;
    }
    else if(type == 4){
      Pool2D.liftSolidsNow = true;
    } 
    else if(type == 5){
      Pool2D.dropSolidsNow = true;
    }
  }
  
}
