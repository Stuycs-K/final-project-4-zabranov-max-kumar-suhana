  public void startGame() {}
  
  public void endGame() {}
  
  public void draw() {}
  
  public void setup() {
  size(1500, 900);
  PImage img;
  img = loadImage("grass.jpg");
  img2 = loadImage("tile.jpg");
  image(img, 0, 0, width, height);
  int step = 75;
  for(int i = 0; i < width/step; i++ ) {
   image(img2, i, i*step, height);
  }
  }
