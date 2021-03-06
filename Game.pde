class Game extends CWorld {
  public static final int STAGE_OFFSET = 32;

  public static final int BUY_TOWER = 0;
  public static final int UPGRADE_TOWER = 1;
  public static final int SELL_TOWER = 2;

  private Player player;

  private SpawnWaveButton SpawnWaveButton;
  private WaveSequence waveSeq;

  private Stage stage;
  private Combat combat;

  Game(String stageId) {
    stage = new Stage(stageId, this);
    stage.setOffset(0, Game.STAGE_OFFSET);

    player = new Player(stage.getInitialGold(), this);
  }

  void setup() {
    stage.setup();
    waveSeq = new WaveSequence(stage.getWavedataArray(), stage.getPath(), this);
    new SpawnWaveButton(stage.getPath().getSpawnpoint(), this);
  }

  void postUpdate() {
    if (waveSeq.hasNotStarted()) return;

    if (player.isAlive()) {
      if (waveSeq.areAllCreepsDead()) {
        // Wins.
        transitionTo(new RatingCalculation(player.getHp()));
      }
    } else {
      // Loses.
      transitionTo(new GameOver());
    }

//     XXX: Auto populate all nodes with arrow towers for testing.
//    for (Node node : stage.getNodes().getObjects()) {
//      player.buyTower(Tower.ICE, node);
//    }
  }

  void draw() {
    background(Utils.VERY_DARK_VIOLET);

    // Manually draw non-Beings.
    player.drawStats();
    stage.drawMap();

    // TODO: stage.drawForeground() and stage.drawBackground() would allow for beings to be displayed behind objectsr
    super.draw();
  }

  void buyTower(int type, Node node) {
    player.buyTower(type, node);
  }

  void dmgPlayer() {
    player.receiveDmg();
  }

  void rewardPlayer(int amount) {
    player.gainGold(amount);
  }

  void startWaveSeq() {
    waveSeq.start();
    combat = new Combat(player.getTowers(), player.getGuards(), waveSeq.getCreeps(), this);
  }

  public Path getPath() {
    return stage.getPath();
  }

  private class SpawnWaveButton extends TextButton {

    private Game game;

    public SpawnWaveButton(PVector spawnpoint, Game game) {
      super((int) spawnpoint.x, (int) spawnpoint.y + 60, "Spawn wave", game);
      this.game = game;
    }

    protected void _onClick() {
      game.startWaveSeq();
      game.delete(this);
    }
  }
}