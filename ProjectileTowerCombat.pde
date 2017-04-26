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