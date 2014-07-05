

public class Ball extends Mass{
  Point center;
  public final float ENERGY_LOSS_CONSTANT;
  private String name;
  //////////////////////////////////////////////////////////////////////////
  public PImage skin;
  private int sDetail = 60;  // Sphere detail setting
  private float R = RAD;
  private float[] cx, cz, sphereX, sphereY, sphereZ;
  private float sinLUT[];
  private float cosLUT[];
  private float SINCOS_PRECISION = 0.5;
  private int SINCOS_LENGTH = int(360.0 / SINCOS_PRECISION);
  //////////////////////////////////////////////////////////////////////////
  
  
  public Ball(float x,float y, float z, PImage skin, float vx,float vy,float vz){
    this.skin = skin;
    center = new Point(x,y,z,vx,vy,vz);
    points = new ArrayList<Point>();
    points.add(center);
    setMovable(true);
    setMass(6);
    ENERGY_LOSS_CONSTANT = 1;
  }
  public Ball(float x, float y, float z, PImage skin){
    this(x,y,z,skin,0,0,0);
  }
  public Ball(float x,float y, float z, PImage skin, float vx,float vy,float vz, String name){
    this.skin = skin;
    center = new Point(x,y,z,vx,vy,vz,name);
    points = new ArrayList<Point>();
    points.add(center);
    setMovable(true);
    setMass(6);
    ENERGY_LOSS_CONSTANT = 1;
    this.name = name;
  }
  public Ball(){
    this(0, 0, 0, loadImage("14.png"),0,0,0);
  }
  
  public void update(){
    insertCollisions();
  }
  
  public void renderSurfaces(int r,int g,int b){
    pushMatrix();
    fill(r,g,b);
    noStroke();
    translate(center.getX(),center.getY(),center.getZ());
    sphere(R);
    //renderGlobe();
    popMatrix();
  }
  
  
  //Collisions//////////////////////////////////////////////////////////////////////////////
  public void insertCollisions(){
    boolean collided = false;
    for(Segment seg : world.getSegments()){
      if(!collided){
        Point norm =  seg.normalPoint(center);
        if(center.distance(norm) <= R){
           reflect(norm.vectorTo(center));
           collided = true;
        }
      }
    }
    for(Surface s : world.getSurfaces()){
      if(s.distance(center) <= R){
        if(s.pointOnSurface(s.normalPoint(center))){
          reflect(s.normal());
        }
      }
    }
    for(Ball b : world.getBalls()){
      if(this != b ){ //Make sure they're not the same instance.
        if(center.distanceSq(b.getCenter()) < 4*sq(R) && abs(center.velocity().mag()) > 0){
          reflect(b);
        }
      }
    }
  }
  
  public void reflect(PVector normalVector){
    PVector normal = normalVector;
    PVector velocity = center.velocity();
    PVector projection = PVector.mult(normal,normal.dot(velocity)/normal.magSq());
    
    center.setVelocity(PVector.add(velocity, PVector.mult(projection,-2)));
  }
  public void reflect(Ball b){
    println(getName() + ".reflect(" + b.getName() + "){");
    //println(center);
    //println(center.velocity());
    //First check if this ball's velocity is actually going to cause it to hit into b
    //Use the normalPoint formula from Segment-- if t is negative, then ignore the case.
//    PVector starting = center.getPVector();
//    PVector direction = center.velocity();
//    float t = direction.dot(PVector.sub(b.getCenter().getPVector(),direction)) / (direction.dot(direction));
//    println(t);
//    if(t>=0){
//      println("hello");
      //Next, use the projection of the velocity onto the vector from center to b.center.
      PVector d = center.vectorTo(b.getCenter());
      PVector projection = PVector.mult(d,center.velocity().dot(d)/sq(d.mag()));
      println("   " + getName() + ".applyEnergy(" + b.getName() + ", " + projection + ")");
      applyEnergy(b, projection);
//    }
  println("}");
  }
  public void correctDistance(float d, Surface s){
    //After a collision with something, it corrects the distance so that no multiple fallacious collisions are detected.
    //D should be a negative number.
    PVector unit = PVector.mult(s.normal(),1/s.normal().mag());
    unit.mult(d);
    center.setX(center.getX()+unit.x);
    center.setY(center.getY()+unit.y);
    center.setZ(center.getZ()+unit.z);
  }
  
  /*
  The formula is:
  r = v - 2(v • n)n
 
 The better formula is
  r = - ( -v + 2 * proj(v)(n))
  r = -( -v + 2(v.dot(n))/mag(n)^2*n
  
  Where: 
  r is the reflection vector, v is the incident vector, n is the normal vector, and • is the dot product. 
  
  Apparently if you wish to account for the loss of speed during a bounce, then we add the factor of b, where 0 ≤ b ≤ 1. If b = 0, then there is no bounce and if b = 1, then there is no loss of speed: 
  r = b(v - 2(v • n)n)
  */
  
  /////Getters&Setters//////////////////////////////////////////////////////////////////////
  public Point getCenter(){ return center;}
  public String getName(){return name;}
  
  /////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////DO NOT ENTER///////////////////////////////////////////
  ///////////////////////////////BALL RENDERING CODE///////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////  
  
  
  
  public void renderGlobe() {
    pushMatrix();
    //strokeWeight(0.25);
    smooth();
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
