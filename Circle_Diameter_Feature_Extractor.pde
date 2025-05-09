// Import libraries for OSC communication
import oscP5.*; 
import netP5.*;

// Declare OSC objects
OscP5 oscP5; 
NetAddress wekinator;

// Declare circle properties
float circleDiameter;
float circleX, circleY;
int circleColor;

void setup()
{
  size(500, 500); // Set window size
  circleX = width/2; // Center circle horizontally
  circleY = height/2; // Center circle vertically
  circleDiameter = 50; // Initial diameter
  circleColor = 100; // Initial color
  
  // OSC setup: Initialize OSC communication with Wekinator
  oscP5 = new OscP5(this, 12000);
  wekinator = new NetAddress("127.0.0.1" ,6448);
}

void draw()
{
  background(0); // Clear background
  fill(circleColor); // Set fill color
  ellipse(circleX, circleY, circleDiameter, circleDiameter); // Draw circle
  Osc(); // Send OSC message
}

// Osc(): Sends the circle diameter as an OSC message to Wekinator
void Osc() {
  OscMessage myMessage = new OscMessage("/wek/inputs");
  myMessage.add(circleDiameter);
  oscP5.send(myMessage, wekinator);
  }

// keyPressed(): Adjusts the circle diameter based on key presses
void keyPressed()
{
  if ( key =='a')
  {
    circleDiameter -= 5;
  }
  if ( key =='s')
  {
    circleDiameter += 5;
  }
  circleDiameter = constrain(circleDiameter, 5, 500); // Keep diameter within bounds
}
