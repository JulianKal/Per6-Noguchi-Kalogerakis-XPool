

public class Surface extends Collidable{
  //Equation constants- ax + by + cz = d
  public float a, b, c, d;
  PVector normal;
  
  ArrayList<Segment> segments;
  
  public Surface(ArrayList<Point> points){
    this.points = points;
    segments = new ArrayList<Segment>();
    for(int x=1;x<points.size();x++){
      segments.add(new Segment(points.get(x-1),points.get(x)));
    }
    segments.add(new Segment(points.get(0),points.get(points.size()-1)));//Segment between first and last.
    calculateEquation(); //Only needs to be calculated once.
//    println("constants: "+a+" "+b+" "+c+" "+d);
  }
  
  public void update(){
    for(Point p : points){
      p.update();
    }
    
  }
  
  public void renderSurfaces(int r,int g,int b){
    pushMatrix();
    fill(200,0,0);
    beginShape();
    for(Point p : points){
      p.placeVertex();
    }
    endShape();
    popMatrix();
  }
  
  public void calculateEquation(){
    calculateNormal();
    d = normal.dot(points.get(1).getX(),points.get(1).getY(),points.get(1).getZ());
    a = normal.x;
    b = normal.y;
    c = normal.z;
  }
  public void calculateNormal(){
    PVector p1 = points.get(2).vectorTo(points.get(0));
    PVector p2 = points.get(3).vectorTo(points.get(1));
    normal = p1.cross(p2);
  }
  public float distance(Point p){
    return abs(p.getX()*a + p.getY()*b + p.getZ()*c - d) / sqrt(sq(a)+sq(b)+sq(c));    
  }
  public Point normalPoint(Point p){
    Point o = points.get(0);
    PVector unitNormal = PVector.mult(normal, 1/normal.mag());
    PVector offset = PVector.mult(unitNormal,-1*unitNormal.dot(o.vectorTo(p)));
    return new Point(PVector.add(p.getPVector(),offset));
  }
  public boolean pointOnSurface(Point p){
    //First check if the point is on the plane
    if(abs((a*p.getX()+b*p.getY()+c*p.getZ()) - d) > 0.1){
      return false;
    }
    //Ray casting method! Shoot a ray from the point in any direction.
    //If the ray intersects an even number of sides, then the point is within the poly.
    Point spare = new Point();
    if(a!=0){
      spare = new Point((d-(b*(p.getY()+1)))/a,p.getY()+1,0);
    }else if(b!=0){
      spare = new Point(p.getX()+1,(d-(a*(p.getX()+1)))/b,0);
    }else if(c!=0){
      spare = new Point(0,p.getX()+1,(d-(b*(p.getY()+1)))/c);
    }else{
      println("Genji doesn't do cs the right way.");
    }
    int intersections = 0;
    for(int x=1;x<points.size();x++){
      if(intersect(p,spare,points.get(x-1),points.get(x))){
        intersections++;
      }
    }
    if(intersect(p,spare,points.get(0),points.get(points.size()-1))){
      intersections++;
    }
    if(intersections % 2==1){
      return true;
    }
    return false;
  }
  public boolean intersect(Point p1, Point p2, Point p3, Point p4){
    //Find out if the ray from p1 to p2 intersects with the line segment from p3 to p4
    //p1 is the center.
//    (a1,b1,c1) + t1(d1+e1+f1) -> ray
//    (a2,b2,c2) + t2(d2+e2+f2) -> segment
    float a1 = p1.getX(), b1 = p1.getY(), c1 = p1.getZ();
    float d1 = p2.getX()-a1, e1 = p2.getY()-b1, f1 = p2.getZ()-c1;
    
    float a2 = p3.getX(), b2 = p3.getY(), c2 = p3.getZ();
    float d2 = p4.getX()-a2, e2 = p4.getY()-b2, f2 = p4.getZ()-c2;
    
    float t2=0,t1=0;
    
    boolean finished = false;
    if(!finished){
      // Using x and y parametric equations to solve for the t's.
      if(e1!=0 && d2-(d1*e2/e1)!=0){ //Original formula.
        t2 = longFormula(a1,a2,b2,d1,e1,b1,e2,d2);
        t1 = shortFormula(b2,b1,t2,e2,e1);
        finished = true;
      }else if(e2!=0 && d1-(d2*e1/e2)!=0){ // Original formula, but with swapped 1's and 2's.
        t1 = longFormula(a2,a1,b1,d2,e2,b2,e1,d1);
        t2 = shortFormula(b1,b2,t1,e1,e2);
        finished = true;
      }else if(d1!=0 && e2-(e1*d2/d1)!=0){ //Original formula, but solved for the opposite variable.
        t2 = longFormula(b1,b2,a2,e1,d1,a1,d2,e2);
        t1 = shortFormula(a2,a1,t2,d2,d1);
        finished = true;
      }else if(d2!=0 && e1-(e2*d1/d2)!=0){ //The previous equation with swapped 1's and 2's
        t1 = longFormula(b2,b1,a1,e2,d2,a2,d1,e1);
        t1 = shortFormula(a1,a2,t1,d1,d2);
        finished = true;
      }
      if(finished){
        if(abs((c1 + (t1*f1))-(c2 + (t2*f2))) > 0.1){ //Check if the z's intersect.
          return false;
        }
      }
    }
    if(!finished){
      // Using x and z
      if(f1!=0 && d2-(d1*f2/f1)!=0){ //Original formula.
        t2 = longFormula(a1,a2,c2,d1,f1,c1,f2,d2);
        t1 = shortFormula(c2,c1,t2,f2,f1);
        finished = true;
      }else if(f2!=0 && d1-(d2*f1/f2)!=0){ // Original formula, but with swapped 1's and 2's.
        t1 = longFormula(a2,a1,c1,d2,f2,c2,f1,d1);
        t2 = shortFormula(c1,c2,t1,f1,f2);
        finished = true;
      }else if(d1!=0 && f2-(f1*d2/d1)!=0){ //Original formula, but solved for the opposite variable.
        t2 = longFormula(c1,c2,a2,f1,d1,a1,d2,f2);
        t1 = shortFormula(a2,a1,t2,d2,d1);
        finished = true;
      }else if(d2!=0 && f1-(f2*d1/d2)!=0){ //Original formula, but solved for the opposite variable.
        t1 = longFormula(c2,c1,a1,f2,d2,a2,d1,f1);
        t2 = shortFormula(a1,a2,t1,d1,d2);
        finished = true;
      }
      if(finished){
        if(abs((b1 + (t1*e1))-(b2 + (t2*e2))) > 0.1){ //Check if the z's intersect.
          return false;
        }
      }
    }
    
    if(!finished){
      // Using y and z
      if(f1!=0 && e2-(e1*f2/f1)!=0){ //Original formula.
        t2 = longFormula(b1,b2,c2,e1,f1,c1,f2,e2);
        t1 = shortFormula(c2,c1,t2,f2,f1);
        finished = true;
      }else if(f2!=0 && e1-(e2*f1/f2)!=0){ // Original formula, but with swapped 1's and 2's.
        t1 = longFormula(b2,b1,c1,e2,f2,c2,f1,e1);
        t2 = shortFormula(c1,c2,t1,f1,f2);
        finished = true;
      }else if(e1!=0 && f2-(f1*e2/e1)!=0){ //Original formula, but solved for the opposite variable.
        t2 = longFormula(c1,c2,b2,f1,d1,b1,e2,f2);
        t1 = shortFormula(b2,b1,t2,e2,e1);
        finished = true;
      }else if(e2!=0 && f1-(f2*e1/e2)!=0){ //Original formula, but solved for the opposite variable.
        t1 = longFormula(c2,c1,b1,f2,d2,b2,d1,f1);
        t1 = shortFormula(b1,b2,t1,d1,d2);
        finished = true;
      }
      if(finished){
        if(abs((a1 + (t1*d1))-(a2 + (t2*d2))) > 0.1){ //Check if the z's intersect.
          return false;
        }
      }
    }
    //println(""+a1+" "+b1+" "+c1+" "+t1+" "+d1+" "+e1+" "+f1+"      "+a2+" "+b2+" "+c2+" "+t2+" "+d2+" "+e2+" "+f2+" ");
 
    if(t1<0){ //The intersection is not on the ray.
      return false;
    }
    if(t2>1 || t2<0){ //The intersection is not between the two points.
      return false;
    }
    return true;
  }
  //Intersection helper formulas
  public float shortFormula(float c1,float c2,float c3,float c4,float c5){
    //(b2 - b1 + (t2*e2)) / e1
    return (c1-c2+(c3*c4)) / c5;
  }
  public float longFormula(float c1,float c2,float c3,float c4,float c5,float c6,float c7,float c8){
    //(a1 - a2 + (b2*d1/e1) - (b1*d1/e1) + (d1*e2/e1)) / (d2 - (d1*e2/e1))
    return (c1-c2+(c3*c4/c5) - (c6*c4/c5) + (c4*c7/c5)) / (c8 - (c4*c7/c5));
  }
  
  public PVector normal(){
    return normal;
  }
  
  public ArrayList<Segment> getSegments(){ return segments;}
  
}
