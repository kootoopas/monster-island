class Combat {

  private Game game;

  private Group<Tower> towers;
  private Group<Creep> creeps;
  
  public Combat(Group<Tower> towers, Group<Creep> creeps, Game game) {
    this.towers = towers;
    this.creeps = creeps;
    this.game = game;
    
    this.game.register(towers, creeps, new TowerToCreepCombatInteractor());
  }
}


class TowerToCreepCombatInteractor extends Interactor<Tower, Creep> {

  public boolean detect(Tower tower, Creep creep) {
    PVector towerCenter = tower.getBoundingBox().getCenter();
    PVector creepCenter = creep.getBoundingBox().getCenter();

    return dist(towerCenter.x, towerCenter.y, creepCenter.x, creepCenter.y) < Tower.RANGE;
  }

  public void handle(Tower tower, Creep creep) {
    println(tower + " pews " + creep);
  }
}

