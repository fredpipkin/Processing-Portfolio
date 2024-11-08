import processing.video.*;

Capture cam;
int numSegments = 12; // Number of segments in the kaleidoscope
float angleIncrement;

void setup() {
  size(1000, 900);
  
  // Initialize camera capture
  String[] cameras = Capture.list(); // List available cameras
  if (cameras.length == 0) {
    println("No cameras available");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + ": " + cameras[i]);
    }
    // Choose the first camera from the list
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
  
  angleIncrement = TWO_PI / numSegments;
}

void draw() {
  if (cam.available()) {
    cam.read(); // Read a new frame from the camera
    
    // Draw kaleidoscope effect
    translate(width / 2, height / 2); // Translate origin to the center
    for (int i = 0; i < numSegments; i++) {
      pushMatrix(); // Save the current transformation matrix
      rotate(angleIncrement * i); // Rotate the coordinate system
      scale(1, -1); // Flip the coordinate system vertically
      image(cam, -width / 2, -height / 2, width, height); // Draw the camera feed
      popMatrix(); // Restore the saved transformation matrix
    }
  }
}
