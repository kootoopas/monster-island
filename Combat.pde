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

  private Game game;

  private ProjectileTower tower;
  private int lastShot = (int) HermesMath.MINUS_INFINITY;
  
  public ProjectileTowerCombat(ProjectileTower tower, Game game) {
    this.game = game;
    this.tower = tower;
  }
  
  public void hit(Creep creep) {
    creep.receiveDmg(_calcHitDmg(creep));
  }
  
  private int _calcHitDmg(Creep creep) {
    // TODO: Properly calculate damage based on creep.stats & tower type and stats
    return ProjectileTower.ATK;
  }
  
  public void shoot(Creep creep) {
    registerShot();
    // Projectile calls tower.hit(creep) on contact with creep.
    new Projectile(tower, creep, game);
  }
  
  public void registerShot() {
    lastShot = millis();
  }
  
  public boolean onCooldown() {
    return millis() < lastShot + ProjectileTower.HITRATE;
  }
}


class Projectile extends Being {

  private Game game;

  private ProjectileTower tower;
  private Creep creep;

  private int launchtime;

  public Projectile(ProjectileTower tower, Creep creep, Game game) {
    super(Utils.voidRectangle());
    this.game = game;
    this.tower = tower;
    this.creep = creep;

    this.launchtime = millis();
    this.game.register(this);
  }

  public void update() {
    if (millis() - launchtime > 150) {
      game.delete(this);
      tower.hit(creep);
    }
  }

  public void draw() {
    PVector towerPos = tower.getBoundingBox().getCenter();
    PVector creepPos = creep.getBoundingBox().getCenter();

    line(towerPos.x, towerPos.y, creepPos.x, creepPos.y);
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
  void shoot(Creep creep);
  void registerShot();
  void hit(Creep creep);
  boolean onCooldown();
}
