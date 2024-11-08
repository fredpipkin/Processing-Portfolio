void setup() {
  size(800, 600);
  background(0);
}

void draw() {
  // Set the stroke color
  stroke(random(255), random(255), random(255));
  
  // Draw random lines
  for (int i = 0; i < 50; i++) {
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height);
    line(x1, y1, x2, y2);
  }
}
