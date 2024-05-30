static int _width = 1000;
static int _height = (int) (_width * .8);
static float playheight = _width * .65;
static float cellSize = _width/20; 
static float menuY = playheight + 1;
static float menuHeight = _height - menuY;
int[][] Grid = new int[20][16];

public void startGame() {}
  
  public void endGame() {}
  
  public void draw() {
  PImage grass;
  PImage path;
  grass = loadImage("grass.jpg");
  path = loadImage("path.png");
  image(grass, 0, 0, _width, _height);
  image(path, 0, 0, _width, _height);
  mouseHover();
  }
  public void setup() {
  size(_width, _height);
  for (int x = 0; x < Grid.length; x++) {
    for (int y = 0; y < Grid[0].length; y++) {
      noFill();
      stroke(#000000);
      rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
  }
  }
  void mouseHover() {
    int x = (int) (mouseX / cellSize);
    int y = (int) (mouseY/cellSize);
    if (y < Grid[0].length && x < Grid.length) {
    noFill();
    stroke(#000000);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
  }
