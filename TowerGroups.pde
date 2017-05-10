class TowerGroups {

  public Group<Tower> all;
  public Group<ArrowTower> arrow;
  public Group<IceTower> ice;
  public Group<GuardTower> guard;

  public TowerGroups(Game game) {
    this.all = new Group(game);
    this.arrow = new Group(game);
    this.ice = new Group(game);
    this.guard = new Group(game);
  }

  public void add(ArrowTower tower) {
    _addToAll(tower);
    arrow.add(tower);
  }

  public void add(IceTower tower) {
    _addToAll(tower);
    ice.add(tower);
  }

  public void add(GuardTower tower) {
    _addToAll(tower);
    guard.add(tower);
  }

  private void _addToAll(Tower tower) {
    all.add(tower);
  }
}
