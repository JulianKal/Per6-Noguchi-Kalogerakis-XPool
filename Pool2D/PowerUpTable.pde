import java.util.*;
import java.io.*;
public class PowerUpTable{
  
  private ArrayList<PowerUpStack> powerUps;
  
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
      if(!P.getStack().empty()){
        return false;
      }
    }
    return true;
  }
  
  public void add(int i){
    PowerUp p = new PowerUp(i);
    powerUps.get(i).getStack().push(p);
  }
  
  
  public void remove(int i){
    if(!powerUps.isEmpty()){
      if(!powerUps.get(i).getStack().empty()){
        powerUps.get(i).getStack().pop();
      }
    }
    else{
      println("You have no PowerUps!!!!");
    }
  }
}
