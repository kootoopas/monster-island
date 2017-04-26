class TowerGroups {

  private Game game;

  public Group<Tower> all;
  public Group<ProjectileTower> projectile;
  public Group<GuardTower> guard;

  public TowerGroups(Game game) {
    this.game = game;

    this.all = new Group(game);
    this.projectile = new Group(game);
    this.guard = new Group(game);
  }

  public void add(ProjectileTower tower) {
    _addToAll(tower);
    projectile.add(tower);
  }

  public void add(GuardTower tower) {
    _addToAll(tower);
    guard.add(tower);
  }

  private void _addToAll(Tower tower) {
    all.add(tower);
  }
}
