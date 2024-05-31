public class Map {
    class Cell {
      int x;
      int y;
      boolean isPath = false;
      Tower placed = null;
      
      void place(Tower tower) {
        if (canBuild()) {
          placed = tower;
          
        }
      }
      
      boolean canBuild() {
        if (placed == null && !isPath) return true;
        else return false;
      }
      
      void outline() {
        noFill();
        if (canBuild()) stroke(#000000);
        else stroke(#FF0000);
        rect(x * cellSize, y * cellSize, cellSize, cellSize);
        
      }
    }
    
    class Point {
      private float x;
      private float y;
      
      public Point(float x, float y) {
        this.x = x;
        this.y = y;
      }
      
      public Point() {
        this(0, 0);
      }
      
      public float getX() {
        return x;
      }
      
      public float getY() {
        return y;
      }
    }
    
