int numShapes = 20;
float[] x = new float[numShapes];
float[] y = new float[numShapes];
float[] angle = new float[numShapes];
float[] speed = new float[numShapes];
color[] colors = new color[numShapes];

color redColor = color(255, 0, 0);
color blackColor = color(0);
color blueColor = color(0, 0, 255);
color whiteColor = color(255);
color yellowColor = color(255, 255, 0);

int lastColorChange = 0;
int lastBackgroundChange = 0;
int colorChangeInterval = 5000; // 5 seconds in milliseconds
int backgroundChangeInterval = 10000; // 10 seconds in milliseconds
int flashDuration = 3000; // 3 seconds in milliseconds

float arrowAngle = 0;
float arrowRadius = 150; // Radius of the circle
float arrowSpeed = radians(1); // Speed of rotation

void setup() {
  size(800, 600);
  for (int i = 0; i < numShapes; i++) {
    x[i] = random(width);
    y[i] = random(height);
    angle[i] = random(TWO_PI);
    speed[i] = random(0.5, 2.0);
    colors[i] = randomColor();
  }
}

void draw() {
  // Check if it's time to change background color
  if (millis() - lastBackgroundChange < flashDuration && millis() - lastBackgroundChange < backgroundChangeInterval) {
    background(yellowColor);
  } else if (millis() - lastBackgroundChange >= backgroundChangeInterval) {
    background(yellowColor);
    lastBackgroundChange = millis();
  } else {
    background(255); // White background
  }

  // Draw arrow moving in a circle
  float arrowX = width/2 + cos(arrowAngle) * arrowRadius;
  float arrowY = height/2 + sin(arrowAngle) * arrowRadius;
  drawArrow(arrowX, arrowY, arrowAngle, blueColor); // Draw arrow
  
  arrowAngle += arrowSpeed;
  
  for (int i = 0; i < numShapes; i++) {
    drawShape(x[i], y[i], angle[i], colors[i]);
    x[i] += cos(angle[i]) * speed[i];
    y[i] += sin(angle[i]) * speed[i];
    if (x[i] < 0 || x[i] > width || y[i] < 0 || y[i] > height) {
      x[i] = random(width);
      y[i] = random(height);
    }
    angle[i] += random(-0.1, 0.1);
  }
  
  // Check if it's time to change colors
  if (millis() - lastColorChange >= colorChangeInterval) {
    for (int i = 0; i < numShapes; i++) {
      colors[i] = randomColor();
    }
    lastColorChange = millis();
  }
}

void drawShape(float x, float y, float angle, color c) {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  fill(c);
  ellipse(0, 0, 50, 50); // Circle with a diameter of 50 pixels
  popMatrix();
}

void drawArrow(float x, float y, float angle, color c) {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  fill(c);
  beginShape();
  vertex(0, -25);
  vertex(20, 0);
  vertex(0, 25);
  endShape(CLOSE);
  popMatrix();
}

color randomColor() {
  int choice = int(random(4));
  switch (choice) {
    case 0:
      return redColor;
    case 1:
      return blackColor;
    case 2:
      return blueColor;
    case 3:
      return whiteColor;
    default:
      return color(255);
  }
}
