class slowTower extends Tower{
  int range;
  float slowDuration;
  float slowAmount;
  
  slowTower(float x, float y){
    super(x, y);
    this.range = 200;
    this.slowDuration = 3.0;
    this.slowAmount = 0.5;
  }

    void update(ArrayList<Rabbit> rabbits) {
    fireCooldown--;
    if (fireCooldown <= 0) {
      for (Rabbit r : rabbits) {
        if (PVector.dist(position, r.position) <= range) {
          fireCooldown = fireRate;
          Bullets.add(new Bullet(position.x, position.y, r, damage));
          r.applySlow(slowAmount, slowDuration);
          break;
        }
      }
    }
  }
  
  void upgrade() {
    if (playerMoney >= upgradeCost) {
      if (count < 5){
      count++;
      playerMoney -= upgradeCost;
      level++;
      fireRate = max(10, fireRate-10);
      if (slowDuration < 10.0){
        slowDuration++;
      }
      upgradeCost += 50;
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
