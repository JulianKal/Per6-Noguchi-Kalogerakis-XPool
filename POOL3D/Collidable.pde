

public abstract class Collidable{
  protected ArrayList<Point> points;
  protected float mass;
  protected boolean movable;
  
  abstract void update();
  
  abstract void renderSurfaces(int r,int g,int b);
  
  public ArrayList<Point> getPoints(){ return points; }
  public boolean isMovable(){ return movable; }
  public void setMovable(boolean b){ movable = b; }
  
  public float magnitude(float x, float y, float z){
    return sqrt(sq(x)+sq(y)+sq(z));
  }
  
}
