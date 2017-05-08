class Combat {

  private Game game;

  private TowerGroups towers;
  private Group<Guard> guards;
  private Group<Creep> creeps;
  
  public Combat(TowerGroups towers, Group<Guard> guards, Group<Creep> creeps, Game game) {
    this.towers = towers;
    this.guards = guards;
    this.creeps = creeps;
    this.game = game;
    
    this.game.register(towers.projectile, creeps, new ProjectileTowerCombatInteractor());
//    this.game.register(guards, creeps, new GuardCombatInteractor());
  }
}