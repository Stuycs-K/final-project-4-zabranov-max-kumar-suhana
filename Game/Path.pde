public class Path {
      private Point[] points;
      public Path() {
      ArrayList<Point[]> track = new ArrayList<Point[]>();
      
      track.add(new Point[]{new Point(-1, width/100*17.5), new Point(width/1.29, width/100*17.5),
                           new Point(width/1.29, width/100*32.5), new Point(width/4.425, width/100*32.5),
                           new Point(width/4.425, width/100*47.5), new Point(width/1.289, width/100*47.5),
                           new Point(width/1.289, width/100*67.5), new Point(width/8, width/100*67.5),
                           new Point(width/8, width/100*79.5)});
      
      this.points = track.get(0);
      }
      
     void display() {
       stroke(#00FF00, 50);
       strokeWeight(width/18);
       for (int i = 0; i < points.length - 1; i++) {
         line(points[i].getX(), points[i].getY(), points[i + 1].getX(), points[i + 1].getY());
       }
     }
     
     void update() {}
    }
    
   
