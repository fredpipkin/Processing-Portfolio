// Define colors
color beige = color(245, 245, 220);
color black = color(0, 0, 0);
color brown = color(139, 69, 19);

// Define side length and time variable
float sideLength = 40;
float time = 0;

void setup() {
  size(800, 800);
}

void draw() {
  background(255); // Clear background for each frame
  float h = sideLength * sqrt(3) / 2;
  time += 0.02; // Increment time for animation
  
  // Draw the background tessellation
  drawBackgroundTessellation(h);

  // Draw the animated tessellation
  for (float y = 0; y < height + h; y += 3 * h) {
    for (float x = 0; x < width + sideLength; x += 1.5 * sideLength) {
      float offsetX = sin(time + x * 0.05) * 20; // Calculate horizontal offset
      float offsetY = cos(time + y * 0.05) * 20; // Calculate vertical offset
      drawHexagon(x + offsetX, y + offsetY, sideLength, (int)(x + y) % 3, 255);
      drawHexagon(x + 0.75 * sideLength + offsetX, y + 1.5 * h + offsetY, sideLength, (int)(x + y + 1) % 3, 255);
    }
  }
}

void drawBackgroundTessellation(float h) {
  for (float y = 0; y < height + h; y += 3 * h) {
    for (float x = 0; x < width + sideLength; x += 1.5 * sideLength) {
      drawHexagon(x, y, sideLength, (int)(x + y) % 3, 50); // Semi-transparent background hexagons
      drawHexagon(x + 0.75 * sideLength, y + 1.5 * h, sideLength, (int)(x + y + 1) % 3, 50);
    }
  }
}

void drawHexagon(float x, float y, float s, int colorChoice, int alpha) {
  float h = s * sqrt(3) / 2;
  fill(selectColor(colorChoice, alpha));
  noStroke();
  beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = TWO_PI / 6 * i;
    float xOffset = s * cos(angle);
    float yOffset = s * sin(angle);
    vertex(x + xOffset, y + yOffset);
  }
  endShape(CLOSE);
}

color selectColor(int choice, int alpha) {
  switch (choice) {
    case 0:
      return color(red(beige), green(beige), blue(beige), alpha);
    case 1:
      return color(red(black), green(black), blue(black), alpha);
    case 2:
      return color(red(brown), green(brown), blue(brown), alpha);
    default:
      return color(red(beige), green(beige), blue(beige), alpha);
  }
}
