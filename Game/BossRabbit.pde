public class BossRabbit extends Rabbit{
  BossRabbit(ArrayList<PVector> pathPoints, int wave) {
    super(pathPoints, wave);
    speed = ((12/(-wave - 7)) + 3) * speedmult;
    maxHealth = 5000 * healthmult;
    health = maxHealth * healthmult;
    image = bossrabbitImage;
  }
  
  void display() {
    imageMode(CENTER);
    image(image, position.x, position.y, 120, 120);
    fill(0);
    textSize(16);
    textAlign(CENTER, BOTTOM);
    text(health + "/" + maxHealth, position.x, position.y - 40); 
  }
}
