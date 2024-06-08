class multiTower extends Tower{
  int maxTargets:
  
  Multitower(float x, float y){
    super(x,y);
    maxTargets = 2;
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
      if (maxTaregts < 10.0){
        maxTargets++;
      }
      upgradeCost += 50;
    }
  }
  }


}
