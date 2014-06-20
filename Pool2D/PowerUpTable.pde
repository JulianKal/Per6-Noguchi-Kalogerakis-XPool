import java.util.*;
import java.io.*;
public class PowerUpTable{
  private ArrayList<Stack<PowerUp>> powerUps;
  
  public PowerUpTable(){
    powerUps = new ArrayList<Stack<PowerUp>>();
    for(int i = 0; i < 6; i++){
      powerUps.add(new Stack<PowerUp>());
    }
  }
  
  public Stack<PowerUp> getStack(int i){
    return powerUps.get(i);
  }
  
  public boolean isEmpty(){
    for(Stack<PowerUp> P : powerUps){
      if(!P.empty()){
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
    return powerUps.get(i).pop();
  }
  
   public PowerUp get(int i){
    return powerUps.get(i).peek();
  }
}
