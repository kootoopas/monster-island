class IceTower extends ProjectileTower {

  public IceTower(int type, Node node, Player player, Game game) {
    super(type, node, player, game);
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
