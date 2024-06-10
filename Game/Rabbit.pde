class Rabbit {
  ArrayList<PVector> pathPoints;
  int currentPointIndex;
  PVector position;
  float speed, slowTimer, ogspeed;
  int health;
  int maxHealth;
  PImage image;
  boolean flipImage;

  Rabbit(ArrayList<PVector> pathPoints, int wave) {
    this.pathPoints = pathPoints;
    currentPointIndex = 0;
    position = pathPoints.get(currentPointIndex).copy();
    speed = 1 + (wave - 1) * 0.2 * speedmult;
    ogspeed = speed;
    maxHealth = wave * 10 * healthmult;
    health = maxHealth;
    image = rabbitImage;
    slowTimer = 0;
    flipImage = false;
  }

  void update() {
    if (slowTimer > 0){
      slowTimer -= 1.0 / frameRate;
      if (slowTimer <= 0){
        speed = ogspeed;
      }
    }
    if (currentPointIndex < pathPoints.size() - 1) {
      PVector target = pathPoints.get(currentPointIndex + 1);
      PVector direction = PVector.sub(target, position);
      if (direction.mag() <= speed) {
        currentPointIndex++;
      } else {
        direction.normalize();
        direction.mult(speed);
        position.add(direction);
        flipImage = (direction.x < 0);
      }
    }
  }
  
 
  
  void applySlow(float slowAmount, float duration){
    speed = speed * (1 - slowAmount);
    slowTimer = duration;
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);
    if (flipImage) {
      scale(-1, 1);
    }
    image(image, 0, 0, 40, 40); 
    popMatrix();
    fill(textcolor);
    textSize(10);
    textAlign(CENTER, BOTTOM);
    text(health + "/" + maxHealth, position.x, position.y - 30);
  }

  void takeDamage(int damage) {
    health -= damage;
  }

  boolean isDead() {
    return health <= 0;
  }

  boolean reachedEnd() {
    return currentPointIndex >= pathPoints.size() - 1;
  }
  int getMaxHealth() {
    return maxHealth;
}
}
