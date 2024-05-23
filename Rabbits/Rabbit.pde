public class Rabbit {
  private int health
  private double speed;
  private point 
  
  
  public Rabbit(){
    health = 5;
    speed = 5;
    //intended to increase with waves, will switch to var
  }
  
  public void move(){
  }
  
  public void takeDamage(int amount){
    if (health - amount <= 0){
      //rabit removed
    }
    health = health - amount;
    
  }
    
}
