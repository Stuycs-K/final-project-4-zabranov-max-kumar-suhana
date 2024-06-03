class Rabbit {
  ArrayList<PVector> pathPoints;
  int currentPointIndex;
  PVector position;
  float speed;
  int health;
  int maxHealth;
  PImage image;

  Rabbit(ArrayList<PVector> pathPoints, int wave) {
    this.pathPoints = pathPoints;
    currentPointIndex = 0;
    position = pathPoints.get(currentPointIndex).copy();
    speed = 1 + (wave - 1) * 0.2; // Increase speed with each wave
    maxHealth = wave * 10;
    health = maxHealth;
    image = rabbitImage;// Assign the loaded image
  }

  void update() {
    if (currentPointIndex < pathPoints.size() - 1) {
      PVector target = pathPoints.get(currentPointIndex + 1);
      PVector direction = PVector.sub(target, position);
      if (direction.mag() <= speed) {
        currentPointIndex++;
      } else {
        direction.normalize();
        direction.mult(speed);
        position.add(direction);
      }
    }
  }

  void display() {
    imageMode(CENTER);
    image(image, position.x, position.y, 40, 40); // Draw the rabbit image
    fill(0);
    textSize(12);
    textAlign(CENTER, BOTTOM);
    text(health + "/" + maxHealth, position.x, position.y - 30); // Display health above the rabbit
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