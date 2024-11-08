float angle = 0;
float spacing = 20;
int cols, rows;
float[][] offsets;
int lastColorChange = 0;
int colorChangeInterval = 10000; // 10 seconds

void setup() {
  size(600, 600);
  cols = width / int(spacing);
  rows = height / int(spacing);
  offsets = new float[cols][rows];
}

void draw() {
  // Calculate background color
  float bgBrightness = map(sin(millis() / 5000.0 * TWO_PI), -1, 1, 255, 0);
  background(bgBrightness);

  // Check if it's time to change color
  if (millis() - lastColorChange >= colorChangeInterval) {
    lastColorChange = millis();
  }

  // Update offsets
  float xoff = 0;
  for (int i = 0; i < cols; i++) {
    float yoff = 0;
    for (int j = 0; j < rows; j++) {
      offsets[i][j] = map(noise(xoff, yoff), 0, 1, -spacing / 2, spacing / 2);
      yoff += 0.1;
    }
    xoff += 0.1;
  }

  // Draw tessellated patterns
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i * spacing + offsets[i][j];
      float y = j * spacing + offsets[i][j];
      drawPattern(x, y, millis());
    }
  }
}

void drawPattern(float x, float y, float time) {
  pushMatrix();
  translate(x, y);

  // Calculate pattern color
  float patternBrightness = map(cos(millis() / 5000.0 * TWO_PI), -1, 1, 0, 255);
  fill(patternBrightness);

  // Apply dynamic transformations
  float displacementX = sin(angle + x / 50 + time / 1000) * spacing / 2;
  float displacementY = cos(angle + y / 50 + time / 1000) * spacing / 2;

  for (int i = 0; i < TWO_PI; i += PI / 3) {
    float x1 = cos(angle + i) * spacing / 2 + displacementX;
    float y1 = sin(angle + i) * spacing / 2 + displacementY;
    float x2 = cos(angle + i + PI / 3) * spacing / 2 + displacementX;
    float y2 = sin(angle + i + PI / 3) * spacing / 2 + displacementY;
    float x3 = cos(angle + i + 2 * PI / 3) * spacing / 2 + displacementX;
    float y3 = sin(angle + i + 2 * PI / 3) * spacing / 2 + displacementY;

    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x3, y3);
    endShape(CLOSE);
  }

  popMatrix();
}
