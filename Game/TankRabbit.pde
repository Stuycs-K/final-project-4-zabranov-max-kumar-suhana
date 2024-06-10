public class TankRabbit extends Rabbit{
  TankRabbit(ArrayList<PVector> pathPoints, int wave) {
    super(pathPoints, wave);
    speed = ((12/(-wave - 7)) + 3) * speedmult;
    maxHealth = wave * 20 * healthmult;
    health = maxHealth;
    image = tankrabbitImage;
  }
}
