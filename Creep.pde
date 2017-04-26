class Creep extends Unit {

  private int loot;

  Creep(int type, Path path, Game game) {
    super(type, UnitUtils.CREEP, path.getSpawnpoint(), game);
    this.movement = new CreepMovement(this, path);
    this.loot = data.getInt("loot");
  }

  public void dmgPlayer() {
    game.dmgPlayer();
  }

  protected void _preDeath() {
    new PopupText("+" + loot, getPosition(), game);
    game.rewardPlayer(loot);
  }
}
