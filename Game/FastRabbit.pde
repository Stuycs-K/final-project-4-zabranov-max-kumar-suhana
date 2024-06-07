public class FastRabbit extends Rabbit{
  FastRabbit(ArrayList<PVector> pathPoints, int wave) {
    super(pathPoints, wave);
    speed = (12/(-wave - 3)) + 5;
    maxHealth = wave * 5;
    health = maxHealth;
    image = fastrabbitImage;
  }
}
