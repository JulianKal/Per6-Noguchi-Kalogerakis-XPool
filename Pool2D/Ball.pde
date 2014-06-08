
public class Ball{
  private float _x, _y; //Positions of the ball, set using the translate() function.
  private float _vx, _vy; //Delta x and y, for velocity.
  private float _ax, _ay; //The acceleration (rate of change of speed)
  private int colorNum;
  private float _spinx,_spiny;
  private float _spinvert; //The spin that is mainly for curves.
                           //POS is clockwise, and NEG is counterclockwise.
  private float _prevRollingSpin,_prevRollingAngle, _rollingSpin;
  private boolean inYet = false;
  private boolean cueBall = false;
  private float rotation,rotationVert;
  ////////////////////////////////////////////////////////////////
  public PImage skin;
  private int sDetail = 60;  // Sphere detail setting
  private float R = 15;
  private float[] cx, cz, sphereX, sphereY, sphereZ;
  private float sinLUT[];
  private float cosLUT[];
  private float SINCOS_PRECISION = 0.5;
  private int SINCOS_LENGTH = int(360.0 / SINCOS_PRECISION);
  ////////////////////////////////////////////////////////////////

  public Ball(float x,float y, PImage skin, float vx,float vy){
    this(x,y, skin);
    _vx = vx;
    _vy = vy;
  }
  public Ball(float x, float y,  PImage skin){
    this.skin = skin;
    _x = x;
    _y = y;
    colorNum = 255;
  }
  public Ball(){
    this(0, 0, loadImage("ZeroImage.png"));
  }
  
  public void update(){
    insertLowPass();
    _x += _vx;
    _y += _vy;
    insertFriction();
    insertWallCollisions();
    insertBallCollisions();
    insertRollingSpin();
    insertSpinEffect(); //This has to go last so that collision checking occurs first.
  }
  
  ////////////////////////////////////////////////////
  //Spin. Spin will be measured in angle(radians) per frame.
  
  public void insertRollingSpin(){//For when the ball is rolling forward without obstruction.
    _rollingSpin = (1/FPS)*(speed())/R; //Using the radian formula for arclength of a circle
    insertSpinHoriz(_rollingSpin, direction());
    _prevRollingSpin = _rollingSpin;
    _prevRollingAngle = direction();
  }
  public void resetRollingSpin(){
    insertSpinHoriz(_prevRollingSpin,_prevRollingAngle);
    _prevRollingSpin = 0;
    _prevRollingAngle = direction();
  }
  public void insertSpinHoriz(float magnitude, float dir){
    _spinx += magnitude * cos(dir);
    _spiny += magnitude * sin(dir);
  }
  public void insertSpinVert(float magnitude){
    _spinvert = magnitude;
  }
  public void insertSpinEffect(){
    _vx += _spinx;
    _vy += _spiny;
    insertForce(0.09*_spinvert,direction()+PI/2);
    _spinx-= 0.7 * getSpinMag()*cos(spinHorizAngle());
    _spiny-= 0.7 * getSpinMag()*sin(spinHorizAngle());
    _spinvert *= 0.99;
    if(abs(_spinx)<0.0001){
      //_spinx = 0;
    }
    if(abs(_spiny)<0.0001){
      //_spiny = 0;
    }
    if(abs(_spinvert)<0.0001){
      //_spinvert = 0;
    }
  }  
  public float spinHorizAngle(){
    return angle(_spinx,_spiny);
  }
  public void spinVertWallLR(boolean right){
    if(right){
      insertForce(speed()*(_spinvert/(abs(_spinvert)+2)),3*PI/2);
    }else{
      insertForce(speed()*(_spinvert/(abs(_spinvert)+2)),PI/2);
    }
    _vx *= 1 - (_spinvert/(_spinvert+1));
    _vy *= 1 - (_spinvert/(_spinvert+1));
    _spinvert*=0.5;
  }
  public void spinVertWallUD(boolean up){
    if(up){
      insertForce(speed()*(_spinvert/(_spinvert+1)),0);
    }else{
      insertForce(speed()*(_spinvert/(_spinvert+1)),PI);
    }
    _vx *= 1 - (_spinvert/(_spinvert+1));
    _vy *= 1 - (_spinvert/(_spinvert+1));
    _spinvert*=0.5;
  }
  public void transferSpin(Ball b){
    b.addSpinVert(_spinvert * 0.3);
    _spinvert *= 0.6;
  }
  public void insertSpinRotations(){
    rotation += 100*getSpinMag();
    rotationVert += _spinvert;
    rotateZ(PI/2+spinHorizAngle());
    rotateX(rotation);
    rotateZ(-spinHorizAngle());
    rotateZ(rotationVert);
  }
  
