public class Tower {
    PVector position;
    float range;
    int damage;
    int fireRate;
    int fireCooldown;
    int level;
    int upgradeCost;
    int upCount;
    int count;
    PImage image;
    boolean flipImage;
    SoundFile shootsound;

  Tower(float x, float y) {
    position = new PVector(x, y);
    range = 100;
    damage = 5;
    fireRate = 60;
    fireCooldown = 0;
    level = 1;
    upgradeCost = 75;
    image = towerImage;
    flipImage = false;
    shootsound = towershoot;
  }

  void update(ArrayList<Rabbit> rabbits) {
    fireCooldown--;
    if (fireCooldown <= 0) {
      for (Rabbit r : rabbits) {
        if (PVector.dist(position, r.position) <= range) {
          fireCooldown = fireRate;
          Bullets.add(new Bullet(position.x, position.y, r, damage, range));
          shootsound.play();
          flipImage = (r.position.x < position.x);
          break;
        }
      }
    }
  }
  
 int getUpgradeCost(){
    return upgradeCost;
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);
    if (flipImage) {
      scale(-1, 1);
    }
    image(image, 0, 0, 60, 40);
    popMatrix();
    if (level == 1) {
      fill(50, 100, 200);
    } else if (level == 2) {
      fill(100, 150, 250);
    } else if (level >= 3 && level <=15) {
      fill(150, 200, 300);
    }
    noFill();
    stroke(0, 0, 255, 50);
    ellipse(position.x, position.y, range * 2, range * 2);
  }

  void upgrade() {
    if (playerMoney >= upgradeCost) {
      if (count < 5){
      count++;
      playerMoney -= upgradeCost;
      level++;
      damage += 5;
      range += 20;
      fireRate = max(10, fireRate - 10);
      upgradeCost += 50;
    }
  }
  }
  
  int upCount(){
    return upCount;
  }
  
  void setUpCount(){
    upCount++;
  }

  boolean isClicked(float mx, float my) {
    return mx > position.x - 10 && mx < position.x + 10 && my > position.y - 10 && my < position.y + 10;
  }
}
