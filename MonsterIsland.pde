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
  // set window size
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  noSmooth();

  // give the library the PApplet
  Hermes.setPApplet(this);

  // Set default font.
  textFont(createFont("fonts/m5x7.ttf", 32));

  // set up the world
  worldManager = new CWorldManager();
  worldManager.setInitialWorld(new Game("test"));
  
  rectMode(CORNER);
  frameRate(50);
  
  worldManager.start();
}

void draw() {
  worldManager.draw();
}
