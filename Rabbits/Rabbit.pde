public class Rabbit {
  private int health, width, height;
  private double x,y;
  private double speed;
  private boolean active;
  private Rectangle bounds;//need class
    
  public Rabbit(double x, double y, int width, int height, double speed, int health){
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.speed = speed;
    this.health = health;
  }
  
  public Rabbit(){
    x = 10;
    y = 10;
    health = 5;
    speed = 5;
    //intended to increase with waves, will switch to var
  }
  
  public double getX(){
    return x;
  }
  public double getY(){
    return y;
  }
  publick Recntangle getBounds(){
    return bounds;
  }
  
  
  
  
  
  
  
  
  
  
  
  public void move(){
  Point temp;
  point(this.x, this.y);
  }

  
  public draw(){
  }
  
  public void takeDamage(int amount){
    if (health - amount <= 0){
      this.active = false;
      //add money
      //rabit removed
    }
    health = health - amount;
    
  }
    
}
