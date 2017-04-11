import processing.opengl.*;
import java.util.Hashtable;

import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

static final int WINDOW_WIDTH = 544;
static final int WINDOW_HEIGHT = 512;

CWorldManager worldManager;

void setup() {
    size(WINDOW_WIDTH, WINDOW_HEIGHT, JAVA2D);  // set window size
    Hermes.setPApplet(this);            // give the library the PApplet
    
    // set up the world
    worldManager = new CWorldManager();
    worldManager.setInitialWorld(new Game("test"));
    
    rectMode(CORNER);
    frameRate(50);
    
    worldManager.start();
}

void draw() {
  noSmooth();
  worldManager.draw();
}
