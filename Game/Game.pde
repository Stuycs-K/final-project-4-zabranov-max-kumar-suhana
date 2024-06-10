import processing.sound.*;
ArrayList<Rabbit> rabbits;
ArrayList<Tower> towers;
ArrayList<slowTower> sTowers;
ArrayList<multiTower> mTowers;
ArrayList<Bullet> Bullets;
int wave = 1;
int radi =1;
int spawnInterval = 60;
int spawnTimer = 0;
int rabbitsTBulletoSpawn;
int rabbitsSpawned = 0;
int rabbitsToSpawn;
int playerHealth = 100;
int playerMoney = 100;
PVector startPoint;
PVector endPoint;
boolean placingTower = false;
boolean placingMTower = false;
boolean placingSTower = false;
boolean upgradingTower = false;
boolean upgradingSTower = false;
boolean upgradingMTower = false;
slowTower tempSTower;
slowTower selectedSTower;
multiTower tempMTower;
multiTower selectedMTower;
boolean gameStarted = false;
Tower tempTower;
Tower selectedTower;
PImage coins;
PImage heart;
PImage waveI;
ArrayList<PVector> pathPoints;
PImage rabbitImage;
PImage fastrabbitImage;
PImage tankrabbitImage;
PImage bossrabbitImage;
PImage towerImage;
PImage slowImage;
PImage multiImage;
PImage currentbg;
PImage menu;
PImage map1;
PImage map2;
PImage map3;
color pathcolor;
color textcolor;
float speedmult;
int healthmult;
int maxwave;
int moneymult;
SoundFile music1;
SoundFile music2;
SoundFile music3;
SoundFile currmusic;
SoundFile towershoot;
SoundFile slowshoot;
SoundFile multishoot;

void setup() {
  size(1180, 800);
  music1 = new SoundFile(this, "easy.mp3");
  music2 = new SoundFile(this, "medium.mp3");
  music3 = new SoundFile(this, "hard.mp3");
  towershoot = new SoundFile(this, "shootsound.mp3");
  slowshoot = new SoundFile(this, "slowsound.mp3");
  multishoot = new SoundFile(this, "multisound.mp3");
  menu = loadImage("summer.png");
  map1 = loadImage("grass.jpg");
  map2 = loadImage("sand.jpg");
  map3 = loadImage("lava.jpg");
  rabbits = new ArrayList<Rabbit>();
  towers = new ArrayList<Tower>();
  sTowers = new ArrayList<slowTower>();
  mTowers = new ArrayList<multiTower>();
  Bullets = new ArrayList<Bullet>();
  coins = loadImage("coin.png");
  heart = loadImage("heart.png");
  waveI = loadImage("waveI.png");
  rabbitsToSpawn = 10; 
  rabbitImage = loadImage("rabbitpic.png"); 
  fastrabbitImage = loadImage("fastrabbit.png");
  tankrabbitImage = loadImage("tankrabbit.png");
  bossrabbitImage = loadImage("Lepus.png");
  towerImage = loadImage("tower.png");
  slowImage = loadImage("slowpic.png");
  multiImage = loadImage("multipic.png");
  pathPoints = new ArrayList<PVector>();
}

