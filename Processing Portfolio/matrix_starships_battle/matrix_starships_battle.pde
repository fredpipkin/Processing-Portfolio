float noiseTime = 0;
ArrayList<Boid> boids;
int numBoids = 50;

void setup() {
  size(800, 600);
  background(0); // Set background to black
  
  // Initialize the flock
  boids = new ArrayList<Boid>();
  for (int i = 0; i < numBoids; i++) {
    boids.add(new Boid(random(width), random(height)));
  }
}

void draw() {
  background(0); // Set background to black
  
  // Update time for Perlin noise
  noiseTime += 0.01;
  
  // Draw moving thin line pattern
  for (int i = 0; i < width; i += 20) {
    for (int j = 0; j < height; j += 20) {
      float noiseVal = noise(i * 0.01 + noiseTime, j * 0.01 + noiseTime);
      stroke(0, noiseVal * 255, 0); // Set line color to green
      float x1 = i + noiseVal * 10;
      float y1 = j + noiseVal * 10;
      float x2 = i + 10 + noiseVal * 10;
      float y2 = j + 10 + noiseVal * 10;
      line(x1, y1, x2, y2);
    }
  }
  
  // Move and display boids
  for (Boid boid : boids) {
    boid.flock(boids);
    boid.update();
    boid.edges();
    boid.display();
  }
}

// Boid class for flocking behavior
class Boid {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxForce = 0.1;
  float maxSpeed = 4;
  boolean isWhite = true; // Flag to switch between white and gray
  
  Boid(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void flock(ArrayList<Boid> boids) {
    PVector separateForce = separate(boids);
    separateForce.mult(1.5);
    applyForce(separateForce);
  }
  
  void display() {
    if (isWhite) {
      fill(255); // White color
    } else {
      fill(100); // Gray color
    }
    noStroke();
    float angle = velocity.heading() + PI / 2; // Rotate arrow in the direction of velocity
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    beginShape();
    vertex(0, -10);
    vertex(5, 10);
    vertex(-5, 10);
    endShape(CLOSE);
    popMatrix();
    // Flicker between white and gray
    isWhite = !isWhite;
  }
  
  void edges() {
    if (position.x > width) position.x = 0;
    else if (position.x < 0) position.x = width;
    if (position.y > height) position.y = 0;
    else if (position.y < 0) position.y = height;
  }
  
  PVector separate(ArrayList<Boid> boids) {
    float desiredSeparation = 25;
    PVector sum = new PVector();
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if (d > 0 && d < desiredSeparation) {
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float) count);
      sum.normalize();
      sum.mult(maxSpeed);
      sum.sub(velocity);
      sum.limit(maxForce);
    }
    return sum;
  }
}
