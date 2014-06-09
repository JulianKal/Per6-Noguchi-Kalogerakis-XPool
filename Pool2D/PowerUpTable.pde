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
<<<<<<< HEAD
      if(!P.getStack().empty()){
=======
      /*
      if(!powerUps.empty()){
>>>>>>> FETCH_HEAD
        return false;
      }
      */
    }
    return true;
  }
  
  public void add(int i){
    PowerUp p = new PowerUp(i);
<<<<<<< HEAD
    powerUps.get(i).getStack().push(p);
  }
  
  
  public void remove(int i){
    if(!powerUps.isEmpty()){
      if(!powerUps.get(i).getStack().empty()){
        powerUps.get(i).getStack().pop();
=======
    //powerUps.get(i).push(p);
  }
  
  /*
  public PowerUp remove(int i){
    if(!powerUps.isEmpty()){
      /*
      if(!powerUps.get(i).empty()){
        return powerUps.get(i).pop();
>>>>>>> FETCH_HEAD
      }
      
    }
    else{
      println("You have no PowerUps!!!!");
    }
  }
<<<<<<< HEAD
=======
  */
  
>>>>>>> FETCH_HEAD
}
