// how many background snowflakes ( small white dots )
int quantity = 30;

float [] xPosition = new float[quantity];
float [] yPosition = new float[quantity];

int [] flakeSize = new int[quantity];
int [] direction = new int[quantity];

int minFlakeSize = 1;
int maxFlakeSize = 5;

ArrayList<Snowflake> snowflakes;

final int max_life = 128;

void setup() {

  //size(600, 600);  // create a 600x600 window
  // or full screen!
  fullScreen();

  // smoothness! or not. reduces framerate.
  //smooth(102400);

  snowflakes = new ArrayList<Snowflake>();

  for (int i = 0; i < quantity; i++) {
    flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
    xPosition[i] = random(0, width);
    yPosition[i] = random(0, height);
    direction[i] = round(random(0, 1));
  }
}

void draw() {
  background(0); //set background to black

  if (frameCount % 25 == 0) {
    float Height = random(10, min(width / 14, height / 14));
    snowflakes.add(new Snowflake(random(width), -Height, Height, floor(random(6, 6))));
  }

  for (int i = 0; i < xPosition.length; i++) {
    fill(255);
    ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i]);
    if (direction[i] == 0) {
      xPosition[i] += map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    } else {
      xPosition[i] -= map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    }
    yPosition[i] += flakeSize[i] + direction[i]; 
    if (xPosition[i] > width + flakeSize[i] || xPosition[i] < -flakeSize[i] || yPosition[i] > height + flakeSize[i]) {
      xPosition[i] = random(0, width);
      yPosition[i] = -flakeSize[i];
    }
  }

  for (int i = snowflakes.size() - 1; i >= 0; i--) { 
    Snowflake e = snowflakes.get(i);
    e.move();
    e.show();
    if (e.finished()) {
      snowflakes.remove(i);
    }
  }
}
