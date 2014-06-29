

public class Ball extends Mass{
  Point center;
  public final float ENERGY_LOSS_CONSTANT;
  //////////////////////////////////////////////////////////////////////////
  public PImage skin;
  private int sDetail = 60;  // Sphere detail setting
  private float R = 10.5;
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
    setMovable(false);
    setMass(6);
    ENERGY_LOSS_CONSTANT = 1;
    initializeSphere(30);
  }
  public Ball(float x, float y, float z, PImage skin){
    this(x,y,z,skin,0,0,0);
    initializeSphere(30);
  }
  public Ball(){
    this(0, 0, 0, loadImage("14.png"),0,0,0);
  }
  
  public void update(){
    center.addVelocity(0,0,-0.1);
    center.update();
    insertCollisions();
  }
  
  public void renderSurfaces(int r,int g,int b){
    pushMatrix();
    fill(r,g,b);
    noStroke();
    translate(center.getX(),center.getY(),center.getZ());
    sphere(RAD);
    renderGlobe();  
    //ambient(125,125,125);
    //specular(150, 150, 150);
    //shininess(250);
    popMatrix();
  }
  
  
  //Collisions//////////////////////////////////////////////////////////////////////////////
  public void insertCollisions(){
   for(Surface s : surfaces){
     if(distanceTo(s)<=RAD){
       reflect(s);
       //println(s.normal());
//       if(checkIntersection(s)){
//         reflect(s);
//       }
     }
   }
  }
  
  public float distanceTo(Surface s){
    return abs(center.getX()*s.a + center.getY()*s.b + center.getZ()*s.c) / sqrt(sq(s.a) + sq(s.b) + sq(s.c));
  }
  public boolean checkIntersection(Surface s){
    Point intersection = intersect(s);
    return false;
  }
  public Point intersect(Surface s){ //Velocity should never be 0 if gravity is in effect.
    //Turning the vector into a parametric equation- <x + tv1, y + tv2, z + tv3>
    float k1 = s.d - (s.a*center.getX()) - (s.b*center.getY()) - (s.c*center.getZ());
    float k2 = center.velocity().dot(s.a,s.b,s.c);
    float t = k1/k2;
    return new Point(center.getX()+(t*center.velocity().x),center.getY()+(t*center.velocity().y),center.getZ()+(t*center.velocity().z));
  }
  public void reflect(Surface s){
    
  }
  
  /*
  The formula is: 
  r = v - 2(v • n)n 
  
  Where: 
  r is the reflection vector, v is the incident vector, n is the normal vector, and • is the dot product. 
  
  Apparently if you wish to account for the loss of speed during a bounce, then we add the factor of b, where 0 ≤ b ≤ 1. If b = 0, then there is no bounce and if b = 1, then there is no loss of speed: 
  r = b(v - 2(v • n)n)
  */
  
  /////Getters&Setters//////////////////////////////////////////////////////////////////////
  public Point getCenter(){ return center;}
  
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
