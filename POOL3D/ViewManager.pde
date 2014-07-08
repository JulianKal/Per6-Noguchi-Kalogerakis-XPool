public class ViewManager{
  private int viewNum;
  private float centerX, centerY, centerZ;
  private float mousePrecisionAngleHoriz, mouseRotatorAngleHoriz, mousePrecisionAngleVert, mouseRotatorAngleVert;
  private float viewAngleHoriz, viewAngleVert;
  public ViewManager(){
    viewNum = 1;
  }
  
  public void toggleView(){
    viewNum++;
    if(viewNum == 4){
      viewNum = 1;
    }
  }
  
  public void update(){
    keyListener();
    translate(0,0,0); //Center of rotation
    println("ctrX " + (int)centerX); 
    println("ctrY " + (int)centerY); 
    println("ctrZ " + (int)centerZ); 
    
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
    translate(centerX,centerY,centerZ);
  }
  
  //Horizontal Rotation
  public void viewPosition(){
    viewAngleHoriz = mousePrecisionAngleHoriz + mouseRotatorAngleHoriz;
    mousePrecisionAngleHoriz = (mouseX-X_MID) * 0.001;
    if(abs(mousePrecisionAngleHoriz) > .46){
      mouseRotatorAngleHoriz += mousePrecisionAngleHoriz/20;
    }
    rotateY(-viewAngleHoriz);
    
    //Vertical Rotation
    viewAngleVert = mousePrecisionAngleVert + mouseRotatorAngleVert;
    mousePrecisionAngleVert = (mouseY-Y_MID) * 0.001;
    if(abs(mousePrecisionAngleVert) > .32){
      mouseRotatorAngleVert += mousePrecisionAngleVert/20*.46/.32;
    }
    rotateY(-viewAngleHoriz);
    rotateX(-(viewAngleVert + 1));
    rotateY(viewAngleHoriz);
  }
  
  public void shootingView(){
    //translate(0,0,0); //translate to the coordinates of the cueball; this will come later. DOES NOT FOLLOW THE BALL AFTER SHOT.
    mousePrecisionAngleHoriz += (mouseX-X_MID)*.0008;
    if(abs(mouseX-X_MID) > 50){
      viewAngleHoriz += mousePrecisionAngleHoriz/30;
    }
    else{
      mousePrecisionAngleHoriz /= 1.5;
    }
    rotateX(PI*viewAngleVert);
    rotate(viewAngleHoriz);
    if(abs(mousePrecisionAngleHoriz) > 18){
      mousePrecisionAngleHoriz/=1.1;  
    }
  }
  
  public void topView(){
    viewAngleHoriz = mousePrecisionAngleHoriz + mouseRotatorAngleHoriz;
    mousePrecisionAngleHoriz = (mouseX-X_MID) * 0.001;
    if(abs(mousePrecisionAngleHoriz) > .22){
      mouseRotatorAngleHoriz += mousePrecisionAngleHoriz/25;
    }
    rotateX(PI*viewAngleVert);
    rotate(viewAngleHoriz);
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
    }
  }
}
