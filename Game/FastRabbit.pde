public class FastRabbit extends Rabbit{
  ArrayList<PVector> pathPoints;
  int currentPointIndex;
  PVector position;
  float speed;
  int health;
  int maxHealth;
  PImage image;

  FastRabbit(ArrayList<PVector> pathPoints, int wave) {
    super(pathPoints, wave);
    this.pathPoints = pathPoints;
    currentPointIndex = 0;
    position = pathPoints.get(currentPointIndex).copy();
    speed = 1 + ((wave + 1) - 1) * 1.3;
    maxHealth = wave * 5;
    health = maxHealth;
    image = fastrabbitImage;
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
    image(image, position.x, position.y, 40, 40);
    fill(0);
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
