class Bullet {
  PVector position;
  Rabbit target;
  float speed = 10;
  boolean hit = false;
  int damage;

  Bullet(float x, float y, Rabbit target, int damage) {
    position = new PVector(x, y);
    this.target = target;
    this.damage = damage;
  }

  void update() {
    if (!hit && target != null) {
      PVector direction = PVector.sub(target.position, position);
      direction.normalize();
      direction.mult(speed);
      position.add(direction);
      if (position.dist(target.position) < 5) {
        hit = true;
        target.takeDamage(damage);
      }
    }
  }

  void display() {
    fill(#000000);
    rect(position.x, position.y, 10, 5);
  }
}
