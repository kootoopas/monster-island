abstract class OffensiveTower extends Tower {

  protected TowerToCreepCombat combat;

  public OffensiveTower(int type, Node node, Game game) {
    super(type, node, game);
  }

  public void hit(Creep creep) {
    combat.hit(creep);
  }

  public boolean onCooldown() {
    return combat.onCooldown();
  }
}
