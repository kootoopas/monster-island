class ArrowTowerCombatInteractor extends Interactor<ArrowTower, Creep> {

  public boolean detect(ArrowTower tower, Creep creep) {
    if (tower.onCooldown()) return false;

    PVector towerCenter = tower.getCenter();
    PVector creepCenter = creep.getCenter();

    return dist(towerCenter.x, towerCenter.y, creepCenter.x, creepCenter.y) <= Tower.RANGE;
  }

  public void handle(ArrowTower tower, Creep creep) {
    tower.shoot(creep);
  }
}
