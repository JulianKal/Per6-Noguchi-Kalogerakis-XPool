public class ViewManager{
  private int viewNum;
  private float viewAngle, mousePrecisionAngle, mouseRotatorAngle;
  private float viewVertical;
  public ViewManager(){
    viewNum = 1;
    viewVertical = .35;
  }
  
  public void toggleView(){
    viewNum++;
    if(viewNum == 4){
      viewNum = 1;
    }
  }
  
  public void update(){
    translate(0,0,0); //Center of rotation
    if(viewNum == 1){
      viewVertical = .35;
      viewPosition();
    }
    if(viewNum == 2){
      viewVertical = .45;
      shootingView();
    }
    if(viewNum == 3){
      viewVertical = 0;
      topView();
    }
    println("\nPrecisionAngle " + degrees(mousePrecisionAngle)%360);
    println("RotatorAngle " + degrees(mouseRotatorAngle)%360);
    println("\nViewAngle " + degrees(viewAngle)%360);
  }
  
  public void viewPosition(){
    viewAngle = mousePrecisionAngle + mouseRotatorAngle;
    mousePrecisionAngle = (mouseX-X_MID) * 0.001;
    if(abs(mousePrecisionAngle) > .42){
      mouseRotatorAngle += mousePrecisionAngle/35;
    }
    viewVertical = mouseY*0.001;
    rotateX(PI*viewVertical);
    rotate(viewAngle);
  }
  
  public void shootingView(){
    //translate(0,0,0); //translate to the coordinates of the cueball; this will come later. DOES NOT FOLLOW THE BALL AFTER SHOT.
    mousePrecisionAngle += (mouseX-X_MID)*.0008;
    if(abs(mouseX-X_MID) > 50){
      viewAngle += mousePrecisionAngle/3000;
    }
    else{
      mousePrecisionAngle /= 1.5;
    }
    rotateX(PI*viewVertical);
    rotate(viewAngle);
    if(abs(mousePrecisionAngle) > 18){
      mousePrecisionAngle/=1.1;  
    }
  }
  
  public void topView(){
    viewAngle = mousePrecisionAngle + mouseRotatorAngle;
    mousePrecisionAngle = (mouseX-X_MID) * 0.001;
    if(abs(mousePrecisionAngle) > .22){
      mouseRotatorAngle += mousePrecisionAngle/35;
    }
    rotateX(PI*viewVertical);
    rotate(viewAngle);
  }
    
}
