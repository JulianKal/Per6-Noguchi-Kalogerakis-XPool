public class Cloth{
  private Surface surface;
  private ArrayList<Point> points;
  
  public Cloth(){
    points = new ArrayList<Point>();
    initSurface();
    surface.setMovable(false);
  }
  
  public void update(){
    
  }
  
  public void initSurface(){
    points.add(new Point(-420,-220,-RAD));
    points.add(new Point(-420,220,-RAD));
    points.add(new Point(420,220,-RAD));
    points.add(new Point(420,-220,-RAD));
    surface = new Surface(points);
  }
  
  public void renderSurfaces(int r, int g, int b){
    fill(r,g,b);
    beginShape();
    layoutSector(-420,-220,20,PI/2,0);
    layoutSector(0,-220,20,PI,0);
    layoutSector(420,-220,20,PI,PI/2);
    layoutSector(420,220,20,3*PI/2,PI);
    layoutSector(0,220,20,2*PI,PI);
    layoutSector(-420,220,20,2*PI,3*PI/2);
    endShape();
  }
  
  public void layoutSector(float x, float y,float radius, float startAngle, float endAngle){
    for(int i=0;i<=RES;i++){
      float angle = startAngle + ((endAngle-startAngle)*(i/RES));
      vertex(x + radius*cos(angle),y + radius*sin(angle),-RAD);
    }
  }
  
  public Surface getSurface(){ return surface;}
  
}
