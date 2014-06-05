public class Pool{
  private ArrayList<Ball> ballSet;
  private ArrayList<Hole> holeSet;
  
  public Pool(){
    ballSet = new ArrayList<Ball>();
    holeSet = new ArrayList<Hole>();
  }

  
  public void update(){
    for(Ball b : ballSet){
      if(!b.inYet()){
        b.update();
        if (dist(b.getX(), b.getY(), 450, 250) < 60 ||
            dist(b.getX(), b.getY(), -450, 250) < 60 ||
            dist(b.getX(), b.getY(), 450, -250) < 60 ||
            dist(b.getX(), b.getY(), -450, -250) < 60 ||
            dist(b.getX(), b.getY(), 0, 250) < 60 ||
            dist(b.getX(), b.getY(), 0, -250) < 60){
          if(!b.cueBall()){   
          b.setColor(color(0, 0, 0));
          }
          b.setX(1000);
          b.setY(1000);
          b.setXVel(0);
          b.setYVel(0);
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
  public void set(Hole h){
    holeSet.add(h);
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

