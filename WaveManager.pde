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
    }
      
     public void display(){
        noStroke();
        rectMode(CENTER);
        fill(getColor());
        rect(getX(), getY(), getW(), getH());
        textAlign(CENTER, CENTER);
        textSize(width/70);
        fill(#BD054E);
        text("Start Wave", getX(), getY());
        
        if (currentWave == 0 && wave < waveData.length-1) {
          setColor(getOriginalColor());
          if (mouseX <= getX()+getW()/2 && mouseY <= getY()+getH()/2 && mouseX >= getX()-getW()/2 && mouseY >= getY()-getH()/2) {
            setColor(color(red(getOriginalColor())*1.3, green(getOriginalColor())*1.3, blue(getOriginalColor())*1.3));
            if (mousePressed) {
              money += wave*100;
              wave++;
              try {
                currentWave = waveNum[wave].length;
              } catch (Exception e) {
              }
            }
          }
        } 
        else{
          setColor(color(red(getOriginalColor())*1, green(getOriginalColor())*1, blue(getOriginalColor())*1));
        }
      
     
    }
    
    public void update(){
      updateWave();
    }
    
    public void updateWave(){
    if (getCooldown() <= 0 && wave > 0) {
      if (currentWave > 0) {
        setCDTime(waveNum[wave][waveNum[wave].length-currentWave][0]);
        setCooldown(getCDTime());
        liveEntities.add(new Rabbit((int)waveNum[wave][waveNum[wave].length-currentWave][1]));
        currentWave -= 1;
      }
    }
    else {
      setCooldown(getCooldown()-0.0166667); 
    }
  }
    
}
