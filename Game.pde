import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

import tiled.io.*;

class Game extends CustomWorld {
  
  private Stage stage;
  
  Game(String stageId) {
    stage = new Stage(stageId);
  }
  
  void handleEvent(Being being) {
  
  }
  
  void setup() {
    stage.setup();
  }
  
  void draw() {
      background(0);
      stage.draw();
  }
}
