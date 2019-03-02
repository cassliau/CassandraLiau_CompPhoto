/*Week5Img2_2.pde
Author: Cassandra Liau
Summary: Using a mouse to navigate the 
rectangle to the areas to sharpen */

PImage img; //image source
int w = 500; //size of rect

// the image matrices
float[][] matrix = { { -1, -1, -1 },
                     { -1,  9, -1 },
                     { -1, -1, -1 } }; 

void setup() {
  size(800, 1067);
  img = loadImage("2.jpeg"); //load image into processing
  img.resize(800, 1067);
}

void draw() {
  image(img,0,0);
  
  //small rectangle
  int xstart = constrain(mouseX - w/2 ,0 ,img.width);
  int ystart = constrain(mouseY - w/2 ,0 ,img.height);
  int xend = constrain(mouseX + w/2 ,0 ,img.width);
  int yend = constrain(mouseY + w/2 ,0 ,img.height);
  int matrixsize = 3;
  
  loadPixels();
  
  //for loop for every pixel
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++ ) {
      // Each pixel location (x,y) gets passed into a function called convolution() 
      // which returns a new color value to be displayed.
      color c = convolution(x ,y ,matrix ,matrixsize,img);
      int loc = x + y*img.width;
      pixels[loc] = c;
    }
  }
  updatePixels();

}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  
  // Loop through convolution matrix
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      int xloc = x + i - offset;
      int yloc = y + j - offset;
      int loc = xloc + img.width*yloc;
      
      //make sure loc is within range
      loc = constrain(loc,0,img.pixels.length-1);
      
      // Calculate the convolution for RGB
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal,0,255);
  gtotal = constrain(gtotal,0,255);
  btotal = constrain(btotal,0,255);
  
  // Return the resulting color
  return color(rtotal,gtotal,btotal);
}
