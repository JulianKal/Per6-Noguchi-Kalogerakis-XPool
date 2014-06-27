public class Pool{
  private ArrayList<Ball> ballSet;
  private ArrayList<Hole> holeSet;
  int temp = 0;
  
  public Pool(){
    ballSet = new ArrayList<Ball>();
    holeSet = new ArrayList<Hole>();
  }

  
  public void update(){
    for(Ball b : ballSet){
      if(!b.inYet()){
        //b.update();
        if (dist(b.getX(), b.getY(), 445, 245) < 40 ||
            dist(b.getX(), b.getY(), -445, 245) < 40 ||
            dist(b.getX(), b.getY(), 445, -245) < 40 ||
            dist(b.getX(), b.getY(), -445, -245) < 40 ||
            dist(b.getX(), b.getY(), 0, 275) < 40 ||
            dist(b.getX(), b.getY(), 0, -275) < 40){
          b.setX(515);
          b.setY(temp++);
          b.stop();
          if(b==cueBall){
            rotatable = false;
            scratch = true;
          }
        }   
      }
      else{
        for(Hole h : holeSet){          
          b.fallenIn(h);
        }
      }      
    }
    for(Hole h : holeSet){
      h.update();
    }
  }
  public void set(Ball b){
    ballSet.add(b);
  }
  public Ball getBall(int n){
    return ballSet.get(n);
  }
  public void set(Hole h){
    holeSet.add(h);
  }
  public ArrayList<Ball> getBallSet(){
    return ballSet;
  }
  
  public boolean stopped(){
    for(Ball b : ballSet){
      if(abs(b.getXVel())>0.0001 && abs(b.getYVel())>0.0001){
        return false;
      }
    }
    return true;
  }
}

