class Tower {
  PVector position;
  float range;
  int damage;
  int fireRate;
  int fireCooldown;
  int level;
  int upgradeCost;
  private int count;

  Tower(float x, float y) {
    position = new PVector(x, y);
    range = 100;
    damage = 5;
    fireRate = 60; // Frames between shots
    fireCooldown = 0;
    level = 1;
    upgradeCost = 75;
  }

  void update(ArrayList<Rabbit> rabbits) {
    fireCooldown--;
    if (fireCooldown <= 0) {
      for (Rabbit r : rabbits) {
        if (PVector.dist(position, r.position) <= range) {
          fireCooldown = fireRate;
          shots.add(new Shot(position.x, position.y, r, damage));
          break;
        }
      }
    }
  }
  
 int getUpgradeCost(){
    return upgradeCost;
  }

  void display() {
    if (level == 1) {
      fill(50, 100, 200);
    } else if (level == 2) {
      fill(100, 150, 250);
    } else if (level >= 3) {
      fill(150, 200, 300);
    }
    rect(position.x - 10, position.y - 10, 20, 20);
    // Draw range circle
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
      fireRate = max(10, fireRate - 10); // Decrease the fire rate to make it faster
      upgradeCost += 50;
    }
  }
  }

  boolean isClicked(float mx, float my) {
    return mx > position.x - 10 && mx < position.x + 10 && my > position.y - 10 && my < position.y + 10;
  }
}
