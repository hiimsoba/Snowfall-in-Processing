class Snowflake {

  int num_branches;
  float radius;
  float posx;
  float posy; 
  float speed;
  float gravity;
  float life = max_life;

  // keep track of an arraylist of cells
  // so we know where each of our cells is
  ArrayList<Cell> snowflake = new ArrayList<Cell> ();

  Snowflake(float x_, float  y_, float radius_, int num_branches_) {
    posx= x_;
    posy=y_;
    radius = radius_;
    num_branches = num_branches_; 
    speed = 0;
    gravity = 0.1;

    Cell current = new Cell(radius, 0, num_branches);

    // and now float xpos, float ypos, float spwe can simulate the automaton, using this single cell
    while (true) {
      // to count the number of frames it takes for a cell to reach
      // its "final state" ( i.e. it intersected another cell or the origin )
      int count = 0;

      // and until it reaches its final position
      while (!current.finished() && !current.intersects(snowflake)) {
        // update it and count the number of steps
        current.update();
        count++;
      }

      // if a particle doesn't move, the snowflake is finished
      if (count == 0) {
        //println("snowflake completed");
        break;
      }

      // set the color to the cell
      current.setColor();

      // add the cell to the snowflake
      snowflake.add(current);

      // and reinitialize the current cell
      current = new Cell(radius, 0, num_branches);
    }
  }

  void show() {
    pushMatrix();
    translate(posx, posy);

    // rotate a bit   
    rotate(PI / ((float) num_branches / 3));

    // and finally, draw the snowflake ( display each cell )
    // draw each branch
    for (int i = 0; i < num_branches; i++) {
      // first rotate
      rotate(PI / ((float) num_branches / 2));
      // display all cels
      for (Cell p : snowflake) {
        p.show(life);
      }
      pushMatrix();
      // inverse
      scale(1, -1);
      // and display the cells again
      for (Cell p : snowflake) {
        p.show(life);
      }
      popMatrix();
    }
    popMatrix();
  }

  void move() {
    // Add gravity to speed
    speed = speed + gravity;
    // Add speed to y location
    posy = posy + speed;
  }

  boolean finished() {
    // Balls fade out
    life--;
    return life < 0;
  }
}
