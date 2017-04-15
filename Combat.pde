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


class ProjectileTowerCombat implements TowerToCreepCombat {
  
  private ProjectileTower tower;
  private int lastShot = (int) HermesMath.MINUS_INFINITY;
  
  public ProjectileTowerCombat(ProjectileTower tower) {
    this.tower = tower;
  }
  
  public void inflictDmg(Creep creep) {
    creep.receiveDmg(_calcHitDmg(creep));
  }
  
  private int _calcHitDmg(Creep creep) {
    // TODO: Properly calculate damage based on 
    return ProjectileTower.ATK;
  }
  
  public void registerShot() {
    lastShot = millis();
  }
  
  public boolean onCooldown() {
    return millis() < lastShot + ProjectileTower.HITRATE;
  }
}


class ProjectileTowerCombatInteractor extends Interactor<ProjectileTower, Creep> {

  public boolean detect(ProjectileTower tower, Creep creep) {
    if (tower.onCooldown()) return false;

    PVector towerCenter = tower.getBoundingBox().getCenter();
    PVector creepCenter = creep.getBoundingBox().getCenter();

    return dist(towerCenter.x, towerCenter.y, creepCenter.x, creepCenter.y) <= Tower.RANGE;
  }

  public void handle(ProjectileTower tower, Creep creep) {
    tower.shoot(creep);
  }
}


interface TowerToCreepCombat {
  void inflictDmg(Creep creep);
  void registerShot();
  boolean onCooldown();
}