  ////////////////////////////////////////////////////
  
  public void insertBallCollisions(){
    for(Ball b : p.getBallSet()){
      if(this != b){
        if(distance(b)<0){
          float translatedAngle = convert2PI(absoluteAngle(b) - direction());
          //Rotate such that this ball's direction is 0.
          if(cos(translatedAngle)>0){
            _x += distance(b)*cos(absoluteAngle(b)); //distance is less than 0.
            _y += distance(b)*sin(absoluteAngle(b));
            transferSpin(b);
            b.insertForce(speed()*cos(translatedAngle),absoluteAngle(b));
            insertForce(speed()*cos(translatedAngle+PI),absoluteAngle(b));
            resetRollingSpin(); //For collisions
          }
        }
      }
    }
  }
  
  public void insertLowPass(){ //Simple low pass filter for any float calculation errors.
    if(abs(_vx)<0.1){
      _vx=0;
    }
    if(abs(_vy)<0.1){
      _vy=0;
    }
  }
  public void insertFriction(){
    _vx += cos(direction())*FRICTION;
    _vy += sin(direction())*FRICTION;
  }
  public void insertWallCollisions(){
    boolean collided = false;
    if(_x<-425 || _x>425){
      _x -= _vx;
      _vx *= -1;
      _ax *= -1;
      collided = true;
      spinVertWallLR(_x>=0);
    }
    if(_y<-225 || _y>225){
      _y -= _vy;
      _vy *= -1;
      _ay *= -1;
      collided = true;
      spinVertWallUD(_y>=0);
    }
    if(collided){
      resetRollingSpin();
    }
  }
  public void insertForce(float velocity, float angle){
    float vx = velocity * cos(angle);
    float vy = velocity * sin(angle);
    _vx += vx;
    _vy += vy;
  }
  
  public float angle(float x, float y){ //Helper function
    if(x==0){
      
      if(y>0){
        return PI/2;
      }else{
        return 3*PI/2;
      }
    }
    float temp = 0;
    if(x>=0){
      if(y>=0){ //Quadrant 1
        return atan(y/x);
      }else{ //Quadrant IV
        return 2*PI - abs(atan(y/x));
      }
    }else{
      if(y>=0){//Quad II
        return PI - abs(atan(y/x));
      }else{ //Quad III
        return PI + abs(atan(y/x));
      }
    }
  }
  public float direction(){
    return angle(_vx,_vy);
  }
  
  public boolean fallenIn(Hole h) {
    boolean ans = (dist(x, y, h.getX(), h.getY()) < 60);
    setX(10000);
    setY(10000);
    if(ans){ 
      inYet = true;
    }
    return ans;
  }

  public boolean inYet(){
    return inYet;
  }
  
  public float absoluteAngle(Ball b){ //Angle between two balls
    float dy = b.getY() - _y;
    float dx = b.getX() - _x;
    return angle(dx, dy);
  }
  
  public float distance(Ball b){
    return sqrt(sq(_x-b.getX()) + sq(_y-b.getY()))-2*R;
  }
  
  public float convert2PI(float f){ //Convert angles to between 0 and 2PI
    while(f<0){
      f+= 2*PI;
    }
    while(f>2*PI){
      f-= 2*PI;
    }
    return f;
  }
  
  //Getters and setters;
  //public float getForce(){return sqrt(sq(_
  public void setX(float x){_x = x;}
  public void setY(float y){_y = y;}
  public float getX(){return _x;}
  public float getY(){return _y;}
  public void setXVel(float x){_vx = x;}
  public void setYVel(float y){_vy = y;}
  public float getXVel(){return _vx;}
  public float getYVel(){return _vy;}
  public float speed(){return sqrt(sq(_vx)+sq(_vy));}
  public float getSpinMag(){return sqrt(sq(_spinx)+sq(_spiny));}
  public void setSpinVert(float magnitude){ _spinvert = magnitude;}
  public void addSpinVert(float magnitude){ _spinvert += magnitude;}
  public float getSpinVert(){return _spinvert;}
  public void setColor(int c){colorNum = c;}
  public int getColor(){ return colorNum;}
  public boolean cueBall(){
    return cueBall;  
  }
  public void setCueBall(){
    cueBall = !cueBall;
  }
 public PImage getPImage(){
    return skin;
  }
    
