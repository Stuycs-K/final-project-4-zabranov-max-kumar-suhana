public class WaveManager {
    private int currentWave;
    private double[][] waveNum;
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
      this.currentWave = 0;
      this.waveNum = new double[21][int((Math.random * 40) + 20)] [2];
      for (int W = 1; W < waveNum.length; W++){
        for (int E = 0; E < waveNum[W].length; E++){
          waveNum[W][E][0] = random(0.7-log(wave)/4,0.9);
          waveNum[W][E][1] = int(random(floor(wave*0.7)+1, wave + 1));
        }
      }
      
      void display(){
      
      
     
    }
    
}
