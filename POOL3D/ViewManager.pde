//view stuff. INCLUDES SHOOTING VIEW STUFF.

public class ViewManager{
  boolean shooting;
  private float centerX, centerY, centerZ;
  private float mousePrecisionAngleHoriz, mouseRotatorAngleHoriz, mousePrecisionAngleVert, mouseRotatorAngleVert;
  private float viewAngleHoriz, viewAngleVert;
  public ViewManager(){
    shooting = false;
  }
  
  public void update(){
    keyListener();
    translate(0,0,0); //Center of rotation
    println("ctrX " + (int)centerX); 
    println("ctrY " + (int)centerY); 
    println("ctrZ " + (int)centerZ);
    viewPosition();
    translate(centerX,centerY,centerZ);
  }
  
  //Horizontal Rotation
  public void viewPosition(){
    viewAngleHoriz = mousePrecisionAngleHoriz + mouseRotatorAngleHoriz;
    mousePrecisionAngleHoriz = (mouseX-X_MID) * 0.001;
    if(abs(mousePrecisionAngleHoriz) > .46 && !shooting){
      mouseRotatorAngleHoriz += mousePrecisionAngleHoriz/20;
    }
    
    rotateY(-viewAngleHoriz);
    
    //Vertical Rotation
    viewAngleVert = mousePrecisionAngleVert + mouseRotatorAngleVert;
    mousePrecisionAngleVert = (mouseY-Y_MID) * 0.001;
    if(abs(mousePrecisionAngleVert) > .32 && !shooting){
      mouseRotatorAngleVert += mousePrecisionAngleVert/20*.46/.32;
    }
    rotateY(-viewAngleHoriz);
    rotateX(-(viewAngleVert + 1));
    rotateY(viewAngleHoriz);
  }
  
  void keyListener(){
    if(keyPressed){
      if(key=='w' && centerY<200){
        centerY+=4;
      }
      if(key=='a' && centerX>-200){
        centerX-=4;
      }
      if(key=='d' && centerX<200){
        centerX+=4;
      }
      if(key=='s' && centerY>-200){
        centerY-=4;
      }
      if(key=='z' && centerZ<200){
        centerZ+=4;
      }
      if(key=='x' && centerZ>-200){
        centerZ-=4;
      }
      if(key==' '){
        shooting = !shooting;
        key='b';
      }
    }
  }
}
