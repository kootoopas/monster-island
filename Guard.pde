class Guard extends Unit {

  private int loot;
  private GuardTower tower;

  Guard(int type, GuardTower tower, Game game) {
    super(type, UnitUtils.GUARD, tower.getCenter(), game);
    this.movement = new GuardMovement(this, tower.getRallypoint());
    this.tower = tower;

    tower.addToGuards(this);
  }



  protected void _preDeath() {

  }
}
