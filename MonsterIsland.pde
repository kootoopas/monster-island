import processing.opengl.*;
import java.util.Hashtable;

import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

static final int WINDOW_WIDTH = 544;
static final int WINDOW_HEIGHT = 512;

CWorld initialWorld;

void setup() {
    size(WINDOW_WIDTH, WINDOW_HEIGHT, JAVA2D);  // set window size
    Hermes.setPApplet(this);            // give the library the PApplet
    
    // set up the world
    initialWorld = new Game("test");
    
    rectMode(CORNER);
    frameRate(50);
    
    //Sets up and starts world
    initialWorld.start();
}

void draw() {
  noSmooth();
  initialWorld.draw();
}
