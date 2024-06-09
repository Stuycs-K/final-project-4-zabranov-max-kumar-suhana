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
Tower tempTower;
Tower selectedTower;
PImage coins;
PImage heart;
PImage waveI;
ArrayList<PVector> pathPoints;
PImage rabbitImage;

void setup() {
  size(1180, 800);
  startPoint = new PVector(-1, (width - 180)/100*17.5);
  endPoint = new PVector((width - 180)/8, (width - 180)/100*79.5);
  rabbits = new ArrayList<Rabbit>();
  towers = new ArrayList<Tower>();
  sTowers = new ArrayList<slowTower>();
  mTowers = new ArrayList<multiTower>();
  Bullets = new ArrayList<Bullet>();
  coins = loadImage("coin.png");
  heart = loadImage("heart.png");
  waveI = loadImage("waveI.png");
  rabbitsToSpawn = 10; // Start with 10 rabbits in wave 1
  rabbitImage = loadImage("rabbitpic.png"); 
  pathPoints = new ArrayList<PVector>();
  pathPoints.add(startPoint);
  pathPoints.add(new PVector((width - 180)/1.29, (width - 180) /100*17.5));
  pathPoints.add(new PVector((width - 180)/1.29, (width - 180)/100*32.5));
  pathPoints.add(new PVector((width - 180)/4.425, (width - 180)/100*32.5));
  pathPoints.add(new PVector((width - 180)/4.425, (width - 180)/100*47.5));
  pathPoints.add(new PVector((width - 180)/1.289, (width - 180)/100*47.5));
  pathPoints.add(new PVector((width - 180)/1.289, (width - 180)/100*67.5));
  pathPoints.add(new PVector((width - 180)/8, (width - 180)/100*67.5));
  pathPoints.add(endPoint);

}

void draw() {
  background(#009900);
  stroke(#808080); // Brown color
  strokeWeight(40); // Wider path
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
  rect(818, 350, 340, 90);
  fill(0);
  text("Click to Place Slow Tower,   Cost: 75", 960, 400);
  fill(255);
  rect(818, 450, 340, 90);
  fill(0);
  text("Click to Place Multi Tower,   Cost: 100", 960 , 500);
  fill(255);
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
    spawnTimer++;
    if (spawnTimer >= spawnInterval) {
      rabbits.add(new Rabbit(pathPoints, wave));
      rabbitsSpawned++;
      spawnTimer = 0;
    }
  }

  for (int i = rabbits.size() - 1; i >= 0; i--) {
    Rabbit r = rabbits.get(i);
    r.update();
    r.display();
    if (r.isDead()) {
      playerMoney += rabbits.get(i).getMaxHealth(); // Gain money for killing a rabbit
      rabbits.remove(i);
    } else if (r.reachedEnd()) {
      playerHealth -= 10; // Lose health if rabbit reaches the end
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

  if (wave > 15) {
      fill(0);
       textSize(32);
       textAlign(CENTER, CENTER);
       text("You Win!", width / 2, height / 2);
       noLoop();
    }
  if (rabbits.size() == 0 && rabbitsSpawned >= rabbitsToSpawn) {
    if (wave < 15){
    wave++;
    playerMoney += 50 * wave;
    rabbitsToSpawn = 10 + wave * 2; // Scale rabbits count with wave number
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
      //rect(width/2 - 50, height / 2 + 40, 200, 20);
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
      //rect(width/2 - 50, height / 2 + 40, 200, 20);
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
      text("Damage: 5 ", width / 2, height / 2 - 10);
      text("Range: 200 ", width / 2, height / 2 + 10);
      textSize(10);
      text("Attack Amount: " + selectedMTower.maxTargets + " Rabbits", width / 2, height / 2 + 30);
      fill(0, 150, 0);
      //rect(width/2 - 50, height / 2 + 40, 200, 20);
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

void mousePressed() {
  int countN = 1;
  if (placingTower) {
    if (playerMoney >= 50) {
      if (mouseX < 800){
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
      if (mouseX < 800){
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
  
  
  if (placingMTower) {
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
  if ((mouseX > 828 && mouseX < 978) && (mouseY > 700 && mouseY < 750)){
    setup();
}
//  if ((mouseX > 1000 && mouseX < 1150) && (mouseY > 700 && mouseY < 750)){
////map
//}
}

void keyPressed() {
  if (key == 'w') wave++;
  if (key == 'm') playerMoney += 1000;
  if (key == 'r') {
    spawnTimer = 0;
    rabbits.add(new Rabbit(pathPoints, wave));
  }
  if (key == ' ' && upgradingTower && selectedTower != null) {
    selectedTower.setUpCount();
    selectedTower.upgrade();
    upgradingTower = false;
  }
  if (key == ' ' && upgradingSTower && selectedSTower != null) {
    selectedSTower.setUpCount();
    selectedSTower.upgrade();
    upgradingSTower = false;
  }if (key == ' ' && upgradingMTower && selectedMTower != null) {
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
  noLoop();
}
