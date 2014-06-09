public class Player{
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
