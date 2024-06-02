public class Tower {
    int range, damage;
    double fireRate;
    int mouseX, mouseY;
    int x, y;
    
  
    
    public Tower(int range, int damage, double fireRate, int x, int y){
      this.range = range;
      this.damage = damage;
      this.fireRate = fireRate;
      this.x = x;
      this.y = y;
    }
    
    public void shoot(Rabbit target){
      
    }
    
    
    
    public void inButtons(){
      bMenu = new MyButton(int w, int h);
    }
    
    public void mouseClicked(int x, int y){
      this.mouseX = x;
      this.mouseY = y;
     
    }
    
    public void draw(){
    }
    
}
