class IceTowerCombatInteractor extends Interactor<IceTower, Creep> {

  public boolean detect(IceTower tower, Creep creep) {
    if (tower.onCooldown()
            || creep.isFrostbitten()) {
      return false;
    }

    PVector towerCenter = tower.getCenter();
    PVector creepCenter = creep.getCenter();

    return dist(towerCenter.x, towerCenter.y, creepCenter.x, creepCenter.y) <= Tower.RANGE;
  }

  public void handle(IceTower tower, Creep creep) {
    tower.shoot(creep);
  }
}
