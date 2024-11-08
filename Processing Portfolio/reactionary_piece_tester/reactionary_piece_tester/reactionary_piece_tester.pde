import processing.serial.*;

Serial myPort;        // The serial port
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

float pointX, pointY;
float pointSpeed = 2;
float pointDirectionX, pointDirectionY;

float baseHeartRate = 0;
float currentHeartRate = 0;

void setup() {
  size(600, 600);
  smooth();
  myPort = new Serial(this, Serial.list()[0], 9600); // Adjust the port name and baud rate if necessary
  bgColor = color(random(255), random(255), random(255));
  for (int i = 0; i < numTriangles; i++) {
    x[i] = width / 2;
    y[i] = height / 2;
    colors[i] = color(random(255), random(255), random(255));
  }
  pointX = width / 2;
  pointY = height / 2;
  pointDirectionX = random(-1, 1);
  pointDirectionY = random(-1, 1);
}

void draw() {
  updateBackground();
  background(bgColor);
  updatePointPosition();
  updateTriangles();
  applyBlur(); // Apply blur filter
  drawTriangles();
  
  if (myPort.available() > 0) {
    String heartRateData = myPort.readStringUntil('\n');
    if (heartRateData != null) {
      heartRateData = trim(heartRateData);
      if (heartRateData.length() > 0) {
        float newHeartRate = float(heartRateData);
        if (baseHeartRate == 0) {
          baseHeartRate = newHeartRate;
        }
        currentHeartRate = newHeartRate;
        adjustSwirlSpeed();
      }
    }
  }
}

void updateBackground() {
  if (millis() - lastBgColorChange > bgColorChangeInterval) {
    bgColor = color(random(255), random(255), random(255));
    lastBgColorChange = millis();
  }
}

void updatePointPosition() {
  pointX += pointDirectionX * pointSpeed;
  pointY += pointDirectionY * pointSpeed;
  
  if (pointX < 0 || pointX > width) {
    pointDirectionX *= -1;
  }
  if (pointY < 0 || pointY > height) {
    pointDirectionY *= -1;
  }
}

void updateTriangles() {
  angle += swirlSpeed;
  swirlRadius += sin(angle) * 2; // Adjust the speed of expansion/contraction
  
  for (int i = 0; i < numTriangles; i++) {
    float theta = angle + i * TWO_PI / numTriangles;
    x[i] = width / 2 + swirlRadius * cos(theta);
    y[i] = height / 2 + swirlRadius * sin(theta);
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
    triangle(x[i], y[i], x[(i+1)%numTriangles], y[(i+1)%numTriangles], pointX, pointY);
  }
}

void applyBlur() {
  filter(BLUR, 4); // Apply blur filter with radius of 4
}

void adjustSwirlSpeed() {
  float heartRateDifference = currentHeartRate - baseHeartRate;
  if (abs(heartRateDifference) > 5) {
    swirlSpeed = 0.01 + (heartRateDifference / 100); // Adjust multiplier as necessary
  } else {
    swirlSpeed = 0.01;
  }
}
