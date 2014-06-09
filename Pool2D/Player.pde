public class Player{
  private int ballColor; //0 is open table, 1 is striped, 2 is solid, 8 is 8 ball.
  private boolean gotBallIn; //Whether the player got the ball in or not.
  private int ballCount; //Balls left
  private boolean scratch;
  private boolean lost;
  private boolean won= false;
  private ArrayList<Ball> pocketed;
  
  public Player(){
    ballColor = 0;
    gotBallIn = true;
    ballCount = 7;
    lost = false;
    pocketed = new ArrayList<Ball>();
  }
  
  public void pocketBall(Ball b){
    switch(ballColor){
      case 0:
      if(b.getBallNumber()==8){
        lost=true;
      }else if(b.getBallNumber()<8){
        ballColor = 2;
      }else if(b.getBallNumber()>8){
        ballColor = 1;
      }
      break;
      case 2:
      if(b.getBallNumber()==8){
        lost = true;
      }else if(b.getBallNumber()<8){
        gotBallIn = gotBallIn && true;
      }else if(b.getBallNumber()>8){
        gotBallIn = false;
      }
      break;
      case 1:
      if(b.getBallNumber()==8){
        lost = true;
      }else if(b.getBallNumber()<8){
        gotBallIn = false;
      }else if(b.getBallNumber()>8){
        gotBallIn = gotBallIn && true;
      }
      break;
      case 8:
      if(b.getBallNumber()==8){
        won = true;
      }else{
        gotBallIn = false;
      }
    }
  }
  
  public boolean getScratched(){return scratch;}
  public void gotScratch(){scratch=true;}
  public int getColor(){ return ballColor; }
  public void setColor(int i){ ballColor = i;}
  public void getBallIn(boolean b){ gotBallIn = b;}
  public boolean getGotBallIn(){return gotBallIn;}
  public void setBallCount(int x){ballCount = x;}
  public boolean lost(){ return lost;}
  public boolean won(){ return won;}
  public void decreaseBallCount(){
    if(ballCount>0){
      ballCount--;
    }else{
      ballColor = 8;
    }
  }
  public int getBallCount(){return ballCount;}


 private PowerUpTable powers;
 private boolean solids;
 
 public Player(){
   boolean solids = false;
   powers = new PowerUpTable();
 }
 
 public PowerUpTable getPowers(){
   return powers;
 }
  
  public boolean getSolids(){
    return solids;
  }

  public void switchStripSolid(){
   solids = !solids;
  }  
  
}
