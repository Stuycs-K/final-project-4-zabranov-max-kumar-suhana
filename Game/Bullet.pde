class Bullet {
  PVector position;
  Rabbit target;
  float speed = 10;
  boolean hit = false;
  int damage;
  float range;
  PVector origin;

  Bullet(float x, float y, Rabbit target, int damage, float range) {
    origin = new PVector(x, y);
    position = new PVector(x, y);
    this.target = target;
    this.damage = damage;
    this.range = range;
  }
  
  Bullet(float x, float y, Rabbit target, int damage, float range, float speed) {
    origin = new PVector(x, y);
    position = new PVector(x, y);
    this.target = target;
    this.damage = damage;
    this.range = range;
    this.speed = speed;
  }

  void update() {
    if (!hit && target != null) {
      if (speed == 1000) {
        hit = true;
        target.takeDamage(damage);
      }
      else { PVector direction = PVector.sub(target.position, position);
      direction.normalize();
      direction.mult(speed);
      position.add(direction);
      if (position.dist(target.position) < 5) {
        hit = true;
        target.takeDamage(damage);
      }
      else if (position.dist(origin) > range) {
        hit = true;
      }
    }
  }
  }

  void display() {
    fill(#000000);
    rect(position.x, position.y, 10, 5);
  }
}
