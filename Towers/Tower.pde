public class Tower {
    int range, damage;
    double fireRate;
    int x, y;
    
  
    
    public void shoot(double target, int range, int damage4, double fireRate, int x, int y){
      this.range = range;
      this.damage = damage4;
      this.fireRate = fireRate;
      this.x = x;
      this.y = y;
    }
    
    public void inButtons(){
      bMenu = new MyButton(int w, int h);
    }
    
    public void mouseClicked(int x, int y){
      
    }
    
    public void draw(){
    }
    
    
    
   
    
    
    
   
}
