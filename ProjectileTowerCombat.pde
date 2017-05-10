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
    return tower.getStats().atk;
  }

  public void shoot(Creep creep) {
    registerShot();
    // Projectile calls sth similar to tower.hit(creep) on contact with creep.
    switch (tower.getType()) {
      case Tower.ARROW:
        new ArrowProjectile(tower, creep, game);
        break;
      case Tower.ICE:
        new IceProjectile(tower, creep, game);
        break;
      default:
        new ArrowProjectile(tower, creep, game);
        break;
    }
  }

  public void registerShot() {
    lastShot = millis();
  }

  public boolean onCooldown() {
    return millis() < lastShot + tower.getStats().hitrate;
  }
}