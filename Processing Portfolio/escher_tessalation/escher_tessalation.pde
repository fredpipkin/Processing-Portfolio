// Define colors
color beige = color(245, 245, 220);
color black = color(0, 0, 0);
color brown = color(139, 69, 19);

void setup() {
  size(800, 800);
  background(255);
  noLoop();
}

void draw() {
  float sideLength = 40;
  float h = sideLength * sqrt(3) / 2;
  
  // Draw the tessellation
  for (float y = 0; y < height + h; y += 3 * h) {
    for (float x = 0; x < width + sideLength; x += 1.5 * sideLength) {
      drawHexagon(x, y, sideLength, (int)(x + y) % 3);
      drawHexagon(x + 0.75 * sideLength, y + 1.5 * h, sideLength, (int)(x + y + 1) % 3);
    }
  }
}

void drawHexagon(float x, float y, float s, int colorChoice) {
  float h = s * sqrt(3) / 2;
  fill(selectColor(colorChoice));
  beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = TWO_PI / 6 * i;
    float xOffset = s * cos(angle);
    float yOffset = s * sin(angle);
    vertex(x + xOffset, y + yOffset);
  }
  endShape(CLOSE);
}

color selectColor(int choice) {
  switch (choice) {
    case 0:
      return beige;
    case 1:
      return black;
    case 2:
      return brown;
    default:
      return beige;
  }
}
