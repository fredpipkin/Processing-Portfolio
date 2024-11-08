float noiseScale = 0.02; // Controls the scale of Perlin noise
float noiseStrength = 150; // Controls the strength of the noise effect
float angleOffset = 0; // Offset angle for swirling effect
float angleIncrement = 0.001; // Controls the rate of change for the angle

void setup() {
  size(800, 600);
  background(0);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(0);
  
  // Calculate center of the canvas
  float centerX = width / 2;
  float centerY = height / 2;
  
  // Update angle offset based on mouse position
  angleOffset += angleIncrement;
  
  // Draw swirling pattern
  for (float radius = 50; radius < width; radius += 20) {
    float angle = noise((centerX + cos(angleOffset) * radius) * noiseScale, (centerY + sin(angleOffset) * radius) * noiseScale) * TWO_PI * noiseStrength;
    float x = centerX + cos(angle) * radius;
    float y = centerY + sin(angle) * radius;
    fill(map(angle, 0, TWO_PI * noiseStrength, 0, 360), 100, 100);
    ellipse(x, y, 10, 10);
  }
}
