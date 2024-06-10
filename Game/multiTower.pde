class multiTower extends Tower{
  int range;
  int maxTargets;
  
  multiTower(float x, float y){
    super(x, y);
    this.range = 200;
    this.maxTargets = 2;
    upgradeCost = 150;
    image = multiImage;
    shootsound = multishoot;
  }
  
   void update(ArrayList<Rabbit> rabbits) {
    fireCooldown--;
    if (fireCooldown <= 0) {
      int targets =0;
      for (Rabbit r : rabbits) {
        if (PVector.dist(position, r.position) <= range) {
          fireCooldown = fireRate;
          Bullets.add(new Bullet(position.x, position.y, r, damage, range));
          shootsound.play();
          flipImage = (r.position.x < position.x);
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
      upgradeCost += 200;
      damage += 15;
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
  
  
  


}
