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
AssetManager assetManager;

void setup() {
  // set window size
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  noSmooth();
  rectMode(CORNER);
  frameRate(50);

  // Give the library the PApplet.
  Hermes.setPApplet(this);

  // Set the default font. (font by: https://managore.itch.io/m5x7)
  textFont(createFont("fonts/m5x7.ttf", 32));

  _preloadAssets();
  _startGame();
}

void draw() {
  worldManager.draw();
}

void _preloadAssets() {
  assetManager = new AssetManager();

  assetManager.put(
        "unitSheet",
        new Tileset(
          loadImage(dataPath(UnitUtils.DIR + "/spritesheet.png")),
          UnitUtils.WIDTH,
          UnitUtils.HEIGHT
        ));

  assetManager.put(
        "arrowTower",
        loadImage(dataPath(Tower.DIR + "/arrow/tower.png")));
  assetManager.put(
        "arrowProjectile",
        loadImage(dataPath(Tower.DIR + "/arrow/projectile.png")));

  assetManager.put(
        "iceTower",
        loadImage(dataPath(Tower.DIR + "/ice/tower.png")));
  assetManager.put(
        "iceProjectile",
        loadImage(dataPath(Tower.DIR + "/ice/projectile.png")));
}

void _startGame() {
  worldManager = new CWorldManager();
  worldManager.setInitialWorld(new Game("test"));
  worldManager.start();
}