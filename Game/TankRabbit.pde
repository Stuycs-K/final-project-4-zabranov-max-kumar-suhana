public class TankRabbit extends Rabbit{
  TankRabbit(ArrayList<PVector> pathPoints, int wave) {
    super(pathPoints, wave);
    speed = 1 + ((wave + 1) - 1) * .5;
    maxHealth = wave * 20;
    health = maxHealth;
    image = tankrabbitImage;
  }
}
