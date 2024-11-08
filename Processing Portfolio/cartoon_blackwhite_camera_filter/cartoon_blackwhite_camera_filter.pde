import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);
  
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
}

void draw() {
  if (cam.available()) {
    cam.read(); // Read a new frame from the camera
    
    // Apply edge detection
    PImage edges = detectEdges(cam);
    
    // Apply posterization
    PImage posterized = posterize(edges, 3); // Number of colors
    
    // Display the cartoon effect
    image(posterized, 0, 0);
  }
}

// Function to apply edge detection
PImage detectEdges(PImage img) {
  img.filter(THRESHOLD); // Convert to binary image
  img.filter(ERODE); // Erode to reduce noise
  img.filter(DILATE); // Dilate to enhance edges
  return img;
}

// Function to apply posterization
PImage posterize(PImage img, int levels) {
  PImage result = createImage(img.width, img.height, RGB);
  img.loadPixels();
  result.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    r = round(map(r, 0, 255, 0, levels - 1)) * 255 / (levels - 1);
    g = round(map(g, 0, 255, 0, levels - 1)) * 255 / (levels - 1);
    b = round(map(b, 0, 255, 0, levels - 1)) * 255 / (levels - 1);
    result.pixels[i] = color(r, g, b);
  }
  result.updatePixels();
  return result;
}
