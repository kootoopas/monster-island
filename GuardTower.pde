abstract class GuardTower extends Tower {

  protected LinkedList<> guards;

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
