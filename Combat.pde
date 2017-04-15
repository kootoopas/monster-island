class Combat {

  private Game game;

  private TowerGroups towers;
  private Group<Creep> creeps;
  
  public Combat(TowerGroups towers, Group<Creep> creeps, Game game) {
    this.towers = towers;
    this.creeps = creeps;
    this.game = game;
    
    this.game.register(towers.projectile, creeps, new ProjectileTowerToCreepCombatInteractor());
  }
}


class ProjectileTowerToCreepCombat implements TowerToCreepCombat {
  
  private ProjectileTower tower;
  
  public ProjectileTowerToCreepCombat(ProjectileTower tower) {
    this.tower = tower;
  }
  
  public void attack(Creep creep) {
    
  }
}


class ProjectileTowerToCreepCombatInteractor extends Interactor<ProjectileTower, Creep> {

  public boolean detect(ProjectileTower tower, Creep creep) {
    PVector towerCenter = tower.getBoundingBox().getCenter();
    PVector creepCenter = creep.getBoundingBox().getCenter();

    return dist(towerCenter.x, towerCenter.y, creepCenter.x, creepCenter.y) <= Tower.RANGE;
  }

  public void handle(ProjectileTower tower, Creep creep) {
    tower.attack(creep);
  }
}


interface TowerToCreepCombat {
  void attack(Creep creep);
}
