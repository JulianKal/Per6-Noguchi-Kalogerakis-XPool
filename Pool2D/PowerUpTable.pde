import java.util.*;
public class PowerUpTable{
  ////////////////////////////////////////////////
  public class PowerUpStack{
    private Stack<PowerUp> S;
    
    public PowerUpStack(){
      S = new Stack<PowerUp>();
    }

    public Stack<PowerUp> getStack(){
      return S;
    }
  }
  ////////////////////////////////////////////////
  
  private ArrayList<PowerUpStack>[] powerUps;
  
  public PowerUpTable(){
    powerUps = new ArrayList<PowerUpStack>();
    for(int i = 0; i < 4; i++){
      powerUps.add(new PowerUpStack());
    }
  }
  
  public PowerUpStack getStack(int i){
    return powerUps.get(i);
  }
  
  public boolean isEmpty(){
    for(PowerUpStack P : powerUps){
      if(!powerUps.empty()){
        return false;
      }
    }
    return true;
  }
  
  public void add(int i){
    PowerUp p = new PowerUp(i);
    powerUps.get(i).push(p);
  }
  
  
  public PowerUp remove(int i){
    if(!powerUps.isEmpty()){
      if(!powerUps.get(i).empty()){
        return powerUps.get(i).pop();
      }
    }
    else{
      println("You have no PowerUps!!!!");
    }
  }
  
}
