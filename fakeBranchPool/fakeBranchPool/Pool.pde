public class Pool{
  private ArrayList<Ball> ballSet;
  
  public Pool(){
    ballSet = new ArrayList<Ball>();
  }
  
  public void update(){
    for(Ball b : ballSet){
      b.update();
    }
  }
  public void set(Ball b){
    ballSet.add(b);
  }
  public ArrayList<Ball> getBallSet(){
    return ballSet;
  }
  
  public boolean stopped(){
    for(Ball b : ballSet){
      if(abs(b.getXVel())>0.1 && abs(b.getYVel())>0.1){
        return false;
      }
    }
    return true;
  }
}

