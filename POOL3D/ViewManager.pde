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
<<<<<<< HEAD
    translate(0,0,0); //Center of rotation
    println("ctrX " + (int)centerX); 
    println("ctrY " + (int)centerY); 
    println("ctrZ " + (int)centerZ);
    viewPosition();
    translate(centerX,centerY,centerZ);
=======
    //translate(0,0,0); //Center of rotation
    translate(centerX,centerY,-centerZ);
    
    if(viewNum == 1){
      viewPosition();
    }
    if(viewNum == 2){
      viewAngleVert = .45;
      shootingView();
    }
    if(viewNum == 3){
      viewAngleVert = 0;
      topView();
    }
//    translate(world.getBalls().get(0).getCenter().getX(),world.getBalls().get(0).getCenter().getY(),world.getBalls().get(0).getCenter().getZ());
>>>>>>> FETCH_HEAD
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
<<<<<<< HEAD
    if(abs(mousePrecisionAngleVert) > .32 && !shooting){
=======
    if(abs(mousePrecisionAngleVert) > 0.32){
>>>>>>> FETCH_HEAD
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
