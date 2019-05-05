// class for a cell
class Cell {

  // position
  PVector pos;

  // and the initial position ( which will be the same for each cell, but still )
  // need it to calculate the distance and get the color of the cell
  PVector init_pos;

  // radius
  float r = 1.5;

  // the y "velocity" of the cell
  // bigger velocity = more spread out branches
  float y_movement = 4.5;

  int num_branches;

  color col;

  // constructor for the cell object
  // gets a radius and an angle to start from
  Cell(float radius, float angle, int num_branches_) {
    // initializes the position as a pvector from the given angle
    pos = PVector.fromAngle(angle);
    // and multiplies by that radius
    pos.mult(radius);
    // and also set the initial position
    init_pos = pos.copy();
    // need this as well
    num_branches = num_branches_;
  }

  // update the cell
  void update() {
    // go 1 pixel to the left
    pos.x -= 1;

    // and a random amount on Y within the fixed bounds
    pos.y += random(-y_movement, y_movement);

    // get the angle of the vector
    float angle = pos.heading();

    // constrain the angle from 0 to PI / (splits / 2)
    angle = constrain(angle, 0, PI / (num_branches/ 2));

    // get the magnitude of the vector
    float magnitude = pos.mag();

    // update the position of the vector
    pos = PVector.fromAngle(angle);
    pos.setMag(magnitude);
  }

  void setColor() {
    // and color the cell using the difference on x
    // which will go from 0 to init_pos
    // to 0-255 ( range of the R, G, B channels )
    float val = map(abs(init_pos.x - pos.x), 0, init_pos.x, 0, 256);
    // red will be 255 - that value, which will yield less red to the middle of the snowflake and more on the edges
    // green value will be something between 128 and 256 for each cell ( arbitrarily, it produced nice effects )
    // and blue will be the value itself, mapped from 0 and 256 to (192, 256) so there's a lot more blue
    // so it will give a cold, nice snowflake
    col = color(255 - val, random(128, 256), map(val, 0, 256, 192, 256));
  }

  void show(float life) {
    // show the cell as an ellipse with no stroke and a given fill color
    noStroke();
    fill(col, map(life, max_life, 0, 255, 0));
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }

  // check if a cell intersects any of the 
  // other cells from the "snowflake" pattern
  boolean intersects(ArrayList<Cell> snowflake) {
    // and for each other cell
    for (Cell s : snowflake) {
      // if the distance between this cell and the other cell
      float d = dist(s.pos.x, s.pos.y, pos.x, pos.y); 
      // is less than the double the radii of the cells
      // (the radii are equal)
      if (d < r * 2) {
        // we intersected another cell
        // return true
        return true;
      }
    }
    // otherwise, return false
    return false;
  }

  // and a cell is "finished" if it reached the origin
  // the origin will be set at the middle of the screen
  boolean finished() {
    return (pos.x < 1);
  }
}
