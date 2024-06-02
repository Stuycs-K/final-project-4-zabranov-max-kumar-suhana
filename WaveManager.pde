public class WaveManager {
    private int currentWave;
    private double 
    ArrayList<Rabbit> enemyTypes = new ArrayList<Rabbit>();
    
    public WaveManager(){
      setX(width/100*72);
      setY(width/64);
      setW(width/13);
      setH(width/32);
      setColor(color(204, 104, 46));
      setOriginalColor(getColor());
      setCDTime(0.85);
      setCooldown(1);
      setLive(true);
    }
    
}
