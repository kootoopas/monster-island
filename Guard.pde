class Guard extends Unit {

  private int loot;

  Guard(int type, , Game game) {
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
