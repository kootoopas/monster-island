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
