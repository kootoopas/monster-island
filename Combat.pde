class Combat {

  private Game game;

  private TowerGroups towers;
  private Group<Creep> creeps;
  
  public Combat(TowerGroups towers, Group<Creep> creeps, Game game) {
    this.towers = towers;
    this.creeps = creeps;
    this.game = game;
    
    this.game.register(towers.projectile, creeps, new ProjectileTowerCombatInteractor());
  }
}