abstract class OffensiveTower extends Tower {

  protected TowerToCreepCombat combat;

  public OffensiveTower(int type, Node node, Player player, Game game) {
    super(type, node, player, game);
  }

  /**
   * NOTE: Should only called by means of attack, i.e: Projectile.
   * @param creep
   */
  public void hit(Creep creep) {
    combat.hit(creep);
  }

  public boolean onCooldown() {
    return combat.onCooldown();
  }
}
