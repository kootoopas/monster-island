import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

class Game extends CWorld {
  public static final int STAGE_OFFSET = 32;

  public static final int BUY_TOWER = 0;
  public static final int UPGRADE_TOWER = 1;
  public static final int SELL_TOWER = 2;
  
  private Stage stage;
  private WaveSequence waveSeq;
  private Player player;
  
  Game(String stageId) {    
    stage = new Stage(stageId, this);
    stage.setOffset(0, Game.STAGE_OFFSET);
    
    player = new Player(stage.getInitialGold(), this);
  }
  
  void setup() {
    stage.setup();
    waveSeq = new WaveSequence(stage.getWavedataArray(), stage.getPath(), this);
  }
  
  void postUpdate() {
    if (player.isAlive()) {
      if (waveSeq.allCreepsAreDead()) {
        println("Ya won.");
        transitionTo(new RatingCalculation());
      }
    } else {
      // game over
      transitionTo(new GameOver());
    }
  }
  
  void draw() {
    background(Utils.VERY_DARK_VIOLET);

    // Manually draw non-Beings.
    player.drawStats();
    stage.drawMap();
    
    // TODO: stage.drawForeground() and stage.drawBackground() would allow for beings to be displayed behind objects
    super.draw();
  }
  
  void handleEvent(Being being) {
    println(being.getPosition());
  }
  
  void buyTower(int type, Node node) {
    player.buyTower(type, node);
  }
  
  void dmgPlayer() {
    player.receiveDmg();
  }
}

static class Actions {
}

