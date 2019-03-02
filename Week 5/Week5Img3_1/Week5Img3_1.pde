/*Week5Img3_1.pde
Author: Cassandra Liau
Summary: Using transformation to create a 3D formation*/

PImage img; //image source
int cellsize = 2;
int cols, rows;

void setup() {
  size(800, 1067, P3D);
  img = loadImage("3.jpeg"); //load image into processing
  img.resize(800, 1067);
  cols = width/cellsize;             // Calculate # of columns
  rows = height/cellsize;            // Calculate # of rows
}

void draw() {
  background(0);
  loadPixels();
  // Begin loop for columns
  for ( int i = 0; i < cols;i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows;j++) {
      int x = i*cellsize + cellsize/2; // x position
      int y = j*cellsize + cellsize/2; // y position
      int loc = x + y*width;           // Pixel array location
      color c = img.pixels[loc];       // Grab the color
      
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (mouseX/(float)width) * brightness(img.pixels[loc]) - 100.0;
      
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
        translate(x,y,z);
        fill(c);
        noStroke();
        rectMode(CENTER);
        rect(0,0,cellsize,cellsize);
      popMatrix();
    }
  }
}
