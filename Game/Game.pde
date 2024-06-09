ArrayList<Rabbit> rabbits;
ArrayList<Tower> towers;
ArrayList<Bullet> Bullets;
int wave = 1;
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
boolean upgradingTower = false;
boolean gameStarted = false;
Tower tempTower;
Tower selectedTower;
ArrayList<PVector> pathPoints;
PImage rabbitImage;
PImage fastrabbitImage;
PImage tankrabbitImage;
PImage towerImage;
PImage currentbg;
PImage menu;
PImage map1;
PImage map2;
PImage map3;
color pathcolor;


void setup() {
  size(1000, 800);
  menu = loadImage("summer.png");
  map1 = loadImage("grass.jpg");
  map2 = loadImage("sand.jpg");
  startPoint = new PVector(-1, width/100*17.5);
  endPoint = new PVector(width/8, width/100*79.5);
  rabbits = new ArrayList<Rabbit>();
  towers = new ArrayList<Tower>();
  Bullets = new ArrayList<Bullet>();
  rabbitsToSpawn = 10; // Start with 10 rabbits in wave 1
  rabbitImage = loadImage("rabbitpic.png"); 
  fastrabbitImage = loadImage("fastrabbit.png");
  tankrabbitImage = loadImage("tankrabbit.png");
  towerImage = loadImage("tower.png");
  pathPoints = new ArrayList<PVector>();
}

void draw() {
  if (!gameStarted) {
    background(menu);
    fill(0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Map Select", width / 2, 50);
    
    fill(#49DD1E);
    rect(width / 2 - 200, 150, 400, 100);
    fill(#5E88FF);
    rect(width / 2 - 200, 300, 400, 100);
    fill(#49DD1E);
    rect(width / 2 - 200, 450, 400, 100);
    
    fill(#1C4B1F);
    text("Grassy Meadows", width / 2, 200);
    fill(#F5F115);
    text("Sandy Shores", width / 2, 350);
    fill(#1C4B1F);
    text("Place holder", width / 2, 500);
  }
  else {
  background(currentbg);
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



  fill(color(189, 224,255));
  rect(0, height - 50, width, 50);
  fill(0);
  PFont mono;
  mono = createFont("RaceSport.ttf", 10);
  textFont(mono);
  text("Health: " + playerHealth, 50, height - 20);
  text("Money: " + playerMoney, 140, height - 20);
  text("Wave: " + wave, 220, height - 20);
  fill(255);
  rect(width/1.265, width/1.315, 160, 30);
  fill(0);
  if (mouseX >= 400 && mouseX <= 550 &&
      mouseY >= 560 && mouseY <= 590) {
        fill(color(1,147,189));
      }
  text("Click to Place Tower", width - 130, height - 20);

  if (rabbitsSpawned < rabbitsToSpawn) {
    int random = (int) (Math.random() * 11);
    spawnTimer++;
    if (wave <= 3){
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
    else {
    if (spawnTimer >= spawnInterval) {
      if (random <= 4) {
        rabbits.add(new Rabbit(pathPoints, wave));
        rabbitsSpawned++;
        spawnTimer = 0;
      }
      else if (random <= 8){
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
  }

  for (int i = rabbits.size() - 1; i >= 0; i--) {
    Rabbit r = rabbits.get(i);
    r.update();
    r.display();
    if (r.isDead()) {
      playerMoney += ((1100/(-(rabbits.get(i).getMaxHealth()) - 62)) + 20); // Gain money for killing a rabbit
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
    playerMoney += (100/(-wave - 12) + 20);
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
}
}

void mousePressed() {
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
    if (mouseY < height - 50 && playerMoney >= 50) {
      towers.add(new Tower(mouseX, mouseY));
      playerMoney -= 50;
      placingTower = false;
    }
  } else if (mouseX > width - 150 && mouseY > height - 50) {
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
}

void keyPressed() {
  if (key == 'w') wave++;
  if (key == 'm') playerMoney += 1000;
  if (key == 'r') {
    spawnTimer = 0;
    rabbits.add(new Rabbit(pathPoints, wave));
  }
  if (key == ' ' && upgradingTower && selectedTower != null) {
    selectedTower.upgrade();
    upgradingTower = false;
  }
  if (key == 'q' && placingTower) {
    placingTower = false;
  }
}

void gameOver() {
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Game Over!", width / 2, height / 2);
  noLoop();
}

void selectMap(int map) {
  pathPoints.clear();

  if (map == 1) {
  currentbg = map1;
  pathPoints.add(startPoint);
  pathPoints.add(new PVector(width/1.29, width/100*17.5));
  pathPoints.add(new PVector(width/1.29, width/100*32.5));
  pathPoints.add(new PVector(width/4.425, width/100*32.5));
  pathPoints.add(new PVector(width/4.425, width/100*47.5));
  pathPoints.add(new PVector(width/1.289, width/100*47.5));
  pathPoints.add(new PVector(width/1.289, width/100*67.5));
  pathPoints.add(new PVector(width/8, width/100*67.5));
  pathPoints.add(endPoint);
  pathcolor = #5C5C5F;
  } else if (map == 2) {
    currentbg = map2;
    startPoint = new PVector(-1, width/20);
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
  } else if (map == 3) {
    pathPoints.add(new PVector(100, 100));
    pathPoints.add(new PVector(200, 200));
    pathPoints.add(new PVector(100, 300));
    pathPoints.add(new PVector(200, 400));
  }
  gameStarted = true;
}
