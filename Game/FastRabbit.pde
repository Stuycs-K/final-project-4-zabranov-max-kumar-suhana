public class FastRabbit extends Rabbit{
  FastRabbit(ArrayList<PVector> pathPoints, int wave) {
    super(pathPoints, wave);
    speed = 1 + ((wave + 1) - 1) * 1.3;
    maxHealth = wave * 5;
    health = maxHealth;
    image = fastrabbitImage;
  }
}
