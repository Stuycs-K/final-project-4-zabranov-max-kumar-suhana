public class Rabbit {
  private int health, x, y, width, height;
  private double speed;
  private boolean active;
    
  public Rabbit(int x, int y, int width, int height, double speed, int health){
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
  
  public void move(){
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
