import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

class Game extends CustomWorld {
  public static final int STAGE_OFFSET = 32;
  
  private Stage stage;
  private Player player;
  
  Game(String stageId) {
    stage = new Stage(stageId, this);
    stage.setOffset(0, Game.STAGE_OFFSET);
    
    player = new Player(stage.getInitialGold(), this);
//    mobs = new Mobs
  }
  
  void handleEvent(Being being) {
    
  }
  
  void setup() {
    stage.setup();
  }
  
  void draw() {
    background(0);
    stage.drawMap();
    player.drawStats();
    super.draw();
  }
}
