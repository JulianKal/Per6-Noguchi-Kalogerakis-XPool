public class Ball{
  private float _x, _y; //Positions of the ball, set using the translate() function.
  private float _vx, _vy; //Delta x and y, for velocity.
  private float _ax, _ay; //The acceleration (rate of change of speed)
  private int colorNum;
  private float _spinx,_spiny,_spinhoriz;
  private float _spinvert;
  private float _spinupdir; //-1 or 1. -1 is clockwise, 1 is counterclockwise. This is the spin that doesn't really affect direction.
  
  public Ball(float x,float y,float vx,float vy){
    this(x,y);
    _vx = vx;
    _vy = vy;
  }
  public Ball(float x, float y){
    _x = x;
    _y = y;
    colorNum = 255;
  }
  public Ball(){
    this(0,0);
  }
  
  public void update(){
    
    insertLowPass();
    _x += _vx;
    _y += _vy;
    println(speed());
    insertSpinEffect();
    insertFriction();
    insertWallCollisions();
    insertBallCollisions();
  }
  
  public void insertSpinEffect(){
    _vx += _spinx;
    _vy += _spiny;
    _spinx-= 0.7 * getSpinMag()*cos(spinHorizAngle());
    _spiny-= 0.7 * getSpinMag()*sin(spinHorizAngle());
    if(abs(_spinx)<0.0001){
      _spinx = 0;
    }
    if(abs(_spiny)<0.0001){
      _spiny = 0;
    }
  }
  public void insertBallCollisions(){
    for(Ball b : p.getBallSet()){
      if(this != b){
        if(distance(b)<0){
          float translatedAngle = convert2PI(absoluteAngle(b) - direction());
          //Rotate such that this ball's direction is 0.
          if(cos(translatedAngle)>0){
            _x += distance(b)*cos(absoluteAngle(b)); //distance is less than 0.
            _y += distance(b)*sin(absoluteAngle(b));
            b.insertForce(speed()*cos(translatedAngle),absoluteAngle(b));
            insertForce(speed()*cos(translatedAngle+PI),absoluteAngle(b));
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
    if(_x<-425 || _x>425){
      _x -= _vx;
      _vx *= -1;
      _ax *= -1;
    }
    if(_y<-225 || _y>225){
      _y -= _vy;
      _vy *= -1;
      _ay *= -1;
    }
  }
  public void insertForce(float velocity, float angle){
    float vx = velocity * cos(angle);
    float vy = velocity * sin(angle);
    _vx += vx;
    _vy += vy;
  }
  public void insertSpinForce(){
  
  }
  
  public void insertSpinXY(float mag, float dir){ //Mag is magnitude, dir is direction.
    _spinx += mag * sin(dir);
    _spiny += mag * cos(dir);
    
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
  public float spinHorizAngle(){
    return angle(_spinx,_spiny);
  }
  public float absoluteAngle(Ball b){ //Angle between two balls
    float dy = b.getY() - _y;
    float dx = b.getX() - _x;
    return angle(dx, dy);
  }
  
  public float distance(Ball b){
    return sqrt(sq(_x-b.getX()) + sq(_y-b.getY()))-2*RAD;
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
  public void setColor(int c){colorNum = c;}
  public int getColor(){ return colorNum;}
}
