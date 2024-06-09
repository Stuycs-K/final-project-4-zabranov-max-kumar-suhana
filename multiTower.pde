class multiTower extends Tower{
  int range;
  int maxTargets;
  
  multiTower(float x, float y){
    super(x, y);
    this.range = 200;
    this.maxTargets = 2;
  }
  
   void update(ArrayList<Rabbit> rabbits) {
    fireCooldown--;
    if (fireCooldown <= 0) {
      int targets =0;
      for (Rabbit r : rabbits) {
        if (PVector.dist(position, r.position) <= range) {
          fireCooldown = fireRate;
          Bullets.add(new Bullet(position.x, position.y, r, damage));
          targets++;
          if (targets >= maxTargets){
            break;            
          }
        }
      }
    }
  }
  
    void upgrade() {
    if (playerMoney >= upgradeCost) {
      if (count < 3){
      count++;
      playerMoney -= upgradeCost;
      level++;
      fireRate = max(10, fireRate-10);
      if (maxTargets < 10.0){
        maxTargets++;
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
  
  
  


}
