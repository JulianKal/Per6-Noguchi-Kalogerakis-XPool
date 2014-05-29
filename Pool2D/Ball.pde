public class Ball{
  private float _x, _y; //Positions of the ball, set using the translate() function.
  private float _vx, _vy; //Delta x and y, for velocity.
  private float _ax, _ay; //The acceleration (rate of change of speed)
  private float FRICTION;
  private int colorNum;
  
  public Ball(float x,float y,float vx,float vy){
    this(x,y);
    _vx = vx;
    _vy = vy;
  }
  public Ball(float x, float y){
    _x = x;
    _y = y;
    FRICTION = -0.2;
    colorNum = 255;
  }
  public Ball(){
    this(0,0);
  }
  
  public void update(){
    insertLowPass();
    _x += _vx;
    _y += _vy;
    
    insertFriction();
    insertWallCollisions();
    
    //Ball to ball collisions
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
          println("CONTACT123223323");
        }
      }
    }
  }
  
  public void insertLowPass(){ //Simple low pass filter for any float calculation errors.
    if(abs(_vx)<0.5){
      _vx=0;
    }
    if(abs(_vy)<1){
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
  public float absoluteAngle(Ball b){ //Angle between two balls
    float dy = b.getY() - _y;
    float dx = b.getX() - _x;
    return angle(dx, dy);
  }
  
  public float distance(Ball b){
    return sqrt(sq(_x-b.getX()) + sq(_y-b.getY()))-50;
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
  public void setXAcc(float x){_ax = x;}
  public void setYAcc(float y){_ay = y;}
  public float getXAcc(){return _ax;}
  public float getYAcc(){return _ay;}
  public float speed(){return sqrt(sq(_vx)+sq(_vy));}
  public float kinetic(){return 0.5 + sq(speed());}
  public void setColor(int c){colorNum = c;}
  public int getColor(){ return colorNum;}
}
