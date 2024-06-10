class slowTower extends Tower{
  float slowDuration;
  float slowAmount;
  
  slowTower(float x, float y){
    super(x, y);
    this.slowDuration = 3.0;
    this.slowAmount = 0.5;
    damage = 2;
    image = slowImage;
    shootsound = slowshoot;
  }

    void update(ArrayList<Rabbit> rabbits) {
    fireCooldown--;
    if (fireCooldown <= 0) {
      for (Rabbit r : rabbits) {
        if (PVector.dist(position, r.position) <= range) {
          fireCooldown = fireRate;
          Bullets.add(new Bullet(position.x, position.y, r, damage, range, 1000));
          shootsound.play();
          flipImage = (r.position.x < position.x);
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
      upgradeCost += 100;
      range += 5;
      damage += 4;
    }
  }
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
