public class TankRabbit extends Rabbit {
  private double armorprot;
  private int health;
  
  public TankRabbit(){
    super;
  }
  
  public void takeDamage(int amount){
    if (health - amount <= 0){
      //rabit removed
    }
    health = health - amount;
    
  }
  
 
    
}
}
