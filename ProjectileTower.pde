class ProjectileTower extends OffensiveTower {

  public static final int HITRATE = 800;
  public static final int ATK = 100;

  public ProjectileTower(int type, Node node, Player player, Game game) {
    super(type, node, player, game);
    _register();
    this.combat = new ProjectileTowerCombat(this, game);
  }

  public void shoot(Creep creep) {
    combat.shoot(creep);
  }

  protected void _register() {
    super._register();
    game.register(this);
    player.addToTowers(this);
    node.setTower(this);
  }
}
