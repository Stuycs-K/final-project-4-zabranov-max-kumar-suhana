public class WaveManager {
    private int currentWave, money;
    private int wave = 0;
    private float [][][] waveNum;
    private color col, C;
    private float x,y,targetX, targetY, w, h, cool, CDTime; 
    private boolean live;
    //ArrayList<Rabbit> enemyTypes = new ArrayList<Rabbit>();
    
   public WaveManager(){
      this.x = (width/100*72);
      this.y = (width/64);
      this.w = (width/13);
      this.h = (width/32);
      this.col = (color(204, 104, 46));
      this.CDTime= 0.85;
      this.cool = 1;
      this.live = true;
      this.currentWave = 0;
      this.waveNum = new float[21][int(random(20,60))][2];
      for (int W = 1; W < waveNum.length; W++){
        for (int E = 0; E < waveNum[W].length; E++){
          waveNum[W][E][0] = random(0.7-log(W)/4,0.9);
          waveNum[W][E][1] = int(random(floor(W*0.7)+1, W + 1));
        }
      }
    }
      
     public void display(){
        noStroke();
        rectMode(CENTER);
        fill(col);
        rect(x, y, w, h);
        textAlign(CENTER, CENTER);
        textSize(width/70);
        fill(#BD054E);
        text("Start Wave", x, y);
        
        if (currentWave == 0 && wave < waveNum.length-1) {
          col = C;
          if (mouseX <= x+w/2 && mouseY <= y+h/2 && mouseX >= x-w/2 && mouseY >= y-h/2) {
            col = color(red(C)*1.3, green(C)*1.3, blue(C)*1.3);
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
          col = color(red(C)*1, green(C)*1, blue(C)*1);
        }
      
     
    }
    
    public void update(){
      updateWave();
    }
    
    public int getMoney(){
      return money;
    }
    
    public void updateWave(){
    if (this.cool <= 0 && wave > 0) {
      if (currentWave > 0) {
        CDTime = waveNum[wave][waveNum[wave].length-currentWave][0];
        cool = CDTime;
        liveEntities.add(new Rabbit((int)waveNum[wave][waveNum[wave].length-currentWave][1]));
        currentWave -= 1;
      }
    }
    else {
      cool = cool - 0.0166667;
    }
  }
    
}
