int tileSize = 50; // Size of each tile
int cols, rows;

void setup() {
  size(800, 800); // Set canvas size
  cols = width / tileSize;
  rows = height / tileSize;
  noLoop(); // Draw only once
}

void draw() {
  background(255); // Set background color
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i * tileSize;
      float y = j * tileSize;
      drawTile(x, y, tileSize);
    }
  }
}

// Function to draw a single tile
void drawTile(float x, float y, float size) {
  int pattern = int(random(3)); // Random pattern selector (0, 1, 2)
  color c = color(random(255), random(255), random(255)); // Random color
  fill(c);
  stroke(0);
  strokeWeight(2);
  
  switch(pattern) {
    case 0: // Circle pattern
      ellipse(x + size / 2, y + size / 2, size * 0.8, size * 0.8);
      break;
    case 1: // Square pattern
      rect(x + size * 0.1, y + size * 0.1, size * 0.8, size * 0.8);
      break;
    case 2: // Triangle pattern
      triangle(x + size / 2, y + size * 0.1, x + size * 0.1, y + size * 0.9, x + size * 0.9, y + size * 0.9);
      break;
  }
}