  /////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////DO NOT ENTER///////////////////////////////////////////
  ///////////////////////////////////SKINS CODE//////////////////////////////////////////// 
  /////////////////////////////////////////////////////////////////////////////////////////  
  
  public void renderGlobe() {
    pushMatrix();
    strokeWeight(0.25);
    smooth();
    lights();
    fill(200);
    noStroke();
    textureMode(IMAGE);  
    texturedSphere(R, skin);
    popMatrix();
  }
  
  public void initializeSphere(int res){
    sinLUT = new float[SINCOS_LENGTH];
    cosLUT = new float[SINCOS_LENGTH];
    for (int i = 0; i < SINCOS_LENGTH; i++) {
      sinLUT[i] = (float) Math.sin(i * DEG_TO_RAD * SINCOS_PRECISION);
      cosLUT[i] = (float) Math.cos(i * DEG_TO_RAD * SINCOS_PRECISION);
    }
    float delta = (float)SINCOS_LENGTH/res;
    float[] cx = new float[res];
    float[] cz = new float[res];
    // Calc unit circle in XZ plane
    for (int i = 0; i < res; i++) {
      cx[i] = -cosLUT[(int) (i*delta) % SINCOS_LENGTH];
      cz[i] = sinLUT[(int) (i*delta) % SINCOS_LENGTH];
    }
    // Computing vertexlist vertexlist starts at south pole
    int vertCount = res * (res-1) + 2;
    int currVert = 0;
    // Re-init arrays to store vertices
    sphereX = new float[vertCount];
    sphereY = new float[vertCount];
    sphereZ = new float[vertCount];
    float angle_step = (SINCOS_LENGTH*0.5f)/res;
    float angle = angle_step;
    // Step along Y axis
    for (int i = 1; i < res; i++) {
      float curradius = sinLUT[(int) angle % SINCOS_LENGTH];
      float currY = -cosLUT[(int) angle % SINCOS_LENGTH];
      for (int j = 0; j < res; j++) {
        sphereX[currVert] = cx[j] * curradius;
        sphereY[currVert] = currY;
        sphereZ[currVert++] = cz[j] * curradius;
      }
      angle += angle_step;
    }
    sDetail = res;
  }
  
  // Generic routine to draw textured sphere
  public void texturedSphere(float r, PImage t) {
    //ambientLight(255, 255, 255);
    int v1,v11,v2;
    //r = (r + 240 ) * 0.33;
    beginShape(TRIANGLE_STRIP);
    texture(t);
    float iu=(float)(t.width-1)/(sDetail);
    float iv=(float)(t.height-1)/(sDetail);
    float u=0,v=iv;
    for (int i = 0; i < sDetail; i++) {
      vertex(0, -r, 0,u,0);
      vertex(sphereX[i]*r, sphereY[i]*r, sphereZ[i]*r, u, v);
      u+=iu;
    }
    vertex(0, -r, 0,u,0);
    vertex(sphereX[0]*r, sphereY[0]*r, sphereZ[0]*r, u, v);
    endShape();   
    // Middle rings
    int voff = 0;
    for(int i = 2; i < sDetail; i++) {
      v1=v11=voff;
      voff += sDetail;
      v2=voff;
      u=0;
      beginShape(TRIANGLE_STRIP);
      texture(t);
      for (int j = 0; j < sDetail; j++) {
        vertex(sphereX[v1]*r, sphereY[v1]*r, sphereZ[v1++]*r, u, v);
        vertex(sphereX[v2]*r, sphereY[v2]*r, sphereZ[v2++]*r, u, v+iv);
        u+=iu;
      }
      // Close each ring
      v1=v11;
      v2=voff;
      vertex(sphereX[v1]*r, sphereY[v1]*r, sphereZ[v1]*r, u, v);
      vertex(sphereX[v2]*r, sphereY[v2]*r, sphereZ[v2]*r, u, v+iv);
      endShape();
      v+=iv;
    }
    u=0;
    // Add the northern cap
    beginShape(TRIANGLE_STRIP);
    texture(t);
    for (int i = 0; i < sDetail; i++) {
      v2 = voff + i;
      vertex(sphereX[v2]*r, sphereY[v2]*r, sphereZ[v2]*r, u, v);
      vertex(0, r, 0,u,v+iv);    
      u+=iu;
    }
    vertex(sphereX[voff]*r, sphereY[voff]*r, sphereZ[voff]*r, u, v);
    endShape();
  }

}


