import processing.opengl.*;
import java.util.Hashtable;

import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

static final int WINDOW_WIDTH = 1024;
static final int WINDOW_HEIGHT = 768;

CustomWorld world;

void setup() {
    size(WINDOW_WIDTH, WINDOW_HEIGHT, JAVA2D);  // set window size
    Hermes.setPApplet(this);            // give the library the PApplet
    
    // set up the world
    world = new Game("test");
    
    rectMode(CORNER);
    
    frameRate(60);
    
    //Sets up and starts world
    world.start();
}

void draw() {
  noSmooth();
  world.draw();
}
