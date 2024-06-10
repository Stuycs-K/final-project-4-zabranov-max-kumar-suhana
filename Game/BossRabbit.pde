public class BossRabbit extends Rabbit{
  BossRabbit(ArrayList<PVector> pathPoints, int wave) {
    super(pathPoints, wave);
    speed = ((12/(-wave - 7)) + 3) * speedmult;
    maxHealth = 5000 * healthmult;
    health = maxHealth;
    image = bossrabbitImage;
  }
  
  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);
    if (flipImage) {
      scale(-1, 1);
    }
    image(image, 0, 0, 120, 120); // Draw the rabbit image
    popMatrix();
    fill(textcolor);
    textSize(16);
    textAlign(CENTER, BOTTOM);
    text(health + "/" + maxHealth, position.x, position.y - 40); 
  }
}
