float angle = 0;
float angleIncrement = 0.02;
float swirlRadius = 200;
float swirlSpeed = 0.01;
int numTriangles = 50;
float[] x = new float[numTriangles];
float[] y = new float[numTriangles];
color[] colors = new color[numTriangles];
int colorChangeInterval = 2000; // milliseconds
int lastColorChange = 0;
color bgColor;
int bgColorChangeInterval = 2000; // milliseconds
int lastBgColorChange = 0;
float moveSpeed = 20; // High constant speed

void setup() {
  size(600, 600);
  smooth();
  bgColor = color(random(255), random(255), random(255));
  for (int i = 0; i < numTriangles; i++) {
    x[i] = random(width);
    y[i] = random(height);
    colors[i] = color(random(255), random(255), random(255));
  }
}

void draw() {
  updateBackground();
  background(bgColor);
  updateTriangles();
  applyBlur(); // Apply blur filter
  drawTriangles();
}

void updateBackground() {
  if (millis() - lastBgColorChange > bgColorChangeInterval) {
    bgColor = color(random(255), random(255), random(255));
    lastBgColorChange = millis();
  }
}

void updateTriangles() {
  for (int i = 0; i < numTriangles; i++) {
    x[i] += random(-moveSpeed, moveSpeed); // Move triangles randomly along x-axis
    y[i] += random(-moveSpeed, moveSpeed); // Move triangles randomly along y-axis
    
    // Keep triangles within canvas bounds
    if (x[i] < 0) x[i] = 0;
    if (x[i] > width) x[i] = width;
    if (y[i] < 0) y[i] = 0;
    if (y[i] > height) y[i] = height;
  }

  if (millis() - lastColorChange > colorChangeInterval) {
    for (int i = 0; i < numTriangles; i++) {
      colors[i] = color(random(255), random(255), random(255));
    }
    lastColorChange = millis();
  }
}

void drawTriangles() {
  for (int i = 0; i < numTriangles; i++) {
    fill(colors[i]);
    triangle(
      x[i], y[i], 
      x[(i+1) % numTriangles], y[(i+1) % numTriangles], 
      x[(i+2) % numTriangles], y[(i+2) % numTriangles]
    );
  }
}

void applyBlur() {
  filter(BLUR, 4); // Apply blur filter with radius of 4
}