void draw() {
  if (!gameStarted) {
    PFont f = createFont("Lucida Sans", 12);
    textFont(f);
    background(menu);
    fill(#8C8C8C);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Map Select", width / 2, 50);
    
    fill(#49DD1E);
    rect(width / 2 - 200, 150, 400, 100);
    fill(#5E88FF);
    rect(width / 2 - 200, 300, 400, 100);
    fill(#C41C23);
    rect(width / 2 - 200, 450, 400, 100);
    
    fill(#1C4B1F);
    text("Grassy Meadows", width / 2, 200);
    fill(#F5F115);
    text("Sandy Shores", width / 2, 350);
    fill(#000000);
    text("Lava Lake", width / 2, 500);
    
    fill(#14FF00);
    text("EASY", 1000, 200);
    fill(#FFFE01);
    text("MEDIUM", 1000, 350);
    fill(#FF0101);
    text("HARD", 1000, 500);
  }
  else {
  background(currentbg);
  if (!currmusic.isPlaying()) { currmusic.play(); currmusic.amp(0.05); }
  stroke(pathcolor); 
  strokeWeight(40); 
  noFill();
  beginShape();
  for (PVector point : pathPoints) {
    vertex(point.x, point.y);
  }
  endShape();
  noStroke();
  strokeWeight(4);



  fill(color(144, 224,255));
  rect(808, 20, 360, 760);
  fill(0);
  PFont mono;
  mono = createFont("RaceSport.ttf", 14);
  textFont(mono);
  image(heart, 830, 50, 30, 30);
  text("Health: " + playerHealth, 910, 55);
  image(coins, 830, 100, 30, 30);
  text("Money: " + playerMoney, 910, 102);
  image(waveI, 830, 150, 50, 50);
  text("Wave: " + wave, 890, 149);
  fill(0);
  rect(width/1.265, width/1.315, 160, 30);
  fill(0);
  if (mouseX >= 400 && mouseX <= 550 &&
      mouseY >= 560 && mouseY <= 590) {
        fill(color(1,147,189));
      }
  mono = createFont("RaceSport.ttf", 20);
  textFont(mono);
  text("MENU:", 985, 210);
  mono = createFont("RaceSport.ttf", 10);
  textFont(mono);
  fill(255);
  rect(818, 250, 340, 90);
  fill(0);
  text("Click to Place Tower,  Cost: 75", 940, 300);
  fill(255);
  image(towerImage, 1100, 300, 80, 80);
  rect(818, 350, 340, 90);
  fill(0);
  text("Click to Place Slow Tower,   Cost: 75", 960, 400);
  fill(255);
  image(slowImage, 1115, 400, 60, 60);
  rect(818, 450, 340, 90);
  fill(0);
  text("Click to Place Multi Tower,   Cost: 100", 960 , 500);
  fill(255);
  image(multiImage, 1120, 500, 60, 60);
  rect(828, 700, 150, 50);
  fill(0);
  textSize(14);
  text("Restart", 905 , 730);
  fill(255);
  rect(1000, 700, 150, 50);
  fill(0);
  textSize(14);
  text("Maps", 1070 , 730);


  if (rabbitsSpawned < rabbitsToSpawn) {
    int random = (int) (Math.random() * 11);
    spawnTimer++;
    if (rabbitsSpawned == rabbitsToSpawn - 1 && wave == maxwave) {
      if (spawnTimer >= spawnInterval) {
      rabbits.add(new BossRabbit(pathPoints, wave));
      rabbitsSpawned++;
      spawnTimer = 0;
    }
    }
    else if (wave >= (-speedmult + 7) && wave < (-speedmult + 9)){
    if (spawnTimer >= spawnInterval) {
      if (random <= 7) {
        rabbits.add(new Rabbit(pathPoints, wave));
        rabbitsSpawned++;
        spawnTimer = 0;
      }
      else {
        rabbits.add(new FastRabbit(pathPoints, wave));
        rabbitsSpawned++;
        spawnTimer = 0;
    }
  }
    }
    else if (wave >= (-speedmult + 9)) {
    if (spawnTimer >= spawnInterval) {
      if (random <= 3) {
        rabbits.add(new Rabbit(pathPoints, wave));
        rabbitsSpawned++;
        spawnTimer = 0;
      }
      else if (random <= 7){
        rabbits.add(new FastRabbit(pathPoints, wave));
        rabbitsSpawned++;
        spawnTimer = 0;
    }
      else {
        rabbits.add(new TankRabbit(pathPoints, wave));
        rabbitsSpawned++;
        spawnTimer = 0;
  }
    }
  }
  else {
    if (spawnTimer >= spawnInterval) {
    rabbits.add(new Rabbit(pathPoints, wave));
    rabbitsSpawned++;
    spawnTimer = 0;
  }
  }
  }

  for (int i = rabbits.size() - 1; i >= 0; i--) {
    Rabbit r = rabbits.get(i);
    r.update();
    r.display();
    if (r.isDead()) {
      playerMoney += ((1100/(-(rabbits.get(i).getMaxHealth()) - 62)) + 20) * moneymult; 
      rabbits.remove(i);
    } else if (r.reachedEnd()) {
      playerHealth -= 10; 
      rabbits.remove(i);
      if (playerHealth <= 0) {
        gameOver();
      }
    }
  }

  for (Tower t : towers) {
    t.update(rabbits);
    t.display();
  }
  
  for (slowTower t : sTowers){
    t.update(rabbits);
    t.display();
  }
  
  for (multiTower t : mTowers){
    t.update(rabbits);
    t.display();
  }

  for (int i = Bullets.size() - 1; i >= 0; i--) {
    Bullet s = Bullets.get(i);
    s.update();
    s.display();
    if (s.hit) {
      Bullets.remove(i);
    }
  }

  if (placingTower) {
    tempTower.position.set(mouseX, mouseY);
    tempTower.display();
  }
  
  if (placingSTower) {
    tempSTower.position.set(mouseX, mouseY);
    tempSTower.display();
  }
  
  if (placingMTower) {
    tempMTower.position.set(mouseX, mouseY);
    tempMTower.display();
  }

  if (wave > maxwave) {
      fill(0);
       textSize(32);
       textAlign(CENTER, CENTER);
       text("You Win!", width / 2, height / 2);
       noLoop();
    }
  if (rabbits.size() == 0 && rabbitsSpawned >= rabbitsToSpawn) {
    if (wave == 0) {}
    else if (wave < maxwave){
    wave++;
    playerMoney += (100/(-wave - 12) + 20) * moneymult;
    rabbitsToSpawn = 10 + wave * 2; 
    rabbitsSpawned = 0;
    println("Wave " + wave);
    }
    else{
       fill(0);
       textSize(32);
       textAlign(CENTER, CENTER);
       text("You Win!", width / 2, height / 2);
       noLoop();
    }
   
  }

  if (upgradingTower && selectedTower != null) {
    if (selectedTower.upCount() < 5){
      fill(0, 0, 0, 150);
      rect(width / 2 - 110, height / 2 - 50, 220, 100);
      fill(255);
      rect(width / 2 - 105, height / 2 - 45, 210, 90);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(14);
      text("Upgrade Tower", width / 2, height / 2 - 30);
      textSize(12);
      text("Damage: " + selectedTower.damage, width / 2, height / 2 - 10);
      text("Range: " + selectedTower.range, width / 2, height / 2 + 10);
      textSize(10);
      text("Attack Speed: " + (60.0 / selectedTower.fireRate) + " Bullets/sec", width / 2, height / 2 + 30);
      fill(0, 150, 0);
      fill(0);
      textSize(20);
      text("Press 'SPACE BAR' to Upgrade for " + selectedTower.getUpgradeCost(), width / 2 - 10, height / 2 + 130);
    }
    else{
      fill(0, 0, 0, 150);
      rect(width / 2 - 110, height / 2 - 50, 220, 100);
      fill(255);
      rect(width / 2 - 105, height / 2 - 45, 210, 90);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(14);
      text("out of upgrades", width/2, height/2 - 10);
    }
 
  }

if (upgradingSTower && selectedSTower != null) {
    if (selectedSTower.upCount() < 5){
      fill(0, 0, 0, 150);
      rect(width / 2 - 110, height / 2 - 50, 220, 100);
      fill(255);
      rect(width / 2 - 105, height / 2 - 45, 210, 90);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(14);
      text("Upgrade Slow Tower", width / 2, height / 2 - 30);
      textSize(12);
      text("Damage: " + selectedSTower.damage, width / 2, height / 2 - 10);
      text("Range: " + selectedSTower.range, width / 2, height / 2 + 10);
      textSize(10);
      text("Slow Duration: " + selectedSTower.slowDuration, width / 2, height / 2 + 30);
      fill(0, 150, 0);
      fill(0);
      textSize(20);
      text("Press 'SPACE BAR' to Upgrade for " + selectedSTower.getUpgradeCost(), width / 2 - 10, height / 2 + 130);
    }
    else{
      fill(0, 0, 0, 150);
      rect(width / 2 - 110, height / 2 - 50, 220, 100);
      fill(255);
      rect(width / 2 - 105, height / 2 - 45, 210, 90);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(14);
      text("out of upgrades", width/2, height/2 - 10);
    }
 
  }

if (upgradingMTower && selectedMTower != null) {
    if (selectedMTower.upCount() < 3){
      fill(0, 0, 0, 150);
      rect(width / 2 - 110, height / 2 - 50, 220, 100);
      fill(255);
      rect(width / 2 - 105, height / 2 - 45, 210, 90);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(14);
      text("Upgrade Tower", width / 2, height / 2 - 30);
      textSize(12);
      text("Damage: " + selectedMTower.damage, width / 2, height / 2 - 10);
      text("Range: " + selectedMTower.range, width / 2, height / 2 + 10);
      textSize(10);
      text("Attack Amount: " + selectedMTower.maxTargets + " Rabbits", width / 2, height / 2 + 30);
      fill(0, 150, 0);
      fill(0);
      textSize(20);
      text("Press 'SPACE BAR' to Upgrade for " + selectedMTower.getUpgradeCost(), width / 2 - 10, height / 2 + 130);
    }
    else{
      fill(0, 0, 0, 150);
      rect(width / 2 - 110, height / 2 - 50, 220, 100);
      fill(255);
      rect(width / 2 - 105, height / 2 - 45, 210, 90);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(14);
      text("out of upgrades", width/2, height/2 - 10);
    }
 
  }

}
}

void mousePressed() {
  int countN = 1;
  if (!gameStarted) {
    if (mouseX > width / 2 - 200 && mouseX < width / 2 + 200) {
      if (mouseY > 150 && mouseY < 250) {
        selectMap(1);
      } else if (mouseY > 300 && mouseY < 400) {
        selectMap(2);
      } else if (mouseY > 450 && mouseY < 550) {
        selectMap(3);
      }
    }
  } else {
  if (placingTower) {
    if (playerMoney >= 50) {
      if (mouseX < 800 && !isOnPath(mouseX, mouseY)){
        towers.add(new Tower(mouseX, mouseY));
        if (countN == 1){
          playerMoney -= 75;
          countN++;
        }
        else{
          playerMoney -= 50;
        }
        placingTower = false;
      }
      else{
        textSize(18);
        text("Cannot be placed here", mouseX, mouseY);
      }
    }
  }
  if (!placingTower){
    if ((mouseX > 818 && mouseX < 1158) && (mouseY > 250 && mouseY < 340)) {
    if (playerMoney >= 50){
       placingTower = true;
       tempTower = new Tower(mouseX, mouseY);
    }

  } else {
    upgradingTower = false;
    for (Tower t : towers) {
      if (t.isClicked(mouseX, mouseY)) {
        selectedTower = t;
        upgradingTower = true;
        return;
      }
    }
  }
  }
  
  if (placingSTower) {
    int countS =1;
    if (playerMoney >= 50) {
      if (mouseX < 800 && !isOnPath(mouseX, mouseY)){
        sTowers.add(new slowTower(mouseX, mouseY));
        if (countS == 1){
          playerMoney -= 75;
          countS++;
        }
        else{
          playerMoney -= 50;
        }
        placingSTower = false;
      }
      else{
        textSize(18);
        text("Cannot be placed here", mouseX, mouseY);
      }

    }
  }
  if (!placingSTower){
    if ((mouseX > 818 && mouseX < 1158) && (mouseY > 350 && mouseY < 440)) {
    if (playerMoney >= 50){
       placingSTower = true;
       tempSTower = new slowTower(mouseX, mouseY);
    }

  } else {
    upgradingSTower = false;
    for (slowTower t : sTowers) {
      if (t.isClicked(mouseX, mouseY)) {
        selectedSTower = t;
        upgradingSTower = true;
        return;
      }
    }
  }
  }
  
  
  if (placingMTower && !isOnPath(mouseX, mouseY)) {
    int countM= 1;
    if (playerMoney >= 50) {
      if (mouseX < 800){
        mTowers.add(new multiTower(mouseX, mouseY));
        if (countM == 1){
          playerMoney -= 100;
          countM++;
        }
        else{
          playerMoney -= 50;
        }
        placingMTower = false;
      }
      else{
        textSize(18);
        text("Cannot be placed here", mouseX, mouseY);
      }

    }
  }
  if (!placingMTower){
    if ((mouseX > 818 && mouseX < 1158) && (mouseY > 450 && mouseY < 540)) {
    if (playerMoney >= 50){
       placingMTower = true;
       tempMTower = new multiTower(mouseX, mouseY);
    }

  } else {
    upgradingMTower = false;
    for (multiTower t : mTowers) {
      if (t.isClicked(mouseX, mouseY)) {
        selectedMTower = t;
        upgradingMTower = true;
        return;
      }
    }
  }
  }
  }

  if ((mouseX > 828 && mouseX < 978) && (mouseY > 700 && mouseY < 750)){
    wave = 1;
    radi =1;
    spawnInterval = 60;
    spawnTimer = 0;
    rabbitsTBulletoSpawn = 0;
    rabbitsSpawned = 0;
    rabbitsToSpawn = 12;
    playerHealth = 100;
    playerMoney = 100;
    while (rabbits.size() != 0) { rabbits.remove(0); }
    while (towers.size() != 0) { towers.remove(0); }
    while (mTowers.size() != 0) { mTowers.remove(0); }
    while (sTowers.size() != 0) { sTowers.remove(0); }
    while (Bullets.size() != 0) { Bullets.remove(0); }
}
  if ((mouseX > 1000 && mouseX < 1150) && (mouseY > 700 && mouseY < 750)){
     gameStarted = false;
     currmusic.stop();
      wave = 1;
    radi =1;
    spawnInterval = 60;
    spawnTimer = 0;
    rabbitsTBulletoSpawn = 0;
    rabbitsSpawned = 0;
    rabbitsToSpawn = 12;
    playerHealth = 100;
    playerMoney = 100;
    pathcolor = 0;
    textcolor = 0;
    healthmult = 1;
    moneymult = 1;
    speedmult = 1;
    while (rabbits.size() != 0) { rabbits.remove(0); }
    while (towers.size() != 0) { towers.remove(0); }
    while (mTowers.size() != 0) { mTowers.remove(0); }
    while (sTowers.size() != 0) { sTowers.remove(0); }
    while (Bullets.size() != 0) { Bullets.remove(0); }
    while (pathPoints.size() != 0) { pathPoints.remove(0); }
     PFont f = createFont("Lucida Sans", 12);
     textFont(f);
}
}


void keyPressed() {
  if (key == 'w') wave++;
  if (key == 'm') playerMoney += 1000;
  if (key == 'r') {
    spawnTimer = 0;
    rabbits.add(new Rabbit(pathPoints, wave));
    rabbitsSpawned++;
  }
  if (key == 'f') {
    spawnTimer = 0;
    rabbits.add(new FastRabbit(pathPoints, wave));
    rabbitsSpawned++;
  }
  if (key == 't') {
    spawnTimer = 0;
    rabbits.add(new TankRabbit(pathPoints, wave));
    rabbitsSpawned++;
  }
  if (key == 'b') {
    spawnTimer = 0;
    rabbits.add(new BossRabbit(pathPoints, wave));
    rabbitsSpawned++;
  }
  if (key == ' ' && upgradingTower && selectedTower != null && playerMoney >= selectedTower.getUpgradeCost()) {
    selectedTower.setUpCount();
    selectedTower.upgrade();
    upgradingTower = false;
  }
  if (key == ' ' && upgradingSTower && selectedSTower != null && playerMoney >= selectedSTower.getUpgradeCost()) {
    selectedSTower.setUpCount();
    selectedSTower.upgrade();
    upgradingSTower = false;
  }if (key == ' ' && upgradingMTower && selectedMTower != null && playerMoney >= selectedMTower.getUpgradeCost()) {
    selectedMTower.setUpCount();
    selectedMTower.upgrade();
    upgradingMTower = false;
  }
  if (key == 'q' && placingTower) {
    placingTower = false;
  }
   if (key == 'q' && placingSTower) {
    placingSTower = false;
  } if (key == 'q' && placingMTower) {
    placingMTower = false;
  }
}


void gameOver() {
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Game Over!", width / 2, height / 2);
  currmusic.stop();
  noLoop();
}

void selectMap(int map) {
  pathPoints.clear();

  if (map == 1) {
  currentbg = map1;
  startPoint = new PVector(-1, (width - 180)/100*17.5);
  endPoint = new PVector((width - 180)/8, (width - 180)/100*79.5);
  pathPoints.add(startPoint);
  pathPoints.add(new PVector((width - 180)/1.29, (width - 180)/100*17.5));
  pathPoints.add(new PVector((width - 180)/1.29, (width - 180)/100*32.5));
  pathPoints.add(new PVector((width - 180)/4.425, (width - 180)/100*32.5));
  pathPoints.add(new PVector((width - 180)/4.425, (width - 180)/100*47.5));
  pathPoints.add(new PVector((width - 180)/1.289, (width - 180)/100*47.5));
  pathPoints.add(new PVector((width - 180)/1.289, (width - 180)/100*67.5));
  pathPoints.add(new PVector((width - 180)/8, (width - 180)/100*67.5));
  pathPoints.add(endPoint);
  pathcolor = #5C5C5F;
  speedmult = 1;
  healthmult = 1;
  maxwave = 15;
  currmusic = music1;
  } else if (map == 2) {
    currentbg = map2;
    startPoint = new PVector(-1, (width - 180)/20);
    endPoint = new PVector(800, 0);
    pathPoints.add(startPoint);
    pathPoints.add(new PVector(100, 50));
    pathPoints.add(new PVector(300, 250));
    pathPoints.add(new PVector(100, 250));
    pathPoints.add(new PVector(300, 450));
    pathPoints.add(new PVector(800, 450));
    pathPoints.add(new PVector(600, 250));
    pathPoints.add(new PVector(800, 250));
    pathPoints.add(endPoint);
    pathcolor = #39A9FF;
    speedmult = 1.5; 
    healthmult = 2;
    maxwave = 20;
    moneymult = 2;
    currmusic = music2;
  } else if (map == 3) {
    currentbg = map3;
    startPoint = new PVector(-1, (width - 180)/5);
    endPoint = new PVector(0, 605);
    pathPoints.add(startPoint);
    pathPoints.add(new PVector(200, (width - 180)/5));
    pathPoints.add(new PVector(250, 150));
    pathPoints.add(new PVector(350, 130));
    pathPoints.add(new PVector(500, 120));
    pathPoints.add(new PVector(600, 130));
    pathPoints.add(new PVector(700, 120));
    pathPoints.add(new PVector(800 - 45, 170));
    pathPoints.add(new PVector(850 - 55, 300));
    pathPoints.add(new PVector(800 - 45, 500));
    pathPoints.add(new PVector(700, 600));
    pathPoints.add(new PVector(600, 650));
    pathPoints.add(new PVector(500, 600));
    pathPoints.add(new PVector(450, 580));
    pathPoints.add(new PVector(400, 550));
    pathPoints.add(new PVector(300, 550));
    pathPoints.add(new PVector(200, 575));
    pathPoints.add(new PVector(100, 605));
    pathPoints.add(endPoint);
    textcolor = #FFFFFF;
    speedmult = 4;
    healthmult = 2;
    maxwave = 30;
    moneymult = 4;
    currmusic = music3;
  }
  gameStarted = true;
}


boolean isOnPath(float x, float y) {
  float pathwidth = 40;
  for (int i = 0; i < pathPoints.size() - 1; i++) {
    PVector p1 = pathPoints.get(i);
    PVector p2 = pathPoints.get(i + 1);
    if (distSeg(new PVector(x, y), p1, p2) < pathwidth) {
      return true;
    }
  }
  return false;
}

float distSeg(PVector p, PVector v, PVector w) {
  float length = PVector.dist(v, w) * PVector.dist(v, w);
  if (length == 0.0) return PVector.dist(p, v);
  float a = max(0, min(1, PVector.sub(p, v).dot(PVector.sub(w, v)) / length));
  PVector projection = PVector.add(v, PVector.mult(PVector.sub(w, v), a));
  return PVector.dist(p, projection);
}
