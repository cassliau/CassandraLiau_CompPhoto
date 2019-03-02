/*Week5Img1_3.pde
Author: Cassandra Liau
Summary: Using the mouse to put spotlight to areas of the image*/

PImage img; //image source

void setup() {
  size(800, 1067);
  img = loadImage("1.jpeg"); //load image into processing
  img.resize(800, 1067);
  loadPixels();
}

void draw() {
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      int loc = x + y * img.width;
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      
      //set brightness based on proximity to the mouse
      float maxdist = 250;
      float d = dist(x, y, mouseX, mouseY);
      float adjustbrightness = 100 * (maxdist - d)/maxdist;
      
      r += adjustbrightness;
      g += adjustbrightness;
      b += adjustbrightness;

      // Constrain RGB
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);

      // Make a new color and set pixel in the window
      color c = color(r,g,b);
      
      pixels[y * width + x] = c;
    }
  }
  updatePixels();
}
