class slowTower extends Tower{
  Tower(float x, float y){
    super;
  }
  
  
  void update(ArrayList<Rabbit> rabbits) {
    fireCooldown--;
    if (fireCooldown <= 0) {
      for (Rabbit r : rabbits) {
        if (PVector.dist(position, r.position) <= range) {
          fireCooldown = fireRate;
          Bullets.add(new Bullet(position.x, position.y, r, damage, 2));
          break;
        }
      }
    }
  }
  
    void display() {
    if (level == 1) {
      fill(50, 100, 200);
    } else if (level == 2) {
      fill(100, 150, 250);
    } else if (level >= 3 && level <=15) {
      fill(150, 200, 300);
    }
    rect(position.x - 10, position.y - 10, 20, 20);
    noFill();
    stroke(0, 0, 255, 50);
    ellipse(position.x, position.y, range * 2, range * 2);
  }
  
  int getUpgradeCost(){
    return upgradeCost;
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
