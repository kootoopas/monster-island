import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

class Game extends CustomWorld {
  public static final int STAGE_OFFSET = 32;

  public static final int BUY_TOWER = 0;
  public static final int UPGRADE_TOWER = 1;
  public static final int SELL_TOWER = 2;
  
  private Stage stage;
  private Player player;
  
  Game(String stageId) {
    stage = new Stage(stageId, this);
    stage.setOffset(0, Game.STAGE_OFFSET);
    
    player = new Player(stage.getInitialGold(), this);
//    mobs = new Mobs
  }
  
  void setup() {
    stage.setup();
  }
  
  void draw() {
    background(Utils.VERY_DARK_VIOLET);
    stage.drawMap();
    player.drawStats();
    super.draw();
  }
  
  void handleEvent(Being being) {
    println(being.getPosition());
  }
  
  void buyTower(int type, Node node) {
    player.buyTower(type, node);
  }
}

static class Actions {
}
