public class Tower {
    PVector position;
    float range;
    int damage;
    int fireRate;
    int fireCooldown;
    int level;
    int upgradeCost;

    Tower(int range, int damage, double fireRate, int x, int y){
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
